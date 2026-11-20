# https://leetcode.com/problems/zigzag-conversion/

class Solution:
    def convert(self, s: str, numRows: int) -> str:
        if(numRows>=len(s) or numRows == 1):
            return s
        
        rows = [""]*numRows
        row = 0
        step = 1

        for i, char in enumerate(s):
            rows[row] = rows[row]+char
            if step == 1:
                row = row+1
            elif step == -1:
                row = row - 1

            if row >= (numRows):
                row = row - 2
                step = -1
            if row == 0:
                step = 1

        return ''.join(rows)
        