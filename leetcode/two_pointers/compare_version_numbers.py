# https://leetcode.com/problems/compare-version-numbers/description/

class Solution:
    def compareVersion(self, version1: str, version2: str) -> int:
        revisions1 = version1.split('.')
        revisions2 = version2.split('.')

        len1 = len(revisions1)
        len2 = len(revisions2)

        score = 0
        i = 0
        j = 0
        while(i<len1 and j<len2):
            val1 = int(revisions1[i])
            val2 = int(revisions2[i])
            # If the current number is same, just keep going! 
            if val1 == val2:
                i += 1
                j += 1
            elif val1 > val2:
                score = 1
                break
            else:
                score = -1
                break
            
        # Check the remaining parts of the string
        while(i<len1):
            val1 = int(revisions1[i])
            if val1 > 0 and score >=0:
                score = 1
                break
            i += 1
        
        while(j<len2):
            val2 = int(revisions2[j])
            if val2 > 0 and score <=0:
                score = -1
                break
            j += 1
        
        return score