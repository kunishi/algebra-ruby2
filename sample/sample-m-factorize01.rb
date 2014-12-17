require "algebra"
P = MPolynomial(Integer)
x, y, z = P.vars("xyz")
f = x**3 + y**3 + z**3 - 3*x*y*z
p f.factorize #=> (x + y + z)(x^2 - xy - xz + y^2 - yz + z^2)

PQ = MPolynomial(Rational)
x, y, z = PQ.vars("xyz")
f = x**3 + y**3/8 + z**3 - 3*x*y*z/2
p f.factorize #=> (1/8)(2x + y + 2z)(4x^2 - 2xy - 4xz + y^2 - 2yz + 4z^2)
