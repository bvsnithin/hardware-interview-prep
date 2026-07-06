class MyHashSet:

    def __init__(self):
        self.set = []

    def add(self, key: int) -> None:
        if not (key in self.set):
            self.set.append(key)

    def remove(self, key: int) -> None:
        if self.contains(key):
            self.set.remove(key)

    def contains(self, key: int) -> bool:
        return (key in self.set)


# Your MyHashSet object will be instantiated and called as such:
# obj = MyHashSet()
# obj.add(key)
# obj.remove(key)
# param_3 = obj.contains(key)
