# https://leetcode.com/problems/mini-parser/

# """
# This is the interface that allows for creating nested lists.
# You should not implement it, or speculate about its implementation
# """
#class NestedInteger:
#    def __init__(self, value=None):
#        """
#        If value is not specified, initializes an empty list.
#        Otherwise initializes a single integer equal to value.
#        """
#
#    def isInteger(self):
#        """
#        @return True if this NestedInteger holds a single integer, rather than a nested list.
#        :rtype bool
#        """
#
#    def add(self, elem):
#        """
#        Set this NestedInteger to hold a nested list and adds a nested integer elem to it.
#        :rtype void
#        """
#
#    def setInteger(self, value):
#        """
#        Set this NestedInteger to hold a single integer equal to value.
#        :rtype void
#        """
#
#    def getInteger(self):
#        """
#        @return the single integer that this NestedInteger holds, if it holds a single integer
#        The result is undefined if this NestedInteger holds a nested list
#        :rtype int
#        """
#
#    def getList(self):
#        """
#        @return the nested list that this NestedInteger holds, if it holds a nested list
#        The result is undefined if this NestedInteger holds a single integer
#        :rtype List[NestedInteger]
#        """

class Solution:
    def deserialize(self, s: str) -> NestedInteger:

        # If the string is just a number, then return it as a NesterInteger
        # isdigit() checks if a string is digit or not. For negative numbers, we need to check if the first char is a minus sign(-)
        if s.isdigit() or s[0]=='-':
            return NestedInteger(int(s))

        #-------------------------------------------------------------------

        stack = []
        num = ""
        for i in range(len(s)):
            # Current character in the string
            c = s[i]

            if(c == '['):
                # If it's an opening square bracket - create a NestedInteger Object and add it to stack
                stack.append(NestedInteger())

            elif c.isdigit() or c=='-':
                # If it's a digit then append to current num string. 
                # If it's a minus sign then it means it's a negative number
                num = num+c
                
            elif(c == ','):
                # Add the number to the list
                if num:
                    stack[-1].add(NestedInteger(int(num)))
                    num = ""

            elif(c == ']'):
                # This is for processing the last number before the closing bracket
                if num:
                    stack[-1].add(NestedInteger(int(num)))
                    num = ""

                top = stack.pop() # Get the completed inner list now
                if not stack:
                    return top # If stack is empty, it means, this is the parent list, return it
                else:
                    stack[-1].add(top) 
        
        return NestedInteger()