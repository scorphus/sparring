class BaseOne(object):
    def __init__(self, *args, **kwargs):
        from ipdb import set_trace; set_trace()  # BREAKPOINT BaseOne


class ExtendedOne(BaseOne):
    def __init__(self, *args, **kwargs):
        from ipdb import set_trace; set_trace()  # BREAKPOINT ExtendedOne
        super().__init__(*args, **kwargs)


x = ExtendedOne()
