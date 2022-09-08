#include <iostream>
#include <iomanip>

extern "C" void show_results(double, double, double, double);

void show_results(double side1, double side2, double side3, double area)
{
	std::cout << "The area of a triangle with sides " << std::fixed << std::setprecision(10) << side1 << ", " 
		  << std::setprecision(10) << side2 << ", and " 
		  << std::setprecision(10) << side3 << " is "
		  << std::setprecision(10) << area << " square units.\n";
		  
		 return;
} 
