############################################################
#                                                          #
#  This is test script for 'algebraic-extension-field.rb'  #
#                                                          #
############################################################
require "rubyunit"
require "algebra/algebraic-extension-field"
require "algebra/polynomial"
require "algebra/rational"

class Rational;def inspect; to_s; end;end

class TestAEF < Runit
  AEF = Algebra.AlgebraicExtensionField(Rational, "x") { |x|
    x ** 2 + 1
  }
  def test_aef
    aef1 = Algebra.AlgebraicExtensionField(AEF, "y") { |y|
      y ** 3 - 2
    }
    p aef1.def_polys
    p aef1.def_polys.collect{|f| f.type}
    p aef1.env_ring
    x, y = AEF.var, aef1.var
    z = (x + y)*(x + y)
    p z
    w = z.abs_lift.evaluate(y, x)
    p w
    assert_equal(w, 2*x*y-2)
  end
end

Tests(TestAEF)
