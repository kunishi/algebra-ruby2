=begin
[((<index|URL:index.html>))] 
= algebraic-eqation.rb
((*(Utility for algebraic equations)*))

Library of utiltity for algebraic equations

== File Name:
* ((|algebraic-equation.rb|))

== Methods:

--- Algebra::Polynomial#minimal_decompositon_field([fact0])
    Same as ((<Algebra.PolyDecompose>))(self [,fact0])).

--- Algebra.MinimalPolynomial(element, poly1[, poly2[, poly3...]])
    Returns the mimimal polynmial of ((|element|)) 
    by the extention (({poly1, poly2, poly3...})).
    
    Example: Get the mimimal polymial of the square root of 2 + the
    square root of 3 + the square root of 5.
      PQ = MPolynomial(Rational)
      a, b, c = PQ.vars("abc")
      p MinimalPolynomial(a + b + c, a**2-2, b**2-3, c**2-5)
      #=> x^8 - 40x^6 + 352x^4 - 960x^2 + 576

=end
