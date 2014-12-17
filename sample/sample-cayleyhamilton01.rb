require "algebra"

n = 4
R = MPolynomial(Integer)
MR = SquareMatrix(R, n)
m = MR.matrix{|i, j| R.var("x#{i}#{j}") }
Rx = Polynomial(R, "x")
ch = m.char_polynomial(Rx)
p ch.evaluate(m) #=> 0
