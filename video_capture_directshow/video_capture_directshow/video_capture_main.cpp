// Raymond: 
//	Modified from <WinSDK-7.1>\Samples\multimedia\directshow\capture\playcap
//	1. For readability, better variable name 
//  2. For readability, clean error detection code
//	3. Smart COM pointer, personal hobby & cleaner code
//  4. Select camera if more than one
//
// DirectShow Samples http://msdn.microsoft.com/en-us/library/windows/desktop/dd375468(v=vs.85).aspx
//

#include <atlcomcli.h>
#include <atlcoll.h>
#include <atlstr.h>
#include <atlcomcli.h>

// Building DirectShow Applications http://msdn.microsoft.com/en-us/library/windows/desktop/dd377592(v=vs.85).aspx
#include <dshow.h>
#pragma comment(lib, "strmiids.lib")	// Exports class identifiers (CLSIDs) and interface identifiers (IIDs).

#define WM_GRAPHNOTIFY  WM_APP+1

//////////////////////////////////////////////////////////////////////////
// 'Throw on Fail' error handling helper. (By myself) 
// Error Handling in COM http://msdn.microsoft.com/en-us/library/ff485842(v=vs.85)
class HRESULT_failed_throw
{
public:
	HRESULT m_hr;
	HRESULT_failed_throw():m_hr(S_OK) {}
	HRESULT_failed_throw(HRESULT hr):m_hr(hr) {}

	void operator = (HRESULT hr)
	{
		m_hr = hr;
		if (FAILED(hr))
			throw hr;
	}

	operator HRESULT()
	{
		return m_hr;
	}
};

//////////////////////////////////////////////////////////////////////////
//
// Global data
//
//HWND ghApp=0;

CComPtr<IVideoWindow> g_pVideoWindow = NULL;
CComPtr<IMediaControl> g_pMediaControl = NULL;
CComPtr<IMediaEventEx> g_pMediaEvent = NULL;

CComPtr<IGraphBuilder> g_pGraphBuilder = NULL;
CComPtr<ICaptureGraphBuilder2> g_pCaptureGraphBuilder = NULL;

enum PLAYSTATE {Stopped, Paused, Running, Init};
PLAYSTATE g_psCurrent = Stopped;

void Msg(TCHAR *szFormat, ...)
{
}


HRESULT GetInterfaces(void)
{
	HRESULT_failed_throw hr;
	
	// Create the filter graph
	hr = g_pGraphBuilder.CoCreateInstance(CLSID_FilterGraph);

	// Create the capture graph builder
	hr = g_pCaptureGraphBuilder.CoCreateInstance(CLSID_CaptureGraphBuilder2);

	// Obtain interfaces for media control and Video Window
	hr = g_pGraphBuilder->QueryInterface(&g_pMediaControl);

	hr = g_pGraphBuilder->QueryInterface(&g_pVideoWindow);

	hr = g_pGraphBuilder->QueryInterface(&g_pMediaEvent);

	return hr;
}

void CloseInterfaces(void)
{
	// Stop previewing data
	if (g_pMediaControl)
		g_pMediaControl->StopWhenReady();

	g_psCurrent = Stopped;

	// Stop receiving events
	if (g_pMediaEvent)
		g_pMediaEvent->SetNotifyWindow(NULL, WM_GRAPHNOTIFY, 0);

	// Relinquish ownership (IMPORTANT!) of the video window.
	// Failing to call put_Owner can lead to assert failures within
	// the video renderer, as it still assumes that it has a valid
	// parent window.
	if(g_pVideoWindow)
	{
		g_pVideoWindow->put_Visible(OAFALSE);
		g_pVideoWindow->put_Owner(NULL);
	}

	// Release DirectShow interfaces
	g_pMediaControl.Release();
	g_pMediaEvent.Release();
	g_pVideoWindow.Release();
	g_pGraphBuilder.Release();
	g_pCaptureGraphBuilder.Release();
}

