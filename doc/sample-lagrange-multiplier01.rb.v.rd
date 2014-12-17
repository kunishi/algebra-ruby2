=begin
  # sample-lagrange-multiplier01.rb

  require 'algebra'
  P = MPolynomial(Rational)
  t, x, y, z = P.vars('txyz')
  f = x**3+2*x*y*z - z**2
  g = x**2 + y**2 + z**2 - 1
  
  fx = f.derivate(x)
  fy = f.derivate(y)
  fz = f.derivate(z)
  
  gx = g.derivate(x)
  gy = g.derivate(y)
  gz = g.derivate(z)
  
  F = [fx - t * gx, fy - t * gy, fz - t * gz, g]
  
  Groebner.basis(F).each do |h|
    p h.factorize
  end
  
  #(1/7670)(7670t - 11505x - 11505yz - 335232z^6 + 477321z^4 - 134419z^2)
  #x^2 + y^2 + z^2 - 1
  #(1/3835)(3835xy - 19584z^5 + 25987z^3 - 6403z)
  #(1/3835)(3835x + 3835yz - 1152z^4 - 1404z^2 + 2556)(z)
  #(1/3835)(3835y^3 + 3835yz^2 - 3835y - 9216z^5 + 11778z^3 - 2562z)
  #(1/3835)(3835y^2 - 6912z^4 + 10751z^2 - 3839)(z)
  #(1/118)(118y - 1152z^3 + 453z)(z)(z - 1)(z + 1)
  #(1/1152)(z)(z - 1)(3z - 2)(3z + 2)(z + 1)(128z^2 - 11)
  
  
((<_|CONTENTS>))
=end
