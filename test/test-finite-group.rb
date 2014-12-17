########################################################################
#                                                                      #
#   Test Script for lib/finite-group.rb                                #
#                                                                      #
########################################################################
require "rubyunit"
require "algebra/finite-group"
require "algebra/permutation-group"

include Algebra
PG = PermutationGroup
P = Permutation
S5 = PG.symmetric(5)
A5 = PG.alternate(5)
S4 = PG.symmetric(4)
A4 = PG.alternate(4)
S3 = PG.symmetric(3)
A3 = PG.alternate(3)
T3 = PG[PG.unity(3), P[0, 2, 1]]
S2 = PG.symmetric(2)
e = P.unity(4)
a = P[1, 0, 2, 3]
b = P[0, 1, 3, 2]
A = PG[e, a]
B = PG[e, b]
C = PG[e, a, b, a*b]

class Rational;def inspect; to_s; end;end

class TestFiniteGroup < Runit
  #Operator Domain
  def test__star #test for *
    ab = A * B
    assert_equal(ab.class, Set)
    assert_equal(ab, C)
  end

  def test__slash #test for /
    s = S3 / S2
    t = Set[
      Set[P[1, 2, 0], P[0, 2, 1]],
      Set[P[0, 1, 2], P[1, 0, 2]],
      Set[P[2, 1, 0], P[2, 0, 1]]
    ]
    assert_equal(s, t)
  end

  def test__parcent #test for %
    s = S3 % S2
    t6 = Set[P[0, 2, 1], P[2, 1, 0], P[0, 1, 2]]
    t7 = Set[P[2, 1, 0], P[1, 0, 2], P[1, 2, 0]]
    assert(s == t6 || s == t7)
  end

  def test_orbit! #test for orbit!
    e = P.unity(4)
    a = P[1, 0, 2, 3]
    b = P[0, 1, 3, 2]
    x = PG[e, a]
    y = PG[e, b]
    x.orbit!(y)
    assert_equal(x, PG[e, a, b, a*b])
  end

  def test_initialize #test for initialize
    e = P.unity(4)
    a = P[1, 0, 2, 3]
    assert_equal(PG[e, a].size, 2)
  end

  def test_set_unity #test for set_unity
    e = P.unity(4)
    a = P[1, 0, 2, 3]
    assert_equal(PG[e, a].unity, e)
  end

  def test_semi_complete! #test for semi_complete!
    e = P.unity(4)
    a = P[1, 2, 0, 3]
    x = PG[e, a]
    x.semi_complete!
    assert_equal(x, PG[e, a, a**2])
  end

  def test_semi_complete #test for semi_complete
    e = P.unity(4)
    a = P[1, 2, 0, 3]
    x = PG[e, a]
    y = x.semi_complete
    assert_equal(x, PG[e, a])
    assert_equal(y, PG[e, a, a**2])
  end

  def test_complete! #test for complete!
    e = P.unity(4)
    a = P[1, 2, 0, 3]
    x = PG[e, a]
    x.complete!
    assert_equal(x, PG[e, a, a**2])
  end

  def test_complete #test for complete
    e = P.unity(4)
    a = P[1, 2, 0, 3]
    x = PG[e, a]
    y = x.complete
    assert_equal(x, PG[e, a])
    assert_equal(y, PG[e, a, a**2])
  end

  def test_self_dot_generate_strong #test for self.generate_strong
    a = PG.generate_strong(P.unity(3),
			   [P[0, 2, 1]] ,[P[1, 0, 2], P[2, 0, 1]])
    assert_equal(S3, a)
    a = PG.generate_strong(P.unity(3),
			   [P[2, 0, 1], P[1, 2, 0]])
    assert_equal(A3, a)
  end

  def test_closed? #test for closed?
    assert(S3.closed?)
    e = P.unity(4)
    a = P[1, 2, 0, 3]
    assert(!PG[e, a].closed?)
  end

  def test_subgroups #test for subgroups
    e = P.unity(2)
    a = P[1, 0]
    assert_equal(S2.subgroups, Set[PG[e], S2])

    e = P.unity(3)
    a = P[1, 0, 2]
    b = P[0, 2, 1]
    c = P[2, 1, 0]
    m = Set[
      PG[e],
      PG[e, a], PG[e, b], PG[e, c],
      A3, S3
    ]
    assert_equal(S3.subgroups, m)

    k = Set.phi
    S3.subgroups do |s|
      k << s
    end
    assert_equal(k, m)
  end

  def test_centralizer #test for centralizer
    assert_equal(S3.centralizer(S3), PG.unit_group(3))
    assert_equal(S3.centralizer(A3), A3)
    assert_equal(S3.centralizer(T3), T3)
    assert_equal(A3.centralizer(T3), PG.unit_group(3))
  end

  def test_center #test for center
    assert_equal(S3.center, PG.unit_group(3))
    assert_equal(A3.center, A3)
  end

  def test_center? #test for center?
    assert(!S3.center?(P[1, 2, 0]))
    assert(A3.center?(P[1, 2, 0]))
  end

  def test_normalizer #test for normalizer
    assert_equal(S3.normalizer(T3), T3)
    assert_equal(S3.normalizer(A3), S3)
  end

  def test_normal? #test for normal?
    assert(PG.unit_group(3).normal?(S3))
    assert(!S3.normal?(T3))
    assert(S3.normal?(A3))
    assert(S3.normal?(S3))
  end

  def test_normal_subgroups #test for normal_subgroups
    assert_equal(S3.normal_subgroups, Set[S3, A3, PG.unit_group(3)])
  end

  def test_conjugacy_class #test for conjugacy_class
    assert_equal(S3.conjugacy_class(P[2, 0, 1]).size, 2)
    assert_equal(S4.conjugacy_class(P[2, 0, 1, 3]).size, 8)
    assert_equal(S5.conjugacy_class(P[2, 0, 1, 4, 3]).size, 20)
  end

  def test_conjugacy_classes #test for conjugacy_classes
    assert_equal(S3.conjugacy_classes.map_s{|c| c.size},
		 Set[1, 3, 2])
    assert_equal(S4.conjugacy_classes.map_s{|c| c.size},
		 Set[6, 6, 8, 3, 1])
    assert_equal(S5.conjugacy_classes.map_s{|c| c.size},
		 Set[30, 24, 15, 10, 20, 20, 1])
  end

  def test_simple? #test for simple?
    assert(S2.simple?)
    assert(!S3.simple?)
    assert(A3.simple?)
    assert(!A4.simple?)
