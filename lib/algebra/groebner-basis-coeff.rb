# Groebner basis module (with coeffitients)
#
#   by Shin-ichiro Hara
#
# Version 1.2 (2001.04.03)

module Algebra
module Groebner
  def S_pair_coeff(other)
    x = lm.lcm(other.lm)
    a, b = x / lt, x / other.lt
    y = a * rt - b * other.rt
    [y, a, -b]
  end

  def self.basis_coeff_132D(g)
    gbasis = g.dup
    n0 = g.size
#    coeff = (0...n0).collect{|k| [0]*k+[1]+[0]*(n0-k-1)}
    zero, unity = f.first.zero, f.first.unity
    coeff = (0...n0).collect{|k| [zero]*k+[unity]+[zero]*(n0-k-1)}
    pairs = []
    g.each_pair_with_index do |x, y, i, j|
      pairs.push [x, y, i, j]
    end
    while pair = pairs.shift
      x, y, i, j = pair
      t, a, b = x.S_pair_coeff(y)
      q, s = t.divmod(*gbasis)
      unless s.zero?
	n1 = gbasis.size
	gbasis.each_with_index do |z, k| pairs.push([z, s, k, n1]) end
	u = (0...n0).collect {|k| sum = 0
	  (0...gbasis.size).each do |m|
	    sum += (m==i ? a-q[m] : (m==j ? b-q[m] : -q[m])) * coeff[m][k]
	  end
	  sum
	}
	coeff.push u
	gbasis.push s
      end
    end
    [coeff, gbasis]
  end

  def self.basis_coeff_159A(f)
    n0 = f.size
    glm = f.collect{|x| x.lm}
#    fc = (0...n0).collect{|k| [0]*k+[1]+[0]*(n0-k-1)}
    zero, unity = f.first.zero, f.first.unity
    fc = (0...n0).collect{|k| [zero]*k+[unity]+[zero]*(n0-k-1)}

    indexes = (0...n0).sort{|i, j| glm[i] <=> glm[j]}
    glm = glm.values_at(*indexes)
    gbasis = f.values_at(*indexes)
    coeff = fc.values_at(*indexes)

    pairs = []
    (0...n0).to_a.each_pair do |i, j|
      pairs.push [i, j]
    end

    until pairs.empty?
      i, j = pairs.first
      if !glm[i].prime_to?(glm[j]) && !_ct(glm, pairs, i, j)
	t, a, b = gbasis[i].S_pair_coeff(gbasis[j])
	q, s = t.divmod(*gbasis)
	unless s.zero?
	  0.upto glm.size-1 do |k|
	    pairs.push [k, glm.size]
	  end
	  u = (0...n0).collect {|k| sum = 0
	    (0...gbasis.size).each do |m|
	      sum += (m==i ? a-q[m] : (m==j ? b-q[m] : -q[m])) * coeff[m][k]
	    end
	    sum
	  }
	  coeff.push u
	  gbasis.push s
	  glm.push s.lm
	end
      end
      pairs.shift
    end

    [coeff, gbasis]
  end

  def self.minimal_basis_coeff(coeff, gbasis)
    glm = gbasis.collect{|x| x.lm}
    indexes = (0...gbasis.size).sort{|i, j| glm[j] <=> glm[i]}
    indexes.each_with_index do |i, s|
      (s+1).upto indexes.size-1 do |k| j = indexes[k]
	if glm[j].divide? glm[i]
	  indexes[s] = nil
	  break
	end
      end
    end
    indexes.compact!
    b = gbasis.values_at(*indexes)
    c = coeff.values_at(*indexes)
    [c, b]
  end

  def self.reduced_basis_coeff(coeff, gbasis)
    gbasis.each_with_index do |x, i|
      (g = gbasis.dup).delete_at(i)
      q, gbasis[i] = x.divmod(*g)
      coeff[i] = (0...coeff[i].size).collect {|k| sum = 0
	(0...gbasis.size).each do |m|
	  d = (m < i ? -q[m] : m == i ? 1 : -q[m-1])
	  sum += d * coeff[m][k]
	end
	sum
      }
    end
    gbasis.each_with_index do |x, i|
      c = x.lc
      coeff[i].collect!{ |v| v / c}
      gbasis[i] = x / c
    end
    [coeff, gbasis]
  end
  
  def self.basis_coeff(g)
#    coeff, gbasis = basis_coeff_132D(g)
    coeff, gbasis = basis_coeff_159A(g)
    coeff, gbasis = minimal_basis_coeff(coeff, gbasis)
    coeff, gbasis = reduced_basis_coeff(coeff, gbasis)
    ind = (0...gbasis.size).to_a
    ind.sort!{|i, j| gbasis[j] <=> gbasis[i]}
    [coeff.values_at(*ind), gbasis.values_at(*ind)]
  end

  def divmod_s0(*f)
    coeff, gbasis = Groebner.basis_coeff(f)
    q, r = divmod(*gbasis)
    q0 = (0...f.size).collect{|i| sum = 0
      (0...q.size).each do |j|
	sum += q[j]*coeff[j][i]
      end
      sum
    }
    [q0, r]
  end

  def divmod_s(*f)
    cg = Groebner.basis_coeff(f)
    div_cg(f, cg)
  end

  def div_cg(f, cg = nil)
    unless cg
      cg = Groebner.basis_coeff(f)
    end
    coeff, gbasis = cg
    q, r = divmod(*gbasis)
    q0 = (0...f.size).collect{|i| sum = 0
      (0...q.size).each do |j|
	sum += q[j]*coeff[j][i]
      end
      sum
    }
    [q0, r]
  end
end
end

if $0 == __FILE__
  require "algebra/m-polynomial"
  require "algebra/groebner-basis"
  require "algebra/algebraic-parser"
#  include Algebra

  def gbc(f)
    f0 = f.first
    print "Basis of: "
    puts(f.join(", "))
    c, g = Algebra::Groebner.basis_coeff(f)
    print "is: "
    puts(g.join(", "))
    puts "Coeefitients are: "
    c.each do |x|
      puts x.join(", ")
    end
    p 3333
    p g
    p c.collect{|x| f.inner_product x}
    
    if g == c.collect{|x| f.inner_product x}
      puts "Success!"
    else
      puts "Fail."
    end
    puts
  end

#  require "algebra/residue-class-ring"
#  Z5 = ResidueClassRing(Integer, 5)
#  P = MPolynomial(Z5)
  require "algebra/rational"
  P = Algebra.MPolynomial(Rational)

  x, y, z = P.vars("xyz")

  f1 = x**2 + y**2 + z**2 -1
  f2 = x**2 + z**2 - y
  f3 = x - z

  gbc([f1, f2, f3])

  g = x**3 + y**3 + z**3
  q, r = g.divmod_s(f1, f2, f3)
  p q
  p r
  if g == q.inner_product([f1, f2, f3]) + r
    puts "Success!"
  else
    puts "Fail."
  end
end
