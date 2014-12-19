############################################################
#                                                          #
#  This is test script for 'algebraic-extension-field.rb'  #
#                                                          #
############################################################
require "rubyunit"
require "algebra/algebraic-extension-field"
require "algebra/polynomial"
require "algebra/rational"

class TestAEF < Test::Unit::TestCase
  def setup
    @aef = Algebra.AlgebraicExtensionField(Rational, "x") { |x|
      x ** 2 + 1
    }
    @aef1 = Algebra.AlgebraicExtensionField(@aef, "y") { |y|
      y ** 3 - 2
    }
  end

  def test_aef
    p @aef1.def_polys
    # TODO: type method is missing.
    p @aef1.def_polys.collect{|f| f.class}
    p @aef1.env_ring
    x, y = @aef.var, @aef1.var
    z = (x + y)*(x + y)
    p z
    w = z.abs_lift.evaluate(y, x)
    p w
    assert_equal(w, 2*x*y-2)
  end
end
