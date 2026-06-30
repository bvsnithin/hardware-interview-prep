"""
Inheritance and Method Overriding

Inheritance allows a new class (Child/Subclass) to inherit attributes and methods 
from an existing class (Parent/Superclass).

Key Concepts:
1. Syntax: `class ChildClass(ParentClass):` In other languages extends keywords is used. In python, we pass the parent class name in the parantheses
2. `super()`: A built-in function used to call methods of the parent class (most commonly `super().__init__(...)`).
3. Method Overriding: When a child class provides a specific implementation of a method that is already defined in its parent class.
"""

# Parent Class
class Vehicle:
    def __init__(self, brand: str, model: str):
        self.brand = brand
        self.model = model

    def start_engine(self) -> str:
        return f"The engine of the {self.brand} {self.model} is starting..."

    def get_info(self) -> str:
        return f"{self.brand} {self.model}"


# Car Inherits from Vehicle
class Car(Vehicle):
    def __init__(self, brand: str, model: str, num_doors: int):
        # Call the parent class's constructor to initialize brand and model
        super().__init__(brand, model)
        # Initialize child-specific attribute
        self.num_doors = num_doors

    # Method Overriding overrides the get_info method from Vehicle
    def get_info(self) -> str:
        # We can call the parent's get_info() using super() and append to it
        parent_info = super().get_info()
        return f"Car: {parent_info} with {self.num_doors} doors"


# Electric Car Inherits from Vehicle
class ElectricCar(Car): # Inheriting from Car (Multi-level inheritance)
    def __init__(self, brand: str, model: str, num_doors: int, battery_capacity: int):
        super().__init__(brand, model, num_doors)
        self.battery_capacity = battery_capacity

    # Method Overriding
    def start_engine(self) -> str:
        return f"The {self.brand} {self.model} hums silently to life. (Electric)"


if __name__ == "__main__":
    print("--- Vehicle Testing ---")
    my_vehicle = Vehicle("Generic", "Truck")
    print(my_vehicle.start_engine())
    print(my_vehicle.get_info())

    print("\n--- Car Testing ---")
    my_car = Car("Toyota", "Camry", 4)
    print(my_car.start_engine()) # Inherited directly from Vehicle
    print(my_car.get_info())     # Overridden in Car

    print("\n--- ElectricCar Testing ---")
    my_ev = ElectricCar("Tesla", "Model S", 4, 100)
    print(my_ev.start_engine()) # Overridden in ElectricCar
    print(my_ev.get_info())     # Inherited from Car
    print("-" * 40)


# =====================================================================
# 1. Create a parent class named 'Employee'.
#    - `__init__` takes `name` (str) and `base_salary` (float).
#    - Method `calculate_pay(self)` returns `base_salary`.
# 2. Create a child class named 'Manager' that inherits from 'Employee'.
#    - `__init__` takes `name`, `base_salary`, and `bonus` (float). Remember to use `super()`.
#    - Overrides `calculate_pay(self)` to return `base_salary + bonus`.
# 3. Create another child class named 'Developer' that inherits from 'Employee'.
#    - `__init__` takes `name`, `base_salary`, and `programming_language` (str).
#    - Overrides `calculate_pay(self)` to return the `base_salary` plus an additional fixed $500 language bonus.
# =====================================================================

class Employee:
    def __init__(self, name:str, base_salary:float):
        self.name = name
        self.base_salary = base_salary

    def calculate_pay(self) -> float:
        return self.base_salary

class Manager(Employee):
    def __init__(self, name:str, base_salary:float, bonus:float):
        super().__init__(name,base_salary)
        self.bonus = bonus
    
    def calculate_pay(self) -> float:
        return self.base_salary+self.bonus

class Developer(Employee):
    def __init__(self, name: str, base_salary: float, programming_language:str):
        super().__init__(name,base_salary)
        self.programming_langauge = programming_language

    def calculate_pay(self) -> float:
        return self.base_salary +  500.0


if __name__ == "__main__":
    mgr = Manager("Alice", 80000.0, 15000.0)
    dev = Developer("Bob", 70000.0, "Python")
    
    print(f"Manager {mgr.name} pay: ${mgr.calculate_pay():,.2f}")
    print(f"Developer {dev.name} pay: ${dev.calculate_pay():,.2f}") 