// Selecting a Capture Device http://msdn.microsoft.com/en-us/library/windows/desktop/dd377566(v=vs.85).aspx
HRESULT SelectCamera(/*in*/ IEnumMoniker* pInputDevs, /*out*/ IBaseFilter** pInputDevSeleted)
{
	if (NULL == pInputDevSeleted)
	{
		return E_POINTER;
	}

	HRESULT_failed_throw hr;

	// Save devices

	CInterfaceArray<IMoniker> devs;

	CComPtr<IMoniker> item;
	hr = pInputDevs->Next(1, &item, NULL);
	while (S_OK == hr)
	{
		devs.Add(item.Detach());
		hr = pInputDevs->Next(1, &item, NULL);
	}

	// Get names for device
	CSimpleArray<CString> names;
	CString prompt;

	//CComHeap comHeap;
	//CAtlStringMgr strMemMgr(&comHeap);
	//CString str(&strMemMgr);

	for (size_t i = 0; i < devs.GetCount(); i++)
	{
		IMoniker* pMoniker = devs[i];
		//LPOLESTR p;
		//hr = pMoniker->GetDisplayName(NULL, NULL, &p); // Retrieves the display name for the moniker.
		//str = p;

		CComPtr<IPropertyBag> pPropBag;
		CComVariant var;
		hr = pMoniker->BindToStorage(0, 0, IID_PPV_ARGS(&pPropBag));
		hr = pPropBag->Read(L"FriendlyName", &var, 0);	// The name of the device.
		CString str = var;

		names.Add(str);

		prompt.AppendFormat(L"%d = ", i);
		prompt.Append(str);
		prompt.Append(TEXT("\n"));
	}

	// Prompt to select
	int sel = MessageBox(NULL,  prompt, TEXT("SelCam Yes=0, No=1, Cancel=2"), MB_YESNOCANCEL);
	switch (sel)
	{
	case IDYES      : sel = 0; break;
	case IDNO       : sel = 1; break;
	case IDCANCEL   : sel = 2; break;
	default:		  sel = -1; break;
	}

	if (-1 != sel && sel < (int) devs.GetCount())
	{
		hr = devs[sel]->BindToObject(0,0,IID_PPV_ARGS(pInputDevSeleted));

		//*pInputDevSeleted = devs[sel].Detach();
	}

	return S_OK;
}


HRESULT FindCaptureDevice(IBaseFilter ** ppSrcFilter)
{
	if (NULL == ppSrcFilter)
	{
		return E_POINTER;
	}

	HRESULT_failed_throw hr = S_OK;
	CComPtr<ICreateDevEnum> pCaptureDevEnum;

	CComPtr<IEnumMoniker> pVideoCaptureDevEnum;


	// Create the system device enumerator
	hr = pCaptureDevEnum.CoCreateInstance(CLSID_SystemDeviceEnum);

	// Create an enumerator for the video capture devices
	hr = pCaptureDevEnum->CreateClassEnumerator (CLSID_VideoInputDeviceCategory, &pVideoCaptureDevEnum, 0);

	// If there are no enumerators for the requested type, then 
	// CreateClassEnumerator will succeed, but pClassEnum will be NULL.
	if (pVideoCaptureDevEnum == NULL)
	{
		MessageBox(0,TEXT("No video capture device was detected.\r\n\r\n")
			TEXT("This sample requires a video capture device, such as a USB WebCam,\r\n")
			TEXT("to be installed and working properly.  The sample will now close."),
			TEXT("No Video Capture Hardware"), MB_OK | MB_ICONINFORMATION);
		hr = E_FAIL;
	}

	CComPtr<IBaseFilter> pSrc = NULL;
	hr = SelectCamera(pVideoCaptureDevEnum, &pSrc);

//	pVideoCaptureDevEnum->Reset();
//
//	// Use the first video capture device on the device list.
//	// Note that if the Next() call succeeds but there are no monikers,
//	// it will return S_FALSE (which is not a failure).  Therefore, we
//	// check that the return code is S_OK instead of using SUCCEEDED() macro.
//	CComPtr<IMoniker> pInputDev =NULL;
//	hr = pVideoCaptureDevEnum->Next (1, &pInputDev, NULL);
//	if (hr == S_FALSE)
//	{
//		//Msg(TEXT("Unable to access video capture device!"));   
//		hr = E_FAIL;
//	}
//
//	// Bind Moniker to a filter object
////	hr = pInputDev->BindToObject(0,0,IID_IBaseFilter, (void**)&pSrc);
//	hr = pInputDev->BindToObject(0,0,IID_PPV_ARGS(&pSrc));


	// Copy the found filter pointer to the output parameter.
	if (SUCCEEDED(hr))
	{
		*ppSrcFilter = pSrc;
		(*ppSrcFilter)->AddRef();
	}

	return hr;
}


