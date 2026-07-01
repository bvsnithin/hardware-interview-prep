class Solution:
    def maxProduct(self, words: List[str]) -> int:
        ans = 0
        bitmask = {}
        for s in words:
            mask = 0
            for c in s:
                ## ord(c) - ord('a') gives the position.  
                mask = mask | (1 << (ord(c)-ord('a')))
            bitmask[s] = mask

        for i in range(len(words)-1):
            for j in range(i,len(words)):
                mask_i = bitmask.get(words[i])
                mask_j = bitmask.get(words[j])
                if ((mask_i & mask_j) == 0):
                    ans = max(ans, len(words[i]) * len(words[j]))
        return ans