# https://leetcode.com/problems/convert-sorted-list-to-binary-search-tree/?envType=problem-list-v2&envId=linked-list

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def sortedListToBST(self, head: ListNode | None) -> TreeNode | None:
        # Find the middle of the linked list and it becomes the root
        # If odd LL, then middle becomes the root
        # If even LL, then middle+1 becomes the root
        # Node before the middle becomes the left node and node after the middle becomes the right node
        # Repeat this process for all sub LLs
        # Recursively build the BST for left sublist(nodes before the middle)
        # Recursively build the BST for right sublist(nodes after the middle)
        # Root is the middle node

        # Base case
        if not head:
            return head

        if not head.next:
            return TreeNode(head.val)

        # Find the middle of the linked list using the fast and slow pointer technique
        fast = head
        slow = head

        # Finding the half after middle is very easy - You just do middle.next

        prev = None
        while fast and fast.next:
            prev = slow
            fast = fast.next.next
            slow = slow.next
        print(prev)

        prev.next = None # Unlink the first and second half

        # This leaves slow pointer node alone. This is the middle node
        root = TreeNode(slow.val)
        root.left = self.sortedListToBST(head) # Pass the first half
        root.right = self.sortedListToBST(slow.next) # Pass the second half 

        return root