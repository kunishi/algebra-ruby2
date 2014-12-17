# G.C.D. and something for Euclidian ring (equipping 'divmod' and 'zero?')
#
#   by Shin-ichiro Hara
#
# Version 1.01 (2001.03.22)

require "algebra/algebraic-system"
module Algebra
module EuclidianRing
  def lcm(b)
    self * b / gcd(b)
  end

  def lcm_all(*a)
    t = self
    a.each do |x|
      t = t.lcm(x)
    end
    t
  end

  def gcd3(b)
    x, y = self, b
    until y.zero?
      q, r = x.divmod y
      x, y = y, r
    end
    x
  end

  def gcd(n)
    m = self
    while n != 0
      m %= n
      tmp = m; m = n; n = tmp
    end
    m
  end

  def gcd_all(*a)
    t = self
    a.each do |x|
      t = t.gcd(x)
    end
    t
  end

  def gcd_ext(g)
    h, s = self, g
    a, b = self.class.unity, self.class.zero
    c, d = self.class.zero, self.class.unity
    loop do
      q, r = h.divmod s
      return [s, c, d] if r.zero?
      h, s = s, r # r == h - q * s
      a, c = c, a - q * c
      b, d = d, b - q * d
    end
  end

  alias gcd_coeff gcd_ext
  
  def gcd_coeff0(b)
    if b.zero?
      [self, unity, zero]
    else
      q, r = divmod b
      d, x, y = b.gcd_coeff(r)
      [d, y, x - y * q]
    end
  end

  def gcd_coeff_all(*a0)
    return [self, self] if a0.empty?
    t, *a = a0
    d, x, y = gcd_ext(t)
    r = [x, y]
    a.each do |u|
      d, x, y = d.gcd_coeff(u)
      r = r.collect{|v| x*v} + [y]
    end
    [d] + r
  end

  alias gcd_ext_all gcd_coeff_all

  def pgcd(b)
    x, y = self, b
    until y.zero?
      q, r = x.pdivmod y
      x, y = y, r
    end
    x
  end

  def gcd_rec(b)
    return self if b.zero?
    return b if zero?
    if is_a?(Polynomial) && !ground.field?
      ac, ap = cont_pp
      bc, bp = b.cont_pp
      c = ac.gcd_rec(bc)
      x, y = ap, bp
      until y.zero?
	q, r = x.pdivmod y
	x, y = y, r
      end
      x.pp * c
    else
      x, y = self, b
      until y.zero?
	q, r = x.pdivmod y
	x, y = y, r
      end
      x
    end
  end

  def cont
    t = nil
    each do |x|
      break if t && t.unit?
      t = t ? t.gcd_rec(x) : x
    end
    t ? t : self
  end

  def pp; self / cont; end
  def cont_pp; [c = cont, self / c]; end
end
end

class Integer < Numeric
  include Algebra::EuclidianRing
end

class Rational < Numeric
  include Algebra::EuclidianRing
end

if $0 == __FILE__
  include Algebra
  a, b = 108, 221
  d, x, y = a.gcd_coeff(b)
  puts "#{x}*#{a} + #{y}*#{b} = #{x * a + y * b} = #{d}"
  a, b, c, e = 36, 126, 81, 12
  p a.gcd_all(b, c, e)
  d, x, y, z, w = a.gcd_coeff_all(b, c, e)
  p d == x*a + y*b + z*c + w*e
  puts "#{d} == #{x}*#{a} + #{y}*#{b} + #{z}*#{c} + #{w}*#{e}"

  require "algebra/polynomial"
  require "algebra/residue-class-ring"
  Z7 = ResidueClassRing(Integer, 7)
#  P = Polynomial(Z7, "x", "y")
  P = Polynomial(Integer, "x", "y")
  x, y = P.vars
  f = 6*(x + 1)*(x + 2)*(y - 1)* (y + 2)
  g = 9*(x + 1)*(x - 3)*(y - 1)* (y - 1)
  p [f, g, f.gcd_rec(g)]
end
