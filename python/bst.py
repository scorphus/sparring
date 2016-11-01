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
