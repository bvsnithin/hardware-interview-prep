class Solution:
    def minEatingSpeed(self, piles: List[int], h: int) -> int:
        """
        We need to find the minimum speed "k" to eat the bananas within "h" hours
        The value of k could be 1(eats only 1 banana per hour) to max value in the piles.
        For [3,6,7,11] k could be 1 to 11
        If k == 1:
            To eat 3 bananas it takes 3 hours, 6 bananas 6, hours and so on
            Total 3+6+7+11 =27
            27<8. So k = 1 is not enough speed
        If k == 2:
            To eat 3 bananas, it will take 2 hours, 6 bananas 3 hours, 7 bananas 4 hours and 11 bananas 6 hours
            So total 2+3+4+6 = 15
            15<8. So k = 2 is also not enough speed
        If k == 3:
            Total 1+2+3+4 = 10
            10 < 8. So k = 3 is also not enough
        If k == 4:
            Total = 1+2+2+3 = 8
            8 == 8. So k = 4 just satisfies. That means even k = 5 will satisfy. 
            But we have to select the minimum number. So k = 4 is the right speed
        So, there is a monotonicity pattern, where once we reach a number that satisfies the condition, 
        the rest of the conditions above that number will satisfy as well.
        Here, from 1 to 11 (max in piles), our k could be in range [1,11]
        However, 1 to 3 do no satisfy. But rest do.
        This could be seen as [no,no,no,yes,yes,yes......yes]
        This pattern is called a monotonic pattern. Hence we can perform a binary search on this array from 1 to 11 to find the minimum where where we get a yes(condition satisfied)
        """
        min_k = 0
        left = 1                    # Minimum speed is 1
        right = max(piles)          # Maximum speed is max value in the pile
        while(left<=right):
            mid = left + (right-left)//2; 
            total_sum = 0
            for i in range(len(piles)):
                hours = math.ceil(piles[i]/mid) #Num of hours it takes to eat those bananas with this speed(mid)
                total_sum += (hours)
                # print(f"Number of hours to eat {piles[i]} bananas at speed {mid} = {hours}")
            # print(f"Total sum for {mid} = {total_sum}")
            
            #If total sum is less than h, then let's search in the left to see if we can find the min k
            if(total_sum<=h): 
                min_k = mid
                right = mid-1
            
            #If total sum is greater than h, value of k does not satisfy the condition, we need to increase speed
            else:
                left = mid+1
            
        return min_k
        