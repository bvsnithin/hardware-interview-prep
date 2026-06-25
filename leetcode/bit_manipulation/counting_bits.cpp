class Solution {
public:
    vector<int> countBits(int n) {
        vector<int> out;
        for(int i = 0;i<=n;i++){
            int num = i;
            int count = 0;
            while(num>0){
                count = count + (num&1);
                num = num>>1;
            }
            out.push_back(count);
        }
        return out;
    }
};