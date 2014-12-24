####################################################
#                                                  #
#  This is test script for 'polynomial-factor.rb'  #
#                                                  #
####################################################
require 'test/unit'
require "algebra/polynomial-factor.rb"
require "algebra/polynomial"
require "algebra/residue-class-ring"
require "algebra/rational"
include Algebra

class TestPolynomialFactor < Test::Unit::TestCase
  # def test(f)
  #   print "#{f}\n  => "
  #   a = f.factorize
  #   sw = (f == a.pi)
  #   puts "#{a.inspect}, #{sw}"
  #   raise unless sw
  # end

  def test_polynomial_factor_01
    p0 = Polynomial(Integer, "x")
    x = p0.var
    #  PQ = Polynomial(Rational, "x")
    pq = Polynomial(Integer, "x")
    x = pq.var
    f = (x**2+x+1)*(x+1)**3

    # test(f)
    # print "#{f}\n  => "
    a = f.factorize
    assert_equal(a.pi, f, "#{f}\n  => #{a.inspect}")
    # sw = (f == a.pi)
    # puts "#{a.inspect}, #{sw}"
    # raise unless sw
  end

  def test_polynomial_factor_02
    pq = Polynomial(Integer, "x")
    x = pq.var
    f = (x**2+x+1)*(x+1)**3
    
    n = 5
    # puts "mod = #{n}"
    pf = Polynomial.reduction(Integer, n, "y")
    g = pf.reduce(f)
    # test(g)
    # print "#{g}\n  => "
    a = g.factorize
    assert_equal(a.pi, g, "mod = #{n}, #{g}\n  => #{a.inspect}")
    # sw = (g == a.pi)
    # puts "#{a.inspect}, #{sw}"
    # raise unless sw
  end

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
end
