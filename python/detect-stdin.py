#!/usr/bin/env python
# -*- coding:utf-8 -*-
import sys


def main():
    if not sys.stdin.isatty():
        for line in sys.stdin:
            print line.strip('\n')
    else:
        print 'has no data'


if __name__ == '__main__':
    main()
