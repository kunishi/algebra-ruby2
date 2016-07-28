##########################################################
#                                                        #
#  This is test script for 'm-polynomial-factor-int.rb'  #
#                                                        #
##########################################################
require 'test/unit'
require 'algebra'
require 'algebra/m-polynomial-factor'

class TestMPolynomialFactorInt < Test::Unit::TestCase
  def setup
    @P = MPolynomial(Integer)
    x, y, z, t = @P.vars('xyzt')

    @FS = [
      [x, y, z],
      #  [3*x + 2*y, x + y],
      #  [3*x + 2*y, 5*x + 7*y, 4*x + 5*z],
      #  [3*x**2 + 2*y, 5*x + 7*y**2, 4*x + 5*z + x*y],
      #  [x+y+z, x**2+y**2+z**2-x*y-y*z-z*x],
      #  [x - y*z + z, x + y - z**2 + 2],
      [x + y, x + z**2 + 1, x**2 + y * z + 1],
      #  [x + y, x + y**2 + z**2 + 1 + y * z, x**2 + z + y * 3],
      [x + y, x + z + y * 3, x + 1],
      [x + y, x + y, x + z],
      [t + x, t + y, t + z]
    ]

    @PQ = MPolynomial(Rational)
    x, y, z, t = @PQ.vars('xyzt')
    @FSQ = [
      [x / 2 + y / 3, x / 5 + y / 5],
      [x / 2 + y / 3, y / 5 + z / 3, z / 7 + x / 11]
    ]

    # PF = PolynomialFactorization::Factors
    @PF = Algebra::Factors
  end

  def test_factorize_int
    # puts
    @FS.each_with_index do |fs, _i|
      f = @PF.seki(fs)
      # print "Factorize Int(#{i+1}): #{f}\n"
      a = f.factorize_int
      # print "  -> #{a}\n"
      assert_equal(@PF[*fs], a)
    end
  end

  def test_factorize_rational
    # puts
    @FSQ.each_with_index do |fs, _i|
      f = @PF.seki(fs)
      # print "Factorize Rational(#{i+1}): #{f}\n"
      a = f.factorize_rational
      # print "  -> #{a}\n"
      assert_equal(@PF[*fs], a)
    end
  end
end
