#incenter
puts "too heavy ... skip (#{$0})"
exit
require 'algebra'

R = MPolynomial(Rational)
x,y,a1,a2,b1,b2,c1,c2 = R.vars('xya1a2b1b2c1c2')
Q = LocalizedRing(R)
x0,y0,a10,a20,b10,b20,c10,c20 = R.vars.map{|v| Q[v]}
V = Vector(R, 2)
W = Vector(Q, 2)
X, A, B, C = V[x,y], V[a1,a2], V[b1,b2], V[c1,c2]

def bisector(p1, p2, p3)
  p1,p2,p3 = [p1,p2,p3].map{|v| v.convert_to(W)}
  k1 = (p1.inner_product(p2))**2/p2.norm2
  k2 = (p1.inner_product(p3))**2/p3.norm2
  (k1-k2).numerator
end

def line(p1, p2, p3)
  SquareMatrix.det([[1, *p1], [1, *p2], [1, *p3]])
end

l1 = bisector(X-A, B-A, C-A)
p l1
l2 = bisector(X-B, C-B, A-B)
p l2
l3 = bisector(X-C, A-C, B-C)
p l3

s = line(A, B, C)

g = Groebner.basis [l1, l2, l3, s-1] #s-1 means non degeneracy

g.each do |f|
  p f
end

#p g.size > 1
