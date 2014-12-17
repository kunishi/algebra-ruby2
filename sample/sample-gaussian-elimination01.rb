require "algebra"
M = MatrixAlgebra(Rational, 5, 4)
a = M.matrix{|i, j| i + j}
a.display #=>
  #[0, 1, 2, 3]
  #[1, 2, 3, 4]
  #[2, 3, 4, 5]
  #[3, 4, 5, 6]
  #[4, 5, 6, 7]
a.kernel_basis.each do |v|
  puts "a * #{v} = #{a * v}"
  #=> a * [1, -2, 1, 0] = [0, 0, 0, 0, 0]
  #=> a * [2, -3, 0, 1] = [0, 0, 0, 0, 0]
end
