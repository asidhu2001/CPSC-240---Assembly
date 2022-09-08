
#include <stdio.h>

extern long manager();

int main()
{
	printf("Welcome to the Array of Integers.\nBrought to you by Amritpaul Sidhu\n");
	
	long int returnValue = 0;
	returnValue = manager();
	
	printf("\nMain received this number: %ld" , returnValue);
	printf("\nMain will return 0 to the operating system. Bye!\n");
	
	return 0;
	

}

