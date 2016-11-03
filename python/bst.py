import pickle


class Node:

    def __init__(self, key, val, par=None, left=None, right=None):
        self._key = key
        self._pickle_key = pickle.dumps(key)
        self._val = val
        self._par = par
        self._left = left
        self._right = right
        self._length = 1

    def __setitem__(self, key, val):
        pickle_key = pickle.dumps(key)
        if self._key == key:
            self._val = val
        elif self._pickle_key > pickle_key:
            if not self._left:
                self._left = Node(key, val, self)
                self._incr()
            else:
                self._left[key] = val
        else:
            if not self._right:
                self._right = Node(key, val, self)
                self._incr()
            else:
                self._right[key] = val

    def __iter__(self):
        return self.keys()

    def __getitem__(self, key):
        pickle_key = pickle.dumps(key)
        if self._key == key:
            return self._val
        elif self._pickle_key > pickle_key:
            if self._left:
                return self._left[key]
        else:
            if self._right:
                return self._right[key]
        raise KeyError(key)

    def __len__(self):
        return self._length

    def __delitem__(self, key):
        pickle_key = pickle.dumps(key)
        if self._key == key:
            self._delete()
            return
        elif self._pickle_key > pickle_key:
            if self._left:
                del(self._left[key])
                return
        else:
            if self._right:
                del(self._right[key])
                return
        raise KeyError(key)

    @property
    def _is_root(self):
        return hasattr(self._par, '_root')

    def _upadte_length(self):
        l_len = self._left._length if self._left else 0
        r_len = self._right._length if self._right else 0
        self._length = 1 + l_len + r_len
        if self._par and not self._is_root:
            self._par._upadte_length()

    def _promote_left(self):
        self._left.max()._right = self._right
        self._right._upadte_length()

    def _promote_right(self):
        self._right.min()._left = self._left
        self._left._upadte_length()

    def _delete(self):
        if self._left and self._right:
            if self._left._length > self._right._length:
                self._promote_left()
            else:
                self._promote_right()
        elif self._right and not self._left:
            if self._is_root:
                self._par._root = self._right
            else:
                self._par._right = self._right
            self._right._par = self._par
            self._right._upadte_length()
        elif self._left and not self._right:
            if self._is_root:
                self._par._root = self._left
            else:
                self._par._left = self._left
            self._left._par = self._par
            self._left._upadte_length()
        else:
            if self._is_root:
                self._par._root = None
            else:
                if self._par._left and self._par._left == self:
                    self._par._left = None
                else:
                    self._par._right = None
                self._par._upadte_length()
        del(self._val)

    def _incr(self):
        self._length += 1
        if self._par and not self._is_root:
            self._par._incr()

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
        else:
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
