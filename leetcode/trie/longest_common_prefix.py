# https://leetcode.com/problems/longest-common-prefix/

class Trie:
    def __init__(self):
        self.children = {} # The root of the trie
    
    def insert(self, word:str):
        node = self.children # This is a dict that holds all the children of the root 
        for char in word:
            if not char in node: # Create a new node at that level
                node[char] = {}
            node = node[char] # If the char exists at that level, move to the nexr level in trie
        node['#'] = '' # To indicate the end of the word
    
    def common_prefix(self) -> str:
        prefix = ""
        node = self.children
        while len(node) == 1 and '#' not in node:
            # Retrive the key of this node
            keys = node.keys()
            keys_list = list(keys) # Convert to list
            char = keys_list[0]
            prefix = prefix + char
            node = node[char]
        return prefix
    
class Solution:
    def longestCommonPrefix(self, strs: list[str]) -> str:
        # Using a trie
        trie = Trie()
        for string in strs:
            trie.insert(string)
        
        print(trie.children)
        return trie.common_prefix()

        