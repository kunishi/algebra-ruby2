###################################################
#                                                 #
#  This is test script for 'algebraic-parser.rb'  #
#                                                 #
###################################################
require "algebra/algebraic-parser.rb"
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


p  AlgebraicParser.eval("x * y - x^2 + x/8", A) #=> 7*11 - 7**2 + 7/8 = 28

require "algebra/rational"

class B < A
  def self.indeterminate(str)
    case str
    when /\d+/; Rational(eval($&))
    else
  super
    end
  end
end
puts  AlgebraicParser.eval("x * y - x^2 + x/8", B)
                                        #=> 7*11 - 7**2 + 7/8 = 231/8
p  AlgebraicParser.eval("2^(-8+4-2+(3-1)^3)^2", Integer) #=> 16

require "algebra/m-polynomial"
include Algebra
F = MPolynomial(Rational)
p  AlgebraicParser.eval("- (2*y)**3 + x", F) #=> -8y^3 + x
F.variables.clear
p  AlgebraicParser.eval("x; y; - (2*y)**3 + x", F) #=> x - 8y^3
