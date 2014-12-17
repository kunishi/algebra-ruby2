=begin
  # sample-groebner01.rb

  require "algebra"
  P = MPolynomial(Rational, "xyz")
  x, y, z = P.vars("xyz")
  f1 = x**2 + y**2 + z**2 -1
  f2 = x**2 + z**2 - y
  f3 = x - z
  p Groebner.basis([f1, f2, f3])
  #=> [x - z, y - 2z^2, z^4 + 1/2z^2 - 1/4]
((<_|CONTENTS>))
=end
