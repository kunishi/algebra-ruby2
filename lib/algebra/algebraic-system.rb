# Algebraic System Library
#
#   by Shin-ichiro Hara
#
# Version 1.1 (2001.04.20)

require "algebra/numeric-supplement"
require "algebra/auto-require"

module Algebra
  module AlgebraCreator
    def create(ground)
      klass = Class.new(self)
      klass.sysvar :ground, ground
      def klass.inspect
	to_s
      end
      def klass.to_s
	s = super
	s = "(#{superclass.inspect}/#{ground.inspect})" if s =~ /^#/ #/
	s.gsub(/Algebra::/ , '')
      end
      klass
    end

    # Needed in the type conversion of MatrixAlgebra
    def wedge(otype) # =:= tensor
      if superior?(otype)
        self
      elsif otype.respond_to?(:superior?) && otype.superior?(self)
        otype
      else
        raise "wedge: unknown pair (#{self}) .wedge (#{otype})"
      end
    end

    def superior?(otype)
      if otype <= Numeric || self <= otype
        true
      elsif self.respond_to?(:ground) && self.ground.respond_to?(:superior?)
        self.ground.superior?(otype)
      else
        false
      end
    end

    def sysvar(var_name, value = nil, sw = false)
      var_name = var_name.id2name if var_name.is_a?(Symbol)
      
      class_eval <<__END_OF_CLASS_DEFINITION__
        @@#{var_name} = nil
        def self.#{var_name}; @@#{var_name}; end
        def self.#{var_name}=(value); @@#{var_name} = value; end
__END_OF_CLASS_DEFINITION__

      send(var_name + "=", value) if value

      if sw
      class_eval <<__END_OF_CLASS_DEFINITION__
        def #{var_name}; @@#{var_name}; end
        def #{var_name}=(value); @@#{var_name} = value; end
__END_OF_CLASS_DEFINITION__
      end
    end
  end
      
  module AlgebraBase
    def zero; self.class.zero; end
    def unity; self.class.unity; end
    
    def zero?; zero == self; end
    def unit?; unity == self or -unity == self; end
    def unity?; unity == self; end
    
    def ground; self.class.ground; end
    def ground=(bf); self.class.ground = bf; end
    def devide?(other)
      if self.class.field?
	true
      elsif self.class.euclidian?
	q, r = other.divmod(self)
	r.zero?
      else
	raise "don't konw #{self} divides #{other}"
      end
    end

    def regulate(x)
      self.class.regulate(x)
    end
    #  private :regulate
    
    def self.append_features(klass)
      def klass.field?
	!method_defined?(:divmod) # may be overwrited
      end
      
      def klass.euclidian?
	method_defined?(:divmod) #  may be overwrited
      end

      def klass.ufd?
	euclidian? #  may be overwrited
      end
      
      def klass.zero; new(ground.zero); end
      
      def klass.unity; new(ground.unity); end
      
      def klass.regulate(x)
	if x.is_a? self
	  x
	elsif y = ground.regulate(x)
	  new(y)
	else
	  nil
	end
      end
      super
    end
    
  # Operations
    def +@
      self
    end
    
    def -@
      zero - self
    end
    
    def ==(other)
      if o = regulate(other)
	yield o
      else
	x , y = other.coerce(self)
	x == y
      end
    end
    
    def +(other)
      if o = regulate(other)
	yield o
      else
	x , y = other.coerce(self)
	x + y
      end
    end
    
    def -(other)
      if o = regulate(other)
	yield o
      else
	x , y = other.coerce(self)
	x - y
      end
    end
    
    def *(other)
      if o = regulate(other)
	yield o
      else
	x , y = other.coerce(self)
	x * y
      end
    end
    
    def /(other)
      if o = regulate(other)
	yield o
      else
	x , y = other.coerce(self)
	x / y
      end
    end
    
    def **(n)
      if ! n.is_a? Integer or n < 0
	raise "index must be non negative integer"
      elsif n == 0
	return unity
      elsif n == 1
	self
      else
	q , r = n.divmod 2
	x = self ** q
	x = x * x
	x = x * self if r > 0
	x
      end
    end
    
    alias ^ **
      
    def coerce(other)
      if x = regulate(other)
	[x, self]
      else
	raise "(ALG.SYS) can't coerce: (#{self.class}).coerce(#{other.class}) : (#{self}).coerce(#{other})"
	  end
    end
  end
end
    
