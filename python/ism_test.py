import random
import unittest

from ism import IntStackMin


class IntStackMinBasicTest(unittest.TestCase):

    def test_can_create(self):
        s = IntStackMin()
        self.assertEqual(len(s), 0)

    def test_can_push(self):
        s = IntStackMin()
        s.push(1)
        self.assertEqual(len(s), 1)

    def test_can_push_more(self):
        s = IntStackMin()
        for x in range(3):
            s.push(x)

        self.assertEqual(len(s), 3)

    def test_can_pop(self):
        s = IntStackMin()
        for x in range(3):
            s.push(x)
        s.push(1)

        self.assertEqual(len(s), 4)

        num = s.pop()

        self.assertEqual(num, 1)
        self.assertEqual(len(s), 3)

    def test_can_top(self):
        s = IntStackMin()
        for x in range(3):
            s.push(x)
        s.push(1)

        self.assertEqual(len(s), 4)

        num = s.top()

        self.assertEqual(num, 1)
        self.assertEqual(len(s), 4)

    def test_can_min(self):
        s = IntStackMin()
        for x in [2, 3, 1, 5, 4]:
            s.push(x)
        self.assertEqual(len(s), 5)

        num = s.min()

        self.assertEqual(num, 1)
        self.assertEqual(len(s), 5)

    def test_can_min_builtin(self):
        s = IntStackMin()
        for x in [2, 3, 1, 5, 4]:
            s.push(x)
        self.assertEqual(len(s), 5)

        num = min(s)

        self.assertEqual(num, 1)
        self.assertEqual(len(s), 5)

    def test_can_iterate(self):
        s = IntStackMin()
        for x in [2, 3, 1, 5, 4]:
            s.push(x)
        self.assertEqual(len(s), 5)

        unstacked = list(s)

        self.assertListEqual(unstacked, [2, 3, 1, 5, 4][::-1])