#    assert(!S4.simple?)
#    assert(A5.simple?)
  end

  def test_commutator_group #test for commutator_group
    assert_equal(A4.commutator, Set[P[0, 1, 2, 3], P[1, 0, 3, 2],
		   P[2, 3, 0, 1], P[3, 2, 1, 0]])
    assert(true)
  end

  def test_D #test for D
    assert_equal([A4.D(0).size, A4.D(1).size, A4.D(2).size], [12, 4, 1])
  end

  def test_commutator_series #test for commutator_series
    assert_equal(A4.commutator_series.collect{|x| x.size}, [12, 4, 1])
    assert_equal(S5.commutator_series.collect{|x| x.size}, [120, 60])
  end

  def test_solvable? #test for solvable?
    assert(S2.solvable?)
    assert(A3.solvable?)
    assert(S3.solvable?)
    assert(A4.solvable?)
    assert(S4.solvable?)
    assert(!A5.solvable?)
    assert(!S5.solvable?)
  end

  def test_K #test for K
    assert_equal(A3.K.size, 1)
    assert_equal(S3.K.size, 3)
    assert_equal(A4.K.size, 4)
    assert_equal(S4.K.size, 12)
    assert_equal(A5.K.size, 60)
    assert_equal(S5.K.size, 60)
  end

  def test_descending_central_series #test for descending_central_series
    assert_equal(A4.descending_central_series.collect{|x| x.size}, [12, 4])
    assert_equal(S5.descending_central_series.collect{|x| x.size}, [120, 60])
  end

  def test_Z #test for Z
    assert_equal(A3.Z, A3)
    assert_equal(A4.Z, A4.unit_group)
  end

  def test_ascending_central_series #test for ascending_central_series
    assert_equal(A3.ascending_central_series.collect{|x| x.size}, [1])
    assert_equal(S3.ascending_central_series.collect{|x| x.size}, [1])
    assert_equal(A4.ascending_central_series.collect{|x| x.size}, [1])
    assert_equal(S4.ascending_central_series.collect{|x| x.size}, [1])
  end

  def test_nilpotent? #test for nilpotent?
    assert(T3.nilpotent?)
    assert(A3.nilpotent?)
    assert(!S3.nilpotent?)
    assert(!A4.nilpotent?)
    assert(!A5.nilpotent?)
  end

  def test_nilpotency_class #test for nilpotency_class
    assert_equal(A3.nilpotency_class, 1)
  end

  def test_quotient_group
    e, a = S5.quotient_group(A5)
    assert_equal(e*e, e)
    assert_equal(a*a, e)
  end
end
Tests(TestFiniteGroup)
