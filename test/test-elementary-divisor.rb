require "rubyunit"
require "algebra/rational"
class Rational;def inspect; to_s; end;end
#class Rational < Numeric;def inspect; to_s; end;end
require "algebra/linear-algebra"
require "algebra/matrix-algebra-triplet"
#include Algebra

class TestElementaryDivisor < Runit
  M4 = Algebra.SquareMatrix(Rational, 4)
  PR = Algebra.Polynomial(Rational, "x")
  SPR4 = Algebra.SquareMatrix(PR, 4)
  def test_elementary_divisor
    m = M4[
      [-3, -3, 4, 2],
      [5, 1, -4, -6],
      [4, -1, -2, -5],
      [-5, -3, 4, 4]]
    puts
    p m.char_polynomial(PR)

    mc = m._char_matrix(SPR4)
    ###################
    mct = Algebra::MatrixAlgebraTriplet.new(mc)
    ###################

    mced = mct.e_diagonalize
    mced.display;puts

    body, left, right = mced
    d = Algebra::ElementaryDivisor.factorize(mc.elementary_divisor)
    p d

    a = (left*mc*right)
    a.display; puts

    assert_equal(body, a)

    x = PR.var
    fac = [
      Algebra::Factors.new([[1, 1]]),
      Algebra::Factors.new([[1, 1]]),
      Algebra::Factors.new([[1, 1]]),
      Algebra::Factors.new([[x-2, 2], [x+2, 2]])]
    assert_equal(d, fac)
  end
end

Tests(TestElementaryDivisor)
