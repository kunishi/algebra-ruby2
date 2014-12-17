#
require "algebra/algebra"
P = MPolynomial(Integer)
x, y, z = P.vars("xyz")
f = x**3 + y**3 + z**3 - 3*x*y*z
f.factorize #=> (x + y + z)(x^2 - xy - xz + y^2 - yz + z^2)
