#include <stdio.h>
#include <math.h>
#define PI 3.14159
#define Area(r) (PI*r*r)
float r,a;
int main(){
printf("please enter radius of circle \n");
scanf("%f",&r);
printf("Area of circle will be= %f",Area(r));
}
