# MatrixAlgebra over Ring
#
#   by Shin-ichiro Hara
#
# Version 1.05 (2003.06.24)

require "algebra/algebraic-system"
require "algebra/gaussian-elimination"

module Enumerable
  def collecti
    a = []
    each_with_index do |x, i|
      a.push yield(x, i)
    end
    a
  end

  def sum(z)
    sum = z
    each do |i|
      sum += yield(i)
    end
    sum
  end
end

module Algebra
def MatrixAlgebra(ground, rsize, csize)
  MatrixAlgebra.create(ground, rsize, csize)
end

def SquareMatrix(ground, size)
  SquareMatrix.create(ground, size)
end

def Vector(ground, size)
  Vector.create(ground, size)
end

def Covector(ground, size)
  Covector.create(ground, size)
end
module_function :MatrixAlgebra, :SquareMatrix, :Vector, :Covector

class MatrixAlgebra
  extend AlgebraCreator
  include AlgebraBase
  include Enumerable
  auto_req_init
  auto_req :solve_eigen_value_problem, "algebra/linear-algebra"
  auto_req :diagonalize, "algebra/linear-algebra"
  auto_req :to_triplet, "algebra/matrix-algebra-triplet"
  auto_req :to_quint, "algebra/matrix-algebra-triplet"
  auto_req :e_inverse, "algebra/elementary-divisor"
  auto_req :elementary_divisor, "algebra/elementary-divisor"
  auto_req :e_diagonalize, "algebra/elementary-divisor"
  auto_req :e_diagonalize!, "algebra/elementary-divisor"
  autoload :JordanForm, "algebra/jordan-form"
  auto_req :jordan_form, "algebra/jordan-form"
  auto_req :jordan_form_info, "algebra/jordan-form"

  Matrices = {}

  def initialize(array, conv = false)
    raise "rsize error (#{array.size} for #{rsize})" if array.size != rsize
    array.each do |v|
      raise "csize error (#{v.size} for #{csize})" if v.size != csize
    end
    if conv
      @bone = array.collect{|cv| cv.collect{|x| 
          ground.regulate(x) or
            raise "initialize: unknown type #{x.class} (#{x})"
        }}
    else
      @bone = array
    end
  end

  def dup
#    matrix{|x| self[* x.collect{|y| y.dup}]}
#    matrix{|x| self[* x.collect{|y| y}]} #in 1.8.0, Integer can't be dup..
    matrix{|i, j| self[i, j]} #in 1.8.0, Integer can't be dup..
  end

  def replace(m)
    if m.is_a?(self.class) and sizes == m.sizes
      each_index do |i, j|
	@bone[i][j] = m[i, j]
      end
    else
      raise "Type Error #{m.class}"
    end
  end

  def simplify; matrix{|i, j| self[i, j].simplify}; end

  def self.matrices; Matrices; end

  def self.[](*a)
     new(a, true)
  end

  ############################################
  #
  # matrix type conversion
  #
  #############################################

  def self.*(otype)
    if csize != otype.rsize
      raise "type error (#{self} * #{otype}, #{csize}:#{otype.rsize})"
    end

    if ground.respond_to?(:wedge)
      g = ground.wedge otype.ground
    elsif ground <= Numeric
      g = otype.ground
    else
      raise "*: unkown type conversion (#{ground}) * (#{oground})"
    end

    if otype <= Vector
      Algebra::Vector.create(g, rsize)
    elsif self <= Covector
      Algebra::Covector.create(g, csize)
    elsif rsize == otype.csize
      SquareMatrix.create(g, rsize)
    else
      MatrixAlgebra.create(g, rsize, otype.csize)
    end
  end

#  def self.vector_type
#    Algebra::Vector.create(ground, rsize)
#  end

