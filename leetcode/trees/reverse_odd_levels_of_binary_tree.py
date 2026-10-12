# https://leetcode.com/problems/reverse-odd-levels-of-binary-tree/

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
from collections import deque
class Solution:
    def reverseOddLevels(self, root: TreeNode | None) -> TreeNode | None:
        # This is a level order traversal problem
        # Traverse the tree level by level
        # If the level number is odd, then reverse the node values in that level
        if not root:
            return None

        queue = deque([root])
        level = 0
        while queue:
            level_len = len(queue)
            current_level = []

            for i in range(level_len):
                node = queue.popleft()
                
                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)
                
                current_level.append(node)
            
            if level%2 == 1:
                # swap the node values in the list using 2 pointer approach
                left = 0
                right = len(current_level)-1

                while left <= right:
                    current_level[left].val, current_level[right].val = current_level[right].val, current_level[left].val

                    left = left + 1
                    right = right - 1
            
            level = level + 1

        return root

        