=begin
[((<index|URL:index.html>))] 
((<Algebra::MPolynomial>))
/
((<Algebra::MPolynomial::Monomial>))
/
((<Algebra::MPolynomialFactorization>))
/
((<Algebra::Groebner>))

= Algebra::MPolynomial
((*(Class of Multi-variate Polynomial Ring)*))

This class expresses the multi-variate polynomial ring over arbitrary ring.
For creating the actual class, use the class method ((<::create>))
or ((<Algebra.MPolynomial>))(), giving the coefficient ring.

== File Name:
* ((|m-polynomial.rb|))

== SuperClass:

* ((|Object|))

== Included Modules:

* ((|Enumerable|))
* ((|Comparable|))
* ((<Algebra::Groebner>))

== Associated Function:

--- Algebra.MPolynomial(ring [, obj0 [, obj1 [, ...]]])
    Same as ((<::create>))(ring [, obj0[, obj1[, ...]]]).

== Class Methods:

--- ::create(ring [, obj0 [, obj1 [, ...]]])
    Creates a multi-variate polynomial ring class over the coefficient
    ring expressed by the class: ((|ring|)).

    The objects (({obj0, obj1, ...})) are reserved and represent variables.
    They are only to utilize for the names of variables (for ((|to_s|)) )
    and the distinction.
    
    The return value of this method is a sub-class of ((|Algebra::MPolynomial|)).
    This class has class-methods: ((|ground|)) and ((|vars|)), 
    which return
    the coefficient ring ((|ring|)) and an array of variables.
    
    The variables represented by objects (({obj0, obj1, ...})) can be
    able to obtain as :(({var(obj0)})), (({var(obj1)})),... So, 
    (({vars == [var(obj0), var(obj1), ...]})).
    
    The order of each variable is: (({obj0 > obj1 > ...})), and
    the order of monomials is determined by ((<::set_ord>)).

    Example: Polynomial ring over Integer
      require "m-polynomial"
      P = Algebra::MPolynomial.create(Integer, "x", "y", "z")
      x, y, z = P.vars
      p((-x + y + z)*(x + y - z)*(x - y + z))
      #=> -x^3 + x^2y + x^2z + xy^2 - 2xyz + xz^2 - y^3 + y^2z + yz^2 - z^3
      p P.ground #=> integer

--- ::vars([obj0 [, obj1 [, ...]]])
    ((*When no parameter is designated*)), it returns the array of 
    all variables, already reserved.
    
    Example:
      P = Algebra.MPolynomial(Integer, "x", "y", "z")
      p P.vars #=> [x, y, z]
    
    ((*When only one parameter of ((|String|)) is designated *)), 
    splits the string into identifiers and reserves them, which
    represent variables. The string of "AN ALPHABET + SOME DIGITS" can be
    an identifier.
    
    If the object has been already reserved, no new reservation is done.
    The return value of this method is an array of variables corresponding
    to the objects.
    
    Example: 
      P = Algebra.MPolynomial(Integer)
      x, y, z, w = P.vars("a0b10cd")
      p P.vars #=> [a0, b10, c, d]
      p [x, y, z, w] #=> [a0, b10, c, d]

    ((*Otherwise*)), reserve objects (({obj0, obj1, ...})) which represent
    variables. If the object has been already reserved, no reservation is 
    done. 
    The return value of this method is an array of variables corresponding
    to the objects.

    Example:
      P = Algebra.MPolynomial(Integer)
      p P.vars("x", "y", "z") #=> [x, y, z]

--- ::mvar([obj0 [, obj1 [, ...]]])
    ((*When no parameter is designated*)), it returns the array of 
    all variables, already reserved.
    
    ((*Otherwise*)), reserve objects (({obj0, obj1, ...})) which represent
    variables. If the object has been already reserved, no reservation is 
    done. 
    The return value of this method is an array of variables corresponding
    to the objects.

--- ::to_ary
    Returns (({[self, *vars]})).

    Example: Define MPolynomial ring and variables simulteniously
      P, x, y, z, w = Algebra.MPolynomial(Integer, "a", "b", "c", "d")

