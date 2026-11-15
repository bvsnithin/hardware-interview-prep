# https://leetcode.com/problems/reverse-linked-list-ii/description/?envType=problem-list-v2&envId=linked-list

# This solution works but it's pretty verbose

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def reverseBetween(self, head: ListNode | None, left: int, right: int) -> ListNode | None:

        if head.next is None:
            return head

        if left == right:
            return head
        
        # Let's first find the head and tail of the sub linked list that needs to reversed
        length = 1
        curr = head
        subLL_head = head
        subLL_tail = head
        while(curr.next is not None):

            if length == left:
                subLL_head = curr
            if length+1 == right:
                subLL_tail = curr.next
            
            curr = curr.next
            length += 1

        # Lets save the part after the sub linked list tail
        after_subLL_tail = subLL_tail.next

        # Let's reverse the left to right part of the linked list
        subLL_length = right - left + 1

        prev = None
        curr = subLL_head

        while (subLL_length):
            temp = curr.next # Store the next node in temp
            curr.next = prev # 
            prev = curr
            curr = temp
            subLL_length -= 1
        
        subLL_tail = subLL_head
        subLL_head = prev

        # If the range we are given is the entire linkedlist, then we already reversed that! So just return the subLL_head
        if(right == length and left == 1):
            return subLL_head

        # Now subLL_head is pointer to the reversed sub linkedlist
        # All we have to do is link the exisiting linked list to this reversed sub linked list
        subLL_tail.next = after_subLL_tail

        if left == 1:
            return subLL_head
        
        before_subLL_starts = head
        i = 0 # Traverse till i == left -2
        for i in range(left-2):
            before_subLL_starts = before_subLL_starts.next
        
        before_subLL_starts.next = subLL_head
        
        return head

