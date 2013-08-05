// Raymond:
//   1. Minimum code for creating window, with message map feature.
//   2. Can generate message mapping code using 'Property Window'
//   

#include <atlbase.h>
#include <atlwin.h>

// standalone window
class MainWindow : public CWindowImpl<MainWindow, CWindow, CFrameWinTraits>
{
	BEGIN_MSG_MAP(MainWindow)
	END_MSG_MAP()
};

///////////////////////////////////////////////

// sub window
class ChildWindow : public CWindowImpl<ChildWindow>
{
	BEGIN_MSG_MAP(ChildWindow)
	END_MSG_MAP()
};

//////////////////////////////////////////////

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
