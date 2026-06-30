class Solution:
    def threeSum(self, nums: list[int]) -> list[list[int]]:
        res = []
        nums.sort()

        for i in range(len(nums)-1):
            if i>0 and nums[i]==nums[i-1]:
                continue

            j = i+1
            k = len(nums)-1

            while(j<k):
                sum = nums[i]+nums[j]+nums[k]
                if(sum==0):
                    res.append([nums[i],nums[j],nums[k]])
                    j = j+1
                    k = k-1

                    #Skip duplicate elements for j and k
                    while j<k and nums[j] == nums[j-1]:
                        j = j+1
                    
                    while k>j and nums[k] == nums[k+1]:
                        k = k-1
                elif(sum>0):
                    k = k-1
                elif(sum<0):
                    j = j+1
        return res