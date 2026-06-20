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
        writer.writerow(next(reader))
        total_inventory_value = 0
        for lines in reader:
            if(lines[2]=='' or lines[3]==''):
                continue
            quantity = float(lines[2])
            price = float(lines[3])

            if(price >= 0):
                total_inventory_value = total_inventory_value + (quantity*price)
                writer.writerow(lines)

        print(f"Total Inventory value: {total_inventory_value:.2f}")
except FileNotFoundError as e:
    print(f"Error: Could not find the file! Details: {e}")