# Factorization of Polyomial over Zp by Berlekamp's method
#
#   by Shin-ichiro Hara
#
# Version 1.0 (2001.04.17)

require "algebra/matrix-algebra"
require "algebra/gaussian-elimination"

module Algebra
module PolynomialFactorization
  module Zp
    def verschiebung
      x = var
      ch = ground.char
      e = ground.zero
      each_with_index do |c, i|
	e += x ** (i/ch) *  c
      end
      e
    end
    
    def weak_factors_and_r
      #self asumed to be square and p- free
      y = var ** ground.char
      n = deg

      u = Algebra.SquareMatrix(ground, n).collect_column{|i|
	a = y ** i % self
	(0...n).collect{|j| a[j]}
      }

      u -= u.unity

      basis = u.kernel_basis
      
      wf = []
      basis.each_with_index do |h, i|
#	next if i == 0
	fh = self.class.new(*h)
	(0...ground.char).each do |s|
	  fhg = (fh - s).gcd(self)
	  if fhg.deg > 0
	    fhgm = fhg / fhg.lc
	    wf.push(fhgm) unless wf.include? fhgm
	  end
	end
      end
      [wf, basis.size]
    end
    
    def factors_of_sqfree
      #self assumed to be square and p-free
      wf, fact_size = weak_factors_and_r
      n = deg
      degwize = (1..n).collect{|i| []}
      wf.each do |f|
	degwize[f.deg-1].push f
      end
      degwize.each_with_index do |a, i|
	(i..degwize.size-1).each do |j|
	  b = degwize[j]
	  a.each do |f|
	    b.each do |g|
	      next if f == g
	      h = f.gcd(g)
	      if h.deg > 0 &&  h.deg < f.deg
		h = h / h.lc
		unless degwize[h.deg-1].include? h
		  degwize[h.deg-1].push(h)
		end
	      end
	    end
	  end
	end
      end
      
      facts = []
      degwize.each_with_index do |a, i|
	b = []
	a.each do |f|
	  b.push f unless facts.find{|g| g.divide?(f)}
	end
	facts.concat b
	break if facts.size == fact_size
      end
      facts
    end

    #module_function :verschiebung, :weak_factors_and_r, :factors_of_sqfree, :factorize

    def factorize_modp
      me = self
      g = sqfree
      fs = Factors.new
      g.factors_of_sqfree.each do |f|
	i, r = 0, 0
	while me.deg > 0
	  q, r = me.divmod f
	  if r.zero?
	    me = q
	    i += 1
	  else
	    break
	  end
	end
	fs.push [f, i]
      end
      
      # for 'over Zp'
      if ch = ground.char
	if me.deg > 0
	  me.verschiebung.factorize_modp.each do |f_i|
	    f0, i0 = f_i
	    fs.push [f0, i0*ch]
	  end
	end
      end
      fs
    end
    #  module_function :factorize_modp

    #def _factorize
    #  [factorize_modp, ground.char]
    #end
  end

  include Zp
end
end

if __FILE__ == $0
#  include Algebra
  def test(f)
    print "#{f}\n  => "
    a = f.factorize
    sw = (f == a.pi)
    puts "#{a.inspect}, #{sw}"
    raise unless sw
  end

  require "algebra/polynomial"
  require "algebra/polynomial-factor"
  require "algebra/residue-class-ring"
  require "algebra/rational"
  PQ = Algebra.Polynomial(Rational, "x")

  [2, 3, 5, 7, 11].each do |n|
    puts "mod = #{n}"
    fn = Algebra.ResidueClassRing(Integer, n)
    pfn = Algebra.Polynomial(fn, "y")
    
    y = pfn.var
    x = PQ.var
    fs = [
      x**2+x+1,
      (x**2+x+1)*(x+1)**3,
      (x**8+x**6+x**5+x**4+x**3+x**2+1)*(x**2+x+1)**3
    ]
    fs.each do |f|
      g = f.project(pfn) {|c, i| fn[c.mod(n)]}
      test(g)
    end
  end
end
