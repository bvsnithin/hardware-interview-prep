class Solution {
public:
    int singleNumber(vector<int>& nums) {
        // Using the bit set technique
        int ans = 0;

        for (int i = 0;i<32;i++){
            int count = 0;

            for (int j = 0;j<nums.size();j++){
                int val = nums[j];
                if(val & (1 << i)){
                    count++;
                }
            }

            if(count%3 == 1){
                // If count of number of 1s is 1, that means the unique number has a bit set at that index (i)
                ans = ans | (1 << i);
            }
            else{
                ans = ans | 0;
            }
        }


        return ans;
    }
};