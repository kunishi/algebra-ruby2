#######################################################
#                                                     #
#  This is test script for 'groebner-basis-coeff.rb'  #
#                                                     #
#######################################################
require "algebra/groebner-basis-coeff.rb"
require "algebra/m-polynomial"
require "algebra/groebner-basis"
require "algebra/algebraic-parser"
include Algebra

def gbc(f)
  f0 = f.first
  print "Basis of: "
  puts(f.join(", "))
  c, g = Groebner.basis_coeff(f)
  print "is: "
  puts(g.join(", "))
  puts "Coeefitients are: "
  c.each do |x|
    puts x.join(", ")
  end
  p 3333
  p g
  p c.collect{|x| f.inner_product x}
  
  if g == c.collect{|x| f.inner_product x}
    puts "Success!"
  else
    puts "Fail."
  end
  puts
end

#  require "algebra/residue-class-ring"
#  Z5 = ResidueClassRing(Integer, 5)
#  P = MPolynomial(Z5)
require "algebra/rational"
P = MPolynomial(Rational)

x, y, z = P.vars("xyz")

f1 = x**2 + y**2 + z**2 -1
f2 = x**2 + z**2 - y
f3 = x - z

gbc([f1, f2, f3])

g = x**3 + y**3 + z**3
q, r = g.divmod_s(f1, f2, f3)
p q
p r
if g == q.inner_product([f1, f2, f3]) + r
  puts "Success!"
else
  puts "Fail."
end
