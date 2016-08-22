require 'test/unit'
require 'algebra'

class TestAlgebraicEquation01 < Test::Unit::TestCase
  def test_algebraic_equation_01
    # PQ = MPolynomial(Rational)
    capital_p_capital_q = MPolynomial(Rational)
    a, b, c = capital_p_capital_q.vars('abc')

    result = AlgebraicEquation.minimal_polynomial(a + b + c, a**2 - 2, b**2 - 3, c**2 - 5)
    #=> x^8 - 40x^6 + 352x^4 - 960x^2 + 576
    expected = 'x^8 - 40/1x^6 + 352/1x^4 - 960/1x^2 + 576/1'
    assert_equal(expected, result.to_s)
  end
end
