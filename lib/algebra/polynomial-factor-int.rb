# Factorization of Polyomial over Integer by Zassenhaus's method
#
#   by Shin-ichiro Hara
#
# Version 1.0 (2001.04.19)

require "algebra/prime-gen"
require "algebra/residue-class-ring"

module Algebra
module PolynomialFactorization
  module Z
    def resolve_c(g, h, c) # find [a, b] s.t. a * g + b * h == c
      d, a, b = g.gcd_coeff(h)
      q, r = c.divmod(d)
      raise "#{c} is not devided by (#{g}, #{h})" unless r.zero?
      a = a * q
      b = b * q
      q, r = a.divmod(h)
      a = r #= a - q * h
      b = b + q * g
      [a, b]
    end

    def centorize(f, n)
      half = n / 2
      f.class.new(*f.collect{|c| c > half ? c - n : c })
    end

    def try_e(g, u)
      m = g.deg
      c = 1.0
      n = (m/2).to_i
      0.upto n - 1 do |i|
	c *= (m - i) / (n - i)
      end
      s = 0
      each do |c|
	s += c**2
      end
      (Math.log(c * Math.sqrt(s))/Math.log(u)).to_i + 1
    end

    def sqfree_over_integral
      f = pp
      g = f.derivate.pp
      h = f.pgcd(g)
      f / h.pp
    end

    def divmod_ED(o) # divmod in the ring over Euclidian Domain
      raise ZeroDivisionError, "divisor is zero" if o.zero?

      d0, d1 = deg, o.deg
      if d1 <= 0
	a = collect{|c|
	  q, r = (ground.field? ? [ground.zero, c/o.lc] : c.divmond(o.lc))
	  if r.zero?
	    [q, zero]
	  else
	    return [zero, self]
	  end
	}
	[self.class.new(*a), zero]
      elsif d0 < d1
	[zero, self]
      else
	q, r = (ground.field? ? [lc/o.lc, ground.zero] : lc.divmod(o.lc))
	if r.zero?
	  tk = monomial(d0 - d1) * q
	  e = rt - o.rt * tk
	  q, r = e.divmod_ED(o)
	  [q + tk, r]
	else
	  [zero, self]
	end
      end
    end

    def resultant_by_elimination(o) #ground ring must be a field
      sylvester_matrix(o).determinant_by_elimination
    end

    def reduce_over_prime_field(f)
      Primes.new.each do |prime|
	if prime > 10
	  pf = Algebra::Polynomial.reduction(Integer, prime, "x")
	  f0 = pf.reduce(f)
	  r = f0.resultant_by_elimination(f0.derivate)
	  unless r.zero?
	    return f0
	  end
	end
      end
    end

    def lifting(f, ring)
      f.project(ring){|c, i| c.lift}
    end

    def hensel_lift(g0)
      ring, pf, char = self.class, g0.class, g0.class.ground.char

      f0 = pf.reduce(self)
      h0, r0 = f0.divmod g0
      unless r0.zero?
	raise "each_product does not work well"
	#return nil 
      end

      g = lifting(g0, ring)
      h = lifting(h0, ring)
      a, b = 0, 0

      0.upto try_e(g, char) do |e|
	mod = char ** e
	mod1 = mod * char
	g = centorize(g + b * mod, mod1)
	h = centorize(h + a * mod, mod1)

	q, r = divmod(g)
	if r.zero?
	  return [g, q]
	end

	c = (self - g * h)  / mod1
	g0, h0, c0 = pf.reduce(g), pf.reduce(h), pf.reduce(c)
	a0, b0 =  resolve_c(g0, h0, c0)
	a, b = lifting(a0, ring), lifting(b0, ring)
      end

      return nil
    end

    def _factorize
      if constant?
	return Algebra::Factors.new([[self, 1]]), 0
      end
      f = sqfree_over_integral
      flc = f.lc
      f = f.monic_int(flc)
      
      f0 = reduce_over_prime_field(f)
      fa = f0.factorize_modp

      f1 = f
      factors = Algebra::Factors.new
#      fa.each_product0 do |g0|
      fa.each_product do |g0|
        next if g0.deg > f1.deg
#	if fact_q = f1.hensel_lift(g0, f0.class)
	if fact_q = f1.hensel_lift(g0)
	  fact, f1 = fact_q
	  factors.push [fact, 1]
	  break if f1.deg <= 0
	  true
	end
      end

      factors.map!{|f2| f2.project(self.class){|c, j| c*flc**j}.pp }
      facts = factors.fact_all(self)
      [facts.correct_lc!(self), f0.ground.char]
    end

    def factorize_int
      _factorize.first
    end
  end

  module Q
    def contQ
      ns = collect{|q| q.numerator}
      ds = collect{|q| q.denominator}
      n = ns.first.gcd_all(* ns[1..-1])
      d = ds.first.lcm_all(* ds[1..-1])
#      ground.new(n, d)
      if ground == Rational #in 1.8.0, Rational.new is private.
	ground.new!(n, d)
      else
	raise "unknown gound type #{ground}" #20030606
	ground.new(n, d)
      end
    end

    def ppQ(ring)
      (self / contQ).project(ring){|c, j| c.to_i}
    end
    
    def factorize_rational
      pz = Algebra.Polynomial(Integer, "x")
      fz = ppQ(pz)
      a = fz.factorize
      u = ground.ground.unity # ground == Rational, ground.ground == Integer
      b = a.collect{|f, i|
	[f.project(self.class){|c, j|
#	    ground.new
	    ##in 1.8.0, Rational.new is private.
	    ground == Rational ? ground.new!(c, u) : ground.new(c, u)
	  }, i]
      }
      contQ == ground.unity ? b : b.unshift([self.class.const(contQ), 1])
    end
  end
  
  include Z
  include Q
end
end

if __FILE__ == $0
  require "algebra/polynomial"
  require "algebra/polynomial-factor"
  require "algebra/residue-class-ring"
  require "algebra/rational"
#  include Algebra

  def test(f)
    print "#{f}\n  => "
    a = f.factorize
    sw = (f == a.pi)
    puts "#{a.inspect}, #{sw}"
    raise "Test Failed" unless sw
  end

  PQ = Algebra.Polynomial(Rational, "y")
  y = PQ.var

  P = Algebra.Polynomial(Integer, "x")
  x = P.var

h = x**12 - 12*x**10 - 4*x**9 + 96*x**8 - 442*x**6 + 672*x**5 + 1572*x**4 - 1412*x**3 - 2544*x**2 - 1560*x + 4225

  fs = [
    54*x**3 + 57*x**2 + 28*x + 15, #(9*x**2+2*x+3)*(6*x+5)
    (x**2+x+1)**2*(x+1)**3,
    (x**2+x+1)**2,
    (x**2+x+1)*(x+1)**3,
    (x**2+x+1)*(x+1)*(x+2),
    (x**2+x+1)*(x+1),
    (x**2+x+1),
    (x+1)**3,
    (3*x + 1)*(2*x + 5)*3,
    (x**3 + 1)**3,
#    (x**8+x**6+x**5+x**4+x**3+x**2+1)*(x**2+x+1)**3,
    (y**2 + 2*y + Rational(3, 4))*(y + Rational(1, 3)),
#    h
  ]
#  fs[-1..-1].each do |f|
  fs.each do |f|
    test(f)
  end
end
