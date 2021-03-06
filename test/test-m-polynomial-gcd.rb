###################################################
#                                                 #
#  This is test script for 'm-polynomial-gcd.rb'  #
#                                                 #
###################################################
require 'test/unit'
require 'algebra'

class TestMPolynomialGcd < Test::Unit::TestCase
  def setup
    @Z7 = ResidueClassRing(Integer, 7)
    @P = MPolynomial(@Z7)
  end

  def test_m_polynomial_gcd
    #  P = MPolynomial(Integer)
    x, y, z = @P.vars('xyz')

    f = (x + y) * (x + 2 * y)
    g = (x + 2 * y) * (x + 3 * y)
    #  f, g  = x**2*y, x*y**2
    # p k = f.gcd(g)
    assert_equal(x + 2 * y, f.gcd(g))
    # p k/3 == x + 2*y
    assert_not_equal(x + 2 * y, Rational(1, 3) * f.gcd(g))
  end
end
