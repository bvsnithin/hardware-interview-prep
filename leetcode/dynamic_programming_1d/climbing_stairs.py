class Solution:
    def climbStairs(self, n: int) -> int:
        """
        To reach an index x, we can get there in 2 ways
        1) From index x-1, take 1 step
        2) From index x-2, take 2 steps

        Num of steps to reach x = (Num of steps to reach x-1) + (Num of steps to reach x-2  )
        """
        if(n==1):
            return 1
        elif(n==2):
            return 2
        
        arr = [0]*n
        arr[0] = 1
        arr[1] = 2

        for i in range(2,n):
            arr[i] = arr[i-1]+arr[i-2]

        return arr[n-1]

        # # Memoization technqiue
        # memo = {}
        # def memoization(k:int) -> int:
        #     if k <= 2:
        #         return k
        #     if k in memo:
        #         return memo[k]
        #     memo[k] = memoization(k-1) + memoization(k-2)
        #     return memo[k]
        # return memoization(n)
        