"""
This file is a comprehensive cheat sheet on strings in python
"""

# :::::::::: STRING BASICS ::::::::::
# String in python are immutable. That means, once a memory is allocated for a string, we cannot modify the string in place
# Any modifications will allocate a new memory space for the updated string
# Example: 
# name = "Jon Snow" => If we want to edit Jon to John => name = "John Snow" => This does not edit in the memory, rather creates a new string and moves pointer to the new string memory location

# Let's see this in action: Allocate initial string
name = "Jon Snow"
print(f"Original String: {name}")
print(f"Memory Address: {id(name)}")   #id(variable) gives the memory address

# Let's modify the string
name = "John Snow"
print(f"Updated String: {name}")
print(f"Memory Address: {id(name)}")

# We can access characters by indexing 
print("First character: ",name[0]) # Prints: First character: J
# Negative indexing for accessing characters from the end of the string
print("Last character: ", name[-1]) # Prints: Last character: w

# Index slicing to access a substring in the string
# Syntax: string[start:stop:step] 

print(name[0:3]) #Joh
print(name[1:])  #ohn Snow
print(name[:5])  #John 
print(name[::2]) #Prints every second character: Jh nw

print(name[::-1]) #Prints in reverse; wonS nhoJ

# String Repetition
print("Hi " * 3) # Hi Hi Hi 

# membership operators - in and not in
print("Snow" in name) # True because Snow occurs in the name
print("Jon" not in name) # True ecause Jon is not present in John Snow

# :::::::::::::: USEFUL STRING FUNCTIONS TO BE AWARE OF ::::::::::::::

# Use strip() to remove whitespaces from the string. Useful in file processing of outputs
log = "    Date: 07-04-2023    "
white_space_remove_log = log.strip()
print(white_space_remove_log)

left_white_space_removed = log.lstrip()
print(left_white_space_removed)

right_white_spaced_removed = log.rstrip()
print(right_white_spaced_removed)


