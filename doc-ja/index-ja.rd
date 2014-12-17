=begin
[((<README-ja|URL:README-ja.html>))]  [((<English|URL:../doc/index.html>))]
= 代数パッケージ

  Version: 0.72  (2006.09.16)
  Author: 原 信一郎 (sinara@blade.nagaokaut.ac.jp)

  これは１変数あるいは多変数の多項式を計算するためのライブラリです。

== 0. 最初の一歩

最も簡単な利用法は require "algebra" として、計算を始めることです。

  require "algebra"
  x = Polynomial(Integer, "x").var
  puts( (x+1)**7 )
    #=> x^7 + 7x^6 + 21x^5 + 35x^4 + 35x^3 + 21x^2 + 7x + 1
  puts( (x**7 + 7*x**6 + 21*x**5 + 35*x**4 + 35*x**3 + 21*x**2 + 7*x + 1).factorize )
    #=> (x + 1)^7
  
== 1. 例題

 * ((<Samples|URL:samples-ja.html>))

== 2. 主なクラス・モジュール

 * ((<Algebra|URL:algebra-ja.html>)) (代数モジュール)
   * ((<Algebra::Polynomial|URL:polynomial-ja.html>)) (1変数多項式環クラス)
   * ((<Algebra::EuclidianRing|URL:euclidian-ring-ja.html>)) (ユークリッド環モジュール)
   * ((<Algebra::MPolynomial|URL:m-polynomial-ja.html>)) (多変数多項式環クラス)
   * ((<Algebra::ResidueClassRing|URL:residue-class-ring-ja.html>)) (剰余環クラス)
   * ((<Algebra::AlgebraicExtensionField|URL:algebraic-extension-field-ja.html>)) (代数拡大体クラス)
   * ((<Algebra::LocalizedRing|URL:localized-ring-ja.html>)) (局所化環クラス)
   * ((<Algebra::MatrixAlgebra|URL:matrix-algebra-ja.html>)) (行列代数クラス)
   * ((<Algebra::AlgebraicParser|URL:algebraic-parser-ja.html>)) (代数式を表す文字列の評価クラス)
   * ((<Algebra::Set|URL:finite-set-ja.html>)) (集合のクラス)
   * ((<Algebra::Map|URL:finite-map-ja.html>)) (写像のクラス)
   * ((<Algebra::Group|URL:finite-group-ja.html>)) (群のクラス)
   * ((<Algebra::PermutationGroup|URL:permutation-group-ja.html>)) (置換群のクラス)
== 3. その他

 * ((<Algebra::ElementaryDivisor|URL:elementary-divisor-ja.html>)) (単因子モジュール)
 * ((<Algebra::JordanForm|URL:jordan-form-ja.html>)) (ジョルダン行列クラス)
 * ((<Algebra::MatrixAlgebraTriplet|URL:matrix-algebra-triplet-ja.html>)) (3つ組行列のクラス)
 * ((<代数方程式ハンドルユーティリティー|URL:algebraic-equation-ja.html>))
 * ((<多項式環相互変換ユーティリティー|URL:polynomial-converter-ja.html>))

== 4. パッケージ内容

=== 総合
  algebra.rb             Algebra ライブラリ一般利用ファイル

=== 一変数関係
  polynomial.rb          １変数多項式環のクラス
  euclidian-ring.rb      ユークリッド整域ユティリティー(G.C.D.の計算)
  polynomial-factor.rb   １変数多項式因数分解ライブラリ
    polynomial-factor-int.rb   整数係数版
    polynomial-factor-zp.rb    Zp係数版
    polynomial-factor-alg.rb   代数的数係数版

=== 多変数関係
  m-polynomial.rb         多変数多項式環のクラス
    m-index.rb            m-polynomial.rb の下請け
  m-polynomial-factor.rb   １変数多項式因数分解ライブラリ
    m-polynomial-factor-int.rb   整数係数版
    m-polynomial-factor-zp.rb    Zp係数版
  groebner-basis.rb       グレブナ基底の計算モジュール
  groebner-basis-coeff.rb 除算の計算モジュール

=== 代数全般
  localized-ring.rb       商体作成ライブラリ
  matrix-algebra.rb       行列代数のクラス
    elementary-divisor.rb 単因子操作モジュール
    matrix-algebra.triplete.rb  3つ組行列クラス
    jordan-form.rb        ジョルダン行列クラス
  residue-class-ring.rb   多項式環の剰余環
  algebraic-extention-field.rb 代数拡大体
  splitting-field.rb      多項式の最小分解体
  galois-group.rb         Galois 群
  linear-algebra.rb       線形代数ライブラリ
  algebraic-equation.rb   代数方程式ライブラリ

=== 基礎部分

  finite-set.rb           集合のクラス
    finite-map.rb         写像のクラス
    finite-group.rb       群のクラス
      permutation-group.rb  置換群のクラス

=== 共通部分
  prime-gen.rb            素数生成クラス
  numeric-supplement.rb   Numeric の補完
  polynomial-converter.rb 多項式環相互変換ユーティリティー
  algebra-system.rb       代数系の共通仕様
  algebraic-parser.rb     多元環の式の文字列表現を評価するモジュール

=== その他
  array-supplement.rb     Array の補完
  doc-ja/                 マニュアル日本語版(RD, HTML, TXT)
  doc/                    マニュアル英語版(RD, HTML, TXT)
  sample/                 サンプルコード
  work/                   （開発作業場所）

== 5. ToDo
#<<< todo.rd
* ((<todo.html|URL:todo.html>))

== 6. Changes
#<<< changes.rd
* ((<changes.html|URL:changes.html>))

=end
