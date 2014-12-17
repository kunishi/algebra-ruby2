########################################################################
#                                                                      #
#   finite-set.rb                                                      #
#                                                                      #
########################################################################
=begin
[((<index|URL:index.html>))] 
[((<finite-map|URL:finite-map.html>))] 
((<Algebra::Set>))
/
((<Enumerable>))

= Algebra::Set
((*Class of Set*))

This is the class of sets. The conclusion relationship is determined by
((|each|)) and ((<member?>)), that is, ((|s|)) is the subset of ((|t|))
if and only if
  s.all?{|x| t.member?(x)}
is true.

== File Name:
* ((|finite-set.rb|))

== SuperClass:
* ((|Object|))

== Included Module:

* ((|Enumerable|))

== Class Methods:

--- ::[]([obj0, [obj1, [obj2, ...]]])
    Creates ((|Set|)) objects from parameters.
    
    Example: Create {"a", [1, 2], 0}
      require "finite-set"
      p Algebra::Set[0, "a", [1, 2]]
      p Algebra::Set.new(0, "a", [1, 2])
      p Algebra::Set.new_a([0, "a", [1, 2]])
      p Algebra::Set.new_h({0=>true, "a"=>true, [1, 2]=>true})

--- ::new([obj0, [obj1, [obj2, ...]]])
    Creates ((|Set|)) objects from parameters.

--- ::new_a(a)
    Creates ((|Set|)) objects from an array ((|a|)).
    
--- ::new_h(h)
    Creates ((|Set|)) objects from a hash.

--- ::empty_set
    Returns the empty set.

--- ::phi
--- ::null
    Alias of ((<::empty_set>)).

--- ::singleton(x)
    Creates the set of one element ((|x|)).
    
== Methods:

--- empty_set
    Returns the empty set.

--- phi
--- null
    Alias of ((<::empty_set>)).

--- empty?
    Returns true if ((|self|)) is the empty set.

--- phi?
--- empty_set?
--- null?
    Alias of ((<empty?>))

--- singleton(x)
    Creates the set of one element ((|x|)).

--- singleton?
    Returns true if ((|self|)) is a singleton set.

--- size
    Returns the size of ((|self|)).

--- each
    Iterates the block with the block parameter of each element.
    The order of iteration is indefinite.

    Example: 
      require "finite-set"
      include Algebra
      Set[0, 1, 2].each do |x|
        p x #=> 1, 0, 2
      end

--- separate
    Returns the set of the elements which make the block true.

    Example: 
      require "finite-set"
      include Algebra
      p Set[0, 1, 2, 3].separate{|x| x % 2 == 0} #=> {2, 0}

--- select_s
--- find_all_s
    Alias of ((<separate>))

--- map_s
    Return the set of the values of the block.

    Example: 
      require "finite-set"
      include Algebra
      p Set[0, 1, 2, 3].map_s{|x| x % 2 + 1} #=> {2, 1}

--- pick
    Returns a elements of ((|self|)). The chois is indefinite.

--- shift
    Takes an element from ((<self>)) and returns it. 

    Example: 
      require "finite-set"
      include Algebra
      s = Set[0, 1, 2, 3]
      p s.shift #=> 2
      p s #=> {0, 1, 3}

--- dup
    Returns the duplication of ((|self|)).

--- append!(x)
    Appends ((|x|)) to ((|self|)) and returns ((|self|)).

--- push
--- <<
    Alias of ((|append!|)).

--- append(x)
    Duplicates and appends ((|x|)) to it and returns it.

--- concat(other)
    Adds the all elements of ((|other|)). This is the destructive
    version of ((<+>)).

--- rehash
    Rehashes the internal ((|Hash|)) object.

--- eql?(other)
    Returns true if ((|self|)) is equal to ((|other|)). This is
    equivalent to (({ self >= other and self <= other})).

--- ==
    Alias of eql?

--- hash
    Returns the hash value of ((|self|)).

--- include?(x)
    Returns true if ((|x|)) is a element of ((|self|)).

--- member?
--- has?
--- contains?
    Alias of ((<include>)).

--- superset?(other)n
    Returns true if ((|self|)) containds ((|other|)).
    This is equivalent to (({other.all{|x| member?(x)}})).

--- >=
--- incl?
    Alias of (({superset?})).

--- subset?(other)
    Returns true if ((|self|)) is a subset of ((|other|)).

--- <=
--- part_of?
    Alias of ((<subset?>)).

--- <(other)
    Returns true if ((|self|)) is a proper subset of ((|other|)).

--- >(other)
    Returns true if ((|other|)) is a proper subset of ((|self|)).

--- union(other = nil)
    Returns the union of ((|self|)) and ((|other|)).
    If ((|other|)) is omitted, returns the union of the
    ((|self|)) the set of sets.

    Example: 
      require "finite-set"
      include Algebra
      p Set[0, 2, 4].cup Set[1, 3] #=> {0, 1, 2, 3, 4}
      s = Set[*(0...15).to_a]
      s2 = s.separate{|x| x % 2 == 0}
      s3 = s.separate{|x| x % 3 == 0}
      s5 = s.separate{|x| x % 5 == 0}
      p Set[s2, s3, s5].union #=> {1, 7, 11, 13}

--- |
--- +
--- cup
    Alias of ((<union>)).

