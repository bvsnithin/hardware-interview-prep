"""
In this file we will look at how to traverse a tree using Breadth First Search

BFS is also know as level order traversal because we go level by level in the tree. 

To perform BFS, we use a FIFO data structure like a queue. 

The idea is to add children of current node to the queue and visit them one after the other and add their children to the queue
Keep repeating this until the queue is empty
"""

from collections import deque

class Node:

    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

    def bfs(self, root:Node):
        queue = deque([root])

        while queue:
        
            node = queue.popleft()

            print(node.value)

            if node.left:
                queue.append(node.left)
        
            if node.right:
                queue.append(node.right)

    
    #     1
    #    / \
    #   2   3
    #  / \   \
    # 4   5   6

root = Node(1)

root.left = Node(2)
root.right = Node(3)

root.left.left = Node(4)
root.left.right = Node(5)

root.right.right = Node(6)

root.bfs(root)
        
root = Node(10)
root.left = Node(20)
root.right = Node(30)
root.left.left = Node(40)
root.left.right = Node(45)
root.left.left.right = Node(50)
root.left.left.left = Node(60)

root.bfs(root)
        