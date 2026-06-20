"""
File to use: students.csv
Task: Write a script that parses the student data and:
1. Reads all student records from students.csv.
2. Sorts the students based on their "Score" in descending order (highest score first).
3. If two students have the same score, sort them alphabetically by their "Name".
4. Prints the sorted names and scores to the console.
"""
import csv
try:
    with open('../practice_files/students.csv','r') as fp:
        reader = csv.reader(fp)
        header = next(reader)
        students_data = []
        for data in reader:
            students_data.append(data)
        students_data.sort(key = lambda x: (-1*int(x[4]), x[0]))  #For multiple sorting criteria, return a tuple
        for data in students_data:
            print(data)

except FileNotFoundError as e:
    print(f"File not found error: {e}")
