########################################################################
#                                                                      #
#   finite-map.rb                                                      #
#                                                                      #
########################################################################
=begin
[((<index|URL:index.html>))] 
[((<finite-set|URL:finite-set.html>))] 
((<Algebra::Map>))

= Algebra::Map
((*Map Class*))

The class which represents maps.

== File Name:
* ((|finite-map.rb|))

== SuperClass:
* ((|Set|))

== Included Module:

* ((|Powers|))

== Class Methods:

--- ::[]([x0 => y0, [x1 => y1, [x2 => y2, ...]]])
    Returns the map which has values ((|y0|)) at ((|x0|)),
    ((|y1|)) at ((|x1|)),  ((|y2|)) at ((|x2|))...
    
    Exampel: 
      require "finite-map"
      include Algebra
      p Map[0 => 10, 1 => 11, 2 => 12]         #=> {0 => 10, 1 => 11, 2 => 12}
      p Map[{0 => 10, 1 => 11, 2 => 12}]       #=> {0 => 10, 1 => 11, 2 => 12}
      p Map.new(0 => 10, 1 => 11, 2 => 12)     #=> {0 => 10, 1 => 11, 2 => 12}
      p Map.new({0 => 10, 1 => 11, 2 => 12})   #=> {0 => 10, 1 => 11, 2 => 12}
      p Map.new_a([0, 10, 1, 11, 2, 12])       #=> {0 => 10, 1 => 11, 2 => 12}

--- ::new([x0 => y0, [x1 => y1, [x2 => y2, ...]]])
    Returns the map which has values ((|y0|)) at ((|x0|)),
    ((|y1|)) at ((|x1|)),  ((|y2|)) at ((|x2|))... This is the same
    as ((<::[]>)).

--- ::new_a(a)
    Returns the map defined so that the even-th elements are in domain and
    the odd-th elements are their image.

--- ::phi([t])
    Return the empty map (having empty set as domain).
    If ((|t|)) is given, ((<target=>)) is set by ((|t|)).

    Exampel: 
      p Map.phi #=> {}
      p Map.phi(Set[0, 1]) #=> {}
      p Map.phi(Set[0, 1]).target #=> {0, 1}

--- ::empty_set
    Alias of ((<::phi>)).

--- ::singleton(x, y)
    Returns the map defined over singleton (({{x}})) and having value ((|y|))
    on it.

== Methods:

--- target=(s)
    Sets the codomain ((|s|)). This is used for ((<surjective?>)) and so on.

--- codomain=(s)
    Alias of ((<target=>)).

--- target
    Returns the codomain of ((|self|))

--- codomain
    Alias of ((<target>)).

--- source
    Returns the domain of ((|self|)).

    Example: 
      require "finite-map"
      include Algebra
      m = Map[0 => 10, 1 => 11, 2 => 12]
      p m.source #=> {0, 1, 2}
      p m.target #=> nil
      m.target = Set[10, 11, 12, 13]
      p m.target #=> {10, 11, 12, 13}

--- domain
    Alias of ((<source>)).

--- phi([t])
    Returns the empty map. If ((|t|)) given, ((<target=>)) t is done.

--- empty_set
--- null
    Alias of ((<phi>)).

--- call(x)
    Return the value of ((|x|)).

--- act
--- []
    Alias of ((<call>)).

--- each
    Iterates for each (({[point, image]})) of the map.

    Example: 
      require "finite-map"
      include Algebra
      Map[0 => 10, 1 => 11, 2 => 12].each do |x, y|
        p [x, y] #=> [1, 11], [0, 10], [2, 12]
      end

--- compose(other)
    Returns the composition map of ((|self|)) and ((|other|)).

    Example: 
      require "finite-map"
      include Algebra
      f = Map.new(0 => 10, 1 => 11, 2 => 12)
      g = Map.new(10 => 20, 11 => 21, 12 => 22)
      p g * f #=> {0 => 20, 1 => 21, 2 => 22}

--- *
    Alias of ((<compose>)).

--- dup
    Duplicates ((|self|)). ((<target>)) is also duplicated if it is set.

--- append!(x, y)
    Let the value of ((|x|)) be ((|y|)).

    Example: 
      require "finite-map"
      include Algebra
      m = Map[0 => 10, 1 => 11]
      m.append!(2, 12)
      p m #=> {0 => 10, 1 => 11, 2 => 12}

--- []=(x, y)
    Alias of ((<append!>)).

--- append(x, y)
    ((<dup>)) and ((<append!>))(x, y).

--- include?(x)
    Returns true if ((|x|)) is in the domain.

--- contains?(x)
    Alias of ((<include?>)).

--- member?(a)
    Returns true if there is (({[x, y]})) s.t. the value of ((|x|))
    is ((|y|)) and (({[x, y] == a})).

    Example: 
      require "finite-map"
      include Algebra
      m = Map[0 => 10, 1 => 11]
      p m.include?(1)  #=> true
      p m.member?([1, 11]) #=> true

--- has?
    Alias of member?

--- image([s])
    Returns the image of ((|self|)). If ((|s|)) is indicated, returns
    the image of ((|s|)) by ((|self|)).

--- inv_image(s)
    Return the inverse image of ((|s|)) by ((|self|)).

--- map_s
    Returns the set given by evaluation of the block, iterating over each pair
    of (({[point, image]})).

    Example: 
      require "finite-map"
      include Algebra
      p Map.new(0 => 10, 1 => 11, 2 => 12).map_s{|x, y| y - 2*x}
      #=> Set[10, 9, 8]

--- map_m
    Returns the map given by evaluation of the block, iterating over each pair
    of (({[point, image]})). The value of the block must be
    the two-dimensional array (({[x, y]})).

    Example: 
      require "finite-map"
      include Algebra
      p Map.new(0 => 10, 1 => 11, 2 => 12).map_m{|x, y| [y, x]}
      #=> {10 => 0, 11 => 1, 12 => 2}

--- inverse
    Returns the inverse map of ((|self|)).

--- inv_coset
    Reterns the map corresponding each point to its set of inverse images.

    Examepe: 
      require "finite-map"
      include Algebra
      m = Map[0=>0, 1=>0, 2=>2, 3=>2, 4=>0]
      p m.inv_coset #=> {0=>{0, 1, 4}, 2=>{2, 3}}
      m.codomain = Set[0, 1, 2, 3]
      p m.inv_coset #=> {0=>{0, 1, 4}, 1=>{}, 2=>{2, 3}, 3=>{}}

--- identity?
    Returns true if ((|self|)) is the identity map.

--- surjective?
    Returns true if ((|self|)) is surjective.
    ((<target>)) should be set before using this.

--- injective?
    Returns true if ((|self|)) is injective.

--- bijective?
    Returns true if ((|self|)) is bijective. 
    ((<target>)) should be set before using this.

=end
