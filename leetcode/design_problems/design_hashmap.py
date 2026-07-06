class MyHashMap:

    def __init__(self):
        self.map={}
        

    def put(self, key: int, value: int) -> None:
        self.map[key] = value

    def get(self, key: int) -> int:
        return self.map.get(key,-1)

    def remove(self, key: int) -> None:
        try:
            del self.map[key]
        except KeyError as k:
            return


# Your MyHashMap object will be instantiated and called as such:
# obj = MyHashMap()
# obj.put(key,value)
# param_2 = obj.get(key)
# obj.remove(key)