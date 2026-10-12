# https://leetcode.com/problems/balanced-binary-tree/

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def isBalanced(self, root: TreeNode | None) -> bool:
        # A Binary tree is balanced, when the height of each and every node's left subtree and right subtree donot differ by more than one

        # For each node in the tree check the following:
        # abs(height(left subtree) - height(right subtree)) <=1
        # If the above check fails, then the tree is unbalanced. 

        def height(node: TreeNode) -> int:
            # Upon reaching the leaf node, return 0
            if not node:
                return 0

            left_height = height(node.left)
            if left_height == -1:
                # This indicates that the left subtree is unbalanced
                return -1
            
            right_height = height(node.right)
            if right_height == -1:
                # This indicates that the right subtree is unbalanced
                return -1
            
            # Check if the current node is balanced or not
            if (abs(left_height - right_height)) > 1:
                return -1
            
            return max(left_height, right_height) + 1
        
        return height(root)!=-1