HRESULT SetupVideoWindow(HWND hWnd)
{
	HRESULT_failed_throw hr;

	// Set the video window to be a child of the main window
	hr = g_pVideoWindow->put_Owner((OAHWND)hWnd);
	if (FAILED(hr))
		return hr;

	// Set video window style
	hr = g_pVideoWindow->put_WindowStyle(WS_CHILD | WS_CLIPCHILDREN);
	if (FAILED(hr))
		return hr;

	// Use helper function to position video window in client rect 
	// of main application window
//	ResizeVideoWindow();
	SendMessage(hWnd, WM_SIZE, 0, 0);
	

	// Make the video window visible, now that it is properly positioned
	hr = g_pVideoWindow->put_Visible(OATRUE);
	if (FAILED(hr))
		return hr;

	return hr;
}



HRESULT CaptureVideo(HWND hWnd)
{
	HRESULT_failed_throw hr;

	// Use the system device enumerator and class enumerator to find
	// a video capture/preview device, such as a desktop USB video camera.
	CComPtr<IBaseFilter> pVideoSrcFilter;

	hr = FindCaptureDevice(&pVideoSrcFilter);


	// Get DirectShow interfaces
	hr = GetInterfaces();

	// Set the window handle used to process graph events
	hr = g_pMediaEvent->SetNotifyWindow((OAHWND)hWnd, WM_GRAPHNOTIFY, 0);

	// Attach the filter graph to the capture graph
	hr = g_pCaptureGraphBuilder->SetFiltergraph(g_pGraphBuilder);

	// Add Capture filter to our graph.
	hr = g_pGraphBuilder->AddFilter(pVideoSrcFilter, L"Video Capture");
	if (FAILED(hr))
	{
		Msg(TEXT("Couldn't add the capture filter to the graph!  hr=0x%x\r\n\r\n") 
			TEXT("If you have a working video capture device, please make sure\r\n")
			TEXT("that it is connected and is not being used by another application.\r\n\r\n")
			TEXT("The sample will now close."), hr);
		return hr;
	}

	// Render the preview pin on the video capture filter
	// Use this instead of g_pGraph->RenderFile
	hr = g_pCaptureGraphBuilder->RenderStream (&PIN_CATEGORY_PREVIEW, &MEDIATYPE_Video,
		pVideoSrcFilter, NULL, NULL);
	if (FAILED(hr))
	{
		Msg(TEXT("Couldn't render the video capture stream.  hr=0x%x\r\n")
			TEXT("The capture device may already be in use by another application.\r\n\r\n")
			TEXT("The sample will now close."), hr);
		return hr;
	}

	// Now that the filter has been added to the graph and we have
	// rendered its stream, we can release this reference to the filter.
	pVideoSrcFilter.Release();

	// Set video window style and position
	hr = SetupVideoWindow(hWnd);

#ifdef REGISTER_FILTERGRAPH
	// Add our graph to the running object table, which will allow
	// the GraphEdit application to "spy" on our graph
	hr = AddGraphToRot(g_pGraphBuilder, &g_dwGraphRegister);
	if (FAILED(hr))
	{
		Msg(TEXT("Failed to register filter graph with ROT!  hr=0x%x"), hr);
		g_dwGraphRegister = 0;
	}
#endif

	// Start previewing video data
	hr = g_pMediaControl->Run();
	if (FAILED(hr))
	{
		Msg(TEXT("Couldn't run the graph!  hr=0x%x"), hr);
		return hr;
	}

	// Remember current state
	g_psCurrent = Running;

	return S_OK;
}

void ResizeVideoWindow(HWND hWnd)
{
	// Resize the video preview window to match owner window size
	if (g_pVideoWindow)
	{
		RECT rc;
		// Make the preview video fill our window
		GetClientRect(hWnd, &rc);
		g_pVideoWindow->SetWindowPosition(0, 0, rc.right, rc.bottom);
	}
}

HRESULT ChangePreviewState(HWND hWnd)
{
	int nShow = ! IsIconic(hWnd);
	HRESULT_failed_throw hr=S_OK;

	// If the media control interface isn't ready, don't call it
	if (!g_pMediaControl)
		return S_OK;

	if (nShow)
	{
		if (g_psCurrent != Running)
		{
			// Start previewing video data
			hr = g_pMediaControl->Run();
			g_psCurrent = Running;
		}
	}
	else
	{
		// Stop previewing video data
		hr = g_pMediaControl->StopWhenReady();
		g_psCurrent = Stopped;
	}

	return 0;
}

