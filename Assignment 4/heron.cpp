#include <iostream>
#include <iomanip>

extern "C" double triangle();


int main()
{
	std::cout << "\nWelcome to CPSC 240 Assignment 4 brought to you by Amritpaul Sidhu.\n";
	
	double returnValue = triangle();
	
	std::cout << "\nHeron received this number: " << std::fixed << std::setprecision(10) << returnValue << "\n";
	std::cout << "Have a nice day. The program will return control to the operating system.\n";
}
