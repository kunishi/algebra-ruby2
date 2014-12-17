=begin
((<Algebra>))

= Algebra
((*(代数モジュール)*))

代数ライブラリ 

* ((<Algebra::Polynomial|URL:polynomial-ja.html>)) (1変数多項式環クラス)
* ((<Algebra::MPolynomial|URL:m-polynomial-ja.html>)) (多変数多項式環クラス)
* ((<Algebra::ResidueClassRing|URL:residue-class-ring-ja.html>)) (剰余環クラス)
* ((<Algebra::LocalizedRing|URL:localized-ring-ja.html>)) (局所化環クラス)
* ((<Algebra::MatrixAlgebra|URL:matrix-algebra-ja.html>)) (行列代数クラス)
* etc.

などをまとめているモジュールです。

== 関連するファイル:
* (({require "algebra.rb"})) をしておくと、

    include Algebra

  がなされ、これらのモジュールが記述されたファイルを適宜 (({require})) します。

== スーパークラス:

* ((|Object|))

== インクルードしているモジュール:

なし

== クラスメソッド:

--- Algebra.Polynomial(ring [, obj0 , obj1 [, ...]])
    ((<Algebra.Polynomial|URL:polynomial-ja.html#Algebra_S_Polynomial>))() 参照。

--- Algebra.MPolynomial(ring [, obj0 [, obj1 [, ...]]])
    ((<Algebra.MPolynomial|URL:m-polynomial-ja.html#Algebra_S_MPolynomial>))() 参照。

--- Algebra.ResidueClassRing(ring, mod)
    ((<Algebra.ResidueClassRing|URL:residue-class-ring-ja.html#Algebra_S_ResidueClassRing>))() 参照。

--- Algebra.AlgebraicExtensionField(field, obj){|x| ... }
    ((<Algebra.AlgebraicExtensionField|URL:residue-class-ring-ja.html#Algebra_S_AlgebraicExtensionField>))() 参照。

--- Algebra.MatrixAlgebra(ring, m, n)
    ((<Algebra.MatrixAlgebra|URL:matrix-algebra-ja.html#Algebra_S_MatrixAlgebra>))(ring, m, n) 参照。

--- Algebra.Vector(ring, n)
    ((<Algebra.Vector|URL:matrix-algebra-ja.html#Algebra_S_Vector>))(ring, n) 参照。

--- Algebra.Covector(ring, n)
    ((<Algebra.Covector|URL:matrix-algebra-ja.html#Algebra_S_Covector>))(ring, n) 参照。

--- Algebra.SquareMatrix(ring, size)
    ((<Algebra.SquareMatrix|URL:matrix-algebra-ja.html#Algebra_S_SquareMatrix>))(ring, n) 参照。


=end
