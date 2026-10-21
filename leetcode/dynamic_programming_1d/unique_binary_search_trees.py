# https://leetcode.com/problems/unique-binary-search-trees/

class Solution:
    def numTrees(self, n: int) -> int:
        """
        Let's look at some patterns
        For n = 3, possible node values are 1,2,3
        If root = 1:
            left nodes = 0 nodes, because there is no value less than 1 that goes to the left. So there is just 1 ways of arranging
            right nodes = 2 nodes (2 and 3). These 2 nodes can be arranged in 2 ways
            1st possible way: root(1) -> right node (3) -> left node (2)
            2nd possible way: root(1) -> right node (2) -> right node (3)
            Hence, if root node is 1, there are 2 ways of constructing 

        If root = 2:
            left node = 1, only 1 is less than 2
            right node = 3, only 3 is greater than 2
            Hence, only 1 ways of constructing
        
        If root = 3:
            Just like root = 1, there are 2 ways of constructing. 

        For n = 3, there are total 2+1+2 = 5 ways of building a BST
        For n = 2, there are 2 ways of building
        For n = 1, there is only 1 ways of building. 
        
        Let's use this and build BST for n = 4
        If root = 1: Left nodes = 0, Right nodes = 3 (5 possible ways of arranging) = 5 ways
        root = 2: Left Node = 1, Right nodes = 2(3 and 4 = 2 possible ways) = 2 ways
        root = 3: Left Nodes = 2 (1 and 2), Right nodes = 1(4) = 2 ways
        root = 4: Left Node = 3(1,2, and 3 = 5 possible ways), Right nodes = 0 = 5 way
        Total 5+2+2+5 ways of constructing BST for n = 4

        If f(n) = number of bsts possible for given n
        f(n) = sum(g(n)) for i = 1 to n
        g(n) = left_nodes * right_nodes for a node n

        For n = 3:
        f(n) = g(1) + g(2) + g(3)
        g(1) = left_nodes*right_nodes = 1*2 (1 ways of arranging left)*(2 ways of arranging right) = 2
        g(2) = 1*1 = 1
        g(3) = 2*1 = 2
        """

        # if n == 1 or n == 0:
        #     return 1

        # if n == 2:
        #     return 2
        
        # total = 0
        # for i in range(n,0,-1):
        #     num_left_nodes = i-1
        #     num_right_nodes = n-i
        #     total = total + self.numTrees(num_left_nodes) * self.numTrees(num_right_nodes)
        # return total

        # Above solution will give TLE because we are not storing the previous values and recalculating them again. Leading to a very long execution time

        # Below is the Dynamic Programming approach - iterative

        # Build an array of size n+1
        dp = []
        dp = [0] * (n+1)

        dp[0] = 1
        dp[1] = 1

        # dp[k] here represents the number of unique BSTs for a given k value
        # dp[1] is 1 because only 1 way of building that 1 node
        # dp[2] is 2 and dp[3] = 5.
        # This dp array helps us build a memory and remember the previous values so we don't have to recalculate like we did previously

        for nodes in range(2, n+1):
            for root in range(1, nodes+1):
                num_left_nodes = root - 1
                num_right_nodes = nodes - root
                dp[nodes] = dp[nodes] + (dp[num_left_nodes] * dp[num_right_nodes])
        
        return dp[n]

        """
        for n = 2

        nodes = 2
        root = 1: num_left_nodes = 0, num_right_nodes = 1 dp[2] = 0+(1*1) = 1
        root = 2: num_left_nodes = 1, num_right_nodes = 0 dp[2] = 1+(1*1) = 2

        for n = 3
        nodes = 2 dp[2] = 2
        nodes = 3
        root = 1: num_left_nodes = 0, num_right_nodes = 2 dp[3] = 0+(1*2) = 2
        root = 2: num_left_nodes = 1, num_right_nodes = 1 dp[3] = 2+(1*1) = 3
        root = 3: num_left_nodes = 2, num_right_nodes = 0 dp[3] = 3+(2*1) = 5
        """
        
        