// Raymond:
//   1. Minimum window creating code, ATL windowing, with message map feature.
//   2. Can auto fill message map with 'Properties Window' help (Visual Studio needs some seconds to refresh wizard) 
//   

#include <atlbase.h>
#include <atlwin.h>

//class MainWindow : public CWindowImpl<MainWindow>	// child window
class MainWindow : public CWindowImpl<MainWindow, CWindow, CFrameWinTraits> // top-level window
{
	BEGIN_MSG_MAP(MainWindow)
	END_MSG_MAP()
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


