require "algebra/algebra"
# jordan form ‚ª
# 2 1
# 0 2
#     a  0
#     0 -a
#‚Æ‚È‚é‚à‚Ì‚ğì‚è‚½‚¢

P = Polynomial(Rational, "x")
x = P.var
MR = SquareMatrix(Rational, 4)

def trans(m, i, j, c)
  m.mix_r!(i, j, c)
  m.mix_c!(j, i, -c)
  m
end
=begin
m = MR[
  [2, 1, 0, 0],
  [0, 2, 0, 0],
  [0, 0, 0, 2],
  [0, 0, -2, 0]
]
m.display; puts
trans(m, 1, 2, 1)
trans(m, 3, 1, 1)
trans(m, 1, 0, -1)
trans(m, 1, 3, -1)
m.display; puts
=end
m = MR[
  [3,   1,  -1,   1],
  [-3,  -1,   3,  -1],
  [-2,  -2,   0,   0],
  [0,   0,  -4,   2]
]
m.display; puts

m.jordan_form.display; puts
