require "algebra"

Z7 = ResidueClassRing(Integer, 7)
P = MPolynomial(Z7)
x, y, z = P.vars("xyz")
f = x**3 + y**3 + z**3 - 3*x*y*z
p f.factorize #=> (x + 4y + 2z)(x + 2y + 4z)(x + y + z)
