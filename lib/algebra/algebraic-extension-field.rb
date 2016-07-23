# Algebraic Extension Field
#
#   by Shin-ichiro Hara
#
# Version 1.00 (2002.02.27)

require 'algebra/polynomial'
# require "algebra/m-polynomial"
require 'algebra/residue-class-ring'
require 'algebra/polynomial'

module Algebra
  def AlgebraicExtensionField(field, var = 'x', &b)
    AlgebraicExtensionField.create(field, var, &b)
  end
  module_function :AlgebraicExtensionField

  class AlgebraicExtensionField < ResidueClassRing
    def self.create(field, var_obj)
      poly_ring = Algebra.Polynomial(field, var_obj)

      modulus = yield(poly_ring.var)
      klass = super(poly_ring, modulus)

      #      def klass.var; self[ground.var]; end
      klass.sysvar :var, klass[klass.ground.var]
      klass.sysvar :base, field

      if Algebra::AlgebraicExtensionField >= field
        env_ring = Algebra.Polynomial(field.env_ring, var_obj)
        klass.sysvar :def_polys, field.def_polys + [modulus]
      else
        env_ring = poly_ring
        klass.sysvar :def_polys, [modulus]
      end

      poly_ring.class_eval <<-__DEF__
      def abs_lift
	if Algebra::AlgebraicExtensionField >= ground
	  project(self.class.env_ring) {|c, n| c.abs_lift }
	else
	  project(self.class.env_ring) {|c, n| c }
	end
      end
      __DEF__
      poly_ring.sysvar :env_ring, env_ring
      klass.sysvar :env_ring, env_ring

      klass
    end

    def [](n)
      lift[n]
    end

    def abs_lift
      Algebra::AlgebraicExtensionField >= self.class.base ? lift.abs_lift : lift
    end

    def self.to_ary
      [self, var]
    end
  end

  ################# experimental ###################

  def QuadraticExtensionField(field, var_obj = nil)
    poly_ring = Algebra.Polynomial(field, 'x')
    modulus = yield(poly_ring.var)
    unless modulus.deg == 2
      raise 'give deg 2 polynomial to QuadraticicExtensionField.'
    end

    fact = modulus.factorize
    if o = fact.find { |x| x[0].deg == 1 }
      b = o[0][0]
      a = o[0][1]
      c = b / a
      return [field, - c, c]
    end

    c = modulus[0]
    b = modulus[1]
    a = modulus[2]
    a2 = a * 2
    b0 = a2.zero? ? b : (b / a2)
    c1 = c / a - b0**2
    cs = (-c1).to_s
    r = 'r'
    var_obj ||= r + (/^\d+$/ !~ cs ? '(' + cs + ')' : cs)

    klass, v = AlgebraicExtensionField(field, var_obj) { |x| x**2 + c1 }

    r1 = v - b0
    r2 = - v - b0
    [klass, r1, r2]
  end
  module_function :QuadraticExtensionField

  def Sqrt(field, a, _name = nil)
    QuadraticExtensionField(field, nil) { |x| x**2 - a }
  end

  module_function :Sqrt

  def Root(field, a = nil, deg = 2, cs = nil, &b)
    r, x = Polynomial(field)
    if b
      f = yield(x)
      as = a ? a.to_s : f.to_s
    else
      f = x**deg - a
      as = a.to_s
    end

    r = deg == 2 ? 'r' : "r[#{deg}]"
    cs ||= r + (/^\d+$/ !~ as ? '(' + as + ')' : as)
    k = f.splitting_field(nil, cs)
    [k.field, *k.roots]
  end

  module_function :Root
end

if $PROGRAM_NAME == __FILE__
  R2, r2, r2_ = Root(Rational, 2)
  R3, r3, r3_ = Root(R2, 3)
  R6, r6, r6_ = Root(R3, 6)

  p r6
  p (r6 + r2 + r3) * (r6 + r2 - r3)

  P, x = Polynomial(R6, x)
  p (x**4 - 60 * x**2 + 36).factorize
  #=> (x - 2r3 - 3r2)(x + 2r3 - 3r2)(x - 2r3 + 3r2)(x + 2r3 + 3r2)
end
