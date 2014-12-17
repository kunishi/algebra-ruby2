=begin
((<Algebra>))

= Algebra
((*(Module for Algebra)*))

This is a module containing:

* ((<Algebra::Polynomial|URL:polynomial.html>))
* ((<Algebra::MPolynomial|URL:m-polynomial.html>))
* ((<Algebra::ResidueClassRing|URL:residue-class-ring.html>))
* ((<Algebra::LocalizedRing|URL:localized-ring.html>))
* ((<Algebra::MatrixAlgebra|URL:matrix-algebra.html>))
* etc.

== Asocciated Files:
* Let (({require "algebra.rb"})) then

    include Algebra

  has done. And (({require})) the scripts defining above modules, automatically.

== SuperClass:

* ((|Object|))

== Included Modules:

none.

== ClassMethods:

--- Algebra.Polynomial(ring [, obj0 , obj1 [, ...]])
    Refer ((<Algebra.Polynomial|URL:polynomial.html#Algebra_S_Polynomial>))().

--- Algebra.MPolynomial(ring [, obj0 [, obj1 [, ...]]])
    Refer ((<Algebra.MPolynomial|URL:m-polynomial.html#Algebra_S_MPolynomial>))().

--- Algebra.ResidueClassRing(ring, mod)
    Refer ((<Algebra.ResidueClassRing|URL:residue-class-ring.html#Algebra_S_ResidueClassRing>))()

--- Algebra.AlgebraicExtensionField(field, obj){|x| ... }
    Refer ((<Algebra.AlgebraicExtensionField|URL:residue-class-ring.html#Algebra_S_AlgebraicExtensionField>))().

--- Algebra.MatrixAlgebra(ring, m, n)
    Refer ((<Algebra.MatrixAlgebra|URL:matrix-algebra.html#Algebra_S_MatrixAlgebra>))(ring, m, n).

--- Algebra.Vector(ring, n)
    Refer ((<Algebra.Vector|URL:matrix-algebra.html#Algebra_S_Vector>))(ring, n).

--- Algebra.Covector(ring, n)
    Refer ((<Algebra.Covector|URL:matrix-algebra.html#Algebra_S_Covector>))(ring, n).

--- Algebra.SquareMatrix(ring, size)
    Refer ((<Algebra.SquareMatrix|URL:matrix-algebra.html#Algebra_S_SquareMatrix>))(ring, n).


=end
