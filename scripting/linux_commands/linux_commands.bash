#!/bin/bash

# 1) How can you find out details regarding what a UNIX/Linux command does?
echo Use man name_of_the_command to find out details regarding what a command does
# man grep  
# Command "man" stands for manual 

# 1) To display first 10 lines of a file
head -10 ../practice_files/sorted_logs.txt

# 2) To display the 10th line of a file
# Fetch the first 10 lines and pick the last one from it using tail
head -10 ../practice_files/sorted_logs.txt | tail -1

# 3) To delete 13th line from a file
# 4) To delete last line from a file

# 5) To reverse a string (ex: “Hello”)
echo Hello | rev

# 6) To check if the last command was successful

# 7) To find number of lines in a file
cat ../practice_files/sorted_logs.txt | wc -l

# 8) To find number of characters in a file
cat ../practice_files/sorted_logs.txt | wc -c

# 9) To find number of characters on 17th line in a file

# 10) To get 3rd word of 17th line in a file
# 11) To change permission of a file to “Read” and
# “Executable” for all users.
# 12) To change group access permissions of a file to a group.
# (assume new group name as “new_group”)
# 13) To move content to two files (file1.txt and file2.txt) into
# one file(file.txt)
# 14) To display all the processes running on your name
# 15) To uniquely sort contents of a file (file1.txt) and copy
# them to another file (file2.txt)
# 16) To check the username
# 17) To login to a remote host (say “remote-server”)

# 18) Display the 2nd line of the file
awk "NR==2" ../practice_files/sorted_logs.txt

# 19) Display the 3rd line from the end 
tail -3 ../practice_files/sorted_logs.txt | head -n 1