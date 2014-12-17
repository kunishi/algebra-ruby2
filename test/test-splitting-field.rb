############################################################
#                                                          #
#  This is test script for 'splitting-field.rb'  #
#                                                          #
############################################################
require "rubyunit"
require "algebra/rational"
require "algebra/splitting-field"

class Rational;def inspect; to_s; end;end

class TestSF < Runit
  P = Algebra.Polynomial(Rational, "x")
  def test_sf
    x = P.var
    for i in 0..2 do
      f = [
	x**2 + 3*x + 1,
	x**3 + x + 1,
	x**5 - x**4 + 2*x - 2,
	][i]
      afs = f.splitting_field
      dfs, roots, proots = afs.def_polys, afs.roots, afs.proots
      case i
      when 0
	a,  = roots
	assert_equal(roots, [a, -a - 3])
	assert_equal(proots, [a, -a - 3])
	assert_equal(dfs, [a**2 + 3*a + 1])
      when 1
	a, b = roots
	assert_equal(roots, [a, b, -b-a])
	assert_equal(proots, [a, b, -b-a])
	assert_equal(dfs, [a**3 + a + 1, b**2 + a * b + a**2 + 1])
      when 2
	a, b = proots
	assert_equal(roots, [1, a, -a, b, -b])
	assert_equal(proots, [a, b, 1, -a, -b])
	assert_equal(dfs, [a**4 + 2, b**2 + a**2])
      end
    end
  end
end

Tests(TestSF)
