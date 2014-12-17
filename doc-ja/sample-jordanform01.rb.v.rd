=begin
  ----------^ sample-jordanform01.rb
  require "algebra"
  
  M4 = SquareMatrix(Rational, 4)
  m = M4[
      [-1, 1, 2, -1],
      [-5, 3, 4, -2],
      [3, -1, 0, 1],
      [5, -2, -2, 3]
  ]
  m.jordan_form.display; #=>
  #  2,   0,   0,   0
  #  0,   1,   1,   0
  #  0,   0,   1,   1
  #  0,   0,   0,   1
  puts
  
  #------------------------------------------------------------
  m = M4[
    [3, 1, -1, 1],
    [-3, -1, 3, -1],
    [-2, -2, 0, 0],
    [0, 0, -4, 2]
  ]
  jf, pt, qt, field, modulus  = m.jordan_form_info
  print "extention = "; p modulus #=> [a^2 + 4]
  jf.display; puts #=>
  #  2,   1,   0,   0
  #  0,   2,   0,   0
  #  0,   0,   a,   0
  #  0,   0,   0,  -a
  
  m = m.convert_to(jf.type)
  p jf == pt * m * qt #=> true
  
  #------------------------------------------------------------
  m = M4[
      [-1, 1, 2, -1],
      [-5, 3, 4, -2],
      [3, -1, 0, 1],
      [5, -2, -2, 0]
  ]
  jf, pt, qt, field, modulus  = m.jordan_form_info
  print "extention = "; p modulus #=> [a^3 + 3a - 1, b^2 + ab + a^2 + 3]
  jf.display; puts #=>
  #  2,   0,   0,   0
  #  0,   a,   0,   0
  #  0,   0,   b,   0
  #  0,   0,   0, -b - a
  
  m = m.convert_to(jf.type)
  p jf == pt * m * qt #=> true
  ----------$ sample-jordanform01.rb
=end
