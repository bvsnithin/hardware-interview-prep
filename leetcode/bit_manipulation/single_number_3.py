class Solution:
    def singleNumber(self, nums: List[int]) -> List[int]:
        """
        - XOR operation of two identical numbers is always 0. 
        - Hence we can calculate XOR of nums to get the XOR between the two unique numbers. 
        - In [1,2,1,3,2,5] XOR of the array will be 3^5
        - 011 (3)
          101 (5)
          110 (6)

          - This XOR indicates the bits where our two unique numbers differ. Let's call this XOR result as diff. 
          - To identify our two unique numbers from the array, let's create a mask to identify the rightmost set bit.
          - But, why are we interested in the rightmost set bit? 
          - By identifying this bit, we can segregate all the numbers that have this bit set to one group and all the numbers that have this bit unset to another group 
          - Since there are only 2 unique numbers, we know that the rightmost set bit of diff means that at this bit position, our two unique numbers differ. Hence they will be in seperate groups. 
          - We will then calculate the XOR on these groups. 
          - Why? We know that the duplicates come in pair, hence both of them always go into one group and their XOR will be 0. This leaves us with just the unique number in the group.

          - In our array example, diff = 110(6). Rightmost set bit mask is 010 (Is calculated by performing x & (-x))
          - Let's group all numbers with this bit set into group A and unset to group B
          1 - 001
          2 - 010
          3 - 011
          5 - 101
          1: 001 & 010 =  0    (group B)
          2: 010 & 010 =  010  (group A)
          1: 001 & 010 =  0    (group B)
          3: 011 & 010 =  010  (group A)
          2: 010 & 010 =  010  (group A)
          5: 101 & 010 =  0    (group B)

          groupA = (2,3,2)
          groupB = (1,1,5)
          XORA = 3,
          XORB = 5
        """

        diff =0;
        for _,num in enumerate(nums):
            diff = diff ^ num
        
        mask = diff & (-diff)

        a = 0 #group A xor
        b = 0 #group B xor

        for _, num in enumerate(nums):
            if(mask & num):
                a = a ^ num
            else: b = b ^ num
        
        return [a,b]