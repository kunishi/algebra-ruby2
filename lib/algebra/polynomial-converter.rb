# String <=> Polynomial <=> MPolynomial translator
#
#   by Shin-ichiro Hara
#
# Version 2.0 (2001.04.08)

require "algebra/m-polynomial"
require "algebra/polynomial"
require "algebra/residue-class-ring"

module Algebra
  module PolynomialConvertTo
    def convert_to(other)
      if other <= MPolynomial
	g = self
	vs = []
	while g <= Polynomial
	  vs.push g.variable
	  #	vs.push g.var
	  g = g.ground
	end
	MPolynomial.create(g, *vs)
      else
	raise "unkown self.class (#{other})"
      end
    end
  end

  module PolynomialConverter
    def value_on(ring)
      e = ring.zero
      #    x = ring.var(var)
      x = ring.var(variable)
      reverse_each do |c|
	 e = e * x + (ground <= Polynomial ? c.value_on(ring) : c)
      end
      e
    end
    
    def var_swap
      k = Algebra.Polynomial(ground.ground, self.class.variable)
      ring = Algebra.Polynomial(k, ground.variable)
      e = ring.zero
      x = ring.var
      y = ring.ground.var
      reverse_each do |c|
	 e = e * y + c.evaluate(x)
      end
      e
    end
  end
  
  module MPolynomialConvertTo
    def convert_to(other)
      if other <= Polynomial
#	Polynomial.create(ground, *(variables))
	Polynomial.create(ground, *(variables.reverse))
      else
	raise "unkown self.class (#{other})"
      end
    end
  end

  module MPolynomialConverter
    def value_on(ring)
      e = ring.zero
      each do |idx, c|
        e = e + value_on_idx(idx, ring, c)
      end
      e
    end

    def value_on_idx(idx, ring, c)
      vars = ring.vars.reverse
#      vars = ring.vars
      e = ring.unity
      idx.each_with_index do |n, i|
	 e = e * vars[i] ** n
      end
      e * c
    end
  end


#  class ResidueClassRing
#    def abs_lift(depth, mring = nil)
#      unless mring
#	r = self.class
#	depth.times do
#	  r = r.ground.ground
#	end
#	mring = Algebra.MPolynomial(r)
#	depth.times do |n|
#	  mring.var("x#{n}")
#	end
#      end
#
#      s = mring.zero
#      if depth > 1
#	lift.each_with_index do |c, n|
#	  s += c.abs_lift(depth-1, mring) * mring.vars[depth-1]**n
#	end
#      else
#	lift.each_with_index do |c, n|
#	  s += c * mring.vars[depth-1]**n
#	end
#      end
#      s
#    end
#  end

#  class Polynomial
#    def abs_lift(depth)
#      r = ground
#      (depth-1).times do
#	r = r.ground.ground
#      end
#      mring = Algebra.MPolynomial(r)
#      depth.times do |n|
#	mring.var("x#{n}")
#      end
#
#      s = mring.zero
#      if depth > 1
#	each_with_index do |c, n|
#	  s += c.abs_lift(depth-1, mring) * mring.vars[depth-1]**n
#	end
#      else
#	each_with_index do |c, n|
#	  s += c * mring.vars[depth-1]**n
#	end
#      end
#      s
#    end
#  end
end

if __FILE__ == $0
#  MPolynomial.extend Polynomial2Polynomial
#  Polynomial.extend Polynomial2Polynomial
  
#  require "algebra/auto-require"
  require "algebra/rational"
  require "algebra/algebraic-extension-field"
  A = Algebra.AlgebraicExtensionField(Rational, "a") {|a|
    a**3 - 2
  }
  a = A.var
  B = Algebra.AlgebraicExtensionField(A, "b") {|b|
    a**2 + a*b + b**2
  }
  b = B.var
  f = (a - b + 1)**2
  p f
  p f.abs_lift#(2)

  P = Algebra::Polynomial.create(Integer, "x", "y", "z")
  x, y, z = P.vars
  f = x**2 + y**2 + z**2 - x*y - y*z - z*x
#  Algebra::MPolynomial.instance_eval do
#    p AUTO_LOAD
#  end
#  P.instance_eval do
#    p ['try convert_to', self, AUTO_LOAD]
#  end
  MP = P.convert_to(Algebra::MPolynomial)
  x, y, z = MP.vars
  g = x**2 + y**2 + z**2 - x*y - y*z - z*x
  p f = f.value_on(MP) #=> z^2 - zy - zx + y^2 - yx + x^2
  p f == g             #=> true

  P0 = MP.convert_to(Algebra::Polynomial)
  x, y, z = P0.vars
  g = x**2 + y**2 + z**2 - x*y - y*z - z*x
  p f = f.value_on(P0)
  p f == g

  Px = Algebra.Polynomial(Integer, "x")
  x = Px.var
  Pxy = Algebra.Polynomial(Px, "y")
  y0 = Pxy.var

  Py = Algebra.Polynomial(Integer, "y")
  y = Py.var
  Pyx = Algebra.Polynomial(Py, "x")
  x0 = Pyx.var

  f = y0**2 * x - y0**3 * x**2
  g = y**2 * x0 - y**3 * x0**2
  p f
  p g
  p f.var_swap
  puts "END."
end
