#include <stdio.h>
#include <iostream>
#include <memory>
#include <algorithm>

using namespace std;

extern "C" signed long input_array(signed long *, signed long);

signed long input_array(signed long * arr, signed long max)
{
	cout << "Input your integer data one line at a time and enter 'q' when finished.\n";
	long count = 0;
	int maximum = max;
	for (; count <  maximum; count++)
	{
		cout << "Enter the next Integer: ";
		cin >> arr[count];
		
		if (cin.fail())
		{
			cout << "You have entered nonsense! Assuming you are done.\n";
			return count;
		}
		else
		{
		cout << "You entered: " << arr[count] << "\n";
		max--;
		cout << "You can enter up to " << max << " more integers.\n";
		}
	}
	return count;
}

