# https://leetcode.com/problems/binary-search-tree-to-greater-sum-tree/description/

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def bstToGst(self, root: TreeNode | None) -> TreeNode | None:

        # An in-order traversal visits nodes in ascending order.
        # A reverse in-order traversal visits in descending order.
        # right -> node -> left
        # By visiting in a reverse in-order, we will reach the largest node first. 
        # Hence for every node we reach, it has already seen a value greater than itself.

        # Maintain a running sum
        # Travel to as right as possible to reach a value greater than current node
        # Add the node value to running sum
        # Update current node to the running sum.  
        self.current_sum = 0

        def revInOrder(node: TreeNode):
            if not node:
                return
            
            revInOrder(node.right)
            
            self.current_sum = self.current_sum + node.val
            node.val = self.current_sum
            
            revInOrder(node.left)
        
        revInOrder(root)
        return root
            
