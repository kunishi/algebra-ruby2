=begin
= Changes
== 0.71(2005.07.26)
* MPolynomial#derivate
* MPolynomial#map_to

== 0.70(2005.02.02)
* id => object_id

== 0.69(2004.10.15)
* MRationalFunctionField
* MPolynomial#gcd
* SquareMatrix#inverse depends on ufd?

== 0.68(2004.07.28)
* fix Mpolynomial#to_s (for tex)

== 0.67(2004.06.10)
* need_paren_in_coeff?
* Matrix: entries are regulated.
* Matrix: type*type is due to wedge.
* AlgebraicSystem: wedge, superior?
* Polynomial#sub, MPolynomial#sub
* SquareMatrix.determinant
* fix MPolynomial#to_s
* fix Factors#normalize!
* (Co)Vector#norm2, inner_product

== 0.66(2004.06.05)
* fix _hensel_lift (add param 'where')
* sample-geometry01.rb
* title of docs

== 0.65(2004.06.04)
* Polynomial#factor over Polynomial
* reverse var's order in value_on & convert_to in polynomial-convert.rb

== 0.64(2004.03.01)
* return value of SquareMatrix#diagonalize is Strut

== 0.63(2004.01.08)
* fix matrix[i, j] = x

== 0.62(2003.11.13)
* allow f.gcd_coeff_all()

== 0.61(2003.11.06)
* corrected Enumerable#any? in finite-set.rb

== 0.60(2003.07.28)
* AlgebraMatrix(cofactor, cofactor_matrix, adjoint)

== 0.59(2003.07.28)
* adapted to the version 1.8.0(preview 4)
* include installer

== 0.58(2002.04.00)
* AlgebraicExtensionField#[n] is lift[n]
* abolish the field of 'poly_exps' of the splitting field' and add 'proots'
* MatrixAlgebra#rank
* Raise Exception for the inverse of the non invertible square matrix
* Use "import-module" for monomial order (0.57.18.01)

== 0.57 (2002.03.16)
* New class
  * Set
  * Map
  * Group
  * PermuationGroup
  * AlgebraicExtensionField
* New methods
  * Galois#group
  * Polynomial#splitting_field
* Rename MinimalDecompositionField to decompose
* Move *.rb to lib/
* Define Polynomial.to_ary and MPolynomial.to_ary

== 0.56 (2002.02.06)
* MPolynomial#with_ord
* Orderings belong to MPolynomial.
* MIndex is not a subclass of Array, now.
* "Integer < Numeric" ==> "Integer"

== 0.55 (2001.11.15)
* Improve Algorithm of Factorization over algebraic fields

== 0.54 (2001.11.05)
* Elementary Divisor
* Jordan Form
* Minimal Decomposition Field

== 0.53 (2001.10.03)

* move "MatrixAlgebra" to "Algebra::MatrixAlgebra"
* move "MatrixAlgebra::Vector" to "Algebra::Vector"
* move "MatrixAlgebra::Covector" to "Algebra::Covector",
* move "MatrixAlgebra::SquareMatrix" to "Algebra::SquareMatrix"

== 0.52 (2001.09.22)

* One-variate polynomial
  * Fundamental operations (addition, multiplication, quotient/remainder, ...)
  * factorization
* Multi-variate polynomial
  * Fundamental operations (addition, multiplication, ...)
  * factorization
  * Creating Groebner-basis, quotient/remainder by Groebner-basis.
* Algebraic systems
  * Creating quotient fields
  * Creating residue class fields
  * Operating matrices.
* Linear Algebra
  * Diagonalization of Symmetrix Matrix

== 0.40 (2001.03.03)

* Initial Version

=end
