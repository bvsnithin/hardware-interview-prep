# https://leetcode.com/problems/simplify-path/?envType=problem-list-v2&envId=stack

class Solution:
    def simplifyPath(self, path: str) -> str:
        stack = []
        names = path.split('/')

        for name in names:
            if name == '':
                # Empty, so ignore
                continue

            elif name == '..':
                # Pop the parent directory

                # If the stack is empty, then there is nothing to pop. So just continue
                if not stack:
                    continue

                stack.pop()

            elif name == '.':
                continue
            
            else:
                stack.append(name)

        return '/' + '/'.join(stack)