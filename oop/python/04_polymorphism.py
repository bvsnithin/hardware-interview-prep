"""
Polymorphism (from Greek meaning "many forms" Poly = Many, Morph = Form/Shape) is the ability in OOP to present 
the same interface for differing underlying data types. 

Key Concepts:
1. Method Overriding Polymorphism: Different child classes implementing the same parent method in their own way.
2. Duck Typing: In Python, "if it walks like a duck and quacks like a duck, it's a duck." 
   Python doesn't enforce strict types for polymorphism. If an object has a method named `fly()`, 
   you can call `obj.fly()` regardless of its actual class.
3. Special Dunder Methods for Operator Overloading: Overloading operators like `+` (`__add__`), 
   `==` (`__eq__`), and `<` (`__lt__`) to define how operators behave with your custom objects.
"""

# Example 1: Polymorphism using Duck Typing
class Dog:
    def make_sound(self) -> str:
        return "Woof!"

class Cat:
    def make_sound(self) -> str:
        return "Meow!"

class Robot:
    def make_sound(self) -> str:
        return "Beep Boop!"

# This function takes any object that has a 'make_sound' method (Duck Typing!)
# We can call this method on any object as long as the method "make_sound"is defined on the object
def introduce_sound(animal_like_obj):
    print(f"The object says: {animal_like_obj.make_sound()}")


# Example 2: Operator Overloading using Dunder Methods
class Item:
    def __init__(self, name: str, price: float):
        self.name = name
        self.price = price

    # Overloading the addition (+) operator
    def __add__(self, other: 'Item') -> float:
        # What happens when we do item1 + item2
        return self.price + other.price

    # Overloading the equality (==) operator
    def __eq__(self, other: object) -> bool:
        if not isinstance(other, Item):
            return False
        return self.price == other.price


if __name__ == "__main__":
    print("--- Duck Typing Polymorphism ---")
    introduce_sound(Dog())
    introduce_sound(Cat())
    introduce_sound(Robot())  # Works even though Robot is not an animal!
    
    print("\n--- Operator Overloading ---")
    item1 = Item("Keyboard", 45.0)
    item2 = Item("Mouse", 25.0)
    item3 = Item("Budget Headset", 45.0)

    # Calling the overloaded '+' operator (calls item1.__add__(item2))
    total = item1 + item2
    print(f"Total price: ${total:.2f}")

    # Calling the overloaded '==' operator (calls item1.__eq__(item3))
    print(f"Are item1 and item3 equal in price? {item1 == item3}")
    print("-" * 40)


# =====================================================================
# 1. Create a class named 'Currency'.
# 2. Implement `__init__` that takes `amount` (float) and `code` (str, e.g. "USD").
# 3. Implement the `__str__` dunder method to return: "<amount> <code >" (e.g., "50.0 USD").
# 4. Implement the `__add__` operator overloading.
#    - If two Currency objects have the SAME code, return a NEW Currency object with their combined amount.
#    - If they have DIFFERENT codes, raise a `ValueError` with a helpful message: "Cannot add different currencies".
# =====================================================================

class Currency:
    def __init__(self, amount:float, code:str):
        self.amount = amount
        self.code = code

    #Dunder methods needs self
    #Remember class methods need cls and instance methods need self but static methods don't need cls or self
    def __str__(self):
        return f"{self.amount} {self.code}"

    def __add__(self, no):
        if self.code == no.code:
            return Currency(self.amount + no.amount, self.code)
        else:
            raise ValueError("Cannot add different currencies")

if __name__ == "__main__":
    c1 = Currency(100.0, "USD")
    c2 = Currency(50.0, "USD")
    c3 = Currency(30.0, "EUR")

    print("c1 + c2 =", c1 + c2) # Should print: c1 + c2 = 150.0 USD

    try:
        print("c1 + c3 =", c1 + c3) # Should raise ValueError
    except ValueError as e:
        print("Caught expected error:", e)
