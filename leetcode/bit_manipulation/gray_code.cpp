// https://leetcode.com/problems/gray-code/

// Binary to Gray Code conversion
// binary 3 = 0011
// gray 3 = msb(bit 3), bit3 ^ bit2, bit2 ^ bit1, bit1 ^ bit0
// gray code = n ^ (n >> 1)

// binary 3 =      0011
// binary 3 >> 1 = 0001
// gray code (xor) 0010

class Solution {
public:
    vector<int> grayCode(int n) {
        int size = pow(2,n);
        vector<int> res(size);

        for (int i = 1;i<size;i++){
            res[i] = gray(i);
        }
        return res;
    }

    int gray(int n){
        return n ^ (n >> 1);
    }
};