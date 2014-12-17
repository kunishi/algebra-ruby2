=begin
[((<index-ja|URL:index-ja.html>))] 
= Algebra::JordanForm
((*(ジョルダン行列クラス)*))

ジョルダン行列を表現するクラスです。

== ファイル名:
* ((|jordan-form.rb|))

== スーパークラス:

* ((|Object|))

== インクルードしているモジュール:

なし

== 関連する関数:

--- Algebra::MatrixAlgebra#jordan_form
    ((|self|))のジョルダン標準形を返します。

--- Algebra::MatrixAlgebra#jordan_form_info
    ((<Algebra::JordanForm.decompose>))(self) と同じです。

== クラスメソッド:

--- ::new(array)
    ((<JordanForm>)) オブジェクトを返します。((|array|)) は、
    (({[対角成分, サイズ]})) を要素とする配列です。行列を得るには
    メソッド ((<to_matrix>)) を施すことにより、（上三角）ジョルダン
    行列が得られます。下三角にするには((<to_matrix_l>))を用います。

    例:
      j = Algebra::JordanForm.new([[2, 3], [-1, 2]])
      j.to_matrix.display #=>
      #  2,   1,   0,   0,   0
      #  0,   2,   1,   0,   0
      #  0,   0,   2,   0,   0
      #  0,   0,   0,  -1,   1
      #  0,   0,   0,   0,  -1

--- ::construct(elem_divs, facts, field, pfield)
    略。

--- ::decompose(m)
    行列 ((|m|)) のジョルダン行列を ((|jm|))、((|m|)) を ((|jm|)) に
    変形するために必要な左変形を ((|tL|))、右変形を ((|sR|))、ジョルダン
    分解をするのに必要な最小分解体を ((|field|)) 、最小分解体まで基礎体
    を拡大するのに必要な方程式の配列を ((|modulus|)) とするとき、

      [jm, tL, sR, field, modulus]

    を返します。（(({tL * sR == 単位行列})) です。）

    例:
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

== メソッド:

--- to_matrix(ring)
    ((|ring|)) 上のジョルダン行列（上三角）を返します。

    例:
      j = Algebra::JordanForm.new([[2, 3], [-1, 2]])
      j.to_matrix(Integer).display #=>
      #  2,   1,   0,   0,   0
      #  0,   2,   1,   0,   0
      #  0,   0,   2,   0,   0
      #  0,   0,   0,  -1,   1
      #  0,   0,   0,   0,  -1

--- to_matrix_r(ring)
    ((<to_matrix>)) と同じ。

--- to_matrix_l(ring)
    ジョルダン行列（下三角）を返します。

=end
