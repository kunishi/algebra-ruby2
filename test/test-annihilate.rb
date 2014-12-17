#############################################
#                                           #
#  This is test script for 'annihilate.rb'  #
#                                           #
#############################################
require "algebra/annihilate.rb"
require "algebra/residue-class-ring"
include Algebra
Z7 = ResidueClassRing(Integer, 7)
P = MPolynomial(Z7)
x, y, z = P.vars("xyz")

f, g  = (x + y) * (x + 2*y), (x + 2*y) * (x + 3*y)
#  f, g  = x**2*y, x*y**2
p f.lcm(g)
p f.gcd(g)
