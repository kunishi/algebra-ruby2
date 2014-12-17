=begin
[((<index|URL:index.html>))] 
= EuclidianRing

((*(G.C.D. module)*))

This is the module for getting G.C.D. (the greatest common divisor) 
from ((|divmod|)).
This is included to ((|Integer|)) or ((|Algebra::Polynomial|)).

== File Name:
* ((|euclidian-ring.rb|))

== Methods:

--- gcd(other)
    Returns the greatest common divisor of ((|self|)) and ((|other|)).

--- gcd_all(other0 [, other1[, ...]])
    Returns the greatest common divisor of ((|self|)) and 
    ((|other0|)), ((|other1|)),...

--- gcd_coeff(other)
    Returns the array of the greatest common divisor of ((|self|)) and 
    ((|other|)) and the coefficients for getting it.
    
    Example:
      require "polynomial"
      require "rational"
      P = Algebra.Polynomial(Rational, "x")
      x = P.var
      f = (x + 2) * (x**2 - 1)**2
      g = (x + 2)**2 * (x - 1)**3
      gcd, a, b = f.gcd_coeff(g)
      p gcd #=> 4x^3 - 12x + 8
      p a   #=> -x + 2
      p b   #=> x - 1
      p gcd == a*f + b*g #=> true

--- gcd_ext(other)
    Same as ((<gcd_coeff>))

--- gcd_coeff_all(other0 [, other1[, ...]])
    Returns the array of the greatest common divisor ((|self|)) and 
    ((|other0|)), ((|other1|)),.. and the coefficients for getting it.

    Example:
      require "polynomial"
      require "rational"
      P = Algebra.Polynomial(Rational, "x")
      x = P.var
      f = (x + 2) * (x**2 - 1)**2
      g = (x + 2)**2 * (x - 1)**3
      h = (x + 2) * (x + 1) * (x - 1)
      gcd, a, b, c = f.gcd_coeff_all(g, h)
      p gcd #=> -8x^2 - 8x + 16
      p a   #=> -x + 2
      p b   #=> x - 1
      p c   #=> -4
      p gcd == a*f + b*g + c*h #=> true

--- gcd_ext_all(other0 [, other1[, ...]])
    Same as ((<gcd_coeff_all>))

--- lcm(b)
    Return of the least common multiple of ((|self|)) and ((|other|)).

--- lcm_all(other0 [, other1[, ...]])
    Return of the least common multiple of ((|self|)) and 
    ((|other0|)), ((|other1|)),...

=end

