class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        min = prices[0] #Store the minimum value in the array
        maxProfit = 0   #Max profit made so far

        #Iterate over the array and if the price is the minimum, then update min 
        #Calculate the profit is the price is greater than min value and update maxProfit is profit is greater than maxProfit

        for i, num in enumerate(prices):
            if(num<min):
                min = num
            elif(num>min):
                maxProfit = max(maxProfit, num-min)

        return maxProfit