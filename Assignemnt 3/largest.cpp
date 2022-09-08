#include <stdio.h>
#include <iostream>
extern "C" long manager();

int main()
{
	printf("\nWelcome to CPSC 240 Assignment 3 brought to you by Amritpaul Sidhu.\n");
	
	long int returnValue = 0;
	returnValue = manager();
	
	printf("\n\nThe driver recieved this value: %ld\n",  returnValue);
	printf("Have a nice day. The program will return control to the operating system.\n");
	
}
