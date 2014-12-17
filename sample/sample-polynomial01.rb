require "algebra"
P = Polynomial.create(Integer, "x")
x = P.var
p((x + 1)**100) #=> x^100 + 100x^99 + ... + 100x + 1
