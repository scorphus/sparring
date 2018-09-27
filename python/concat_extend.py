pets = list('cat ')
pets += 'dog '
pets.extend('fish ')

print(pets)

try:
    print(pets + 'python')
except TypeError:
    print('Bang!!!')


class MyList(list):

    def __add__(self, *args):
        return super().__add__(*args)

    def __iadd__(self, *args):
        return super().__iadd__(*args)


pets = MyList('cat ')
pets += 'dog '
pets.extend('fish ')

print(pets)

try:
    print(pets + 'python')
except TypeError:
    print('Bang!!!')
