class Solution:
    def threeSumClosest(self, nums: List[int], target: int) -> int:
        """
        - Similar to 3sum
        - First, let's sort the array
        - Fix i to the start of the array
        - Take two pointers j(left) and k(right) from i+1 and end-1
        - Move the pointers withrespect to sum of the 3 values at index i,j,k
        - If sum is very far, then decrement k else increment j
        - Maintain the closest sum value (sum of the 3 values which has the minimum distance from target)
        """

        #Initialize closest sum to the sum of first 3 numbers
        nums.sort()
        close_sum = nums[0] + nums[1] + nums[2]
        n = len(nums)
        for i in range(n-2):
            j = i+1
            k = n-1
            while(j<k):
                
                local_sum = nums[i] + nums[j] + nums[k]
                # print(f"{nums[i]} {nums[j]} {nums[k]} {local_sum}")

                # Calculate the absolute value to find how close are the sums to target
                sum_distance = abs(local_sum-target)
                close_sum_distance = abs(close_sum - target)

                if(sum_distance < close_sum_distance):
                    close_sum = local_sum
                if(local_sum==target):
                    return local_sum
                elif(local_sum<target):
                    j = j+1
                else:
                    k = k-1

        return close_sum                 
