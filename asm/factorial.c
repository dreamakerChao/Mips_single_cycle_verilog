// full_comprehensive_test.c

int square(int x);
int main() {
    int a = 3;
    int b = 4;
    int sum = a + b;       // sum = 7
    int sq = square(sum);  // sq = 49

    if (sq > 20) {
        sq += 10;          // sq = 59
    }

    for (int i = 0; i < 5; i++) {
        sq += 1;           // sq will = 64
    }

    while (sq < 70) {
        sq += 1;
    }

    //sq = 70， $v1
    asm volatile("move $v1, %0" :: "r"(sq));

    return 0;
}

int square(int x) {
    return x * x;
}
