require "rubyunit"
require "algebra/rational"
require "algebra/linear-algebra"
require "algebra/matrix-algebra-triplet"
#include Algebra

class TestElementaryDivisor < Test::Unit::TestCase
  def test_elementary_divisor
    capital_m4 = Algebra.SquareMatrix(Rational, 4)
    capital_p_capital_r = Algebra.Polynomial(Rational, "x")
    capital_s_capital_p_capital_r4 = Algebra.SquareMatrix(capital_p_capital_r, 4)

    x = capital_p_capital_r.var

    m = capital_m4[
      [-3, -3, 4, 2],
      [5, 1, -4, -6],
      [4, -1, -2, -5],
      [-5, -3, 4, 4]]
    # puts
    # p m.char_polynomial(capital_p_capital_r)
    assert_equal(x**4 - 8*x**2 + 16, m.char_polynomial(capital_p_capital_r))

    mc = m._char_matrix(capital_s_capital_p_capital_r4)
    ###################
    mct = Algebra::MatrixAlgebraTriplet.new(mc)
    ###################

    mced = mct.e_diagonalize
    assert_equal(
      [
        [1/3r, 0, 0, 0],
        [1/12r*x - 1/12r, -1/4r, 0, 0],
        [
          -1/64r*x**3 - 1/64r*x**2 + 11/32r*x - 9/16r,
          3/64r*x**2 + 3/32r*x - 15/16r,
          3/4r,
          0
        ],
        [
          -1/12r*x**5 - 1/12r*x**4 + 13/6r*x**3 - 4/3r*x**2 - 34/3r*x - 4/3r,
          1/4r*x**4 + 1/2r*x**3 - 6*x**2 - 6*x + 28,
          4*x**2 - 16,
          16r
        ]

      ],
      mced.left.to_ary
    )
    assert_equal(
      [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, x**4 - 8*x**2 + 16]
      ],
      mced.body.to_ary
    )
    assert_equal(
      [
        [0, 1, -2/3r, 1/8r*x**2 + 1/2r],
        [1, -1, 2, -3/8r*x**2 + 1/2r],
        [0, 1/4r*x, 5/3r, -5/16r*x**2 + 1/4r*x + 3/4r],
        [0, 0, -1/3r*x - 4/3r, 1/16r*x**3 + 1/4r*x**2 - 1/4r*x]
      ],
      mced.right.to_ary
    )
    # mced.display;puts

    assert_equal(
      [1r, 1r, 1r, (x - 2r)**2 * (x + 2r)**2],
      mc.elementary_divisor.to_ary
    )
    # p d

    body, left, right = mced
    a = (left*mc*right)
    assert_equal(
      [
        [1r, 0, 0, 0],
        [0, 1r, 0, 0],
        [0, 0, 1r, 0],
        [0, 0, 0, x**4 - 8r*x**2 + 16]
      ],
      a.to_ary
    )
    # a.display; puts

    assert_equal(body, a)

    d = Algebra::ElementaryDivisor.factorize(mc.elementary_divisor)
    x = capital_p_capital_r.var
    fac = [
      Algebra::Factors.new([[1, 1]]),
      Algebra::Factors.new([[1, 1]]),
      Algebra::Factors.new([[1, 1]]),
      Algebra::Factors.new([[x-2, 2], [x+2, 2]])]
    assert_equal(d, fac)
  end
end
