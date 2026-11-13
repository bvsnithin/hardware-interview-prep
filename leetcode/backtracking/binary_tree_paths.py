# https://leetcode.com/problems/binary-tree-paths/?envType=problem-list-v2&envId=backtracking

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def binaryTreePaths(self, root: TreeNode | None) -> list[str]:

        if root is None:
            return []
        
        all_leaf_paths = []

        def helper(node:TreeNode, path:list):
            if node is None:
                return
            
            path.append(str(node.val))

            # If the current node is a leaf, then add the path to the array
            if node.left is None and node.right is None:
                all_leaf_paths.append("->".join(path))

            helper(node.left, path)
            helper(node.right, path) 

            # Remove the current node before moving back to the parent
            path.pop()

        helper(root,[])
        return all_leaf_paths
        