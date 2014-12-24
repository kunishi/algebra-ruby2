###################################################
#                                                 #
#  This is test script for 'm-polynomial-gcd.rb'  #
#                                                 #
###################################################
require 'test/unit'
require "algebra/m-polynomial-gcd.rb"
require "algebra/residue-class-ring"
include Algebra

class TestMPolynomialGcd < Test::Unit::TestCase
  Z7 = ResidueClassRing(Integer, 7)
  P = MPolynomial(Z7)

  def test_m_polynomial_gcd
    #  P = MPolynomial(Integer)
    x, y, z = P.vars("xyz")

    f, g  = (x + y) * (x + 2*y), (x + 2*y) * (x + 3*y)
    #  f, g  = x**2*y, x*y**2
    # p k = f.gcd(g)
    assert_equal(x + 2*y, f.gcd(g))
    # p k/3 == x + 2*y
    assert_not_equal(x + 2*y, 1/3r*f.gcd(g))
  end
end
