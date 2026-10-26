class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        
        # We maintain the minimum price we have seen till now (best time to buy) and the maximum profit seen so far

        # Each day we check if current price is the lowest or not
        # If it's the lowest, we buy the stock that day
        # Else, we check if selling the stock gives us a new maximum profit

        min = prices[0] # Store the minimum value
        maxProfit = 0   # Max profit made so far

        # Iterate over the array and if the price is the minimum, then update min 
        # Else check if selling would make a profit greater than exisiting maxprofit

        for i, num in enumerate(prices):
            if(num<min):
                min = num # This is the lowest price seen so far.
            elif(num>min):
                maxProfit = max(maxProfit, num-min) # This is the maximum profit we can earn so far

        return maxProfit

        # [7,1,5,3,6,4]
        """
        min = 7
        maxProfit = 0

        1. 1<7, hence we can buy stock here.
        5. 5 is bigger than 1, so we can sell here to max profit of 4. 4>0, hence new maxProfit = 4
        3. 3 is bigger than 1, we can sell here but profit is only 2. 2<4, hence maxProfit stays same = 4
        6. 6 is bigger than 1, we can sell here at profit of 5. 5>4, hence new maxProfit = 5
        4. 4 > 1, we can sell here at profit of 3. But 3<5, hence new maxProfit = 3
        """