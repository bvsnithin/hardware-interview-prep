# https://leetcode.com/problems/add-binary/description/?envType=problem-list-v2&envId=bit-manipulation

class Solution:
    def addBinary(self, a: str, b: str) -> str:
        # Convert the binary string to integers
        a = int(a, 2)
        b = int(b, 2) 

        while b!=0:
            carry = (a & b) << 1 # Carry tells us bit positions where carry is generated
            # We left shift to indicate positions where the generated carry will impact

            sum = a ^ b # Addition without carry
            b = carry
            a = sum

            # We keep looping until we get rid of all carry bits
        
        return format(a, "b")