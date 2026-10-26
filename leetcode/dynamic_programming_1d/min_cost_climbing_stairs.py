# https://leetcode.com/problems/min-cost-climbing-stairs/

class Solution:
    def minCostClimbingStairs(self, cost: list[int]) -> int:
        """
        In order to reach location "i", we can jump from i-2 or i-1
        The cost to reach location i = Min(jumping from i-1 vs jumping from i-2)
        cost to reach location 0 = 0
        cost to reach location 1 = 0
        cost to reach location 2 = min(cost to reach from 0, cost to reach from 1)
        cost to reach location 3 = min(cost to reach from 2, cost to reach from 1)
        """

        # Tabulation technique
        n = len(cost)
        dp = [0]*(n+1)
        for i in range(2, n+1):
            dp[i] = min(dp[i-1]+cost[i-1], dp[i-2]+cost[i-2])

        return dp[n]

        # Memoization technique
        # n = len(cost)
        # memo = {}

        # def memoization(k:int)-> int:
        #     if k <= 1:
        #         return 0
        #     if k in memo:
        #         return memo[k]
        #     memo[k] = min(memoization(k-1)+cost[k-1], memoization(k-2)+cost[k-2])
        #     return memo[k]
        
        # return memoization(n)