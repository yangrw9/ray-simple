#include <windows.h>
#include <strsafe.h>

#ifdef WIN32
// As seen on MSDN.
// Setting a Thread Name (Unmanaged) http://msdn.microsoft.com/en-us/library/xcb2z8hs(VS.71).aspx
#define MSDEV_SET_THREAD_NAME  0x406D1388
//
// Usage: SetThreadName (-1, "MainThread");
//
typedef struct tagTHREADNAME_INFO
{
    DWORD dwType; // must be 0x1000
    LPCSTR szName; // pointer to name (in user addr space)
    DWORD dwThreadID; // thread ID (-1=caller thread)
    DWORD dwFlags; // reserved for future use, must be zero
} THREADNAME_INFO;

void SetThreadName(DWORD dwThreadID, LPCSTR szThreadName) {
    THREADNAME_INFO info;
    info.dwType = 0x1000;
    info.szName = szThreadName;
    info.dwThreadID = dwThreadID;
    info.dwFlags = 0;

    __try {
        RaiseException(MSDEV_SET_THREAD_NAME, 0, sizeof(info) / sizeof(DWORD),
            reinterpret_cast<ULONG_PTR*>(&info));
    }
    __except(EXCEPTION_CONTINUE_EXECUTION) {
    }
}
#endif  // WIN32

// libjingle had said (till 2013 Augest)
//void* Thread::PreRun(void* pv) {
//#if defined(WIN32)
//  SetThreadName(GetCurrentThreadId(), init->thread->name_.c_str());
//#elif defined(POSIX)
//  // TODO: See if naming exists for pthreads.
//#endif


DWORD WINAPI FooThreadProc(_In_  LPVOID lpParameter)
{
   SetThreadName(-1, "I am FOO FOO");  // Try2: comment out OR modify it (to see thread name in debugger)
    
    const int BUF_LEN = 1024;
    char str[BUF_LEN] = {0,};
    while(true)
    {
        Sleep( 2 * 1000);
        int tick = GetTickCount();

        StringCbPrintfA(str, BUF_LEN, "Running FOO FOO [tick=%d]\n\0", tick);
        OutputDebugStringA(str);        // Try1: set BREAK POINT here, see thread name in debugger.

    }

}

DWORD WINAPI BarThreadProc(_In_  LPVOID lpParameter)
{
    SetThreadName(-1, "I am Bar Bar");

    char* name = (char*) lpParameter;
    //SetThreadName(-1, "I am bar bar");
    SetThreadName(-1, name);

    const int BUF_LEN = 1024;
    char str[BUF_LEN] = {0,};
    while(true)
    {
        Sleep( 3 * 1000);
        int tick = GetTickCount();
        StringCbPrintfA(str, BUF_LEN, "Running Bar Bar [tick=%d]\n\0", tick);
        OutputDebugStringA(str);
    }

}


int main()
{
    //HANDLE h;
    CreateThread(NULL, NULL, FooThreadProc, NULL, 0, NULL);
    CreateThread(NULL, NULL, BarThreadProc, NULL, 0, NULL);

    const int BUF_LEN = 1024;
    char str[BUF_LEN] = {0,};
    while (true)
    {
        Sleep( 5 * 1000);
        int tick = GetTickCount();
        StringCbPrintfA(str, BUF_LEN, "Running Main [tick=%d]\n\0", tick);
        OutputDebugStringA(str);

    }

}