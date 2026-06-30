"""
Abstraction is the concept of hiding complex implementation details and showing only the 
essential features of the object. It serves as a strict "contract" or template for other classes.

Key Concepts:
1. `ABC` Class: Inheriting from `abc.ABC` marks a class as an Abstract Base Class.
2. `@abstractmethod`: Decorator used to declare abstract methods. 
   - Abstract methods have no implementation in the base class (or just `pass`).
   - Any subclass *must* implement all abstract methods to be instantiated.
3. Non-instantiability: You cannot create an object directly from an Abstract Base Class.
"""

from abc import ABC, abstractmethod

# Abstract Base Class representing a PaymentProcessor. Abstract class should inherit the ABC class
class PaymentProcessor(ABC):
    
    @abstractmethod
    def process_payment(self, amount: float) -> str:
        """Process a payment for the given amount. Must be overridden by subclasses."""
        pass

    @abstractmethod
    def refund_payment(self, transaction_id: str) -> str:
        """Refund a transaction. Must be overridden by subclasses."""
        pass

    # Abstract classes can also have normal (concrete) methods!
    def print_receipt(self, amount: float) -> None:
        print(f"Receipt: Paid ${amount:.2f} using payment processor.")


# Subclass 1: Stripe Payment Processor
class StripeProcessor(PaymentProcessor):
    def process_payment(self, amount: float) -> str:
        return f"Stripe processed payment of ${amount:.2f} successfully."

    def refund_payment(self, transaction_id: str) -> str:
        return f"Stripe refunded transaction {transaction_id}."


# Subclass 2: PayPal Payment Processor
class PayPalProcessor(PaymentProcessor):
    def process_payment(self, amount: float) -> str:
        return f"PayPal processed payment of ${amount:.2f} successfully."

    def refund_payment(self, transaction_id: str) -> str:
        return f"PayPal refunded transaction {transaction_id}."


if __name__ == "__main__":
    print("--- Abstraction Testing ---")
    
    try:
        processor = PaymentProcessor()
    except TypeError as e:
        print("Caught expected error (cannot instantiate abstract class):")
        print(e)
        
    print("\n--- Stripe Implementation ---")
    stripe = StripeProcessor()
    print(stripe.process_payment(150.00))
    stripe.print_receipt(150.00) 

    print("\n--- PayPal Implementation ---")
    paypal = PayPalProcessor()
    print(paypal.process_payment(75.50))
    print(paypal.refund_payment("TXN_12345"))
    print("-" * 40)


# =====================================================================
# 1. Create an Abstract Base Class named 'Shape' (inherits from ABC).
# 2. Declare two abstract methods on 'Shape':
#    - `area(self) -> float`
#    - `perimeter(self) -> float`
# 3. Create a subclass named 'Rectangle' that inherits from 'Shape':
#    - `__init__` takes `width` and `height`.
#    - Implement both `area()` and `perimeter()` methods.
# 4. Create a subclass named 'Circle' that inherits from 'Shape':
#    - `__init__` takes `radius`.
#    - Implement both `area()` and `perimeter()` methods. (Use math.pi for calculations).
# =====================================================================
import math

class Shape(ABC):

    @abstractmethod
    def area(self) -> float:
        """
        Returns the area of the shape
        """
        pass

    @abstractmethod
    def perimeter(self)-> float:
        """
        Returns the perimeter of the shape
        """
        pass

class Rectangle(Shape):
    def __init__(self, width, height):
        self.width = width
        self.height = height 

    def perimeter(self) -> float:
        return 2 *(self.width + self.height)

    def area(self) -> float:
        return self.height * self.width

class Circle(Shape):
    def __init__(self, radius):
        self.radius = radius

    def area(self)->float:
        return 3.14 * self.radius * self.radius

    def perimeter(self) -> float:
        return 2*3.14*self.radius


if __name__ == "__main__":
    rect = Rectangle(10, 5)
    circ = Circle(3)
    
    print(f"Rectangle Area: {rect.area()}, Perimeter: {rect.perimeter()}") # Area: 50, Perimeter: 30
    print(f"Circle Area: {circ.area():.2f}, Perimeter: {circ.perimeter():.2f}") # Area: 28.27, Perimeter: 18.85

