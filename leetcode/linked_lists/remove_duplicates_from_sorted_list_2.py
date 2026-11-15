# https://leetcode.com/problems/remove-duplicates-from-sorted-list-ii/?envType=problem-list-v2&envId=linked-list

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def deleteDuplicates(self, head: ListNode | None) -> ListNode | None:
        if head is None:
            return 
        if head.next is None:
            return head
        
        dummy = ListNode(0, head)
        prev = dummy

        curr = head

        while curr:
            # If we find a sequene of same numbers, we keep moving our curr pointer until the end of the sequence
            if curr.next and curr.next.val == curr.val:
                while curr.next and curr.next.val == curr.val:
                    curr = curr.next
                prev.next = curr.next 
            else:
                prev.next = curr
                prev = curr
            curr = curr.next
            
        return dummy.next