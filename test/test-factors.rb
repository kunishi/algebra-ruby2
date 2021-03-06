##################################################
#                                                #
#  This is test script for 'product-factors.rb'  #
#                                                #
##################################################
require 'test/unit'
require 'algebra'

class TestProductFactors < Test::Unit::TestCase
  def setup
    @PF = Factors
  end

  def test_int
    capital_p_capital_f = Factors
    facts = capital_p_capital_f.new
    probrem = [2, 3, 5, 7, 11, 13, 3, 2, 7, 3]
    pi = 1
    probrem.each do |n|
      pi *= n
      facts << n
    end
    # p facts
    assert_equal(pi, facts.pi)
    assert_equal(capital_p_capital_f.mk(2, 2, 3, 3, 5, 1, 7, 2, 11, 1, 13, 1),
                 capital_p_capital_f[*probrem])
  end
end
