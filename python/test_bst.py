import unittest

from bst import BinarySearchTree


class BinarySearchTreeTestCase(unittest.TestCase):

    def test_can_create_an_empty_tree(self):
        t = BinarySearchTree()
        self.assertIsNot(t, None)

    def test_can_check_tree_length(self):
        t = BinarySearchTree()
        self.assertEqual(len(t), 0)

    def test_can_iter_over_an_empty_tree(self):
        t = BinarySearchTree()
        try:
            iter(t)
        except TypeError:
            raise AssertionError('BinarySearchTree is not iterable')

    def test_can_set_the_first_leaf(self):
        t = BinarySearchTree()
        t['name'] = 'Doge'

    def test_can_set_and_get_the_first_leaf(self):
        t = BinarySearchTree()
        t['name'] = 'Doge'
        self.assertEquals(t['name'], 'Doge')

    def test_can_set_and_get_two_items(self):
        t = BinarySearchTree()
        t['name'] = 'Doge'
        t['does'] = 'bark'
        self.assertEquals(t['name'], 'Doge')
        self.assertEquals(t['does'], 'bark')
