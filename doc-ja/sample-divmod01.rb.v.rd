=begin
  # sample-divmod01.rb

  require "algebra"
  P = MPolynomial(Rational)
  x, y, z = P.vars("xyz")
  f = x**2*y + x*y**2 + y*2 + z**3
  g = x*y-z**3
  h = y*2-6*z
  
  P.set_ord(:lex) # lex, grlex, grevlex
  puts "(#{f}).divmod([#{g}, #{h}]) =>", "#{f.divmod(g, h).inspect}"
  #=> (x^2y + xy^2 + 2y + z^3).divmod([xy - z^3, 2y - 6z]) =>
  #   [[x + y, 1/2z^3 + 1], xz^3 + 3z^4 + z^3 + 6z]
  #   = [[Quotient1,Quotient2], Remainder]
((<_|CONTENTS>))
=end
