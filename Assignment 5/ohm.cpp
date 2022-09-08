#include <iostream>
#include <iomanip>

extern "C" double resistance();

using namespace std;


int main()
{
	cout << "\nWelcome to Parallel Circuits by Amritpaul Sidhu.\n";
	cout << "This program will automate finding the resistance in a large circuit.\n";
		  
	double returnValue = resistance();
		  
	
	cout << "\nMain received this number: " << std::fixed << std::setprecision(10) << returnValue << endl;
	cout << "Main will now return 0 to the operating system.\n";
	
	return 0;
}
		  

		  
	
