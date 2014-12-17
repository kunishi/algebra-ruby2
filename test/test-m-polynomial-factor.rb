######################################################
#                                                    #
#  This is test script for 'm-polynomial-factor.rb'  #
#                                                    #
######################################################
require "algebra/m-polynomial-factor.rb"
require "algebra/residue-class-ring"
require "algebra/m-polynomial"
include Algebra

Z7 = ResidueClassRing(Integer, 7)
P = MPolynomial(Z7)
x, y, z = P.vars("xyz")
#  f = x**2*y*z + (-z**2 - y*z + y + z + 2)*x + (y*z**3 - z**3 - y**2*z - y*z + 2*z)
#  f = x**2*y + x**2*z + x * y * z
#  f = x**2*y + x**2*z + x * y 
f = (x + y)*(y + z)*(z + x)

#  p f.lc_at(0)
p f
#  p f.monic_int
p f.coeffs_at(0)
