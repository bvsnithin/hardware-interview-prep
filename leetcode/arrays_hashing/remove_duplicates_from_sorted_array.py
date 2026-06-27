class Solution:
    def removeDuplicates(self, nums: List[int]) -> int:
        i = 0
        for j in range(1,len(nums)):
            if(nums[i] != nums[j]):
                i = i+1
                nums[i] = nums[j]
            j = j+1
        return i+1            
        