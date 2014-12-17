=begin
  # sample-algebraic-root01.rb

  require "algebra"
  
  R2, r2, r2_ = Root(Rational, 2) # r2 = sqrt(2), -sqrt(2)
  p r2 #=> sqrt(2)
  R3, r3, r3_ = Root(R2, 3)       # r3 = sqrt(3), -sqrt(3)
  p r3 #=> sqrt(3)
  R6, r6, r6_ = Root(R3, 6)       # R6 = R3, r6 = sqrt(6), -sqrt(6)
  p r6 #=> -r2r3
  p( (r6 + r2)*(r6 - r2) ) #=> 4
  
  F, a, b =  QuadraticExtensionField(Rational){|x| x**2 - x - 1}
  # fibonacci numbers
  (0..100).each do |n|
    puts( (a**n - b**n)/(a - b) )
  end
((<_|CONTENTS>))
=end
