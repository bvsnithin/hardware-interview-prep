# https://leetcode.com/problems/jump-game/

class Solution:
    def canJump(self, nums: list[int]) -> bool:
        # [2,3,1,1,4]
        # From index 0 = 2, we can jump to index 1 and index 2, range = 1:2
        # From index 1 = 3, we can jump to index 2, 3, and 4, range = 2:4
        # Index 2 = 1, range = 3:3
        # Index 3 = 1, range = 4:4
        n = len(nums)
        if n == 1:
            return True

        # dp[x] = whether you can jump from index x to the last index
        # dp[x] = True, means you can jump from this index to the last index. 

        # Initially, except for last index, we don't know whether we can jump from any of the indices to reach the last index. Hence we initialize our dp array to be false
        dp = [False]*n
        dp[n-1] = True
        # dp[last_index] is always True because we can reach it from that index

        # Top to bottom approach
        for i in range(n-2, -1,-1):
            if nums[i] == 0:
                dp[i] = False

            farthest = min(n, i+nums[i])  # No point in checking the index beyond the last index so we go as far as minimum of n(last index) or i+nums[i](max possible jump)
            nearest = i+1
            # Range: nearest to farthest
            # print(f"{farthest}, {nearest}")
            for x in range(i+1, farthest+1):
                if dp[x] == True:
                    dp[i] = True
                    break
                    
        # print(dp[:n-1])
        return dp[0]