# https://leetcode.com/problems/rotate-list/description/?envType=problem-list-v2&envId=linked-list

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

# The idea to solve this problem:
    # First traverse the LL to reach till the tail. Then create a circular LL by pointing the next node of tail to the head
    # After that, we just need to find the position where the new tail of the rotated LL will be located
    # Once we know where the new tail is, it's next node becomes the new head of the rotated LL
    # We then break the circular linked list by pointing the next of the new found tail node to None
class Solution:
    def rotateRight(self, head: ListNode | None, k: int) -> ListNode | None:
        if k == 0:
            return head
        
        if head is None:
            return head
        
        length = 1
        curr = head # Used for iteration to reach the tail node

        # This gives us the tail node and length of the array
        while curr.next is not None:
            curr = curr.next
            length = length + 1
        
        # Point the tail's next node to the head of the linked list to create a circular linked list
        curr.next = head

        new_tail_position = length - (k%length) - 1

        curr = head
        while(new_tail_position != 0):
            curr = curr.next
            new_tail_position = new_tail_position -1

        head = curr.next
        curr.next = None
        return head
