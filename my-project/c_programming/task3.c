#include <stdio.h>
#include <math.h>
float Area_of_square(float);
float l;
int main(){
	printf("Please enter lenght of a side of square\n");
	scanf("%f",&l);
	printf("Area of square will be %f",Area_of_square(l));
	return 0;
}
float Area_of_square(float x){
	return x*x;
}


