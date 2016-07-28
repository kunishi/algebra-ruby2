############################################################
#                                                          #
#  This is test script for 'galois-group.rb'  #
#                                                          #
############################################################
require 'test/unit'
require 'algebra'

class TestAEF < Test::Unit::TestCase
  def setup
    @P = Algebra.Polynomial(Rational, 'x')
  end

  def test_galois_group_0
    x = @P.var
    f = x**2 - 1
    expected = PermutationGroup[
      Permutation[0, 1]
    ]
    assert_equal(expected, f.galois_group)
  end

  def test_galois_group_1
    x = @P.var
    f = x**3 - 3 * x + 1
    expected = PermutationGroup[
      Permutation[2, 0, 1],
      Permutation[1, 2, 0],
      Permutation[0, 1, 2]
    ]
    assert_equal(expected, f.galois_group)
  end

  def test_galois_group_2
    x = @P.var
    f = x**3 - 2
    expected = PermutationGroup[
      Permutation[2, 1, 0],
      Permutation[2, 0, 1],
      Permutation[1, 0, 2],
      Permutation[1, 2, 0],
      Permutation[0, 1, 2],
      Permutation[0, 2, 1]
    ]
    assert_equal(expected, f.galois_group)
  end

  def test_galois_group_3
    x = @P.var
    f = (x**2 - 2) * (x**2 - 3)
    expected = PermutationGroup[
      Permutation[0, 3, 2, 1],
      Permutation[2, 3, 0, 1],
      Permutation[0, 1, 2, 3],
      Permutation[2, 1, 0, 3]
    ]
    assert_equal(expected, f.galois_group)
  end

  def test_galois_gr
    x = @P.var

    for i in 0..3
      #      next if i != 2
      f = [
        x**2 - 1, # 0
        x**3 - 3 * x + 1, # 1
        x**3 - 2, # 2
        (x**2 - 2) * (x**2 - 3), # 3
        x**3 - x + 1, # 4
        x**4 + 1, # 5
      ][i]
      gsize = [1, 3, 6, 4, 6, 4]
      g = f.galois_group
      # puts "Galois group of #{f} is"
      # g.each do |h|
      #   p h
      # end
      # puts
      assert_equal(gsize[i], g.size)
    end
  end
end
