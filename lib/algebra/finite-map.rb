# Map of Finite Sets
#
#   by Shin-ichiro Hara
#
# Version 0.96 (2003.11.06)

require "algebra/finite-set"
require "algebra/powers"

module Algebra
  class Map < Set
    include Powers

    def self.[](a = {})
      new.instance_eval do
	@body = Hash[a]
	self
      end
    end

    def self.new_a(a)
      self[Hash[*a]]
    end

    def initialize(h = {})
      @body = h
    end

    def self.empty_set(t = nil)
      m = new()
      m.target = t if t
      m
    end
    
    class << self
      alias phi empty_set
      alias null empty_set
    end

    def self.singleton(x, y)
      new(x => y)
    end

    def base_class
      self.class.superclass
    end

    def each(&b)
      @body.each(&b)
    end

    def empty_set(s = nil)
      self.class.empty_set(s)
    end
    
    alias phi empty_set
    alias null empty_set

    def dup
      m = self.class.new(@body.dup)
      m.target = target if target
      m
    end

    def call(x)
      @body.fetch(x)
    end

    alias act call
    alias [] call

    def append!(x, y)
      @body.store(x, y)
      self
    end

    alias []= append!

    def append(x, y)
      dup.append!(x, y)
    end

    def hash
      s = 0
      @body.each_key do |k, v|
	s ^= k.hash ^ ~(v.hash)
      end
      s
    end

    def member?(a)
      return nil unless a.is_a? Array
      @body[a.first] == a.last
    end

    alias has? member?

    def domain
      base_class.new(*@body.keys)
    end
    
    def image(set = nil)
      if set
	set.map_s{|k| call(k)}
      else
	base_class.new(*@body.values)
      end
    end

    def map_s
      s = base_class.phi
      each do |x, y|
	s.append!(yield(x, y))
      end
      s
    end
    
    def map_m
      s = phi
      each do |x, y|
	s.append!(* yield(x, y))
      end
      s
    end

    def inverse
      self.class.new(@body.invert)
    end

    def compose(other)  # LEFT ACTION!!!
      m = other.map_m{|x, y| [x, call(y)]}
      m.target = target
      m
    end

    alias * compose

#  module Map_common
    
    attr_accessor :target
    alias source domain
    alias codomain target
    alias codomain= target=

    def identity?
      all?{|x, y| x == y}
    end
        
    def surjective?
      raise "target is not defined." unless @target
      image.size == target.size
    end
    
    def injective?
      image.size == source.size
    end
    
    def bijective?
      surjective? and injective?
    end
    
    def inv_image(s)
      source.separate{|x| s.member? act(x)}
    end

    def inv_coset
      s = phi
      if target
	target.each do |y|
	  s.append!(y, base_class.phi)
	end
      end
      each do |x, y|
	if s.include? y
	  s.call(y) << x
	else
	  s.append!(y, base_class.singleton(x))
	end
      end
      s
    end

    def inspect
      @body.inspect
    end

    def to_s
      @body.inspect
    end
  end
end

if $0 == __FILE__
  require "algebra/permutation-group"

  a = Algebra::Set[0, 1, 2]
  b = Algebra::Set[0, 1, 2]
  (a ** b).each do |x|
    p x
  end
end
