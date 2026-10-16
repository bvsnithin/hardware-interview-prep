# https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/description/

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def sortedArrayToBST(self, nums: list[int]) -> TreeNode | None:
        # Let's use a divide and conquer approach
        # Since the given array is sorted, the middle element becomes the root
        # Dividing array into 2 (left and right), we follow the same technique again

        def buildTree(left:int, right: int) -> TreeNode:

            if left > right:
                return None
                
            mid = int(left + (right - left)/2)

            root = TreeNode(nums[mid])
            root.left = buildTree(left, mid-1)
            root.right = buildTree(mid+1, right)

            return root
        
        return buildTree(0, len(nums)-1)