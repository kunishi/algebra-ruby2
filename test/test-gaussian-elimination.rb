#######################################################
#                                                     #
#  This is test script for 'gaussian-elimination.rb'  #
#                                                     #
#######################################################
require "rubyunit"
require "algebra/gaussian-elimination.rb"
require "algebra/m-polynomial"
require "algebra/polynomial"
require "algebra/matrix-algebra"
#require "algebra/numeric-supplement"
require "algebra/rational";class Rational<Numeric;def inspect;to_s;end;end
include Algebra

G = MatrixAlgebra(Rational, 2, 2)
R = MPolynomial(Rational)
require "algebra/residue-class-ring"
F2 = ResidueClassRing(Integer, 2)
M = SquareMatrix(F2, 8)
MR = SquareMatrix(Rational, 5)
MI = SquareMatrix(Integer, 5)
MR56 = MatrixAlgebra(Rational, 5, 7)
MI56 = MatrixAlgebra(Integer, 5, 7)

class TestGaussianElimination < Runit
  def test_left_elimination
    a0 = [
      [3, 2, 0, -1, 7, 2, 3],
      [-1, -5, 0, 2, 5, 1, 2],
      [2, -3, 0, 1, 12, 3, 5],
      [9, 2, 0, -8, 3, 4, 2],
      [7, 5, 0, -9, -9, 1, -3]
    ]
    puts
    a = MR56[*a0]
    a.display
    puts "=>"
    a.left_eliminate!
    a.display
    b0 = [
      [1,   0,   0, 0, Rational(319)/85, Rational(82)/85, Rational(134)/85],
      [0,   1,   0, 0, -Rational(4)/17, -Rational(3)/17, -Rational(2)/17],
      [0,   0,   0, 1, Rational(322)/85, Rational(46)/85, Rational(127)/85],
      [0,   0,   0, 0,   0,   0,   0],
      [0,   0,   0, 0,   0,   0,   0]
    ]
    assert_equal(MR56[*b0], a)

    puts

    a = MI56[*a0]
    a.display
    puts "=>"
    a.left_eliminate_euclidian!
    a.display
    b0 = [
      [1,   5,   0,  -2,  -5,  -1,  -2],
      [0,   1,   0, -20, -76, -11, -30],
      [0,   0,   0, -85, -322, -46, -127],
      [0,   0,   0,   0,   0,   0,   0],
      [0,   0,   0,   0,   0,   0,   0],
    ]
    assert_equal(MI56[*b0], a)
    
  end
  def test_determinant_by_elimination
    a0 = [
      [3, 2, -1, 7, 2],
      [-1, -5, 2, 5, 1],
      [2, 8, 2, -3, 1],
      [9, 2, -8, 3, 4],
      [3, -1, 3, 4, 5]
    ]
    puts
    d = MR[*a0].determinant_by_elimination
    p [d, d.type]
    assert_equal(1383, d)
    d = MI[*a0].determinant_by_elimination_euclidian
    p [d, d.type]
    assert_equal(1383, d)
  end
  def test_kernel_basis_2x2
    puts
    a = G[[0, 0], [1, -1]]
    k = a.kernel_basis
    p Hash[a, k]
    assert_equal([Vector(Rational, 2)[1, 1]], k)
  end
  def test_kernel_basis_8x8_Z2
    puts "Kernel of"
    m = M[
      "10001101".scan(/./).collect{|x|x.to_i},
      "00000011".scan(/./).collect{|x|x.to_i},
      "01001011".scan(/./).collect{|x|x.to_i},
      "00001111".scan(/./).collect{|x|x.to_i},
      "00101011".scan(/./).collect{|x|x.to_i},
      "00001001".scan(/./).collect{|x|x.to_i},
      "00011011".scan(/./).collect{|x|x.to_i},
      "00000111".scan(/./).collect{|x|x.to_i}
    ]
    cm = m - m.unity
    cm.display
    puts "is"
    k = cm.kernel_basis
    k.each do |b|
      puts "Vector(F2, 8)#{b}"
    end
    assert_equal([
		   Vector(F2, 8)[1, 0, 0, 0, 0, 0, 0, 0],
		   Vector(F2, 8)[0, 1, 1, 1, 1, 1, 1, 0],
		   Vector(F2, 8)[0, 1, 1, 0, 1, 0, 0, 1],
		 ], k)
  end
end
Tests(TestGaussianElimination)


#  R = MPolynomial(Integer)
#a, b, c, d, e, f, g, h, i, j, k, l, x, y, z = R.vars("abcdefghijklxyz")
#M3 = MatrixAlgebra(R, 3, 4)
#m = M3[
#  [a, b, c, d],
#  [e, f, g, h],
#  [i, j, k, l]
#]
#m.display
#m.swap_r(0, 2).display
#  m.set_column(1, [1,2,3]).display
#m.swap_c(0, 2).display
#m.multiply_r(2, x).display
#m.multiply_c(0, x).display
#m.mix_r(0, 2, x).display
#m.mix_c(0, 2, x).display
