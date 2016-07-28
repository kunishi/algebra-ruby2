require 'test/unit'
require 'algebra'
require 'algebra/matrix-algebra-triplet'

class TestElementaryDivisor < Test::Unit::TestCase
  def test_elementary_divisor
    capital_m4 = SquareMatrix(Rational, 4)
    capital_p_capital_r = Polynomial(Rational, 'x')
    capital_s_capital_p_capital_r4 = SquareMatrix(capital_p_capital_r, 4)

    x = capital_p_capital_r.var

    m = capital_m4[
      [-3, -3, 4, 2],
      [5, 1, -4, -6],
      [4, -1, -2, -5],
      [-5, -3, 4, 4]]
    # puts
    # p m.char_polynomial(capital_p_capital_r)
    assert_equal(x**4 - 8 * x**2 + 16, m.char_polynomial(capital_p_capital_r))

    mc = m._char_matrix(capital_s_capital_p_capital_r4)
    ###################
    mct = MatrixAlgebraTriplet.new(mc)
    ###################

    mced = mct.e_diagonalize
    assert_equal(
      [
        [Rational('1/3'), 0, 0, 0],
        [Rational('1/12') * x - Rational('1/12'), -Rational('1/4'), 0, 0],
        [
          -Rational('1/64') * x**3 - Rational('1/64') * x**2 + Rational('11/32') * x - Rational('9/16'),
          Rational('3/64') * x**2 + Rational('3/32') * x - Rational('15/16'),
          Rational('3/4'),
          0
        ],
        [
          -Rational('1/12') * x**5 - Rational('1/12') * x**4 + Rational('13/6') * x**3 - Rational('4/3') * x**2 - Rational('34/3') * x - Rational('4/3'),
          Rational('1/4') * x**4 + Rational('1/2') * x**3 - 6 * x**2 - 6 * x + 28,
          4 * x**2 - 16,
          Rational(16)
        ]

      ],
      mced.left.to_ary
    )
    assert_equal(
      [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, x**4 - 8 * x**2 + 16]
      ],
      mced.body.to_ary
    )
    assert_equal(
      [
        [0, 1, -Rational(2, 3), Rational(1, 8) * x**2 + Rational(1, 2)],
        [1, -1, 2, -Rational(3, 8) * x**2 + Rational(1, 2)],
        [0, Rational(1, 4) * x, Rational(5, 3), -Rational(5, 16) * x**2 + Rational(1, 4) * x + Rational(3, 4)],
        [0, 0, -Rational(1, 3) * x - Rational(4, 3), Rational(1, 16) * x**3 + Rational(1, 4) * x**2 - Rational(1, 4) * x]
      ],
      mced.right.to_ary
    )
    # mced.display;puts

    assert_equal(
      [Rational(1), Rational(1), Rational(1), (x - Rational(2))**2 * (x + Rational(2))**2],
      mc.elementary_divisor.to_ary
    )
    # p d

    body, left, right = mced
    a = (left * mc * right)
    assert_equal(
      [
        [Rational(1), 0, 0, 0],
        [0, Rational(1), 0, 0],
        [0, 0, Rational(1), 0],
        [0, 0, 0, x**4 - Rational(8) * x**2 + 16]
      ],
      a.to_ary
    )
    # a.display; puts

    assert_equal(body, a)

    d = ElementaryDivisor.factorize(mc.elementary_divisor)
    x = capital_p_capital_r.var
    fac = [
      Factors.new([[1, 1]]),
      Factors.new([[1, 1]]),
      Factors.new([[1, 1]]),
      Factors.new([[x - 2, 2], [x + 2, 2]])]
    assert_equal(d, fac)
  end
end
