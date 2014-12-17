# Factorization of Multivariate polynomial
#
#   by Shin-ichiro Hara
#
# Version 1.0 (2001.09.14)


require "algebra/factors"
require "algebra/chinese-rem-th"
require "algebra/m-polynomial-factor-int"
require "algebra/m-polynomial-factor-zp"
require "algebra/combinatorial"

module Algebra
module MPolynomialFactorization
  include ChineseRemainderTheorem

  def each_point_int(n0, na)
    #obscure algorithm
    pblock = 7
    m = 0
    loop do
      each_point_zp(n0, na, m + pblock) do |pb0|
	next if (1...n0-na).find{|k| pb0[na+k] < m}
	yield pb0
      end
      m += pblock
      $stderr.puts "warning (each_point_int): it's hard to find adequate zero point"
    end
  end
 
  def each_point_zp(n0, na, char)
    avoid_indice = indice_of_constant
    Combinatorial.power_cubic(char, n0 - na - 1) do |a|
      pb0 = (0..na).collect{0} + a
      next if avoid_indice.find{|i| ! pb0[i].zero?}
      yield(pb0)
    end
    raise "each_point(limit over)"
  end

  def _factorize(na = 0)
    pring = Algebra.Polynomial(ground, "x")

    f, f_one, pb0 = self, nil, nil
    # f     : m-poly. moved by pb0 reduced onto f_one
    # f_one : sqfree poly. 
    # pb0   : parallel moving vector
    
    if ground == Integer
      each_point_int(vars.size, na) do |pb0|
        f = move_const(pb0) if pb0.find{|x|!x.zero?}
	 f_one = f.reduce2onevar(pring, na)
	 break if f_one.psqfree?
      end
      fact_one, char = f_one._factorize
      hensel = :hensel_lift_int
    else # ground == Zp
      char = ground.char
      each_point_zp(vars.size, na, char) do |pb0|
	 f = move_const(pb0) if pb0.find{|x|!x.zero?}
	 f_one = f.reduce2onevar(pring, na)
	 break if f_one.sqfree?
      end
      fact_one = f_one.factorize_modp
      hensel = :hensel_lift_zp
    end

    factors = Factors.new
    if fact_one.fact_size <= 1
      factors *= self
      return factors
    end
    height = totdeg_away_from(0)

    f1 = f
    fact_one.each_product do |g0|
      f1_one = f1.reduce2onevar(pring, na)
      next if g0.deg > f1_one.deg
#      fact_q = f1.send(hensel, g0, f1_one, char, height)
      fact_q = f1.send(hensel, g0, f1_one, char, height, na)
      if fact_q
#        if fact_q = f1.hensel_lift(g0, f1_one, char, height)
	 f0, f1 = fact_q
	 factors.push [f0, 1]
	 break if f1.totdeg <= 0
	 true
      end
    end

    factors.collect{|f3, i| [f3.move_const(pb0, -1), i]}
  end

#  def _hensel_lift(g0, f0, char, height)
  def _hensel_lift(g0, f0, char, height, where)
    # self in MPolynomial/ZorZp
    # g0 in Polyomial/ZorZp, candidate of factor of f0
    # f0 in Polyomial/ZoZzp, one variable reduction of self

    ring, ring_one  = self.class, g0.class

    h0, r0 = f0.divmod g0
    unless r0.zero?
      raise "each_product does not work well"
    end

#    where = 0
    ary = [g0, h0]
    cofacts = mk_cofacts(ary)
    fk = ary.collect{|fx| fx.value_on_one(ring, where)} #MPolynomial

    height.times do |k|
      c = self - fk[0]*fk[1]
      h = c.annihilate_away_from(where, k+1)
      h_alpha0 = h.collect_away_from(where, ring_one) #Hash: ind0=>Polynomial
      h_alpha = {}

      h_alpha0.each do |ind, ha|
        h_alpha[ind] = yield(ha, ary, cofacts)
      end

      hias = ary.collect{ {} }
      h_alpha.each do |ind, ha_i|
	 ha_i.each_with_index do |fx, i|
	   next if fx.zero?
	   hias[i][ind] = fx
	 end
      end

      hi = hias.collect{ |hia|
        e = ring.zero
        hia.each do |ind, fx|
	  e += ring.monomial(ind)*fx.value_on_one(ring, where)
        end
        e
      }
      fk_new = []
      hi.each_with_index do |fx, i|
	 fk_new.push fk[i] + fx
      end
      fk = fk_new
    end
    fk
  end

  def _sqfree
    dvs = []
    vars.each_with_index do |v, i|
      dv = derivate_at(i)
      next if dv.zero?
      dvs.push dv
    end
    g = gcd_all(*dvs)
    self / g
  end

  def pp(an)
    x, *a = coeffs_at(an)
    content = x.gcd_all(*a)
    self / content
  end

  def monic_int(na = 0)
    d = deg_at(na)
    a = lc_at(na)
    ary = self.class.vars
    m = project0(self.class){|c, ind|
      n = ind[na]
      if n == d
	zero
      elsif n < d
	c * a ** (d - n - 1) * index_eval(self.class, ary, ind)
      elsif c.zero?
        zero
      else
	raise 'fatal contradiction!'
      end
    }
    
    index_eval(self.class, ary, MIndex.monomial(na, d)) + m
  end
