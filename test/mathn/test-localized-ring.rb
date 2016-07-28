#################################################
#                                               #
#  This is test script for 'localized-ring.rb'  #
#                                               #
#################################################
require 'test/unit'
require 'algebra'
require 'mathn'

class TestLocalizedRing < Test::Unit::TestCase
  def setup
    @Q = LocalizedRing(Integer)
    @Z13 = ResidueClassRing(Integer, 13)
    @Z13x = Polynomial(@Z13, 'x')
    @QZ13x = LocalizedRing(@Z13x)

    # a = Q.new(3, 5)
    # b = Q.new(5, 3)
    # p [a + b, a - b, a * b, a / b, a + 3, 1 + a]
  end

  def test_localized_ring_01
    assert_equal(Rational(34, 15), @Q.new(3, 5) + @Q.new(5, 3))
  end

  def test_localized_ring_02
    assert_equal(-Rational(16, 15), @Q.new(3, 5) - @Q.new(5, 3))
  end

  def test_localized_ring_03
    assert_equal(1, @Q.new(3, 5) * @Q.new(5, 3))
  end

  def test_localized_ring_04
    assert_equal(Rational(9, 25), @Q.new(3, 5) / @Q.new(5, 3))
  end

  def test_localized_ring_05
    assert_equal(Rational(18, 5), @Q.new(3, 5) + 3)
  end

  def test_localized_ring_06
    assert_equal(Rational(8, 5), 1 + @Q.new(3, 5))
  end

  # x = Z13x.var
  # a = @QZ13x[x**2 + x + 1, x**2 - 1]
  # b = @QZ13x[x + 1, x**2 + 3*x + 2]
  # p a + b
  # p( (a + b) ** 4)
  # puts

  def test_localized_ring_07
    x = @Z13x.var
    a = @QZ13x[x**2 + x + 1, x**2 - 1]
    b = @QZ13x[x + 1, x**2 + 3 * x + 2]

    assert_equal(
      @QZ13x[x**3 + 4 * x**2 + 3 * x + 1, x**3 + 2 * x**2 - x + 11],
      a + b
    )
  end

  def test_localized_ring_08
    x = @Z13x.var
    a = @QZ13x[x**2 + x + 1, x**2 - 1]
    b = @QZ13x[x + 1, x**2 + 3 * x + 2]
    assert_equal(
      @QZ13x[
        x**12 + 3 * x**11 + 4 * x**10 + x**9 + 11 * x**8 + 11 * x**7 + x**6 + 7 * x**5 + 8 * x**4 + 9 * x**3 + 5 * x**2 - x + 1,
        x**12 + 8 * x**11 + 7 * x**10 + 4 * x**8 + 11 * x**7 + 11 * x**6 + 4 * x**5 + x**4 + 10 * x**3 - x**2 + 6 * x + 3],
      (a + b)**4
    )
    # p( (a + b) ** 4)
  end

  def test_localized_ring_09
    #  Rx = Polynomial(Z13, "x")
    capital_rx = Polynomial(Rational, 'x')
    x = capital_rx.var
    capital_q_capital_rx = LocalizedRing(capital_rx)
    x = capital_q_capital_rx[x]
    a = (x**2 + 1) / (x**3 + x + 1)
    capital_q_capital_r_xy = Polynomial(capital_q_capital_rx, 'y')
    y = capital_q_capital_r_xy.var
    aff = ResidueClassRing(capital_q_capital_r_xy, y**3 + a * y + 1)
    y = aff[y]

    assert_equal(
      3 * x * y**2 + (3 * x**5 + 3 * x**3 + 2 * x**2 - 1) / (x**3 + x + 1) * y + x**3 - 1,
      (y + x)**3
    )
    # p( (y+x) ** 3 )
  end

  def test_localized_ring_10
    capital_f = RationalFunctionField(Rational, 'x')

    x = capital_f.var
    assert_equal(x**2 / (x**4 + x**3 - x - 1), 1 / (x**2 - 1) - 1 / (x**3 - 1))
    # p ( 1 / (x**2 - 1) - 1 / (x**3 - 1) )
  end

  def test_localized_ring_11
    capital_s = AlgebraicExtensionField(Rational, 'a') { |a| a**2 - 2 }
    capital_q_capital_s_x = RationalFunctionField(capital_s, 'x')
    x = capital_q_capital_s_x.var
    a = capital_s.var
    assert_equal(
      1 / (x**4 + 1),
      (a / 4 * x + 1 / 2) / (x**2 + a * x + 1) + (-a / 4 * x + 1 / 2) / (x**2 - a * x + 1)
    )
    # p( (a/4*x + 1/2)/(x**2 + a*x + 1) + (-a/4*x + 1/2)/(x**2 - a*x + 1) )
  end
end
