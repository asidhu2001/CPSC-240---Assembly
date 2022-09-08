
#include <stdio.h>
#include <algorithm>

extern "C" { void reverse(signed long *, long);};


void reverse(signed long * arr, long count)
{
	signed long * p1;
	signed long * p2 = arr + count - 1;
	for (;p1 < p2; p1++)
	{
	std::swap(*p1, *p2);
	p2--;
	}
}
		

