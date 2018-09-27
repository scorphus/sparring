def real(z):
    return hasattr(z, 'real') and z.real or z
    # Should read like this instead
    # return hasattr(z, 'real') and z.real or not z.imag and z or 0


def imag(z):
    return hasattr(z, 'imag') and z.imag or 0


for z in 3 + 4j, 5, 0 + 6j, 7.0, 8 + 0j, 6:
    print(real(z), imag(z))
