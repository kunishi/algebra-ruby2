=begin
[((<index|URL:index.html>))] 
= Algebra::ResidueClassRing
((*(Class of Residue Class Ring)*))

This class represents a residue class ring. To create concrete class,
use the class method ((<::create>)) or 
the function ((<Algebra.ResidueClassRing>))()
designating the base ring and the element of it.

== File Name:
* ((|residue-class-ring.rb|))

== SuperClass:

* ((|Object|))

== Included Modules:

none.

== Associated Functions:

--- Algebra.ResidueClassRing(ring, mod)
    Same as ((<::create(ring, mod)>)).

== Class Methods:

--- ::create(ring, mod)
    Returns the class of the residue class ring of the 
    ((|ring|)) and the modulus ((|mod|)).
    
    This class is a subclass of ((<ResidueClassRing>)) and
    has the class methods ((|::ground|)), ((|::modulus|)) and (({ [x] }))
    , which return the fundamental ring ((|ring|)), the modulus 
    ((|mod|)) and the representing residue class of ((|x|)), respectively.

    Example: divide the polynomial ring by the modulus (({x**2 + x + 1})).
      require "rational"
      require "polynomial"
      require "residue-class-ring"
      Px = Algebra.Polynomial(Rational, "x")
      x = Px.var
      F = ResidueClassRing(Px, x**2 + x + 1)
      p F[x + 1]**100     #=> -x - 1

    When ((|ring|)) is ((|Integer|)), all inverse elements are calculated
    in advance. And we can obtain the residue classes of 
    (({0, 1, ... , mod-1})) by ((|to_ary|)).
    
    Example: the prime field of modulo 7
      require "residue-class-ring"
      F7 = Algebra::ResidueClassRing.create(Integer, 7)
      a, b, c, d, e, f, g = F7
      p [e + c, e - c, e * c, e * 2001, 3 + c, 1/c, 1/c * c]
        #=> [6, 2, 1, 3, 5, 4, 1]
      p( (1...7).collect{|i| F7[i]**6} )
        #=> [1, 1, 1, 1, 1, 1]

--- ::[](x)
    Returns the residue class represented bye ((|x|)).
    
#--- ::indeterminate(obj)

--- ::zero
    Returns zero.
    
--- ::unity
    Returns unity.

== Methods:

--- lift
    Returns the representative of ((|self|)).

#--- monomial?

--- zero?
    Returns true if ((|self|)) is zero.

--- zero
    Returns zero.
    
--- unity
    Returns unity.

--- ==(other)
    Returns true if ((|self|)) equals ((|other|)).

--- +(other)
    Returns the sum of ((|self|)) and ((|other|)).

--- -(other)
    Returns the difference of ((|self|)) from ((|other|)).

--- *(other)
    Returns the product of ((|self|)) and ((|other|)).

--- **(n)
    Returns the ((|n|))-th power of ((|self|)).

--- /(other)
    Returns the quotient of ((|self|)) by ((|other|)) using ((<inverse>)).

--- inverse
    Returns the inverse element, assuming the fundamental ring
    is Euclidian. When it does not exist, this returns nil.

#--- to_s

=end


