# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def hasCycle(self, head: Optional[ListNode]) -> bool:
        #If empty of just one node is present
        if(head == None or head.next == None):
            return False

        fast = head 
        slow = head

        #Using floyd's algorithm. Fast pointer jump 2 places and slow pointer moves one after other
        while(fast and fast.next):
            slow = slow.next
            fast = fast.next.next
            if(slow == fast):
                return True
        
        return False