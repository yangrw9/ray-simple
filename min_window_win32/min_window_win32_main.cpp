#include <windows.h>
#include <windowsx.h>   // Introduction to STRICT and Message Crackers http://support.microsoft.com/kb/83456

LRESULT CALLBACK WindowProc(_In_ HWND hwnd, _In_ UINT uMsg, _In_ WPARAM wParam, _In_ LPARAM lParam);

//////////////////////////////////////////////////////////////////////////

int APIENTRY wWinMain(HINSTANCE hInstance,              // tWinMain  requires <tchar.h>
                        HINSTANCE /*hPrevInstance*/,
                        LPWSTR    /*lpCmdLine*/,        // tWinMain  uses LPTSTR
                        int       nCmdShow)
{
    WCHAR kClassName[] = L"min_win";
    WCHAR kWindowTitle[] = L"Hello mini";

    WNDCLASSEX wcs = {sizeof(WNDCLASSEX)};  // C language will auto zero other members
    wcs.lpfnWndProc = WindowProc;
    wcs.lpszClassName = kClassName;

    ATOM wnd_class = RegisterClassEx(&wcs);
    
    if (!wnd_class) {return FALSE;}

    HWND wnd = CreateWindowEx(WS_EX_OVERLAPPEDWINDOW, kClassName, kWindowTitle, WS_OVERLAPPEDWINDOW  | WS_VISIBLE , 
            CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,
            NULL, NULL, hInstance, NULL);

    if (!wnd) { return FALSE;}

    MSG msg;
    // Main message loop:
    while (GetMessage(&msg, NULL, 0, 0))
    {
        TranslateMessage(&msg); // Translates virtual-key messages into character messages.
        DispatchMessage(&msg);  // Dispatches a message to a window procedure.
    }

    return (int) msg.wParam;
}

//////////////////////////////////////////////////////////////////////////

void Cls_OnPaint(HWND hwnd)
{
    PAINTSTRUCT ps; 
    HDC hdc = BeginPaint(hwnd, &ps); //GetDC();

    static TCHAR str[] = TEXT("Hello min window from Win32");
    TextOut(hdc, 10,10, str, ARRAYSIZE(str) - 1);
    
    EndPaint(hwnd, &ps); //ReleaseDC(hdc);
}

LRESULT CALLBACK WindowProc(_In_ HWND hwnd, _In_ UINT uMsg, _In_ WPARAM wParam, _In_ LPARAM lParam)
{
    switch (uMsg)
    {
    //case WM_PAINT:
    //    HANDLE_WM_PAINT(hwnd, wParam, lParam);
    HANDLE_MSG(hwnd, WM_PAINT, Cls_OnPaint);

    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hwnd, uMsg, wParam, lParam);
    }
    return 0;
}

