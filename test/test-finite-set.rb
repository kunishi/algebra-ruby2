########################################################################
#                                                                      #
#   Test Script for finite-set.rb                                      #
#                                                                      #
########################################################################

require "rubyunit"
require "algebra/finite-set.rb"
include Algebra
=begin
    o = Object.new
    def o.call(x, y)
      (x - y) % 3 == 0
    end
    s = Set[0, 1, 2, 3, 4, 5]
    c = s.equiv_class(o)
    p c == Set[Set[0, 3], Set[1, 4], Set[2, 5]]
exit
#p Set[Set[0,3],Set[5,2],Set[1,4]] == Set[Set[1,4],Set[5,2],Set[0,3]]
#exit
=end
class Rational;def inspect; to_s; end;end

class TestFiniteSet < Runit
  include Algebra

  def test_initialize #test for initialize
    s = Set.new(0, "a", [1, 2])
    assert(s.is_a?(Set))
  end

  def test_new_a #test for self.new_a
    s = Set.new_a([0, "a", [1, 2]])
    t = Set[0, "a", [1, 2]]
    assert_equal(s, t)
  end

  def test_new_h #test for self.new_h
    s = Set.new_h({0=>true, "a"=>true, [1, 2]=>true})
    t = Set[0, "a", [1, 2]]
    assert_equal(s, t)
  end

  def test_self_dot_empty_set #test for self.empty_set
    assert_equal(Set.empty_set.size, 0)
  end

  def test_self_dot_phi #test for self.phi
    assert_equal(Set.phi.size, 0)
  end

  def test_self_dot__bra #test for self.[]
    s = Set[0, "a", [1, 2]]
    assert_equal(s.size, 3)
  end

  def test_self_dot_singleton
    assert_equal(Set.singleton(0), Set[0])
  end

  def test_shift
    s = Set[0, 1, 2]
    t = s.dup
    x = t.shift
    assert(s.has?(x))
    assert(s > t)
  end

  def test_shift
    s = Set[0, 1, 2]
    t = s.dup
    x = t.pick
    assert(s.has?(x))
    assert(s == t)
  end

  def test_phi
    assert_equal(Set[1].phi, Set[])
  end

  def test_empty_set
    assert_equal(Set[1].phi, Set[])
  end

  def test_singleton
    assert_equal(Set[1].singleton(0), Set[0])
  end

  def test_singleton?
    assert(Set[0].singleton?)
    assert(!Set[].singleton?)
    assert(!Set[0, 1].singleton?)
  end

  def test_empty? #test for empty?
    assert(Set.phi.empty?)
  end

  def test_each #test for each
    Set[0, "a", [1, 2]].each do |x|
      assert([0, "a", [1, 2]].include?(x))
    end
  end

  def test_separate
    s = Set[0, 1, 2, 3, 4, 5]
    t = s.separate{|x| x % 3 == 0}
    assert(t.class, Set[0, 3])
  end

  def test_map_s
    s = Set[0, 1, 2]
    t = s.separate{|x| x ** 2}
    assert(t.class, Set[0, 1, 4])
  end

  def test_dup #test for dup
    a = Set[[0], [1], [2]]
    b = a.dup
    b.each do |x|
      x.push x[0]
    end
    assert(a.id != b.id)
    a.each do |x|
      assert_equal(x.size, 2)
    end
  end

  def test_push #test for push
    s = Set[0, 1, 3]
    s.push 2
    assert_equal(s.size, 4)
    s.push 3
    assert_equal(s.size, 4)
  end


  def test_concat
    s = Set[0, 1, 3]
    s.concat Set[1, 2]
    assert_equal(s, Set[0, 1, 2, 3])
  end

  def test_rehash #test for rehash
    s = Set[[0], [1], [2]]
    s.each do |x|
      x[0] += 10
    end
    assert(s != Set[[10], [11], [12]])
    s.rehash
    assert(s == Set[[10], [11], [12]])
  end

  def test__equal #test for ==
    assert(Set[0, 3, "a"] == Set[3, "a", 0])
    assert(Set[0, 3, "a", 2] != Set[3, "a", 0])
    assert(Set[0, 3, "a"] != Set[3, "a", 0, 2])
  end

  def test_include? #test for include?
    assert(Set[0, 3, "a"].include?(0))
    assert(!Set[0, 3, "a"].include?(1))
  end

  def test_has? #test for has?
    assert(Set[0, 3, "a"].has?(0))
    assert(!Set[0, 3, "a"].has?(1))
  end

  def test_incl? #test for incl?
    assert(Set[0, 3, "a"].incl?(Set[0, 3]))
    assert(Set[0, 3, "a"].incl?(Set["a", 0, 3]))
    assert(! (Set[0, 3, "a"].incl?(Set["a", 0, 1])))
  end

  def test_isin? #test for isin?
    assert(Set[0, 3].part_of?(Set[0, 3, "a"]))
    assert(Set[0, 3, "a"].part_of?(Set["a", 0, 3]))
    assert(! (Set[0, 3, "a"].part_of?(Set["a", 0, 1])))
  end

  def test_ge? #test for incl?
    assert(Set[0, 3, "a"] >= Set[0, 3])
    assert(Set[0, 3, "a"] >= Set["a", 0, 3])
    assert(! (Set[0, 3, "a"] >= Set["a", 0, 1]))
  end

  def test_le? #test for isin?
    assert(Set[0, 3] <= Set[0, 3, "a"])
    assert(Set[0, 3, "a"] <= Set["a", 0, 3])
    assert(! (Set[0, 3, "a"] <= Set["a", 0, 1]))
  end

  def test__gt? #test for incl?
    assert(Set[0, 3, "a"] > Set[0, 3])
    assert(! (Set[0, 3, "a"] > Set["a", 0, 3]))
    assert(! (Set[0, 3, "a"] > Set["a", 0, 1]))
  end

  def test__lt? #test for isin?
    assert(Set[0, 3] < Set[0, 3, "a"])
    assert(! (Set[0, 3, "a"] < Set["a", 0, 3]))
    assert(! (Set[0, 3, "a"] < Set["a", 0, 1]))
  end

  def test__plus #test for +
    s = Set[0, 2, 4] + Set[1, 3]
    assert_equal(s, Set[0, 1, 2, 3, 4])
  end

  def test__stroke #test for |
    s = Set[0, 2, 4] | Set[1, 3]
    assert_equal(s, Set[0, 1, 2, 3, 4])
  end

  def test_cup #test for cup
    s = Set[0, 2, 4].cup Set[1, 3]
    assert_equal(s, Set[0, 1, 2, 3, 4])

    s = Set[*(0...15).to_a]
    s2 = s.separate{|x| x % 2 == 0}
    s3 = s.separate{|x| x % 3 == 0}
    s5 = s.separate{|x| x % 5 == 0}
    assert_equal(Set[s2, s3, s5].union, s - Set[1, 7, 11, 13])
  end

  def test__minus #test for -
    assert_equal(Set[0, 2, 4] - Set[4, 2, 0], Set.phi)
    assert_equal(Set[0, 2, 4] - Set[1, 3], Set[0, 2, 4])
    assert_equal(Set[0, 1, 2, 4] - Set[1, 3], Set[0, 2, 4])
    assert_equal(Set[0, 1, 2, 3] - Set[1, 3], Set[0, 2])
  end

  def test__amp #test for &
    assert_equal(Set[0, 2, 4] & Set[4, 2, 0], Set[0, 2, 4])
    assert_equal(Set[0, 2, 4] & Set[1, 3], Set.phi)
    assert_equal(Set[0, 1, 2, 4] & Set[1, 3], Set[1])
    assert_equal(Set[0, 1, 2, 3] & Set[1, 3], Set[1, 3])
  end

  def test_cap #test for cap
    assert_equal(Set[0, 2, 4].cap(Set[4, 2, 0]), Set[0, 2, 4])
    assert_equal(Set[0, 2, 4] .cap(Set[1, 3]), Set.phi)
    assert_equal(Set[0, 1, 2, 4] .cap(Set[1, 3]), Set[1])
    assert_equal(Set[0, 1, 2, 3] .cap(Set[1, 3]), Set[1, 3])

    s = Set[*(0..30).to_a]
    s2 = s.separate{|x| x % 2 == 0}
    s3 = s.separate{|x| x % 3 == 0}
    s5 = s.separate{|x| x % 5 == 0}
    assert_equal(Set[s2, s3, s5].cap, Set[0, 30])
  end

  def test_each_pair #test for each_pair
    s = Set.phi
    Set[0, 1, 2].each_pair do |x, y|
      s.push [x, y]
    end
    assert_equal(s, Set[[0, 1], [0, 2], [1, 2]])
  end
  
  def test_each_member #test for each_member
    s = Set.phi
    Set[0, 1, 2].each_member(1) do |a|
      s.push Set[*a]
    end
    assert_equal(s, Set[Set[0], Set[1], Set[2]])

    s = Set.phi
    Set[0, 1, 2].each_member(2) do |a|
      s.push Set[*a]
    end
    assert_equal(s, Set[Set[0, 1], Set[0, 2], Set[1, 2]])

    s = Set.phi
    Set[0, 1, 2].each_member(3) do |a|
      s.push Set[*a]
    end
    assert_equal(s, Set[Set[0, 1, 2]])
  end

  def test_subset? #test for subset?
    assert(Set[0, 1, 2].subset?(Set[0, 1, 2]))
    assert(Set[0, 1].subset?(Set[0, 1, 2]))
    assert(! Set[0, 1].subset?(Set[0, 3, 2]))
  end

  def test_each_subset #test for each_subset
    s = Set.phi
    Set.phi.each_subset do |t|
      s.append! t
    end
    assert_equal(s.size, 2**0)
    assert_equal(s, Set[Set.phi])

    s = Set.phi
    Set[0].each_subset do |t|
      s.append! t
    end
    assert_equal(s.size, 2**1)
    assert_equal(s, Set[Set[],Set[0]])

    s = Set.phi
    Set[0, 1].each_subset do |t|
      s.append! t
    end
    assert_equal(s.size, 2**2)
    assert_equal(s, Set[Set[], Set[1], Set[0], Set[1,0]])

    s = Set.phi
    Set[0, 1, 2].each_subset do |t|
      s.append! t
    end
    assert_equal(s.size, 2**3)
    assert_equal(s, Set[Set[],Set[1],Set[2],Set[0],
		   Set[1,2],Set[0,2],Set[0,1],Set[0,1,2]])

  end

  def test_each_non_trivial_subset #test for each_non_trivial_subset
    s = Set.phi
    Set.phi.each_non_trivial_subset do |t|
      s.append! t
    end
    assert_equal(s.size, 2**0-1)
    assert_equal(s, Set[])

    s = Set.phi
    Set[0].each_non_trivial_subset do |t|
      s.append! t
    end
    assert_equal(s.size, 2**1-2)
    assert_equal(s, Set[])

    s = Set.phi
    Set[0, 1].each_non_trivial_subset do |t|
      s.append! t
    end
    assert_equal(s.size, 2**2-2)
    assert_equal(s, Set[Set[1], Set[0]])

    s = Set.phi
    Set[0, 1, 2].each_non_trivial_subset do |t|
      s.append! t
    end
    assert_equal(s.size, 2**3-2)
    assert_equal(s, Set[Set[1],Set[2],Set[0],
		   Set[1,2],Set[0,2],Set[0,1],])

  end

  def test_power_set #test for power_set
    assert_equal(Set.phi.power_set, Set[Set.phi])
    assert_equal(Set[0].power_set, Set[Set[],Set[0]])
    assert_equal(Set[0, 1].power_set, Set[Set[], Set[1], Set[0], Set[1,0]])
    assert_equal(Set[0, 1, 2].power_set, Set[Set[],Set[1],Set[2],Set[0],
		   Set[1,2],Set[0,2],Set[0,1],Set[0,1,2]])
    s = Set[true,false].power_set
    assert_equal(s, Set[Set.phi, Set[true], Set[false], Set[true,false]])
    assert(s != Set[Set.phi, Set[true]])
  end

  def test_each_product
    s = Set.phi
    Set[0, 1].each_product(Set[0, 1]) do |x, y|
      s.push [x, y]
    end
    assert_equal(s, Set[[0,0], [0,1], [1,0], [1,1]])
  end

  def test_product #test for product
    assert_equal(Set[0, 1].product(Set[0, 1]){ |x, y|
		   [x, y*2]
		 }, Set[[0,0], [0,2], [1,0], [1,2]])
  end

  def test__star #test for *
    assert_equal(Set.phi * Set.phi, Set.phi)
    assert_equal(Set.phi * Set[0], Set.phi)
    assert_equal(Set[0] * Set[0], Set[[0,0]])
    assert_equal(Set[0] * Set[0, 1], Set[[0,0], [0, 1]])
    assert_equal(Set[0, 1] * Set[0, 1], Set[[0,0], [0,1], [1,0], [1,1]])
  end

  def test_equiv_class #test for equiv_class
    o = Object.new
    def o.call(x, y)
      (x - y) % 3 == 0
    end
    s = Set[0, 1, 2, 3, 4, 5]
    c = s.equiv_class(o)
    assert_equal(c, Set[Set[0, 3], Set[1, 4], Set[2, 5]])

    s = Set[0, 1, 2, 3, 4, 5]
    def s.q(x, y)
      (x - y) % 3 == 0
    end
    c = s.equiv_class(:q)
    assert_equal(c, Set[Set[0, 3], Set[1, 4], Set[2, 5]])

    s = Set[0, 1, 2, 3, 4, 5]
    c = s.equiv_class{|a, b| (a - b) % 3 == 0}
    assert_equal(c, Set[Set[0, 3], Set[1, 4], Set[2, 5]])
  end

  def test__slash #test for equiv_class
    o = Object.new
    def o.call(x, y)
      (x - y) % 3 == 0
    end
    s = Set[0, 1, 2, 3, 4, 5]
    c = s / o
    assert_equal(c, Set[Set[0, 3], Set[1, 4], Set[2, 5]])

    s = Set[0, 1, 2, 3, 4, 5]
    def s.q(x, y)
      (x - y) % 3 == 0
    end
    c = s / :q
    assert_equal(c, Set[Set[0, 3], Set[1, 4], Set[2, 5]])
  end

  def test_to_a #test for to_a
    assert_equal(Set[0, 1, 2].to_a, [0, 1, 2])
  end

  def test_to_ary #test for to_ary
    a, b, c  = Set[0, 1, 2]
    assert(a == 0 && b == 1 && c == 2)
  end

  require "algebra/finite-map"

  def test_power #test for power
    a = Set[0, 1, 2]
    b = Set[0, 1, 2]
    s = a ** b
    assert_equal(s.size, a.size**b.size)

    a = Set[]
    b = Set[0, 1, 2]
    s = a ** b
    assert_equal(s.size, a.size**b.size)

    a = Set[0, 1, 2]
    b = Set[]
    s = a ** b
    assert_equal(s.size, a.size**b.size)
  end

  def test_identity_map
    a = Set[0, 1, 2]
    b = Map[0=>0, 1=>1, 2=>2]
    assert_equal(a.identity_map, b)
  end

  def test_surjections #test for surjections
    a = Set[0, 1, 2]
    b = Set[0, 1, 2]
    s = a.surjections(b)
    assert_equal(s.size, 3*2)
  end

  def test_injections0 #test for injections0
    a = Set[0, 1, 2, 3]
    b = Set[0, 1, 2]
    s = a.injections0(b)
    assert_equal(s.size, 24)
  end

  def test_injections #test for injections
    a = Set[0, 1, 2, 3]
    b = Set[0, 1, 2]
    s = a.injections(b)
    assert_equal(s.size, 24)
  end

  def test_bijections #test for bijections
    assert_equal(Set[0, 1, 2].bijections(Set[0, 1, 2]).size, 6)
    assert_equal(Set[0, 1, 2].bijections(Set[0, 1, 2, 3]).size, 0)
    assert_equal(Set[0, 1, 2, 3].bijections(Set[0, 1, 2]).size, 0)
  end

#  def test_monotonic_series #test for monotonic_series
#    assert_equal(0, 0)
#    assert(true)
#  end
end
Tests(TestFiniteSet)
