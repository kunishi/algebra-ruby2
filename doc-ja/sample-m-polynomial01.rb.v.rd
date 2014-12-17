=begin
  # sample-m-polynomial01.rb

  require "algebra"
  P = MPolynomial(Integer)
  x, y, z, w = P.vars("xyz")
  p((-x + y + z)*(x + y - z)*(x - y + z))
  #=> -x^3 + x^2y + x^2z + xy^2 - 2xyz + xz^2 - y^3 + y^2z + yz^2 - z^3
((<_|CONTENTS>))
=end
