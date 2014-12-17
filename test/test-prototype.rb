#######################################################
#                                                     #
#  This is the prototype test script                  #
#                                                     #
#######################################################
require "rubyunit"
class Rational;def inspect; to_s; end;end

class TestProtoType < Runit
  def test_factorize
    assert_equal(0, 0)
    assert(1 > 0)
  end
end

Tests(TestProtoType)
