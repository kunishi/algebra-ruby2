=begin
  # sample-algebraicfield01.rb

  require "algebra"
  
  Px = Polynomial(Rational, "x")
  x = Px.var
  F = ResidueClassRing(Px, x**2 + x + 1)
  x = F[x]
  p( (x + 1)**100 )
      #=> -x - 1
  p( (x-1)** 3 / (x**2 - 1) )
      #=> -3x - 3
  
  G = Polynomial(F, "y")
  y = G.var
  p( (x + y + 1)** 7 )
      #=> y^7 + (7x + 7)y^6 + 8xy^5 + 4y^4 + (4x + 4)y^3 + 5xy^2 + 7y + x + 1
  
  H = ResidueClassRing(G, y**5 + x*y + 1)
  y = H[y]
  p( 1/(x + y + 1)**7 )
    #=> (1798/3x + 1825/9)y^4 + (-74x + 5176/9)y^3 + 
    #     (-6886/9x - 5917/9)y^2 + (1826/3x - 3101/9)y + 2146/9x + 4702/9
((<_|CONTENTS>))
=end
