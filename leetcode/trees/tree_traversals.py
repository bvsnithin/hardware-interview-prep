"""
A Tree is a Data structure that is similar to a linked list. 
But instead of each node pointing simply to the next node, each node points to a number of nodes. 
Hence, trees are called as non-linear data structures. Whereas, linked lists and arrays are linear data strcutures. 

Unlike arrays or linked lists, trees don't necessarily have a single linear ordering of elements. 
The ordering depends on the type of tree and how we traverse it.
If we need ordering, we can linear data structures such as stacks, queues, linked lists, or arrays

There are 2 broad ways ways of moving through the trees. 
1) DFS - Depth First Search (Think depth)
2) BFS - Breadth First Search (Think level by level)

DFS:
1) Pre-Order Traversal
2) In-Order Traversal
3) Post-Order Traversal

BFS:
Level-Order Traversal
----------------------------------------------------------------------------------------------------
DFS - Think of this as going as deep as possible in the tree before coming back 
In our tree above, using DFS - we start at 1, go to 2, then 4 and etc. 

There are 3 ways to order our nodes in DFS. 

1) Pre-Order Traversal
The order of travel is Root Node -> Left -> Right
Visit the root node first, then all the nodes in the left and then the nodes in the right

Pre-Order Traversal for the tree: 1 -> 2 -> 4 -> 5 -> 3 -> 6

-------------------------------------------------------------------------------------------

2) In-Order Traversal 
Visit the left nodes first, then the root node, and finally the right node
Order of travel is Left -> Root -> Right

In-Order Traversal for the tree : 4 -> 2 -> 5 -> 1 -> 3 -> 6

-------------------------------------------------------------------------------------------

3) Post-Order Traversal
Visit the left nodes
Then the right nodes
Then finally the root

Post-Order Traversal for the tree: 4 -> 5 -> 2 -> 6 -> 3 -> 1
"""

class Node:

    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None
        print("Created a node")

    #     1
    #    / \
    #   2   3
    #  / \   \
    # 4   5   6

    def preOrderTraversal(self, node):
        if node is None:
            return 
        
        print(node.value)
        self.preOrderTraversal(node.left)
        self.preOrderTraversal(node.right)

    def inOrderTraversal(self, node):
        if node is None:
            return

        self.inOrderTraversal(node.left)
        print(node.value)
        self.inOrderTraversal(node.right)
    
    def postOrderTraversal(self, node):
        if node is None:
            return
        
        self.postOrderTraversal(node.left)
        self.postOrderTraversal(node.right)
        print(node.value)

root = Node(1)

root.left = Node(2)
root.right = Node(3)

root.left.left = Node(4)
root.left.right = Node(5)

root.right.right = Node(6)

print("Pre-Order Traversal")
root.preOrderTraversal(root)
print("In-Order Traversal")
root.inOrderTraversal(root)
print("Post-Order Traversal")
root.postOrderTraversal(root)
