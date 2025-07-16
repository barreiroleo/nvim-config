#include <format>

// Two-way conflict
<<<<<<< HEAD
int add(int a, int b) { return a + b; }
=======
auto add(int a, int b) -> int { return a + b; }
>>>>>>> feature

// Three-way conflict
<<<<<<< HEAD
int multiply(int x, int y) { return x * y; }
||||||| parent
int multiply(int x, int y) {
    int result = 0;
    for (int i = 0; i < y; ++i) result += x;
    return result;
}
=======
constexpr int multiply(int x, int y) { return x * y; }
>>>>>>> ours
