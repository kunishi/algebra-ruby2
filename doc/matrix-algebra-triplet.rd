=begin
[((<index|URL:index.html>))] 
((<Algebra::MatrixAlgebraTriplet>))
/
((<Algebra::MatrixAlgebraQuint>))


= Algebra::MatrixAlgebraTriplet

((*(Class of Triplet of matrices)*))

This is the class of the matrix and the records of the right and
left elementary diformations on it. There is a subclass of the quintet
of matrices (((<Algebra::MatrixAlgebraQuint>))).

== File Name:
* ((|matrix-algebra-triplet.rb|))

== SuperClass:

* ((|Object|))

== Included Modules:
* ((|GaussianElimination|))
* ((|ElementaryDivisor|))

=== Class Methods:

--- :new(matrix[, left[, right]])
    Creates the triplet object of ((|matrix|)) as the body, 
    ((|left|)) as the record of the left(row) deformation and
    ((|right|)) as the record ofthe right(column) deformation.

== Methods:

--- body
    Returns the body.

--- left
    Returns ((|left|)) as the record of the left(row) deformation.

--- right
    Returns ((|right|)) as the record ofthe right(column) deformation.

--- to_a
    Retruns the array of (({[body, left, right]})).

--- to_ary
    Same as ((<to_a>)).

--- dup
    Returns the duplicate of ((|self|)).

--- transpose
    Returns the transpose of ((|self|)). Same as
    
      [type.new(body.transpose, right.transpose, left.transpose].

--- replace(other)
    Replaces ((|self|)) to ((|other|)).

--- display
    Displays ((|self|))

--- [](i, j)
    Returns the componetnt of (({(i, j)})).

--- rsize
    Returns the row size.

--- csize
    Return the column size.

--- each_i
    Iterates for the row index.

--- each_j
    Iterates for the column index.

--- row!(i)
    Retunrs the ((|i|)) -th row.
    
--- sswap_r!(i, j)

--- swap_r!(i, j)

--- swap_c!(i, j)

--- multiply_r!(i, c)

--- multiply_c!(j, c)

--- divide_r!(i, c)

--- divide_c!(j, c)

--- mix_r!(i, j[, c])

--- mix_c!(i, j[, c])

--- left_eliminate!
    Refer ((<Algebra::GauusianElimination|URL:matrix-algebra.html#label:96>)).

= Algebra::MatrixAlgebraQuint

((*(Class of Quintet of matrices)*))

This is the class of the matrix and the records of the right and
left elementary diformations on it and the reverses of them.
There is a superclass of the triplet
of matrices (((<Algebra::MatrixAlgebraTriplet>))).

== SuperClass:

* ((|Algebra:MatrixAlgebraTriplet|))

== Methods:

--- lefti
    Returns the inverse of ((<left>)).

--- righti
    Returns the inverse of ((<right>)).

--- to_a
    Reutrns (({[body, left, right, lefti, righti]})).

=end
