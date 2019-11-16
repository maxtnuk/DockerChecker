#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "time.h"
#include "sys/types.h"
#include "sys/socket.h"
#include "netinet/in.h"
#include <arpa/inet.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/wait.h>
//소켓 프로그래밍에 사용될 헤더파일 선언

#define BUF_LEN 128
//메시지 송수신에 사용될 버퍼 크기를 선언

#define PORT 999

int main(int argc, char* argv[])
{
	char buffer[BUF_LEN];
	struct sockaddr_in server_addr, client_addr;
	char temp[20];
	int server_fd, client_fd;
	FILE* file;
	//server_fd, client_fd : 각 소켓 번호
	int len, msg_size;

	/*
	if (argc != 2)
	{
		printf("usage : %s [port]\n", argv[0]);
		exit(0);
	}
	*/
	

	if ((server_fd = socket(PF_INET, SOCK_STREAM, 0)) == -1)
	{// 소켓 생성
		printf("Server : Can't open stream socket\n");
		exit(0);
	}
	memset(&server_addr, 0x00, sizeof(server_addr));
	//server_Addr 을 NULL로 초기화

	int option = 1;
	setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR, &option, sizeof(option));
	server_addr.sin_family = PF_INET;
	server_addr.sin_addr.s_addr = htonl(INADDR_ANY);
	server_addr.sin_port = htons(PORT);

	//server_addr 셋팅

	if (bind(server_fd, (struct sockaddr*) & server_addr, sizeof(server_addr)) < 0)
	{//bind() 호출
		printf("Server : Can't bind local address.\n");
		exit(0);
	}

	if (listen(server_fd, 5) < 0)
	{//소켓을 수동 대기모드로 설정
		printf("Server : Can't listening connect.\n");
		exit(0);
	}

	memset(buffer, 0x00, sizeof(buffer));
	printf("Server : wating connection request.\n");
	len = sizeof(client_addr);
	
		client_fd = accept(server_fd, (struct sockaddr*) & client_addr, &len);
		if (client_fd < 0)
		{
			printf("Server: accept failed.\n");
			exit(0);
		}
		inet_ntop(AF_INET, &client_addr.sin_addr.s_addr, temp, sizeof(temp));
		printf("Server : %s client connected.\n", temp);

		//msg_size = read(client_fd, buffer, 1024);

		if(access("/home/file", F_OK) == -1)
		{
			strcpy(buffer, "Problem 1 OK\n");
			write(client_fd, buffer, strlen("Problem 1 OK\n"));	
		}else
		{
			strcpy(buffer, "Problem 1 FAIL\n");
			write(client_fd, buffer, strlen("Problem 1 FAIL\n"));
		}

		int fd;
		int flag = 0;
/*
		if(file = fopen("/etc/passwd", "r") != NULL)
		{
			//int nread = read(fd, buffer, BUF_LEN);
			//fgets(buffer, 1024, file);
			fread(buffer, 1024, 1, file);
			if(buffer[4] == ':' && buffer[5] == 'x' && buffer[6] == ':')
			{
				strcpy(buffer, "Problem 2 OK\n");
				write(client_fd, buffer, strlen("Problem 2 OK\n"));
			}else
			{
				strcpy(buffer, "Problem 2 FAIL\n");
				write(client_fd, buffer, strlen("Problem 2 FAIL\n"));
			}

			fclose(file);
		}
*/
		struct stat sb;
	
		if(access("/home/new", F_OK) == 0)
		{
			fd = open("/home/old", O_RDONLY);
			int fd2 = open("/home/new", O_RDONLY);
			fstat(fd, &sb);
			int a = sb.st_ino;
			fstat(fd2, &sb);
			int b = sb.st_ino;
			if(a == b)
			{
				strcpy(buffer, "Problem 2 OK\n");
				write(client_fd, buffer, strlen("Problem 2 OK\n"));
			}else
			{
				strcpy(buffer, "Problem 2 FAIL\n");
				write(client_fd, buffer, strlen("Problem 2 FAIL\n"));
			}
			
		}else
		{
			strcpy(buffer, "Problem 2 FAIL\n");
			write(client_fd, buffer, strlen("Problem 2 FAIL\n"));
		}
	

		if(access("/a", F_OK) == 0)
		{
			fd = open("/a", O_RDONLY);
			

			fstat(fd, &sb);

			if(sb.st_mode & S_ISUID)
			{
				strcpy(buffer, "Problem 3 FAIL\n");
				write(client_fd, buffer, strlen("Problem 3 FAIL\n"));
			}else
			{
				strcpy(buffer, "Problem 3 OK\n");
				write(client_fd, buffer, strlen("Problem 3 OK\n"));
			}
		}else
		{
			strcpy(buffer, "Problem 3 OK\n");
			write(client_fd, buffer, strlen("Problem 3 OK\n"));
		}

		close(fd);

		int piped[2];
		pipe(piped);
		pid_t pid;
/*
		switch (pid = fork())
		{
		case 0:
			close(piped[0]);
			dup2(piped[1], stdout);
			execl("ps", "ps", "-ef", NULL);
			break;

		default:
			close(piped[1]);
			wait(NULL);
			while(read(piped[0], buffer, BUFSIZ))
			{
				if(strcmp(buffer, "<defunct>") == 0)
				{
					flag = 1;
				}
			}

			if(flag == 1)
			{
				strcpy(buffer, "Problem 4 FAIL\n");
				write(client_fd, buffer, strlen("Problem 4 FAIL\n"));
			}else
			{
				strcpy(buffer, "Problem 4 OK\n");
				write(client_fd, buffer, strlen("Problem 4 OK\n"));
			}
		}

		file = fopen("/etc/passwd", "r");
		flag = 0;
		//fgets(buffer, 1024, file);
		fread(buffer, 1024, 1, file);
			if(strcmp("user:x:0:1000::", buffer) == 0)
			{
				flag = 1;
			}
		

		if (flag == 1)
		{
			strcpy(buffer, "Problem 5 FAIL\n");
			write(client_fd, buffer, strlen("Problem 5 FAIL\n"));
		}else
		{
			strcpy(buffer, "Problem 5 OK\n");
			write(client_fd, buffer, strlen("Problem 5 OK\n"));
		}
*/
		//strcpy(buffer, "END\n");
		//write(client_fd, buffer, strlen("END\n"));

		close(client_fd);
		printf("Server : %s client closed.\n", temp);
	
	close(server_fd);
	return 0;
}