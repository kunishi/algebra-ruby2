# Univariate polynomial ring class over arbitary ring
#
#   by Shin-ichiro Hara
#
# Version 1.4 (2001.04.20)

require "algebra/algebraic-system"
require "algebra/euclidian-ring"

module Algebra
  def Polynomial(ground = Integer, *variables)
    Polynomial.create(ground, *variables)
  end
  module_function :Polynomial

  class Polynomial
    include Enumerable
    include Comparable
    include EuclidianRing
    extend AlgebraCreator
    include AlgebraBase
    auto_req_init
    auto_req_s_init
    auto_req :factorize, "algebra/polynomial-factor"
    auto_req :sqfree, "algebra/polynomial-factor"
    auto_req :sqfree?, "algebra/polynomial-factor"
    auto_req :irreducible?, "algebra/polynomial-factor"
    auto_req :MatrixAlgebra, "algebra/matrix-algebra"
    auto_req :SquareMatrix, "algebra/matrix-algebra"
    auto_req(:galois_group, "algebra/galois-group" ) {
      include Galois
    }
    auto_req(:value_on, :var_swap, "algebra/polynomial-converter"){
      include PolynomialConverter
    }
    auto_req_s(:convert_to, "algebra/polynomial-converter"){
      extend PolynomialConvertTo
    }

#    auto_req(:decompose, :splitting_field, "algebra/splitting-field") {
#      include SplittingField
#    }
    auto_req(:decompose, :splitting_field, "algebra/splitting-field"){
      include Algebra::SplittingField
    }

    def initialize(*coeff)
      @coeff = coeff
    end
    
    def self.create(ground, *vs)
      if vs.empty?
	#raise "parameter objects must be given"
	vs = ["x"]
      end
      klass = super(vs.size > 1 ? create(ground, *vs[0..-2]) : ground)
      klass.sysvar(:variable, vs.last)
      klass.sysvar(:display_type, :norm)
      klass
    end
    
    def self.vars; mvar; end
    
    def self.mvar
      g = self
      a = []
      while g <= Algebra::Polynomial
	a.unshift g.var # regulate(g.var)
	g = g.ground
      end
      a
    end
    
    def self.variables
      g = self
      a = []
      while g <= Algebra::Polynomial
	a.unshift g.variable
	g = g.ground
      end
      a
    end
    
    def self.indeterminate(obj)
      if obj == variable
	new(ground.zero, ground.unity)
      else
	new(ground.indeterminate(obj))
      end
    end
    
    def self.monomial(n = 1)
      m = new(*([ground.zero] * n + [ground.unity]))
    end

    def self.to_ary
      [self, *mvar]
    end

    def monomial(n = 1)
      self.class.monomial(n)
    end
    
    def self.var
      monomial
    end
    
    def var
      self.class.monomial
    end
    
    def variable; self.class.variable; end
    
    def variable=(bf); self.class.variable = bf; end
    
    def self.const(c)
      new(c)
    end
    
    def constant?
      deg <= 0
    end
    
#  def self.[](obj)
#    ground = obj
#    monomial
#  end

    def each(&b)
      @coeff.each(&b)
    end
    
    def reverse_each(&b)
      @coeff.reverse_each(&b)
    end
    
    def size
      @coeff.size
    end
    
    def [](x)
      @coeff[x] || ground.zero
    end
    
    def []=(x, v)
      @coeff[x]= v
    end
    
    def monomial?
      flag = false
      each do |x|
	unless x.zero?
#	  if !flag && x.respond_to?(:monomial?) && x.monomial?
	  if !flag# && x.respond_to?(:monomial?) && x.monomial?
	    flag = true
	  else
	    return false
	  end
#	  if flag || !x.respond_to?(:monomial?) || !x.monomial?
#	    return false
#	  else
#	    flag = true
#	  end
	end
      end
      flag
    end
    
    def self.euclidian?
#    ground.euclidian? or ground.field?
      ground.field?
    end
    
    def compact!
      d = deg
      @coeff.slice!((d+1)..-1) if d >= 0
      self
    end
    
    def deg
      i = size - 1
      i -= 1 while i >= 0 && self[i].zero?
