#include <stdio.h>

extern long int area();

int main()
{

	
	printf("Welcome to your friendly area calulcator.\n");
	printf("The main program will now call the area function.\n");
	
	long int returnValue = 0;
	returnValue = area();
	
	printf("The main program recieved this integer: %ld\n" , returnValue);
	printf("Have a nice day. Main will now return 0 to the operating system.\n");
	
	return 0;
}	



