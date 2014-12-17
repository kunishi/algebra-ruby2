=begin
[((<index-ja|URL:index-ja.html>))] 
= Algebra::ElementaryDivisor
((*(単因子モジュール)*))

多項式を成分とする行列から単因子を求めるためのモジュールです。
((|MatrixAlgebra|)) クラスにインクルードされます。

== ファイル名:

* ((|elementary-divisor.rb|))

== インクルードしているモジュール:

なし

== 関連する関数:

--- Algebra::MatrixAlgebra#i2o
    多項式成分の行列を行列係数の多項式に変換します。

--- Algebra::MatrixAlgebra#e_deg
    多項式成分の行列の成分の最大次数を返します。

== クラスメソッド:

--- ::factorize(array)
    
    単因子の配列 ((|array|)) をそれぞれ因数分解して、Algebra::Factors
    オブジェクトの配列にして返します。

== メソッド:

--- e_diagonalize!
    掃き出し法により単因子の対角行列に変形する。

--- e_diagonalize
    (({dup.e_diagonalize!})) と同じ。

--- elementary_divisor
    単因子の配列を返す。
    
--- e_inverse
    掃き出し法より、正則行列を求める。
=end
