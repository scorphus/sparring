import random
import unittest

from bst import BinarySearchTree


class BinarySearchTreeTestCase(unittest.TestCase):

    def test_can_create_an_empty_tree(self):
        t = BinarySearchTree()
        self.assertIsNot(t, None)

    def test_can_check_tree_length(self):
        t = BinarySearchTree()
        self.assertEqual(len(t), 0)

    def test_can_set_the_root(self):
        t = BinarySearchTree()
        t['name'] = 'Doge'
        self.assertEqual(len(t), 1)

    def test_can_set_and_get_the_root(self):
        t = BinarySearchTree()
        t['name'] = 'Doge'
        self.assertEqual(t['name'], 'Doge')

    def test_can_set_and_delete_the_root(self):
        t = BinarySearchTree()
        t['name'] = 'Doge'
        del t['name']
        self.assertEqual(len(t), 0)

    def test_can_set_and_get(self):
        t = BinarySearchTree()
        t['name'] = 'Doge'
        self.assertEqual(t['name'], 'Doge')
        self.assertEqual(t.get('name'), 'Doge')

    def test_can_set_and_get_the_first_leaf(self):
        t = BinarySearchTree()
        t['name'] = 'Doge'
        self.assertEqual(len(t), 1)
        self.assertEqual(t['name'], 'Doge')

    def test_can_set_and_get_two_items(self):
        t = BinarySearchTree()
        t['name'] = 'Doge'
        t['does'] = 'bark'

        self.assertEqual(len(t), 2)

        self.assertEqual(t['name'], 'Doge')
        self.assertEqual(t['does'], 'bark')

    def test_can_add_and_get_many_items(self):
        t = BinarySearchTree()
        t[3] = 'much'
        t[4] = 'bark'
        t[6] = 'wow'
        t[2] = 'scare'

        self.assertEqual(len(t), 4)

        self.assertEqual(t[3], 'much')
        self.assertEqual(t[4], 'bark')
        self.assertEqual(t[6], 'wow')
        self.assertEqual(t[2], 'scare')

    def test_throws_key_error_when_indexing_a_nonexistent_key(self):
        t = BinarySearchTree()
        t[0] = 0
        with self.assertRaises(KeyError) as e:
            t[1]
        self.assertEqual(e.exception.args[0], 1)

    def test_throws_key_error_when_deleting_a_nonexistent_key(self):
        t = BinarySearchTree()
        t[0] = 0
        with self.assertRaises(KeyError) as e:
            del t[1]
        self.assertEqual(e.exception.args[0], 1)

    def test_returns_none_when_getting_a_nonexisting_key(self):
        t = BinarySearchTree()
        t[0] = 0
        self.assertEqual(t.get(1), None)

    def test_returns_default_when_getting_a_nonexisting_key(self):
        t = BinarySearchTree()
        t[0] = 0
        self.assertEqual(t.get(1, 1), 1)


class EmptyBinarySearchTreeTestCase(unittest.TestCase):

    def setUp(self):
        self.t = BinarySearchTree()

    def test_can_iter(self):
        try:
            iter(self.t)
        except TypeError:
            raise AssertionError('BinarySearchTree is not iterable')

    def test_can_get_keys(self):
        try:
            self.t.keys()
        except:
            raise AssertionError('Can not get keys of an empty tree')

    def test_can_get_values(self):
        try:
            self.t.values()
        except:
            raise AssertionError('Can not get values of an empty tree')

    def test_throws_key_error_when_indexing(self):
        with self.assertRaises(KeyError) as e:
            self.t[1]
        self.assertEqual(e.exception.args[0], 1)

    def test_throws_key_error_when_deleting(self):
        with self.assertRaises(KeyError) as e:
            del self.t[1]
        self.assertEqual(e.exception.args[0], 1)

    def test_returns_none_when_getting_a_key(self):
        self.assertEqual(self.t.get(1), None)

    def test_returns_default_when_getting_a_key(self):
        self.assertEqual(self.t.get(1, 0), 0)

    def test_throws_value_error_when_getting_min_key(self):
        with self.assertRaises(ValueError) as e:
            self.t.min_key()
        self.assertEqual(e.exception.args[0], 'empty sequence')

    def test_throws_value_error_when_getting_max_key(self):
        with self.assertRaises(ValueError) as e:
            self.t.max_key()
        self.assertEqual(e.exception.args[0], 'empty sequence')

    def test_throws_value_error_when_getting_min_val(self):
        with self.assertRaises(ValueError) as e:
            self.t.min_val()
        self.assertEqual(e.exception.args[0], 'empty sequence')

    def test_throws_value_error_when_getting_max_val(self):
        with self.assertRaises(ValueError) as e:
            self.t.max_val()
        self.assertEqual(e.exception.args[0], 'empty sequence')


