# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def getIntersectionNode(self, headA: ListNode, headB: ListNode) -> Optional[ListNode]:
        #Set Technique -> Store the pointer of linked list A in a set. Traverse linked list B and if a node already exists in the set, then it's a match
        # visited = set()
        # ptrA = headA
        # while(ptrA):
        #     visited.add(ptrA)
        #     ptrA = ptrA.next

        # ptrB = headB
        # while(ptrB):
        #     if ptrB in visited:
        #         return ptrB
        #     ptrB = ptrB.next
        # return None

        #Two pointer technique. 
        # If nodes intersect, they traverse the same amount of distnace before they intersect. 

        if headA == None or headB == None:
            return None

        ptrA = headA
        ptrB = headB

        while(ptrA != ptrB):
            if(ptrA==None):
                ptrA = headB
            else:
                ptrA = ptrA.next

            if(ptrB==None):
                ptrB = headA
            else:
                ptrB = ptrB.next

        return ptrA