=begin
  # sample-algebraicfield02.rb

  require "algebra"
  
  F = AlgebraicExtensionField(Rational, "x") {|x| x**2 + x + 1}
  x = F.var
  p( (x + 1)**100 )
  p( (x-1)** 3 / (x**2 - 1) )
  
  H = AlgebraicExtensionField(F, "y") {|y| y**5 + x*y + 1}
  y = H.var
  p( 1/(x + y + 1)**7 )
((<_|CONTENTS>))
=end
