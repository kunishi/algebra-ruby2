=begin
  # sample-factorize02.rb

  require "algebra"
  
  Z7 = ResidueClassRing(Integer, 7)
  P = Polynomial(Z7, "x")
  x = P.var
  f = 8*x**7 - 20*x**6 + 6*x**5 - 11*x**4 + 44*x**3 - 9*x**2 - 27
  p f.factorize #=> (x + 5)^2(x + 3)^2(x + 2)^3
  
((<_|CONTENTS>))
=end
