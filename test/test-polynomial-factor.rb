####################################################
#                                                  #
#  This is test script for 'polynomial-factor.rb'  #
#                                                  #
####################################################
require "algebra/polynomial-factor.rb"
require "algebra/polynomial"
require "algebra/residue-class-ring"
require "algebra/rational"
include Algebra

def test(f)
  print "#{f}\n  => "
  a = f.factorize
  sw = (f == a.pi)
  puts "#{a.inspect}, #{sw}"
  raise unless sw
end

P0 = Polynomial(Integer, "x")
x = P0.var
#  PQ = Polynomial(Rational, "x")
PQ = Polynomial(Integer, "x")
x = PQ.var
f = (x**2+x+1)*(x+1)**3

test(f)

n = 5
puts "mod = #{n}"
PF = Polynomial.reduction(Integer, n, "y")
g = PF.reduce(f)
test(g)

#  require "algebra/matrix-algebra"
#  P3 = Polynomial(Integer, "x")
#  x = P3.var
#  f = 3 * x**3 + 5 * x**2 + 7 * x + 11
#  g = x**4 - 3*x**2 + x - 7
#  f.sylvester_matrix(g).display
#  f.sylvester_matrix(g, 0).display
#  f.sylvester_matrix(g, 1).display
#  f.sylvester_matrix(g, 2).display
#  p f.resultant(g)
