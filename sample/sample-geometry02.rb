require 'algebra'
R = MPolynomial(Rational)
x,y,a1,a2,b1,b2,c1,c2 = R.vars('xya1a2b1b2c1c2')

V = Vector(R, 2)
X, A, B, C = V[x,y], V[a1,a2], V[b1,b2], V[c1,c2]

def line(p1, p2, p3)
  SquareMatrix.det([[1, *p1], [1, *p2], [1, *p3]])
end

def vline(p1, p2, p3)
  (p1-p2).norm2 - (p1-p3).norm2
end

l1 = vline(X, A, B)
l2 = vline(X, B, C)
l3 = vline(X, C, A)

s = line(A, B, C)

g = Groebner.basis [l1, l2, l3, s-1] #s-1 means non degeneracy

g.each do |f|
  p f
end
#x - 1/2a1a2b1 + 1/2a1a2c1 + 1/2a1b1c2 - 1/2a1c1c2 - 1/2a1 - 1/2a2^2b2 + 1/2a2^2c2 + 1/2a2b1^2 - 1/2a2b1c1 + 1/2a2b2^2 - 1/2a2c2^2 - 1/2b1^2c2 + 1/2b1c1c2 - 1/2b2^2c2 + 1/2b2c2^2 - 1/2c1
#y + 1/2a1^2b1 - 1/2a1^2c1 - 1/2a1b1^2 + 1/2a1c1^2 + 1/2a2^2b1 - 1/2a2^2c1 - 1/2a2b1b2 - 1/2a2b1c2 + 1/2a2b2c1 + 1/2a2c1c2 + 1/2b1^2c1 + 1/2b1b2c2 - 1/2b1c1^2 -1/2b2c1c2 - 1/2b2 - 1/2c2
#a1b2 - a1c2 - a2b1 + a2c1 + b1c2 - b2c1 - 1
