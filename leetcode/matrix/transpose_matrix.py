class Solution:
    def transpose(self, matrix: List[List[int]]) -> List[List[int]]:
        
        #Number of rows
        n_rows = len(matrix)

        #Number of cols
        n_cols = len(matrix[0])

        #Initialize a matrix with 0
        transpose_mat =[[0]*n_rows for _ in range(n_cols)]

        #for row in transpose_mat:
        #    print(row)

        for rows in range(n_cols):
            for cols in range(n_rows):
                transpose_mat[rows][cols] = matrix[cols][rows]
        return transpose_mat
