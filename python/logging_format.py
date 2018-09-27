import logging
import os
import time


def main():
    with open(os.devnull, 'w') as devnull:
        log_level = os.getenv('LOG_LEVEL', 'WARNING').upper()
        level = getattr(logging, log_level, logging.WARNING)
        logging.basicConfig(level=level, stream=devnull)
        start = time.time()
        for n in range(int(1e5)):
            logging.info('%d', n)
        print(f'{time.time() - start:0.4f}')
        start = time.time()
        for n in range(int(1e5)):
            logging.info(f'{n}')
        print(f'{time.time() - start:0.4f}')
        a, b, c, d, e, f, g, h = 'Alpha', 'Bravo', 'Charlie', 'Delta', 'Echo', 'Foxtrot', 'Golf', 'Hotel'
        start = time.time()
        for n in range(int(1e5)):
            logging.info('%d, %s, %s, %s, %s, %s, %s, %s, %s', n, a, c, b, d, e, f, g, h)
        print(f'{time.time() - start:0.4f}')
        start = time.time()
        for n in range(int(1e5)):
            logging.info(f'{n}, {a}, {c}, {b}, {d}, {e}, {f}, {g}, {h}')
        print(f'{time.time() - start:0.4f}')


if __name__ == '__main__':
    main()
