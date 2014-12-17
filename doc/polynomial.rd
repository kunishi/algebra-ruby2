=begin
[((<index|URL:index.html>))] 
((<Polynomial>))
/
((<PolynomialFactorization>))
/
((<Algebra::SplittingField>))
/
((<Algebra::Galois>))

= Polynomial
((*(Class of Polynomial Ring)*))

This class expresses the polynomial ring over arbitrary ring.
For creating the actual class, use the class method ((<::create>))
or ((<Algebra.Polynomial>)), giving the coefficient ring.

== File Name:
* ((|polynomial.rb|))

== SuperClass:

* ((|Object|))

== Included Modules

* ((|Enumerable|))
* ((|Comparable|))
* ((<Algebra::EuclidianRing>))
#* ((<PolynomialFactorization>))

== Associated Functions:

--- Algebra.Polynomial(ring [, obj0 , obj1 [, ...]])
    Same as ((<::create>))(ring, obj0[, obj1 [, ...]]).

== Class Methods:

--- ::create(ring, obj0[, obj1[, ...]])
    Creates a polynomial ring class over the coefficient ring
    expressed by the class: ((|ring|)).
    
    The objects designated in (({obj0, obj1, ...})) express the variables,
    and the polynomial ring on the polynomial ring is recursively created, 
    if this is multiple.

    The value of this method is the subclass of Polynomial class.
    This subclass has the class methods: ((|ground|)), ((|var|)), 
    and ((|vars|)), which return the coefficient ring ((|ring|)), 
    the primary variable object(the latest one) and all variables, 
    respectively.

    The objects (({obj0, obj1, ...})) are to utilize for the name
    (the value of ((|to_s|)) ) of the variable.
        
    Example: Polynomial ring over Integer
      require "polynomial"
      P = Algebra::Polynomial.create(Integer, "x")
      x = P.var
      p((x + 1)**100) #=> x^100 + 100x^99 + ... + 100x + 1
      p P.ground #=> integer


    Example: Multi variate Polynomial ring over Integer
      require "polynomial"
      P = Algebra::Polynomial.create(Integer, "x", "y", "z")
      x, y, z = P.vars
      p((-x + y + z)*(x + y - z)*(x - y + z))
      #=> -z^3 + (y + x)z^2 + (y^2 - 2xy + x^2)z - y^3 + xy^2 + x^2y - x^3
      p P.var #=> z
    
    This (({P})) is equal to

      Algebra::Polynomial.create(
        Algebra::Polynomial.create(
          Algebra::Polynomial.create(
            Integer,
          "x"),
        "y"),
      "z")

    and the last variable ((|z|)) is the primary variable.

--- ::var
    Returns the (primary) variable of the polynomial ring.

--- ::vars
    Returns the array of the variables of the polynomial rings, 
    collecting recursively.

--- ::mvar
    Same as ((<::vars>)).

--- ::to_ary
    Returns (({[self, *vars]})).

    Example: Define Polynomial ring and variables simulteniously
      P, x, y, z = Algebra::Polynomial.create(Integer, "x", "y", "z")

--- ::variable
    Returns the object which expresses the (primary) variable of 
    the polynomial ring.

--- ::variables
    Returns the array of the objects which express the variables of 
    the polynomial rings, collecting recursively.

--- ::indeterminate(obj)
    Returns the variable expressed by ((|obj|)).

--- ::monomial([n])
    Returns the monomial of degree ((|n|)).
    
    Example:
      P = Polynomial(Integer, "x")
      P.monomial(3) #=> x^3

--- ::const(c)
    Returns the constant value ((|c|)).

    Example:
      P = Polynomial(Integer, "x")
      P.const(3)      #=> 3
      P.const(3).type #=> P

--- ::zero
    Returns the zero.
    
--- ::unity
    Returns the unity.

#--- ::euclidian?

== Methods:

--- var
    Same as ((<::var>)).

--- variable
    Same as ((<::variable>)).

--- each(&b)
    Iterates of coefficients in the ascendant power series.
    
    Example:
      P = Polynomial(Integer, "x")
      x = P.var
      (x**3 + 2*x**2 + 4).each do |c|
        p c #=> 4, 0, 2, 1
      end

--- reverse_each(&b)
    Iterates of coefficients in the descendent power series.

    Example:
      P = Polynomial(Integer, "x")
      x = P.var
      (x**3 + 2*x**2 + 4).reverse_each do |c|
        p c #=> 1, 2, 0, 4
      end

