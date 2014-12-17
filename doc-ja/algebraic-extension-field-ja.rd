=begin
[((<index-ja|URL:index-ja.html>))] 

= AlgebraicExtensionField
((*(代数拡大体)*))

代数拡大体を表現するクラス

== ファイル名:
* ((|algebraic-Extension-feild.rb|))

== スーパークラス:

* ((|ResidueClassRing|))

== インクルードしているモジュール:

なし。

== 関連するメソッド:

--- Algebra.AlgebraicExtensionField(field, obj){|x| ... }
    ((<::create>)) と同じ。

== クラスメソッド:

--- ::create(k, obj){|x| p(x) }
    体 ((|k|)) を、((|obj|)) で表される変数 ((|x|)) の多項式
    ((|p(x)|)) で拡大した環 ((|k[x]/(p(x))|))を返します。
    この環には、クラスメソッド ((<::var>))、((<::def_polys>))、
    ((<::env_ring>)) が定義されます。

    
    例: 有理数を方程式 (({x**2 + x + 1 == 0})) で拡大した体 F を作る。
      require "rational"
      require "algebraic-extension-field"
      F = Algebra::AlgebraicExtensionField.create(Rational, "x") {|x| x**2 + x + 1}
      x = F.var
      p( (x-1)** 3 / (x**2 - 1) ) #=> -3x - 3

--- ::to_ary
    (({[self, var]})) を返します。

    例: 代数拡大体と添加元を同時に定義する
      require "rational"
      require "algebraic-extension-field"
      F, a = Algebra.AlgebraicExtensionField(Rational, "a") {|a| a**2 + a + 1}

--- ::var
    ((<::create>)) の返り値 ((|k[x]/(p(x))|)) に定義され、
    この剰余環における ((|x|)) で
    代表される剰余類を返します。

--- ::modulus
    ((<::create>)) の返り値 ((|k[x]/(p(x))|)) に定義され、((|k[x]|)) 
    の要素 ((|p(x)|))  を返します。

--- ::def_polys
    ((<::create>)) の返り値 ((|k[x]/(p(x))|)) に定義され、
    長さ ((|n|)) の各 ((<::modulus>)) の配列を返します。
    ここで、自身は、基礎体 ((|k0|)) 上高さ ((|n|)) の
    再帰的な ((|AlgebraicExtensionField|)) であるとします。


    例: 基礎体を有理数とし、2, 3, 5 の立方根による拡大体を作る
      require "algebra"
      # K0 == Rational
      K1 = AlgebraicExtensionField(Rational, "x1") { |x|
        x ** 3 - 2
      }
      K2 = AlgebraicExtensionField(K1, "x2") { |y|
        y ** 3 - 3
      }
      K3 = AlgebraicExtensionField(K2, "x3") { |z|
        z ** 3 - 5
      }

      p K3.def_polys #=> [x1^3 - 2, x2^3 - 3, x3^3 - 5]

      x1, x2, x3 = K1.var, K2.var, K3.var
      f = x1**2 + 2*x2**2 + 3*x3**2
      f0 = f.abs_lift

      p f0.type     #=> (Polynomial/(Polynomial/(Polynomial/Rational)))
      p f0.type == K3.env_ring #=> true

      p f #=> 3x3^2 + 2x2^2 + x1^2
      p f0.evaluate(x3.abs_lift, x2.abs_lift, x1.abs_lift)
          #=> x3^2 + 2x2^2 + 3x3^2


--- ::env_ring
    ((<::create>)) の返り値 ((|k[x]/(p(x))|)) に定義され、
    多変数多項式環 ((|k0[x1, x2,.., xn]|)) を返します。
    ここで、自身は、基礎体 ((|k0|)) 上高さ ((|n|)) の
    再帰的な ((|AlgebraicExtensionField|)) であるとします。

--- ::ground
    剰余環のもとになる多項式環 ((|k[x]|)) を返します。


== メソッド
--- abs_lift
    ((<::env_ring>)) すなわち基礎体 ((|k0|)) 上
    の多変数多項式環 ((|k0[x1, x2,.., xn]|))
    へのリフトを返します。

--- [](n)
    ((<n>)) 次の係数を返します。(({lift[n]})) と同じです。

    例: Fibonacci 数列
      require "algebra"
      t = AlgebraicExtensionField(Integral, "t"){|x| x**2-x-1}.var
      (0..10).each do |n|
        p( (t**n)[1] ) #=> 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55
      end

=end
