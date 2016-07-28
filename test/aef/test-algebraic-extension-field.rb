############################################################
#                                                          #
#  This is test script for 'algebraic-extension-field.rb'  #
#                                                          #
############################################################
require 'test/unit'
require 'algebra'

class TestAEF < Test::Unit::TestCase
  def setup
    @aef = AlgebraicExtensionField(Rational, 'x') do |x|
      x**2 + 1
    end
    @aef1 = AlgebraicExtensionField(@aef, 'y') do |y|
      y**3 - 2
    end
  end

  def test_aef
    x = @aef.var
    y = @aef1.var

    assert_equal([x**2 + 1, y**3 - 2], @aef1.def_polys.to_ary)
    # p @aef1.def_polys
    # p @aef1.def_polys.collect{|f| f.class}
    # p @aef1.env_ring

    z = (x + y) * (x + y)
    # p z
    assert_equal(y**2 + Rational(2) * x * y - 1, z)

    w = z.abs_lift.evaluate(y, x)
    # p w
    assert_equal(w, 2 * x * y - 2)
  end
end
