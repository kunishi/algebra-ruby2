require "algebra/polynomial"
require "algebra/m-polynomial"
#require "algebra/polynomial-converter"

module Algebra
  class MPolynomial
    def gcd(other)
      pring = self.class.convert_to(Polynomial)
      f = value_on(pring)
      g = other.value_on(pring)
      h = f.gcd_rec(g)
      k = h.value_on(self.class)
      k
    end
    
    def gcd_all(*a)
      t = self
      a.each do |x|
	break if t.unit?
	t = t.gcd(x)
      end
      t
    end
  end
end

if $0 == __FILE__
  require "algebra/residue-class-ring"
  include Algebra
  Z7 = ResidueClassRing(Integer, 7)
  P = MPolynomial(Z7)
#  P = MPolynomial(Integer)
  x, y, z = P.vars("xyz")
  
  f, g  = (x + y) * (x + 2*y), (x + 2*y) * (x + 3*y)
#  f, g  = x**2*y, x*y**2
  p k = f.gcd(g)
  p k/3 == x + 2*y
end
