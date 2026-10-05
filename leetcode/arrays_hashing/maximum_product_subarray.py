# https://leetcode.com/problems/maximum-product-subarray/

class Solution:
    def maxProduct(self, nums: list[int]) -> int:
        # Similar to the maximum subarray sum question - If we use the brute force, it would need us to check N(N+1)/2 subarrays which is O(N^2) time complexity

        # A version of Kadane's Algorithm can solve this in single pass in O(N) time complexity

        # In addition, a negative number always reduces the running sum. Whether the current element is positive or negative, adding a negative number always reduces the sum. 
        # However, in multiplication, sometimes a negative number can increase the product - If the current running product is also negative. 

        # We maintain both the current maximum and current minimum product
        # A big negative number when multilpied with another negative number can produce a very high product. 
        # Hence we cannot simply discard minimum values during our pass

        # The algorithm thus maintains both maximum prod and minimum prod. 
        # If the current element is positive, we multiply with our maximum prod and increase our product
        # If the current element is negative, then we swap "max" and "min" and calculate our product
        
        curr_max = nums[0]
        curr_min = nums[0]
        max_prod = nums[0]

        for i in range(1, len(nums)):
            num = nums[i]
            # Swap curr_max and curr_min when the nums[i] is negative
            if(num < 0):
                temp = curr_max
                curr_max = curr_min
                curr_min = temp

            curr_max = max(num, curr_max * num)
            curr_min = min(num, curr_min * num)
            max_prod = max(max_prod, curr_max)

        return max_prod