"""

What is a class?
In Object-Oriented Programming (OOP), a 'Class' is a blueprint or template for creating objects.
What is an Object?
An 'Object' is an instance of a class.

Important Syntax:
1. Class Definition: `class ClassName:`
2. The Constructor: `__init__(self, ...)` is called automatically when a new object is created.
3. `self`: Represents the specific instance of the class you are working with (Similar to this in java/c++).
4. Attributes: Variables inside a class that hold data.
5. Methods: Functions defined inside a class that describe the behaviors of the object.
"""

# Example: A simple class representing a Book
class Book:
    #This becomes a static variable and all the objects will have the same publisher name. 
    publisher = "Good Books Only"
    def __init__(self, title: str, author: str, pages: int):
        self.title = title       # Instance attribute
        self.author = author     # Instance attribute
        self.pages = pages       # Instance attribute

    #When we are defining a method, we must put self as the first parameter
    def get_description(self) -> str:
        # Instance method
        return f"'{self.title}' by {self.author} ({self.pages} pages)"


# Create an object by called the ClassName
book1 = Book("To Kill a Mockingbird", "Harper Lee", 281)
print("Example Book 1:")
print("Publisher Name: ", book1.publisher) # Accesses class attribute

# This does NOT change the class attribute. It creates a NEW instance attribute 
# on book1 that "shadows" (hides) the class attribute for book1 only!
book1.publisher = "Sometimes Good Sometimes Bad Books"
print("Book 1 Publisher (shadowed):", book1.publisher)
print("Book Class Publisher:", Book.publisher) 

book2 = Book("Making Money is not Easy!", "Luiz Benoli", 211)
print("\nSecond Example Book (Book 2):")
print("Book 2 Publisher (still fallback to Class attribute):", book2.publisher)

# To change the class attribute for ALL instances, we must modify it on the CLASS itself:
Book.publisher = "Universal Books Publishing"
print("\n--- After changing Book.publisher directly ---")
print("Book 1 Publisher (still has its own instance attribute):", book1.publisher)
print("Book 2 Publisher (now falls back to the updated class attribute):", book2.publisher)
print("-"*40)

# =====================================================================
# Practice:
# 1. Create a class named 'SmartDevice' that represents a smart home device.
# 2. In the `__init__` constructor, initialize:
#    - `name` (str)
#    - `status` (bool, representing whether it is ON (True) or OFF (False))
# 3. Add a method `toggle()` that switches status from True to False, or False to True.
# 4. Add a method `get_status_message()` that returns:
#    - "SmartDevice <name> is ON" if status is True
#    - "SmartDevice <name> is OFF" if status is False
# =====================================================================

class SmartDevice:
    # We can provide a default value (e.g. status: bool = False)
    # If the caller doesn't provide status, it defaults to False!
    def __init__(self, name: str, status: bool = False):
        self.name = name
        self.status = status

    def toggle(self):
        self.status = not self.status

    def get_status_message(self) -> str:
        if self.status:
            return f"SmartDevice {self.name} is ON"
        else:
            return f"SmartDevice {self.name} is OFF"

if __name__ == "__main__":
    tv = SmartDevice("Living Room TV", False)
    print(tv.get_status_message()) 
    tv.toggle()
    print(tv.get_status_message())

    print("-" * 40)

    light = SmartDevice("Kitchen Light")
    print(light.get_status_message()) 
