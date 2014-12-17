# Factorization of Polyomial
#
#   by Shin-ichiro Hara
#
# Version 1.0 (2001.04.17)

require "algebra/polynomial-factor-int"
require "algebra/polynomial-factor-zp"
require "algebra/polynomial-factor-alg"
require "algebra/factors"

module Algebra
  module PolynomialFactorization
    def sqfree
      f = self
      g = gcd(derivate)
      f / g * g.lc
    end
    
    def sqfree?
      gcd(derivate).deg <= 0
    end
    
    def psqfree?
      pgcd(derivate).deg <= 0
    end
    
    def monic_int(a = lc)
      d = deg
      project(self.class){|c, n|
	if n == d
	  ground.unity
	elsif n < d
	  c * a ** (d - 1 - n)
	else
	  #	p [self, d, n];	exit
	  raise
	end
      }
    end
    
    def monic_int_rev(a)
      d = deg
      project(self.class){|c, n|
	if n == d
	  a
	elsif n < d
	  c / a ** (d - 1 - n)
	else
	  raise
	end
      }
    end
    
    def factorize
      if zero?
        return Algebra::Factors.new([[zero, 1]])
      end
      fact0 = if  ground <= Integer
                factorize_int
              elsif defined?(Rational) &&  ground <= Rational or
                  defined?(Algebra::LocalizedRing) &&  ground <= Algebra::LocalizedRing
                factorize_rational
              elsif defined?(Algebra::ResidueClassRing) && ground <= Algebra::ResidueClassRing
                if ground.ground <= Integer
                  factorize_modp
                else
                  factorize_alg
                end
              elsif ground <= Algebra::Polynomial
                require "algebra/m-polynomial-factor"
                require "algebra/polynomial-converter"
                mp = self.class.convert_to(Algebra::MPolynomial)
                f = value_on(mp)
                fact = f.factorize
                fact.map{|g| g.value_on(self.class)}
              else
                raise "(factor) unknown data type : #{self.class}"
              end
      fact0.normalize!
    end
    
    def irreducible?
      factorize.size == 1
    end
  end

  class Polynomial
    include PolynomialFactorization
    
    def self.reduction(ring, mod, var)
    pfx = Algebra.Polynomial(Algebra.ResidueClassRing(ring, mod), var)
#    def pfx.[](poly)
      def pfx.reduce(poly)
	poly.project(self){|c, i| ground[c]}
      end
      pfx
    end
  end
end

if __FILE__ == $0
  require "algebra/polynomial"
  require "algebra/residue-class-ring"
  require "algebra/rational"
  include Algebra

  def test(f)
    print "#{f}\n  => "
    a = f.factorize
    sw = (f == a.pi)
    puts "#{a.inspect}, #{sw}"
    raise unless sw
  end

  P0 = Polynomial(Integer, "x")
  x = P0.var
#  PQ = Polynomial(Rational, "x")
  PQ = Polynomial(Integer, "x")
  x = PQ.var
  f = (x**2+x+1)*(x+1)**3

  test(f)
  
  n = 5
  puts "mod = #{n}"

  PF = Polynomial.reduction(Integer, n, "y")
  g = PF.reduce(f)
  test(g)

#  require "algebra/matrix-algebra"
#  P3 = Polynomial(Integer, "x")
#  x = P3.var
#  f = 3 * x**3 + 5 * x**2 + 7 * x + 11
#  g = x**4 - 3*x**2 + x - 7
#  f.sylvester_matrix(g).display
#  f.sylvester_matrix(g, 0).display
#  f.sylvester_matrix(g, 1).display
#  f.sylvester_matrix(g, 2).display
#  p f.resultant(g)
end
