# Matrix Algebra Triplet
#
#   by Shin-ichiro Hara
#
# Version 1.0 (2001.11.01)

require "algebra/gaussian-elimination"
require "algebra/elementary-divisor"

module Algebra

class MatrixAlgebra
  def to_triplet
    Algebra::MatrixAlgebraTriplet.new(self)
  end

  def to_quint
    Algebra::MatrixAlgebraQuint.new(self)
  end
end

class MatrixAlgebraTriplet
  include GaussianElimination
  include ElementaryDivisor

  attr_reader :left, :body, :right, :ground
  def initialize(matrix, left = nil, right = nil)
    @body = matrix
    @type = @body.class
    @ground = @type.ground
    @left_type = Algebra.SquareMatrix(@type.ground, @type.rsize)
    @right_type = Algebra.SquareMatrix(@type.ground, @type.csize)
    @left = left ? left : @left_type.unity
    @right = right ? right : @right_type.unity
  end

  def to_ary
    [body, left, right]
  end

  alias to_a to_ary

  def dup
    self.class.new(body.dup, left.dup, right.dup)
  end

  def transpose
    self.class.new(body.transpose, right.transpose, left.transpose)
  end

  def replace(other)
    initialize(other.body, other.left, other.right)
    self
  end

  def display
    puts "============= begin"
    @left.display
    puts
    @body.display
    puts
    @right.display
    puts "============= end"
  end

  def [](i, j)
    @body[i, j]
  end

  def rsize
    @body.rsize
  end

  def csize
    @body.csize
  end

  def each_i(&block)
    @body.each_i(&block)
  end

  def each_j(&block)
    @body.each_j(&block)
  end

  def row!(i)
    @body.row!(i)
  end
    

#ElementaryOpeartion
  def sswap_r!(i, j)
    @left.sswap_r!(i, j)
    @body.sswap_r!(i, j)
    self
  end

  def swap_r!(i, j)
    @left.swap_r!(i, j)
    @body.swap_r!(i, j)
    self
  end

#  def swap_r(i, j)
#    dup.swap_r!(i, j)
#  end

  def swap_c!(i, j)
    @body.swap_c!(i, j)
    @right.swap_c!(i, j)
    self
  end

#  def swap_c(i, j)
#    dup.swap_c!(i, j)
#  end

  def multiply_r!(i, c)
    @left.multiply_r!(i, c)
    @body.multiply_r!(i, c)
    self
  end

#  def multiply_r(i, c)
#    dup.multiply_r!(i, c)
#  end

  def multiply_c!(j, c)
    @body.multiply_c!(j, c)
    @right.multiply_c!(j, c)
    self
  end

#  def multiply_c(j, c)
#    dup.multiply_c!(j, c)
#  end

  def divide_r!(i, c)
    @left.divide_r!(i, c)
    @body.divide_r!(i, c)
  end

#  def divide_r(i, c)
#    dup.divide_r!(i, c)
#  end

  def divide_c!(j, c)
    @body.divide_c!(j, c)
    @right.divide_c!(j, c)
  end

#  def divide_c(j, c)
#    dup.divide_c!(j, c)
#  end

  def mix_r!(i, j, c = nil)
    @left.mix_r!(i, j, c)
    @body.mix_r!(i, j, c)
    self
  end

#  def mix_r(i, j, c = nil)
#    dup.mix_r!(i, j, c)
#  end

  def mix_c!(i, j, c = nil)
    @body.mix_c!(i, j, c)
    @right.mix_c!(i, j, c)
    self
  end

#  def mix_c(i, j, c = nil)
#    dup.mix_c!(i, j, c)
#  end

  def left_eliminate!
#    inv = Algebra.SquareMatrix(ground, rsize).unity
    k = ground.unity
    pi = 0
    each_j do |j|
      if i = (pi...rsize).find{|i| !self[i, j].zero?}
	if i != pi
	  swap_r!(pi, i)#; inv.swap_r!(pi, i)
	  k = -k
	end
	c = ground.unity / self[pi, j] # this lets the entries be in ground
	multiply_r!(pi, c)#; inv.multiply_r!(pi, c)
	k = k * c
	each_i do |i0|
	  next if i0 == pi
	  d = self[i0, j]# / self[pi, j]
	  mix_r!(i0, pi, -d)#; inv.mix_r!(i0, pi, -d)
	end
	pi += 1
      end
    end
    [left, k]
  end
end

class MatrixAlgebraQuint < MatrixAlgebraTriplet
  attr_reader :lefti, :righti
  def initialize(matrix, left = nil, right = nil, lefti = nil, righti = nil)
    super(matrix, left, right)
    @lefti = lefti ? lefti : @left_type.unity
    @righti = righti ? righti : @right_type.unity
  end

  def to_ary
    [body, left, right, lefti, righti]
  end

  alias to_a to_ary

  def dup
    self.class.new(body.dup, left.dup, right.dup, lefti.dup, righti.dup)
  end

  def transpose
    self.class.new(body.transpose, right.transpose, left.transpose,
	     righti.transpose, lefti.transpose)
  end

  def replace(other)
    initialize(other.body, other.left, other.right, other.lefti, other.righti)
    self
  end

#ElementaryOpeartion
  def sswap_r!(i, j)
    @lefti.swap_c!(i, j) # sswap_c doesn't exist
    super
  end

  def swap_r!(i, j)
    @lefti.swap_c!(i, j)
    super
  end

  def swap_c!(i, j)
    @righti.swap_r!(i, j)
    super
  end

  def multiply_r!(i, c)
    @lefti.divide_c!(i, c)
    super
  end

  def multiply_c!(j, c)
    @righti.divide_r!(j, c)
    super
  end

  def divide_r!(i, c)
    @lefti.multiply_c!(i, c)
    super
  end

  def divide_c!(j, c)
    @righti.multiply_r!(j, c)
    super
  end

  def mix_r!(i, j, c = nil)
    @lefti.mix_c!(j, i, c ? -c : -1)
    super
  end

  def mix_c!(i, j, c = nil)
    @righti.mix_r!(j, i, c ? -c : -1)
    super
  end
end

end

if $0 == __FILE__
  require "algebra/m-polynomial"
  require "algebra/polynomial"
  require "algebra/rational"
  require "algebra/matrix-algebra"
#  class Rational# < Numeric
#    def inspect; to_s; end
#  end
#  include Algebra

  G = Algebra.MatrixAlgebra(Rational, 2, 2)
  a = G[[1, 1], [1, -1]]
  a0 = Algebra::MatrixAlgebraTriplet.new(a)
  a0.display
  a0.left_eliminate!
  puts "-------"
  a0.display
#  p a.kernel_basis
end
