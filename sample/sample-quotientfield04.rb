require "algebra"

F13 = ResidueClassRing(Integer, 13)
F = RationalFunctionField(F13, "x")
x = F.var
AF = AlgebraicExtensionField(F, "a") {|a| a**2 - 2*x}
a = AF.var

p( (a/4*x + AF.unity/2)/(x**2 + a*x + 1) +
  (-a/4*x + AF.unity/2)/(x**2 - a*x + 1) )
#=> (-x^3 + x^2 + 1)/(x^4 + 11x^3 + 2x^2 + 1)
