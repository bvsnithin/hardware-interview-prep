import csv

#Opening a python file and reading the data in it

# with open('../practice_files/students.csv', 'r') as file:
#     print(file.read())
#     file.close() #This is redundant as we are using with - it automatically closes the file.

#Printing only students with age == 15 using basic text line by line iteration
# with open('../practice_files/students.csv','r') as fp:
#     #To skip the header row and move to first row
#     next(fp)
#     for line in fp:
#         column = line.strip().split(",")
#         # print(column)
#         name = column[0]
#         age = int(column[1])
#         if(age==15):
#             print(f"Name: {name}, Age: {age}")
        
#Using csv module
#Printing only the students with Maths score greater than 80
with open('../practice_files/students.csv','r') as fp:
    reader = csv.reader(fp)

    # print(reader) #Prints the object
    header = next(reader) #next method moves the reader to the next line. Same method is used for basic line by line iteration as well
    
    # print(header) #Prints an array of string with the header names
    
    for line in reader:
        name = line[0]
        subject = line[3]
        score = int(line[4])

        if(subject == "Mathematics" and score > 80):
            print(f"Name: {name}, subject: {subject}, score: {score}")