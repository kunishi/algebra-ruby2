=begin
[((<index-ja|URL:index-ja.html>))] 
= Algebra::EuclidianRing

((*(G.C.D.計算モジュール)*))

((|divmod|)) から G.C.D(最大公約数)等を計算するモジュールです。
これは ((|Integer|)) や ((|Algebra::Polynomial|)) にインクルードされます。

== ファイル名:
* ((|euclidian-ring.rb|))

== メソッド:

--- gcd(other)
    ((|self|)) と ((|other|)) との最大公約数を返します。

--- gcd_all(other0 [, other1[, ...]])
    ((|self|)) と ((|other0|)), ((|other1|)),... との最大公約数を返します。

--- gcd_coeff(other)
    ((|self|)) と ((|other|)) との最大公約数と、それを表現する係数の
    配列を返します。
    
    例:
      require "polynomial"
      require "rational"
      P = Algebra.Polynomial(Rational, "x")
      x = P.var
      f = (x + 2) * (x**2 - 1)**2
      g = (x + 2)**2 * (x - 1)**3
      gcd, a, b = f.gcd_coeff(g)
      p gcd #=> 4x^3 - 12x + 8
      p a   #=> -x + 2
      p b   #=> x - 1
      p gcd == a*f + b*g #=> true

--- gcd_ext(other)
    ((<gcd_coeff>)) と同じです。

--- gcd_coeff_all(other0 [, other1[, ...]])
    ((|self|)) と ((|other0|)), ((|other1|)),... との最大公約数と、それ
    を表現する係数の配列を返します。

    例:
      require "polynomial"
      require "rational"
      P = Algebra.Polynomial(Rational, "x")
      x = P.var
      f = (x + 2) * (x**2 - 1)**2
      g = (x + 2)**2 * (x - 1)**3
      h = (x + 2) * (x + 1) * (x - 1)
      gcd, a, b, c = f.gcd_coeff_all(g, h)
      p gcd #=> -8x^2 - 8x + 16
      p a   #=> -x + 2
      p b   #=> x - 1
      p c   #=> -4
      p gcd == a*f + b*g + c*h #=> true

--- gcd_ext_all(other)
    ((<gcd_coeff_all>)) と同じです。

--- lcm(b)
    ((|self|)) と ((|other|)) との最小公倍数を返します。

--- lcm_all(other0 [, other1[, ...]])
    ((|self|)) と ((|other0|)), ((|other1|)),... との最小公倍数を返します。

=end
