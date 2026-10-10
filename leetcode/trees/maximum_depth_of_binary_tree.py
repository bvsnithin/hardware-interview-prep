# https://leetcode.com/problems/maximum-depth-of-binary-tree/

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def maxDepth(self, root: TreeNode | None) -> int:

        if root is None:
            return 0
            
        # Depth at root node is 1
        depth = 1

        def traverseTree(node: TreeNode, depth:int) -> TreeNode:
            if node is None:
                return depth

            depth = depth + 1
            return max(traverseTree(node.left, depth), traverseTree(node.right, depth))

        return max(traverseTree(root.left, depth), traverseTree(root.right, depth))

            

