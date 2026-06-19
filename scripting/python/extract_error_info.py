"""
File to use: log_file.txt
Task: Write a script that reads log_file.txt and:
1. Finds every line that contains ERROR.
2. Extracts the timestamp (e.g., 14:03:12) and the message (e.g., Database connection timeout. Retrying...).
3. Writes these filtered errors to a new file named errors.log in this exact format:

[14:03:12] Database connection timeout. Retrying...
[14:05:30] Failed to send confirmation email to user_id=4821.
[14:07:11] Critical disk space warning: less than 5% free.
"""

try:
    with open('../practice_files/log_file.txt','r') as fp_logfile, \
         open('../practice_files/exercise_error_info.txt','w',newline='') as fp_newfile:

        for line in fp_logfile:
            split_line = line.split(" - ")
            # print(split_line)
            if(split_line[1]=="ERROR"):
                time_stamp = split_line[0].split(" ")[1]
                fp_newfile.write(f"[{time_stamp}] {split_line[2]}")

except FileNotFoundError as e:
    print(f"Error: Could not find the file! Details: {e}")