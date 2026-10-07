# https://leetcode.com/problems/same-tree/

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def isSameTree(self, p: TreeNode | None, q: TreeNode | None) -> bool:
        # If both nodes are None, this part of the trees is identical
        if not p and not q:
            return True

        # If one of the tree's node is still present while other is not, then they are not same
        # Also, different values indicate different trees
        if not p or not q or p.val != q.val:
            return False

        # Checking the left and right subtrees recursively.
        # This is essentially a DFS approach. Check current node and then left and right
        return self.isSameTree(p.left, q.left) and self.isSameTree(p.right, q.right)