--- ::var(obj)
    Returns the variable, which is represented by ((|obj|)).
    
    Example: 
      P = Algebra.MPolynomial(Integer, "X", "Y", "Z")
      x, y, z = P.vars
      P.var("Y") == y #=> true

--- ::variables
    Returns the array of reserved objects, which represent variables.

--- ::indeterminate(obj)
    Same as ((<::var>)).

--- ::zero?
    Returns true if ((|self|)) is zero.

--- ::zero
    Returns zero.
    
--- ::unity
    Returns unity.

--- ::set_ord(ord [, v_ord])
    Sets the order of monomials as ((|ord|)) which is ((|Symbol|))
    of ordering type.
    The possible designations are ((|:lex|)) (lexicographic order (default)), 
    ((|:grlex|)) (graded lexicographic order), ((|:grevlex|)) (graded
    reverse lexicographic order). 
    
    The order of variables is the order of reservation.
    By the array ((|v_ord|)), we can transform the order.
    
    Example: the order of (({x, y, z = P.var("xyz")}))
      require "m-polynomial"
      P = Algebra.MPolynomial(Integer)
      x, y, z = P.vars("xyz")
      f = -5*x**3 + 7*x**2*z**2 + 4*x*y**2*z + 4*z**2

      P.set_ord(:lex)
      p f #=> -5x^3 + 7x^2z^2 + 4xy^2z + 4z^2

      f.method_cash_clear
      P.set_ord(:grlex)
      p f #=> 7x^2z^2 + 4xy^2z - 5x^3 + 4z^2

      f.method_cash_clear
      P.set_ord(:grevlex)
      p f #=> 4xy^2z + 7x^2z^2 - 5x^3 + 4z^2

      f.method_cash_clear
      P.set_ord(:lex, [2, 1, 0]) # z > y > x
      p f #=> 7x^2z^2 + 4z^2 + 4xy^2z - 5x^3

    See ((<::with_ord>)).

--- ::ord=(x)
    Same as ((<::set_ord(x)>)).

#--- ::order=(obj)
#    Same as ((<::set_ord(obj)>)).

--- ::get_ord
    Returns the monomial order. (:lex, :grlex, :grevlex)

--- ::ord
    Same as ((<::get_ord>)).

#--- ::order
#    Same as ((<::get_ord>)).