HRESULT HandleGraphEvent(void)
{
	LONG evCode;
	LONG_PTR evParam1, evParam2;
	HRESULT_failed_throw hr=S_OK;

	if (!g_pMediaEvent)
		return E_POINTER;

	while(SUCCEEDED(g_pMediaEvent->GetEvent(&evCode, &evParam1, &evParam2, 0)))
	{
		//
		// Free event parameters to prevent memory leaks associated with
		// event parameter data.  While this application is not interested
		// in the received events, applications should always process them.
		//
		hr = g_pMediaEvent->FreeEventParams(evCode, evParam1, evParam2);

		// Insert event processing code here, if desired
	}

	return hr;

}


LRESULT CALLBACK WndMainProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	switch (message)
	{
	case WM_GRAPHNOTIFY:
		HandleGraphEvent();
		break;

	case WM_SIZE:
		ResizeVideoWindow(hwnd);
		break;

	case WM_WINDOWPOSCHANGED:
		ChangePreviewState(hwnd);
		break;

	case WM_CLOSE:            
		// Hide the main window while the graph is destroyed
		ShowWindow(hwnd, SW_HIDE);
		CloseInterfaces();  // Stop capturing and release interfaces
		break;

	case WM_DESTROY:
		PostQuitMessage(0);
		return 0;
	}

	// Pass this message to the video window for notification of system changes
	if (g_pVideoWindow)
		g_pVideoWindow->NotifyOwnerMessage((LONG_PTR) hwnd, message, wParam, lParam);

	return DefWindowProc (hwnd , message, wParam, lParam);
}


