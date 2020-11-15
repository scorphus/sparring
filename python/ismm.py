import sys


class IntStackMaxMin(object):
    def __init__(self):
        self._stack = list()
        self._max = self._min = None

    def __iter__(self):
        max_, min_ = self._max, self._min
        for num in self._stack[::-1]:
            if num > max_:
                num, max_ = max_, num - max_
            elif num < min_:
                num, min_ = min_, min_ - num
            yield num

    def __len__(self):
        return len(self._stack)

    def __sizeof__(self):
        extra_size = sys.getsizeof(1) * 2
        if self._max is not None:
            extra_size = sys.getsizeof(self._max) + sys.getsizeof(self._min)
        return sys.getsizeof(self._stack) + extra_size

    def push(self, num):
        if not self._stack:
            self._max = self._min = num
        else:
            if num < self._min:
                num, self._min = num - self._min, num
            elif num > self._max:
                num, self._max = num + self._max, num
        self._stack.append(num)

    def pop(self):
        try:
            num = self._stack.pop()
            if num > self._max:
                num, self._max = self._max, num - self._max
            elif num < self._min:
                num, self._min = self._min, self._min - num
            return num
        except IndexError:
            raise ValueError("empty sequence")

    def top(self):
        try:
            num = self._stack[-1]
            if num > self._max:
                num = self._max
            elif num < self._min:
                num = self._min
            return num
        except IndexError:
            raise ValueError("empty sequence")

    def max(self):
        if self._stack:
            return self._max
        raise ValueError("empty sequence")

    def min(self):
        if self._stack:
            return self._min
        raise ValueError("empty sequence")
