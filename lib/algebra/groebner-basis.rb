# Groebner basis module
#
#   by Shin-ichiro Hara
#
# Version 1.3 (2001.04.03)
#
# Example:
#   x, y, z = MPolynomial.vars "xyz"
#   require "algebra/mathn"
#   p Groebner.basis([x**2 + y**2 + z**2 -1, x**2 + z**2 - y, x - z])

require "algebra/ruby-version"
require "algebra/array-supplement"
require "algebra/groebner-basis-coeff"
#require "algebra/work/old-basis"

module Algebra
module Groebner
  def S_pair(other)
    x = lm.lcm(other.lm)
    x / lt * rt - x / other.lt * other.rt
  end
  
  alias | S_pair

  def self.basis?(f)
    f.each_pair do |x, y|
      unless ((x|y) % f).zero?
	return false
      end
    end
    true
  end

  def self.minimal_basis?(f)
    return false unless basis?(f)
    indexes = (0...f.size).to_a
    indexes.each do |i|
      others = f.values_at(*(indexes-[i])).collect{|x| x.lt}
      if (f[i].lt % others).zero?
	return false
      end
    end
    true
  end

  def self.reduced_basis?(f)
    return false unless basis?(f)
    indexes = (0...f.size).to_a
    indexes.each do |i|
      others = f.values_at(*(indexes-[i])).collect{|x| x.lt}
      f[i].each_term do |t|
	if (t % others).zero?
	  return false
	end
      end
    end
    true
  end

  def self.basis_132D(f)
    gbasis = f.dup
    pairs = []
    gbasis.each_pair do |x, y|
      pairs.push [x, y]
    end
    while pair = pairs.shift
      x, y = pair
      s = (x|y) % gbasis
      unless s.zero?
	gbasis.each do |z| pairs.push([z, s]) end
	gbasis.push s
      end
    end
    gbasis
  end

  def self.basis_159A(f)
    gbasis = f.sort # little effort
    glm = gbasis.collect{|x| x.lm}
    pairs = []
    (0...glm.size).to_a.each_pair do |i, j|
      pairs.push [i, j]
    end

    until pairs.empty?
      i, j = pairs.first
      if !glm[i].prime_to?(glm[j]) && !_ct(glm, pairs, i, j)
	s = (gbasis[i]|gbasis[j]) % gbasis
	unless s.zero?
	  0.upto glm.size-1 do |k|
	    pairs.push [k, glm.size]
	  end
	  gbasis.push s
	  glm.push s.lm
	end
      end
      pairs.shift
    end
    gbasis
  end

  def self._ct(fm, b, i, j)
    0.upto fm.size-1 do |k|
      next if k == i or
	k == j or
	i < k ? b.include?([i, k]) : b.include?([k, i]) or
	j < k ? b.include?([j, k]) : b.include?([k, j])
      return true if fm[k].divide_or?(fm[i], fm[j])
    end
    false
  end

  def self.minimal_basis(gbasis)
#    p [200, gbasis]
    glm = gbasis.collect{|x| x.lm}
    indexes = (0...gbasis.size).sort{|i, j| glm[j] <=> glm[i]}
    indexes.each_with_index do |i, s|
      (s+1).upto indexes.size-1 do |k| j = indexes[k]
#	p [glm[j], glm[i],  glm[j].divide? glm[i]]
	if glm[j].divide? glm[i]
	  indexes[s] = nil
	  break
	end
      end
    end
    indexes.compact!
    gbasis.values_at(*indexes)
  end

  def self.reduced_basis(gbasis)
    gbasis.each_with_index do |x, i|
      (g = gbasis.dup).delete_at(i)
      gbasis[i] = x % g
    end
    gbasis.collect{|t| t / t.lc}
  end

  def self.basis(g)
    gbasis = nil

#    gbasis = basis_132D(g)
    gbasis = basis_159A(g)

    gbasis = minimal_basis(gbasis)
    gbasis = reduced_basis(gbasis)
    gbasis.sort!{|x, y| y <=> x}
    gbasis
  end
end

class MPolynomial
  include Algebra::Groebner
end

end

if $0 == __FILE__
  require "algebra/m-polynomial"
#  include Algebra

  def gb(f, sw = false)
    f0 = f.first
    print "Basis of: "
    sw ? puts('', *f) : puts(f.join(", "))
    gbase = Algebra::Groebner.reduced_basis(f)
    print "Is: "
    sw ? puts('', *gbase) : puts(gbase.join(", "))
    puts
  end

  puts "rational"
  require "algebra/rational"
  x, y, z = Algebra.MPolynomial(Rational).vars "xyz"
  f1 = x**2 + y**2 + z**2 -1
  f2 = x**2 + z**2 - y
  f3 = x - z
  gb([f1, f2, f3])


  puts "mod 5"
  require "algebra/residue-class-ring"
  F5 = Algebra.ResidueClassRing(Integer, 5)
  x, y, z = Algebra.MPolynomial(F5).vars "xyz"
  f1 = x**2 + y**2 + z**2 -1
  f2 = x**2 + z**2 - y
  f3 = x - z
  gb([f1, f2, f3])

  puts "require 'algebra/mathn'"
  require "algebra/mathn"
  x, y, z = Algebra.MPolynomial(Integer).vars "xyz"
  f1 = x**2 + y**2 + z**2 -1
  f2 = x**2 + z**2 - y
  f3 = x - z
  gb([f1, f2, f3])
end
