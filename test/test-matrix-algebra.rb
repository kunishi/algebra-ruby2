#################################################
#                                               #
#  This is test script for 'matrix-algebra.rb'  #
#                                               #
#################################################
require "algebra"
require "rubyunit"
#require "algebra/matrix-algebra.rb"
#include Algebra
M33 = Algebra.MatrixAlgebra(Integer, 3, 3)
M34 = Algebra.MatrixAlgebra(Integer, 3, 4)
m0 = M33[
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8]
]
m1 = M33[
  [10, 11, 12],
  [13, 14, 15],
  [16, 17, 18]]
m2 = M34[[20, 21, 22, 23],
         [24, 25, 26, 27],
         [28, 29, 30, 31]]
p m0 + m1
p m0 * m0
p( (m0 * m0).t )
m = m0 * m2
M43 = M34.transpose
p M34.sizes
p M43.sizes
M44 = M43 * M34
p m2.t * m2

require "algebra/polynomial"
Px =  Algebra.Polynomial(Integer, "x")
M2 = Algebra.SquareMatrix(Rational, 2)
#M2 = SquareMatrix(Integer, 2)
m2 = M2[
  [1, 2],
  [3, 4],
  ]
p f = m2.char_polynomial(Px)

M3 = Algebra.SquareMatrix(Rational, 3)
m3 = M3[
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8]]
p f = m3.char_polynomial(Px)

class TestMatrixAlgebra < Runit
  def test_basic
    m = M2[[0, 1], [2, 3]]
    assert_equal(m[1, 1], 3)
    m[1, 1] = 4
    assert_equal(m[1, 1], 4)
  end
  def test_rank
    assert_equal(M3[[0, 0, 0], [0, 0, 0], [0, 0, 0]].rank, 0)
    assert_equal(M3[[1, 2, 3], [-2, -4, -6], [-1, -2, -3]].rank, 1)
    assert_equal(M3[[1, 2, 3], [-2, -4, -5], [-1, -2, -2]].rank, 2)
    assert_equal(M3[[1, 2, 3], [-2, -4, -5], [-1, 0, -3]].rank, 3)
  end
  def test_inverse
    m = M3[
      [0, 1, 3],
      [1, 0, 1],
      [0, 1, 2]
    ]
    assert_equal(m * m.inverse, 1)
    assert_equal(m.inverse * m, 1)
  end
  def test_cofactor_matirx
    m = M3[
      [0, 1, 3],
      [1, 0, 1],
      [0, 1, 2]
    ]
    assert_equal(m.cofactor_matrix * m, m.unity * m.determinant)
  end

  R = Polynomial(Rational, "x")
  MR = SquareMatrix(R, 2)
  MQ = SquareMatrix(Rational, 2)
  MZ = SquareMatrix(Rational, 2)
  Z3 = ResidueClassRing(Integer, 3)
  MZ3 = SquareMatrix(Z3, 2)
#  class R0 < MatrixAlgebra
#  end
#  ME = SquareMatrix(R0, 2)

  def test_conversion
    x = R.var
    mR = MR[[x,2*x],[3*x,4*x]]
    mQ = MQ[[1,2],[3,4]]
#    mE = ME.new [[1,2],[3,4]]
    mZ = MZ[[1,2],[3,4]]
    mZ3 = MZ3[[1,2],[3,4]]
    assert_equal(MR, (mR*mQ).class)
    assert_equal(MR, (mQ*mR).class)

#    assert_raises(RuntimeError) {mR * mE}

    assert_equal(MQ, (mZ*mQ).class)
    assert_equal(MQ, (mQ*mZ).class)

    assert_equal(MZ3, (mZ3*mZ).class)
    assert_equal(MZ3, (mZ*mZ3).class)

    assert_equal(Z3, Z3.wedge(Rational))
    assert_equal(MZ3, (mZ3*mQ).class)
    assert_equal(Z3, Rational.wedge(Z3))
    assert_equal(MZ3, (mQ*mZ3).class)
  end
end

Tests(TestMatrixAlgebra)
