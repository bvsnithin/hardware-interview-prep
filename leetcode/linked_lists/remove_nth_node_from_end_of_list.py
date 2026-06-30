# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def removeNthFromEnd(self, head: Optional[ListNode], n: int) -> Optional[ListNode]:
        # If it is nth element from the end, then it will be the len-n+1 element from the start
        # If it is 2nd element from the end, then it will be the 5-2+1 = 4th element from the start
        index = 1
        length = 0
        curr = head
        while(curr):
            length += 1
            curr = curr.next
        
        prev = None
        curr = head
        while(curr):
            if(index == (length-n+1)):
                if(prev==None):
                    return head.next
                prev.next = curr.next
                break
            else:
                prev = curr
                curr = curr.next
                index += 1
        return head