# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:
        dummy = ListNode(0)
        current = dummy

        while(list1 and list2):
            list1_val = list1.val
            list2_val = list2.val
            # print(f"List1 Value: {list1_val}, List2 Value: {list2_val}")
            if(list1_val == list2_val):
                current.next = ListNode(list1_val)
                current = current.next
                current.next = ListNode(list2_val)
                current = current.next
                list1 = list1.next
                list2 = list2.next
            elif(list1_val>list2_val):
                current.next = ListNode(list2_val)
                current = current.next
                list2 = list2.next
            elif(list1_val<list2_val):
                current.next = ListNode(list1_val)
                current = current.next
                list1 = list1.next

        while(list1):
            current.next = ListNode(list1.val)
            current = current.next
            list1 = list1.next
        while(list2):
            current.next = ListNode(list2.val)
            current = current.next
            list2 = list2.next

        return dummy.next