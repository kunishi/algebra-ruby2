require "runit/testcase"
require "runit/cui/testrunner"

Runit = RUNIT::TestCase
def Tests(x)
  r = RUNIT::CUI::TestRunner.run(x.suite)
  exit(r.error_size + r.failure_size)
end

if __FILE__ == $0
#  require "polynomial"
  require "algebra"
  
  P = Polynomial(Integer, "x")
  
  class TestPolynomial < RUNIT::TestCase
    def test_products
      x = P.var
      assert_equal(x**2 + 3*x + 2, (x + 1)*(x + 2))
      assert_equal(x**3 + 3*x**2 + 3*x + 1, (x + 1)**3)
    end
  end
  
  #RUNIT::CUI::TestRunner.run(TestPolynomial.suite).succeed?
  Tests(TestPolynomial)
end
