#####################################################
#                                                   #
#  This is test script for 'residue-class-ring.rb'  #
#                                                   #
#####################################################
require 'test/unit'
require "algebra/residue-class-ring.rb"
require 'algebra/polynomial'
require "algebra/rational"

include Algebra

class TestResidueClassRing < Test::Unit::TestCase
  def test_residue_class_ring_01
    z13 = ResidueClassRing.create(Integer, 13)

    a, b, c, d, e, f, g = z13
    assert_equal(
      [6, 2, 8, 9, 5, 7, 1, 1, 1],
      [e + c, e - c, e * c, e * 2001, 3 + c, 1/c, 1/c * c,
        d / d, b * 1 / b]
    )
    # p [e + c, e - c, e * c, e * 2001, 3 + c, 1/c, 1/c * c,
    #   d / d, b * 1 / b] #=> [6, 2, 8, 9, 5, 7, 1, 1, 1]
  end

  def test_residue_class_ring_02
    z13 = ResidueClassRing.create(Integer, 13)

    a, b, c, d, e, f, g = z13
    assert_equal(
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      (1...13).collect{|i|  z13[i]**12}
    )
    # p( (1...13).collect{|i|  z13[i]**12} )
    #         #=> [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
  end

  def test_residue_class_ring_03
    px = Polynomial(Rational, "x")
    #  Px = Polynomial(Z13, "x")

    x = px.var
    f = ResidueClassRing(px, x**2 + x + 1)
    x = f[x]
    assert_equal(-x - 1, (x + 1)**100)
    # p( (x + 1)**100 )    #=> -x - 1
  end

  def test_residue_class_ring_04
    px = Polynomial(Rational, "x")
    #  Px = Polynomial(Z13, "x")

    x = px.var
    f = ResidueClassRing(px, x**2 + x + 1)
    x = f[x]

    g = Polynomial(f, "y")
    y = g.var

    assert_equal(
      y**7 + (7*x + 7)*y**6 + 21*x*y**5 - 35*y**4 + (-35*x - 35)*y**3 - 21*x*y**2 + 7*y + x + 1,
      (x + y + 1)** 7
    )
    # p( (x + y + 1)** 7 )
      #=> y^7 + (7x + 7)y^6 + 8xy^5 + 4y^4 + (4x + 4)y^3 + 5xy^2 + 7y + x + 1
  end

  def test_residue_class_ring_05
    px = Polynomial(Rational, "x")
    #  Px = Polynomial(Z13, "x")

    x = px.var
    f = ResidueClassRing(px, x**2 + x + 1)
    x = f[x]

    g = Polynomial(f, "y")
    y = g.var

    h = ResidueClassRing(g, y**5 + x*y + 1)
    y = h[y]

    assert_equal(
      -35*y**4 + (-36*x -35)*y**3 + (-21*x + 6)*y**2 + (14*x + 21)*y - 20*x + 1,
      (x + y + 1)**7
    )
    # p( (x + y + 1)**7 )
      #=> 4y^4 + (3x + 4)y^3 + (5x + 6)y^2 + (x + 8)y + 6x + 1
  end

  def test_residue_class_ring_06
    px = Polynomial(Rational, "x")
    #  Px = Polynomial(Z13, "x")

    x = px.var
    f = ResidueClassRing(px, x**2 + x + 1)
    x = f[x]

    g = Polynomial(f, "y")
    y = g.var

    h = ResidueClassRing(g, y**5 + x*y + 1)
    y = h[y]

    assert_equal(
      (Rational(1798, 3)*x + Rational(1825, 9))*y**4 + (-74*x + Rational(5176, 9))*y**3 + (-Rational(6886, 9)*x - Rational(5917, 9))*y**2 + (Rational(1826, 3)*x - Rational(3101, 9))*y + Rational(2146, 9)*x + Rational(4702, 9),
      1/(x + y + 1)**7
    )
    # p( 1/(x + y + 1)**7 )
      #=> (1798/3x + 1825/9)y^4 + (-74x + 5176/9)y^3 +
      #     (-6886/9x - 5917/9)y^2 + (1826/3x - 3101/9)y + 2146/9x + 4702/9
  end

  def test_residue_class_ring_07
    #require 'polynomial'
    #  A = Polynomial(Rational, "x")
    z7 = ResidueClassRing.create(Integer, 7)
    a = Polynomial(z7, "x")
    x = a.var
    b = Polynomial(a, "y")
    y = b.var
    c = Polynomial(b, "z")
    z = c.var
    d = Polynomial(c, "w")
    w = d.var
    assert_equal(w**7 + z**7 + y**7 + x**7, (x+y+z+w)**7)
    # p( (x+y+z+w)**7 ) #=> w^7 + z^7 + y^7 + x^7
  end
end