#    i >= 0 ? i : nil
      i
    end
    
    def ==(other)
      super {|o|
	d0, d1 = deg, o.deg
	return false unless d0 == d1
	d = d0
	0.upto d do |i|
	  return false unless self[i] == o[i]
	end
	true
      }
    end
    
    def <=>(o)
      d0, d1 = deg, o.deg
      return d0 <=> d1 unless d0 == d1
      d = d0
      if ground.method_defined? :<=>
	  0.upto d do |i|
	  c0, c1 = self[i], o[i]
	  unless (c = (c0 <=> c1)).zero?
	    return c
	  end
	end
      end
      0
    end
    
    def +(other)
      super { |o|
	d0, d1 = deg, o.deg
	d = [d0, d1].max
	a = []
	i = 0
	0.upto d do |i|
	  c = (i <= d0 ? self[i] : ground.zero)
	  d = (i <= d1 ? o[i] : ground.zero)
	  a.push( c + d )
	end
	self.class.new(*a)
      }
    end
    
    def -(other)
      super { |o|
	d0, d1 = deg, o.deg
	d = [d0, d1].max
	a = []
	i = 0
	0.upto d do |i|
	  a.push( (i <= d0 ? self[i] : ground.zero) -
		 (i <= d1 ? o[i] : ground.zero))
	end
	self.class.new(*a)
      }
    end
    
    def *(other)
      super { |o|
	d0, d1 = deg, o.deg
	return zero if d0 < 0 or d1 < 0
	
	d = [d0, d1].max
	a = (0..(d0+d1)).collect{ground.zero}
	i = j = 0
	0.upto d0 do |i|
	  0.upto d1 do |j|
	    a[i+j] += self[i]*o[j]
	  end
	end
	self.class.new(*a)
      }
    end

    def ground_div(n, d)
      if ground.field?
	n / d
      elsif ground.euclidian?
	q, r = n.divmod(d)
	raise "devide #{n} by #{d} in #{n.class}" unless r.zero?
	q
      else
	q = n / d
	r = n - q*d
	raise "devide #{n} by #{d} in #{n.class}" unless r.zero?
	q
      end
    end
    
    def divmod(o)
      raise ZeroDivisionError, "divisor is zero" if o.zero?
      d0, d1 = deg, o.deg
      if d1 <= 0
	[self.class.new(*collect{|c|
			  c / o.lc
			}), zero]
      elsif d0 < d1
	[zero, self]
      else
	tk = monomial(d0 - d1) * ground_div(lc, o.lc)
	e = rt - o.rt * tk
#      e.compact!
	q, r = e.divmod(o)
	[q + tk, r]
      end
    end
    
    def div(other)
      if o = regulate(other)
	divmod(o).first
      else
	raise "unknown divisor self.class #{other.class}"
      end
    end
    
    alias / div
    
    def rem(other)
      if o = regulate(other)
        divmod(o)[1]
      else
	raise "unknown divisor self.class #{other.class}"
      end
    end
    
    alias % rem
    
    def divide?(other)
      q, r = other.divmod(self)
      r.zero?
    end
    
    def pdivmod(other)
      if o = regulate(other)
	deg0, deg1 = deg,  o.deg
	if deg0 < deg1
	  [zero, self]
	else
	  ((o.lc)**(deg0 - deg1 + 1) * self).divmod(o)
	end
      else
	raise "unknown divisor self.class #{other.class}"
      end
    end
    
    def pdiv(other)
      if o = regulate(other)
	pdivmod(o).first
      else
	raise "unknown divisor self.class #{other.class}"
      end
    end
    
    def prem(other)
      if o = regulate(other)
	pdivmod(other).last
      else
	raise "unknown divisor self.class #{other.class}"
      end
    end
    
    def lc
      self[deg]
    end
    
    def lm
      monomial(deg)
    end
    
    def lt
      lc * lm
    end
    
    def rt
      self - lt
    end
    
    def monic
      self / lc
    end

