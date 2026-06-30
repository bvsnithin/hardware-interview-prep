"""
In Python classes, we have different types of methods and special "dunder" (double underscore) methods.

1. Instance Methods:
   - Take `self` as the first parameter.
   - Access and modify instance-specific data.

2. Class Methods (`@classmethod`):
   - Take `cls` (the class itself) as the first parameter.
   - Can access or modify class-level attributes.
   - Often used as "factory methods" (alternative constructors to create objects).

3. Static Methods (`@staticmethod`):
   - Do NOT take `self` or `cls` as the first parameter.
   - Behave like regular functions, but belong to the class's namespace.
   - Used for utility tasks that don't need class or instance data.

4. Dunder Methods (like `__str__`):
   - Special built-in methods with double underscores on both sides.
   - `__str__(self)` defines what happens when you print an object or convert it to a string.
"""

class Employee:
    # company_name is called the class attribute
    company_name = "Very Profitable Company"

    def __init__(self, name: str, salary: float):
        self.name = name
        self.salary = salary

    # 1. Dunder Method for string representation
    def __str__(self) -> str:
        return f"Employee: {self.name} (Salary: ${self.salary:,.2f})"

    # 2. Class Method: Factory to create an intern employee
    @classmethod
    def create_intern(cls, name: str) -> Employee:
        # Can access class attributes using cls.company_name
        print(f"Creating an intern for {cls.company_name}.")
        return cls(name, salary=30000.0) # Calls __init__ (cls is the Employee class)

    # 3. Static Method: A utility function that doesn't need 'self' or 'cls'
    @staticmethod
    def is_valid_salary(salary: float) -> bool:
        return salary >= 15000.0



if __name__ == "__main__":
    emp1 = Employee("Alice Keys", 85000.0)
    print(emp1) # Automatically calls __str__ dunder method 
    
    intern = Employee.create_intern("Intern Very Good")
    print(intern) # Automatically calls __str__ dunder method 

    print("Is $5,000 valid?", Employee.is_valid_salary(5000))
    print("Is $20,000 valid?", Employee.is_valid_salary(20000))
    print("-" * 40)


# =====================================================================
# 1. Create a class named 'Temperature'.
# 2. Implement `__init__` that takes `celsius` (float) and stores it as `self.celsius`.
# 3. Implement a `__str__` method so printing a Temperature object returns:
#    "<celsius>°C" (e.g. "25.0°C").
# 4. Implement a `@staticmethod` named `celsius_to_fahrenheit(celsius)` that takes a float
#    and returns the converted value: (celsius * 9/5) + 32.
# 5. Implement a `@classmethod` named `from_fahrenheit(cls, fahrenheit)` that takes a
#    fahrenheit value, converts it to celsius, and returns a new Temperature object!
#    Formula: celsius = (fahrenheit - 32) * 5/9
# =====================================================================


class Temperature:
    def __init__(self, celsius:float):
        self.celsius = celsius
    
    def __str__(self) -> str:
        return (f"{self.celsius}°C")

    @staticmethod
    def celsius_to_fahrenheit(celsius:float):
        return (celsius* 9/5) + 32

    @classmethod
    def from_fahrenheit(cls, fahrenheit:float):
        celsius = (fahrenheit - 32)* 5/9
        return cls(celsius)

if __name__ == "__main__":
    temp1 = Temperature(25.0)
    print("Temp 1:", temp1) # Should print: Temp 1: 25.0°C
    
    # Test static method
    f = Temperature.celsius_to_fahrenheit(0.0)
    print("0°C in Fahrenheit:", f) # Should print: 32.0
    
    # Test class method (factory)
    temp2 = Temperature.from_fahrenheit(104.0)
    print("Temp 2:", temp2) # Should print: Temp 2: 40.0°C
    pass
