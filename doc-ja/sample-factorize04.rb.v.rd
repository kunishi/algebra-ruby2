=begin
  # sample-factorize04.rb

  require "algebra"
  
  A = AlgebraicExtensionField(Rational, "a") {|a| a**2 - 2}
  B = AlgebraicExtensionField(A, "b"){|b| b**2 + 1}
  P = Polynomial(B, "x")
  x = P.var
  f = x**4 + 1
  p f.factorize
  #=> (x - 1/2ab - 1/2a)(x + 1/2ab - 1/2a)(x + 1/2ab + 1/2a)(x - 1/2ab + 1/2a)
((<_|CONTENTS>))
=end
