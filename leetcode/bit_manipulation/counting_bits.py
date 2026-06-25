class Solution:
    def countBits(self, n: int) -> List[int]:
        out = []
        for i in range(n+1):
            count = 0
            num = i
            while(num>0):
                count = count + (num&1)
                num = num >> 1
            out.append(count)
        return out
        