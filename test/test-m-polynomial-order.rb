#######################################################
#                                                     #
#  This is the test of order of MPolynomial           #
#                                                     #
#######################################################
require 'test/unit'
require 'algebra'

class TestMIndex < Test::Unit::TestCase
  def setup
    @P = Algebra::MPolynomial.create(Integer, 'x', 'y', 'z')
  end

  def test_compare
    x, y, z = @P.vars
    @P.with_ord(:lex) do
      assert(y * z**2 > y)
      assert(y**2 * z**2 > y * z**2)
      assert(y**2 * z**2 > y * z**10)
      assert(y**2 * z**2 < x * z**3)
      assert(y * z**2 > 1)
    end
  end

  def test_compare_grlex
    x, y, z = @P.vars
    @P.with_ord(:grlex) do
      assert(y * z**2 > z)
      assert(y**2 * z**2 > y * z**2)
      assert(y**2 * z**2 < y * z**10)
      assert(y**2 * z**2 < x * z**3)
      assert(y * z**2 > 1)
    end
  end

  def test_compare_grevlex
    x, y, z = @P.vars
    @P.with_ord(:grevlex) do
      assert(y * z**2 > z)
      assert(y**2 * z**2 > y * z**2)
      assert(y**2 * z**2 < y * z**10)
      assert(y**2 * z**2 > x * z**3)
      assert(y * z**2 > 1)
    end
  end

  def test_compare_vars
    x, y, z = @P.vars
    f = x + y + z
    @P.with_ord(nil, [0, 1, 2], [f]) do
      assert_equal('x + y + z', f.to_s)
    end
    @P.with_ord(nil, [1, 0, 2], [f]) do
      assert_equal('y + x + z', f.to_s)
    end
    @P.with_ord(nil, [2, 1, 0], [f]) do
      assert_equal('z + y + x', f.to_s)
    end
    @P.with_ord(nil, [0, 2, 1], [f]) do
      assert_equal('x + z + y', f.to_s)
    end
  end
end
