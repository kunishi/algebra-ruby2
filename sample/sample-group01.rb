require "algebra"
e = Permutation[0, 1, 2, 3, 4]
a = Permutation[1, 0, 3, 4, 2]
b = Permutation[0, 2, 1, 3, 4]
p a * b #=> [2, 0, 3, 4, 1]

g = Group.new(e, a, b)
g.complete!
p g == PermutationGroup.symmetric(5) #=> true







