info_count = 0
with open('../practice_files/log_file.txt','r') as fp:
    for line in fp:
        line = line.split()
        # print(line)
        if(line[3]=="INFO"): info_count = info_count+1

print(f"Count of info logs: {info_count}")