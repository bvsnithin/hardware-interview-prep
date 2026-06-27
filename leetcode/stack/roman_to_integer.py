class Solution:
    def romanToInt(self, s: str) -> int:
        charToIntMap = {'I':1,'V':5,'X':10,'L':50,'C':100,'D':500,'M':1000}
        stack = []
        ans = 0
        for i in range(len(s)):
            curr = charToIntMap.get(s[i],0)
            
            if(len(stack)!=0):
                prev = stack[-1]
                if(prev < curr):
                    ans = ans + curr - (2*prev)
                    stack.append(curr)
                    continue

            ans = ans + curr
            stack.append(curr)
        return ans