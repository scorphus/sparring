import sys


class IntStackMin(object):

    def __init__(self):
        self._stack = list()
        self._min = None

    def __iter__(self):
        min_ = self._min
        for num in self._stack[::-1]:
            if num < min_:
                num, min_ = min_, min_ - num
            yield num

    def __len__(self):
        return len(self._stack)

    def __sizeof__(self):
        size_min = sys.getsizeof(1)
        if self._min is not None:
            size_min = sys.getsizeof(self._min)
        return sys.getsizeof(self._stack) + size_min

    def push(self, num):
        if not self._stack:
            self._stack.append(num)
            self._min = num
        elif num < self._min:
            self._stack.append(num - self._min)
            self._min = num
        else:
            self._stack.append(num)

    def pop(self):
        try:
            num = self._stack.pop()
            if num < self._min:
                num, self._min = self._min, self._min - num
            return num
        except IndexError:
            raise ValueError('empty sequence')

    def top(self):
        try:
            num = self._stack[-1]
            if num < self._min:
                return self._min
            return num
        except IndexError:
            raise ValueError('empty sequence')

    def min(self):
        if self._stack:
            return self._min
        raise ValueError('empty sequence')
