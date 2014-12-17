# Factorization of Multivariate polynomial / Zp
#
#   by Shin-ichiro Hara
#
# Version 1.0 (2001.09.14)

require "algebra/m-polynomial"
require "algebra/polynomial"
require "algebra/polynomial-factor"
require "algebra/residue-class-ring"
require "algebra/chinese-rem-th"
require "algebra/m-polynomial-gcd"
#require "algebra/annihilate"

module Algebra
module MPolynomialFactorization
#  include PolynomialFactorization::Z

  def factorize_modp(an = 0)
    f = self
    f = f.sqfree_zp if an == 0
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
      fac.factorize_modp(an + 1)
    }
    facts
  end

  def verschiebung
    ary = vars
    ch = ground.char
    e = zero
    project0 { |c, ind|
      c * index_eval(self.class, ary, ind.collect{|i| i/ch})
    }
  end

  def sqfree_zp
    f = self
    s = unity
    until f.constant?
      g = f._sqfree
      s *= g
      f = (f/g).verschiebung
    end
    s / s.lc
  end

#  def hensel_lift_zp(g0, f0, char, height)
  def hensel_lift_zp(g0, f0, char, height, where)
    # self in MPolynomial/int
    # g0 in Polyomial/Zp, candidate of factor of f0
    # f0 in Polyomial/Zp, one variable reduction of self

#    fk = _hensel_lift(g0, f0, char, height) {|ha, ary, cofacts|
    fk = _hensel_lift(g0, f0, char, height, where) {|ha, ary, cofacts|
	decompose_on_cofactors_modp(ha, ary, cofacts)
    }

    r = self - fk[0] * fk[1]
    if r.zero?
      return fk
    end
        
    return nil
  end
end
end

if __FILE__ == $0
  require "algebra/rational"
  require "algebra/m-polynomial-factor"
  include Algebra

  def test(f)
    print "#{f}\n  => "
    a = f.factorize_modp
    sw = (f == a.pi)
    puts "#{a.inspect}", "#{sw}"
    puts
    raise unless sw
  end

  #  P = MPolynomial(Rational)
  Z7 = ResidueClassRing(Integer, 7)
  P = MPolynomial(Z7)
#  PS = Polynomial(Z7, "t")
  x, y, z = P.vars("xyz")
#  x, y, z, t = P.vars("xyzt")

  fs = [
    x**3 + y**3 + z**3 - 3*x*y*z,
    (x + y + 1)**2 * x,
    (x + y + 1)**2 * (x + 1),
    x**2 + (-z**2 - y*z + y + z + 2)*x + (y*z**3 - z**3 - y**2*z - y*z + 2*z),
    (x + z + 1) * (x + y ) * (x + y**2 + z + 2),
    (x + z + 1) * (x + y) * (x + y**2 + z),
    (x + z + 1) * (x + y)**2 * (x + y**2 + z + 2),
    (x + y)*(y + z)*(z + x),
    (x + y)*(y + z)*(z + x)**3,
    (x * y + 1) * (x * z + 1),
#    (t + x)*(t + y)*(t + z),
  ]
  fs.each do |f|
    test(f)
  end
end
