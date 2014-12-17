# Algebraic Parser
#
#   by Shin-ichiro Hara
#
# Version 1.1 (2001.04.08)

require "algebra/numeric-supplement"

class AlgebraicParser
  def self.eval(str, klass)#, coeff = Numeric)
    new(str, klass).compile
  end

  Var = '[a-zA-Z]\d*'
  Num = '\d+(?:\.\d*)?'
  Op = '(?:\*\*|[+\-*\/^])'
  Gr = '[\(\)]'
  Dlm = ';'

  def initialize(str, klass)
    @klass = klass
    @coeff = klass.ground
    @s = str.gsub(/\s+/, '').scan(/#{Dlm}|#{Num}|#{Op}|#{Gr}|#{Var}|.+/o)
    @basis = [] # stack for the basis of the power
  end
  def compile; sentence; end

  private
  def head; @s[0]; end

  def succ(x = nil)
    raise "Error: receive #{x} expect #{head}" if x && x != head
    @s.shift
  end

  def sentence
    e = expr
    while /^#{Dlm}$/ =~ head
      succ(";")
      e = expr
    end
    e
  end

  def expr
    e = expr1
    while /^[+-]$/ =~ head
      case succ
      when "+"
	e += expr1
      when "-"
	e -= expr1
      end
    end
    e
  end

  def expr1
    case head
    when "+"; succ; term
    when "-"; succ; - term
    else term
    end
  end
  
  def term
    e = sequence
    while /^[*\/]$/ =~ head #/
      case succ
      when "*"
	e = e * sequence
      when "/"
	e /= sequence
      end
    end
    e
  end
  
  def sequence
    e = power
    while head && head !~ /^#{Dlm}$|^#{Op}$|^#{Gr}$/o
      e *= power
    end 
    e
  end

  def power
    @basis.push(k = factor)
    n = 0
    while /^(?:\*\*)$|^\^$/ =~ head
      succ
      @basis.push(factor)
      n += 1
    end
    f = @basis.pop
    while n > 0
      f = (@basis.pop) ** f
      n -= 1
    end
    f
  end

  def factor
    case head
    when "("; succ; e = sentence; succ(")"); e
    when /^#{Num}$/o
      @basis.empty? ? @coeff.indeterminate(succ) : eval(succ)
    when /^#{Var}$/o; @klass.indeterminate(succ)
    else
      raise "unknown token '#{head}'"
    end
  end
end

if $0 == __FILE__
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
  F = MPolynomial(Rational)
  p  AlgebraicParser.eval("- (2*y)**3 + x", F) #=> -8y^3 + x
  F.variables.clear
  p  AlgebraicParser.eval("x; y; - (2*y)**3 + x", F) #=> x - 8y^3
end
