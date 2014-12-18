require "test/unit"

# Runit = Test::Unit::TestCase
def Tests(x)
end

if __FILE__ == $0
#  require "polynomial"
  require "algebra"

  P = Polynomial(Integer, "x")

  class TestPolynomial < Test::Unit::TestCase
    def test_products
      x = P.var
      assert_equal(x**2 + 3*x + 2, (x + 1)*(x + 2))
      assert_equal(x**3 + 3*x**2 + 3*x + 1, (x + 1)**3)
    end
  end

  #RUNIT::CUI::TestRunner.run(TestPolynomial.suite).succeed?
  Tests(TestPolynomial)
end
