# https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/description/?envType=problem-list-v2&envId=binary-tree

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

# This question is similar to level order traversal. However, we alternate the direction of traversal for each level
# In the first level, we traverse from left to right and in the next level we traverse right to left and so on.....

from collections import deque

class Solution:
    def zigzagLevelOrder(self, root: TreeNode | None) -> list[list[int]]:
        
        if not root:
            return []

        res = []
        queue = deque([root])
        order = 1  # For alternate/zig-zag traversal of nodes. If order == 1, go left to right, else if order = 0, go right to left
        while queue:
            current_length = len(queue)
            current_level = [] # To store current level nodes

            for i in range(current_length):
                node = queue.popleft()

                current_level.append(node.val)

                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)
            
            if order == 0:
                current_level.reverse()
                res.append(current_level)
                order = 1
            else:
                res.append(current_level)
                order = 0

        return res