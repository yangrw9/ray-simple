// Raymond:
//   1. Minimum window creating code, ATL windowing, with message map feature.
//   2. Can auto fill message map with 'Properties Window' help (Visual Studio needs some seconds to refresh wizard) 
//   

#include <atlbase.h>
#include <atlwin.h>


class MainWindow : public CWindowImpl<MainWindow, CWindow, CFrameWinTraits> // top-level window
{
	BEGIN_MSG_MAP(MainWindow)
		MESSAGE_HANDLER(WM_PAINT, OnPaint)
		MESSAGE_HANDLER(WM_DESTROY, OnDestroy)
	END_MSG_MAP()
public:
	LRESULT OnPaint(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/, BOOL& /*bHandled*/);
	LRESULT OnDestroy(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/, BOOL& /*bHandled*/);
};

//////////////////////////////////////////////////////////////////////////

int APIENTRY _tWinMain(HINSTANCE /*hInstance*/,
					   HINSTANCE /*hPrevInstance*/,
					   LPTSTR    /*lpCmdLine*/,
					   int       nCmdShow)
{
	MainWindow wnd;

	wnd.Create(NULL);

	if (!wnd)
	{
		ATLASSERT(false);
		return FALSE;
	}
	wnd.ShowWindow(nCmdShow);

	MSG msg;
	// Main message loop:
	while (GetMessage(&msg, NULL, 0, 0))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

	return (int) msg.wParam;
}


LRESULT MainWindow::OnPaint(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/, BOOL& /*bHandled*/)
{
	PAINTSTRUCT ps; 
	HDC hdc = BeginPaint(&ps); //GetDC();
	static TCHAR str[] = TEXT("Hello Mini-Window from ATL");
	TextOut(hdc, 10,10, str, ARRAYSIZE(str) - 1);
	//RECT rect = {10, 10, 100, 100};
	//DrawText(hdc, str, ARRAYSIZE(str) - 1, &rect, DT_TOP | DT_LEFT);
	//ReleaseDC(hdc);
	EndPaint(&ps);
	return 0;
}


LRESULT MainWindow::OnDestroy(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/, BOOL& /*bHandled*/)
{
	//PostMessage(WM_QUIT);
	PostQuitMessage(0);
	return 0;
}

