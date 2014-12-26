require "test/unit"
require "algebra"

class TestElementaryDivisor01 < Test::Unit::TestCase
  def test_elementary_divisor01
    capital_m = SquareMatrix(Rational, 4)
    a = capital_m[
      [2, 0, 0, 0],
      [0, 2, 0, 0],
      [0, 0, 2, 0],
      [5, 0, 0, 2]
    ]
    capital_p = Polynomial(Rational, "x")
    capital_m_capital_p = SquareMatrix(capital_p, 4)
    x = capital_p.var

    ac = a._char_matrix(capital_m_capital_p)
    assert_equal(
      [
        [x - 2, 0, 0, 0],
        [0, x - 2, 0, 0],
        [0, 0, x - 2, 0],
        [-5, 0, 0, x - 2]
      ],
      ac.to_ary
    )
    # ac.display; puts #=>
    #x - 2,   0,   0,   0
    #  0, x - 2,   0,   0
    #  0,   0, x - 2,   0
    # -5,   0,   0, x - 2

    assert_equal(
      [1, x - 2, x - 2, x**2 - 4*x + 4],
      ac.elementary_divisor.to_ary
    )
    # p ac.elementary_divisor #=> [1, x - 2, x - 2, x^2 - 4x + 4]

    require "algebra/matrix-algebra-triplet"
    at = ac.to_triplet.e_diagonalize

    assert_equal(
      [
        [1, 0, 0, 0],
        [0, x - 2, 0, 0],
        [0, 0, x - 2, 0],
        [0, 0, 0, x**2 - 4*x + 4]
      ],
      at.body.to_ary
    )
    # at.body.display; puts #=>
    #  1,   0,   0,   0
    #  0, x - 2,   0,   0
    #  0,   0, x - 2,   0
    #  0,   0,   0, x^2 - 4x + 4

    assert_equal(
      [
        [0, 0, 0, -Rational(1, 5)],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [5, 0, 0, x - 2]
      ],
      at.left.to_ary
    )
    # at.left.display; puts #=>
    #  0,   0,   0, -1/5
    #  0,   1,   0,   0
    #  0,   0,   1,   0
    #  5,   0,   0, x - 2

    assert_equal(
      [
        [1, 0, 0, Rational(1, 5)*x - Rational(2, 5)],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
      ],
      at.right.to_ary
    )
    # at.right.display; puts #=>
    #  1,   0,   0, 1/5x - 2/5
    #  0,   1,   0,   0
    #  0,   0,   1,   0
    #  0,   0,   0,   1

    assert_equal(at.body, at.left * ac * at.right)
    # p at.left * ac * at.right == at.body #=> true
  end
end
