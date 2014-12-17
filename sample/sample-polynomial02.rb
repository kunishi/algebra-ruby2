require "algebra"
P = Polynomial(Integer, "x", "y", "z")
x, y, z = P.vars
p((-x + y + z)*(x + y - z)*(x - y + z))
#=> -z^3 + (y + x)z^2 + (y^2 - 2xy + x^2)z - y^3 + xy^2 + x^2y - x^3

