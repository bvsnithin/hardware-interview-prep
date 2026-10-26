# https://leetcode.com/problems/coin-change/

class Solution:
    def coinChange(self, coins: list[int], amount: int) -> int:
        # The main idea to solving this problem is what happens if we use one of the available coins as the last coin.
        
        # coins = [1,2,5], amount = 11

        # To make 11, if we use 1 as the last coin, then that means we already have 10 with us, 1+10
        # To make 11, if we use 2 as the last coin, then we already have 9, so it's 2+9
        # Similarly, for 5, it means, we have 6, so it's 5+6
        # This remaining value 10, 9, and 6, becomes the sub-problem

        # State: dp[a] = minimum number of coins needed to reach the amount
        # For the above test case: dp[11] = min(1 + dp[11-1], 1+dp[11-2], 1+dp[11-5])
        # We add 1 because we are using that coin as the last coin, so we count that coin
        # dp[0] = 0
        # For coins that can't be reached, the dp[x] for such coins x will be infinity or a large value. 
        # We use a large value because in the min() function it will be ignored. 

        """
        coins = [1,2,5], amount = 11

        Initially array dp = [inf, inf, inf,.......,inf](size = 12)
        dp[0] = 0
        dp[1] = c=1:dp[1] = min(inf, 1+dp[1-1]) = min(inf, 1) = 1. 
                dp[1] = 1
        dp[2] = c=1:dp[2] = min(inf, 1+dp[2-1]) = min(inf, 1+1) = min(inf,2) = 2
                c=2:dp[2] = min(2, 1+dp[2-2]) = min(2,1) = 1
                dp[2] = 1
        dp[3] = c=1: dp[3] = min(inf, 1+dp[3-1]) = min(inf, 1+dp[2]) = 2
                c=2: dp[3] = min(2, 1+ dp[3-2]) = min(2, 1+dp[1]) = min(2, 2) = 2
        dp[4] = c=1: dp[4] = min(inf, 1+dp[4-1]) = min(inf, 1+dp[3]) = 3
                c=2: dp[4] = min(3, 1+ dp[4-2]) = min(3, 1+dp[2]) = min(3, 2) = 2
        dp[5] = c=1: dp[5] = min(inf, 1+dp[5-1]) = min(inf, 1+dp[4]) = 3
                c=2: dp[5] = min(3, 1+ dp[5-2]) = min(3, 1+dp[3]) = min(3, 3) = 3
                c=5: dp[5] = min(3, 1+dp[5-5]) = min(3,1+dp[0]) = min(3,1) = 1
        dp[6] = c=1 or c=5 give same results dp[6] = min(inf, 1+dp[5]) = min(inf, 1+1) = 2
        We calculate dp for other amounts in the same pattern
        dp[9] = 3
        dp[10] = 2
        dp[11] = When c = 1, min(inf, 1+dp[11-1]) = min(inf, 1+dp[10]) = min(inf, 1+2) = 3
        """

        dp = [inf]*(amount+1) # Create an array with each value initialized to inf
        dp[0] = 0
        for a in range(1, amount+1):
            for c in coins:
                # If coin value is greater than the amount, then we cannot use that coin, so we skip that coin
                # We only consider coins whose value is less than or equal to the amount
                if c<=a:
                    dp[a] = min(dp[a], 1 + dp[a-c])
        if dp[amount] == inf:
            return -1
        else: return dp[amount]