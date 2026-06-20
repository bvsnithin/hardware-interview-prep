"""
File to use: log_file.txt
Task: Write a script that parses log_file.txt and:
1. Reads all log entries from log_file.txt.
2. Sorts the log entries by severity level in this exact priority:
   - First, all "ERROR" log lines
   - Second, all "WARNING" log lines
   - Third, all "INFO" log lines
3. Writes the sorted log lines to a new file named sorted_logs.txt.
"""

try:
    with open('../practice_files/log_file.txt','r') as fp, open('../practice_files/log_file.txt','w') as new_fp:
        severity_level = {'ERROR':1, 'WARNING':2, 'INFO':3}
        logs = []
        for log in fp:
            severity = log.split(" - ")[1]
            logs.append((severity_level(severity), log))
        logs.sort(key = lambda x:x[0])
        for level,log in logs:
            new_fp.write(log)
            
        
except FileNotFoundError as e:
    print(f"File not found error; {e}")