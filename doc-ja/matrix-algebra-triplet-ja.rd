=begin
[((<index-ja|URL:index-ja.html>))] 
((<Algebra::MatrixAlgebraTriplet>))
/
((<Algebra::MatrixAlgebraQuint>))


= Algebra::MatrixAlgebraTriplet

((*(3つ組行列のクラス)*))

行列と行列に対する左右の基本変形を記録した2つの行列を表すクラス。下位クラス
に5つ組みクラス ((<Algebra::MatrixAlgebraQuint>)) がある。

== ファイル名:
* ((|matrix-algebra-triplet.rb|))

== スーパークラス:

* ((|Object|))

== インクルードしているモジュール:
* ((|GaussianElimination|))
* ((|ElementaryDivisor|))


=== クラスメソッド:

--- :new(matrix[, left[, right]])
    ((|matrix|)) を本体、((|left|))左（行）変形の記録、((|right|))
    を右（列）変形の記録とする3つ組みオブジェクトを生成します。

== メソッド:

--- body
    本体を返します。

--- left
    左（行）変形の記録を返します。

--- right
    右（列）変形の記録を返します。

--- to_a
    (({[body, left, right]})) という配列を返します。

--- to_ary
    ((<to_a>)) と同じ。

--- dup
    自身の複製を返します。

--- transpose
    転置行列を返します。
    
      [type.new(body.transpose, right.transpose, left.transpose]

    と同じです。

--- replace(other)
    自分を ((|other|)) と置き換えます。

--- display
    自分を表示します。

--- [](i, j)
    自分の (({(i, j)})) 成分を返します。

--- rsize
    行サイズを返します。

--- csize
    列サイズを返します。

--- each_i
    すべての行インデックスに対して繰り返すイテレータです。

--- each_j
    すべての列インデックスに対して繰り返すイテレータです。

--- row!(i)
    本体の ((|i|)) 行目そのものを返します。
    
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
    以上、((|Algebra::GauusianElimination|)) の同名メソッドを参照。


= Algebra::MatrixAlgebraQuint

((*(5つ組行列のクラス)*))

行列と行列に対する左右の基本変形、それらの逆行列を記録した計5つの
行列を表すクラス。上位クラスに3つ組みクラス ((<Algebra::MatrixAlgebraTriplet>)) がある。

== スーパークラス:

* ((|Algebra:MatrixAlgebraTriplet|))


== メソッド:

--- lefti
    ((<left>)) の逆行列を返します。

--- righti
    ((<right>)) の逆行列を返します。

--- to_a
    (({[body, left, right, lefti, righti]})) という配列を返します。

=end
