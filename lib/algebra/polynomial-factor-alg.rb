# Factorization of Polyomial over Algebraic Extension over Rational
#
#   by Shin-ichiro Hara
#
# Version 1.0 (2001.04.17)

#require "algebra/polynomial-converter"
require "algebra/algebraic-extension-field"

module Algebra
class Polynomial
  module Alg
    def norm
      f = project(Algebra.Polynomial(ground.ground, variable)){|c, i| c.lift }
      f.var_swap.resultant(ground.modulus)
    end
  end
  include Alg

  def factorize_alg_old
#    if !respond_to?(:deg) or deg <= 1
    if deg <= 1
      return Algebra::Factors.new([[self, 1]])
    end

    t = ground.var
    x = var
    sf = sqfree.monic

    n = 0
    while true
      nm = sf.norm
      break if nm.sqfree?
      n += 1
      sf = sf.evaluate(x - t)
    end
    fac = nm.factorize
    fac.map!{|f0|
      f0.convert_to(self.class).gcd(sf).evaluate(x + t*n).monic
    }
    fac.fact_all(self).correct_lc!(self)
  end

  def factorize_alg(s = 0)
    if deg <= 1
      return Algebra::Factors.new([[self, 1]])
    end

    t = ground.var
    x = var
    sf = sqfree.monic

    nm = sf.evaluate(x - t*s).norm
    fac0 = Algebra::Factors.new
    nm.factorize.each{|f0, n|
      next if f0.deg <= 0
      g = f0.convert_to(self.class).evaluate(x + t*s)
      g = g.gcd(sf).monic
      if n == 1
	fac0.multiply g
      elsif n >= 2
	h = g.factorize_alg(s+1)
	fac0.concat h
      end
    }
    fac0.fact_all(self).correct_lc!(self)
  end
end
end

if __FILE__ == $0
  def test(f, s = "")
    print "#{f}#{s}\n"
    a = f.factorize
    sw = (f == a.pi)
    puts "#{a.inspect}, #{sw}"
    raise unless sw
  end

  require "algebra/polynomial"
  require "algebra/polynomial-factor"
  require "algebra/residue-class-ring"
  require "algebra/rational"

  n, i, j, k = ARGV.collect{|v| v.to_i}
  fss = [
    "x**4 + 1",#0
    "x**2 + x + 1",#1
    "x**4 + 1 + a",#2
    "(x**4 + 1)*(x**2 + x + 1)",#3
    "x**4 + 4",#4
    "x**2 + 4*x + 1",#5
    "x**2 + 1",#6
    "x**3 - 1",#7
    "x**3 - 2",#8
  ]
  fs = fss[n||0]
  ass = [
    "a**2 + 1",#0
    "a**2 - 2",#1
    "a**3 - 2",#2
    "a**2 - 3",#3
  ]
  bss = [
    "b**2 - 2",#0
    "b**3 - 2",#1
    "b**2 + b + 1",#2
    "b**2 + 1",#3
    "b**2 - 3",#4
  ]
  css = [
    "c**3 - 2",#0
    "c**2 - 3",#1
  ]

  as = ass[i||0]
  bs = bss[j||0]
  cs = css[k||0]

  unless i
    [fss, ass, bss, css].each do |xs|
      puts "-----------"
      xs.each_with_index do |f, i|
	puts "#{i}: #{f}"
      end
    end
  else
    ka = Algebra.AlgebraicExtensionField(Rational, "a") {|a| eval as }
    a = ka.var	  
    unless j
      pka = Algebra.Polynomial(ka, "x")
      x = pka.var
      f = eval fs
      test(f, ", in Q[a, x]/(#{as})")
    else
      kab = Algebra.AlgebraicExtensionField(ka, "b") { |b| eval bs}
      
      unless k
	pkab = Algebra.Polynomial(kab, "x")
	x = pkab.var
	f = eval fs
	test(f, ", in Q[a, b, x]/(#{as}, #{bs})")
      else
	kabc = Algebra.AlgebraicExtensionField(kab, "c") { |c| eval cs}
	pkabc = Algebra.Polynomial(kabc, "x")
	x = pkabc.var
	f = eval fs
	test(f, ", in Q[a, b, c, x]/(#{as}, #{bs}, #{cs})")
      end
    end
  end
end

