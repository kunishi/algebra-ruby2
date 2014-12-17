require 'algebra'
R = MPolynomial(Rational)
x,y,a1,a2,b1,b2,c1,c2 = R.vars('xya1a2b1b2c1c2')

V = Vector(R, 2)
X, A, B, C = V[x,y], V[a1,a2], V[b1,b2], V[c1,c2]

D = (B + C) /2
E = (C + A) /2
F = (A + B) /2

def line(p1, p2, p3)
  SquareMatrix.det([[1, *p1], [1, *p2], [1, *p3]])
end

l1 = line(X, A, D)
l2 = line(X, B, E)
l3 = line(X, C, F)
s = line(A, B, C)

g = Groebner.basis [l1, l2, l3, s-1] #s-1 means non degeneracy

g.each_with_index do |f, i|
  p f
end
#x - 1/3a1 - 1/3b1 - 1/3c1
#y - 1/3a2 - 1/3b2 - 1/3c2
#a1b2 - a1c2 - a2b1 + a2c1 + b1c2 - b2c1 - 1
