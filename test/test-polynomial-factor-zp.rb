#######################################################
#                                                     #
#  This is test script for 'polynomial-factor-zp.rb'  #
#                                                     #
#######################################################
require "rubyunit"
require "algebra/polynomial"
require "algebra/polynomial-factor"
require "algebra/residue-class-ring"
include Algebra

PQ = Polynomial(Integer, "x")
x = PQ.var
FS = [
  x**2+x+1,
  (x**2+x+1)*(x+1)**3,
  (x**8+x**6+x**5+x**4+x**3+x**2+1)*(x**2+x+1)**3
]

class TestPolynomialFactorZp < Runit
  def test_factorize
    [2, 3, 5, 7, 11].each do |n|
      fn = ResidueClassRing(Integer, n)
      pfn = Polynomial(fn, "y")
      FS.each do |fs|
#        f = PF.seki(fs)
	f = fs
	g = f.project(pfn){|c, i| fn[c]}
	print "Factorize(mod #{n}): #{g}\n"
	a = g.factorize_modp
	print "  -> #{a}\n"
#	assert_equal(PF[*fs], a)
	assert_equal(g, a.pi)
      end
    end
  end
end

Tests(TestPolynomialFactorZp)
