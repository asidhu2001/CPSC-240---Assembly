#include <iostream>

extern "C" double compute_resistance(double, double, double, double);

double compute_resistance(double circ1, double circ2, double circ3, double circ4) 
{
	if (circ1 <= 0 || circ2 <= 0 || circ3 <= 0 || circ4 <= 0)
	{
		return 0.0;
	}
	
	double res = 0.0;
	
	res  = (1/circ1) + (1/circ2) + (1/circ3) + (1/circ4);
	res = (1/res);
	
	return res;
}

