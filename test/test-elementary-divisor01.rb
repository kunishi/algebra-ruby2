require "test/unit"
require "algebra"
require "stringio"

class TestElementaryDivisor01 < Test::Unit::TestCase
  def capture_stdout(&block)
    original_stdout = $stdout
    $stdout = fake = StringIO.new
    begin
      yield
    ensure
      $stdout = original_stdout
    end
    fake.string
  end

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

    ac = a._char_matrix(capital_m_capital_p)
    expected = [
      "x - 2/1,   0,   0,   0", "\n",
      "  0, x - 2/1,   0,   0", "\n",
      "  0,   0, x - 2/1,   0", "\n",
      "-5/1,   0,   0, x - 2/1", "\n"
    ].join
    assert_equal(expected, capture_stdout { ac.display })
    # ac.display; puts #=>
    #x - 2,   0,   0,   0
    #  0, x - 2,   0,   0
    #  0,   0, x - 2,   0
    # -5,   0,   0, x - 2

    assert_equal("[1/1, x - 2/1, x - 2/1, x^2 - 4/1x + 4/1]", capture_stdout { p ac.elementary_divisor }.chomp)
    # p ac.elementary_divisor #=> [1, x - 2, x - 2, x^2 - 4x + 4]

    require "algebra/matrix-algebra-triplet"
    at = ac.to_triplet.e_diagonalize

    expected = [
      "1/1,   0,   0,   0", "\n",
      "  0, x - 2/1,   0,   0", "\n",
      "  0,   0, x - 2/1,   0", "\n",
      "  0,   0,   0, x^2 - 4/1x + 4/1", "\n"
    ].join
    assert_equal(expected, capture_stdout { at.body.display })
    # at.body.display; puts #=>
    #  1,   0,   0,   0
    #  0, x - 2,   0,   0
    #  0,   0, x - 2,   0
    #  0,   0,   0, x^2 - 4x + 4

    at.left.display; puts #=>
    #  0,   0,   0, -1/5
    #  0,   1,   0,   0
    #  0,   0,   1,   0
    #  5,   0,   0, x - 2

    at.right.display; puts #=>
    #  1,   0,   0, 1/5x - 2/5
    #  0,   1,   0,   0
    #  0,   0,   1,   0
    #  0,   0,   0,   1

    p at.left * ac * at.right == at.body #=> true
  end
end
