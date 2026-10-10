# https://leetcode.com/problems/binary-tree-level-order-traversal/

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

from collections import deque

class Solution:
    def levelOrder(self, root: TreeNode | None) -> list[list[int]]:
        
        if not root:
            return []

        # For traversing a tree in python using bfs - level order traversal, we can use deque data structure
        # instantiate a deque with the root element
        queue = deque([root])

        # Final response list
        res = []

        while queue:
            length = len(queue)  # This gives the number of elements in queue at this level
            current_level = [] # Stores elements in current level

            # Iterate over the current level elements in the tree stored in the queue
            for i in range(length):
                node = queue.popleft()

                current_level.append(node.val)

                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)
            
            res.append(current_level)

        return res

