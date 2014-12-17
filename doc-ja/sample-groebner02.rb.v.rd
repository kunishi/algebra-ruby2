=begin
  # sample-groebner02.rb

  require "algebra"
  
  P = MPolynomial(Rational)
  x, y, z = P.vars "xyz"
  f1 = x**2 + y**2 + z**2 -1
  f2 = x**2 + z**2 - y
  f3 = x - z
  
  coeff, basis = Groebner.basis_coeff([f1, f2, f3])
  basis.each_with_index do |b, i|
    p [coeff[i].inner_product([f1, f2, f3]), b]
    p coeff[i].inner_product([f1, f2, f3]) == b #=> true
  end
((<_|CONTENTS>))
=end
