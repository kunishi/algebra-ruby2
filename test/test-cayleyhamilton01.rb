require "test/unit"
require "algebra"

class TestCayleyhamilton01 < Test::Unit::TestCase
  def test_cayleyhamilton01
    n = 4
    capital_r = MPolynomial(Integer)
    capital_m_capital_r = SquareMatrix(capital_r, n)
    m = capital_m_capital_r.matrix{|i, j| capital_r.var("x#{i}#{j}") }
    capital_rx = Polynomial(capital_r, "x")
    ch = m.char_polynomial(capital_rx)

    assert_equal(0, ch.evaluate(m))
    # p ch.evaluate(m) #=> 0
  end
end
