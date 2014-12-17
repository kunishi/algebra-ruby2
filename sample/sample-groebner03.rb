require "algebra"
F5 = ResidueClassRing(Integer, 2)
F = AlgebraicExtensionField(F5, "a") {|a| a**3 + a + 1}
a = F.var
P = MPolynomial(F)

x, y, z = P.vars("xyz")
f1 = x + y**2 + z**2 - 1
f2 = x**2 + z**2 - y * a
f3 = x - z - a

f = x**3 + y**3 + z**3
q, r = f.divmod_s(f1, f2, f3)
p f == q.inner_product([f1, f2, f3]) + r #=> true
