########################################################################
#                                                                      #
#   Test Script for lib/permutation-group.rb                           #
#                                                                      #
########################################################################
require "rubyunit"
require "algebra/permutation-group.rb"
include Algebra
Pg = PermutationGroup
P = Permutation
class Rational;def inspect; to_s; end;end

class TestPermutationGroup < Runit
  #PermutationGropu
  def test_self_dot_unity #test for self.unity
    assert_equal(P.unity(3), [0, 1, 2])
  end

  def test_self_dot_perm #test for self.perm
    assert_equal(Pg.perm([0, 1, 2]), P.new([0, 1, 2]))
  end

  def test_self_dot_symmetric #test for self.symmetric
    assert_equal(Pg.symmetric(3), Pg[P[0, 1, 2], P[0, 2, 1],
		   P[1, 0, 2], P[1, 2, 0],
		   P[2, 0, 1], P[2, 1, 0]])
  end

  def test_self_dot_alternate #test for self.alternate
    assert_equal(Pg.alternate(3), Pg[P[0, 1, 2],
		   P[1, 2, 0],
		   P[2, 0, 1]])
  end

  #Permutation
  def test_self_dot__bra #test for self.[]
    assert_equal(P[0, 1, 2], P.new([0, 1, 2]))
  end

  def test_self_dot_unity #test for self.unity
    assert_equal(P.unity(3), P[0, 1, 2])
  end

  def test_initialize #test for initialize
    assert_equal(P.new([0, 1, 2]), P[0, 1, 2])
    assert(true)
  end

  def test_unity #test for unity
    assert_equal(P[2, 1, 0].unity, P[0, 1, 2])
  end

  def test_degree #test for degree
    assert_equal(P[0, 1, 2].degree, 3)
  end

  def test_each #test for each
    a = []
    P[0, 1, 2].each do |i|
      a << i
    end
    assert_equal(a, [0, 1, 2])
  end

  def test__bra #test for []
    assert_equal(P[0, 1, 2][1], 1)
  end

  def test_index #test for index
    assert_equal(P[2, 1, 0].index(0), 2)
  end

  def test_right_act #test for right_act
    assert_equal(P[1, 2, 0].right_act(P[0, 2, 1]), P[2, 1, 0])
  end

  def test__star #test for *
    assert_equal(P[1, 2, 0].right_act(P[0, 2, 1]), P[2, 1, 0])
  end

  def test_left_act #test for left_act
    assert_equal(P[1, 2, 0].left_act(P[0, 2, 1]), P[1, 0, 2])
  end

  def test_inverse #test for inverse
    assert_equal(P[1, 2, 0].inverse, P[2, 0, 1])
  end

  def test_inv #test for inv
    assert_equal(P[1, 2, 0], P[2, 0, 1].inv)
  end

  def test_sign #test for sign
    assert_equal(P[0, 2, 1].sign, -1)
    assert_equal(P[1, 2, 0].sign, 1)
  end

  def test_conjugate #test for conjugate
    assert_equal(P[1, 2, 0].conjugate(P[0, 2, 1]), P[2, 0, 1])
  end

  def test_decompose_cyclic #test for decompose_cyclic
    assert_equal(P[0, 6, 3, 2, 1, 4, 5].decompose_cyclic, [[1,6,5,4], [2,3]])
  end

=begin
  def test_self_dot_load #test for self.load
  end

  def test_self_dot_subgr_load #test for self.subgr_load
  end

  def test_conjugate0 #test for conjugate0
  end
=end
  require "algebra/finite-map"

  def test_to_map #test for to_Mapa
    assert_equal(P[1, 2, 0].to_map, Map[0=>1, 1=>2, 2=>0])
  end

  def test_decompose_transposition #test for decompose_transposition
    assert_equal(P[0, 6, 3, 2, 1, 4, 5].decompose_transposition,
		 [[4, 5], [2, 3], [1, 6], [1, 5]])
  end

  def test_Permutation_dot_cyclic2perm
    assert_equal(P.cyclic2perm([[1,6,5,4], [2,3]]), P[0, 6, 3, 2, 1, 4, 5])
    assert_equal(P.cyclic2perm([[1,6,5,4], [2,3]], 7), P[0, 6, 3, 2, 1, 4, 5])
  end

end
Tests(TestPermutationGroup)
