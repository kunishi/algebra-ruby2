#################################################
#                                               #
#  This is test script for 'chinese-rem-th.rb'  #
#                                               #
#################################################
require "algebra/chinese-rem-th.rb"
include Algebra
include ChineseRemainderTheorem
require "algebra/polynomial"
require "algebra/residue-class-ring"
require "algebra/array-supplement"
require "algebra/polynomial-factor"
Zp = ResidueClassRing(Integer, 5)
P = Polynomial(Zp, "x")
x = P.var
a = x + 1
b = x + 2
c = x + 3
#  ary = [b*c, c*a, a*b]
ary = [a, b, c]
f = a*b*c
#  coeffs =  decompose_on_factors(P.unity, ary)
coeffs =  decompose_on_cofactors_modp(P.unity, ary, mk_cofacts(ary))
p cofacts = mk_cofacts(ary)
p coeffs
p coeffs.inner_product(cofacts)

exit
PZ = Polynomial(Integer, "x")
x = PZ.var
a = (x + 1)**2
b = (x + 2)**3
c = (x + 3)**1
ary = [a, b, c]
p decompose_on_cofactors_over_p_adic_int(PZ.unity, ary, mk_cofacts(ary),
                     11, 2)
