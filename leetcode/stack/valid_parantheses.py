class Solution:
    def isValid(self, s: str) -> bool:
        stack = []

        for i in range(len(s)):
            if(s[i]=='(' or s[i]=='{' or s[i] == '['):
                stack.append(s[i])
            else:
                if stack:
                    curr_stack = stack[-1]
                    if(self.isMatch(curr_stack,s[i])):
                        stack.pop()
                    else:
                        stack.append(s[i])
                else:
                    return False

        return len(stack) == 0
        
    def isMatch(self, s1:str, s2:str) -> bool:
        if(s1=='('and s2==')'):
            return True
        if(s1=='['and s2==']'):
            return True
        if(s1=='{'and s2=='}'):
            return True
        return False