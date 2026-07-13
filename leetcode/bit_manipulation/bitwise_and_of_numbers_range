class Solution:
    def rangeBitwiseAnd(self, left: int, right: int) -> int:
        """
        If we loop over all the values from left to right, we will reach TLE
        To solve this question we need to use bit manipulation/shifting
        
        :::::: Idea behind the solution :::::: 
        In binary, the last bits are always flipping back and forth. Following are numbers from 0 to 7 
        Observe how the last bit toggles every number and for 2nd position, it get's toggled every 2 numbers
        000
        001
        010
        011
        100
        101
        110
        111
        - When we perform and operation between number 0 to 7, it results in 0, since the bits are toggled for all  the positions. 
        - Hence, even if the bit is toggled once, that position will result in 0.
        - Consider the subset from 4 to 7. Only bits at the 0th and 1st position are toggled. Hence the and of 4 to 7 will have 0 and 0 at the 0th and 1st positions. 

        Therefore, to find the and of numbers inbetween left and right, we need to find the most common prefix of left and right.
        
        Example 1:
        Common prefix for 8 and 11 is 10 Because 8 = 1000 and 1011. Last two bits are toggled. Which leaves with 10 as common prefix. 
        Hence and operation will give 1000(Remaining bits after common prefix will result in 0 when performed and operation)

        Example 2:
        416 = 0b110100000
        436 = 0b110110100
        Common prefix = 1101
        And operation will result in 110100000

        Hence for this question:
            1. Find the common prefix between the binaries of left and right
            2. This could be found by shifting both numbers to right until they become equal
            3. Once they are equal, we have the common prefix 
            4. Then shift the common prefix left the same number of times, we shifted right
        """
        count = 0
        while(left!=right):
            left = left >> 1
            right = right >> 1
            count += 1
        return left << count