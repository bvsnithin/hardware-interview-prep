# https://leetcode.com/problems/linked-list-cycle-ii/?envType=problem-list-v2&envId=linked-list

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def detectCycle(self, head: Optional[ListNode]) -> Optional[ListNode]:

        # Let's use the same technique as linked list cycle question to first check if there is a cycle in the linked list or not
        slow = head
        fast = head

        # If there is a cycle, both the pointer will meet at somepoint
        # Slow moves one node at a time
        # Fast moce two nodes at a time
        flag = False
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next

            if(slow == fast):
                flag = True
                break
        
        if not flag:
            return None
        
        slow = head # Move the slow pointer to the head
        # fast remains at the same spot, which is the meeting point inside the cycle. 
        # keep moving one node at a time until both the slow and fast pointer meet

        while slow!=fast:
            slow = slow.next
            fast = fast.next
        
        return slow