"""
File to use: inventory.csv
Task: Write a script that parses the inventory data and:
1. Reads inventory.csv and cleans the data (ignoring rows with missing quantities, missing prices, or negative prices).
2. Sorts the valid items alphabetically by their "item_name".
3. Writes the cleaned and sorted inventory records to a new file named sorted_inventory.csv (with headers included).
"""
import csv
try:
    valid_rows = [] #Store valid rows here
    with open('../practice_files/inventory.csv','r') as fp, \
         open('../practice_files/sorted_inventory.csv','w',newline='') as new_fp:
        reader = csv.reader(fp)
        writer = csv.writer(new_fp)
        header = next(reader) #Save the header

        for row in reader:
            item_id,item_name,quantity,price,category = row
            if(quantity!='' and price!=''):
                int_price = float(price)
                if(int_price>=0):
                    valid_rows.append(row)
        
        writer.writerow(header) #Write the header saved previously to the new file.
        valid_rows.sort(key = lambda x: x[1].lower())
        for items in valid_rows:
            writer.writerow(items)
        

except FileNotFoundError as e:
    print(f"File not found error! Check details: {e}")