#include <stdio.h>

int MyFunc(int x) {
    int ret = -1;
    if (x < 0)
        ret = 0;
    if (x > 5)
        ret = x - 3;
    if (x > 10)
        ret = 0;
    return ret;
}
int main() {
    int a = MyFunc(7);
    printf("%d\n", a);
    return 0;
}

