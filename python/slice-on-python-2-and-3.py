import random
import string
import sys
import time


def data():
    if not hasattr(data, 'data'):
        print('Creating data...')
        random_string = ''.join(random.choice(
            string.ascii_letters + string.digits
        ) for _ in range(9999))
        fmt = '#%05d (%s) just a string that also ends with carnival\n'
        data.data = [fmt % (d, random_string) for d in range(99999)]

    def decorator(f):

        def wrapper(*args, **kwargs):
            return f(data.data, *args, **kwargs)

        return wrapper
    return decorator


def timeit(f):

    def wrapper(*args, **kwargs):
        start_time = time.time()
        result = f(*args, **kwargs)
        spent = time.time() - start_time
        print('{}: {}'.format(f.__name__, spent))
        return result

    return wrapper


@data()
@timeit
def slicing(data):
    suffix = 'carnival\n'
    str_list = [s for s in data if s[-len(suffix):] == suffix]
    return len(str_list) == len(data)


@data()
@timeit
def slicing_more(data):
    str_list = [[s for s in d[::3]] for d in data[::3]]
    return len(str_list)


def main():
    print('Testing with Python {}.{}.{} ...'.format(*sys.version_info))
    print(slicing())
    print(slicing_more())
    print('Finish!')


if __name__ == '__main__':
    main()
