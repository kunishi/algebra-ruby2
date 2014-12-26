#######################################################
#                                                     #
#  This is test script for 'polynomial-converter.rb'  #
#                                                     #
#######################################################
require 'test/unit'
#require "algebra/polynomial-converter.rb"
require "algebra/m-polynomial"
require "algebra/polynomial"
#  MPolynomial.extend Polynomial2Polynomial
#  Polynomial.extend Polynomial2Polynomial
include Algebra

class TestPolynomialConverter < Test::Unit::TestCase
  # P = Polynomial.create(Integer, "x", "y", "z")
  # MP = P.convert_to(MPolynomial)
  # P0 = MP.convert_to(Polynomial)
  #
  def test_polynomial_converter_01
    p = Polynomial.create(Integer, "x", "y", "z")
    x, y, z = p.vars
    f = x**2 + y**2 + z**2 - x*y - y*z - z*x

    mp = p.convert_to(MPolynomial)
    x, y, z = mp.vars
    g = x**2 + y**2 + z**2 - x*y - y*z - z*x

    f = f.value_on(mp)
    # p f = f.value_on(MP) #=> z^2 - zy - zx + y^2 - yx + x^2
    assert_equal(z**2 - z*y - z*x + y**2 - y*x + x**2, f)
    # p f == g             #=> true
    assert_equal(g, f)
  end

  def test_polynomial_converter_02
    p = Polynomial.create(Integer, "x", "y", "z")
    x, y, z = p.vars
    f = x**2 + y**2 + z**2 - x*y - y*z - z*x

    mp = p.convert_to(MPolynomial)
    f = f.value_on(mp)

    p0 = mp.convert_to(Polynomial)
    x, y, z = p0.vars
    g = x**2 + y**2 + z**2 - x*y - y*z - z*x

    # p f = f.value_on(P0)
    f = f.value_on(p0)
    assert_equal(z**2 + (-y - x)*z + y**2 - x*y + x**2, f)
    # p f == g
    assert_equal(f, g)
  end

  def test_polynomial_converter_03
    px = Polynomial(Integer, "x")
    x = px.var
    pxy = Polynomial(px, "y")
    y0 = pxy.var

    py = Polynomial(Integer, "y")
    y = py.var
    pyx = Polynomial(py, "x")
    x0 = pyx.var

    f = y0**2 * x - y0**3 * x**2
    g = y**2 * x0 - y**3 * x0**2

    assert_equal(-x**2 * y0**3 + x * y0**2, f)
    assert_equal(-y**3 * x0**2 + y**2 * x0, g)
    # assert_equal(-y**3 * x0**2 + y**2 * x0, f.var_swap)
    # p f
    # p g
    p f.var_swap
  end
end
