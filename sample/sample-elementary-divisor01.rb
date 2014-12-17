require "algebra"

M = SquareMatrix(Rational, 4)
a = M[
  [2, 0, 0, 0],
  [0, 2, 0, 0],
  [0, 0, 2, 0],
  [5, 0, 0, 2]
]
P = Polynomial(Rational, "x")
MP = SquareMatrix(P, 4)

ac = a._char_matrix(MP)
ac.display; puts #=>
#x - 2,   0,   0,   0
#  0, x - 2,   0,   0
#  0,   0, x - 2,   0
# -5,   0,   0, x - 2

p ac.elementary_divisor #=> [1, x - 2, x - 2, x^2 - 4x + 4]

require "algebra/matrix-algebra-triplet"
at = ac.to_triplet.e_diagonalize

at.body.display; puts #=>
#  1,   0,   0,   0
#  0, x - 2,   0,   0
#  0,   0, x - 2,   0
#  0,   0,   0, x^2 - 4x + 4

at.left.display; puts #=>
#  0,   0,   0, -1/5
#  0,   1,   0,   0
#  0,   0,   1,   0
#  5,   0,   0, x - 2

at.right.display; puts #=>
#  1,   0,   0, 1/5x - 2/5
#  0,   1,   0,   0
#  0,   0,   1,   0
#  0,   0,   0,   1

p at.left * ac * at.right == at.body #=> true
