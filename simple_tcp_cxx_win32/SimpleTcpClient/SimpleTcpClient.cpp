// SimpleTcpClient.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <stdio.h>

#include <winsock2.h>
//#include <ws2tcpip.h>

#pragma comment(lib, "Ws2_32.lib")	// For WinSocket 


int send_big_data(SOCKET socket,  char* data, int len)
{
	int total = 0;
	char* p = data;
	for (; total < len;)
	{
        int piece_len = (len - total);

        int piece = send(socket, p, piece_len, 0);
		if (SOCKET_ERROR == piece)
		{
			break;
		}
		else 
		{
			total += piece;
			p += piece;
            printf("Send %d bytes\n", total);
		}
	}
	return total == len ? total : -1;
}


int client()
{

	unsigned short server_port = htons(6234);
	unsigned long  server_addr = htonl(INADDR_LOOPBACK); 
                                //inet_addr("127.0.0.1");	
                                //get_ipv4_addr

	//////////////////////////////////////////////////////////////////////////
	sockaddr_in server = {0};
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = server_addr;
	server.sin_port = server_port;

	SOCKET sockfd;
	// creates a socket descriptor
	sockfd = socket(AF_INET /*IPv4*/, SOCK_STREAM, IPPROTO_TCP);
	if (INVALID_SOCKET == sockfd) {
		printf("socket() failed");
		return 1;
	}

	//  establishes a connection to a specified socket address
	if (SOCKET_ERROR == connect(sockfd, (const sockaddr *) &server, sizeof(sockaddr_in))) {
        printf("connect() failed");
		return 1;
	}

	// sends data on a connected socket
    if (0)
    {
        // short test data
        const char * question = "Hello Server?";
        if (SOCKET_ERROR == send(sockfd, question, (size_t)strlen(question) + 1, 0)) {
            printf("send() short data failed");
        	return 1;
        }	
    }
    else
    {
        // big test data
        const int BIG_LEN = 20010010;
        char* BIG_DATA = new char[BIG_LEN];
        memset(BIG_DATA, 'b', BIG_LEN);
        memset(BIG_DATA, 'a', 3);	// leading
        memset(BIG_DATA + BIG_LEN - 4, 'c', 4); // tailing

        if (-1 == send_big_data(sockfd, BIG_DATA, BIG_LEN))
        {
            printf("send() big data failed");
            return -1;
        }
        delete[] BIG_DATA;
    }

	// receive feed back;
	const size_t bufflen = 4096;
	size_t bytesreceived = 0;
	char buff[bufflen];
	bytesreceived = recv(sockfd, buff, bufflen, 0);
    if (SOCKET_ERROR == bytesreceived) {
        printf("recv() response failed");
		return 1;
	}
	printf("%s\n", buff);

	
	closesocket(sockfd);
	return 0;
}

int _tmain(int argc, _TCHAR* argv[])
{
	WSADATA wsadata;
     
	int error = WSAStartup(0x0202, &wsadata);
	client();
    WSACleanup();
}
