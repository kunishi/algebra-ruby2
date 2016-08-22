require 'test/unit'
require 'algebra'

class TestAlgebraicField02 < Test::Unit::TestCase
  def test_algebraicfield02
    capital_f = AlgebraicExtensionField(Rational, 'x') { |x| x**2 + x + 1 }
    x = capital_f.var

    assert_equal('-x - 1/1', ((x + 1)**100).to_s)
    # p( (x + 1)**100 )
    assert_equal('-3/1x - 3/1', ((x - 1)**3 / (x**2 - 1)).to_s)
    # p( (x-1)** 3 / (x**2 - 1) )

    capital_h = AlgebraicExtensionField(capital_f, 'y') { |y| y**5 + x * y + 1 }
    y = capital_h.var

    expected = '(1798/3x + 1825/9)y^4 + (-74/1x + 5176/9)y^3 + (-6886/9x - 5917/9)y^2 + (1826/3x - 3101/9)y + 2146/9x + 4702/9'
    assert_equal(expected, (1 / (x + y + 1)**7).to_s)
    # p( 1/(x + y + 1)**7 )
  end
end
