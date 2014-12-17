=begin
[((<index|URL:index.html>))] 
= Algebra::JordanForm
((*(Jordan Matrix)*))

This class expresses the Jordan canonical matrix. 

== File Name:
* ((|jordan-form.rb|))

== SuperClass:

* ((|Object|))

== Included Modules

none.

== Associated Functions:

--- Algebra::MatrixAlgebra#jordan_form
    Returns the Jordan matrix of ((|self|)).

--- Algebra::MatrixAlgebra#jordan_form_info
    Same as ((<Algebra::JordanForm.decompose>))(self).

== Class Methods:

--- ::new(array)
    Returns a instance of ((<JordanForm>)).
    ((|array|)) is the array of the pair of (({[diagonal component, size]})).
    To get the matrix expression, apply ((<to_matrix>)) for the upper 
    triaglular matrix or ((<to_matrix_l>)) for the lower.

    Exampe:
      j = Algebra::JordanForm.new([[2, 3], [-1, 2]])
      j.to_matrix.display #=>
      #  2,   1,   0,   0,   0
      #  0,   2,   1,   0,   0
      #  0,   0,   2,   0,   0
      #  0,   0,   0,  -1,   1
      #  0,   0,   0,   0,  -1

--- ::construct(elem_divs, facts, field, pfield)
    abbreviate.

--- ::decompose(m)
    Returns the array:

      [jm, tL, sR, field, modulus]

    where ((|jm|)) is the Jordan matrix of ((|m|)),
    ((|tL|)) and ((|sR|)) are the left and right deformation matrix
    from ((|m|)) to((|jm|)),
    ((|field|)) is the mimimal decompostion field to Jordan decompose and
    ((|modulus|)) is the polynomials to the algebraic extention.
    ((({tL * sR == the identity matrix})))

    Example:
      m = Algebra.SquareMatrix(Rational, a.size)[
       [-1, 1, 2, -1],
       [-5, 3, 4, -2],
       [3, -1, 0, 1],
       [5, -2, -2, 0]
      ]
      jf, p, q, field, modulus = Algebra::JordanForm.decompose(m)
      jf.display; puts #=>
      #  2,   0,   0,   0
      #  0,   a,   0,   0
      #  0,   0,   b,   0
      #  0,   0,   0, -b - a

      p modulus #=> [a^3 + 3a - 1, b^2 + ab + a^2 + 3]

      print "P =\n"; p.display; puts
      print "P^-1 =\n"; q.display; puts

      m = m.convert_to(field)
      p jf == p * m * q #=> true

== Methods:

--- to_matrix(ring)
    Returns the upper triangular Jordan matrix over ((|ring|)).

    Example:
      j = Algebra::JordanForm.new([[2, 3], [-1, 2]])
      j.to_matrix(Integer).display #=>
      #  2,   1,   0,   0,   0
      #  0,   2,   1,   0,   0
      #  0,   0,   2,   0,   0
      #  0,   0,   0,  -1,   1
      #  0,   0,   0,   0,  -1

--- to_matrix_r(ring)
    Same as ((<to_matrix>)).

--- to_matrix_l(ring)
    Returns the lower triangular Jordan matrix over ((|ring|)).

=end
