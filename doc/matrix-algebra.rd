=begin
[((<index|URL:index.html>))] 

((<Algebra::MatrixAlgebra>))
/
((<Algebra::Vector>))
/
((<Algebra::Covector>))
/
((<Algebra::SquareMatrix>))
/
((<Algebra::GaussianElimination>))

= Algebra::MatrixAlgebra
((*(Class of Matrices)*))

This class expresses matrices.
For creating an actual class, use the class method 
((<::create>)) or the function ((<Algebra.MatrixAlgebra>))(), 
giving the ground ring and sizes.

That has ((<Algebra::Vector>))(column vectorÅj, 
((<Algebra::Covector>))(row vector), 
((<Algebra::SquareMatrix>))(square matrix) as subclass.

== File Name:
* ((|matrix-algebra.rb|))

== SuperClass:

* ((|Object|))

== Included Module:

* ((<Algebra::GaussianElimination>))
* Enumerable

== Associated Function:

--- Algebra.MatrixAlgebra(ring, m, n)
    Same as ((<::create>))(ring, m, n).

== Class Methods:

--- ::create(ring, m, n)
    Creates the class of matrix of type (({ (m, n) })) with
    elements of the ring ((|ring|)).

    The return value of this method is a subclass of
    ((<Algebra::MatrixAlgebra>)).
    The subclass has class methods:
    ((|ground|)),  ((|rsize|)), ((|csize|)) and  ((|sizes|)), 
    which returns the ground ring, the size of rows( ((|m|)) ),
    the size of columns( ((|n|)) )  and the array of (({ [m, n] }))
    respectively.

    To create the actual matrix, use the class methods: ((<::new>)), 
    ((<::matrix>)) or ((<::[]>)).

--- ::new(array)
    Returns the matrix of the elements designated by the array of
    arrays ((|array|)).

    Example:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M.new([[1, 2, 3], [4, 5, 6]])
      a.display
        #=> [1, 2, 3]
        #=> [4, 5, 6]

--- ::matrix{|i, j| ... }
    Returns the matrix which has the (({i-j}))-th elements
    evaluating ..., where ((|i|)) and ((|j|)) are the row 
    and the column indices
    
    Example:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M.matrix{|i, j| 10*(i + 1) + j + 1}
      a.display
        #=> [11, 12, 13]
        #=> [21, 22, 23]

--- ::[](array1, array2, ..., array)
    Returns the matrix which has (({array1, array2, ..., array})) 
    as rows.

    Example:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M[[1, 2, 3], [4, 5, 6]]
      a.display
        #=> [1, 2, 3]
        #=> [4, 5, 6]

--- ::collect_ij{|i, j| ... }
    Returns the array of arrays with the value ... as 
    the ((|j|))-th element of the ((|i|))-th array.

--- ::collect_row{|i| ... }
    Returns the matrix whose ((|i|))-th row is the array
    obtained by evaluating ....

    Example:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      A = M.collect_row{|i| [i*10 + 11, i*10 + 12, i*10 + 13]}
      A.display
        #=> [11, 12, 13]
        #=> [21, 22, 23]

--- ::collect_column{|j| ... }
    Returns the matrix whose ((|j|))-th column is the array
    obtained by evaluating ....

    Example:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      A = M.collect_column{|j| [11 + j, 21 + j]}
      A.display
        #=> [11, 12, 13]
        #=> [21, 22, 23]

--- ::*(otype)
    Returns the class of matrix multiplicated by ((|otype|)).

    Example:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      N = Algebra.MatrixAlgebra(Integer, 3, 4)
      L = M * N
      p L.sizes #=> [3, 4]

--- ::vector_type
    Returns the class of column-vector(Vector) which has the same size of ((<rsize>)).

--- ::covector_type
    Returns the class of row-vector(CoVector) which has the same size of ((<csize>)).

--- ::transpose
    Returns the transposed matrix

--- ::zero
    Returns the zero matrix.

#--- ::matrices; Matrices; end
#--- ::regulate(x)

== Methods:
#--- dup
--- [](i, j)
    Returns the (({(i, j)}))-th component.

--- []=(i, j, x)
    Replaces the (({(i, j)}))-th component with ((|x|)).

--- rsize
    Same as ((<::rsize>)).

--- csize
    Same as ((<::csize>)).

--- sizes
    Same as ((<::sizes>)).

--- rows
    Returns the array of rows.
    
    Example:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M.new([[1, 2, 3], [4, 5, 6]])
      p a.rows #=> [[1, 2, 3], [4, 5, 6]]
      p a.row(1) #=> [4, 5, 6]
      a.set_row(1, [40, 50, 60])
      a.display #=> [1, 2, 3]
                #=> [40, 50, 60]

--- row(i)
    Returns the ((|i|))-th row as an array.

--- set_row(i, array)
    Replaces the ((|i|))-th row with ((|array|)).

--- columns
    Returns the array of columns.
    
    ó·:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M.new([[1, 2, 3], [4, 5, 6]])
      p a.columns #=> [[1, 4], [2, 5], [3, 6]]
      p a.column(1) #=> [2, 5]
      a.set_column(1, [20, 50])
      a.display #=> [1, 20, 3]
                #=> [4, 50, 6]

--- column(j)
    Returns the ((|j|))-th column as an array.

--- set_column(j, array)
    Replaces the ((|i|))-th column with ((|array|)).

--- each{|row| ...}
    Iterates with ((|row|)).

--- each_index{|i, j| ...}
    Iterates with indices (({ (i, j) })).

--- each_i{|i| ...}
    Iterates with the index (({i})) of rows.

--- each_j{|j| ...}
    Iterates with the index (({j})) of columns.

--- each_row{|r| ... }
    Iterates with the row ((|r|)). Same as ((<each>)).

--- each_column{|c| ... }
    Iterates with the column ((|c|)).

--- matrix{|i, j| ... }
    Same as ((<::matrix>)).

--- collect_ij{|i, j| ... }
    Same as ((<::collect_ij>)).

--- collect_row{|i| ... }
    Same as ((<::collect_row>)).

--- collect_column{|j| ... }
    Same as ((<::collect_column>)).

--- minor(i, j)
    Returns the minor matrix deleteing ((|i|))-th row and ((|j|))-th column.


--- cofactor(i, j)
    Return the determinant of minor matrix deleteing ((|i|))-th row and ((|j|))-th colum multiplied by (-1)**(i+j). 
    This is equal to (({minor(i, j) ** (i + j)})).

--- cofactor_matrix
    Returns the cofactor_matrix.  This is equal to (({self.class.transpose.matrix{|i, j| cofactor(j, i)}})).

--- adjoint
    Same as ((<cofactor_matrix>)).

--- ==(other)
    Returns true if ((|self|)) is equal to ((|other|)).

--- +(other)
    Returns the sum of ((|self|)) and ((|other|)).

--- -(other)
    Returns the difference of ((|self|)) from ((|other|)).

--- *(other)
    Returns the product of ((|self|)) and ((|other|)).
     
    Example:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      N = Algebra.MatrixAlgebra(Integer, 3, 4)
      L = M * N
      a = M[[1, 2, 3], [4, 5, 6]]
      b = N[[-3, -2, -1, 0], [1, 2, 3, 4], [5, 6, 7, 8]]
      c = a * b
      p c.type  #=> L
      c.display #=> [14, 20, 26, 32]
                #=> [23, 38, 53, 68]

--- **(n)
    Returns the ((|n|))-th power of ((|self|)).

--- /(other)
    Returns the quotient ((|self|)) by ((|other|)).

--- rank
    Returns the rank.

--- dsum(other)
    Returns the direct sum of ((|self|)) and ((|other|)).

    Example:
      a = Algebra.MatrixAlgebra(Integer, 2, 3)[
            [1, 2, 3],
            [4, 5, 6]
          ]
      b = Algebra.MatrixAlgebra(Integer, 3, 2)[
            [-1, -2],
            [-3, -4],
            [-5, -6]
          ]
      (a.dsum b).display #=> 1,   2,   3,   0,   0
                         #=> 4,   5,   6,   0,   0
                         #=> 0,   0,   0,  -1,  -2
                         #=> 0,   0,   0,  -3,  -4
                         #=> 0,   0,   0,  -5,  -6


--- to_ary
    Returns ((|to_a|)). ((|to_a|)) is defined in ((|Enumerable|)).

--- flatten
    Returns ((|to_a.flatten|)).

--- diag
    Returns the array of the diagonal compotents.

--- convert_to(ring)
    Returns the conversion of ((|self|)) to ring's object.

    Example:
      require "matrix-algebra"
      require "residue-class-ring"
      Z3 = Algebra.ResidueClassRing(Integer, 3)
      a = Algebra.MatrixAlgebra(Integer, 2, 3)[
        [1, 2, 3],
        [4, 5, 6]
      ]
      a.convert_to(Algebra.MatrixAlgebra(Z3, 2, 3)).display
                                          #=>  1,   2,   0
                                          #=>  1,   2,   0

--- transpose
    Returns the transposed matrix.

    Example:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M.new([[1, 2, 3], [4, 5, 6]])
      Mt = M.transpose
      b = a.transpose
      p b.type  #=> Mt
      b.display #=> [1, 4]
                #=> [2, 5]
                #=> [3, 6]

#--- to_s

--- dup
    Returns the duplication of ((|self|)).
    
    Example:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M.new([[1, 2, 3], [4, 5, 6]])
      b = a.dup
      b[1, 1] = 50
      a.display #=> [1, 2, 3]
                #=> [4, 5, 6]
      b.display #=> [1, 2, 3]
                #=> [4, 50, 6]

--- display([out])
    Displays ((|self|)) to  ((|out|)). If ((|out|)) is omitted, ((|out|))
    is ((|$stdout|)).
    
#--- inspect

= Algebra::Vector
((*(Class of Vector)*))

The class of column vectors.

== SuperClass:

* ((|MatrixAlgebra|))

== Included Module

none.

== Associated Functions:

--- Algebra.Vector(ring, n)
    Same as ((<Algebra::Matrix::Vector.create>))(ring, n).

== Class Methods:

--- Algebra::Vector.create(ring, n)
    Creates the class of the ((|n|))-th dimensional (column) vector
    over the ((|ring|)).

    The return value of this is a subclass of 
    ((<Algebra::Vector>)).
    This subclass has the class methods: 
    ((|ground|)) and 
    ((|size|)), 
    which returns ((|ring|)) and the size 
    ((|n|)) respectively.

    To get actual vectors, use the class methods: ((|new|)), 
    ((|matrix|)) or
    ((|[]|)).
    
    ((<Algebra::Vector>)) is identified with 
    ((<Algebra::MatrixAlgebra>)) of type (({[n, 1]})).

--- Algebra::Vector::new(array)
    Returns the vector of the ((|array|)).

    Example:
      V = Algebra.Vector(Integer, 3)
      a = V.new([1, 2, 3])
      a.display
        #=> [1]
        #=> [2]
        #=> [3]

--- Algebra::Vector::vector{|i| ... }
    Returns the vector of ... as the ((|i|))-th element.

    Example:
      V = Algebra.Vector(Integer, 3)
      a = V.vector{|j| j + 1}
      a.display
        #=> [1]
        #=> [2]
        #=> [3]

--- Algebra::Vector::matrix{|i, j| ... }
    Returns the vector of ... as the ((|i|))-th element.
    ((|j|)) is always 0.

== Methods

--- size
    Returns the dimension.

--- to_a
    Returns the array of elements.

--- transpose
    Transpose to the row vector ((<Algebra::Covector>)).

--- inner_product(other)
    Reurns the inner product with ((|other|)).

--- inner_product_complex(other)
    Reurns the inner product with ((|other|)).
    Same as (({inner_product(other.conjugate)})).

--- norm2
    Return the square of norm.
    Same as (({inner_product(self)})).

--- norm2_complex
    Return the square of norm.
    Same as (({inner_product(self.conjugate)})).

= Algebra::Covector
((*(Row Vector Class)*))

The class of row vectors.

== SuperClass:
* ((|MatrixAlgebra|))

== Included Module

none.

== Associated Functions:

--- Algebra.Covector(ring, n)
    Same as ((<Algebra::Covector::create>))(ring, n).

== Class Methods:

--- Algebra::Covector::create(ring, n)
    Creates the class of the ((|n|))-th dimensional (row) vector
    over the ((|ring|)).

    The return value of this is a subclass of 
    ((<Algebra::MatrixAlgebra::CoVector>)).
    This subclass has the class methods: 
    ((|ground|)) and 
    ((|size|)), whic
    h returns ((|ring|)) and the size 
    ((|n|)) respectively.

    To get actual vectors, use the class methods: ((|new|)), 
    ((|matrix|)) or
    ((|[]|)).
    
    ((<Algebra::Covector>)) is identified with 
    (({[1, n]}))-type 
    ((<Algebra::MatrixAlgebra>)).

--- Algebra::Covector::new(array)
    Returns the row vector of the ((|array|)).

    Example:
      V = Algebra::Covector(Integer, 3)
      a = V.new([1, 2, 3])
      a.display
        #=> [1, 2, 3]

--- Algebra::Covector::covector{|j| ... }
    Returns the vector of ... as the ((|j|))-th element.

    Example:
      V = Algebra.Covector(Integer, 3)
      a = V.covector{|j| j + 1}
      a.display
        #=> [1, 2, 3]

--- Algebra::Covector::matrix{|i, j| ... }
    Returns the vector of ... as the ((|j|))-th element.
    ((|i|)) is always 0.

== Methods:

--- size
    Returns the dimension.

--- to_a
    Returns the array of elements.

--- transpose
    Transpose to the column vector ((<Algebra::Vector>)).

--- inner_product(other)
    Reurns the inner product with ((|other|)).

--- inner_product_complex(other)
    Reurns the inner product with ((|other|)).
    Same as (({inner_product(other.conjugate)})).

--- norm2
    Return the square of norm.
    Same as (({inner_product(self)})).

--- norm2_complex
    Return the square of norm.
    Same as (({inner_product(self.conjugate)})).

= Algebra::SquareMatrix
((*(Class of SquareMatrix)*))

The Ring of Square Matrices over a ring.

== SuperClass:

* ((|Algebra::MatrixAlgebra|))

== Included Module

none.

== Associated Functions:

--- Algebra.SquareMatrix(ring, size)
    Same as ((<Algebra::SquareMatrix.create>))(ring, n).

== Class Methods:

--- Algebra::SquareMatrix::create(ring, n)

    Creates the class of square matrices.

    The return value of this is the subclass of 
    ((<Algebra::SquareMatrix>)).
    This subclass has the class methods ((|ground|)) and
    ((|size|)) which returns ((|ring|)) and the size ((|n|)) respectively.

    ((<Algebra::SquareMatrix>)) is identified 
    with ((<Algebra::MatrixAlgebra::MatrixAlgebra>)) of type 
    (({[n, n]})).

    To get the actual matrices, use the class methods
    ((<Algebra::SquareMatrix::new>)),  
    ((<Algebra::SquareMatrix::matrix>)) or 
    ((<Algebra::SquareMatrix::[]>)).
    
--- Algebra::SquareMatrix.determinant(aa)
    Return the determinat of a array of arrays ((|aa|)).

--- Algebra::SquareMatrix.det(aa)
    Same as ((<Algebra::SquareMatrix.determinat>)).

--- Algebra::SquareMatrix::unity
    Returns the unity.

--- Algebra::SquareMatrix::zero
    Returns the zero.

--- Algebra::SquareMatrix::const(x)
    Returns the scalar matrix with by the diagonal components ((|x|)).

#--- Algebra::SquareMatrix::regulate(x)

== Methods:

--- size
    Returns the dimension.

--- const(x)
    Returns the scalar matrix with the diagonal components ((|x|)).

--- determinant
    Returns the determinant.

--- inverse
    Returns the inverse matrix.

--- /(other)
    Returns (({self * other.inverse})). If ((|other|)) is a schalar,
    divides each entries by ((|other|)).

#--- self.matrices
#--- sign(a)
#--- perm

--- char_polynomial(ring)
    Returns the characteristic polynomial over ((|ring|)).


--- char_matrix(ring)
    Returns the characteristic matrix over ((|ring|)).

--- _char_matrix(poly_ring_matrix)
    Returns the characteristic matrix over ((|poly_ring_matrix|)).

= Algebra::GaussianElimination
((*(Module of Gaussian Elimination)*))

Module of the elimination method of Gauss.

== FileName:
((|gaussian-elimination.rb|))

== Included Module

none.

== Class Method:

none.

== Methods:

--- swap_r!(i, j)
    Swaps ((|i|))-th row and ((|j|))-th row.

--- swap_r(i, j)
    Returns the new matrix with ((|i|))-th row and ((|j|))-th row swapped.

--- swap_c!(i, j)
    Swaps ((|i|))-th column and ((|j|))-th column.

--- swap_c(i, j)
    Returns the new matrix with ((|i|))-th column and ((|j|))-th
    column swapped.

--- multiply_r!(i, c)
    Multiplys the ((|i|))-th row by ((|c|)).

--- multiply_r(i, c)
    Returns the new Matrix with the ((|i|))-th row multiplied
    by ((|c|)).

--- multiply_c!(j, c)
    Multiplys the ((|j|))-th column by ((|c|)).

--- multiply_c(j, c)
    Returns the new Matrix with the ((|j|))-th column multiplied
    by ((|c|)).

--- divide_r!(i, c)
    Divides the ((|i|))-th row by ((|c|)).

--- divide_r(i, c)
    Returns the new Matrix with the ((|i|))-th row divided
    by ((|c|)).

--- divide_c!(j, c)
    Divides the ((|j|))-th column by ((|c|)).

--- divide_c(j, c)
    Returns the new Matrix with the ((|j|))-th column divided
    by ((|c|)).

--- mix_r!(i, j, c)
    Adds the ((|j|))-th row multiplied by ((|c|)) to the ((|i|))-th row.

--- mix_r(i, j, c)
    Returns the new matrix such that
    the ((|j|))-th row multiplied by ((|c|)) is added to
    the ((|i|))-th row.

--- mix_c!(i, j, c)
    Adds the ((|j|))-th column multiplied by ((|c|)) to the ((|i|))-th column.

--- mix_c(i, j, c)
    Returns the new matrix such that
    the ((|j|))-th column multiplied by ((|c|)) is added to
    the ((|i|))-th column.

--- left_eliminate!
    Transform to the step matrix by the left fundamental transformation.
    
    The return value is the array of the square matrix which used to transform,
    its determinant and the ((<rank>)).
    
    Example:
      require "matrix-algebra"
      require "mathn"
      class Rational < Numeric
        def inspect; to_s; end
      end
      M = Algebra.MatrixAlgebra(Rational, 4, 3)
      a = M.matrix{|i, j| i*10 + j}
      b = a.dup
      c, d, e = b.left_eliminate!
      b.display #=> [1, 0, -1]
                #=> [0, 1, 2]
                #=> [0, 0, 0]
                #=> [0, 0, 0]
      c.display #=> [-11/10, 1/10, 0, 0]
                #=> [1, 0, 0, 0]
                #=> [1, -2, 1, 0]
                #=> [2, -3, 0, 1]
      p c*a == b#=> true
      p d       #=> 1/10
      p e       #=> 2

--- left_inverse
    The general inverse matrix obtained by the left fundamental
    transformation.

--- left_sweep
    Returns the step matrix by the left fundamental transformation.

--- step_matrix?
    Returns the array of pivots if ((|self|)) is a step matrix, otherwise
    returns ((|nil|)).

--- kernel_basis
    Returns the array of vector( ((<Algebra::Vector>)) ) such that
    the right multiplication of it is null.

    Example:
      require "matrix-algebra"
      require "mathn"
      M = Algebra.MatrixAlgebra(Rational, 5, 4)
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

--- determinant_by_elimination
    Calculate the determinant by elimination.
    
=end


