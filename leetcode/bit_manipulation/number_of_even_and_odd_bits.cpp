// https://leetcode.com/problems/number-of-even-and-odd-bits/

class Solution {
public:
    vector<int> evenOddBit(int n) {
        // Let's extract even bits with the even mask = 0x55555555
        // Because 5 is 0101. 1 is present in even positions (bit 0, bit 2) 
        int even_bits = n & 0x55555555;

        // Let's extract odd bits with the odd mask = 0xAAAAAAAA
        // Because A is 1010. 1 is present in odd po˚sitions (bit 1, bit 2)
        int odd_bits = n & 0xAAAAAAAA;

        // Now let's count 1s in even_bits and odd_bits
        vector<int> res(2);
        res[0] = countOnes(even_bits);
        res[1] = countOnes(odd_bits);
        return res;
    }

    int countOnes(int n){
        int count = 0;
        while (n>0){
            count = count + (n&1);
            n = n >> 1;
        }

        return count;
    }
};