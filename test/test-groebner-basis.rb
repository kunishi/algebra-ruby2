#################################################
#                                               #
#  This is test script for 'groebner-basis.rb'  #
#                                               #
#################################################
#require "algebra/groebner-basis.rb"
#require "algebra/m-polynomial"
require "algebra"
include Algebra
def gb(f, sw = false)
  f0 = f.first
  print "Basis of: "
  sw ? puts('', *f) : puts(f.join(", "))
#  gbase = Groebner.reduced_basis(f)
  gbase = Groebner.basis(f)
  print "Is: "
  sw ? puts('', *gbase) : puts(gbase.join(", "))
  puts
end

puts "rational"
require "algebra/rational"
x, y, z = MPolynomial(Rational).vars "xyz"
f1 = x**2 + y**2 + z**2 -1
f2 = x**2 + z**2 - y
f3 = x - z
gb([f1, f2, f3])

puts "mod 5"
#require "algebra/residue-class-ring"
F5 = ResidueClassRing(Integer, 5)
x, y, z = MPolynomial(F5).vars "xyz"
f1 = x**2 + y**2 + z**2 -1
f2 = x**2 + z**2 - y
f3 = x - z
gb([f1, f2, f3])

puts "require 'mathn'"
#require "mathn"
x, y, z = MPolynomial(Integer).vars "xyz"
f1 = x**2 + y**2 + z**2 -1
f2 = x**2 + z**2 - y
f3 = x - z
gb([f1, f2, f3])
