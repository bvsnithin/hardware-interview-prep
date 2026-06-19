import csv

#Opening the file in 'w' mode will override the entire file. Always use 'a' to append
# with open('../practice_files/students.csv', 'a') as fp:
#     text = "\nRamdin Dinesh,15,12,Physics,99"
#     fp.write(text)

#Using the CSV reader
with open('../practice_files/students.csv', 'a', newline='') as fp:
    writer = csv.writer(fp)
    writer.writerow(["Ramdin Dinesh", "15", "12", "Physics", "99"])