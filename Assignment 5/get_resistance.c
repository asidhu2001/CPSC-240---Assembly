#include <stdio.h>
#include <string.h>

extern double get_resistance();

double get_resistance(double * circ1, double * circ2, double * circ3, double * circ4)
{	
	char input[8192];
	int returnValue;

	printf("Please enter the resistance for each of the 4 devices.\n");
	
    	printf("Enter the resistance for device 1 (Ohms): ");
	if (fgets(input, sizeof(input), stdin) == NULL) {
		return 0.0;
		}
		else {
		returnValue = sscanf( input, "%lf", circ1 );
		if ( returnValue < 0 ) {
			return 0.0;
		}
		else if ( returnValue == 0 ) {
			return 0.0;
		}else {
		printf("You entered: %f\n", *circ1);
	    }
	   }
	    
	    printf("Enter the resistance for device 2 (Ohms): ");
	    if (fgets(input, sizeof(input), stdin) == NULL) {
		return 0.0;
		}
		else {
		returnValue = sscanf( input, "%lf", circ2 );
		if ( returnValue < 0) {
			return 0.0;
		}
		else if ( returnValue == 0 ) {
			return 0.0;
		} else {
		printf("You entered: %f\n", *circ2);
	    }
	  }  
	    printf("Enter the resistance for device 3 (Ohms): ");
	    if (fgets(input, sizeof(input), stdin) == NULL) {
		return 0.0;
		}
		else {
		returnValue = sscanf( input, "%lf", circ3 );
		if ( returnValue < 0 ) {
			return 0.0;
		}
		else if ( returnValue == 0 ) {
			return 0.0;
		} else {
		printf("You entered: %f\n", *circ3);
	    }
	   } 
	    
	     printf("Enter the resistance for device 4 (Ohms): ");
	     if (fgets(input, sizeof(input), stdin) == NULL) {
		return 0.0;
		}
		else {
		returnValue = sscanf( input, "%lf", circ4 );
		if ( returnValue < 0) {
			return 0.0;
		}
		else if ( returnValue == 0 ) {
			return 0.0;
		} else {
		printf("You entered: %f\n", *circ4);
	    }
	  }
	  
    	return 1.0;
}

