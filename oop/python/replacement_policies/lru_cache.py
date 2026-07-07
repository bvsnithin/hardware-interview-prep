# LRU Cache Replacement Policy
# Least Recently Used Policy: When a cache is full, we evict the line that was least recently used. This uses temporal locality. 
# LRU keeps track of age of each cache line. When a cache line is updated or added, it becomes the most recently used cache line.

class lru_cache:

    def __init__(self, capacity:int=16):
        self.cache = {}             #Instance attribute for the cache contents
        self.capacity = capacity    #Capacity of the cache
        self.age = []               #Age of the cache line

    # Retrieve the element from the cache. If that value is not available, then return -1
    def get(self, key:int) -> int:
        if key not in self.cache:
            return -1

        #Update the age of the key to MRU
        self.age.remove(key)
        self.age.append(key)

        return self.cache[key]

    def put(self, key:int, value:int) -> None:
        if key in self.cache:
            #Update the cache with the new value
            self.cache[key] = value
            #Update the age
            self.age.remove(key)
            self.age.append(key)
            return

        if(self.capacity == len(self.cache)):
            #Remove the lru value from the cache
            lru = self.age.pop(0)
            del self.cache[lru]

        self.cache[key] = value
        self.age.append(key)

        


