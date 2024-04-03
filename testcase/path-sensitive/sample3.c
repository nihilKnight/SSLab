#include <stdlib.h>  
#include <stdio.h>
 
void GenerateRandomArray(int *arr, int len, int (*GetNextValue)(void)) {
    for (int i = 0; i < len; i++)
        arr[i] = GetNextValue();
}
 
int GetRandomValue(void) {
    return rand() % 114514;
}
 
int main() {
    int arr[10];
    GenerateRandomArray(arr, 5, GetRandomValue);
    for(int i = 0; i < 5; i++) {
        printf("%d ", arr[i]);
    }
    return 0;
}