#!/usr/bin/env python
# -*- coding: utf-8 -*-

from difflib import get_close_matches


def main():
    execs = ['cut', 'gcut', 'gdu', 'git', 'gpt', 'gtf', 'gtr']
    matches = get_close_matches('gut', execs)
    print('The following matches were found: {}'.format(', '.join(matches)))
    matches = get_close_matches('gut', execs, 5)
    print('The following matches were found: {}'.format(', '.join(matches)))


if __name__ == '__main__':
    main()
