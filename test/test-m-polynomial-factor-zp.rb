#########################################################
#                                                       #
#  This is test script for 'm-polynomial-factor-zp.rb'  #
#                                                       #
#########################################################
require "rubyunit"
require "algebra/m-polynomial-factor-zp.rb"
require "algebra/m-polynomial-factor"
include Algebra

Z7 = ResidueClassRing(Integer, 7)
P = MPolynomial(Z7)
x, y, z, t = P.vars("xyzt")

FS = [
  [x, y, z],
  [z, z],
  [x+y+z, x**2+y**2+z**2-x*y-y*z-z*x],
  [x - y*z + z, x + y - z**2 + 2],
  [x + y, x + z**2 + 1, x**2 + y*z + 1],
  [x + y + 1, x + y + 1, x] ,
  [x + y + 1, x + y + 1, x + 1],
  [x + z + 1, x + y, x + y**2 + z + 2],
  [x + z + 1, x + y, x + y**2 + z],
  [x + z + 1, x + y, x + y, x + y**2 + z + 2],
  [x + y, y + z, z + x],
  [x + y, y + z, z + x, z + x, z + x],
  [x * y + 1, x * z + 1],
  [t + x, t + y, t + z],
]

#PF = PolynomialFactorization::Factors
PF = Algebra::Factors

class TestMPolynomialFactorZp < Runit
  def test_factorize
    puts
    FS.each do |fs|
      f = PF.seki(fs)
      print "Factorize: #{f}\n"
      a = f.factorize_modp
      print "  -> #{a}\n"
      assert_equal(PF[*fs], a)
    end
  end
end

Tests(TestMPolynomialFactorZp)
