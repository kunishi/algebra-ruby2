=begin
  # sample-factorize03.rb

  require "algebra"
  
  A = AlgebraicExtensionField(Rational, "a") {|a| a**2 + a + 1}
  a = A.var
  P = Polynomial(A, "x")
  x = P.var
  f = x**4 + (2*a + 1)*x**3 + 3*a*x**2 + (-3*a - 5)*x - a + 1
  p f.factorize #=> (x + a)^3(x - a + 1)
  
((<_|CONTENTS>))
=end
