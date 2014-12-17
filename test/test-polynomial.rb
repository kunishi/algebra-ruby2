#############################################
#                                           #
#  This is test script for 'polynomial.rb'  #
#                                           #
#############################################
require "algebra/polynomial.rb"
require "algebra/residue-class-ring"
require "mathn"
require 'assert'

Fx = Algebra::Polynomial.create(Integer, "x")
x = Fx.var

f = x**6 - 1
g = (x^4) -1

d, t, u = f.gcd_coeff(g)
#puts "(#{t})(#{f}) + (#{u})(#{g}) = #{t * f + u * g} = #{d}"
assert t*f + u*g, d

Fy = Algebra::Polynomial.create(Rational, "y")
y = Fy.var

f = y**3 - 3*y + 2
g = y**6 - 1
h = y**4 - 1

assert f.gcd_all(g, h), -14/9*y + 14/9

d, a, b, c =  f.gcd_coeff_all(g, h)

assert a*f+b*g+c*h, d

# Polynimial is a commutative multi-variable ring
Fxy = Algebra::Polynomial.create(Fx, "y")
x = Fx.var
y = Fxy.var
assert x**2 * y**2 - y**2 * x**2, 0

require "algebra/algebraic-parser"
assert AlgebraicParser.eval("(x + y)**10 - (y**2 + 2*x*y + x**2)**5)", Fxy), 0

require "algebra/rational"
#  A = Algebra::Polynomial.create(Rational, "x")
#  x = A.var
#  B = Algebra::Polynomial.create(A, "y")
#  y = B.var
#  C = Algebra::Polynomial.create(B, "z")
#  z = C.var
#  D = Algebra::Polynomial.create(C, "w")
#  w = D.var
#  p( (x+y+z+w)**4 )

K = Algebra::Polynomial.create(Integer, "x", "y", "z", "w")
x, y, z, w = K.vars
assert (x+y+z+w)**4, (x+y+z+w)**2 * (x+y+z+w)**2

L = Algebra::Polynomial.create(Integer, 'x', 'y', 'z')
x, y, z = L.vars
f = x * y * z
assert f.sub(y, y-1), x*(y-1)*z
f = (x - y)*(y - z - 1)
assert f.sub(y, z+1), 0
