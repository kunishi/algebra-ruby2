#################################################
#                                               #
#  This is test script for 'localized-ring.rb'  #
#                                               #
#################################################
require 'test/unit'
require "algebra/localized-ring.rb"
require "algebra/polynomial"
require "algebra/rational"
require "algebra/algebraic-extension-field"
require "mathn"

include Algebra

class TestLocalizedRing < Test::Unit::TestCase
  Q = LocalizedRing(Integer)
  Z13 = ResidueClassRing(Integer, 13)
  Z13x = Polynomial(Z13, "x")
  QZ13x = LocalizedRing(Z13x)

  # a = Q.new(3, 5)
  # b = Q.new(5, 3)
  # p [a + b, a - b, a * b, a / b, a + 3, 1 + a]

  def test_localized_ring_01
    assert_equal(34/15r, Q.new(3, 5) + Q.new(5, 3))
  end

  def test_localized_ring_02
    assert_equal(-16/15r, Q.new(3, 5) - Q.new(5, 3))
  end

  def test_localized_ring_03
    assert_equal(1r, Q.new(3, 5) * Q.new(5, 3))
  end

  def test_localized_ring_04
    assert_equal(9/25r, Q.new(3, 5) / Q.new(5, 3))
  end

  def test_localized_ring_05
    assert_equal(18/5r, Q.new(3, 5) + 3r)
  end

  def test_localized_ring_06
    assert_equal(8/5r, 1r + Q.new(3, 5))
  end

# x = Z13x.var
# a = QZ13x[x**2 + x + 1, x**2 - 1]
# b = QZ13x[x + 1, x**2 + 3*x + 2]
# p a + b
# p( (a + b) ** 4)
# puts

  def test_localized_ring_07
    x = Z13x.var
    a = QZ13x[x**2 + x + 1, x**2 - 1]
    b = QZ13x[x + 1, x**2 + 3*x + 2]

    assert_equal(
      QZ13x[x**3 + 4r*x**2 + 3r*x + 1r, x**3 + 2r*x**2 - x + 11r],
      a + b
    )
  end

  def test_localized_ring_08
    x = Z13x.var
    a = QZ13x[x**2 + x + 1, x**2 - 1]
    b = QZ13x[x + 1, x**2 + 3*x + 2]
    assert_equal(
      QZ13x[
        x**12 + 3r*x**11 + 4r*x**10 + x**9 + 11r*x**8 + 11r*x**7 + x**6 + 7r*x**5 + 8r*x**4 + 9r*x**3 + 5r*x**2 - x + 1r,
        x**12 + 8r*x**11 + 7r*x**10 + 4r*x**8 + 11r*x**7 + 11r*x**6 + 4r*x**5 + x**4 + 10r*x**3 - x**2 + 6r*x + 3r],
      (a + b) ** 4
    )
    # p( (a + b) ** 4)
  end

  def test_localized_ring_09
    #  Rx = Polynomial(Z13, "x")
    capital_rx = Polynomial(Rational, "x")
    x = capital_rx.var
    capital_q_capital_rx = LocalizedRing(capital_rx)
    x = capital_q_capital_rx[x]
    a = (x**2 + 1)/(x**3 + x + 1)
    capital_q_capital_r_xy = Polynomial(capital_q_capital_rx, "y")
    y = capital_q_capital_r_xy.var
    aff = ResidueClassRing(capital_q_capital_r_xy, y**3 + a*y + 1)
    y = aff[y]

    assert_equal(
      3*x*y**2 + (3*x**5 + 3*x**3 + 2*x**2 - 1)/(x**3 + x + 1)*y + x**3 - 1,
      (y + x) ** 3
    )
    # p( (y+x) ** 3 )
  end

  def test_localized_ring_10
    capital_f = RationalFunctionField(Rational, "x")

    x = capital_f.var
    assert_equal(x**2 / (x**4 + x**3 - x - 1), 1 / (x**2 - 1) - 1 / (x**3 - 1))
    # p ( 1 / (x**2 - 1) - 1 / (x**3 - 1) )
  end

  def test_localized_ring_11
    capital_s = AlgebraicExtensionField(Rational, "a") {|a| a**2 - 2}
    capital_q_capital_s_x = RationalFunctionField(capital_s, "x")
    x, a = capital_q_capital_s_x.var, capital_s.var
    assert_equal(
      1/(x**4 + 1),
      (a/4*x + 1/2)/(x**2 + a*x + 1) + (-a/4*x + 1/2)/(x**2 - a*x + 1)
    )
    # p( (a/4*x + 1/2)/(x**2 + a*x + 1) + (-a/4*x + 1/2)/(x**2 - a*x + 1) )
  end
end
