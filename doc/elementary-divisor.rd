=begin
[((<index|URL:index.html>))] 
= Algebra::ElementaryDivisor
((*(Elementary Divisor Module)*))

Module to get the elementary divisors of the matrix of polynomial.
This is included by the class ((|Algebra::MatrixAlgebra|)).

== File Name:

* ((|elementary-divisor.rb|))

== Included Modules:

none.

== Associated Functions:

--- Algebra::MatrixAlgebra#i2o
    Converts the matrix of polynomials into the polynomial of matrices.

--- Algebra::MatrixAlgebra#e_deg
    Returns the max degree of the matrix of polynomials.

== Class Methods:

--- ::factorize(ary)
    
    Returns the array of the factors (instances of ((|Algebra::Factors|))),
    factorizing the each entries of the array ((|ary|))
    of the elementary divisors of a matrix.

== Methods:

--- e_diagonalize!
    Deforms to the diagonal matrix of the elementary divisors.
    If can't, raise an error.

--- e_diagonalize
    Same as (({dup.e_diagonalize!})).

--- elementary_divisor
    Returns the array of the elementary divisors.
    
--- e_inverse
    Returns the inverse matrix of the matrix over Euclidian ring.
    If can't, raise an error.

=end
