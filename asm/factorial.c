// factorial_recursive.c
int factorial(int n) {
    if (n <= 1)
        return 1;
    return n * factorial(n - 1);
}

int main() {
    int n = 5;
    int result = factorial(n);

    asm volatile("move $v0, %0" :: "r"(result));

    asm volatile(
        "li $v0, 10\n\t"
        "syscall\n\t"
    );

    return 0;
}