--- [](n)
    Returns the coefficient of degree ((|n|)).

--- []=(n, v)
    Sets the coefficient of degree ((|n|)) into ((|v|)).

--- monomial
    Same as ((<::monomial>)).

--- monomial?
    Returns true if self is a monomial.

--- zero?
    Returns true if self is the zero.

--- zero
    Returns the zero.
    
--- unity
    Returns the unity.

#--- variable=(bf)
#--- size
#--- compact!
#--- ground_div(n, d)

--- ==(other)
    Returns true if ((|self|)) is equal to ((|other|)).

--- <=>(other)
    Returns positive if ((|self|)) is greater than ((|other|)).

--- +(other)
    Returns the sum of ((|self|)) and ((|other|)).

--- -(other)
    Returns the difference of ((|self|)) from ((|other|)).

--- *(other)
    Returns the product of ((|self|)) and ((|other|)).

--- **(n)
    Returns the ((|n|))-th power of ((|self|)).

--- /(other)
    Returns the quotient of ((|self|)) by ((|other|)).
    Same as ((<div>)).

--- divmod(other)
    Returns the array [quotient, remainder] by ((|other|)).

--- div(other)
    Returns the quotient of ((|self|)) by ((|other|)).
    Same as (({divmod(other).first})).

--- %(other)
    Returns the remainder of ((|self|)) by ((|other|)).
    Same as (({divmod(other).last})).

--- divide?(other)
    Returns true if ((|self|)) is divisible by ((|other|)).
    Same as (({divmod(other).last == zero?})).

--- deg
    Returns the degree.

    Example:
      P = Polynomial(Integer, "x")
      x = P.var
      (5*x**3 + 2*x + 1).deg #=> 3

--- lc
    Returns the leading coefficient.

    Example:
      (5*x**3 + 2*x + 1).lc #=> 5

--- lm
    Returns the leading monomial.

    Example:
      (5*x**3 + 2*x + 1).lm #=> x**3

--- lt
    Returns the leading term).
    Same as (({lc * lm})).

    Example:
      (5*x**3 + 2*x + 1).lt #=> 5*x**3

--- rt
    Returns the rest term, which has the same value as (({self - lt})).

    Example:
      (5*x**3 + 2*x + 1).rt #=> 2*x + 1

--- monic
    Returns the polynomial, which corrected the maximum order coefficient in 1.
    Same as (({self / lc})) .

--- cont
    Returns the content (i.e. L.C.M of coefficients).

--- pp
    Returns the primitive part.
    Same as(({self / cont})).

--- to_s
    Returns the expression in strings.
    Use ((|display_type|)) in order to change the display format.
    The possible value of ((|display_type|)) is 
    ((|:norm|))(default) and  ((|:code|)).
    
    Example:
      P = Polynomial(Integer, "x")
      x = P.var
      p 5*x**3 + 2*x + 1 #=>5x^3 + 2x + 1
      P.display_type = :code
      p 5*x**3 + 2*x + 1 #=> 5*x**3 + 2*x + 1

--- derivate
    Return the derivative.
    
    Example:
      (5*x**3 + 2*x + 1).derivate #=> 15*x**2 + 2

--- sylvester_matrix(other)
    Return the Sylvester matrix of ((|self|)) and ((|other|)).

--- resultant(other)
    Return the resultant of ((|self|)) with ((|other|))

--- project(ring[, obj]){|c, n| ... }
    Returns the sum of the evaluations
    of ... for each monomial of coefficient ((|c|)) and degree ((|n|)).
    If ((|obj|)) is omitted, it is assumed to be (({ring.var})).
    
    Example:
      require "polynomial"
      require "rational"
      P = Algebra::Polynomial(Integer, "x")
      PQ = Algebra::Polynomial(Rational, "y")
      x = P.var
      f = 5*x**3 + 2*x + 1
      p f.convert_to(PQ) #=> 5y^3 + 2y + 1
      p f.project(PQ) {|c, n| Rational(c) / (n + 1)} #=> 5/4y^3 + y + 1

--- evaluate(obj)
    Returns the value of ((|self|)) at ((|obj|)).
    This is equivalent to (({ project(ground, obj){|c, n| c} })).

    Example:
      require "polynomial"
      P = Algebra::Polynomial(Integer, "x")
      x = P.var
      f = x**3 - 3*x**2 + 1
      p f.evaluate(-1)    #=> -3 (in Integer)
      p f.evaluate(x + 1) #=> x^3 - 3x - 1 (in P)

