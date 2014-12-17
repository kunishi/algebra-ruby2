require "algebra"

F13 = ResidueClassRing(Integer, 13)
F = AlgebraicExtensionField(F13, "a") {|a| a**2 - 2}
a = F.var
RF = RationalFunctionField(F, "x")
x = RF.var

p( (a/4*x + RF.unity/2)/(x**2 + a*x + 1) +
  (-a/4*x + RF.unity/2)/(x**2 - a*x + 1) )
#=> 1/(x**4 + 1)