--- intersection(other = nil)
    Returns the intersection of ((|self|)) and ((|other|)).
    If ((|other|)) is omitted, returns the intersection of the
    ((|self|)) the set of sets.

    Example: 
      require "finite-set"
      include Algebra
      p Set[0, 2, 4].cap(Set[4, 2, 0]) #=> {0, 2, 4}
      s = Set[*(0..30).to_a]
      s2 = s.separate{|x| x % 2 == 0}
      s3 = s.separate{|x| x % 3 == 0}
      s5 = s.separate{|x| x % 5 == 0}
      p Set[s2, s3, s5].cap #=> {0, 30}

--- &
--- cap
    Alias of ((<intersection>)).

--- difference(other)
    Returns the set of the elements of ((|self|)) which are not in
    ((|other|)).

--- - 
    Alias of ((<difference>)).

--- each_pair
    Iterates with each two different elements of ((|self|)).

    Example: 
      require "finite-set"
      include Algebra
      s = Set.phi
      Set[0, 1, 2].each_pair do |x, y|
        s.push [x, y]
      end
      p s == Set[[0, 1], [0, 2], [1, 2]] #=> true

--- each_member(n)
    Iterates with each ((|n|)) different elements of ((|self|)).

    Example: 
      require "finite-set"
      include Algebra
      s = Set.phi
      Set[0, 1, 2].each_member(2) do |x, y|
        s.push [x, y]
      end
      p s == Set[[0, 1], [0, 2], [1, 2]] #=> true

--- each_subset
    Iterates over each subset of ((|self|)).

    Example: 
      require "finite-set"
      include Algebra
      s = Set.phi
      Set[0, 1, 2].each_subset do |t|
        s.append! t
      end
      p s.size = 2**3 #=> true

--- each_non_trivial_subset
    Iterates over each non trivial subset of ((|self|))

--- power_set
    Returns the set of subsets.


--- each_product(other)
    Iterates over for each ((|x|)) in ((|self|)) and
    each ((|y|)) in ((|other|))
    
    Exameple:
      require "finite-set"
      include Algebra
      Set[0, 1].each_prodct(Set[0, 1]) do |x, y|
        p [x, y] #=> [0,0], [0,1], [1,0], [1,1]
      end

--- product(other)
    Returns the product set of ((|self|)) and ((|other|)).
    The elements are the arrays of type (({[x, y]})).
    If the block is given, it returns the set which consists
    of the value of the block.

    Example: 
      require "finite-set"
      include Algebra
      p Set[0, 1].product(Set[0, 1]) #=> {[0,0], [0,1], [1,0], [1,1]}
      p Set[0, 1].product(Set[0, 1]){|x, y| x + 2*y} #=> {0, 1, 2, 3]

--- *
    Alias of ((<product>)).

--- equiv_class([equiv])
    Returns the quotient set by the equivalent relation.
    The relation are given as following:
    
    (1) The evaluation of the block:
          require "finite-set"
          include Algebra
          s = Set[0, 1, 2, 3, 4, 5]
          p s.equiv_class{|a, b| (a - b) % 3 == 0} #=> {{0, 3}, {1, 4}, {2, 5}}
    (2) The value of the instance method 
        ((|call(x, y)|)) of the parameter.
          require "finite-set"
          include Algebra
          o = Object.new
          def o.call(x, y)
            (x - y) % 3 == 0
          end
          s = Set[0, 1, 2, 3, 4, 5]
          p s.equiv_class(o) #=> {{0, 3}, {1, 4}, {2, 5}}
    (3) The value of method indicated ((|Symbol|)).
          require "finite-set"
          include Algebra
          s = Set[0, 1, 2, 3, 4, 5]
          def q(x, y)
            (x - y) % 3 == 0
          end
          p s.equiv_class(:q) #=> {{0, 3}, {1, 4}, {2, 5}}

--- /
    Alias of ((<equiv_class>)).

--- to_a
    Returns the array of elements. The order is indefinite.

--- to_ary
    Alias of ((<to_a>)).

--- sort
    Returns the value of (({to_a.sort})).

--- power(other)
    Returns the all maps from ((|other|)) to ((|self|)).
    The maps are the instances of ((<Map|URL:finite-map.html>)).

    Example: 
      require "finite-map"
      include Algebra
      a = Set[0, 1, 2, 3]
      b = Set[0, 1, 2]
      s = 
      p( (a ** b).size )      #=> 4 ** 3 = 64
      p b.surjections(a).size #=> S(3, 4) = 36
      p a.injections(b).size  #=> 4P3 = 24

--- ** power
    Alias of ((<power>)).

--- identity_map
    Returns the identity map of ((|self|)).

--- surjections(other)
    Returns all surjections from ((|other|)) to((|self|)).

--- injections(other)
    Returns all injections from ((|other|)) to((|self|)).

--- bijections(other)
    Returns all bijections from ((|other|)) to((|self|)).

#--- monotonic_series #what is this?
#
#    Example: 

= Enumerable

== File Name:
* ((|finite-set.rb|))

== Methods:

--- any?
    Returns true when the block is true for some elements.
    This is the alias of ((|Enumerable#find|))
    (built-in method of ruby-1.8).

--- all?
    Returns true when the block is true for all elements.
    This is defined by:

      !any?{|x| !yield(x)}

    (These are built-in methods of ruby-1.8).

=end

