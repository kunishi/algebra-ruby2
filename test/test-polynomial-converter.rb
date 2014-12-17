#######################################################
#                                                     #
#  This is test script for 'polynomial-converter.rb'  #
#                                                     #
#######################################################
#require "algebra/polynomial-converter.rb"
require "algebra/m-polynomial"
require "algebra/polynomial"
#  MPolynomial.extend Polynomial2Polynomial
#  Polynomial.extend Polynomial2Polynomial
include Algebra

P = Polynomial.create(Integer, "x", "y", "z")
x, y, z = P.vars
f = x**2 + y**2 + z**2 - x*y - y*z - z*x
MP = P.convert_to(MPolynomial)
x, y, z = MP.vars
g = x**2 + y**2 + z**2 - x*y - y*z - z*x
p f = f.value_on(MP) #=> z^2 - zy - zx + y^2 - yx + x^2
p f == g             #=> true

P0 = MP.convert_to(Polynomial)
x, y, z = P0.vars
g = x**2 + y**2 + z**2 - x*y - y*z - z*x
p f = f.value_on(P0)
p f == g

Px = Polynomial(Integer, "x")
x = Px.var
Pxy = Polynomial(Px, "y")
y0 = Pxy.var

Py = Polynomial(Integer, "y")
y = Py.var
Pyx = Polynomial(Py, "x")
x0 = Pyx.var

f = y0**2 * x - y0**3 * x**2
g = y**2 * x0 - y**3 * x0**2
p f
p g
p f.var_swap
