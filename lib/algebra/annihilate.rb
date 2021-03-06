require 'algebra/m-polynomial'
require 'algebra/groebner-basis'

module Algebra
  class MPolynomial
    def lcm(other)
      vars0 = vars
      mp = MPolynomial.create(ground)
      mp.vars('t', *vars)
      t = mp.vars.first
      mpvars = mp.vars
      f = project0(mp) do |c, ind|
        c * index_eval(mp, mpvars, [0] + ind.to_a)
      end
      g = other.project0(mp) do |c, ind|
        c * index_eval(mp, mpvars, [0] + ind.to_a)
      end
      gb = Groebner.basis([t * f, (1 - t) * g])
      lcm0 = gb.last
      lcm0.project0(self.class) do |c, ind|
        c * index_eval(self.class, vars0, ind.empty? ? [] : ind[1..-1])
      end
    end

    def gcd(other)
      (self * other).divmod(lcm(other)).first.first
    end

    def gcd_all(*a)
      t = self
      a.each do |x|
        break if t.constant?
        t = t.gcd(x)
      end
      t
    end
  end
end

if $PROGRAM_NAME == __FILE__
  require 'algebra/residue-class-ring'
  include Algebra
  Z7 = ResidueClassRing(Integer, 7)
  P = MPolynomial(Z7)
  x, y, z = P.vars('xyz')

  f = (x + y) * (x + 2 * y)
  g = (x + 2 * y) * (x + 3 * y)
  #  f, g  = x**2*y, x*y**2
  p f.lcm(g)
  p f.gcd(g)
end
