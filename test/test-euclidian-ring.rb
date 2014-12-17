#################################################
#                                               #
#  This is test script for 'euclidian-ring.rb'  #
#                                               #
#################################################
require "algebra/euclidian-ring.rb"
include Algebra

a, b = 108, 221
d, x, y = a.gcd_coeff(b)
puts "#{x}*#{a} + #{y}*#{b} = #{x * a + y * b} = #{d}"
a, b, c, e = 36, 126, 81, 12
p a.gcd_all(b, c, e)
d, x, y, z, w = a.gcd_coeff_all(b, c, e)
p d == x*a + y*b + z*c + w*e
puts "#{d} == #{x}*#{a} + #{y}*#{b} + #{z}*#{c} + #{w}*#{e}"

require "algebra/polynomial"
require "algebra/residue-class-ring"
Z7 = ResidueClassRing(Integer, 7)
#  P = Polynomial(Z7, "x", "y")
P = Polynomial(Integer, "x", "y")
x, y = P.vars
f = 6*(x + 1)*(x + 2)*(y - 1)* (y + 2)
g = 9*(x + 1)*(x - 3)*(y - 1)* (y - 1)
p [f, g, f.gcd_rec(g)]
