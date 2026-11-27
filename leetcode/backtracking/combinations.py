# https://leetcode.com/problems/combinations/?envType=problem-list-v2&envId=backtracking

class Solution:
    def combine(self, n: int, k: int) -> list[list[int]]:
        # Number of combinations = n!/(r!*(n-r)!)
        # For n = 4 and k = 2 combinations = 4!/(2!*2!) = 24/4 = 6

        result = []
        current_path = []

        def backtrack(start:int):
            if len(current_path) == k:
                result.append(current_path.copy())
                return

            for num in range(start,n+1):
                if num not in current_path:
                    # Choose
                    current_path.append(num)

                    # Explore
                    backtrack(num + 1)

                    # Unchoose
                    current_path.pop()

        backtrack(1)  
        return result