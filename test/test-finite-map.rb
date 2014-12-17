########################################################################
#                                                                      #
#   Test Script for finite-map.rb                                      #
#                                                                      #
########################################################################
require "rubyunit"
require "algebra/finite-map.rb"
include Algebra

class Rational;def inspect; to_s; end;end

class TestFiniteMap < Runit
  def test_initialize #test for initialize
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    t = Map.new({0 => 10, 1 => 11, 2 => 12})
    assert(s.is_a?(Map))
    assert_equal(s, t)
  end

  def test_new_a #test for self.new_a
    t = Map.new_a([0, 10, 1, 11, 2, 12])
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    assert_equal(s, t)
  end
  
  def test_new_h #test for self.new_h
    s0 = Map.new(0 => 10, 1 => 11, 2 => 12)
    s = Map.new_h({0 => 10, 1 => 11, 2 => 12})
    t = Map.new_h(0 => 10, 1 => 11, 2 => 12)
    
    assert_equal(s0, s)
    assert_equal(s, t)
  end
  
  def test_self_dot__bra #test for self.[]
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    t = Map[0 => 10, 1 => 11, 2 => 12]
    u = Map[{0 => 10, 1 => 11, 2 => 12}]
    assert_equal(s, t)
    assert_equal(s, u)
  end
  
  def test_self_dot_empty_set #test for self.empty_set
    assert_equal(Map.empty_set.size, 0)
    assert_equal(Map.empty_set(Set[0, 1]).target, Set[0, 1])
  end
  
  def test_self_dot_phi #test for self.phi
    assert_equal(Map.phi.size, 0)
    assert_equal(Map.phi(Set[0, 1]).target, Set[0, 1])
  end
  
  def test_self_dot_singleton #test for self.single
    assert_equal(Map.singleton(0, 1).size, 1)
  end

  def test_each #test for each
    h = {0 => 10, 1 => 11, 2 => 12}
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    
    assert_equal(s.size, h.size)
    s.each do |x,  y|
      assert_equal(x + 10, y)
    end
  end

  def test_dup #test for dup
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    t = s.dup
    assert_equal(s.size, t.size)
    
    t.each do |x, y|
      t[x] = y + 10
    end
    s.each do |x,  y|
      assert_equal(x + 10, y)
    end

    t.each do |x,  y|
      assert_equal(x + 20, y)
    end
  end

  def test_call #test for call
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    s.each do |x,  y|
      assert_equal(s.call(x), y)
    end
  end

  def test_append! #test for append!
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    s.append!(3, 13)
    i = 0
    s.each do |x,  y|
      i += 1
      assert_equal(x + 10, y)
    end
    assert_equal(i, 4)
  end

  def test__bra= #test for []=
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    s[3] = 13
    i = 0
    s.each do |x,  y|
      i += 1
      assert_equal(x + 10, y)
    end
    assert_equal(i, 4)
  end

  def test_append #test for append
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    t = s.append(3, 13)
    i = 0
    t.each do |x,  y|
      i += 1
      assert_equal(x + 10, y)
    end
    assert_equal(i, 4)
    i = 0
    s.each do |x,  y|
      i += 1
      assert_equal(x + 10, y)
    end
    assert_equal(i, 3)
  end

  def test_hash #test for hash
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    assert(Set[s].has?(s))
    assert(!Set[s].has?(Map.new(0 => 11, 1 => 11, 2 => 12)))
  end

  def test_include? #test for has?
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    assert(s.include?(0))
    assert(!(s.include?([0, 10])))
  end

  def test_has? #test for has?
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    assert(s.has?([0, 10]))
    assert(!(s.has?([0, 11])))
  end

  def test_domain #test for domain
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    assert_equal(s.domain, Set[0, 1, 2])
  end

  def test_image #test for image
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    assert_equal(s.image, Set[10, 11, 12])
    assert_equal(s.image(Set[0, 2]), Set[10, 12])
  end

  def test_map_s
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    t = s.map_s{|x, y| y - 2*x}
    assert_equal(t, Set[10, 9, 8])
  end

  def test_map_m
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    t = s.map_m{|x, y| [x**2, y**2]}
    assert_equal(t, Map[0 => 100, 1 => 121, 4 => 144])
  end

  def test_inverse #test for inverse
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    t = Map.phi
    s.each do |x, y|
      t.append!(y, x)
    end
    assert_equal(s.inverse, t)
  end

  def test_coset
    m = Map[0=>0, 1=>0, 2=>2, 3=>2, 4=>0]
    assert_equal(m.inv_coset, Map[0=>Set[0,1,4],2=>Set[2,3]])
    m.codomain = Set[0, 1, 2, 3]
    assert_equal(m.inv_coset, Map[0=>Set[0,1,4],2=>Set[2,3],1=>Set[],3=>Set[]])
  end

  def test__star #test for *
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    t = Map.new(10 => 20, 11 => 21, 12 => 22)
    v = Set.new(20, 21, 22, 23)
    t.target = v
    u = Map.new(0 => 20, 1 => 21, 2 => 22)
    h = t*s
    assert_equal(h, u)
    assert_equal(h.target, v)
  end

  def test_surjective? #test for surjective?
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    s.target = Set[10, 11, 12]
    assert(s.surjective?)

    s = Map.new(0 => 10, 1 => 11, 2 => 10)
    s.target = Set[10, 11, 12]
    assert(!s.surjective?)
  end

  def test_identity?
    assert(Map[1=>1, 0=>0, 2=>2].identity?)
    assert(!Map[1=>0, 0=>0, 2=>2].identity?)
  end

  def test_injective? #test for injective?
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    assert(s.injective?)

    s = Map.new(0 => 10, 1 => 11, 2 => 10)
    assert(!s.injective?)
  end

  def test_bijective? #test for bijective?
    s = Map.new(0 => 10, 1 => 11, 2 => 12)
    s.target = Set[10, 11, 12]
    assert(s.bijective?)

    s = Map.new(0 => 10, 1 => 11, 2 => 10)
    s.target = Set[10, 11, 12]
    assert(! s.bijective?)
  end

  def test_inv_image #test for inv_image
    s = Map.new(0 => 10, 1 => 11, 2 => 10, 3 => 11)

    assert_equal(s.inv_image(Set[10]), Set[0, 2])
    assert_equal(s.inv_image(Set[]), Set[])
  end
end

Tests(TestFiniteMap)
