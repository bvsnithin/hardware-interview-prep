"""
Trie Data Structure - It is also called as prefix-tree. It is a tree like data structure that is used to store strings 
and effeciently perform operations such as search, insert and delete. 

It is useful when many strings share common prefix. 

Example - "trie" will store words like "tree", "trie", "trip" efficiently by sharing common prefix "tr".

Those 3 words would be stored in the tree like data structure as:

    t
    └── r
        ├── e
        │   └── e
        └── i
            ├── e
            └── p

"""

# This is a node in the Trie data structure. It represents a single character and its children nodes.
class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end_of_word = False # Indicates if the node represents the end of a word

class Trie:
    def __init__(self):
        self.root = TrieNode() # Root node of the Trie

    def insert(self, word):
        """
        Inserts a word into the Trie.

        Args:
            word (str): The word that is to be inserted in the Trie.

        Dry Run Example of adding "tree" to an empty Trie
            node: The current node in the Trie while inserting the word. Initially, it is the root node and also has no children.
            char: The current character in the word being inserted.

            char = 't': Add this character as a child to the root node. Move the node pointer to 't'
            char = 'r': Add this character as a child to 't'. Move the node pointer to 'r'
            char = 'e': Add this character as a child to 'r'. Move the node pointer to 'e'
            char = 'e': Add this character as a child to 'e'. Move the node pointer to 'e'
            Now node points to the last 'e' node which represents the end of the word "tree". Set is_end_of_word to True.
        
        Dry Run Example of adding "trip" to the Trie that already contains "tree"
            char = 't': 't' already exists as a child of the root node. Move the node pointer to 't'
            char = 'r': 'r' already exists as a child of 't'. Move the node pointer to 'r'
            char = 'i': Add this character as a child to 'r'. Move the node pointer to 'i'
            char = 'p': Add this character as a child to 'i'. Move the node pointer to 'p'
            Now node points to the 'p' node which represents the end of the word "trip". Set is_end_of_word to True.
        """

        # Get the root node of the Trie
        node = self.root
        # Traverse through each character in the word and add it to the Trie if it doesn't exist already
        for char in word:
            if char not in node.children:
                # Create a new Node here with the current character
                node.children[char] = TrieNode()
            # Now we move to the child node
            node = node.children[char]
        # Mark the end of the word
        node.is_end_of_word = True

    def search(self, word) -> bool:
        """
        Searches for a word in the Trie.

        Args:
            word (str): The word to search for in the Trie.

        Returns:
            bool: True if the word exists in the Trie, False otherwise.
        """

        node = self.root
        for char in word:
            if char not in node.children:
                return False
            node = node.children[char]
        return node.is_end_of_word # We check this because the word might be a prefix of another word but not a complete word itself.
    

if __name__ == "__main__":
    trie = Trie()
    trie.insert("tree")
    trie.insert("trip") 
    print(trie.search("tree"))  # Expected output: True
    print(trie.search("trip"))  # Expected output: True
    print(trie.search("trie"))  # Expected output: False
    print(trie.search("tri"))   # Expected output: False
    print(trie.search("tr"))    # Expected output: False



