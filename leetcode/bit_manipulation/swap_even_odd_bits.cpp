/*
This is a popular interview question asked in DV and RTL interviews
Given a binary number, swap the bits in even and odd positions. 
Bits are indexed from right to left in the binary representation of a number.

Input - 1011_0101, Output - 0111_1010
*/
#include <iostream>
#include <bitset>
using namespace std;

class Solution {
public:
    int swapEvenOddBits(int n) {
        // Use even bits mask - 0x55555555 
        // Because 5 in binary = 0101. Here even bits are 1. 
        // Hence using this mask we can extract bits in even positions by doing an "and" operation
        unsigned int even_bits = n & 0x55555555;

        // Use odd bits mask - 0xAAAAAAAA
        unsigned int odd_bits = n & 0xAAAAAAAA;

        // Shift odd bits to the right
        odd_bits = odd_bits >> 1;

        // Shift even bits to the left
        even_bits = even_bits << 1;

        // Perform "or" operation to concatenate the bits
        return even_bits | odd_bits;
    }
};

int main() {
    Solution sol;
    int input = 71;
    int swapped = sol.swapEvenOddBits(input);
    cout << "Input decimal: " << input << " | binary: " << bitset<8>(input) << endl;
    cout << "Swapped decimal: " << swapped << " | binary: " << bitset<8>(swapped) << endl;

    input = 170;
    swapped = sol.swapEvenOddBits(input);
    cout << "Input decimal: " << input << " | binary: " << bitset<8>(input) << endl;
    cout << "Swapped decimal: " << swapped << " | binary: " << bitset<8>(swapped) << endl;
    return 0;
}