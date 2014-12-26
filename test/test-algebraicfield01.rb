require "test/unit"
require "algebra"

class TestAlgebraicfield01 < Test::Unit::TestCase
  def test_algebraicfield01
    capital_px = Polynomial(Rational, "x")
    x = capital_px.var
    capital_f = ResidueClassRing(capital_px, x**2 + x + 1)
    x = capital_f[x]
    assert_equal("-x - 1/1", "#{(x + 1)**100}")
    # p( (x + 1)**100 )
    #=> -x - 1
    assert_equal("-3/1x - 3/1", "#{(x-1)** 3 / (x**2 - 1)}")
    # p( (x-1)** 3 / (x**2 - 1) )
    #=> -3x - 3

    # TODO: which one is correct?
    capital_g = Polynomial(capital_f, "y")
    y = capital_g.var
    expected = "y^7 + (7/1x + 7/1)y^6 + 21/1xy^5 - 35/1y^4 + (-35/1x - 35/1)y^3 - 21/1xy^2 + 7/1y + x + 1/1"
    assert_equal(expected, "#{(x + y + 1)** 7}")
    # p( (x + y + 1)** 7 )
    #=> y^7 + (7x + 7)y^6 + 8xy^5 + 4y^4 + (4x + 4)y^3 + 5xy^2 + 7y + x + 1

    capital_h = ResidueClassRing(capital_g, y**5 + x*y + 1)
    y = capital_h[y]
    expected = "(1798/3x + 1825/9)y^4 + (-74/1x + 5176/9)y^3 + (-6886/9x - 5917/9)y^2 + (1826/3x - 3101/9)y + 2146/9x + 4702/9"
    assert_equal(expected, "#{1/(x + y + 1)**7}")
    # p( 1/(x + y + 1)**7 )
    #=> (1798/3x + 1825/9)y^4 + (-74x + 5176/9)y^3 +
    #     (-6886/9x - 5917/9)y^2 + (1826/3x - 3101/9)y + 2146/9x + 4702/9
  end
end