--- call(obj)
    Same as ((<evaluate>)).

--- sub(var, value)
    Returns the value of substitution of a variable ((|var|)) by ((|value|)).

    Example:
      require "polynomial"
      P = Algebra::Polynomial(Integer, "x", "y", "z")
      x, y, z = P.vars
      f = (x - y)*(y - z - 1)
      p f.sub(y, z+1)    #=> 0

--- convert_to(ring)
    Returns the polynomial the one converted on ((|ring|)).
    This is equivalent to (({ project(ring){|c, n| c} })).

= PolynomialFactorization
((*(Module of Factorization)*))

The module of factorization of polynomials.

== File Name:
((|polynomial-factor.rb|))

== Methods:

--- sqfree
    Returns the square free parts.

--- sqfree?
    Returns true if square free.

--- irreducible?
    Returns true if irreducible

--- factorize
    Returns the factorization.
    
    The following type can be factorized:
    * Integer
    * Rational
    * prime field
    * Algebraic Field


= Algebra::SplittingField
((*(Module of Splitting Field)*))

The module of the minimal splitting field of polynomials.


== File Name:
* ((|splitting-field.rb|))

== Methods:

--- decompose([fac0])
    Returns

      [field, modulus, facts, roots, addelems]

    Here the elements are: 
    ((|field|)) the mimimal splitting field of ((|poly|)), 
    ((|def_polys|)) the irreducible polynomial needed for the splitting,
    ((|facts|)) the linear factors of ((|poly|)) over ((|field|)), 
    ((|roots|)) the roots of ((|poly|)) and
    ((|proots|)) the sorted array of ((|roots|)) in order that
    the added elements to the base field first.

    ((|fac0|)) makes the factorization fast. (((|facts|)) and ((|fact0|))
    are the instance of ((|Algebra::Factors|))).
    Generally, ((|field|)) is the object of
    ((<AlgebraicExtensionField|algebraic-extension-field.html>)).
    If ((|self|)) is splitted linearlly,
    that is the ((<ground>)) ring own.

    Example:
      require "algebra"
      PQ = Polynomial(Rational, "x")
      x = PQ.var
      f = x**5 - x**4 + 2*x - 2
      field, def_polys, facts, roots, proots = f.decompose
      p def_polys #=> [a^4 + 2, b^2 + a^2]
      p facts    #=> (x - 1)(x - a)(x + a)(x - b)(x + b)
      p roots    #=> [1, a, -a, b, -b]
      p proots   #=> [a, b, 1, -a, -b]
      fp = Polynomial(field, "x")
      x = fp.var
      facts1 = Factors.new(facts.collect{|g, n| [g.call(x), n]})
      p facts1.pi == f.convert_to(fp) #=> true

--- splitting_field([fac0]))
    Returns the infomation of the splitting field of ((|self|)).
    Each field corresponds to the return value of ((<decompose>)):

    poly, field, roots, proots, def_polys

    The values of ((|roots|)) and ((|proots|)) are transrated in
    the elements of ((|fields|)).

    Example:
      require "algebra"
      PQ = Polynomial(Rational, "x")
      x = PQ.var
      f = x**5 - x**4 + 2*x - 2
      sf = f.splitting_field
      p sf.roots     #=> [1, a, -a, b, -b]
      p sf.proots     #=> [a, b, 1, -a, -b]
      p sf.def_polys #=> [a^4 + 2, b^2 + a^2]

= Algebra::Galois
((*(Module of Galois Group)*))

The module of Galois Group of polynomials

== File Name:
* ((|galois-group.rb|))

== Included Module:
(none)

== Associated Method

--- GaloisGroup.galois_group(poly)
    Same as ((<galois_group>)).

== Method:

--- galois_group
    Retuns the galois group of ((|self|)).
    Each elements of this is the object of
    ((<FiniteGroup|finite-group.html>)) of which elements are
    in ((<PermutationGroup|permutation-group.html>)).

    Example:
      require "rational"
      require "polynomial"

      P = Algebra.Polynomial(Rational, "x")
      x = P.var
      p( (x**3 - 3*x + 1).galois_group.to_a )
      #=>[[0, 1, 2], [1, 2, 0], [2, 0, 1]]

      (x**3 - x + 1).galois_group.each do |g|
        p g
      end
      #=> [0, 1, 2]
      #   [1, 0, 2]
      #   [2, 0, 1]
      #   [0, 2, 1]
      #   [1, 2, 0]
      #   [2, 1, 0]

=end
