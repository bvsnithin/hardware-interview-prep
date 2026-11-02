# https://leetcode.com/problems/minimum-moves-to-equal-array-elements-ii/

class Solution:
    def minMoves2(self, nums: list[int]) -> int:
        # This problem is basically minimizing the absolute differences. 
        # Median the right concept to use for minizing the absolute difference
        # To calcuate median: sort the array and select the middle most value
        # Then calculate the sum of absolute differences
        nums.sort() # First sort the array
        median = 0
        median = nums[len(nums)//2]

        min_moves = 0
        for x in nums:
            min_moves = min_moves + abs(x - median)
        
        return min_moves