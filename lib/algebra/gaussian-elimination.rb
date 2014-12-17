# Gussian Elimination Algorism
#
#   by Shin-ichiro Hara
#
# Version 1.1 (2001.09.12)

module Algebra
module GaussianElimination
#ElementaryOpeartion
  def sswap_r!(i, j)
    a, b = row!(i), row!(j)
    set_row(i, b).set_row(j, a)
  end

  def swap_r!(i, j)
    a, b = row(i), row(j)
    set_row(i, b).set_row(j, a)
  end

  def swap_r(i, j)
    dup.swap_r!(i, j)
  end

  def swap_c!(i, j)
    a, b = column(i), column(j)
    set_column(i, b).set_column(j, a)
  end

  def swap_c(i, j)
    dup.swap_c!(i, j)
  end

  def multiply_r!(i, c)
    set_row(i, row(i).collect{|x| x * c})
  end

  def multiply_r(i, c)
    dup.multiply_r!(i, c)
  end

  def multiply_c!(j, c)
    set_column(j, column(j).collect{|x| x * c})
  end

  def multiply_c(j, c)
    dup.multiply_c!(j, c)
  end

  def divide_r!(i, c)
    set_row(i, row(i).collect{|x| x / c})
  end

  def divide_r(i, c)
    dup.divide_r!(i, c)
  end

  def divide_c!(j, c)
    set_column(j, column(j).collect{|x| x / c})
  end

  def divide_c(j, c)
    dup.divide_c!(j, c)
  end

  def mix_r!(i, j, c = nil)
    row_i = row(i)
    row_j = row(j)
    set_row(i, (0...csize).collect{|k|
	      row_i[k] + (c ? row_j[k]*c : row_j[k])}
	    )
  end

  def mix_r(i, j, c = nil)
    dup.mix_r!(i, j, c)
  end

  def mix_c!(i, j, c = nil)
    column_i = column(i)
    column_j = column(j)
    set_column(i, (0...rsize).collect{|k|
		 column_i[k] + (c ? column_j[k]*c : column_j[k])}
	       )
  end

  def mix_c(i, j, c = nil)
    dup.mix_c!(i, j, c)
  end

  def left_eliminate!
    inv = Algebra.SquareMatrix(ground, rsize).unity
    k = ground.unity
    pi = 0
    each_j do |j|
      if i = (pi...rsize).find{|i| !self[i, j].zero?}
#	  pivots.push j
	if i != pi
	  swap_r!(pi, i); inv.swap_r!(pi, i)
	  k = -k
	end
	##### this lets the entries be in ground #####
	c = ground.unity / self[pi, j]
	##############################################
	multiply_r!(pi, c); inv.multiply_r!(pi, c)
	k = k * c
	each_i do |i0|
	  next if i0 == pi
	  d = self[i0, j]# / self[pi, j]
	  mix_r!(i0, pi, -d); inv.mix_r!(i0, pi, -d)
	end
	pi += 1
      end
    end
    [inv, k, pi]
  end

  def _normalize!(pi, j, inv)
    c = ground.unity
    e = self[pi, j]
    if !e.unity? && e.unit?
      c /= e
      multiply_r!(pi, c); inv.multiply_r!(pi, c)
    end
    c
  end
  private :_normalize!

  def left_eliminate_euclidian!
    inv = Algebra.SquareMatrix(ground, rsize).unity
    k = ground.unity
    pi = 0
    each_j do |j|
      if i = (pi...rsize).find{|i| !self[i, j].zero?}
#	  pivots.push j
	if i != pi
	  swap_r!(pi, i); inv.swap_r!(pi, i)
	  k = -k
	end
	k *= _normalize!(pi, j, inv)
	(pi+1...rsize).each do |i0|
#	each_i do |i0|;  next if i0 == pi
	  d = self[i0, j] / self[pi, j]
	  mix_r!(i0, pi, -d); inv.mix_r!(i0, pi, -d)
	  if !self[i0, j].zero? && i0 > pi
	    swap_r!(i0, pi); inv.swap_r!(i0, pi);
	    k = -k
	    k *= _normalize!(pi, j, inv)
	    redo
	  end
	end
	
	pi += 1
      end
    end
    [inv, k, pi]
  end

  def left_inverse
    dup.left_eliminate![0]
  end

  def left_sweep
    m = dup
    m.left_eliminate!
    m
  end

  def step_matrix?
    pivots = []
    i = j = 0
    each_j do |j|
      if !self[i, j].zero?
	0.upto rsize - 1 do |i0|
	  return nil if i0 != i && !self[i0, j].zero?
	end
	pivots << j
	return pivots if (i += 1) >= rsize
      else
	(i+1).upto rsize - 1 do |i0|
	  return nil if i0 != i && !self[i0, j].zero?
	end
      end
    end
    pivots
  end

  def kernel_basis
    if pivots =  step_matrix?
      m = self
    else
      m = left_sweep
      pivots = m.step_matrix?
    end
    basis = []

    v = Algebra.Vector(ground, csize)
    (0...csize).each do |i|
      unless pivots.include? i
	base = v.vector{|j|
	  if j == i
	    ground.unity
	  elsif k = pivots.index(j)
	    -m[k, i] / m[k, j] #m[k, j] may not be an unit.
	  else
	    ground.zero
	  end
	}
	basis.push base
      end
    end
    basis
  end
