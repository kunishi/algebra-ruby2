# Utility for Algebraic Equations
#
#   by Shin-ichiro Hara
#
# Version 1.11 (2002.02.23)

require "algebra/polynomial"
require "algebra/polynomial-factor"
require "algebra/m-polynomial"
require "algebra/groebner-basis"
require "algebra/residue-class-ring"
require "algebra/splitting-field"

module Algebra
  module AlgebraicEquation
    def symmetric_product(objs)
      a = [1]
      objs.each do |x|
	ax = a.collect{|t| t * x}
	a.each_index do |i|
	  if i > 0 && i < a.size
	    a[i] = a[i] + ax[i-1]
	  end
	end
	a.push ax.last
      end
      a
    end
    
    def minimal_polynomial(e, *fs)
      raise "too many polys" if fs.size > ?x - ?a#("a"..."x").size
      require "algebra/groebner-basis"
      (mpring = e.class).vars("x")
      x = mpring.var("x")
      gb = mpring.with_ord(:lex) {
	Algebra::Groebner.basis([x - e, * fs])
      }
      gb.last
    end
    
    module_function :minimal_polynomial
    module_function :symmetric_product
  end
end

if __FILE__ == $0
  include Algebra::AlgebraicEquation
  require "algebra/rational"
  PQ = Algebra.MPolynomial(Rational)
  a, b, c, d = PQ.vars("abcd")
  p minimal_polynomial(a + b, a**3-2, b**2+b+1)
  p minimal_polynomial(a + b + c, a**2-2, b**2-3, c**2-5)
#  p minimal_polynomial(a + b, a**5-2, b**4+b**3+b**2+b+1)
#x^20 + 5x^19 + 15x^18 + 35x^17 + 70x^16 + 113x^15 + 155x^14 + 215x^13 + 410x^12 + 1095x^11 + 1929x^10 + 2185x^9 + 1180x^8 - 905x^7 - 835x^6 + 17x^5 + 40x^4 - 255x^3 - 45x^2 + 135x + 81

  #too difficult, deg == 16
  #p minimal_polynomial(a+b+c+d, a**2-2, b**2-3, c**2-5, d**2-7)
end
