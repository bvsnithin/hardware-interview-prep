# https://leetcode.com/problems/house-robber/

class Solution:
    def rob(self, nums: list[int]) -> int:
        # Tabulation: bottom-up approach technique
        # n = len(nums)
        # if n <= 2:
        #     return max(nums)

        # dp = [0]*(n)
        # dp[0] = nums[0]
        # dp[1] = max(nums[0:2])

        # for i in range(2, n):
        #     # You can do the following at each house
        #     # 1) Rob it. It means, we don't rob the previous house. So we add up current house's value and the (i-2)th house's value
        #     # 2) Don't Rob, because we robbed previous house. So we continue with current value only.
        #     # Case 1: nums[i] + dp[i-2]
        #     # Case 2: dp[i-1
        #     # We select the one that gives us the maxium value
        #     dp[i] = max(dp[i-2]+nums[i], dp[i-1])

        # # print(dp)
        # return dp[n-1]

        # Memoization Technique
        n = len(nums)
        if n<=2:
            return max(nums)
        memo = {}

        def helper(k:int)-> int:
            print(k)
            if k == 0:
                memo[k] = nums[k]
            elif k == 1:
                memo[k] = max(nums[0], nums[1])

            if k in memo:
                return memo[k]

            memo[k] = max(helper(k-2)+nums[k], helper(k-1))

            return memo[k]
        
        return helper(n-1)