"""
File to use: students.csv
Task: Write a script that parses the student data and:
1. Prints the name and score of the student with the highest score.
2. Prints the name and score of the student with the lowest score.
3. Calculates the average score across all students.
4. Print in the following format

Highest Score: Diana Prince (95)
Lowest Score: Fiona Gallagher (67)
Average Score: 85.3
"""
import csv

try:
    with open('../practice_files/students.csv','r') as fp:
        reader = csv.reader(fp)
        header = next(reader)

        max_score = 0
        min_score = 100
        sum = 0
        num_records = 0 

        max_score_student=""
        min_score_student=""

        for lines in reader:
            score = int(lines[4])
            name = lines[0]
            if(max_score < score):
                max_score = score
                max_score_student = name
            
            if(min_score > score):
                min_score = score
                min_score_student = name

            sum = sum + score
            num_records = num_records+1
        
        avg = sum/num_records

        print(f"Highest Score: {max_score_student} ({max_score})")
        print(f"Lowest Score: {min_score_student} ({min_score})")
        print(f"Average Score: {avg:.2f}")

except FileNotFoundError as e:
    print(f"Error Occured, File not found! More details: {e}")