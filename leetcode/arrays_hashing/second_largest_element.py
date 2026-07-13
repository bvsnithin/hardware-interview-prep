array = [1,4,2,43,54,23,12,-2,4]

max = 0
second_max = 0

for i,num in enumerate(array):
    if(num > max):
        second_max = max
        max = num
    elif (max>num and second_max < num):
        second_max = num

print("Max is: ",max)
print("Second largest number is: ",second_max)