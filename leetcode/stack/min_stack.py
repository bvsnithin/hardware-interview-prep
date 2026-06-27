class MinStack:

    def __init__(self):
        self.stack = []
        self.min_stack = []

    def push(self, value: int) -> None:
        self.stack.append(value)
        if not self.min_stack:
            #If min stack is empty, then add the new value as empty value
            self.min_stack.append(value)
        else:
            min_val = self.min_stack[-1] #Get the minimum value
            if(value<min_val):
                self.min_stack.append(value)
            else:
                self.min_stack.append(min_val)

    def pop(self) -> None:
        #Pop values from both stacks
        if self.stack:
            self.stack.pop()
        if self.min_stack:
            self.min_stack.pop()

    def top(self) -> int:
        if self.stack:
            return self.stack[-1]
        return 0

    def getMin(self) -> int:
        if self.min_stack:
            return self.min_stack[-1]
        return 0


# Your MinStack object will be instantiated and called as such:
# obj = MinStack()
# obj.push(value)
# obj.pop()
# param_3 = obj.top()
# param_4 = obj.getMin()