end

class MPolynomial
  include MPolynomialFactorization

  def factorize
    if zero?
      return Algebra::Factors.new([[zero, 1]])
    end
    fact = if  ground <= Integer
             factorize_int
           elsif defined?(Rational) &&  ground <= Rational or
               defined?(LocalizedRing) &&  ground <= LocalizedRing
             factorize_rational
           elsif defined?(ResidueClassRing) &&  ground <= ResidueClassRing && ground.ground <= Integer
             factorize_modp
           else
             factorize_alg
           end
    fact.normalize!
  end

  def reduce2onevar(pring, n)
    evar = []
    self.class.vars.each_with_index do |v, i|
      evar.push i == n ? pring.var : pring.zero
    end
    project(pring, evar){|c, ind| c}
  end

  def annihilate_away_from(n, e = 0)
    #n = 0, e = 2
    # x*y*z + x*y**2*z + x*y*z + y*z + z**3 #=> x*y*z + y*z + z**3
    project(self.class) do |c, ind|
      ind.totdeg - ind[n] > e ? ground.zero : c
    end
  end

  def deg_at(an)
    if zero?
      -1
    else
      max = 0
      each do |ind, c|
	unless c.zero?
	  t = ind[an]
	  max = t if t > max
	end
      end
      max
    end
  end

  def indice_of_constant
    (0...vars.size).find_all{|an| deg_at(an) <= 0}
  end

  def lc_at(an)
    d = deg_at(an)
    s = zero
    each do |ind, c|
      next if c.zero?
      if ind[an] == d
	md = ind.annihilate(an)
	s += monomial(md, c)
      end
    end
    s
  end

  def coeffs_at(an)
    ss = (0..deg_at(an)).collect{ zero }
    each do |ind, c|
      next if c.zero?
      md = ind.annihilate(an)
      ss[ind[an]] += monomial(md, c)
    end
    ss
  end

  def totdeg_away_from(n)
    max = 0
    each do |ind, c|
      next if c.zero?
      m = ind.totdeg - ind[n]
      max = m if m > max
    end
    max
  end

  def collect_away_from(n, ps)
    #2*x*y*z + x**2*y*z + x*y #=> [y*z=>(2*x + x**2), y=>x]
    h_alpha = {}
    each do |ind, c|
      next if c.zero?
      i = ind[n]
      ind0 = ind.annihilate(n)
      v = ps.var
      h_alpha[ind0] = h_alpha[ind0] ? h_alpha[ind0] + c*v**i : c*v**i
    end
    h_alpha
  end
end

class Polynomial
  def value_on_one(ring, n = 0)
    e = ring.zero
    x = ring.vars[n]
    reverse_each do |c|
      e = e * x + c
    end
    e
  end
end
end

if __FILE__ == $0
  require "algebra/residue-class-ring"
  require "algebra/m-polynomial"
  include Algebra
  Z7 = ResidueClassRing(Integer, 7)
  P = MPolynomial(Z7)
  x, y, z = P.vars("xyz")
#  f = x**2*y*z + (-z**2 - y*z + y + z + 2)*x + (y*z**3 - z**3 - y**2*z - y*z + 2*z)
#  f = x**2*y + x**2*z + x * y * z
#  f = x**2*y + x**2*z + x * y 
  f = (x + y)*(y + z)*(z + x)

#  p f.lc_at(0)
  p f
#  p f.monic_int
  p f.coeffs_at(0)
  p( (x*x + y + 1 + x*z + z*2).indice_of_constant)
  p( (x).indice_of_constant)
end
