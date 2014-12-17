########################################################################
#                                                                      #
#   lib/permutation-group.rb                                           #
#                                                                      #
########################################################################
=begin
[((<index|URL:index.html>))] 
((<Algebra::PermutationGroup>))
/
((<Algebra::Permutation>))

= Algebra::PermutationGroup
This is the class of permutations.
The elements are assumed to be the instances of ((<Permutation>)).

== File Name:
* ((|permutation-group.rb|))

== SuperClass:
* ((|Group|))

== Class Methods:

--- ::new(u, [g0, [g1, ...]])
    Returns the group with unit ((|u|)), whcih
    consists of ((|g0|)), ((|g1|)), ....

--- ::unit_group(d)
    Return the unit group of degree ((|d|)).

--- ::unity(n)
    Retunrs the unity of degree ((|n|)).

--- ::perm(a)
    Returns the permuation represented by the array ((|a|)).

--- ::symmetric(n)
    Returns the simmetric group of degree ((|n|))

--- ::alternate(n)
    Returns the alternative group of dgree ((|n|)).

= Algebra::Permutation

== File Name:
* ((|permutation-group.rb|))

== SuperClass:
* ((|Object|))

== Included Module:

* ((|Enumerable|))
* ((|Powers|))

== Class Methods:

--- ::new(x)
    Returns the permutaiont represented by the array ((|x|)).

--- ::[]([n0, [n1, [n2, ..., ]]])
    Returns the permutation (({[n0, n1, n2, ..., ]})).

    Example:
      a = Permutation[1, 2, 0]
      p a**2 #=> [2, 0, 1]
      p a**3 #=> [0, 1, 2]

--- ::unity(d)
    Returns the unity of degree ((|d|)).

--- ::cyclic2perm(c, n)
    Returns the ((<Permutation>)) represented by
    ((|c|)) : the array of arrays of cyclic permutations,
    where ((|n|)) is the degree. This method is the inverse of
    ((<decompose_cyclic>)).

    Example:
      Permutation.cyclic2perm([[1,6,5,4], [2,3]], 7) #=> [0, 6, 3, 2, 1, 4, 5]
      Permutation[0, 6, 3, 2, 1, 4, 5].decompose_cyclic #=> [[1,6,5,4], [2,3]]

== Methods:

--- unity
    Returns the unity.

--- perm
    Returns the array which represents ((|self|))

--- degree
    Returns the degree

--- size
    Alias of ((<degree>)).

--- each
    Iterates for each entry.

--- eql?(other)
    Returns true if ((|self|)) is equal to ((|other|)).

--- ==
    Alias of ((|eql?|)).

--- hash
    Returns the hash number.

--- [](i)
    Returns the number to which ((|i|)) is transferrd.

--- call
    Alias of ((<[]>)).

--- index(i)
    Returns the number from which ((|i|)) is transferred.

--- right_act(other)
    Returns the value multiplying ((|other|)) from right.
    It follows (({(g.right_act(h))[x] == h[g[x]]})).

--- *
    Alias of ((<right_act>))

--- left_act(other)
    Returns the value multiplying ((|other|)) from left.
    It follows (({(g.left_act(h))[x] == g[h[x]]})).

--- inverse
    Returns the inverse element.

--- inv
    Alias of ((|inverse|)).

--- sign
    Returns the sign of ((|self|)).

--- conjugate(g)
    Returns the conjugate by ((|g|)): (({g * self * g.inv})).

--- decompose_cyclic
    Returns the array of arrays of cyclic permutations.
    This is the inverse of ((<::cyclic2perm(c, n)>)).

--- to_map
    Returns the ((<Map|URL:finite-map.html>)) object of ((|self|)).

--- decompose_transposition
    Decompose into the array of the transpositions.

=end

