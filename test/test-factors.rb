##################################################
#                                                #
#  This is test script for 'product-factors.rb'  #
#                                                #
##################################################
require "rubyunit"
require "algebra/factors.rb"
include Algebra

PF = Factors

class TestProductFactors < Runit
  def test_int
    facts = PF.new
    probrem = [2, 3, 5, 7, 11, 13, 3, 2, 7, 3]
    pi = 1
    probrem.each do |n|
      pi *= n
      facts << n
    end
    p facts
    assert_equal(pi, facts.pi)
    assert_equal(PF.mk(2,2, 3,3, 5,1, 7,2, 11,1, 13,1), PF[*probrem])
  end
end

Tests(TestProductFactors)

