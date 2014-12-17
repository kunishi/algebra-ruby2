=begin
  # sample-quotientfield02.rb

  require "algebra"
  
  F13 = ResidueClassRing(Integer, 13)
  
  P = Polynomial(F13, "x")
  Q = LocalizedRing(P)
  x = Q[P.var]
  p ( 1 / (x**2 - 1) - 1 / (x**3 - 1) )
  
  #This is equivalent to the following
  F = RationalFunctionField(F13, "x")
  x = F.var
  p ( 1 / (x**2 - 1) - 1 / (x**3 - 1) )
((<_|CONTENTS>))
=end
