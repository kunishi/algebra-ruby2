=begin
[((<index-ja|URL:index-ja.html>))] 
= AlgebraicEqation
((*(代数方程式のためのユーティリティー)*))

方程式と体のためのファイル

== ファイル名:
* ((|algebraic-equation.rb|))

== モジュールメソッド:

--- minimal_polynomial(element, poly1[, poly2[, poly3...]])
    (({poly1, poly2, poly3...})) を法とした、((|element|)) の最小多項式
    を求めます。
    
    例: ルート2 + ルート3 + ルート5 の最小多項式を求める。
      PQ = MPolynomial(Rational)
      a, b, c = PQ.vars("abc")
      p AlgebraicEquation.minimal_polynomial(a + b + c, a**2-2, b**2-3, c**2-5)

      #=> x^8 - 40x^6 + 352x^4 - 960x^2 + 576

--- symmetric_product

=end
