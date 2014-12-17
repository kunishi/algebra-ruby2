=begin
  # sample-factorize01.rb

  require "algebra"
  
  P = Polynomial(Integer, "x")
  x = P.var
  f = 8*x**7 - 20*x**6 + 6*x**5 - 11*x**4 + 44*x**3 - 9*x**2 - 27
  p f.factorize #=> (2x - 3)^3(x^2 + x + 1)^2
((<_|CONTENTS>))
=end
