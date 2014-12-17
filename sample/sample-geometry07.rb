require "algebra"
R = MPolynomial(Rational)
m, b, a = R.vars("mba")
K = LocalizedRing(R)
a0, b0, m0 = K[a], K[b], K[m]

M = SquareMatrix(K, 3)
l0, l1, l2 = M[[0, 1, 0], [1, 1, -1], [1, 0, 0]]
m4 = M[[a0, 1, -a0], [1, b0, -b0], [m0, -1, 0]]
m40 = m4.dup; m40.set_row(0, l0)
m41 = m4.dup; m41.set_row(1, l1)
m42 = m4.dup; m42.set_row(2, l2)

def mdet(m, i)
  i = i % 3
  m.minor(i, 2).determinant * (-1) ** i
end

def tris(m, i)
  pts = [0, 1, 2] - [i]
  (m.determinant)**2 / mdet(m, pts[0]) / mdet(m, pts[1])
end

u0 = (tris(m4, 0) - tris(m40, 0)).numerator
u1 = (tris(m4, 1) - tris(m41, 1)).numerator
u2 = (tris(m4, 2) - tris(m42, 2)).numerator

puts [u0, u1, u2]
puts

[u0, u1, u2].each do |um|
  p um.factorize
end
puts

x = u0 / a / (m*b+1)
y = u1 / (m+a) / (b-1)
z = u2 / (-b*a+1)

p x
p y
p z
puts

gb = Groebner.basis([x, y, z])
puts gb
puts

gb.each do |v|
  p v.factorize
end
#(-1)(-mb + m + ba^3 + ba^2 - ba - a^2)
#(-1)(-ma + m + ba^2 - a^2)
#(-1)(b + a - 1)(-ba + 1)(a)
#(-1)(-ba + 1)(a)(a^2 + a - 1)

# => a = -1/2 + \sqrt{5}/2
