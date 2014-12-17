=begin
= 代数パッケージ

2006.09.16

*Version: 0.72
*著者: 原 信一郎
*e-mail: sinara@blade.nagaokaut.ac.jp
*Home Page: ((<URL:http://blade.nagaokaut.ac.jp/~sinara/ruby/math/>))

== これは、、、

1変数あるいは多変数の多項式を計算するためのライブラリです。
数学的対象を自然に Ruby で表現可能にする事を目的にしています。
スピードはありませんが、スクリプト言語なのでアルゴリズムを見る事
ができます。

* 一変数多項式
  * 加法、乗法、商／剰余等の演算
  * 因数分解
  * Galois 群
* 多変数多項式
  * 加法、乗法等の演算
  * 因数分解
  * グレブナ基底の生成、グレブナ基底による商／剰余の演算
* 代数系
  * 商体の生成
  * 剰余環の生成
  * 行列環の生成
  * 置換群の計算
* 集合と写像

== インストール

このパッケージを利用するにはまず、オブジェクト指向スクリプト言語 Ruby 
(((<URL:http://www.ruby-lang.org/>))参照) が必要です。

更に、アーカイブの展開後

  ruby install.rb

とすれば、lib ディレクトリ以下を、ロード可能なディレクトリにコピーし、
インストールが完了します。

速度の点から、有理数は標準添付の rational.rb ではなく、拡張ライブラリ
(((<URL:http://blade.nagaokaut.ac.jp/~sinara/ruby/rational/>))
を使うことを勧めます。

== 使い方・サンプル

doc ディレクトリの ((<index-ja.html|URL:index-ja.html>)) を見てください。
マニュアルやサンプルがあります。

== 参考
* D.コックス, J.リトル and D.オシー, "グレブナ基底と代数多様体入門（上・下）",
  2000,シュプリンガー・フェアラーク東京
* 児玉宏児, "Polynomial", ((<URL:http://www.math.kobe-u.ac.jp/HOME/kodama/tips-RubyPoly.html>))
* H.Anai, M.Noro and K.Yokoyama, "Computation of the splitting fields and the Galois groups of polynomials", Progres in Mathematics, 28-50, Vo.143, 1996

=end
