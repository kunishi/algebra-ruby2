###############################################
#                                             #
#  This is test script for 'm-polynomial.rb'  #
#                                             #
# date: 2003.06.01                            #
#                                             #
###############################################
require 'test/unit'
require "algebra/rational.rb"
require "algebra/m-polynomial.rb"
require "mathn"

include Algebra

class TestMPolynomial < Test::Unit::TestCase
  Foo = MPolynomial(Integer)
  P0 = Algebra.MPolynomial(Rational)
  P = MPolynomial(Rational)
  Q = MPolynomial(Integer)

  def test_m_polynomial_01
    f = Foo[MIndex[1,1]=>1, MIndex[1,3]=>4, MIndex[]=>9]
    g = Foo[MIndex[1,1]=>1, MIndex[1,3]=>4, MIndex[]=>9,
      MIndex[0,2,3]=>6, MIndex[2,3]=>-1, MIndex[2]=>-5,MIndex[0,1]=>7]
    # puts f.to_s, g.to_s, (f*g).to_s
    # assert_equal("4[1,3] + [1,1] + 9", f.to_s)
    # assert_equal("-[2,3] - 5[2] + 4[1,3] + [1,1] + 6[0,2,3] + 7[0,1] + 9", g.to_s)
    # assert_equal(
    #   "-4[3,6] - [3,4] - 20[3,3] - 5[3,1] + 16[2,6] + 8[2,4] - 9[2,3] + [2,2] - 45[2] + 24[1,5,3] + 28[1,4] + 6[1,3,3] + 72[1,3] + 7[1,2] + 18[1,1] + 54[0,2,3] + 63[0,1] + 81",
    #   (f*g).to_s
    # )
  end

  def test_m_polynomial_02
    x, y = P0.vars("xy")

    P0.with_ord(:lex) do
      assert_equal((x*y**2 -x).divmod(x*y - 1, y**2 - 1), [[y, 0], -x + y])
      assert_equal((x*y**2 -x).divmod(x*y - 1, y**2 - 1), [[y, 0], -x + y])
    end
  end

  def test_m_polynomial_03
    x, y = P0.vars("xy")
    P0.with_ord(:lex) do
      assert_equal((x+y**2).divmod(x+y), [[1], y**2 - y])
    end
  end

  def test_m_polynomial_04
    x, y = P0.vars("xy")

    P0.with_ord(:lex, [1,0]) do
      assert_equal((x+y**2).divmod(x+y), [[y - x], x**2 + x])
    end
  end

  def test_m_polynomial_05
    x, y = P0.vars("xy")

    P0.with_ord(:lex, nil) do
      assert_equal((x*y+y**2).divmod(x + y**2), [[y], -y**3 + y**2])
    end
  end

  def test_m_polynomial_06
    x, y = P0.vars("xy")

    P0.with_ord(:grlex, nil) do
      assert_equal((x*y+y**2).divmod(x + y**2), [[1], x*y - x])
    end
  end

  def test_m_polynomial_07
    x, y, z = P.vars("xyz")
    f = x**2*y + x*y**2 + y*2 + z**3
    g = x*y-z**3
    h = y*2-6*z

    assert_equal(f.derivate(x), 2*x*y + y**2)
    assert_equal(f.derivate(y), x**2 + 2*x*y + 2)
    assert_equal(f.derivate("x"), 2*x*y + y**2)
  end

  def test_m_polynomial_08
    x, y, z = P.vars("xyz")
    f = x**2*y + x*y**2 + y*2 + z**3
    g = x*y-z**3
    h = y*2-6*z

    P.set_ord(:lex)
    #puts "LEX:"
    #puts "(#{f}).divmod([#{g}, #{h}]) =>"
    fgh = f.divmod(g, h)
    assert_equal(fgh, [[x + y, 1/2*z**3 + 1], x*z**3 + 3*z**4 + z**3 + 6*z])
    #puts
  end

  def test_m_polynomial_09
    x, y, z = P.vars("xyz")
    f = x**2*y + x*y**2 + y*2 + z**3
    g = x*y-z**3
    h = y*2-6*z

    P.method_cash_clear(f, g, h)
    P.set_ord(:grlex)
    #puts "GRLEX:"
    #puts "(#{f}).divmod([#{g}, #{h}]) =>"
    fgh = f.divmod(g, h)
    ###assert(fgh , [[-1, 1], x**2*y + x*y**2 + x*y + 6*z])
    assert_equal(fgh , [[-1, 1/2*x**2 + 1/2*x*y + 3/2*x*z + 1/2*x + 1], 3*x**2*z + 9*x*z**2 + 3*x*z + 6*z])
    #puts
  end

  def test_m_polynomial_10
    x, y, z = P.vars("xyz")
    f = x**2*y + x*y**2 + y*2 + z**3
    g = x*y-z**3
    h = y*2-6*z

    P.method_cash_clear(f, g, h)
    P.set_ord(:grevlex)
    #puts "GREVLEX:"
    #puts "(#{f}).divmod([#{g}, #{h}]) =>"
    fgh = f.divmod(g, h)
    assert_equal(fgh, [[-1, 1/2*x**2 + 1/2*x*y + 3/2*x*z + 1/2*x + 1], 3*x**2*z + 9*x*z**2 + 3*x*z + 6*z] )
    #puts
  end

  def test_m_polynomial_11
    P.variables.clear
    z, y, x = P.vars("zyx")
    f = x**2*y + x*y**2 + y*2 + z**3
    g = x*y-z**3
    h = y*2-6*z
    #puts "GREVLEX: order z, y, x"
    #puts "(#{f}).divmod([#{g}, #{h}]) =>"
    fgh = f.divmod(g, h)
    assert_equal(fgh , [[-1, 0], y**2*x + y*x**2 + y*x + 2*y])
    #puts
  end

  def test_m_polynomial_12
    x, y, z = Q.vars('xyz')
    f = x * y * z
    assert_equal(f.sub(y, y-1), x*(y-1)*z)
    f = (x - y)*(y - z - 1)
    assert_equal(f.sub(y, z+1), 0)
  end
end
