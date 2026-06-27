class Solution:
    def spiralOrder(self, matrix: List[List[int]]) -> List[int]:
        left = 0
        right = len(matrix[0])
        top = 0
        bottom = len(matrix)

        # To store the result
        res = []

        while(top<bottom and left<right):
            #Traverse the top row 
            for i in range(left,right):
                print(f"left to right: {top},{i}")
                res.append(matrix[top][i])
            top = top + 1
            print("top: ",top)

            #Traverse the rightmost column top to bottom
            for i in range(top,bottom):
                print(f"top to bottom: {i},{right-1}")
                res.append(matrix[i][right-1])
            right = right - 1
            print("right: ",right)

            if not (left < right and top < bottom):
                break

            #Traverse the bottom most row from right to left
            for i in range(right-1,left-1,-1):
                print(f"right to left: {bottom-1},{i}")
                res.append(matrix[bottom-1][i])
            bottom = bottom - 1
            print(f"bottom: {bottom}")

            #Traverse the left most row from bottom to top
            for i in range(bottom-1,top-1,-1):
                print(f"bottom to top: {i},{left}")
                res.append(matrix[i][left])
            left = left+1
            print(f"left: {left}")

        return res
            