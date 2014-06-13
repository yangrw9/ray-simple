#include <windows.h>
//#include <windowsx.h>   // Introduction to STRICT and Message Crackers http://support.microsoft.com/kb/83456

#include "GL/GL.h"
#pragma comment(lib, "opengl32.lib")    // for OpenGL on Windows

//////////////////////////////////////////////////////////////////////////
// Windows unique context
void CreateGLContext(HDC hDC, /*out*/ HGLRC * hGLRC)
{
    PIXELFORMATDESCRIPTOR pfd = {sizeof(PIXELFORMATDESCRIPTOR), };
    pfd.nVersion = 1;
    pfd.dwFlags = PFD_DRAW_TO_WINDOW    // can draw to a window or device surface
                | PFD_SUPPORT_OPENGL    // supports OpenGL drawing
                | PFD_DOUBLEBUFFER;     // double-buffered  // SwapBuffers(hDC)
    pfd.iPixelType = PFD_TYPE_RGBA; 
    pfd.cColorBits = 24;                // the size of the color buffer, excluding the alpha bitplanes
    pfd.cDepthBits = 16;                // the depth of the depth (z-axis) buffer

    int pfi;
    pfi = ChoosePixelFormat( hDC, &pfd );
    SetPixelFormat( hDC, pfi, &pfd );

    *hGLRC = wglCreateContext( hDC );   // creates a new OpenGL rendering context
    wglMakeCurrent(hDC, *hGLRC);        // make subsequent OpenGL calls work
}

void DeleteGLContext(HGLRC hGLRC)
{
    wglMakeCurrent( NULL, NULL );
    wglDeleteContext(hGLRC);
}

//////////////////////////////////////////////////////////////////////////
// OpenGL Drawing function

// Platform-independent (Window system independent) 
//void DrawingFunc(void)    

// copied from OpenGL Programming Guide 7th, example 1-2
void display(void)  
{
    /*  clear all pixels  */
    glClear(GL_COLOR_BUFFER_BIT);
/*  draw white polygon (rectangle) with corners at
 *  (0.25, 0.25, 0.0) and (0.75, 0.75, 0.0)  
 */
    glColor3f(1.0, 1.0, 1.0);
    glBegin(GL_POLYGON);
        glVertex3f(0.25, 0.25, 0.0);
        glVertex3f(0.75, 0.25, 0.0);
        glVertex3f(0.75, 0.75, 0.0);
        glVertex3f(0.25, 0.75, 0.0);
    glEnd();
/*  don¡¯t wait!  
 *  start processing buffered OpenGL routines 
 */
    glFlush();
}

void init(void) 
{
    /*  select clearing (background) color       */
    glClearColor(0.0, 0.0, 0.0, 0.0);
    /*  initialize viewing values  */
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrtho(0.0, 1.0, 0.0, 1.0, -1.0, 1.0);
}

//////////////////////////////////////////////////////////////////////////
// Windows WGL wrapper call for DrawingFunc
//void DrawingWrapper(HDC hDC, HGLRC hGLRC, void (* func)() )
void DrawingWrapper(HDC hDC, HGLRC hGLRC)
{
    wglMakeCurrent(hDC,hGLRC);  // hDC  MUST on same device, MUST same pixel format, may not same hDC when hGLRC is created.
    //func();
    //DrawingFunc();
    display();
    SwapBuffers(hDC);     // present to window
}

//////////////////////////////////////////////////////////////////////////

LRESULT CALLBACK WindowProc(_In_ HWND hwnd, _In_ UINT uMsg, _In_ WPARAM wParam, _In_ LPARAM lParam);

HGLRC g_hGLRC = NULL;

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


    HDC hdc = GetDC(wnd);
    CreateGLContext(hdc, &g_hGLRC);
    init();


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

    //static TCHAR str[] = TEXT("Hello min window from Win32");
    //TextOut(hdc, 10,10, str, ARRAYSIZE(str) - 1);
    DrawingWrapper(hdc, g_hGLRC);

    EndPaint(hwnd, &ps); //ReleaseDC(hdc);
}

LRESULT CALLBACK WindowProc(_In_ HWND hwnd, _In_ UINT uMsg, _In_ WPARAM wParam, _In_ LPARAM lParam)
{
    switch (uMsg)
    {
    //case WM_PAINT:
    //    HANDLE_WM_PAINT(hwnd, wParam, lParam);    // style 1 with <windowsx.h>
    //HANDLE_MSG(hwnd, WM_PAINT, Cls_OnPaint);      // style 2 with <windowsx.h>
    case WM_PAINT:
        Cls_OnPaint(hwnd);
        break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hwnd, uMsg, wParam, lParam);
    }
    return 0;
}

