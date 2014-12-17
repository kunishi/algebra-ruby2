# Finite Set
#
#   by Shin-ichiro Hara (sinara@blade.nagaokaut.ac.jp)
#
# Version 0.96 (2003.11.06)

#require "algebra/persistence"

module Algebra
  class Set
    include Enumerable

    def self.[](*a)
      new(*a)
    end

    def self.new_a(a)
      new(*a)
    end

    def self.new_h(h)
      new.instance_eval do
	@body = h
	self
      end
    end

    def initialize(*m)
      @body = {}
      m.each do |x|
	@body.store(x, true)
      end
    end
    attr_accessor :body

    def self.empty_set
      new()
    end

    class << self
      alias phi empty_set
      alias null empty_set
    end

    def self.singleton(x)
      new(x)
    end

    def cast(klass = Set)
      x = klass.new_h(@body)
      if block_given?
	x.instance_eval do
	  yield
	end
      end
      x
    end
    
    def empty_set
      self.class.new()
    end
    
    alias phi empty_set
    alias null empty_set

    def singleton(x)
      self.class.new(x)
    end

    def singleton?
      size == 1
    end

    def size
      @body.size
    end
    
    def empty?
      @body.empty?
    end

    alias phi? empty?
    alias empty_set? empty?
    alias nul? empty?

    def each(&b)
      @body.each_key(&b)
    end

    def separate(&b)
      self.class.new(*find_all(&b))
    end
    
    alias select_s separate
    alias find_all_s separate

    def map_s(&b)
      self.class.new(*map(&b))
    end

    def pick
      each do |x|
	return x
      end
      nil
    end

    def shift
      (x = @body.shift) && x.first
    end

    def dup
      self.class.new(*to_a)
    end

    def append!(x)
      @body.store(x, true)
      self
    end

    alias push append!
    alias << append!

    def append(x)
      dup.append!(x)
    end

    def concat(other)
      case other
      when Set
	@body.update other.body
      when Array
	other.each do |x|
	  append!(x)
	end
      else
	raise "unknown self.class #{other.class}"
      end
      self
    end

    def rehash
      @body.rehash
    end

    def eql?(other)
      subset?(other) and superset?(other)
    end

    alias == eql?

    def hash
      s = 0
      @body.each_key do |k|
	s ^= k.hash
      end
      s
    end

    def include?(x)
      @body.include?(x)
    end

    alias member? include?
    alias has? include?
    alias contains? include?

    def superset?(other) # self includes other
      other.is_a?(Set) and other.all?{|x| member?(x)}
    end

    alias >= superset?
    alias incl? superset?

    def subset?(other) # self is a part of other
      other.is_a?(Set) and all?{|x| other.member?(x)}
    end

    alias <= subset?
    alias part_of? subset?

    def <(other)
      self <= other && size < other.size
    end

    def >(other)
      self >= other && size > other.size
    end

    def union(other = nil)
      if other
	h = @body.dup
	h.update other.body
	self.class.new_h(h)
      else
	u = phi
	each do |s|
	  u = u.union(s)
	end
	u
      end
    end

    alias | union
    alias + union
    alias cup union
    
    def difference(other)
      h = @body.dup
      h.delete_if {|k, v| other.include?(k)}
      self.class.new_h(h)
    end

    alias - difference

    def intersection(other = nil)
      if other
	h = @body.dup
	h.delete_if {|k, v| !other.include?(k)}
	self.class.new_h(h)
      else
	i = nil # nil is a universe?
	each do |s|
	  if i.nil?
	    i = s
	  else
	    i = i.intersection(s)
	  end
	end
	i
      end
    end

    alias & intersection
    alias cap intersection

    def each_pair
      stock = []
      each do |x|
	stock.each do |a|
	  yield a, x
	end
	stock.push x
      end
    end
    
    def each_member(n)
      if n == 0
	yield []
      elsif n == 1 #redundant but effective
	each do |x|
	  yield [x]
	end
      else
	stock = self.class[]
	each do |x|
	  stock.each_member(n-1) do |a|
	    yield a + [x]
	  end
	  stock.push x
	end
      end
    end
        
    def each_subset
      yield phi
      _each_subset do |s|
	yield s
      end
    end

    def each_non_trivial_subset # each without empty set and total set
      n = size
      _each_subset do |x|
	yield x unless x.size == n
      end
    end
    
    def _each_subset
      stock = phi
      each do |x|
	yield self.class[x]
	stock._each_subset do |a|
	  yield a + self.class[x]
	end
	stock.push x
      end
      stock
    end
    protected :_each_subset

    def power_set
      s = phi
      each_subset do |u|
	s.append! u
      end
      s
    end

    def each_product(other)
      each do |x|
	other.each do |y|
	  yield [x, y]
	end
      end
    end

    def product(other, s = phi)
      if block_given?
	each_product(other) do |x, y|
	  s.append! yield(x, y)
	end
      else
	each_product(other) do |x, y|
	  s.append! [x, y]
	end
      end
      s
    end

    alias * product

    def equiv_class(equiv = nil)
      classes = Set.phi
      if equiv && equiv.is_a?(Symbol) && !block_given?
	each do |e|
	  if c = classes.find{|s|
	      send(equiv, s.pick, e)
	    }
	    c.push e
	    classes.rehash
	  else
	    classes.push singleton(e)
	  end
	end
      elsif equiv && !block_given?
	each do |e|
	  if c = classes.find{|s|
	      equiv.call(s.pick, e)
	    }
	    c.push e
	    classes.rehash
	  else
	    classes.push singleton(e)
	  end
	end
      elsif !equiv && block_given?
	each do |e|
	  if c = classes.find{|s|
	      yield(s.pick, e)
	    }
	    c.push e
	    classes.rehash
	  else
	    classes.push singleton(e)
	  end
	end
      else
	raise "illegal call `equiv_class'"
      end
      classes
    end
    
    alias / equiv_class

    def to_s
      "{" + @body.keys.collect{|x| x.inspect}.join(', ') + "}"
    end

    def inspect
      "{" + @body.keys.collect{|x| x.inspect}.join(', ') + "}"
    end

    def to_a
      @body.keys
    end

    def to_ary
      to_a
    end

    def sort
      to_a.sort
    end

    def power(other)
      a = Map.phi(self)
      s = [a]
      other.each do |x|
	tmp = []
	each do |y|
	  s.each do |m|
	    tmp << m.append(x, y)
	  end
	end
	s = tmp
      end
      self.class[*s]
    end

    def identity_map
      a = Map.phi(self)
      each do |x|
	a.append!(x, x)
      end
      a
    end
    
    alias ** power
    
    def surjections(other)
      (self**other).separate{|m| m.surjective?}
    end
    
    def injections0(other)
      (self**other).separate{|m| m.injective?}
    end
    
    def injections(other)
      maps = Set[]
      if size < other.size
	phi;
      elsif other.empty?
	maps.push Map.phi(self)
      else
	each do |x|
	  a = self - self.class[x]
	  o = other.dup
	  h = o.shift
	  maps.concat a.injections(other)
	  maps.concat a.injections(o).map_s{|m| m.append(h, x)}
	end
      end
      maps
    end
    
    def bijections(other)
      size == other.size ? injections(other) : Set[]
    end
  end
end

module Enumerable
  unless instance_methods(true).include?("any?")
    def any?
      each{|x|
    	return true if yield(x)
      }
      false
    end
    
    def all?
      !any?{|x| !yield(x)}
    end
  end
end
