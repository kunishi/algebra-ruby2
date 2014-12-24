###################################################
#                                                 #
#  This is test script for 'algebraic-parser.rb'  #
#                                                 #
###################################################
require 'test/unit'
require "algebra/algebraic-parser.rb"
require "algebra/rational"
require "algebra/m-polynomial"
include Algebra

class TestAlgebraicParser < Test::Unit::TestCase
  class A
    def self.indeterminate(str)
      case str
      when "x"; 7
      when "y"; 11
      when /\d+/; eval($&)
      else
        raise
      end
    end
    def self.ground
      Fixnum
    end
  end

  class B < A
    def self.indeterminate(str)
      case str
      when /\d+/; Rational(eval($&))
      else
        super
      end
    end
  end

  def test_algebraic_parser_01
    assert_equal(28, AlgebraicParser.eval("x * y - x^2 + x/8", A))
    # p  AlgebraicParser.eval("x * y - x^2 + x/8", A) #=> 7*11 - 7**2 + 7/8 = 28
  end

  def test_algebraic_parser_02
    assert_equal(28, AlgebraicParser.eval("x * y - x^2 + x/8", B))
    # puts  AlgebraicParser.eval("x * y - x^2 + x/8", B)
    #                                         #=> 7*11 - 7**2 + 7/8 = 231/8
  end

  def test_algebraic_parser_03
    assert_equal(16, AlgebraicParser.eval("2^(-8+4-2+(3-1)^3)^2", Integer))
    # p  AlgebraicParser.eval("2^(-8+4-2+(3-1)^3)^2", Integer) #=> 16
  end

  def test_algebraic_parser_04
    capital_f = MPolynomial(Rational)
    x, y = capital_f.vars("xy")
    assert_equal(x -8r*y**3, AlgebraicParser.eval("- (2*y)**3 + x", capital_f))
    # p  AlgebraicParser.eval("- (2*y)**3 + x", capital_f) #=> -8y^3 + x
    capital_f.variables.clear
    assert_equal(x - 8r*y**3, AlgebraicParser.eval("x; y; - (2*y)**3 + x", capital_f))
    # p  AlgebraicParser.eval("x; y; - (2*y)**3 + x", capital_f) #=> x - 8y^3
  end
end
