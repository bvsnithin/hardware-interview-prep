# https://leetcode.com/problems/binary-tree-preorder-traversal

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def preorderTraversal(self, root: TreeNode | None) -> list[int]:
        # In pre order traveral we go root -> left -> right order
        preOrderList = []
        
        def preOrderTraversal(node: TreeNode):
            if node is None:
                return
            preOrderList.append(node.val)
            preOrderTraversal(node.left)
            preOrderTraversal(node.right)
        
        preOrderTraversal(root)
        return preOrderList