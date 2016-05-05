#################################################
#                                               #
#  This is test script for 'groebner-basis.rb'  #
#                                               #
#################################################
require 'test/unit'
#require "algebra/groebner-basis.rb"
#require "algebra/m-polynomial"
require "algebra"
require "algebra/rational"

include Algebra

class TestGroebnerBasis < Test::Unit::TestCase
  def setup
    @F5 = ResidueClassRing(Integer, 5)
  end

  # def gb(f, sw = false)
  #   f0 = f.first
  #   print "Basis of: "
  #   sw ? puts('', *f) : puts(f.map { |v| v.to_s }.join(", "))
  # #  gbase = Groebner.reduced_basis(f)
  #   gbase = Groebner.basis(f)
  #   print "Is: "
  #   sw ? puts('', *gbase) : puts(gbase.map { |v| v.to_s }.join(", "))
  #   puts
  # end

  def test_groebner_basis_01
    # puts "rational"
    x, y, z = MPolynomial(Rational).vars "xyz"
    f1 = x**2 + y**2 + z**2 -1
    f2 = x**2 + z**2 - y
    f3 = x - z
    # gb([f1, f2, f3])
    gbase = Groebner.basis [f1, f2, f3]
    assert_equal(x - z, gbase[0])
    assert_equal(y - 2*z**2, gbase[1])
    assert_equal(z**4 + Rational(1, 2)*z**2 - Rational(1, 4), gbase[2])
  end

  def test_groebner_basis_02
    # puts "mod 5"
    #require "algebra/residue-class-ring"
    x, y, z = MPolynomial(@F5).vars "xyz"
    f1 = x**2 + y**2 + z**2 -1
    f2 = x**2 + z**2 - y
    f3 = x - z

    # gb([f1, f2, f3])
    gbase = Groebner.basis [f1, f2, f3]
    assert_equal(x - z, gbase[0])
    assert_equal(y + 3*z**2, gbase[1])
    assert_equal(z**4 + 3*z**2 + 1, gbase[2])
  end

  def test_groebner_basis_03
    # puts "require 'mathn'"
    #require "mathn"
    x, y, z = MPolynomial(Integer).vars "xyz"
    f1 = x**2 + y**2 + z**2 -1
    f2 = x**2 + z**2 - y
    f3 = x - z
    # gb([f1, f2, f3])
    gbase = Groebner.basis [f1, f2, f3]
    assert_equal(x - z, gbase[0])
    assert_equal(y - 2*z**2, gbase[1])
    assert_equal(z**4 - 1, gbase[2])
  end
end
