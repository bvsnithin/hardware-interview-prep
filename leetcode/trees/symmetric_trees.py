# https://leetcode.com/problems/symmetric-tree/submissions/2165759531/

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def isSymmetric(self, root: TreeNode | None) -> bool:
        if root is None:
            return True
        
        return self.isMirror(root.left, root.right)
    
    def isMirror(self, p:TreeNode, q:TreeNode) -> bool:

        # Checking if we reached the end of the subtree
        if not p and not q:
            return True

        # If one of the nodes is None or if value is not equal, then it's not a symmetric tree
        if not p or not q or p.val != q.val:
            return False

        # Since it's a mirror image, compare left node with right node of the subtrees
        return self.isMirror(p.left, q.right) and self.isMirror(p.right, q.left)