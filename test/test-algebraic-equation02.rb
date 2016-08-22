require 'test/unit'
require 'algebra'

class TestAlgebraicEquation02 < Test::Unit::TestCase
  def test_algebraic_equation_02
    a, b, c = MPolynomial(Rational).vars('abc')
    result = AlgebraicEquation.minimal_polynomial(a + b + c, a**2 - 2, b**2 - 3, c**2 - 5)
    assert_equal('x^8 - 40/1x^6 + 352/1x^4 - 960/1x^2 + 576/1', result.to_s)
    #=> x^8 - 40x^6 + 352x^4 - 960x^2 + 576
  end
end
