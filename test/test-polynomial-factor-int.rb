########################################################
#                                                      #
#  This is test script for 'polynomial-factor-int.rb'  #
#                                                      #
########################################################
require "algebra/polynomial-factor-int.rb"
require "algebra/polynomial"
require "algebra/polynomial-factor"
require "algebra/residue-class-ring"
require "algebra/rational"
#include Algebra

def test(f)
  print "#{f}\n  => "
  a = f.factorize
  sw = (f == a.pi)
  puts "#{a.inspect}, #{sw}"
  raise "Test Failed" unless sw
end

PQ = Algebra.Polynomial(Rational, "y")
y = PQ.var

P = Algebra.Polynomial(Integer, "x")
x = P.var

h = x**12 - 12*x**10 - 4*x**9 + 96*x**8 - 442*x**6 + 672*x**5 + 1572*x**4 - 1412*x**3 - 2544*x**2 - 1560*x + 4225

fs = [
  PQ.unity,
  y,
  54*x**3 + 57*x**2 + 28*x + 15, #(9*x**2+2*x+3)*(6*x+5)
  (x**2+x+1)**2*(x+1)**3,
  (x**2+x+1)**2,
  (x**2+x+1)*(x+1)**3,
  (x**2+x+1)*(x+1)*(x+2),
  (x**2+x+1)*(x+1),
  (x**2+x+1),
  (x+1)**3,
  (3*x + 1)*(2*x + 5)*3,
  (x**3 + 1)**3,
#    (x**8+x**6+x**5+x**4+x**3+x**2+1)*(x**2+x+1)**3,
  (y**2 + 2*y + Rational(3, 4))*(y + Rational(1, 3)),
#    h
]
#  fs[-1..-1].each do |f|
fs.each do |f|
  test(f)
end
