class Node:

    def __init__(self, key, val, par=None, left=None, right=None):
        self._key = key
        self._val = val
        self._par = par
        self._left = left
        self._right = right

    def __setitem__(self, key, val):
        if self._key == key:
            self._val = val
        elif self._key < key:
            if not self._left:
                self._left = Node(key, val, self)
            else:
                self._left[key] = val
        else:
            if not self._right:
                self._right = Node(key, val, self)
            else:
                self._right[key] = val

    def __getitem__(self, key):
        if self._key == key:
            return self._val
        elif self._key < key:
            if self._left:
                return self._left[key]
        else:
            if self._right:
                return self._right[key]


class BinarySearchTree:

    def __init__(self):
        self._root = None
        self._size = 0

    def __len__(self):
        return self._size

    def __iter__(self):
        if self._root:
            return iter(self._root)
        else:
            return iter(())

    def __setitem__(self, key, val):
        if not self._root:
            self._root = Node(key, val)
        else:
            self._root[key] = val

    def __getitem__(self, key):
        return self._root[key]
