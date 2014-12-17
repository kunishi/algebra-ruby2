# Finite Group
#
#   by Shin-ichiro Hara
#
# Version 0.9 (2002.03.12)

require "algebra/finite-set"
require "algebra/prime-gen"

module Algebra
  module OperatorDomain
    def right_act(other)
      cast.product(other.cast) {|x, y| x * y}
#      product(other, self.class[unity]) {|x, y| x * y}
    end
    
    alias act right_act
    
    def left_act(other)
      other.right_act(self)
    end
    
    def right_quotient(other)
      s = Set.phi
      remain = cast.dup
      while !remain.empty?
	x = remain.shift
	t = Set[x].right_act(other)
	s.push t
	remain -= t
      end
      s
    end
    
    alias quotient right_quotient
    alias right_coset right_quotient
    alias coset right_quotient

    def left_quotient(other)
      s = Set.phi
      remain = cast.dup
      while !remain.empty?
	x = remain.shift
	t = Set[x].left_act(other)
	s.push t
	remain -= t
      end
      s
    end

    alias left_coset left_quotient

    def right_representatives(other)
      s = Set.phi
      remain = cast.dup
      while !remain.empty?
	x = remain.shift
	t = self.class[x].act(other)
	s.push x
	remain -= t
      end
      s
    end

    alias representatives right_representatives

    def left_representatives(other)
      s = Set.phi
      remain = cast.dup
      while !remain.empty?
	x = remain.shift
	t = self.class[x].left_act(other)
	s.push x
	remain -= t
      end
      s
    end

    def right_orbit!(other)
      news = Set.phi
      while true
	each_product(other) do |x, y|
	  z = x * y
	  unless include?(z) || news.include?(z)
	    news.push z
	  end
	end
	if news.empty?
	  break
	else
	  concat news
	  news = Set.phi
	end
      end
      self
    end

    alias orbit! right_orbit!
    
    def left_orbit!(other)
      other.right_orbit!(self)
    end
  end

  class Set
    include OperatorDomain
    alias * act
    alias / quotient
    alias % representatives

    def increasing_series(x = unit_group)
      a = []
      loop do
	a.push x
	if x >= (y = yield x)
	  break
	end
	x = y
      end
      a
    end

    def decreasing_series(x = self)
      a = []
      loop do
	a.push x
	if x <= (y = yield x)
	  break
	end
	x = y
      end
      a
    end
  end
  
  class Group < Set
#    include OperatorDomain
    attr_reader :unity

    def quotient_group(u)
#      raise "devided by non normal sub group" unless normal?(u)
      QuotientGroup.new(self, u)
    end

    def separate(&b)
      self.class.new(unity, *find_all(&b))
    end

    def initialize(u, *a)
      super(u, *a)
      @unity = u
    end

    attr_reader :unity

    def unit_group
      self.class.new(@unity)
    end

    def semi_complete!
      orbit!(self)
    end
    
    def semi_complete
      dup.semi_complete!
    end
    
    def complete!
      concat collect{|x| x.inverse}
      orbit!(self)
    end
    
    def complete
      dup.complete!
    end
    
    def self.generate_strong(u, *ary_of_gens)
      unless a = ary_of_gens.shift
	return new(u)
      end
      a.first != u and (a = [u] + a)
      while b = ary_of_gens.shift
	b.first != u and (b = [u] + b)
	c = []
	a.each do |x|
	  b.each do |y|
	    c.push x * y
	  end
	end
	a = c
      end
      new(*a)
    end

    def closed?
      each do |x|
	return false unless include? x.inverse
	each do |y|
	  return false unless include?(x * y)
	end
      end
      true
    end
    
    def subgroups(&b)
      e = unit_group
      if block_given?
	yield e
      end
      subgrs = Set[e, self]
      _subgroups(e, subgrs, &b)
      if block_given?
	yield self
      end
      subgrs
    end
    
    def _subgroups(h, subgrs, &b)
      while true
	new_elem = false
	((cast-h).representatives(h)).each do |a|
	  i = h.append(a).complete!
	  next if i.size == size
	  unless subgrs.include? i
	    new_elem = true
	    subgrs.push i
	    if block_given?
	      yield i
	    end
	    if defined?(Primes) and Primes.include?(size/i.size)
	    else
	      _subgroups(i, subgrs, &b)
	    end
	  end
	end
	break unless new_elem
      end
    end
    private :_subgroups

    def centralizer(s)  # C_{self}(s) not C_{s}(self) !!!!
      separate{|x| s.all?{|y| x * y == y * x}}
    end
    
    def center  # C_{self}(self)
      centralizer(self)
    end
    
    def center?(x)  # self == C_{self}(x)
      all?{|y| x * y == y * x}
    end
    
    def normalizer(s)
      separate{|x| s.right_act(Set[x]) == s.left_act(Set[x])}
    end
    
    def normal?(s)
      all?{|x| s.right_act(Set[x]) == s.left_act(Set[x])}
    end
    
    def normal_subgroups
      s = Set.phi
      subgroups.each{|x|
	if x.size == 1 or
	    x.size == size or
	    normal?(x)
	  yield x if block_given?
	  s.push x
	end
      }
      s
    end

    def conjugacy_class(x)
      (self % centralizer(Set[x])).map_s{|y| x.conjugate(y)}
    end
    
    def conjugacy_classes
      s = Set.phi
      t = cast
      until t.empty?
	x = conjugacy_class(t.pick)
	if block_given?
	  yield x
	end
	s.push x
	t -= x
      end
      s
    end
    
    def simple?
      subgroups.all?{|x|
	x.size == 1 or x.size == size or
	  !normal?(x)
      }
    end

    def commutator(h = self)
      gr = unit_group
      each do |x|
	h.each do |y|
	  gr.push x.inverse * y.inverse * x * y
	end
      end
      self == h ? gr.semi_complete! : gr.complete!
    end
    
    def D(n = 1)
      if n == 0
	self
      else
	D(n - 1).commutator D(n-1)
      end
    end
    
    def commutator_series
      decreasing_series do |s|
	s.D
      end
    end
    
    def solvable?
      commutator_series.last.size == 1
    end
    
    def K(n = 1)
      if n == 0
	self
      else
	commutator K(n-1)
      end
    end
    
    def descending_central_series
      decreasing_series do |s|
	commutator s
      end
    end
    
    def Z(n = 1)
      if n == 0
	unit_group
      else
	separate{ |x|
	  commutator(Set[x]) <= Z(n-1)
	}
      end
    end
    
    def ascending_central_series
      increasing_series do |s|
	s.Z
      end
    end
    
    def nilpotent?
      descending_central_series.last.size == 1
      #ascending_central_series.last.size == size
    end
    
    def nilpotency_class
      a = descending_central_series
      if a.last.size == 1
	a.size - 1
      else
	nil
      end
    end

    def to_a
      [unity, *(super - [unity])]
    end
  end

  #will be optimized
  class QuotientGroup < Group
    def initialize(univ, u)
      @univ = univ
      super(u, *univ.quotient(u))
    end

    def inverse
      map_s{|x| x.inverse}
    end
    
    alias inv inverse
  end

end

if __FILE__ == $0
  
end
