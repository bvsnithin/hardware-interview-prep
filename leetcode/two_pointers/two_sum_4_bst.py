# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def findTarget(self, root: Optional[TreeNode], k: int) -> bool:
        list = []

        def traverse(root):
            if root is None:
                return
            
            traverse(root.left)
            list.append(root.val)
            traverse(root.right)

        traverse(root)
        print(list)
        i = 0
        j = len(list)-1

        while(i<j):
            sum = list[i] + list[j]
            if(sum == k):
                return True
            if(sum<k):
                i+=1
            else: j-=1

        return False