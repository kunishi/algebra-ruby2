=begin
[((<index|URL:index.html>))] 
= AlgebraicExtensionField
((*(Algebraic Extension Field)*))

A class represents the algebraic extension field.

== File Name:
* ((|algebraic-Extension-feild.rb|))

== SuperClass:

* ((|ResidueClassRing|))

== Included Module

(none)

== Associated Methods:

--- Algebra.AlgebraicExtensionField(field, obj){|x| ... }
    Same as ((<::create>)).

== Class Method

--- ::create(k, obj){|x| ... }
    Returns the extension field ((|k[x]/(p(x))|))
    of the field ((|k|)) by 
    the polynomial ((|p(x)|)) of the variable ((|x|)), 
    where ((|obj|)) represents the ((|x|)).

    The class methods ((<::var>)), ((<::def_polys>)) and ((<::env_ring>))
    are defined for the return value.
    
    Example: Create the field ((|F|)) extended by (({x**2 + x + 1 == 0}))
    from ((|Rational|)).
      require "rational"
      require "polynomial"
      require "residue-class-ring"
      F  = Algebra.AlgebraicExtensionField(Rational, "x") {|x| x**2 + x + 1}
      x = F.var
      p( (x-1)** 3 / (x**2 - 1) ) #=> -3x - 3

--- ::to_ary
    Returns (({[self, var]})).

    Example: Define AlgebraicExtensionField and variables simulteniously
      require "rational"
      require "algebraic-extension-field"
      F, a = Algebra.AlgebraicExtensionField(Rational, "a") {|a| a**2 + a + 1}

--- ::var
    Returns the residue class of ((|x|)).
    This method is defined for the residue class ring, ((|k[x]/(p(x))|))
    which is the return value of ((<::create>)).

--- ::modulus
    Returns the element ((|p(x)|)) of ((|k[x]|)) .
    This method is defined for the residue class ring, ((|k[x]/(p(x))|))
    which is the return value of ((<::create>)).

--- ::def_polys
    Returns the array of ((<::modulus>))'s of size ((|n|)).
    Where ((|self|)) is defined recursively as the 
    ((|AlgebraicExtensionField|)) 
    of height ((|n|)) and base field ((|k0|)). 
    This method is defined for the residue class ring ((|k[x]/(p(x))|))
    which is the return value of ((<::create>)).



    Example: Make the extension field of cubic roots of 2, 3, 5 over Rational.
      require "algebra"
      # K0 == Rational
      K1 = AlgebraicExtensionField(Rational, "x1") { |x|
        x ** 3 - 2
      }
      K2 = AlgebraicExtensionField(K1, "x2") { |y|
        y ** 3 - 3
      }
      K3 = AlgebraicExtensionField(K2, "x3") { |z|
        z ** 3 - 5
      }

      p K3.def_polys #=> [x1^3 - 2, x2^3 - 3, x3^3 - 5]

      x1, x2, x3 = K1.var, K2.var, K3.var
      f = x1**2 + 2*x2**2 + 3*x3**2
      f0 = f.abs_lift

      p f0.type     #=> (Polynomial/(Polynomial/(Polynomial/Rational)))
      p f0.type == K3.env_ring #=> true

      p f #=> 3x3^2 + 2x2^2 + x1^2
      p f0.evaluate(x3.abs_lift, x2.abs_lift, x1.abs_lift)
          #=> x3^2 + 2x2^2 + 3x3^2


--- ::env_ring
    Returns the multi-variate polynomial ring ((|k0[x1, x2,.., xn]|)).
    Where ((|self|)) is defined recursively as the 
    ((|AlgebraicExtensionField|)) 
    of height ((|n|)) and base field ((|k0|)). 
    This method is defined for the residue class ring ((|k[x]/(p(x))|))
    which is the return value of ((<::create>)).

--- ::ground
    Return the polnomial ring ((|k[x]|)) which is the ground ring of
    the residue class ring.

== Methods
--- abs_lift
    Returns the lift of self in ((<::env_ring>)).
    ( = ((|k0[x1, x2,.., xn] |)) ).

--- [](n)
    Returns the coeffcient of degree ((<n>)). Same as (({lift[n]})).

    Example: Fibonacci Series
      require "algebra"
      t = AlgebraicExtensionField(Integral, "t"){|x| x**2-x-1}.var
      (0..10).each do |n|
        p( (t**n)[1] ) #=> 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55
      end

=end
