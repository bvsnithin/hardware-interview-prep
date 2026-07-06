class Solution:
    def merge(self, nums1: List[int], m: int, nums2: List[int], n: int) -> None:
        """
        Do not return anything, modify nums1 in-place instead.
        """
        i = m-1 #pointer to last element on nums1
        j = n-1 #pointer to the last element on nums2
        k = m+n-1 #pointer to last element on merged sorted array

        #Compare and add the larger number to the nums1 array
        while(i>=0 and j>=0):
            if(nums2[j] > nums1[i]):
                nums1[k] = nums2[j]
                j = j-1
                k = k-1
            elif(nums1[i] > nums2[j]):
                nums1[k] = nums1[i]
                i = i-1
                k = k-1
            else:
                #If equal? Add both the numbers to nums1 array
                nums1[k] = nums1[i]
                k = k-1
                i = i-1
                nums1[k] = nums2[j]
                k = k-1
                j = j-1
        
        #Does the nums1 array still has elements to be processed?
        while(i>=0):
            nums1[k] = nums1[i]
            k = k-1
            i = i-1
        
        #Does the nums2 array still have elements to be processed
        while(j>=0):
            nums1[k] = nums2[j]
            k = k-1
            j = j-1

        