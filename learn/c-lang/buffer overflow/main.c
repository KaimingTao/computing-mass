#include <stdio.h>

void pwned() {
    printf("GOTCHA!!\n");
}

void callme() {
    int a[10];
    printf("Over here!\n");
    // hack return address.
    a[14] = (int)(&pwned);
}

int main() {
    callme();
    return 0;
}