class HomogeneousBinarySearchTreeTestCase(unittest.TestCase):

    def setUp(self):
        self.t = BinarySearchTree()
        self.t['name'] = 'Doge'
        self.t['does'] = 'bark'

    def test_can_iterate_over_it(self):
        keys = list(self.t)
        self.assertListEqual(keys, ['does', 'name'])

    def test_can_iterate_over_keys(self):
        keys = list(self.t.keys())
        self.assertListEqual(keys, ['does', 'name'])

    def test_can_iterate_over_values(self):
        values = list(self.t.values())
        self.assertListEqual(values, ['bark', 'Doge'])

    def test_can_check_element_in_tree(self):
        self.assertIn('name', self.t)
        self.assertIn('does', self.t)

    def test_can_check_element_not_in_tree(self):
        self.assertNotIn('surname', self.t)
        self.assertNotIn('color', self.t)


class HeterogeneousBinarySearchTreeTestCase(unittest.TestCase):

    def setUp(self):
        self.t = BinarySearchTree()
        self.t['name'] = 'Doge'
        self.t['does'] = 'bark'
        self.t[3] = 'much'
        self.t[4] = 'bark'
        self.t[6] = 'wow'
        self.t[2] = 'scare'

    def test_can_get_any_item(self):
        self.assertEqual(self.t['name'], 'Doge')
        self.assertEqual(self.t['does'], 'bark')
        self.assertEqual(self.t[3], 'much')
        self.assertEqual(self.t[4], 'bark')
        self.assertEqual(self.t[6], 'wow')
        self.assertEqual(self.t[2], 'scare')

    def test_can_get_min_key(self):
        self.assertEqual(self.t.min_key(), 2)

    def test_can_get_max_key(self):
        self.assertEqual(self.t.max_key(), 'name')

    def test_can_get_min_val(self):
        self.assertEqual(self.t.min_val(), 'scare')

    def test_can_get_max_val(self):
        self.assertEqual(self.t.max_val(), 'Doge')

    def test_can_delete_an_item(self):
        self.assertEqual(len(self.t), 6)
        del self.t[4]
        self.assertEqual(len(self.t), 5)

    def test_can_delete_a_leaf(self):
        self.assertEqual(len(self.t), 6)
        del self.t[2]
        self.assertEqual(len(self.t), 5)

    def test_can_delete_root(self):
        self.assertEqual(len(self.t), 6)
        del self.t['name']
        self.assertEqual(len(self.t), 5)

    def test_can_find_successor_key(self):
        self.assertEqual(self.t.successor_key(2), 3)
        self.assertEqual(self.t.successor_key(4), 6)
        self.assertEqual(self.t.successor_key(6), 'does')
        self.assertEqual(self.t.successor_key(3), 4)
        self.assertEqual(self.t.successor_key('does'), 'name')
        self.assertEqual(self.t.successor_key('name'), None)

    def test_can_find_successor_val(self):
        self.assertEqual(self.t.successor_val(2), 'much')
        self.assertEqual(self.t.successor_val(4), 'wow')
        self.assertEqual(self.t.successor_val(6), 'bark')
        self.assertEqual(self.t.successor_val(3), 'bark')
        self.assertEqual(self.t.successor_val('does'), 'Doge')
        self.assertEqual(self.t.successor_val('name'), None)


class BinarySearchTreeMassiveTestCase(unittest.TestCase):

    range_max = 10000

    def test_solution_big_1(self):
        max_ = 2147483647
        t = BinarySearchTree()
        for i in range(self.range_max):
            key = int(max_ * random.random())
            t[key] = i

        self.assertGreaterEqual(len(t), 0)
