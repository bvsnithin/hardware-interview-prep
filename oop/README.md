# Object-Oriented Programming (OOP) for Hardware Engineers
---

## Directory Structure

```
oop/
├── python/                  # Python OOP curriculum, cheat sheets & cache policies (11 files)
├── sv/                      # SystemVerilog OOP mechanisms (2 files)
└── cpp/                     # C++ OOP implementations (1 file) (nothing here yet)
```

---

## 1. Python OOP & Hardware Data Structures ([python/](python/))

A structured 5-part OOP curriculum, interview cheat sheets, and algorithmic problem solving:

| File | Topic & Key Concepts |
| :--- | :--- |
| [python/01_classes_objects.py](python/01_classes_objects.py) | **Classes & Objects**: Blueprint concept, instance variables vs. class variables, constructor (`__init__`), instance instantiation, `self` reference mechanics. |
| [python/02_class_methods.py](python/02_class_methods.py) | **Method Types & Dunder Methods**: Instance methods, class methods (`@classmethod`), static methods (`@staticmethod`), and operator overloading / magic methods (`__str__`, `__repr__`, `__len__`, `__eq__`). |
| [python/03_inheritance.py](python/03_inheritance.py) | **Inheritance & Method Overriding**: Single, multiple, and multi-level inheritance; using `super()` to invoke parent constructors; Method Resolution Order (MRO). |
| [python/04_polymorphism.py](python/04_polymorphism.py) | **Polymorphism**: Duck typing in Python, method overriding across derived classes, polymorphic function dispatch on collections of objects. |
| [python/05_abstraction.py](python/05_abstraction.py) | **Abstraction & Interfaces**: Using Python's Abstract Base Classes (`abc.ABC` and `@abstractmethod`) to define strict component interfaces. |
| [python/replacement_policies/lru_cache.py](python/replacement_policies/lru_cache.py) | **LRU Cache Replacement Policy**: Implements an $O(1)$ Least Recently Used (LRU) cache using a hash map combined with a doubly linked list (equivalent to `collections.OrderedDict`). Fundamental for CPU cache and TLB architecture interviews. |
| [python/hackerrank_dealing_with_complex_numbers.py](python/hackerrank_dealing_with_complex_numbers.py) | Implementation of a `Complex` number class with custom operator overloading for addition, subtraction, multiplication, division, and modulus. |
| [python/hackerrank_torsional_angle.py](python/hackerrank_torsional_angle.py) | 3D Vector geometry class computing dot products, cross products, and torsional angles between planes. |
| [python/python_cheat_sheet_1.py](python/python_cheat_sheet_1.py) | Pre-interview quick reference: Core Python data types, integers, floats, booleans, type conversions, and truthiness. |
| [python/python_cheat_sheet_2.py](python/python_cheat_sheet_2.py) | Pre-interview quick reference: Python string manipulation, slicing, methods (`split`, `join`, `strip`, `find`), formatting, and regex basics. |
| [python/python_cheat_sheet_3.py](python/python_cheat_sheet_3.py) | Pre-interview quick reference: Python lists, sets, tuples, dictionaries, list comprehensions, sorting, and lambda functions. |