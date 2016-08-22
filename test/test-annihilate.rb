#############################################
#                                           #
#  This is test script for 'annihilate.rb'  #
#                                           #
#############################################
require 'test/unit'
require 'algebra'
require 'algebra/annihilate'

class TestAnnihilate < Test::Unit::TestCase
  def test_annihilate
    capital_z7 = ResidueClassRing(Integer, 7)
    capital_p = MPolynomial(capital_z7)
    x, y, z = capital_p.vars('xyz')

    f = (x + y) * (x + 2 * y)
    g = (x + 2 * y) * (x + 3 * y)
    #  f, g  = x**2*y, x*y**2

    assert_equal(x**3 - x**2 * y + 4 * x * y**2 - y**3, f.lcm(g))
    assert_equal(x + 2 * y, f.gcd(g))
    # p f.lcm(g)
    # p f.gcd(g)
  end
end
