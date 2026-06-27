class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        candidate = nums[0]
        count = 1
        for i in range(1,len(nums)):
            if(nums[i] == candidate):
                count = count+1
            elif(nums[i]!=candidate):
                count = count -1
                if(count==0): 
                    candidate = nums[i]
                    count = 1
            print(f"{candidate},{count}")
        return candidate