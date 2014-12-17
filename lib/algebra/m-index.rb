# Multi-index class for MPolymial
#
#   by Shin-ichiro Hara
#
# Version 2.00 (2002.02.04)


module Algebra
  class MIndex
    include Enumerable

    module Lex
      def <=> (other)
	@body <=> other.to_a
      end
    end     
  
    module Grlex
      def <=> (other)
	s = (totdeg <=> other.totdeg)
	return s unless s.zero?
	@body <=> other.to_a
      end
    end

    module Grevlex
      def <=> (other)
	s = (totdeg <=> other.totdeg)
	return s unless s.zero?
	n = [size, other.size].max
	(n-1).downto 0 do |i|
	  x = other[i] - self[i]
	  return x unless x.zero?
	end
	0
      end
    end

    module V_lex
      def <=> (other)
#	n = [size, other.size].max
#	0.upto (n-1) do |i|
	V_ORDER.each do |i|
#	  x = self[V_ORDER[i]] - other[V_ORDER[i]]
	  x = self[i] - other[i]
	  return x unless x.zero?
	end
#	p [111111111, self, other]
	0
      end
    end
    
    module V_grlex
      def <=> (other)
	s = (totdeg <=> other.totdeg)
	return s unless s.zero?
#	n = [size, other.size].max
#	0.upto (n-1) do |i|
	V_ORDER.each do |i|
#	  x = self[V_ORDER[i]] - other[V_ORDER[i]]
	  x = self[i] - other[i]
	  return x unless x.zero?
	end
	0
      end
    end
    
    module V_grevlex
      def <=> (other)
	s = (totdeg <=> other.totdeg)
	return s unless s.zero?
#	n = [size, other.size].max
#	(n-1).downto 0 do |i|
	V_ORDER.reverse_each do |i|
#	  x = other[V_ORDER[i]] - self[V_ORDER[i]]
	  x = other[i] - self[i]
	  return x unless x.zero?
	end
	0
      end
    end

    def initialize(array = [])
      @body = array
    end

    def to_a
      @body
    end
    
    def empty?
      @body.empty?
    end

    def size
      @body.size
    end

    def each
      @body.each do |x|
	yield x
      end
    end

    def ==(other)
      @body == other.to_a
    end

    def eql?(other)
      @body.eql? other.to_a
    end

    def hash
      @body.hash
    end

    Unity = new

    def self.[](*ind)
      new(ind)
    end

    def unity
      Unity.dup
    end
  
    def unity?
      self == Unity
    end

    def [](i)
      @body[i] || 0
    end
    
    def []=(i, x)
      k = (self[i] = x)
      if totdeg == 0
	raise "illegal operation"
      end
      k
    end
        
    def self.monomial(idx, height = 1)
      ind0 = []
      (0..idx).each do |i|
	ind0.push(i == idx ? height : 0)
      end
      new(ind0)
    end
    
    def multideg
      @body
    end
    
    def devide?(other)
      each_with_index do |x, i|
	return false if x > other[i]
      end
      true
    end
    
    def devide_or?(other0, other1)
      each_with_index do |x, i|
	return false if x > other0[i] or x > other1[i]
      end
      true
    end
    
    def prime_to?(other)
      each_with_index do |x, i|
	return false if x > 0 && other[i] > 0
      end
      true
    end
    
    def totdeg
      s = 0
      each do |n| s += n; end
      s
    end
    
    def ==(other)
      0.upto [size, other.size].max - 1 do |i|
	return false if self[i] != other[i]
      end
      true
    end
    
    def +(other)
      self.class.new( (0 ... [size, other.size].max).collect{|i|
		 self[i] + other[i]
	       } )
    end
    
    def -(other)
      self.class.new( (0 ... [size, other.size].max).collect{|i|
		 x = self[i] - other[i]
		 raise "#{self} is not devided by #{other}" if x < 0
		 x
	       }).compact!
    end
    
    def annihilate(at)
      self - self.class.monomial(at, self[at])
    end

    def lcm(other)
      self.class.new( (0 ... [size, other.size].max).collect{|i|
		 [self[i], other[i]].max
	       })
    end
    
    def gcm(other)
      (self.class.new( (0 ... [size, other.size].max).collect{|i|
		  [self[i], other[i]].min
		})).compact!
    end
    
    def compact! # be careful, when this index is used plural places!!
      i = size - 1
      i -= 1 while i >= 0 && self[i].zero?
      @body.slice!((i+1)..(-1)) if i < size - 1
      self
    end
    
    def compact # more safe
      dup.compact!
    end
    
    def dup
      self.class.new(@body)
    end
    
    def to_s!(vars = nil, pr = nil, po = nil)
      return @body.inspect unless vars
      a = ""
      each_with_index do |n, i|
	case n
	when 0
	else
#          u = n == 1 ? vars[i].to_s : vars[i].to_s + "#{po}#{n}"
          u = if n == 1
                vars[i].to_s
              elsif /^\}/ =~ po
                "{#{vars[i]}#{po}#{n}"
              else
                "#{vars[i]}#{po}#{n}"
              end
          a.concat(a.empty? ? u : "#{pr}#{u}")
	end
      end
      a
    end
    
    def to_s(var = nil, pr = nil, po = nil)
      $DEBUG ? @body.inspect.gsub(/\s+/, '') : to_s!(var, pr, po)
    end
    
    def inspect(var = nil, po = nil)
      to_s(var, po)
    end
    
    def self.set_ord(ord)
      mod = get_module(ord)
      adopt_module(mod)
    end

    def self.set_V_ORDER(v_ord)
      const_set("V_ORDER", v_ord)
    end

    def self.set_v_ord(ord, v_ord)
      set_V_ORDER(v_ord)
      vord = get_module(ord, v_ord)
      adopt_module(vord)
    end

    def self.get_module(ord, v_ord = nil)
      ord = ord.id2name
      ord = "V_" + ord if v_ord
      eval(ord.capitalize)
    end
  end
end
