=begin
[((<index-ja|URL:index-ja.html>))] 

= 練習帖

== CONTENTS
* ((<有限集合>))
  * ((<集合>))
  * ((<写像>))
  * ((<群>))
* ((<多項式の計算>))
* ((<多変数多項式の計算>))
* ((<多変数多項式の計算その２>))
* ((<多項式を複数の多項式で割った余りを求める>))
* ((<多項式のグレブナ基底を求める>))
* ((<素体を作る>))
* ((<代数体を作る>))
* ((<商体の生成>))
  * ((<整数環の商体を取って有理数を作る>))
  * ((<有理関数体の生成>))
  * ((<代数拡大体上の有理式の計算>))
  * ((<代数関数体>))
* ((<線形代数>))
  * ((<連立1次方程式を解く>))
  * ((<正方行列の対角化>))
  * ((<行列の単因子を求める>))
  * ((<行列の Jordan 標準形を求める>))
  * ((<Cayley-Hamilton の定理の（次元毎の）証明>))
* ((<グレブナ基底を元の基底で表現する>))
* ((<任意の基底で割った商と余りを求める（余り＝０に意味がある）>))
* ((<因数分解>))
  * ((<整数係数多項式の因数分解>))
  * ((<Zp 係数多項式の因数分解>))
  * ((<有理数の代数拡大上の多項式の因数分解>))
  * ((<有理数の代数拡大の代数拡大上の多項式の因数分解>))
  * ((<x^4 + 10x^2 + 1 の因数分解>))
  * ((<整数、有理係数多変数多項式の因数分解>))
  * ((<Zp 係数多変数多項式の因数分解>))
* ((<代数方程式>))
  * ((<最小多項式>))
  * ((<最小分解体>))
  * ((<多項式のガロア群>))
* ((<初等幾何>))
  * ((<重心の存在>))
  * ((<外心の存在>))
  * ((<垂心の存在>))
  * ((<4 つの等面積>))
* ((<解析>))
  * ((<ラグランジュの乗数法>))

== 有限集合

=== 集合

<<< sample-set01.rb.v.rd

=== 写像

<<< sample-map01.rb.v.rd

=== 群

<<< sample-group01.rb.v.rd

== 多項式の計算

<<< sample-polynomial01.rb.v.rd

== 多変数多項式の計算

<<< sample-polynomial02.rb.v.rd

== 多変数多項式の計算その２

<<< sample-m-polynomial01.rb.v.rd

== 多項式を複数の多項式で割った余りを求める

<<< sample-divmod01.rb.v.rd

== 多項式のグレブナ基底を求める

<<< sample-groebner01.rb.v.rd

== 素体を作る

<<< sample-primefield01.rb.v.rd

== 代数体を作る

<<< sample-algebraicfield01.rb.v.rd

=== これと同じものが次の様に書ける。

<<< sample-algebraicfield02.rb.v.rd

=== ルートの計算

<<< sample-algebraic-root01.rb.v.rd

== 商体の生成

=== 整数環の商体を取って有理数を作る

<<< sample-quotientfield01.rb.v.rd

=== 有理関数体の生成

<<< sample-quotientfield02.rb.v.rd

=== 代数拡大体上の有理式の計算

<<< sample-quotientfield03.rb.v.rd

=== 代数関数体

<<< sample-quotientfield04.rb.v.rd

== 線形代数

=== 連立1次方程式を解く

<<< sample-gaussian-elimination01.rb.v.rd

=== 正方行列の対角化

<<< sample-diagonalization01.rb.v.rd >>>

=== 行列の単因子を求める

<<< sample-elementary-divisor01.rb.v.rd

=== 行列の Jordan 標準形を求める

<<< sample-jordan-form01.rb.v.rd

=== Cayley-Hamilton の定理の（次元毎の）証明

<<< sample-cayleyhamilton01.rb.v.rd

== グレブナ基底を元の基底で表現する

<<< sample-groebner02.rb.v.rd

== 任意の基底で割った商と余りを求める（余り＝０に意味がある）

<<< sample-groebner03.rb.v.rd

== 因数分解

=== 整数係数多項式の因数分解

<<< sample-factorize01.rb.v.rd

=== Zp 係数多項式の因数分解

<<< sample-factorize02.rb.v.rd

=== 有理数の代数拡大上の多項式の因数分解

<<< sample-factorize03.rb.v.rd

=== 有理数の代数拡大の代数拡大上の多項式の因数分解

<<< sample-factorize04.rb.v.rd

=== x^4 + 10x^2 + 1 の因数分解

<<< sample-factorize05.rb.v.rd

=== 整数、有理係数多変数多項式の因数分解

<<< sample-m-factorize01.rb.v.rd

=== Zp 係数多変数多項式の因数分解

<<< sample-m-factorize02.rb.v.rd

== 代数方程式

=== 最小多項式

<<< sample-algebraic-equation01.rb.v.rd

=== 最小分解体

<<< sample-splitting-field01.rb.v.rd

=== 多項式のガロア群

<<< sample-galois-group01.rb.v.rd

== 初等幾何

=== 重心の存在

<<< sample-geometry01.rb.v.rd

=== 外心の存在

<<< sample-geometry02.rb.v.rd

#=== 内心の存在

#<<< sample-geometry03.rb.v.rd

=== 垂心の存在

<<< sample-geometry04.rb.v.rd


=== 4 つの等面積
see ((<URL:http://www1.odn.ne.jp/drinkcat/topic/column/quest/quest_2/quest_2.html>)) Question 3.

<<< sample-geometry07.rb.v.rd

== 解析
=== ラグランジュの乗数法
<<< sample-lagrange-multiplier01.rb.v.rd

=end
