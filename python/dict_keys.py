# Take this

uniq = {}

for k in (10, 'ten', 10 + 0j, u'ten', 'Ten', 't' + 'en', 10.0):
    uniq.setdefault(k, 0)
    uniq[k] = 1

print(uniq)

# And compare with this

uniq = {}

for k in (10 + 0j, 'ten', 10, u'ten', 'Ten', 't' + 'en', 10.0):
    uniq.setdefault(k, 0)
    uniq[k] = 1

print(uniq)
