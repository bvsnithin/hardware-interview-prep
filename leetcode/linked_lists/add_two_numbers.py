# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        carry = 0
        #Dummy will point to the start of the sum linked list
        dummy = ListNode(0)
        # Current pointer will keep going forward with each sum generated at every position
        current = dummy

        #We loop until l1 and l2 are completed and there is no carry left to be added
        while(l1 or l2 or carry):

            # If l1 or l2 are completed then we consider their values as 0
            l1_val = l1.val if l1 else 0
            l2_val = l2.val if l2 else 0
            sum = l1_val + l2_val + carry
            # print(f"sum: {sum}, l1 val = {l1_val}, l2 val = {l2_val}")
            carry = int(sum/10)
            remainder = sum%10
            current.next = ListNode(remainder)
            current = current.next
            if l1: l1 = l1.next
            if l2: l2 = l2.next
        return dummy.next