#  def self.covector_type
#    Algebra::Covector.create(ground, csize)
#  end

  def self.minor
    if self <= SquareMatrix
      superclass.create(ground, size-1)
    elsif self <= MatrixAlgebra
      superclass.create(ground, rsize-1, csize-1)
    else
      raise "minor: unknown type #{self.class}"
    end
  end

  def self.dsum(otype)
    #unless ground == otype.ground
    #  raise "type error #{ground}.dsum #{otype.ground}"
    #end
    if self <= SquareMatrix and otype <= SquareMatrix
      superclass.create(ground, size + otype.size)
    else
      superclass.create(ground, rsize + otype.rsize, csize + otype.csize)
    end
  end

  def self.dsum_r(otype); raise "not implemented"; end

  def self.dsum_c(otype); raise "not implemented"; end

  ################################


#  def [](i, j = nil)
#    j ? @bone[i][j] : @bone[i]
#  end

  def [](i, j)
    @bone[i][j]
  end

  def []=(i, j, x)
    @bone[i][j] = x
  end

  def rows
    (0...rsize).collect{|i| row(i)}
  end

  def row(i)
    raise "size error" unless 0 <= i && i < rsize
    @bone[i].clone
  end

  def row!(i) # column!(j) is not defined!
    raise "size error" unless 0 <= i && i < rsize
    @bone[i]
  end

  def set_row(i, array)
    raise "size error" unless 0 <= i && i < rsize
    raise "size error" unless csize == array.size
    @bone[i] = array
    self
  end

  def columns
    (0...csize).collect{|j| column(j)}
  end

  def vectors
#    vc = self.class.vector_type
    vc = Algebra::Vector.create(ground, rsize)
    columns.collect{|v| vc[*v]}
  end

  def column(j)
    raise "size error" unless 0 <= j && j < csize
    (0...rsize).collect{|i| @bone[i][j]}
  end

  def set_column(j, array)
    raise "size error" unless 0 <= j && j < csize
    raise "size error" unless rsize == array.size
    (0...rsize).each{|i| @bone[i][j] = array[i]}
    self
  end


  def sizes; self.class.sizes; end
  def rsize; self.class.rsize; end
  def csize; self.class.csize; end

  def self.create(ground, rsize, csize)
    if klass = matrices[[ground, rsize, csize]] #flyweight
      klass
    else
      klass = super(ground)
      klass.sysvar(:sizes, [rsize, csize])
      klass.sysvar(:rsize, rsize)
      klass.sysvar(:csize, csize)
      matrices[[ground, rsize, csize]] = klass
      klass
    end
  end

  def self.transpose
    if sizes == [csize, rsize]
      self
    else
      superclass.create(ground, csize, rsize)
    end
  end

  def to_s
    @bone.inspect
  end

  def display(out = $stdout)
    @bone.each do |col|
#      out << col.inspect << "\n"
      first = true
      col.each do |x|
	if first
	  first = false
	else
	  out << ", "
	end
	out << sprintf("%3s", x)
      end
      out << "\n"
    end
    out
  end

  def display_by_latex(out = $stdout)
#    out << "\\left(\n"
#    out "\\begin{array}{" + "c" * @bone[0].size + "}\n"
    @bone.each do |col|
#      out << col.inspect << "\n"
      first = true
      col.each do |x|
	if first
	  first = false
	else
	  out << " & "
	end
	out << sprintf("%3s", x)
      end
      out << "\\\\\n"
    end
#    out << "\\end{array}"
#    out << "\\right)"
    out
  end

  def latex(env = "pmatrix")
    s = ""
    s << "\\begin{#{env}}\n" if env
    s << display_by_latex("")
    s << "\\end{#{env}}\n" if env
    s
  end

  def inspect
    "#{self.class}#{to_s}"
  end

  #check entries
  def types
    matrix{|i, j| self[i, j].class}
  end

  def self.zero