#  def cont; @coeff.first.gcd_all(* @coeff[1..-1]); end
#  def pp; self / cont; end

    def need_paren_in_coeff?
      if constant?
        c = @coeff[0]
        if c.respond_to?(:need_paren_in_coeff?)
          c.need_paren_in_coeff?
        elsif c.is_a?(Numeric)
          false
        else
          true
        end
      elsif !monomial?
        true
      else
        false
      end
    end

    def to_s
      a = []
      case self.class.display_type
      when :code
	pr, po =  "*",  "**"
      else
	pr, po =  "",  "^"
      end

      x = variable ? variable.to_s : "x"
      each_with_index do |c, i|
        next if c.zero?
        s = case i
            when 0
              c.to_s
            else
              c = if c == 1
                    ""
                  elsif c == -1
                    "-"
                   elsif c.respond_to?(:need_paren_in_coeff?)
                     if c.need_paren_in_coeff?
                       "(#{c})" + pr
                     else
                       c.to_s + pr
                     end
                   elsif c.is_a?(Numeric)
                     c.to_s + pr
                   else
                     "(#{c})" + pr
                   end
              i == 1 ? c + x :  c + x + "#{po}#{i}"
            end
        a.unshift s
      end
      a.unshift "0" if a.empty?
      a.join(" + ").gsub(/\+ -/, "- ")
    end
    
    alias _inspect inspect
    alias inspect to_s unless $DEBUG
    
    def evaluate_old(obj)
      e = ground.zero
      reverse_each do |c|
	e = e * obj + c
      end
      e
    end
    
    def project(ring, x = ring.var)
      e = ring.zero
      n = size
      reverse_each do |c|
	n -= 1
	e = e * x + yield(c, n)
      end
      e
    end
    
    def evaluate(*a)
    #project(self.class, x){|c, n| c}
      x = a.last
      if a.size > 1
	project(ground, x){|c, n| c.evaluate(* a[0...-1])}
      elsif a.size == 1
	project(ground, x){|c, n| c}
      else
	raise "can't evaluate"
      end
    end

    def to_proc
      Proc.new{|*a| evaluate(*a)}
    end
    
    def sub(var, value)
      vs = self.class.vars
      if i = vs.index(var)
        vs = vs.dup
        vs[i] = value
        evaluate(*vs)
      else
        raise "#{var} is not a variable"
      end
    end

    alias evaluateR evaluate
    alias call evaluate
    alias callR evaluateR
    
    def projectL(ring = self.class, x = ring.var)
      e = ring.zero
      n = size
      reverse_each do |c|
	n -= 1
	e = x * e + yield(c, n)
      end
      e
    end
    
    def evaluateL(x)
      projectL(ground, x){|c, n| c}
    end
    
    alias callL evaluateL
    
    def move_const(a, coef = 1)
      evaluate(self.class.var + a*coef)
    end
    
    def convert_to(ring)
      project(ring){|c, n| c}
    end
    
    def derivate
      e = zero
      n = size - 1
      reverse_each do |c|
	e = e * var + c * n
	break if n <= 1
	n -= 1
      end
      e
    end
    
    def sylvester_matrix(o, k = 0)
      m, n = deg, o.deg
      if k.zero?
	sm = Algebra.SquareMatrix(ground, m + n - 2*k)
      else
	sm = Algebra.MatrixAlgebra(ground, m + n - 2*k, m + n - k)
      end
      sm.matrix{|i, j|
	if i < n - k
	  i0 = j - i
	  i0 >= 0 && i0 <= m ? self[m-i0] : ground.zero
	else
	  i0 = j - i + n - k
	  i0 >= 0 && i0 <= n ? o[n-i0] : ground.zero
	end
      }
    end
    
    def resultant(other)
      sylvester_matrix(other).determinant
    end
  end
end

if $0 == __FILE__
#  include Algebra
  require "algebra/residue-class-ring"
  require "algebra/mathn"

  Fx = Algebra::Polynomial.create(Integer, "x")
  x = Fx.var
  
  f = x**6 - 1
  g = (x^4) -1

#  p f.sylvester_matrix g
#  p f.resultant g


  d, t, u = f.gcd_coeff(g)
  puts "(#{t})(#{f}) + (#{u})(#{g}) = #{t * f + u * g} = #{d}"

  Fy = Algebra::Polynomial.create(Rational, "y")
  y = Fy.var

  f = y**3 - 3*y + 2
  g = y**6 - 1
  h = y**4 - 1

  p f.gcd_all(g, h)
  d, a, b, c =  f.gcd_coeff_all(g, h)

  p a*f+b*g+c*h == d

  # Polynimial is a commutative multi-variable ring
  Fxy = Algebra::Polynomial.create(Fx, "y")
  x = Fx.var
  y = Fxy.var
  p  x**2 * y**2 - y**2 * x**2 #=> 0

  require "algebra/algebraic-parser"
  p  Algebra::AlgebraicParser.eval("(x + y)**10 - (y**2 + 2*x*y + x**2)**5)", Fxy) #=> 0

  require "algebra/rational"
#  A = Polynomial.create(Rational, "x")
#  x = A.var
#  B = Polynomial.create(A, "y")
#  y = B.var
#  C = Polynomial.create(B, "z")
#  z = C.var
#  D = Polynomial.create(C, "w")
#  w = D.var
#  p( (x+y+z+w)**4 )

  K = Algebra::Polynomial.create(Integer, "x", "y", "z", "w")
  x, y, z, w = K.vars
  p( (x+y+z+w)**4 )
end
