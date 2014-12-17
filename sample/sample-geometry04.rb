require 'algebra'

R = MPolynomial(Rational)
x,y,a1,a2,b1,b2,c1,c2 = R.vars('xya1a2b1b2c1c2')
V = Vector(R, 2)
X, A, B, C = V[x,y], V[a1,a2], V[b1,b2], V[c1,c2]

def perpendicular(p0, p1, p2, p3)
  (p0-p1).inner_product(p2-p3)
end

def line(p1, p2, p3)
  SquareMatrix.det([[1, *p1], [1, *p2], [1, *p3]])
end

l1 = perpendicular(X, A, B, C)
l2 = perpendicular(X, B, C, A)
l3 = perpendicular(X, C, A, B)

s = line(A, B, C)
g = Groebner.basis [l1, l2, l3, s-1] #s-1 means non degeneracy

g.each do |f|
  p f
end
#x + a1a2b1 - a1a2c1 - a1b1c2 + a1c1c2 + a2^2b2 - a2^2c2 - a2b1^2 + a2b1c1 - a2b2^2 + a2c2^2 + b1^2c2 - b1c1c2 - b1 + b2^2c2 - b2c2^2
#y - a1^2b1 + a1^2c1 + a1b1^2 - a1c1^2 - a2^2b1 + a2^2c1 + a2b1b2 + a2b1c2 - a2b2c1 - a2c1c2 - a2 - b1^2c1 - b1b2c2 + b1c1^2 + b2c1c2
#a1b2 - a1c2 - a2b1 + a2c1 + b1c2 - b2c1 - 1
