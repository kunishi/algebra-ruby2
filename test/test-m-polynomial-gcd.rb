###################################################
#                                                 #
#  This is test script for 'm-polynomial-gcd.rb'  #
#                                                 #
###################################################
require "algebra/m-polynomial-gcd.rb"
require "algebra/residue-class-ring"
include Algebra

Z7 = ResidueClassRing(Integer, 7)
P = MPolynomial(Z7)
#  P = MPolynomial(Integer)
x, y, z = P.vars("xyz")

f, g  = (x + y) * (x + 2*y), (x + 2*y) * (x + 3*y)
#  f, g  = x**2*y, x*y**2
p k = f.gcd(g)
p k/3 == x + 2*y
