=begin
  # sample-galois-group01.rb

  require "algebra/rational"
  require "algebra/polynomial"
  
  P = Algebra.Polynomial(Rational, "x")
  x = P.var
  
  (x**3 - 3*x + 1).galois_group.each do |g|
    p g
  end
  #=> [0, 1, 2]
  #   [1, 2, 0]
  #   [2, 0, 1]]
  
  (x**3 - x + 1).galois_group.each do |g|
    p g
  end
  #=> [0, 1, 2]
  #   [1, 0, 2]
  #   [2, 0, 1]
  #   [0, 2, 1]
  #   [1, 2, 0]
  #   [2, 1, 0]
((<_|CONTENTS>))
=end
