"""
This file contains the cheat sheet for lists in python along with other data structures commonly used in python
"""
# :::::::::::::::::::: LISTS ::::::::::::::::::::

# Lists in python are array datastructure can store a list of values of any data type
grocery = ["eggs", 10.0, "bread", 12]
print(type(grocery)) # Prints <class 'list'>

# Creating a list is simple, just name a variable and use square brackets []
nums = [1,2,3,4,5]

# Accessing list elements is done by indexing
num_1 = nums[0]
print(num_1) #Prints 1

nums_1_3 = nums[0:3]
print(nums_1_3) # [1,2,3]

reverse_nums = nums[::-1]
print(reverse_nums) # This will print the reversed list: 5,4,3,2,1

# Adding elements to list
nums.append(6) # append() will add the number to the end of the list
print(nums) # [1, 2, 3, 4, 5, 6]
nums.insert(6,7) # Insert adds an element at a particular index
print(nums) # [1, 2, 3, 4, 5, 6, 7]
nums.insert(-1, 8) # This adds "8" right before the last element in the list
print(nums) # [1, 2, 3, 4, 5, 6, 8, 7]

# Removing elements
print(nums.pop()) # Removes the last element and returns it as well
print(nums) # Prints: [1, 2, 3, 4, 5, 6, 8]

print(nums.pop(2)) # Removes and returns an element at an index 
print(nums) # [1, 2, 4, 5, 6, 8]

print(nums.remove(8)) # Removed the first occurance of "8" 

nums.clear()
print(nums) # Prints: Empty list []

nums = [12,54,3,-3,10]
nums.sort() # Sorting in ascending order
print(nums) # [-3, 3, 10, 12, 54]

nums.sort(reverse=True) # Sorting in descending order
print(nums) # [54, 12, 10, 3, -3]

nums.reverse() # Reverses list in place
print(nums) # [-3, 3, 10, 12, 54]

# List Comprehension
# Syntax destination_list = [var for var in source list condition]
evens = [x for x in range(0,50) if x%2 == 0]  # Creates a list of even number from 0 to 50 (50 is non inclusive)
print(evens) # [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48]

# List of square from 1 to 10
squares = [x**2 for x in range(1,11)]
print(squares) # [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

# Using list comprehension to create a list containting only words with more than 4 characters
words = ["cat", "apple", "banana", "dog", "elephant", "sun"]
words_4 = [word for word in words if len(word)>4]
print(words_4) # ['apple', 'banana', 'elephant']

# Using list comprehension to replace negative numbers with 0s
numbers = [-5,12,2,-9,0,-89,-11,22]
numbers = [0 if num <0 else num for num in numbers]
print(numbers) # [0, 12, 2, 0, 0, 0, 0, 22]

# :::::::::::::::::::: DICTIONARY ::::::::::::::::::::
# Dictionaries are key value pairs and are creted using curly brace {}
d = {}
d = {"name" : "Baron", "age" : 12}
print(d["age"]) # Prints 12. To access a value we can use [] square brackets or we can use get() method
print(d.get("age",0)) # 12, second argument is 0 if the key is not present in the dictionary
print(d.get("standard","Not listed")) # Prints Not Listed, because d only contains two keys

# Updating
d["age"] = 13
print(d["age"]) # 13