#    new((0...rsize).collect{(0...csize).collect{ground.zero}})
    matrix{ground.zero}
  end
    
  def self.regulate(x)
    case x
    when Vector, Covector, MatrixAlgebra #,SquareMatrix
      x
    else
      nil
    end
  end

  def coerce(other)#MatrixAlgebra
    if x = ground.regulate(other)
      [Algebra::Scalar.new(x), self]
    else
      super
    end
  end

  def each(&b)
    @bone.each(&b)
  end

  def self.each_index
    (0...rsize).each do |i|
      (0...csize).each do |j|
	yield i, j
      end
    end
  end

  class << self
    alias each_ij each_index
  end

  def each_index(&b)
    self.class.each_index(&b)
  end

  alias each_ij each_index

  def each_i
    (0...rsize).each do |i|
      yield i
    end
  end
  
  def each_j
    (0...csize).each do |j|
      yield j
    end
  end

  def each_row
    (0...rsize).each do |i|
      yield row(i)
    end
  end

  def each_column
    (0...rsize).each do |i|
      yield column(i)
    end
  end
  
  def ==(other)
    super{ |o|
      rais "type error" unless sizes == o.sizes
      each_index do |i, j|
	return false unless self[i, j] == o[i, j]
      end
      true
    }
  end

  def self.collect_ij(m = rsize, n = csize)
    (0...m).collect do |i|
      (0...n).collect do |j|
	yield(i, j)
      end
    end
  end
  
  def collect_ij(*x, &b); self.class.collect_ij(*x, &b); end

  def self.matrix(m = rsize, n = csize)
    new(collect_ij(m, n) {|i, j| yield i, j})
  end

  def matrix(m = rsize, n = csize)
    self.class.matrix(m, n){|i, j| yield i, j}
  end

  def minor(i, j)
    self.class.minor.matrix{|a, b|
      self[a < i ? a : a+1, b < j ? b : b+1]
    }
  end

  def cofactor(i, j)
    minor(i, j).determinant * (-1)**(i+j)
  end

  def cofactor_matrix
    self.transpose.matrix{|i, j| cofactor(j, i)}
  end

  alias adjoint cofactor_matrix
  
  def self.collect_row(m = rsize)
    new((0...m).collect{|i| yield i})
  end

  def collect_row(m = rsize)
    self.class.collect_row(m){|i| yield i}
  end

  def self.collect_column(n = csize)
    columns = (0...n).collect{|j| yield j}
    matrix{|i, j| columns[j][i]}
  end

  def collect_column(n = csize)
    self.class.collect_columns(n){|j| yield j}
  end
  
  def +(other)
    super{ |o|
      raise "type error" unless sizes == o.sizes
      matrix{|i, j| self[i, j] + o[i, j]}
    }
  end

  def -(other)
    super{ |o|
      raise "type error" unless sizes == o.sizes
      matrix{|i, j| self[i, j] - o[i, j]}
    }
  end

  def old_mul(other)
    #without regulation
    case other
    when ground, Numeric # 1.is_a?(Rational) is false
      matrix{|i, j| self[i, j]*other}
    else
      super{|o|
        msize = csize
        raise "type error" unless msize == o.rsize
        (self.class * o.class).matrix(rsize, o.csize){|i, j|
          (0...msize).sum(ground.zero){|k| self[i, k] * o[k, j]}
        }
      }
    end
  end

  def *(other)
    #without regulation!
    if other.is_a?(ground) || other.is_a?(Numeric)#1.is_a?(Rational) is false
      matrix{|i, j| self[i, j]*other}
    elsif self.is_a?(other.ground)
      other.matrix{|i, j| self*other[i, j]}
    else
      super{|o|
        msize = csize
        raise "type error" unless msize == o.rsize
        (self.class * o.class).matrix(rsize, o.csize){|i, j|
          (0...msize).sum(ground.zero){|k| self[i, k] * o[k, j]}
        }
      }
    end
  end

  def /(other)
    case other
    when ground, Numeric
      matrix{|i, j| self[i, j] / other}
    else
      raise "(/): unknown type #{other.class}"
    end
  end

  def map
    matrix{|i, j| yield(self[i, j])}
  end

  def transpose
    self.class.transpose.matrix(csize, rsize){|i, j| self[j, i]}
  end

  alias t transpose

  def dsum(other)
    mytype = self.class.dsum(other.class)
    mytype.matrix{|i, j|
      if i < rsize
	if j < csize
	  self[i, j]
	else
	  other.ground.zero
	end
      else
	if j < csize
	  ground.zero
	else
	  other[i - rsize, j - csize]
	end
      end
    }
  end

  def to_ary
    to_a
  end

  def flatten
    #'to_a' is defined in Enumerable
    to_a.flatten
  end

  def diag
    ed = []
    size = rsize < csize ? rsize : csize
    (0...size).each do |i|
      break if self[i, i].zero?
      ed.push self[i, i]
      end
    ed
  end

  def convert_to(mat_alg)
    mat_alg.matrix{|i, j| mat_alg.ground.regulate(self[i, j])}
  end

  def self.convert_from(m)
    matrix{|i, j| m[i, j].convert_to(ground)}
  end

  def self.**(m)
    m.convert_to(self)
  end
