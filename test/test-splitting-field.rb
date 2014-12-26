############################################################
#                                                          #
#  This is test script for 'splitting-field.rb'  #
#                                                          #
############################################################
require "rubyunit"
require "algebra/rational"
require "algebra/splitting-field"

class TestSF < Test::Unit::TestCase
  P = Algebra.Polynomial(Rational, "x")

  def test_splitting_field_0
    x = P.var
    f = x**2 + 3*x + 1
    afs = f.splitting_field
    dfs, roots, proots = afs.def_polys, afs.roots, afs.proots
    a,  = roots
    assert_equal(roots, [a, -a - 3])
    assert_equal(proots, [a, -a - 3])
    assert_equal(dfs, [a**2 + 3*a + 1])
  end

  def test_splitting_field_1
    x = P.var
    f = x**3 + x + 1
    afs = f.splitting_field
    dfs, roots, proots = afs.def_polys, afs.roots, afs.proots

    a, b = roots
    assert_equal(roots, [a, b, -b-a])
    assert_equal(proots, [a, b, -b-a])
    assert_equal(dfs, [a**3 + a + 1, b**2 + a * b + a**2 + 1])
  end

  def test_splitting_field_2
    x = P.var
    f = x**5 - x**4 + 2*x - 2
    afs = f.splitting_field
    dfs, roots, proots = afs.def_polys, afs.roots, afs.proots
    a, b = proots
    assert_equal(roots, [1, a, -a, b, -b])
    assert_equal(proots, [a, b, 1, -a, -b])
    assert_equal(dfs, [a**4 + 2, b**2 + a**2])
  end
end
