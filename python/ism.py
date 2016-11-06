class IntStackMin(object):

    def __init__(self):
        self._stack = list()

    def __iter__(self):
        return iter(self._stack[::-1])

    def __len__(self):
        return len(self._stack)

    def push(self, num):
        self._stack.append(num)

    def pop(self):
        return self._stack.pop()

    def top(self):
        return self._stack[-1]

    def min(self):
        return min(self._stack)
