=begin
[((<index|URL:index.html>))] 
= Algebra::LocalizedRing
((*(Class of Localization of Ring)*))

This class creates the fraction ring of the given ring.
To make a concrete class, use the class method
((<::create>)) or the function ((<Algebra.LocalizedRing>))().

== File Name:
* ((|localized-ring.rb|))

== SuperClass:

* ((|Object|))

== Included Ring
none.

== Associated Functions:

--- Algebra.LocalizedRing(ring)
    Same as ((<::create>))(ring).

--- Algebra.RationalFunctionField(ring, obj)
    Creates the rational function field over ((|ring|)) with
    the variable expressed by ((|obj|)). This class is equipped with
    the class method ((|::var|)) which returns the variable.
    
    Example: the quotient field over the polynomial ring over Rational
      require "algebra/localized-ring"
      require "rational"
      F = Algebra.RationalFunctionField(Rational, "x")
      x = F.var
      p ( 1 / (x**2 - 1) - 1 / (x**3 - 1) )
        #=> x^2/(x^4 + x^3 - x - 1)


--- Algebra.MRationalFunctionField(ring, [obj1[, obj2, ...]])
    Creates the rational function field over ((|ring|)) with
    the variables expressed by ((|obj1|)), ((|obj2|)), .... This class is equipped with
    the class method ((|::vars|)) which returns the array of variables.
    
    Example: the quotient field over the polynomial ring over Rational
      require "algebra/localized-ring"
      require "rational"
      G = Algebra.MRationalFunctionField(Rational, "x", "y", "z")
      x, y, z = G.vars
      f = (x + z) / (x + y) - z / (x + y)
      p f #=> (x^2 + xy)/(x^2 + 2xy + y^2)
      p f.simplify #=> x/(x + y)

== Class Method:

--- ::create(ring)
    Returns the fraction ring of which the numerator and the
    denominator are the elements of the ((|ring|)).

    This returns the subclass of Algebra::LocalizedRing. The subclass
    has the class method ((|::ground|)) and (({::[]})) which 
    return ((|ring|)) and (({x/1})) respectively.
    
    Example: Yet Another Rational
      require "localized-ring"
      F = Algebra.LocalizedRing(Integer)
      p F.new(1, 2) + F.new(2, 3) #=> 7/6

    Example: rational function field over Integer
      require "polynomial"
      require "localized-ring"
      P = Algebra.Polynomial(Integer, "x")
      F = Algebra.LocalizedRing(P)
      x = F[P.var]
      p ( 1 / (x**2 - 1) - 1 / (x**3 - 1) )
        #=> (x^3 - x^2)/(x^5 - x^3 - x^2 + 1)

--- ::zero
    Returns zero.
    
--- ::unity
    Returns unity.

#--- ::[](num, den = nil)

#--- ::reduce(num, den)


== Methods:

#--- monomial?; true; end

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

--- /(other)
    Returns the quotient of ((|self|)) by ((|other|)) using ((<inverse>)).

--- **(n)
    Returns the ((|n|))-th power of ((|self|)).

#--- to_s

#--- inspect

#--- hash

=end

