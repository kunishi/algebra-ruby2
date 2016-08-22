#############################################
#                                           #
#  This is test script for 'polynomial.rb'  #
#                                           #
#############################################
require 'test/unit'
require 'algebra'

class TestPolynomial < Test::Unit::TestCase
  def test_products
    p = Algebra::Polynomial(Integer, 'x')

    x = p.var
    assert_equal(x**2 + 3 * x + 2, (x + 1) * (x + 2))
    assert_equal(x**3 + 3 * x**2 + 3 * x + 1, (x + 1)**3)
  end

  def test_polynomial_01
    fx = Algebra::Polynomial.create(Integer, 'x')
    x = fx.var

    f = x**6 - 1
    g = (x ^ 4) - 1

    d, t, u = f.gcd_coeff(g)
    # puts "(#{t})(#{f}) + (#{u})(#{g}) = #{t * f + u * g} = #{d}"
    assert_equal(t * f + u * g, d)
  end

  def test_polynomial_02
    fy = Algebra::Polynomial.create(Rational, 'y')
    y = fy.var

    f = y**3 - 3 * y + 2
    g = y**6 - 1
    h = y**4 - 1

    assert_equal(f.gcd_all(g, h), -Rational(14, 9) * y + Rational(14, 9))
  end

  def test_polynomial_03
    fy = Algebra::Polynomial.create(Rational, 'y')
    y = fy.var

    f = y**3 - 3 * y + 2
    g = y**6 - 1
    h = y**4 - 1

    d, a, b, c = f.gcd_coeff_all(g, h)

    assert_equal(a * f + b * g + c * h, d)
  end

  # Polynimial is a commutative multi-variable ring
  def test_polynomial_04
    fx = Algebra::Polynomial.create(Integer, 'x')
    fxy = Algebra::Polynomial.create(fx, 'y')
    x = fx.var
    y = fxy.var
    assert_equal(x**2 * y**2 - y**2 * x**2, 0)
  end

  def test_polynomial_05
    require 'algebra/algebraic-parser'
    fx = Algebra::Polynomial.create(Integer, 'x')
    fxy = Algebra::Polynomial.create(fx, 'y')
    assert_equal(Algebra::AlgebraicParser.eval('(x + y)**10 - (y**2 + 2*x*y + x**2)**5)', fxy), 0)
  end

  def test_polynomial_06
    require 'algebra/rational'
    #  A = Algebra::Polynomial.create(Rational, "x")
    #  x = A.var
    #  B = Algebra::Polynomial.create(A, "y")
    #  y = B.var
    #  C = Algebra::Polynomial.create(B, "z")
    #  z = C.var
    #  D = Algebra::Polynomial.create(C, "w")
    #  w = D.var
    #  p( (x+y+z+w)**4 )

    k = Algebra::Polynomial.create(Integer, 'x', 'y', 'z', 'w')
    x, y, z, w = k.vars
    assert_equal((x + y + z + w)**4, (x + y + z + w)**2 * (x + y + z + w)**2)
  end

  def test_polynomial_07
    l = Algebra::Polynomial.create(Integer, 'x', 'y', 'z')
    x, y, z = l.vars
    f = x * y * z
    assert_equal(f.sub(y, y - 1), x * (y - 1) * z)
  end

  def test_polynomial_08
    l = Algebra::Polynomial.create(Integer, 'x', 'y', 'z')
    x, y, z = l.vars
    f = (x - y) * (y - z - 1)
    assert_equal(f.sub(y, z + 1), 0)
  end
end
