=begin
= Algebra::AlgebraicParser
((*(文字列の代数的評価クラス)*))

== ファイル名:
* ((|algebraic-parser.rb|))

== スーパークラス:

* ((|Object|))

== インクルードしているモジュール:

なし

== クラスメソッド:
--- Algebra::AlgebraicParser.eval(string, ring)
    ((|string|)) の四則演算式を ((|ring|)) 上で計算します。

== メソッド:

なし

== 仕様

=== 評価の手順

変数の値は、その変数名を引数として ((|ring|)) のクラスメソ
ッド ((|indeterminate|)) の引数として渡され、その戻り値
として評価されます。また数値は ((|ring.ground|)) のクラス
メソッド ((|indterminate|)) で評価されます。

      require "algebraic-parser"
      class A
        def self.indeterminate(str)
          case str
          when "x"; 7
          when "y"; 11
          end
        end
        def A.ground
          Integer
        end
      end
      p Algebraic::AlgebraicParser.eval("x * y - x^2 + x/8", A)
          #=> 7*11 - 7**2 + 7/8 = 28
      
ここで、Integer の indeterminate は algebraic-parser.rb が require
している algebra-supplement.rb で次のように定義されています。
    
        def Integer.indeterminate(x)
          eval(x)
        end
      
=== 識別子
識別子は、「英字1文字＋数字0文字以上」で定義されます。したがって

        "a13bc04def0"
      
は、

        "a13 * b * c04 * d * e * f0"

と解釈されます。

=== 演算子
演算子を結合の弱い順に並べます。

  ;       中間評価
  +, -    和, 差
  +, -    単項 +, 単項 -
  *, /    積, 商
  並置    積
  **, ^   冪

=== 用例
クラス ((|Algebra::Polynomial|))、クラス ((|Algebra::MPolynomial|)) には適
切に ((|indeterminate|)), ((|ground|))
が定義されています。したがって次のように文字列評価ができます。

      require "algebraic-parser"
      require "rational"
      require "m-polynomial"
      F = Algebra::MPolynomial(Rational)
      p Algebra::AlgebraicParser.eval("- (2*y)**3 + x", F) #=> -8y^3 + x

((|Algebra::MPolynomial|)) では、((|indeterminate|)) は変数を表現するオブジェ
クトの登録も行うので、登録順が変数間の順序になります。したがって ; を
使って先に変数を評価させる事によって、順序の変更をする事ができます。

      F.variables.clear
      p Algebra::AlgebraicParser.eval("x; y; - (2*y)**3 + x", F) #=> x - 8y^3

=end

