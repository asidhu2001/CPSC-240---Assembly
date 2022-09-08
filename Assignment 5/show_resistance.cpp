#include <iostream>
#include <iomanip>
#include <cmath>

extern "C" void show_resistance(double, double, int, double);

void show_resistance(double res, double speed, int ticks, double nanosecs){

	std::cout << "The total resistance of the system is " << std::fixed << std::setprecision(10) << res << " Ohms, which required ";
	std::cout << ticks << " ticks (" << std::fixed << std::setprecision(10) << nanosecs << "ns) to complete.\n";
	
	return;
	
}