int PASCAL WinMain(HINSTANCE hInstance, HINSTANCE hInstP, LPSTR lpCmdLine, int nCmdShow)
{
	HWND ghApp = NULL;
	static const TCHAR CLASSNAME[] = TEXT("VidCapPreviewer\0");
	static const TCHAR APPLICATIONNAME[] = TEXT("Video Capture Previewer (PlayCap)\0");
	static const int DEFAULT_VIDEO_WIDTH  =   320;
	static const int DEFAULT_VIDEO_HEIGHT =   320;


	MSG msg={0};
	WNDCLASS wc;

	// Initialize COM
	if(FAILED(CoInitializeEx(NULL, COINIT_APARTMENTTHREADED)))
	{
		Msg(TEXT("CoInitialize Failed!\r\n"));   
		exit(1);
	} 

	// Register the window class
	ZeroMemory(&wc, sizeof wc);
	wc.lpfnWndProc   = WndMainProc;
	wc.hInstance     = hInstance;
	wc.lpszClassName = CLASSNAME;
	wc.lpszMenuName  = NULL;
	wc.hbrBackground = (HBRUSH)GetStockObject(BLACK_BRUSH);
	wc.hCursor       = LoadCursor(NULL, IDC_ARROW);
	wc.hIcon         = NULL;
	if(!RegisterClass(&wc))
	{
		Msg(TEXT("RegisterClass Failed! Error=0x%x\r\n"), GetLastError());
		CoUninitialize();
		exit(1);
	}

	// Create the main window.  The WS_CLIPCHILDREN style is required.
	ghApp = CreateWindow(CLASSNAME, APPLICATIONNAME,
		WS_OVERLAPPEDWINDOW | WS_CAPTION | WS_CLIPCHILDREN,
		CW_USEDEFAULT, CW_USEDEFAULT,
		DEFAULT_VIDEO_WIDTH, DEFAULT_VIDEO_HEIGHT,
		0, 0, hInstance, 0);

	if(ghApp)
	{
		HRESULT hr;

		// Create DirectShow graph and start capturing video
		hr = CaptureVideo(ghApp);
		if (FAILED (hr))
		{
			CloseInterfaces();
			DestroyWindow(ghApp);
		}
		else
		{
			// Don't display the main window until the DirectShow
			// preview graph has been created.  Once video data is
			// being received and processed, the window will appear
			// and immediately have useful video data to display.
			// Otherwise, it will be black until video data arrives.
			ShowWindow(ghApp, nCmdShow);
		}       

		// Main message loop
		while(GetMessage(&msg,NULL,0,0))
		{
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
	}

	// Release COM
	CoUninitialize();

	return (int) msg.wParam;
}




#if 0
//////////////////////////////////////////////////////////////////////////
#define _ATL_CSTRING_EXPLICIT_CONSTRUCTORS      // some CString constructors will be explicit
#include <atlbase.h>
#include <atlstr.h>
#include <atlwin.h>


//CAtlWinModule _Module;


class MainWindow : public CWindowImpl<MainWindow, CWindow, CFrameWinTraits> // top-level window
{
public:
//	DECLARE_WND_CLASS(TEXT("Raywin"))
	//static LRESULT CALLBACK WindowProc(
	//	_In_ HWND hWnd,
	//	_In_ UINT uMsg,
	//	_In_ WPARAM wParam,
	//	_In_ LPARAM lParam);

	BEGIN_MSG_MAP(MainWindow)
		MESSAGE_HANDLER(WM_GRAPHNOTIFY, OnGraphNotify)
		MESSAGE_HANDLER(WM_SIZE, OnSize)
		MESSAGE_HANDLER(WM_WINDOWPOSCHANGED, OnWindowPosChanged)
		//MESSAGE_HANDLER(WM_CLOSE, OnClose)
		MESSAGE_HANDLER(WM_DESTROY, OnDestroy)
		//MESSAGE_RANGE_HANDLER(0, UINT_MAX, OnForwardMsgToVideoWindow )
	END_MSG_MAP()
public:
	LRESULT OnDestroy(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/, BOOL& /*bHandled*/);
	LRESULT OnGraphNotify(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/, BOOL& /*bHandled*/);
	LRESULT OnSize(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/, BOOL& /*bHandled*/);
	LRESULT OnClose(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/, BOOL& /*bHandled*/);
	LRESULT OnWindowPosChanged(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/, BOOL& /*bHandled*/);
	LRESULT OnForwardMsgToVideoWindow(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/, BOOL& /*bHandled*/);
	//LRESULT ForwardMsgToVideoWindow(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/);
};

//////////////////////////////////////////////////////////////////////////

int APIENTRY _tWinMain(HINSTANCE /*hInstance*/,
					   HINSTANCE /*hPrevInstance*/,
					   LPTSTR    /*lpCmdLine*/,
					   int       nCmdShow)
{
	HRESULT_failed_throw hr;
	hr = CoInitialize(NULL);
	//if(FAILED(hr = CoInitializeEx(NULL, COINIT_APARTMENTTHREADED)))
	//{
	//	Msg(TEXT("CoInitialize Failed!\r\n"));   
	//	exit(1);
	//} 

	MainWindow wnd;

	wnd.Create(NULL, 0, 0, WS_OVERLAPPEDWINDOW | WS_CAPTION | WS_CLIPCHILDREN);

	if (!wnd)
	{
		ATLASSERT(false);
		return FALSE;
	}
	hr = CaptureVideo(wnd);

	wnd.ShowWindow(nCmdShow);

	MSG msg;
	// Main message loop:
	while (GetMessage(&msg, NULL, 0, 0))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}


	// Release COM
	CoUninitialize();

	return (int) msg.wParam;
}

LRESULT MainWindow::OnDestroy(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/, BOOL& /*bHandled*/)
{
	PostQuitMessage(0);
	return 0;
}



LRESULT MainWindow::OnSize(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& /*bHandled*/)


LRESULT MainWindow::OnClose(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& /*bHandled*/ )
{
	// Hide the main window while the graph is destroyed
//	ShowWindow(SW_HIDE);

	//BOOL dummy;
	//OnForwardVideoWindowMsg(uMsg, wParam, lParam, dummy);

	return 0;
}


LRESULT MainWindow::OnWindowPosChanged(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& /*bHandled*/ )

LRESULT MainWindow::OnForwardMsgToVideoWindow(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled )
//{
//	ForwardMsgToVideoWindow(uMsg, wParam, lParam);
//	bHandled = FALSE;
//	return 0;
//}

//LRESULT MainWindow::ForwardMsgToVideoWindow(UINT uMsg, WPARAM wParam, LPARAM lParam )
{
	// trick to filter all message to video window
	if (g_pVideoWindow)
	{
		g_pVideoWindow->NotifyOwnerMessage((LONG_PTR) m_hWnd, uMsg, wParam, lParam);
	}
	return 0;
}

LRESULT MainWindow::OnGraphNotify(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& /*bHandled*/ )
#endif