end

module InnerProductSpace
  def inner_product(other)
    ip = defined?(ground) ? ground.zero : first.zero
    each_with_index do |x, i|
      ip += x * other[i]
    end
    ip
  end
  
  def inner_product_complex(other)
    inner_product(other.conjugate)
  end

  def norm2
    inner_product(self)
  end

  def norm2_complex
    inner_product_complex(self)
  end
end

class Vector < MatrixAlgebra
  include InnerProductSpace

  Matrices = {}

  def initialize(array, conv = false)
    @bone0 = array
    super(array.collect{|x| [x]}, conv)
  end

  def each
    @bone0.each do |x|
      yield x
    end
  end
  
  def size; self.class.size; end
  
  #def to_a
  #  column(0)
  #end

  def [](*x)
    case x.size
    when 1
      super(x[0], 0)
    when 2
      super(*x)
    else
      raise "size of index be 1 or 2"
    end
  end
  
  def self.create(ground, n)
    klass = super(ground, n, 1)
    klass.sysvar(:size, n)
    klass
  end
  
  def transpose
    Algebra::Covector.create(ground, size).new(to_a)
  end
  
  def self.vector(conv = false, &b)
    new((0...size).collect(&b), conv)
  end

  def self.[](*a)
    vector(true){|i| a[i]}
  end
  
  def self.matrix(r = size, s = 1)
    vector{|i| yield(i, 0)}
  end
  
  def inspect
    @bone0.inspect
  end
  
  def to_s
    @bone0.inspect
  end
end

class Covector < MatrixAlgebra
  include InnerProductSpace

  Matrices = {}

  def initialize(array, conv = false)
    @bone0 = array
    super([array], conv)
  end

  def each
    @bone0.each do |x|
      yield x
    end
  end
  
  def size; self.class.size; end
  
  #    def to_a
  #      row(0)
  #    end
  
  def [](*x)
    case x.size
    when 1; super(0, x[0])
    when 2; super(*x)
    else
      raise "size of index be 1 or 2"
    end
  end
  
  def self.create(ground, n)
    klass = super(ground, 1, n)
    klass.sysvar(:size, n)
    klass
  end
  
  def transpose
    Algebra::Vector.create(ground, size).new(to_a)
  end
  
  def self.[](*a)
    covector(true){|i| a[i]}
  end
  
  def self.covector(conv = false, &b)
    new((0...size).collect(&b), true)
  end

  def self.matrix(r = 1, s = size)
    covector{|j| yield(0, j)}
  end

  def inspect
    @bone0.inspect
  end
  
  def to_s
    super
  end
end
  
class SquareMatrix < MatrixAlgebra
  Matrices = {}
  
  def self.unity
    matrix{|i, j| i == j ? ground.unity : ground.zero }
  end
  
  def self.const(x)
    matrix{|i, j| i == j ? ground.regulate(x) : ground.zero }
  end
  
  def const(x)
    self.class.const(x)
  end
  
  def self.matrices
    Matrices
  end
  
  def initialzie(array, conv = false)
    super
  end
  
  def self.create(ground, n, m = nil)
    if m && n != m
      raise "type error to create SquareMatrix"
    end
    klass = super(ground, n, n)
    klass.sysvar(:size, n)
    klass
  end
  
  def size; self.class.size; end
  
  def self.regulate(x)
    if x.is_a? superclass #SquareMatrix
      x
    elsif y = ground.regulate(x)
      const(y)
    else
      super
    end
  end

  def self.determinant(aa)
    r = create(Integer, aa.size)
    m = r.new(aa)
    m.determinant
  end

  class << self
    alias det determinant
  end

  def /(other)
    #It might be better to use regulate ...
    case other
