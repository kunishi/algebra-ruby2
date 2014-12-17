# Residue Class Ring
#
#   by Shin-ichiro Hara
#
# Version 1.2 (2001.04.08)

require "algebra/euclidian-ring"
require "algebra/algebraic-system"
#require "algebra/algebraic-extension-field.rb"

module Algebra
  def ResidueClassRing(klass, mod)
    ResidueClassRing.create(klass, mod)
  end

=begin
  def AlgebraicExtensionField(field, var)
    ring = Polynomial(field, var)
    k = ResidueClassRing(ring, yield(ring.var))
    def k.var; self[ground.var]; end
    k
  end
  module_function :ResidueClassRing, :AlgebraicExtensionField
=end
  module_function :ResidueClassRing

  class ResidueClassRing
    extend AlgebraCreator
    include AlgebraBase
    
    attr_reader :x
    
    def lift; @x; end
    
    def self.[](m); new(m); end
    
    def self.indeterminate(obj)
      new(ground.indeterminate(obj))
    end

    def self.**(elem)
      #elem: Polynomial, ResidueClassRing
      elem.convert_to(self)
    end
    
    def initialize(x)
      @x = x % modulus
    end
    
    def monomial?
      !@x.respond_to?(:monomial?) || @x.monomial?
     #^^^^^^^^^ numeric ^^^^^^^^^
    end

    def need_paren_in_coeff?
      if @x.respond_to?(:need_paren_in_coeff?)
        @x.need_paren_in_coeff?
      elsif @x.is_a?(Numeric)
        false
      else
        true
      end
    end
    
    def evaluate(*a)
      #p [333, @x, @x.class, a[0], a[0].class]
      #b = a[0].lift
      #c = b.evaluate(@x)
      #p [c, c.class]
      #d = self.class[c]
      #p [d, d.class]
      #k = @x.evaluate(*a)
      #p [444, k, k.class, k.lift, k.lift.class]
      self.class[@x.evaluate(*a)]
      #d
    end

    def convert_to(k)
      b = lift
      c = b.evaluate(k.ground.var)
      k[c]
    end
    
    def ==(other)
      super{ |o|
	((@x - o.x) % modulus).zero?
      }
    end
    
    def +(other)
      super{ |o|
	self.class[@x + o.x]
      }    
    end
    
    def -(other)
      super{ |o|
	self.class[@x - o.x]
      }
    end
    
    def *(other)
      super{ |o|
	self.class[@x * o.x]
      }    
    end
    
    def inverse
      return self.class.inverse(@x) if self.class.respond_to? :inverse
      return self.class[@x.inverse] if @x.respond_to? :inverse
      d, a, = @x.gcd_coeff(modulus)
      self.class.new(a / d)
    end
    
    def /(other)
      if other.is_a?(self.class)
	self * other.inverse
      else
	super{ |o|
	  self.class[@x / o.x]
	}
      end
    end
    
    def pdivmod(other); [self / other, zero]; end
    
    #  def unit?
    #    inverse
    #  end
    
    def to_s
      (@x % modulus).to_s
    end
    
    alias inspect to_s unless $DEBUG
    
    def modulus; self.class.modulus; end
    def modulus=(var); self.class.modulus = var; end
    
    def self.create(ground, mod)
      klass = super(ground)
      klass.sysvar(:modulus, mod)
      
      if mod.is_a?(Integer) && (ground <= Integer || defined?(Rational) &&
				ground <= Rational)
	klass.class_eval <<__END_OF_CLASS_DEFINITION__
	
	#      @@modulus = #{mod}
	@@inverse = [nil] + (1...@@modulus).collect{|x|
	  d, a, = x.gcd_coeff(@@modulus)
	  (y = a % @@modulus / d).zero? ? nil : y
	}
	require "algebra/prime-gen"
	def self.field?; Primes.include?(@@modulus); end
	def self.char; @@modulus; end
	def self.inverse(k); @@inverse[k]; end
	def self.to_ary; (0...@@modulus).collect{|x| self[x]}; end
	
__END_OF_CLASS_DEFINITION__
      end
      klass
    end
  end
end

if __FILE__ == $0
  include Algebra
  Z13 = ResidueClassRing.create(Integer, 13)

  a, b, c, d, e, f, g = Z13
  p [e + c, e - c, e * c, e * 2001, 3 + c, 1/c, 1/c * c,
    d / d, b * 1 / b] #=> [6, 2, 8, 9, 5, 7, 1, 1, 1]
  p( (1...13).collect{|i|  Z13[i]**12} )
          #=> [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

  require "algebra/polynomial"
  require "algebra/rational"

  Px = Polynomial(Rational, "x")
#  Px = Polynomial(Z13, "x")

  x = Px.var
  F = ResidueClassRing(Px, x**2 + x + 1)
  x = F[x]
  p( (x + 1)**100 )    #=> -x - 1

  G = Polynomial(F, "y")
  y = G.var

  p( (x + y + 1)** 7 )
    #=> y^7 + (7x + 7)y^6 + 8xy^5 + 4y^4 + (4x + 4)y^3 + 5xy^2 + 7y + x + 1

  H = ResidueClassRing(G, y**5 + x*y + 1)
  y = H[y]

  p( (x + y + 1)**7 )
    #=> 4y^4 + (3x + 4)y^3 + (5x + 6)y^2 + (x + 8)y + 6x + 1
  p( 1/(x + y + 1)**7 )
    #=> (1798/3x + 1825/9)y^4 + (-74x + 5176/9)y^3 + 
    #     (-6886/9x - 5917/9)y^2 + (1826/3x - 3101/9)y + 2146/9x + 4702/9

  require "algebra/polynomial"
#  A = Polynomial(Rational, "x")
  Z7 = ResidueClassRing.create(Integer, 7)
  A = Polynomial(Z7, "x")
  x = A.var
  B = Polynomial(A, "y")
  y = B.var
  C = Polynomial(B, "z")
  z = C.var
  D = Polynomial(C, "w")
  w = D.var
  p( (x+y+z+w)**7 ) #=> w^7 + z^7 + y^7 + x^7

  require "algebra/algebraic-extension-field.rb"
  AEF = AlgebraicExtensionField(Rational, "x") {|x| x**2 + x + 1}
  x = AEF.var
  p( (x-1)** 3 / (x**2 - 1) )
end
