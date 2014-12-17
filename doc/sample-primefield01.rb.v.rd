=begin
  # sample-primefield01.rb

  require "algebra"
  Z13 = ResidueClassRing(Integer, 13)
  
  a, b, c, d, e, f, g = Z13
  p [e + c, e - c, e * c, e * 2001, 3 + c, 1/c, 1/c * c, d / d, b * 1 / b]
    #=> [6, 2, 8, 9, 5, 7, 1, 1, 1]
  p( (1...13).collect{|i|  Z13[i]**12} )
    #=> [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
((<_|CONTENTS>))
=end
