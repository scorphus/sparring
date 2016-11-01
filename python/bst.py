class Node:

    def __init__(self, key, val):
        self._key = key
        self._val = val

    def value(self):
        return self._val


class BinarySearchTree:

    def __init__(self):
        self._root = None
        self._size = 0

    def __len__(self):
        return self._size

    def __iter__(self):
        if self._root:
            return self._root.__iter__()
        else:
            return iter(())

    def __setitem__(self, key, val):
        self._root = Node(key, val)

    def __getitem__(self, key):
        return self._root.value()
