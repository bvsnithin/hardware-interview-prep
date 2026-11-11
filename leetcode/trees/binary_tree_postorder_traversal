# https://leetcode.com/problems/binary-tree-postorder-traversal

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def postorderTraversal(self, root: TreeNode | None) -> list[int]:
        # Post order traversal: left -> right -> root
        postOrderList = []

        def postOrderHelper(node: TreeNode):
            
            if node is None:
                return 

            postOrderHelper(node.left)
            postOrderHelper(node.right)
            postOrderList.append(node.val)

        postOrderHelper(root)
        return postOrderList
