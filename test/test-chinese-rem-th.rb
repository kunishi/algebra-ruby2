#################################################
#                                               #
#  This is test script for 'chinese-rem-th.rb'  #
#                                               #
#################################################
require 'test/unit'
require 'algebra'
require 'algebra/chinese-rem-th.rb'
include ChineseRemainderTheorem

class TestChineseRemTh < Test::Unit::TestCase
  def test_chinese_rem_th
    capital_zp = ResidueClassRing(Integer, 5)
    capital_p = Polynomial(capital_zp, 'x')
    x = capital_p.var
    a = x + 1
    b = x + 2
    c = x + 3
    #  ary = [b*c, c*a, a*b]
    ary = [a, b, c]
    f = a * b * c
    #  coeffs =  decompose_on_factors(P.unity, ary)
    coeffs = decompose_on_cofactors_modp(capital_p.unity, ary, mk_cofacts(ary))

    assert_equal([x**2 + 1, x**2 - x + 3, x**2 + 3 * x + 2], mk_cofacts(ary))
    assert_equal([3, 4, 3], coeffs)
    assert_equal(1, coeffs.inner_product(mk_cofacts(ary)))
    # p cofacts = mk_cofacts(ary)
    # p coeffs
    # p coeffs.inner_product(cofacts)

    # exit
    # PZ = Polynomial(Integer, "x")
    # x = PZ.var
    # a = (x + 1)**2
    # b = (x + 2)**3
    # c = (x + 3)**1
    # ary = [a, b, c]
    # p decompose_on_cofactors_over_p_adic_int(PZ.unity, ary, mk_cofacts(ary),
    #                      11, 2)
  end
end
