class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        # nums.sort()
        # for i in range(1,len(nums)):
        #     if(nums[i-1]==nums[i]):
        #         return nums[i]

        # return 0
        
        # Using Floyd's Algorithm

        # The array can be viewed as a linked list where each value points to the next index.

        # nums = [1,3,4,2,2]

        # Index 0: 1
        # Index 1: 3
        # Index 2: 4
        # Index 3: 2
        # Index 4: 2
        # 0 -> 1 -> 3 -> 2 -> 4 -> 2 -> 4 -> 2 -> 4
        # Algorith uses two pointers fast(hare) and tortoise(slow). - slow moves one step at a time
        # - fast moves two steps at a time
        # If there is a cycle, they will eventually meet somewhere inside it.

        # Reset one pointer to the beginning while leaving the other at the meeting point. Move both one step at a time. The node where they meet is the entrance to the cycle, which is the duplicate number.

        slow = 0
        fast = 0
        while True:
            slow = nums[slow]
            fast = nums[nums[fast]]
            print(f"Slow: {slow}, Fast: {fast}")
            if(slow == fast):
                break
            
        slow = 0
        print("After reset")
        while True:
            slow = nums[slow]
            fast = nums[fast]

            print(f"Slow: {slow}, Fast: {fast}")

            if(slow == fast):
                return slow
            
        return 0