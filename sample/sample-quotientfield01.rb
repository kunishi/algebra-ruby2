require "algebra"
Q = LocalizedRing(Integer)
a = Q.new(3, 5)
b = Q.new(5, 3)
p [a + b, a - b, a * b, a / b, a + 3, 1 + a]
  #=> [34/15, -16/15, 15/15, 9/25, 18/5, 8/5]
