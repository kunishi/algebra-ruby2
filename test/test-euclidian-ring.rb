#################################################
#                                               #
#  This is test script for 'euclidian-ring.rb'  #
#                                               #
#################################################
require 'test/unit'
require "algebra/euclidian-ring.rb"
require "algebra/polynomial"
require "algebra/residue-class-ring"

include Algebra

class TestEuclidianRing < Test::Unit::TestCase
  def test_euclidian_ring_01
    a, b = 108, 221
    d, x, y = a.gcd_coeff(b)
    assert_equal(1, d)
    assert_equal(88, x)
    assert_equal(-43, y)
    assert_equal(d, x * a + y * b)
    # puts "#{x}*#{a} + #{y}*#{b} = #{x * a + y * b} = #{d}"
  end

  def test_euclidian_ring_02
    a, b, c, e = 36, 126, 81, 12
    assert_equal(3, a.gcd_all(b, c, e))
    # p a.gcd_all(b, c, e)

    d, x, y, z, w = a.gcd_coeff_all(b, c, e)
    assert_equal(3, d)
    assert_equal(-12, x)
    assert_equal(4, y)
    assert_equal(-1, z)
    assert_equal(1, w)
    assert_equal(d, x*a + y*b + z*c + w*e)
    # p d == x*a + y*b + z*c + w*e
    # puts "#{d} == #{x}*#{a} + #{y}*#{b} + #{z}*#{c} + #{w}*#{e}"
  end

  def test_euclidian_ring_0
    capital_z7 = ResidueClassRing(Integer, 7)
    #  P = Polynomial(Z7, "x", "y")
    capital_p = Polynomial(Integer, "x", "y")
    x, y = capital_p.vars
    f = 6*(x + 1)*(x + 2)*(y - 1)* (y + 2)
    g = 9*(x + 1)*(x - 3)*(y - 1)* (y - 1)
    # p [f, g, f.gcd_rec(g)]
    assert_equal((-3r*x - 3r)*y + 3r*x + 3r, f.gcd_rec(g))
  end
end
