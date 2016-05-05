#################################################
#                                               #
#  This is test script for 'matrix-algebra.rb'  #
#                                               #
#################################################
require "rubyunit"
require "algebra"
require "algebra/polynomial"

#require "algebra/matrix-algebra.rb"
#include Algebra

class TestMatrixAlgebra < Test::Unit::TestCase
  def setup
    @M33 = Algebra.MatrixAlgebra(Integer, 3, 3)
    @M34 = Algebra.MatrixAlgebra(Integer, 3, 4)
    @M43 = @M34.transpose
    @M44 = @M43 * @M34
    @Px =  Algebra.Polynomial(Integer, "x")
    @M2 = Algebra.SquareMatrix(Rational, 2)
    @M3 = Algebra.SquareMatrix(Rational, 3)
  end

  def test_matrix_algebra_01
    m0 = @M33[
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]
    m1 = @M33[
      [10, 11, 12],
      [13, 14, 15],
      [16, 17, 18]]

    assert_equal(
      @M33[
        [10, 12, 14],
        [16, 18, 20],
        [22, 24, 26]
      ],
      m0 + m1
    )
    # p m0 + m1
  end

  def test_matrix_algebra_02
    m0 = @M33[
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]

    # assert_equal(SquareMatrix, (m0 * m0).class)
    assert_equal(
      [
        [15, 18, 21],
        [42, 54, 66],
        [69, 90, 111]
      ],
      (m0 * m0).to_ary
    )
    # p m0 * m0
  end

  def test_matrix_algebra_03
    m0 = @M33[
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]
    m1 = @M33[
      [10, 11, 12],
      [13, 14, 15],
      [16, 17, 18]
    ]
    m2 = @M34[
      [20, 21, 22, 23],
      [24, 25, 26, 27],
      [28, 29, 30, 31]
    ]

    assert_equal(
      [
        [15, 42, 69],
        [18, 54, 90],
        [21, 66, 111]
      ],
      (m0 * m0).t.to_ary
    )
    # p( (m0 * m0).t )
  end

  def test_matrix_algebra_04
    m0 = @M33[
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]
    m1 = @M33[
      [10, 11, 12],
      [13, 14, 15],
      [16, 17, 18]
    ]
    m2 = @M34[
      [20, 21, 22, 23],
      [24, 25, 26, 27],
      [28, 29, 30, 31]
    ]

    assert_equal(
      [[80, 83, 86, 89], [296, 308, 320, 332], [512, 533, 554, 575]],
      (m0 * m2).to_ary
    )
    # m = m0 * m2
  end

  def test_matrix_algebra_05
    assert_equal([3, 4], @M34.sizes)
    # p M34.sizes
  end

  def test_matrix_algebra_06
    assert_equal([4, 3], @M43.sizes)
    # p M43.sizes
  end

  def test_matrix_algebra_07
    m2 = @M34[
      [20, 21, 22, 23],
      [24, 25, 26, 27],
      [28, 29, 30, 31]
    ]

    assert_equal(
      [
        [1760, 1832, 1904, 1976],
        [1832, 1907, 1982, 2057],
        [1904, 1982, 2060, 2138],
        [1976, 2057, 2138, 2219]
      ],
      (m2.t * m2).to_ary
    )
    # p m2.t * m2
  end

  def test_matrix_algebra_08
    m2 = @M2[
      [1, 2],
      [3, 4],
      ]
    x = @Px.var
    assert_equal(x**2 - Rational(5, 1)*x - Rational(2, 1), m2.char_polynomial(@Px))
    # p f = m2.char_polynomial(Px)
  end

  def test_matrix_algebra_09
    m3 = @M3[
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]]
    x = @Px.var
    assert_equal(x**3 - 12*x**2 - 18*x, m3.char_polynomial(@Px))
    # p f = m3.char_polynomial(Px)
  end

  def test_basic
    m = @M2[[0, 1], [2, 3]]
    assert_equal(m[1, 1], 3)
    m[1, 1] = 4
    assert_equal(m[1, 1], 4)
  end
  def test_rank
    assert_equal(@M3[[0, 0, 0], [0, 0, 0], [0, 0, 0]].rank, 0)
    assert_equal(@M3[[1, 2, 3], [-2, -4, -6], [-1, -2, -3]].rank, 1)
    assert_equal(@M3[[1, 2, 3], [-2, -4, -5], [-1, -2, -2]].rank, 2)
    assert_equal(@M3[[1, 2, 3], [-2, -4, -5], [-1, 0, -3]].rank, 3)
  end
  def test_inverse
    m = @M3[
      [0, 1, 3],
      [1, 0, 1],
      [0, 1, 2]
    ]
    assert_equal(m * m.inverse, 1)
    assert_equal(m.inverse * m, 1)
  end
  def test_cofactor_matirx
    m = @M3[
      [0, 1, 3],
      [1, 0, 1],
      [0, 1, 2]
    ]
    assert_equal(m.cofactor_matrix * m, m.unity * m.determinant)
  end

#  class R0 < MatrixAlgebra
#  end
#  ME = SquareMatrix(R0, 2)

  def test_conversion
    r = Polynomial(Rational, "x")
    @mr = SquareMatrix(r, 2)
    @mq = SquareMatrix(Rational, 2)
    @mz = SquareMatrix(Rational, 2)
    @z3 = ResidueClassRing(Integer, 3)
    @mz3 = SquareMatrix(@z3, 2)

    x = r.var
    mR = @mr[[x,2*x],[3*x,4*x]]
    mQ = @mq[[1,2],[3,4]]
#    mE = ME.new [[1,2],[3,4]]
    mZ = @mz[[1,2],[3,4]]
    mZ3 = @mz3[[1,2],[3,4]]
    assert_equal(@mr, (mR*mQ).class)
    assert_equal(@mr, (mQ*mR).class)

#    assert_raises(RuntimeError) {mR * mE}

    assert_equal(@mq, (mZ*mQ).class)
    assert_equal(@mq, (mQ*mZ).class)

    assert_equal(@mz3, (mZ3*mZ).class)
    assert_equal(@mz3, (mZ*mZ3).class)

    assert_equal(@z3, @z3.wedge(Rational))
    assert_equal(@mz3, (mZ3*mQ).class)
    assert_equal(@z3, Rational.wedge(@z3))
    assert_equal(@mz3, (mQ*mZ3).class)
  end
end
