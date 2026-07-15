"""
File to use:  notes.txt
Task: Write a script that reads the plain text file and:
1. Counts how many times the word "file" (case-insensitive, i.e., "file", "File", "files" etc.) appears in the text.
2. Identifies and prints the line numbers where the word "exception" is found.
"""
# module for regex
import re
try:
    with open('../practice_files/notes.txt', 'r') as fp:
        count = 0
        line_number = 1
        for line in fp:
            match_file = re.findall(r"file",line, re.IGNORECASE)
            match_exception = re.search(r"exception", line, re.IGNORECASE)
            count = count + len(match_file)

            if(match_exception):
                print(f"Line Number: {line_number}")

            line_number = line_number+1
    
    print(f"The word file appeared {count} time(s)")

except FileNotFoundError as e:
    print(f"Error: Could not find the file! Details: {e}")
