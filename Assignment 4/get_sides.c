#include <stdio.h>
#include <string.h>

extern void get_sides();

void get_sides(double * side1, double * side2, double * side3)
{	
	char input[8192];
	int returnValue;
	
	*side1 = 180213193408853.2;			//dummy numbers for input validation hoping the user would never enter these specfifc numbers in a row
	*side2 = 9099231233.2313;			//however if entered, the program will not run as intended due to it being the only case that would not work
	*side3 = -213213123.32183439;			//due to how the input validation was implemented
	

	printf("\nInput your 3 floating point numbers representing the sides of a triangle.\nPress enter after each number:\n");
	
	/*scanf("%lf", side1);
    	scanf("%lf", side2);
    	scanf("%lf", side3);
    		
	printf("\n%lf\n", *side1);
	printf("%lf\n", *side2);
    	printf("%lf\n", *side3);*/
    	
	if (fgets(input, sizeof(input), stdin) == NULL) {
		printf("You entered no line!\n");
		}
		else {
		returnValue = sscanf( input, "%lf", side1 );
		if ( returnValue < 0 ) {
			printf("Your input is nonsense!\n");
			return;
		}
		else if ( returnValue == 0 ) {
			printf("\nYour input is nonsense!\n");
			return;
		}
		else{
	    }
	    
	    if (fgets(input, sizeof(input), stdin) == NULL) {
		printf("You entered no line!\n");
		}
		else {
		returnValue = sscanf( input, "%lf", side2 );
		if ( returnValue < 0 ) {
			printf("Your input is nonsense!\n");
			return;
		}
		else if ( returnValue == 0 ) {
			printf("\nYour input is nonsense!\n");
			return;
		}
	    }
	    
	    if (fgets(input, sizeof(input), stdin) == NULL) {
		printf("You entered no line!\n");
		}
		else {
		returnValue = sscanf( input, "%lf", side3 );
		if ( returnValue < 0 ) {
			printf("Your input is nonsense!\n");
			return;
		}
		else if ( returnValue == 0 ) {
			printf("\nYour input is nonsense!\n");
			return;
		}
	    }
    	}
    	return;
}