#    when ground, Numeric
#      matrix{|i, j| self[i, j] / other}
    when self.class.superclass #SquareMatrix
      self * other.inverse
    else
      super
    end
  end
  
  def determinant
    sum = ground.zero
    perm do |idx|
      product = ground.unity
      idx.each_with_index do |i, j|
	product *= self[i, j]
      end
      sum += product * sign(idx)
    end
    sum
  end
  
  alias determinant! determinant
  alias det determinant

  def inverse
    #gaussian-elimination.rb
    if ground.field? &&
        (!ground.respond_to?(:reducible) || ground.reducible)
      inverse_field
    else
      a = adjoint
      d = determinant
      unless d.unit?
        warn("#{a}/#{d} may not be done.")
      end
      a / d
    end
  end
  
  def sign(a)
    n = a.size
    a = a.dup
    b = (0...n).collect{|i| a.index(i)}
    s = 1
    (0...(n-1)).each do |i|
      if (j = a[i]) != i
	a[b[i]], b[j], s = j, b[i], -s
      end
    end
    s
  end
  
  def perm(n = size, stack = [])
    (0...n).each do |x|
      unless stack.include? x
	stack.push x
	if stack.size < n
	  perm(n, stack) do |y|; yield y; end
	else
	  yield stack
	end
	stack.pop
      end
    end
  end
  
  def char_polynomial0(obj = "x")
    require "algebra/polynomial"
    a = Algebra.Polynomial(ground, obj)
    k = Algebra.SquareMatrix(a, size)
    (k.unity * a.var - self).determinant
    #    (k.unity * a.var - k.matrix{|i, j| self[i,j]}).determinant
  end

  def _char_matrix(mop)
    # assume mop.ground.ground == self.ground
    mop.unity * mop.ground.var - self
  end

  def char_matrix(polyring)
    matrix_over_poly = Algebra.SquareMatrix(polyring, size)
    _char_matrix(matrix_over_poly)
  end

  def char_polynomial(polyring)
    matrix_over_poly = Algebra.SquareMatrix(polyring, size)
    _char_matrix(matrix_over_poly).determinant
  end
end

class Scalar # fake class for SCALAR * MATRIX
  def initialize(x)
    @value = x
  end
  
  def +(other)
    case other
    when Algebra::SquareMatrix
      other.const(@value) + other
    else
      raise "Fail: Scalar(#{@value}) + #{other}"
    end
  end
  
  def -(other)
    case other
    when Algebra::SquareMatrix
      other.const(@value) - other
    else
      raise "Fail: Scalar(#{@value}) - #{other}"
    end
  end
  
  def *(other)
    case other
    when Algebra::MatrixAlgebra
      other.matrix{|i, j| @value * other[i, j]}
    else
      raise "Fail: Scalar(#{@value}) * #{other}"
    end
  end
end
end

if $0 == __FILE__
#  include Algebra
  M33 = Algebra.MatrixAlgebra(Integer, 3, 3)
  M34 = Algebra.MatrixAlgebra(Integer, 3, 4)
  a33 = [
    [1, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]
  m0 = M33.new(a33)
  m0[0, 0] = 0
  m1 = M33[
    [10, 11, 12],
    [13, 14, 15],
    [16, 17, 18]]
  m2 = M34[[20, 21, 22, 23], [24, 25, 26, 27], [28, 29, 30, 31]]
  p m0 + m1
  p m0 * m0
  p( (m0 * m0).t )
  m = m0 * m2
  M43 = M34.transpose
  p M34.sizes
  p M43.sizes
  M44 = M43 * M34
  p m2.t * m2
  p m0.dsum(m1).display


  require "algebra/rational"

  M3 = Algebra.SquareMatrix(Rational, 3)
  m3 = M3[
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]]

#  require "algebra/polynomial"
#  Px =  Algebra.Polynomial(Rational, "x")
#  require "algebra/polynomial"
#  p f = m3.char_polynomial(Px)
end
