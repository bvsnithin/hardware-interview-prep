# Finding factorial of a number using normal solution and dp techniques

class Factorial:
    def normal_factorial(self, n: int)-> int:
        if(n<=1):
            return 1
        res = 1
        while(n>1):
            res = res * n
            n = n - 1
        return res

    def recursion_factorial(self, n:int)-> int:
        if n<=1:
            return 1
        return n * self.recursion_factorial(n-1)
 
    def memonization_factorial(self, n: int)-> int:
        memo = {}

        def helper(k:int)-> int:
            if k <= 1:
                return 1
            if k in memo:
                return memo[k]

            memo[k] = k * helper(k-1)
            return memo[k]
        
        return helper(n)
    
    def tabulation_factorial(self, n: int)-> int:
        if n <= 1:
            return 1
        dp = [0]*(n+1)
        dp[0] = 1
        dp[1] = 1

        for i in range(2,n+1):
            dp[i] = i * dp[i-1]
        
        return dp[n]


if __name__ == "__main__":
    f = Factorial()
    print(f.normal_factorial(10))
    print(f.memonization_factorial(10))
    print(f.tabulation_factorial(10))
    print(f.recursion_factorial(10))