end

class MatrixAlgebra
  include GaussianElimination
  def rank
    n, k, pi = dup.left_eliminate!
    pi
  end

  def orthogonal_basis
    transpose.kernel_basis
  end
end

class SquareMatrix < MatrixAlgebra
  def inverse_field
    n, k, pi = dup.left_eliminate!
    if pi != size
      raise "Error: invert non invertible SquareMatrix"
    end
    n
  end
#  def inverse_euclidian; left_inverse_euclidian; end

  def determinant_by_elimination_old
    m = dup
    inv, k = m.left_eliminate!
    s = ground.unity
    (0...size).each do |i|
      s *= m[i, i]
    end
    s / k
  end

  def determinant_by_elimination_euclidian_old
    m = dup
    inv, k = m.left_eliminate_euclidian!
    s = ground.unity
    (0...size).each do |i|
      s *= m[i, i]
    end
    s / k
  end
  
  #ground ring must be a field
  def determinant_by_elimination
    m = dup
    det = ground.unity
    each_j do |d|
      if i = (d...size).find{|i| !m[i, d].zero?}
	if i != d
	  m.sswap_r!(d, i)
	  det = -det
	end
	c = m[d, d]
	det *= c
	(d+1...size).each do |i0|
	  r = m.row!(i0)
	  q = ground.unity * m[i0, d] / c #this lets the entries be in ground
	  (d+1...size).each do |j0|
	    r[j0] -= q * m[d, j0]
	  end
	end
      else
	return ground.zero
      end
    end
    det
  end
  
  #ground ring must be an euclidian domain
  def determinant_by_elimination_euclidian#_new
    m = dup
    det = ground.unity
    each_j do |d|
      if i = (d...size).find{|i| !m[i, d].zero?}
	if i != d
	  m.sswap_r!(d, i)
	  det = -det
	end
	(d+1...size).each do |i0|
	  r = m.row!(i0)
	  q = m[i0, d] / m[d, d]
	  (d...size).each do |j0|; r[j0] -=  q * m[d, j0]; end
	  unless m[i0, d].zero?
	    m.sswap_r!(d, i0)
	    det = -det
	    redo
	  end
	end
	det *= m[d, d]
      else
	return ground.zero
      end
    end
    det
  end
  
  def determinant
    if ground.field?
      determinant_by_elimination
    elsif ground.euclidian?
      determinant_by_elimination_euclidian
    else
      determinant!
    end
  end

end
end

if $0 == __FILE__
  require "algebra/m-polynomial"
  require "algebra/polynomial"
  require "algebra/rational"
  require "algebra/matrix-algebra"
  class Rational# < Numeric
    def inspect; to_s; end
  end
#  include Algebra

  G = Algebra.MatrixAlgebra(Rational, 2, 2)
  a = G[[0, 0], [1, -1]]
  p a
  p a.kernel_basis

#  R = MPolynomial(Integer)
  R = Algebra.MPolynomial(Rational)
  a, b, c, d, e, f, g, h, i, j, k, l, x, y, z = R.vars("abcdefghijklxyz")
  M3 = Algebra.MatrixAlgebra(R, 3, 4)
  m = M3[
    [a, b, c, d],
    [e, f, g, h],
    [i, j, k, l]
  ]
  m.display
  m.swap_r(0, 2).display
#  m.set_column(1, [1,2,3]).display
#  puts
  m.swap_c(0, 2).display
  m.multiply_r(2, x).display
  m.multiply_c(0, x).display
  m.mix_r(0, 2, x).display
  m.mix_c(0, 2, x).display

  u, z = R.unity, R.zero
  require "algebra/residue-class-ring"
  F = Algebra.ResidueClassRing(Integer, 2)
#  M = SquareMatrix(Rational, 8)
  M = Algebra.SquareMatrix(F, 8)
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
  m = m - m.unity
  puts "m = "
  m.display
  m.kernel_basis.each do |b|
    puts b.class
    puts b
    #[1, 0, 0, 0, 0, 0, 0, 0]
    #[0, 1, 1, 1, 1, 1, 1, 0]
    #[0, 1, 1, 0, 1, 0, 0, 1]
  end
end
