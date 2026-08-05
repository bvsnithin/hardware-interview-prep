""" A comprehensive cheat sheet for python to refresh before interview (This file contains only datatypes and operators)"""
# This folder also contains files about OOP in python incase you want a quick refresher on OOP with python

# :::::::::: VARIABLES ::::::::::
# Just give a name to your variables and assign them directly. No fuss on datatypes are needed
name = "John Snow" # name now holds a string
x = 10 # x holds an int
x = "Houston" # The same x now points to a string, python automatically determines the variable's data type. This makes python a dynamically typed language

print(f"x = {x}, Type of x = {type(x)}")  # Prints: x = Houston, Type of x is <class 'str'>

# For the purpose of documentation we can indicate the data type with ":(colon)"
x: int = 25
name: str = "Aegon Targaryen"
flag: bool = True
# This does not enforce any data type. It's only for documentation or tooling purposes. 

print(f"x = {x}, Type of x = {type(x)}") # Prints: x = 25, Type of x is <class 'int'>


# :::::::::: TYPE CONVERSION ::::::::::
age = "20"
int_age = int(age)

price = 29
float_price = float(price) # 29.0
print(f"age = {age}, type = {type(age)} | int_age = {int_age}, type = {type(int_age)}")
print(f"price = {price}, type = {type(price)} | float_price = {float_price}, type = {type(float_price)}")

# :::::::::: ARITHMETIC OPERATIONS ::::::::::
a = 10
b = 3
print("Add = ", a+b)            # Add =  13

print("Sub = ", a-b)            # Sub =  7
print("Mul = ", a*b)            # Mul =  30
print("Div = ", a/b)            # Div =  3.3333333333333335
print("Floor Division = ",a//b) # Floor Division =  3
print("Exponent = ", b**a)        # Exponent = 59049 (3^10)

# Converting decimal to binary
bin_a = bin(10) # Use bin to get the boolean representation of a decimal number (integer)
print(f"a = {a}, binary a = {bin_a}, type of binary a = {type(bin_a)}") # bin converts int to str

# Bitwise operators
print("A and B = ", a & b) # a = 1010 b = 0011 a & b = 0010 (2)
print("A or B = ", a | b) # a = 1010 b = 0011 a | b = 1011 (11)
print("A xor B = ", a ^ b) # a = 1010 b = 0011 a ^ b = 1001 (9)