# Given a list of strings, remove all anagrams and sort in alphabetical order.
from typing import List


test_cases = [
    # 6 strings
    ["listen", "silent", "enlist", "apple", "banana", "orange"],

    # 7 strings
    ["evil", "vile", "veil", "live", "chair", "table", "mouse"],

    # 8 strings
    ["dusty", "study", "night", "thing", "river", "cloud", "stone", "grape"],

    # 9 strings
    ["angel", "glean", "angle", "cinema", "iceman", "anemic", "phone", "laptop", "bottle"],

    # 10 strings
    ["stare", "tears", "rates", "aster", "save", "vase", "rocket", "planet", "window", "garden"],

    # 11 strings
    ["earth", "heart", "hater", "below", "elbow", "care", "race", "acre", "pizza", "coffee", "school"],

    # 12 strings
    ["secure", "rescue", "recuse", "alert", "alter", "later", "artel", "ratel", "music", "camera", "bridge", "forest"],

    # 13 strings
    ["cheaters", "hectares", "teachers", "fired", "fried", "inch", "chin", "market", "purple", "yellow", "guitar", "basket", "cookie"],

    # 14 strings
    ["state", "taste", "pat", "tap", "apt", "bored", "robed", "finder", "planet", "candle", "mirror", "button", "dragon", "flower"],

    # 15 strings
    ["listen", "silent", "enlist", "tinsel", "inlets",
     "evil", "vile", "veil", "live",
     "apple", "banana", "orange", "garden", "school", "rocket"]
]


# #Aanagrams - Words that have same list of characters and also their counts. 
# def check_anagram(a:str, b:str):
#     n_a = len(a)
#     n_b = len(b)

#     map_a = {}
#     map_b = {}

#     if(n_a != n_b):
#         return False
#     else:
#         for char in a:
#             map_a[char] = map_a.get(char,0)+1
        
#         for char in b:
#             map_b[char] = map_b.get(char,0)+1
        
#         for c in map_a:
#             if(map_a[c] != map_b.get(c,0)):
#                 return False
        
#     return True


# print(check_anagram("state","taste"))

# def traverse_list(test_cases:List[str]):
#     for case in test_cases:
#         result = []

#         for word in case:
#             is_anagram = False

#             for saved_word in result:
#                 if(check_anagram(word,saved_word)):
#                     is_anagram = True
#                     break

#             if is_anagram == False:
#                 result.append(word)

#         result.sort()
#         print(result)


# traverse_list(test_cases)


def remove_anagrams(test_cases:List[str]):
    for case in test_cases:
        seen = set()
        result = []  #Store final result of non anagram and sorted list
        for word in case:
            sorted_list = sorted(word)          # sorted(str) returns a list that is sorted
            sorted_str = ''.join(sorted_list) 
            if sorted_str not in seen:
                seen.add(sorted_str)
                result.append(word)

        result.sort()
        print(result)

 
remove_anagrams(test_cases)
