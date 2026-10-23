# https://leetcode.com/problems/n-th-tribonacci-number/
class Solution:
    def tribonacci(self, n: int) -> int:
        # # Simple recursion - will result in TLE
        # if n<=1:
        #     return n
        # if n == 2:
        #     return 1
        # return self.tribonacci(n-1) + self.tribonacci(n-2) + self.tribonacci(n-3)

        # Memoization Technique
        # memo = {}

        # def memoization(k:int) -> int:
        #     if k <= 1:
        #          return k
        #     elif k == 2:
        #         return 1
        #     if k in memo:
        #         return memo[k]

        #     memo[k] = memoization(k-1) + memoization(k-2) + memoization(k-3)
        #     return memo[k]
        
        # return memoization(n)

        # Tabulation technique
        if n <= 1:
            return n
        elif n==2:
            return 1
            
        dp = [0] * (n+1)
        dp[0] = 0
        dp[1] = 1
        dp[2] = 1

        for i in range(3, n+1):
            dp[i] = dp[i-1] + dp[i-2] + dp[i-3]

        return dp[n]
        