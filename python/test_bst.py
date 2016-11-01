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
