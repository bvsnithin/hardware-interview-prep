# https://leetcode.com/problems/swap-nodes-in-pairs/?envType=problem-list-v2&envId=linked-list

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def swapPairs(self, head: ListNode | None) -> ListNode | None:
        # The idea is to use two pointers - first and second. And swap those two nodes and continue moving along the linkedlist and swapping two nodes at a time until we reach the end

        dummyNode = ListNode(0, head)
        prev = dummyNode

        while prev.next and prev.next.next:
            first = prev.next
            second = first.next
            
            temp = second.next  # Save the rest of the linkedlist
            # Swap the nodes
            second.next = first 
            first.next = temp

            # Move the previouse pointer to first! 
            prev.next = second
            prev = first

        return dummyNode.next