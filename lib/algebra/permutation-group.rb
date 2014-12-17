# Permutation Group
#
#   by Shin-ichiro Hara
#
# Version 0.90 (2002.03.12)

require "algebra/powers"
require "algebra/combinatorial"
require "algebra/finite-group"

module Algebra
  class PermutationGroup < Group
    def self.unit_group(d)
      self[unity(d)]
    end

    def self.unity(n)
      Permutation.unity(n)
    end

    def self.perm(a)
      Permutation.new(a)
    end

    def self.symmetric(n)
      s = new(unity(n))
      Combinatorial.perm(n) do |x|
	s << perm(x) #unity is not duplicated naturally
      end
      s
    end
    
    def self.alternate(n)
      symmetric(n).separate{|x| x.sign > 0} #slow two times
    end

    def initialize(u, *a)
      @degree = u.degree
      super(u, *a)
    end

    attr_reader :degree
  end

  class Permutation
    include Enumerable
    include Powers

    def self.[](*a)
      new(a)
    end

    def self.unity(d)
      new((0...d).to_a)
    end

    def initialize(x)
      @perm = x
    end

    attr_accessor :perm
    
    def unity
      self.class.unity(@perm.size)
    end
    
    def degree
      @perm.size
    end

    alias size degree

    def each(&b)
      @perm.each(&b)
    end
    
    def eql?(other)
      @perm.eql?(other.perm)
    end

    alias == eql?
    
    def hash
      @perm.hash
    end
    

    def inspect; @perm.inspect; end
    def to_s; @perm.inspect; end
    
    def [](i); @perm[i] || i;  end
    
    alias call []

    #  def []=(i, x); @perm[i] = x;  end

    def index(i); @perm.index(i); end
    
    def right_act(other)# permutation's traditional product (g*h)[x] == h[g[x]]
      self.class.new(collect{|i| other[i]})
    end

    alias * right_act
    
    def left_act(other)
      self.class.new(other.collect{|i| self[i]})
    end
    
#    alias * left_act

    def inverse
      self.class.new((0...degree).collect{|i| index(i)})
    end
    
    alias inv inverse
    
    def sign
      a, b = perm.dup, inverse.perm
      s = 1
      (0...(degree-1)).each do |i|
	if (j = a[i]) != i
	  a[b[i]], b[j], s = j, b[i], -s
	end
      end
      s
    end
    
    def conjugate(g)
      g * self * g.inverse
    end
    
    def decompose_cyclic
      s = []
      remain = (0...size).to_a
      while f = remain.shift
	a = [f]
	i = f
	while true
	  j = self[i]
	  if j == f
	    s.push a if a.size > 1
	    break
	  else
	    remain.delete j
	    a.push j
	    i = j
	  end
	end
      end
      s
    end

#---------------------------- beta

#    def self.load(file)
#      s = Group[]
#      File.foreach(file) do |line|
#	g = eval(line).self
#	s.set_unity g unless s.unity
#	s.push g
#      end
#      s
#    end
    
#    def self.subgr_load(file)
#      s = Set[]
#      File.foreach(file) do |line|
#	s.push eval(line).collect{|perm| perm.self}.Group
#      end
#      s
#    end
    
#    def conjugate0(g)
#      to_Mapa.collect{|pr| [g[pr.first], g[pr.last]]}.Mapa.to_ParmGr
#    end
 
#    require "algebra/finite-map"

    def to_map
      m = Map.phi
      @perm.each_with_index do |x, i|
	m.append!(i, x)
      end
      m
    end
    
    def decompose_transposition
      a = []
      (0...degree).each do |i|
	a << [i, self[i]]
      end
      r = []
      while true
	a.delete_if{ |i, x| i == x}
	break if a.empty?
	i, x = a.shift
	x, j = alpha = a.assoc(x)
	a.delete(alpha)
	unless j == i
	  a.rassoc(i)[1] = j
	  r.unshift [i, j]
	end
	r.unshift [i, x]
      end
      r
    end
    
    def self.cyclic2perm(c, n = nil)
      unless n
	n = c.flatten.max + 1
      end
      a = (0...n).collect{|i|
	c.each do |b|
	  if j = b.index(i)
	    i = b[(j+1) % b.size]
	  end
	end
	i
      }
      new(a)
    end
  end
end

if $0 == __FILE__
  include Algebra
  a = [
    [Permutation[1, 0, 2], Permutation[2, 0, 1]],
    [Permutation[0, 2, 1]]
  ]
  PermutationGroup.generate_strong(Permutation.unity(3), *a).each do |x|
    p x
  end
  puts


  S3 = PermutationGroup.symmetric(3)
  S3.each do |x|
    p x
  end
  puts

  G = PermutationGroup.generate_strong(Permutation.unity(3),
				       [Permutation[1, 2, 0]],
					  [Permutation[2, 0, 1]])
  G.each do |x|
    p x
  end
  puts
end
