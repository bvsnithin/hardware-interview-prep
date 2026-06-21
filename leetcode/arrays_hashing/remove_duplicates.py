arr = [1,24,53,23,1,1,23,24,4,12]

unique_arr = []
seen = set()
for n in arr:
    if n not in seen:
        seen.add(n)
        unique_arr.append(n)


print(unique_arr)