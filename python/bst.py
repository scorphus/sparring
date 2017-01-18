class Node(object):

    def __init__(self, key, val, par, key_flattener):
        self._key = key
        self._cmp_key = key if not key_flattener else key_flattener(key)
        self._val = val
        self._par = par
        self._left = None
        self._right = None
        self._length = 1
        self._key_flat = key_flattener

    def __eq__(self, node):
        return self._cmp_key == node._cmp_key

    def _setitem(self, key, val):
        if self._key == key:
            self._val = val
            return 0
        cmp_key = key if not self._key_flat else self._key_flat(key)
        if self._cmp_key > cmp_key:
            if not self._left:
                self._left = Node(key, val, self, self._key_flat)
                return 1
            return self._left._setitem(key, val)
        if not self._right:
            self._right = Node(key, val, self, self._key_flat)
            return 1
        return self._right._setitem(key, val)

    def __setitem__(self, key, val):
        self._length += self._setitem(key, val)

    def __iter__(self):
        return self.keys()

    def _getitem(self, key):
        if self._key == key:
            return self
        cmp_key = key if not self._key_flat else self._key_flat(key)
        if self._cmp_key > cmp_key and self._left:
            return self._left._getitem(key)
        if self._right:
            return self._right._getitem(key)
        raise KeyError(key)

    def __getitem__(self, key):
        return self._getitem(key)._val

    def __len__(self):
        return self._length

    def __delitem__(self, key):
        self._getitem(key)._delete()
        self._length -= 1

    @property
    def _is_root(self):
        return hasattr(self._par, '_root')

    def _disconnect(self):
        if self._is_root:
            self._par._root = None
        elif self._par._left and self._par._left == self:
            self._par._left = None
        else:
            self._par._right = None

    def _replace_with(self, node):
        self._key = node._key
        self._cmp_key = node._cmp_key
        self._val = node._val

    def _disown_right(self):
        self._right._par = self._par
        if self._par._left and self._par._left == self:
            self._par._left = self._right
        else:
            self._par._right = self._right

    def _delete(self):
        if self._left and self._right:
            successor = self._successor()
            self._replace_with(successor)
            if successor._right:
                successor._disown_right()
            else:
                successor._disconnect()
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
            self._disconnect()

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
            return self._right._max()
        return self

    def min_key(self):
        return self._min()._key

    def max_key(self):
        return self._max()._key

    def min_val(self):
        return self._min()._val

    def max_val(self):
        return self._max()._val

    def _successor(self):
        if self._right:
            return self._right._min()
        if self._par and not self._is_root:
            if self._par._left and self._par._left == self:
                return self._par
            self._par._right = None
            successor = self._par._successor()
            self._par._right = self
            return successor

    def successor_key(self, key):
        successor = self._getitem(key)._successor()
        return successor._key if successor else None

    def successor_val(self, key):
        successor = self._getitem(key)._successor()
        return successor._val if successor else None

    def _predecessor(self):
        if self._left:
            return self._left._max()
        if self._par and not self._is_root:
            if self._par._right and self._par._right == self:
                return self._par
            self._par._left = None
            predecessor = self._par._predecessor()
            self._par._left = self
            return predecessor

    def predecessor_key(self, key):
        predecessor = self._getitem(key)._predecessor()
        return predecessor._key if predecessor else None

    def predecessor_val(self, key):
        predecessor = self._getitem(key)._predecessor()
        return predecessor._val if predecessor else None


class BinarySearchTree(object):

    def __init__(self, key_flattener=None):
        self._root = None
        self._key_flat = key_flattener

    @property
    def _root_or_value_error(self):
        if self._root:
            return self._root
        raise ValueError('empty sequence')

    def _root_or_key_error(self, key):
        if self._root:
            return self._root
        raise KeyError(key)

    def __len__(self):
        return len(self._root) if self._root else 0

    def __iter__(self):
        if self._root:
            return iter(self._root)
        return iter(())

    def __setitem__(self, key, val):
        if not self._root:
            self._root = Node(key, val, self, self._key_flat)
        else:
            self._root[key] = val

    def __getitem__(self, key):
        return self._root_or_key_error(key)[key]

    def __delitem__(self, key):
        del self._root_or_key_error(key)[key]

    def keys(self):
        if self._root:
            return self._root.keys()
        return iter([])

    def values(self):
        if self._root:
            return self._root.values()
        return iter([])

    def min_key(self):
        return self._root_or_value_error.min_key()

    def max_key(self):
        return self._root_or_value_error.max_key()

    def min_val(self):
        return self._root_or_value_error.min_val()

    def max_val(self):
        return self._root_or_value_error.max_val()

    def successor_key(self, key):
        return self._root_or_key_error(key).successor_key(key)

    def successor_val(self, key):
        return self._root_or_key_error(key).successor_val(key)

    def predecessor_key(self, key):
        return self._root_or_key_error(key).predecessor_key(key)

    def predecessor_val(self, key):
        return self._root_or_key_error(key).predecessor_val(key)

    def get(self, key, default=None):
        try:
            return self._root_or_value_error[key]
        except (KeyError, ValueError):
            return default
