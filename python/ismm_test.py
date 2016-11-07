import random
import sys
import time
import unittest

from ismm import IntStackMaxMin


class IntStackMaxMinBasicTest(unittest.TestCase):

    def test_can_create(self):
        s = IntStackMaxMin()
        self.assertEqual(len(s), 0)

    def test_can_push(self):
        s = IntStackMaxMin()
        s.push(1)
        self.assertEqual(len(s), 1)

    def test_can_push_more(self):
        s = IntStackMaxMin()
        for x in range(3):
            s.push(x)

        self.assertEqual(len(s), 3)

    def test_can_pop(self):
        s = IntStackMaxMin()
        for x in range(3):
            s.push(x)
        s.push(1)

        self.assertEqual(len(s), 4)

        num = s.pop()

        self.assertEqual(num, 1)
        self.assertEqual(len(s), 3)

    def test_can_top(self):
        s = IntStackMaxMin()
        for x in range(3):
            s.push(x)
        s.push(1)

        self.assertEqual(len(s), 4)

        num = s.top()

        self.assertEqual(num, 1)
        self.assertEqual(len(s), 4)

    def test_can_max(self):
        s = IntStackMaxMin()
        for x in [2, 3, 1, 5, 4]:
            s.push(x)
        self.assertEqual(len(s), 5)

        num = s.max()

        self.assertEqual(num, 5)
        self.assertEqual(len(s), 5)

    def test_can_max_builtin(self):
        s = IntStackMaxMin()
        for x in [2, 3, 1, 5, 4]:
            s.push(x)
        self.assertEqual(len(s), 5)

        num = max(s)

        self.assertEqual(num, 5)
        self.assertEqual(len(s), 5)

    def test_can_min(self):
        s = IntStackMaxMin()
        for x in [2, 3, 1, 5, 4]:
            s.push(x)
        self.assertEqual(len(s), 5)

        num = s.min()

        self.assertEqual(num, 1)
        self.assertEqual(len(s), 5)

    def test_can_min_builtin(self):
        s = IntStackMaxMin()
        for x in [2, 3, 1, 5, 4]:
            s.push(x)
        self.assertEqual(len(s), 5)

        num = min(s)

        self.assertEqual(num, 1)
        self.assertEqual(len(s), 5)

    def test_can_iterate(self):
        s = IntStackMaxMin()
        for x in [2, 3, 1, 5, 4]:
            s.push(x)
        self.assertEqual(len(s), 5)

        unstacked = list(s)

        self.assertListEqual(unstacked, [2, 3, 1, 5, 4][::-1])

    def test_can_max_after_pop(self):
        s = IntStackMaxMin()
        for x in [2, 3, 7, 5, 4, 7]:
            s.push(x)

        s.pop()
        num = s.max()

        self.assertEqual(num, 7)

    def test_can_min_after_pop(self):
        s = IntStackMaxMin()
        for x in [2, 3, 1, 5, 4, 1]:
            s.push(x)

        s.pop()
        num = s.min()

        self.assertEqual(num, 1)

    def test_can_push_full_top_along_pop_empty(self):
        s = IntStackMaxMin()
        for x in [2, 3, 1, 5, 4, 1]:
            s.push(x)
            top = s.top()
            self.assertEqual(top, x)
        self.assertEqual(len(s), 6)
        while len(s):
            top = s.top()
            pop = s.pop()
            self.assertEqual(top, pop)
        self.assertEqual(len(s), 0)


class IntStackMaxMinTimeEfficiencyTest(unittest.TestCase):

    range_max = 262144
    val_max = 2147483647

    @classmethod
    def setUpClass(cls):
        sys.stdout.write('Setting up class...\n')
        cls.s = IntStackMaxMin()
        for _ in range(cls.range_max):
            cls.s.push(int(cls.val_max * random.random()))

    def setUp(self):
        self.start = time.time()

    def asertIsFast(self):
        spent = 1000 * (time.time() - self.start)  # time spent in milliseconds
        sys.stdout.write('%0.3fms ' % spent)
        sys.stdout.flush()
        self.assertLess(spent, 0.1)

    def test_len_is_fast(self):
        len(self.s)
        self.asertIsFast()

    def test_push_is_fast(self):
        self.s.push(1)
        self.asertIsFast()

    def test_pop_is_fast(self):
        self.s.pop()
        self.asertIsFast()

    def test_top_is_fast(self):
        self.s.top()
        self.asertIsFast()

    def test_max_is_fast(self):
        self.s.max()
        self.asertIsFast()

    def test_min_is_fast(self):
        self.s.min()
        self.asertIsFast()

    def test_builtin_min_isnt_fast(self):
        min(self.s)
        with self.assertRaises(AssertionError):
            self.asertIsFast()

    def test_builtin_max_isnt_fast(self):
        max(self.s)
        with self.assertRaises(AssertionError):
            self.asertIsFast()


class IntStackMaxMinMemoryEfficiencyTest(unittest.TestCase):

    def test_push(self):
        s = IntStackMaxMin()
        aux = list()
        for _ in range(16):
            n = 1 + int(16 * random.random())
            s.push(n)
            aux.append(n)
        s_size = sys.getsizeof(s)
        aux_size = sys.getsizeof(aux)
        for _ in range(16):
            n = -1 - int(16 * random.random())
            s.push(n)
            aux.append(n)
        expected = sys.getsizeof(aux) - aux_size
        increased = sys.getsizeof(s) - s_size
        sys.stdout.write('{}B vs {}B '.format(increased, expected))
        sys.stdout.flush()
        self.assertEqual(increased, expected)


class IntStackMaxMinSafetyTest(unittest.TestCase):

    def test_len_an_empty_stack(self):
        s = IntStackMaxMin()
        self.assertEqual(len(s), 0)

    def test_pop_from_empty_stack(self):
        s = IntStackMaxMin()
        with self.assertRaises(ValueError) as e:
            s.pop()
        self.assertEqual(e.exception.args[0], 'empty sequence')

    def test_top_from_empty_stack(self):
        s = IntStackMaxMin()
        with self.assertRaises(ValueError) as e:
            s.top()
        self.assertEqual(e.exception.args[0], 'empty sequence')

    def test_max_from_empty_stack(self):
        s = IntStackMaxMin()
        with self.assertRaises(ValueError) as e:
            s.max()
        self.assertEqual(e.exception.args[0], 'empty sequence')

    def test_min_from_empty_stack(self):
        s = IntStackMaxMin()
        with self.assertRaises(ValueError) as e:
            s.min()
        self.assertEqual(e.exception.args[0], 'empty sequence')
