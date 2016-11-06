class IntStackMin(object):

    def __init__(self):
        self._stack = list()
        self._mins = list()

    def __iter__(self):
        return iter(self._stack[::-1])

    def __len__(self):
        return len(self._stack)

    def push(self, num):
        self._stack.append(num)
        if not len(self._mins) or self._mins[-1] >= num:
            self._mins.append(num)

    def pop(self):
        try:
            num = self._stack.pop()
        except IndexError:
            raise ValueError('empty sequence')
        if self._mins[-1] == num:
            self._mins.pop()
        return num

    def top(self):
        try:
            return self._stack[-1]
        except IndexError:
            raise ValueError('empty sequence')

    def min(self):
        try:
            return self._mins[-1]
        except IndexError:
            raise ValueError('empty sequence')
