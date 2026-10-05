# https://leetcode.com/problems/maximum-subarray/submissions/2163285137/

class Solution:
    def maxSubArray(self, nums: list[int]) -> int:
        
        # We can solve this using brute force, where we can check every subarray to find the maximum sum
        # However, that means we need to check N(N+1)/2 subarrays. Which will be O(N^2) time complexity
        # Optimized approach would be to use Kadane's Algorithm, which optimizes this to O(N) in single pass

        # Maintain 2 variables, curr_sum and max_sum. 
        # Initalize them to the first variable for single element arrays
        curr_sum = nums[0]
        max_sum = nums[0]

        for i in range(1, len(nums)):
            # Calcuate the running sum: curr_sum + nums[i]
            # If curr_sum was positive, adding nums[i] helps us, so we extend it.
            # If curr_sum was negative, it's dead weight, so we discard it and start fresh at nums[i].
            
            curr_sum = max(nums[i], curr_sum + nums[i])
            
            # Maintain the max sum
            max_sum = max(curr_sum, max_sum)

        return max_sum