# Galois Group
#
#   by Shin-ichiro Hara
#
# Version 1.13 (2002.07.22)
#
# This algorithm is founded on the paper:
# "Computaion of the splitting fields and the Galois groups of polynomials"
# by H. Anai, M. Noro and K. Yokoyama
# (Progress in Mathematics, 29-50, Vol. 143, 1996, Birkhuaser Verlag 
#  Basel/Swizerland)

require "algebra/ruby-version"
require "algebra/permutation-group"

module Algebra
  module Galois
    def galois_group(pre_facts = nil, sw = nil)
      # sw : Ordinary, sw is asumed to be nil.

      poly = sqfree

      sf = poly.splitting_field(pre_facts, nil, true)

      gens = []
      reps0 = []
      n = poly.deg
      dpn = sf.def_polys.size
      for i in 0...dpn do
	reps = []
	for j in (sw ? i : i+1)...n do
	  if g = prolong((0...i).to_a + [j], sf)
	    reps << g
	  end
	end
	gens.unshift reps
	#      gens.push reps
      end
      
      for i in dpn...n; gens << [(0...n).to_a]; end if sw
      gs = gens.map{|a| a.map{|g| complete(g, sf)}}
      ary_of_gens = gs.collect{|a| a.collect{|x| Permutation.new(x)}}
      PermutationGroup.generate_strong(Permutation.unity(n), *ary_of_gens)
    end
    
    def prolong(ary, sf)
      #INPUT
      #  ary: a set of defining polynomial
      #  sf: splitting field
      #OUTPUT:
      #  ary0: the first l-part of g if g exists; nil other wize

      t = ary.size
      roots = sf.proots

      pn = sf.def_polys.size
      defs = sf.def_polys
      for i in 0...t do
	r = (roots.values_at(*ary))[0..i]
	unless defs[i].abs_lift.evaluate(*r).zero? # this eval. needs no_sq
	  return nil
	end
      end

      ary0 = ary.dup
      for k in t...defs.size do
	sw = false
	for c in (0...roots.size).to_a - ary0 do
	  r = (roots.values_at(* ary0+[c]))[0..k]
	  if defs[k].abs_lift.evaluate(*r).zero? # this eval. needs no_sq
	    ary0.push c
	    sw = true
	    break
	  end
	end
	return nil unless sw
      end
      ary0
    end
    
    def complete(ary, sf)
      # INPUT:
      #   ary: the first l-part of g
      #   sf: splitting field
      # OUTPUT:
      #   ary0: the complete expression of g

      ary0 = ary.dup
      roots = sf.proots

      n = roots.size
      m = sf.def_polys.size
      for i in m...n
	ri = roots[i].abs_lift
	h = if ri.is_a? Algebra::Polynomial
	      r = roots.values_at(*ary0[0...m])
	      ri.evaluate(*r)
	    else
	      ri
	    end
	for k in 0...n
	  if !ary0.include?(k) && roots[k] == h
	    ary0.push k
	  end
	end
      end
      if ary0.size != n
	raise "complete: #{ary.inspect} is not extendable."
      end
      ary0
    end
  end
end

if __FILE__ == $0
  require "algebra/rational"
  require "algebra/polynomial"
  require "algebra/splitting-field"

  P = Algebra.Polynomial(Rational, "x")
  x = P.var
  f = [
    x**3 - 2,             #0
    (x**2 - 2)*(x**2 - 3),#1
    x**3 - 3*x + 1,       #2
    x**3 - x + 1,         #3
    (x**3 - 2)**2,        #4
    x**4  + 1,
    x**4 - x + 1,
  ][ARGV.shift.to_i]

  puts "Galois Group of #{f} is:"
  f.galois_group.each do |reps|
    p reps
  end
end
