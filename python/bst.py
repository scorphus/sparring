class Node:

    def __init__(self, key, val, par):
        self._key = key
        self._str_key = str(key)
        self._val = val
        self._par = par
        self._left = None
        self._right = None
        self._length = 1

    def _setitem(self, key, val):
        str_key = str(key)
        if self._key == key:
            self._val = val
            return 0
        if self._str_key > str_key:
            if not self._left:
                self._left = Node(key, val, self)
                return 1
            return self._left._setitem(key, val)
        if not self._right:
            self._right = Node(key, val, self)
            return 1
        return self._right._setitem(key, val)

    def __setitem__(self, key, val):
        self._length += self._setitem(key, val)

    def __iter__(self):
        return self.keys()

    def __getitem__(self, key):
        str_key = str(key)
        if self._key == key:
            return self._val
        if self._str_key > str_key and self._left:
            return self._left[key]
        if self._right:
            return self._right[key]
        raise KeyError(key)

    def __len__(self):
        return self._length

    def _delitem(self, key):
        str_key = str(key)
        if self._key == key:
            self._delete()
            return 1
        if self._str_key > str_key and self._left:
            return self._left._delitem(key)
        if self._right:
            return self._right._delitem(key)
        raise KeyError(key)

    def __delitem__(self, key):
        self._length -= self._delitem(key)

    @property
    def _is_root(self):
        return hasattr(self._par, '_root')

    def _delete(self):
        del(self._val)
        if self._left and self._right:
            if self._left._length > self._right._length:
                self._left.max()._right = self._right
            else:
                self._right.min()._left = self._left
        elif self._right and not self._left:
            if self._is_root:
                self._par._root = self._right
            else:
                self._par._right = self._right
            self._right._par = self._par
        elif self._left and not self._right:
            if self._is_root:
                self._par._root = self._left
            else:
                self._par._left = self._left
            self._left._par = self._par
        else:
            if self._is_root:
                self._par._root = None
                return
            if self._par._left and self._par._left == self:
                self._par._left = None
            else:
                self._par._right = None
        if self._is_root:
            self._par._root._length = self._length - 1

    def keys(self):
        if self._left:
            for key in self._left:
                yield key
        yield self._key
        if self._right:
            for key in self._right:
                yield key

    def values(self):
        if self._left:
            for val in self._left.values():
                yield val
        yield self._val
        if self._right:
            for val in self._right.values():
                yield val

    def _min(self):
        if self._left:
            return self._left._min()
        return self

    def _max(self):
        if self._right:
            return self._right._min()
        return self

    def min_key(self):
        return self._min()._key

    def max_key(self):
        return self._max()._key

    def min_val(self):
        return self._min()._val

    def max_val(self):
        return self._max()._val


class BinarySearchTree:
    
    def __init__(self):
        self._root = None

    def __len__(self):
        return len(self._root) if self._root else 0

    def __iter__(self):
        if self._root:
            return iter(self._root)
        return iter(())

    def __setitem__(self, key, val):
        if not self._root:
            self._root = Node(key, val, self)
        else:
            self._root[key] = val

    def __getitem__(self, key):
        if self._root:
            return self._root[key]
        raise KeyError(key)

    def __delitem__(self, key):
        if self._root:
            del(self._root[key])
            return
        raise KeyError(key)

    def keys(self):
        if self._root:
            return self._root.keys()
        return iter([])

    def values(self):
        if self._root:
            return self._root.values()
        return iter([])

    def min_key(self):
        if self._root:
            return self._root.min_key()
        raise ValueError('empty sequence')

    def max_key(self):
        if self._root:
            return self._root.max_key()
        raise ValueError('empty sequence')

    def min_val(self):
        if self._root:
            return self._root.min_val()
        raise ValueError('empty sequence')

    def max_val(self):
        if self._root:
            return self._root.max_val()
        raise ValueError('empty sequence')

    def get(self, key, default=None):
        if self._root:
            try:
                return self._root[key]
            except KeyError:
                pass
        return default
