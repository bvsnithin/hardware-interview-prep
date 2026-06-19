"""
File to use: inventory.csv
Task: inventory.csv contains some invalid data (missing quantities/prices, and negative prices). Write a script that:
1. Reads the file and ignores any row that has a missing quantity, missing price, or a negative price.
2. For the valid rows, calculates the total inventory value (Quantity * Price).
3. Prints the total valuation of the store's inventory.
4. Writes the valid rows to a new file named cleaned_inventory.csv.
"""

import csv

try:
    with open('../practice_files/inventory.csv', 'r') as fp, \
         open('../practice_files/cleaned_inventory.csv','w', newline='') as new_fp:
        reader = csv.reader(fp)
        writer = csv.writer(new_fp)
        

except FileNotFoundError as e:
    print(f"Error: Could not find the file! Details: {e}")