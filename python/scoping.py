def main():
    my_list = [1, 2, 3]
    print(my_list)

    def foo():
        my_list.extend([4])

    def bar():
        nonlocal my_list
        my_list += [5]

    def bang():
        my_list += [6]

    foo()
    print(my_list)
    bar()
    print(my_list)
    bang()
    print(my_list)


main()
