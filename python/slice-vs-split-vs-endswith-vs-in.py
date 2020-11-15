import random
import string
import time


def data():
    if not hasattr(data, "data"):
        print("Creating data...")
        random_string = "".join(
            random.choice(string.ascii_letters + string.digits) for _ in range(99999)
        )
        fmt = "#%05d (%s) just a string that also ends with carnival\n"
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
        print("{}: {}".format(f.__name__, spent))
        return result

    return wrapper


@data()
@timeit
def slicing(data, suffix):
    str_list = [s for s in data if s[-len(suffix) :] == suffix]
    return len(str_list) == len(data)


@data()
@timeit
def splitting(data, suffix):
    str_list = [s for s in data if s.split(suffix)[-1] == ""]
    return len(str_list) == len(data)


@data()
@timeit
def endswith(data, suffix):
    str_list = [s for s in data if s.endswith(suffix)]
    return len(str_list) == len(data)


@data()
@timeit
def inning(data, suffix):
    str_list = [s for s in data if s.endswith(suffix)]
    return len(str_list) == len(data)


def main():
    print("Starting tests...")
    print(slicing("carnival\n"))
    print(splitting("carnival\n"))
    print(endswith("carnival\n"))
    print(inning("carnival\n"))
    print("Finish!")


if __name__ == "__main__":
    main()
