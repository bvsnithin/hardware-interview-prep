# https://leetcode.com/problems/invert-binary-tree/

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def invertTree(self, root: TreeNode | None) -> TreeNode | None:
        
        # Let's use post order traversal
        # visit left subtree and swap the left and right nodes
        # visit right substree and swap the left and right nodes
        # swap left and right subtree finally

        # Base case - If we reach the leaf nodes, we return 
        if root is None:
            return None

        self.invertTree(root.left)
        self.invertTree(root.right)

        temp = root.right
        root.right = root.left
        root.left = temp

        return root