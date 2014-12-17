# Localization of Ring
#
#   by Shin-ichiro Hara
#
# Version 1.1 (2001.04.10)

require "algebra/euclidian-ring"
require "algebra/algebraic-system"

module Algebra
def LocalizedRing(ring)
  LocalizedRing.create(ring)
end

def RationalFunctionField(field, obj)
  require "algebra/polynomial"
  k = LocalizedRing(Polynomial(field, obj))
  def k.var
   self[ground.var]
  end
  def k.to_ary
    [self, var]
  end
  k
end

def MRationalFunctionField(field, *objs)
  require "algebra/m-polynomial"
  k = LocalizedRing(MPolynomial(field, *objs))
  def k.vars(*vs)
    ground.vars(*vs).map{|v| self[v]}
  end
  def k.to_ary
    [self, *vars]
  end
  k.reducible = false
  k
end

module_function :LocalizedRing, :RationalFunctionField, :MRationalFunctionField

class LocalizedRing
  extend AlgebraCreator
  include AlgebraBase

  def self.create(ground)
    klass = super(ground)
    klass.sysvar(:reducible, true)
    klass
  end

  def self.reducible
    @@reducible
  end

  def self.reducible=(sw)
    @@reducible = sw
  end
  
  attr :numerator
  attr :denominator

  def monomial?; true; end

  def self.[](num, den = nil)
    den ? reduce(num, den) : unity * num
  end

  def self.reduce(num, den)
    self.reducible ? simplify(num, den) : new(num, den)
  end

  def self.simplify(num, den)
    raise ZeroDivisionError, "denometor is 0" if den.zero?
    return zero if num.zero?

    if ground.field?
      num = num / den
      den = ground.unit
    elsif ground.ufd? #ground.euclidian?
      gcd = num.gcd(den)
      num = num / gcd
      den = den / gcd
#      num = num.div(gcd)
#      den = den.div(gcd)
    end

    #regulate the leading coefficient of polynomil
    if defined?(Polynomial) && ground <= Polynomial
      if ground.ground.field?
	 m =  den.lc
	 num /= m
        den /= m
      elsif ground.ground.euclidian? # high cost!
	 m = num.cont.gcd(den.cont)
	 num /= m
        den /= m
      end
#    elsif defined?(MPolynomial) && ground <= MPolynomial
    end

#    if den.respond_to?(:<) and den < 0
#      num = -num
#      den = -den
#    end
    new(num, den)
  end
  
  def initialize(num, den = ground.unity)
    if den.respond_to?(:<=>) and den < ground.zero
      num = -num
      den = -den
    end
    @numerator = num
    @denominator = den
  end

  def simplify
    self.class.simplify(@numerator, @denominator)
  end

  def == (o)
    super{ |o|
      @numerator * o.denominator == o.numerator * @denominator
    }
  end

  def + (o)
    super { |o|
      num = @numerator * o.denominator
      num_o = o.numerator * @denominator
      self.class.reduce(num + num_o, @denominator * o.denominator)
    }
  end
  
  def - (o)
    super{ |o|
      num = @numerator * o.denominator
      num_o = o.numerator * @denominator
      self.class.reduce(num - num_o, @denominator * o.denominator)
    }
  end
  
  def * (o)
    super{ |o|
      num = @numerator * o.numerator
      den = @denominator * o.denominator
      self.class.reduce(num, den)
    }
  end
  
  def / (o)
    raise ZeroDivisionError, "devided by 0" if o.zero?
    super{ |o|
      num = @numerator * o.denominator
      den = @denominator * o.numerator
      self.class.reduce(num, den)
    }
  end

  def unit?
    not zero? #some about
  end

  def pdivmod(other); [self / other, zero]; end

#  def % (o)
#    raise ZeroDivisionError, "devided by 0" if o.zero?
#    den, a, = @denominator.gcd_coeff(o)
#    num = (@numerator * a) % o
#    q, r = num.divmod den
#    raise "#@denominator can not divide #@numerator mod #{o}" unless r.zero?
#    q
#  end
  
  def ** (other)
    case other
    when Integer
      if other > 0
	num = @numerator ** other
	den = @denominator ** other
	self.class.new(num, den)
      elsif other < 0
	num = @denominator ** -other
	den = @numerator ** -other
	self.class.new(num, den)
      elsif other.zero?
	unity
      end
    else
      x , y = other.coerce(self)
      x ** y
    end
  end

  def need_paren_in_coeff?
    if @denominator.unity?
      if @numerator.respond_to?(:need_paren_in_coeff?)
        @numerator.need_paren_in_coeff?
      elsif @numerator.is_a?(Numeric)
        false
      else
        true
      end
    else
      false
    end
  end

  def to_s
    n = if @numerator.respond_to?(:need_paren_in_coeff?) &&
             @numerator.need_paren_in_coeff? &&
              !@denominator.unity?
	  "(#@numerator)"
	else
	  "#@numerator"
	end
    d = if @denominator.respond_to?(:need_paren_in_coeff?) &&
             @denominator.need_paren_in_coeff? &&
             !@denominator.kind_of?(Integer)
	  "(#@denominator)"
	else
	  "#@denominator"
	end
    if @denominator.unity?
      n.to_s
    else
      n + "/" + d
    end
  end
  
  def inspect
    to_s
#    sprintf("%s(%s/%s)", self.class, @numerator.inspect, @denominator.inspect)
  end

  def hash
    raise "hash is undefined"
  end
  
end
end

if __FILE__ == $0
  require "algebra/polynomial"
  require "algebra/rational"
  require "algebra/residue-class-ring"
  include Algebra

  Q = LocalizedRing(Integer)
  a = Q.new(3, 5)
  b = Q.new(5, 3)
  p [a + b, a - b, a * b, a / b, a + 3, 1 + a]

  Z13 = ResidueClassRing(Integer, 13)

  Z13x = Polynomial(Z13, "x")
  x = Z13x.var
  QZ13x = LocalizedRing(Z13x)
  a = QZ13x[x**2 + x + 1, x**2 - 1]
  b = QZ13x[x + 1, x**2 + 3*x + 2]
  p a + b
  p( (a + b) ** 4)
  puts

  Rx = Polynomial(Rational, "x")
#  Rx = Polynomial(Z13, "x")
  x = Rx.var
  QRx = LocalizedRing(Rx)
  x = QRx[x]
  a = (x**2 + 1)/(x**3 + x + 1)
  QRxy = Polynomial(QRx, "y")
  y = QRxy.var
  AFF = ResidueClassRing(QRxy, y**3 + a*y + 1)
  y = AFF[y]
  p( (y+x) ** 3 )

  F = RationalFunctionField(Rational, "x")
  x = F.var
  p ( 1 / (x**2 - 1) - 1 / (x**3 - 1) )

  require "algebra/mathn"
  require "algebra/algebraic-extension-field"
  S = AlgebraicExtensionField(Rational, "a") {|a| a**2 - 2}
  QSx = RationalFunctionField(S, "x")
  x, a = QSx.var, S.var
  p( (a/4*x + 1/2)/(x**2 + a*x + 1) + (-a/4*x + 1/2)/(x**2 - a*x + 1) )
end
