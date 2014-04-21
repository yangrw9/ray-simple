// SimpleTcpServer.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

#include <winsock2.h>
#include <ws2tcpip.h>

#pragma comment(lib, "Ws2_32.lib")	// For WinSocket 

int recv_big_data(SOCKET s, int len, char * buf, int buf_len)
{
    if (len > buf_len)
    {
        return -1;
    }

    int total = 0;
    char* p = buf;

    for (; total < len;)
    {
        int piece_len = len - total;
        int piece;
        piece = recv(s, p, piece_len, 0);
        if (0 == piece) // the connection has been gracefully closed
        {
            return -1;
        }
        else if (SOCKET_ERROR == piece) // 
        {
            piece;
            return -1;
        }
        else {
            total += piece;
            p += piece;
        }
    }
    return total == len ? total : -1;
}

int server()
{
    unsigned short server_port = htons(6234);
    unsigned long  server_addr = htonl(INADDR_LOOPBACK); // On all address

    //////////////////////////////////////////////////////////////////////////
    sockaddr_in server = {};
	server.sin_family = AF_INET;
    server.sin_port = server_port;
    server.sin_addr.s_addr = server_addr;	
    
	SOCKET listening;
	// creates a socket descriptor
	listening = socket(AF_INET /*IPv4*/, SOCK_STREAM, IPPROTO_TCP);
	if (INVALID_SOCKET == listening) {
        printf("socket() failed");
		return 1;
	}

	// associates a local address with a socket
	if (SOCKET_ERROR == bind(listening, (const sockaddr *) &server, sizeof(sockaddr_in))) {
        printf("bind() local address failed");
		return 1;
	}

	//  listening for an incoming connection
	if (SOCKET_ERROR == listen(listening, 0)) {
		printf("listen() failed");
		return 1;
	}

    printf("Server is listening...\n");

	// waiting for an incoming connection 
    SOCKET working_fd;
    sockaddr_in client;
    working_fd = accept(listening, (sockaddr *) &client, NULL);
	if (INVALID_SOCKET == working_fd) {
        printf("accept() client failed");
		return 1;
	}

    // receive data
    int received = 0;
    if (0)
    {
        // short test data
        const size_t bufflen = 4096;
        char buff[bufflen] = {};
        received = recv(working_fd, buff, bufflen, 0);
        if (-1 != received) printf("%s\n", buff);
    }
    else
    {
        // big test data
        const int BIG_LEN = 20010010;
        char* BIG_BUF = new char[BIG_LEN];
        memset(BIG_BUF, 'B', BIG_LEN);
        received = recv_big_data(working_fd, BIG_LEN, BIG_BUF, BIG_LEN);
        if (-1 != received)
        {
            //printf("%.*s", 10£¬ BIG_BUF);
            printf("%.10s", BIG_BUF);
            printf("...");
            printf("%.10s", BIG_BUF + received - 10);
            printf("\n");
        }
        delete[] BIG_BUF;
    }

	if (-1 == received) {
		printf("recv() failed");
		return 1;
	}

    const char reply[] = "Yes Client.";

    if (SOCKET_ERROR == send(working_fd, reply, sizeof(reply), 0)) {
        printf("send() response failed");
		return 1;
	}

    if (SOCKET_ERROR == closesocket(working_fd)) {
		printf("closesocket() 'working' failed");
		return 1;
	}
    if (SOCKET_ERROR == closesocket(listening)) {
		perror("closesocket() 'listening' failed");
		return 1;
	}
	return 0;
}


int _tmain(int argc, _TCHAR* argv[])
{
	WSADATA wsadata;

	int error = WSAStartup(0x0202, &wsadata);

	server();

    WSACleanup();
}