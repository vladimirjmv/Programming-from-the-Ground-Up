#include <stdio.h>
int factorial(int n);

int main()
{
    int fact = 0;
    printf("Hello World\n");
    fact = factorial(5);
    
    printf("%d \n", fact);
    
    return 0;
}

int factorial(int n){
    if(n == 1)
        return 1;
    return n * factorial(n-1);
}