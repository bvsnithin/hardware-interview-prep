# https://leetcode.com/problems/fibonacci-number/

class Solution:
    def fib(self, n: int) -> int:
        # # Recursion Solution
        # if n == 0 or n == 1:
        #     return n

        # return self.fib(n-1) + self.fib(n-2)

        # Using Dynamic Programming
        # DP is technique where we solve a big problem by breaking it down into small problems. 
        # Solving those small problems one by one and then reusing those answers. 

        # There are 2 techniques in DP
        # 1) Memoization (Top down)
        # 2) Tabulation (Bottom up)

        # Top-down (memoization): Write the problem as a recursive function, then store each result so you never compute the same subproblem twice. 
        # You start from the big problem and break it down.

        # Botom-Up (tabulation): Skip recursion entirely. 
        # Start with the smallest subproblems, fill in a table (usually an array), and build up to the answer with a loop.

        # Factorization using memoization 
        memo = {} # to store the results

        def memoization(k: int) -> int:
            if k <= 1:
                return k
            if k in memo:
                return memo[k]
            memo[k] = memoization(k-1) + memoization(k-2)
            return memo[k]
        
        return memoization(n)

        # # Factorization using tabulation
        # if n<=1:
        #     return n

        # dp = [0]*(n+1)
        # dp[1] = 1

        # for i in range(2, n+1):
        #     dp[i] = dp[i-1] + dp[i-2]
        # return dp[n]