--- ::with_ord(ord [, v_ord[ [, array_of_polys]])
    Executes the block with monomial ordering ((|ord|)) and
    order of variables ((|v_ord|)). These ordering are
    available only in the block.(See ((<::set_ord>)).)
    When the array of polyomials ((|array_of_polys|)) is given,
    for each of them, ((<method_cash_clear>)) is invoked before
    the execution. (This is not a thread-safe block.)

    Example:
      require "m-polynomial"
      P = Algebra.MPolynomial(Integer)
      x, y, z = P.vars("xyz")
      f = -5*x**3 + 7*x**2*z**2 + 4*x*y**2*z + 4*z**2

      P.with_ord(:lex, nil, [f]) do
        p f    #=> -5x^3 + 7x^2z^2 + 4xy^2z + 4z^2
        p f.lt #=> -5x^3
      end

      P.with_ord(:grlex, nil, [f]) do
        p f    #=> 7x^2z^2 + 4xy^2z - 5x^3 + 4z^2
        p f.lt #=> 7x^2z^2
      end

      P.with_ord(:grevlex, nil, [f]) do
        p f    #=> 4xy^2z + 7x^2z^2 - 5x^3 + 4z^2
        p f.lt #=> 4xy^2z
      end

      P.with_ord(:lex, [2, 1, 0], [f]) do # z > y > x
        p f    #=> 7x^2z^2 + 4z^2 + 4xy^2z - 5x^3
        p f.lt #=> 7x^2z^2
      end

--- ::monomial(ind[, c])
    Returns the monomial of multi-degree ((|ind|)) and
    coefficient ((|c|)).
    (((<Algebra::MPolynomial::Monomial>)) is not extend.)
    If ((|c|)) is omitted, it is assumed to be the unity.

#--- ::const(x)
#--- ::regulate(x)
#--- ::method_cash_clear(*m)

== Methods:

--- monomial(ind[, c])
    Same as ((<::monomial>))

#--- each
#--- keys
#--- values
#--- [](ind)
#--- []=(ind, c)
#--- constant_coeff
#--- include?
#--- compact!
#--- rt!

--- constant?
    Retruns true if ((|self|)) is a constant.

--- monomial?
    Returns true if ((|self|)) is a monomial.

--- zero?
    Returns true if ((|self|)) is zero.

--- zero
    Returns zero.
    
--- unity
    Retruns unity.

--- method_cash_clear
    Clears the cashes of methods.
    
    In this library, some results of methods are stored so as not to
    do same calculations. When the order of monomials is changed, 
    we must clear the cashes.
    
    The methods which have cashes are following:
    ((<lc>)), ((<lm>)), ((<lt>)), ((<rt>)), ((<multideg>)).
    
    Example:
      P = Algebra.MPolynomial(Integer)
      x, y, z = P.vars("xyz")
      f = -5*x**3 + 7*x**2*z**2 + 4*x*y**2*z + 4*z**2
      P.set_ord(:lex)
      p f.lt #=> -5x^3
      P.set_ord(:grlex)
      p f.lt #=> -5x^3
      f.method_cash_clear
      p f.lt #=> 7x^2z^2

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
    ((|other|)) must be constant.

--- divmod(f0 [, f1 [,...]])
    Returns the array [the array of quotients, the remainder] 
    by (({f0, f1,...})).

      P = Algebra.MPolynomial(Integer)
      x, y = P.vars("xy")
      f = x**2*y + x*y**2 + y**2
      f0 = x*y - 1
      f1 = y**2 - 1
      p f.divmod(f0, f1) #=> [[x + y, 1], x + y + 1]
      p f % [f0, f1]     #=> x + y + 1

--- %(others)
    Returns the remainder of ((|self|)) by polynomials ((|others|)).
    It is equal to (({divmod(*others)[1]})).

--- multideg
    Returns the multiple degree as an array.
    
    Example: in lex order,
      P = Algebra.MPolynomial(Integer)
      x, y, z = P.vars("xyz")
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.multideg #=> [3, 1]

--- totdeg
    Returns the total degree.

    Example:
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.totdeg   #=> 4

--- deg
    Same as multideg.

--- lc
    Returns the leading coefficient.

    Example: in lex order,
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.lc       #=> -5

--- lm
    Returns the leading monomial.
    The return value is extended by ((<MPolynomial::Monomial>)).

    Example: in lex order,
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.lm       #=> x^3y

--- lt
    Returns leading term. This is equal to (({lc * lm})).

    Example: in lex order
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.lt       #=> -5x^3y

--- rt
    Returns the rest term. This is equal to (({self - lt})).

    Example: in lex order,
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.rt       #=> 4*z**2 - 5*x**3*y + 7*x**2*z**2

--- to_s
    Return the representation of ((|String|)). To change the format of
    expression, use ((|display_type|)).
    The values which are able to designate to ((|display_type|)) is: 
    ((|:norm|)) (default) and  ((|:code|)).
    
    Example:
      P = Algebra.MPolynomial(Integer)
      x, y, z = P.vars("xyz")
      f = -5*x**3 + 7*x**2*z**2 + 4*x*y**2*z + 4*z**2
      p f #=> -5x^3 + 7x^2z^2 + 4xy^2z + 4z^2
      P.display_type = :code
      p f #=> -5*x**3 + 7*x**2*z**2 + 4*x*y**2*z + 4*z**2

--- map_to(ring[, vs]){|c, ind| ... }
    Returns the sum over ((|ring|)) of the evaluations of ...
    for the multi-degree ((|ind|)) and coefficient ((|c|)).
    If ((|vs|)) is omitted, it is assumed to be ((<::vars>)).

    If (({f})) is the polynomial over (({P})), 
    (({f.map_to(P) {|c, ind| c * P.monomial(ind)}})) equals to (({f})).

--- project(ring[, vs]){|c, ind| ... }
    Returns the sum over ((|ring|)) of the evaluations of ...
    on the monomial 
    for the multi-degree ((|ind|)) and coefficient ((|c|)).

    If (({f})) is the polynomial over (({P})), 
    (({f.progect(P) {|c, ind| c}})) equals to (({f})).

    (({project(ring){|c, ind| f(c, ind)}})) equals to (({map_to(ring){|c, ind| f(c, ind) * self.class.monomial(ind)}})).

    If ((|vs|)) is omitted, it is assumed to be ((<::vars>)).
    
    Example:
      require "m-polynomial"
      require "rational"
      P = Algebra::MPolynomial(Integer, "x", "y", "z")
      x, y, z = P.vars
      f = x**2 + 2*x*y - z**3
      PQ = Algebra::MPolynomial(Rational, "x", "y", "z")
      p f.project(PQ) {|c, ind| Rational(c) / (ind[0] + 1)}
                        #=> 1/3x^2 + xy - z^3
      p f.convert_to(PQ)      #=> x^2 + 2xy - z^3


--- evaluate(obj0[, [obj1, [obj2,..]]])
    Reterns the value entering ((|obj0, obj1, obj2,...|)) for each value.
    This equivalent to
    ((<project>))(({(ground, [obj0, obj1, obj2,..]){|c, ind| c}})).

    Example:
      require "m-polynomial"
      P = Algebra::MPolynomial(Integer, "x", "y", "z")
      x, y, z = P.vars
      f = x**2 + 2*x*y - z**3
      p f.evaluate(1, -1, -1) #=> 0 (in Integer)
      p f.evaluate(y, z, x)   #=> -x^3 + y^2 + 2yz (in P)

--- call(obj0[, [obj1, [obj2,..]]])
    Same as ((<evaluate>)).

--- sub(var, value)
    Returns the value of substitution of ((|var|)) by ((|value|)).

    Example:
      require "m-polynomial"
      P = Algebra::MPolynomial(Integer)
      x, y, z = P.vars("x", "y", "z")
      f = (x - y)*(y - z - 1)
      p f.sub(y, z+1)    #=> 0

--- convert_to(ring)
    Returns the polynomial the one converted on ((|ring|)).
    This is equivalent to ((<project>))(({(ring){|c, ind| c}})).

--- derivate(var)
    Returns the partial differential by the variable ((<var>)).

    
= Algebra::MPolynomial::Monomial
(Module of Monomial)

The return value of ((<lt>)) and ((<lm>)) is extended by this module.

== Methods:

#--- ind
#--- coeff
#--- <=>(other)
--- divide?(other)
    Returns true if ((|self|)) is divided by ((|other|)), which is
    assumed to be a monomial.

--- /(other)
    Returns the quotient of ((|self|)) by ((|other|)), which is
    assumed to be a monomial.

--- prime_to?(other)
    Returns true if ((|self|)) is prime to ((|other|)), which is
    assumed to be a monomial.

--- lcm(other)
    Returns the least common multiple of ((|self|)) and ((<other>)), which is
    assumed to be a monomial.

--- divide_or?(other0, other1)
    Returns the same value as ((|divide?(other0.lcm(other1))|)).

= Algebra::MPolynomialFactorization
((*(Module of Factorization)*))

The module of factorization of polynomials.

== File Name:
((|m-polynomial-factor.rb|))

== Methods:
--- factorize
    Returns the factorization.
    
    The following type can be factorized:
    * Integer
    * Rational
    * prime field

= Algebra::Groebner
(Module of Groebner Basis)

== File Name:
* ((|groebner-basis.rb|))
* ((|groebner-basis-coeff.rb|))

== Class Methods:

--- Groebner.basis(f)
    Returns the array of reduced Groebner basis from the array of basis
    ((|f|)).
    Equivalent to ((<Groebner.basis(Groebner.minimal_basis(Groebner.basis_159A(f)))>)).
    
    Example:
      require "m-polynomial"
      require "rational"
      P = Algebra.MPolynomial(Rational)
      P.set_ord :grevlex
      x, y, z = P.vars("xyz")
      f1 = x**2 + y**2 + z**2 -1
      f2 = x**2 + z**2 - y
      f3 = x - z
      b = Groebner.basis([f1, f2, f3])
      p b #=> [y^2 + y - 1, z^2 - 1/2y, x - z]

--- Groebner.basis_159A(f)
    Returns the array of Groebner basis from the array of basis
    ((|f|)).

--- Groebner.minimal_basis(f)
    Returns the array of minimal Groebner basis from the array of 
    Groebner basis ((|f|)).

--- Groebner.reduced_basis(f)
    Returns the array of reduced Groebner basis from the array of 
    minimal Groebner basis ((|f|)). 

--- Groebner.basis_coeff(f)
    Returns the array of Groebner basis from the array of basis
    ((|f|)) and the array of coefficients to express them.
    
    Example:
      require "m-polynomial"
      require "rational"
      P = Algebra.MPolynomial(Rational)
      P.set_ord :grevlex
      x, y, z = P.vars("xyz")
      f1 = x**2 + y**2 + z**2 -1
      f2 = x**2 + z**2 - y
      f3 = x - z
      fs = [f1, f2, f3]
      c, b = Groebner.basis_coeff(fs)
      p b #=> [y^2 + y - 1, z^2 - 1/2y, x - z]
      p c #=> [[1, -1, 0], [0, 1/2, -1/2x - 1/2z], [0, 0, 1]]
      for i in 0..2
        p c[i].inner_product(fs) == b[i] #=> true
      end

--- Groebner.basis?(f)
    Return true if ((|f|)) is an array of Groebner basis.
    
--- Groebner.minimal_basis?(f)
    Return true if ((|f|)) is an array of minimal Groebner basis.
    
--- Groebner.reduced_basis?(f)
    Return true if ((|f|)) is an array of reduced Groebner basis.

    
== Methods:
--- S_pair(other)
    Returns the S-pair of ((|self|)) and ((|other|)).
    
    Example:
      (x**2*y + y**2 + z**2 -1).S_pair(x**2*z + z**2 - y)
        #=> y^2z + y^2 - yz^2 + z^3 - z

--- divmod_s(f1[, f2[, f3...]])
    Returns a array (({[[q1, q2, q3, ...], r]})) 
    of the array of quotients (coefficients of division) 
    and the remainder of division of ((|self|)) by 
    basis (({f1, f2, f3, ...})).
    
    We convert (({f1, f2, f3, ...})) into Groebner basis and make the division.
    So (({divmod(f1, f2, ...).last == 0})) is equivalent to that ((|self|))
    is in the ideal (({(f1, f2, ...)})).
    
    Example:
      require "m-polynomial"
      require "rational"
      P = Algebra.MPolynomial(Rational)
      P.set_ord :grevlex
      x, y, z = P.vars("xyz")
      f1 = x**2 + y**2 + z**2 -1
      f2 = x**2 + z**2 - y
      f3 = x - z
      fs = [f1, f2, f3]
      f = x**3 + y**3 + z**3
      c, r = f.divmod_s(*fs)
      p r #=> yz + 2y - 1
      p c #=> [y - 1, -y + z + 1, x^2]
      p f == c.inner_product(fs) + r #=> true

--- div_cg(f, cg)
    Returns (({[q, r]})) where q (quotients) and
    r (remain) of division, which are obtained from the basis
    ((|f|)) and (({cg}))=((<Groebner.basis_coeff>))(f).
    ((<divmod_s>))(f) returns 
    (({div_cg(f, Groebner.basis_coeff(f))})).

=end

