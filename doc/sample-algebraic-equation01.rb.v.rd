=begin
  # sample-algebraic-equation01.rb

  require "algebra"
  
  PQ = MPolynomial(Rational)
  a, b, c = PQ.vars("abc")
  p AlgebraicEquation.minimal_polynomial(a + b + c, a**2-2, b**2-3, c**2-5)
  #=> x^8 - 40x^6 + 352x^4 - 960x^2 + 576
((<_|CONTENTS>))
=end
