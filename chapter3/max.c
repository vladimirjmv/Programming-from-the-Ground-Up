#include <stdio.h>

int main()
{
    int niz[10] = { 9, 1, 5, 2, 8, 4, 7, 0, 3, 20};
    int max = niz[0];
    for(int i = 1; i < 10; i++){
        if (max < niz[i]){
            max = niz[i];
        }
    }
    printf("%d \n", max);

    return 0;
}