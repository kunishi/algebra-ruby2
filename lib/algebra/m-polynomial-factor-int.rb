# Factorization of Multivariate polynomial / Integer, Rational
#
#   by Shin-ichiro Hara
#
# Version 1.0 (2001.09.14)

require "algebra/m-polynomial"
require "algebra/polynomial"
require "algebra/polynomial-factor"
require "algebra/residue-class-ring"
require "algebra/rational"
require "algebra/chinese-rem-th"
require "algebra/m-polynomial-gcd"
#require "algebra/combinatorial"

module Algebra
module MPolynomialFactorization
  include PolynomialFactorization::Z
#  include PolynomialFactorization::Q

  def factorize_int(an = 0)
    return Factors.new([[self, 1]]) if constant?
    f = self
    f = f.sqfree if an == 0
    an += 1 while f.deg_at(an) <= 0
    f = f.pp(an)
    lc_of_f = f.lc_at(an)
    f = f.monic_int(an)
    facts = f._factorize(an)
    facts = facts.map!{|f2|
      f3 = f2.project(self.class){|c, j| c*lc_of_f**j[an]}
      f3.pp(an)
    }
    facts = facts.fact_all_u(self)
    facts.mcorrect_lc!(self, an) { |fac|
      fac.factorize_int(an + 1)
    }
    facts
  end

  def sqfree
    _sqfree
  end

  def gelfond_bound(char)
    n = vars.size
    ds = (0...n).collect{ 0 }
    c0 = 0
    each do |ind, c|
      next if c.zero?
      ind.each_with_index do |d0, i|
	ds[i] = d0 if d0 > ds[i]
      end
      c0 = c.abs if c.abs > c0
    end
    tot = 0
    ds.each do |x|
      tot += x
    end
    b = Math::E**tot * c0
    l = 0
    s = 1
    while s <= 2*b
      s *= char
      l += 1
    end
    l
  end

#  def hensel_lift_int(g0, f0, char, height)
  def hensel_lift_int(g0, f0, char, height, where)
    # self in MPolynomial/int
    # g0 in Polyomial/Z, candidate of factor of f0
    # f0 in Polyomial/Z, one variable reduction of self

    pheight = gelfond_bound(char)

    fk =  _hensel_lift(g0, f0, char, height, where) {|ha, ary, cofacts|
#    fk =  _hensel_lift(g0, f0, char, height) {|ha, ary, cofacts|
      decompose_on_cofactors_p_adic(ha, ary, cofacts, char, pheight)
    }
    mod = char ** (pheight)
    g = centorize(fk[0], mod)
    h = centorize(fk[1], mod)


    r = self - g * h
    if r.zero?
      return [g, h]
    end

    return nil
  end

  def centorize(f, n)
    half = n / 2
    #    f.class.new(*f.collect{|c| c > half ? c - n : c })
    f.project(f.class) {|c, ind|
      c = c % n
      c > half ? c - n : c
    }
  end

  module Q
    def contQ
      ns = collect{|ind, q| q.numerator}
      ds = collect{|ind, q| q.denominator}
      n = ns.first.gcd_all(* ns[1..-1])
      d = ds.first.lcm_all(* ds[1..-1])
      #if ground == Rational #in 1.8.0, Rational.new is private.
      # ground.new!(n, d)
      #else
      # raise "unknown gound type #{ground}" #20030606
      # ground.new(n, d)
      #end
      ground.new(n, d)
    end

    def ppQ(ring)
      (self / contQ).project(ring){|c, j| c.to_i}
    end
    
    def factorize_rational
      pz = Algebra.MPolynomial(Integer)
      pz.vars(*self.class.variables)
      fz = ppQ(pz)
      a = fz.factorize_int

      # ground == Rational, ground.ground == Integer
      u = ground.ground.unity
      b = a.collect{|f, i|
	[f.project(self.class){|c, j| ground.new(c, u)}, i]
      }
      contQ == ground.unity ? b : b.unshift([self.class.const(contQ), 1])
    end
  end
  include Q
end
end

if __FILE__ == $0
  require "algebra/m-polynomial-factor"
  include Algebra

  def test(f)
    print "#{f}\n  => \n"
    a = f.factorize_int
    sw = (f == a.pi)
    puts "#{a.inspect}, #{sw}"
    raise unless sw
  end

#  P = MPolynomial(Rational)
  P = MPolynomial(Integer)
  PS = Polynomial(Integer, "t")
  x, y, z = P.vars("xyz")
#  x, y, z, t = P.vars("xyzt")

#  f = (x + y + z)**3*(2*z + x)**2*(4*z + y)
#  g = (x + y + z)*(2*z + x)*(4*z + y)
#  p f
#  fs = f.sqfree
#  p fs
#  p g == fs

  fs = [
    x**3 + y**3 + z**3 - 3*x*y*z,
    x**2 + (-z**2 - y*z + y + z + 2)*x + (y*z**3 - z**3 - y**2*z - y*z + 2*z),
    (x + y) * (x + z**2 + 1)*(x**2 + y*z + 1),
    (x + y)*(x + y**2 + z**2 + 1 + y * z)*(x**2 + z + y * 3),
    (x + y)*(x  + z + y * 3)*(x + 1),
    (x + y)**2 * (x + z)
#    (t + x)*(t + y)*(t + z),
  ]

  fs.each do |f|
    test(f)
  end
end
