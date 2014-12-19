require "test/unit"
require "algebra"

class TestAlgebraicRoot < Test::Unit::TestCase
  def test_algebraic_root
    capital_r2, r2, r2_ = Root(Rational, 2) # r2 = sqrt(2), -sqrt(2)
    assert_equal(2, r2 * r2)
    # p r2 #=> sqrt(2)
    capital_r3, r3, r3_ = Root(capital_r2, 3)       # r3 = sqrt(3), -sqrt(3)
    assert_equal(3, r3 * r3)
    # p r3 #=> sqrt(3)
    capital_r6, r6, r6_ = Root(capital_r3, 6)       # R6 = R3, r6 = sqrt(6), -sqrt(6)
    assert_equal(-r2 * r3, r6)
    # p r6 #=> -r2r3
    assert_equal(4, (r6 + r2)*(r6 - r2))
    # p( (r6 + r2)*(r6 - r2) ) #=> 4

    # TODO: how to write unit tests?
    capital_f, a, b =  QuadraticExtensionField(Rational){|x| x**2 - x - 1}
    # fibonacci numbers
    (0..100).each do |n|
      puts( (a**n - b**n)/(a - b) )
    end
  end
end
