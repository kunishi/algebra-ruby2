# Test of Cayley-Hamilton's Theory
#
#   by Shin-ichiro Hara
#
# Version 1.0 (2001.04.08)

require "algebra/matrix-algebra"
require "algebra/m-polynomial"
require "algebra/polynomial"
require "algebra/polynomial-converter"
include Algebra

n = Integer(ARGV.shift || 2)
$mul = ARGV.shift
case n
when 2
  unless $mul
    R = MPolynomial(Integer)
    a, b, c, d = R.vars("abcd")
  else
    R = Polynomial.over(Integer, *"abcd".scan(/./))
    a, b, c, d = R.vars
  end
  Rx = Polynomial(R, "x")
  x = Rx.var

  M2 = SquareMatrix(Rx, 2)
  m = M2[
    [a, b],
    [c, d]
  ]
when 3
  unless $mul
    R = MPolynomial(Integer)
    a, b, c, d, e, f, g, h, i, j = R.vars("abcdefghij")
  else
    R = Polynomial.over(Integer, *"abcdefghi".scan(/./))
    a, b, c, d, e, f, g, h, i = R.vars
  end
  Rx = Polynomial(R, "x")
  x = Rx.var

  M3 = SquareMatrix(Rx, 3)
  m = M3[
    [a, b, c],
    [d, e, f],
    [g, h, i]
  ]
else
  unless $mul
    if true
      R = MPolynomial(Integer)
      MR = SquareMatrix(R, n)
      m = MR.matrix{|i, j| R.var("x#{i}#{j}") }
      Rx = Polynomial(R, "x")
      ch = m.char_polynomial(Rx)
      p ch.evaluate(m)
      exit
    else
      R = MPolynomial(Integer)
      Rx = Polynomial(R, "x")
      M = SquareMatrix(Rx, n)
      m = M.matrix{|i, j| R.var("x#{i}#{j}") }
      x = Rx.var
    end
  else
    puts "not implemented."
    exit
  end
end

p m
p (x - m)
det = (x - m).determinant
p det
p det.evaluate(m)
