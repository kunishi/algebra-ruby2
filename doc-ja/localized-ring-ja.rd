=begin
[((<index-ja|URL:index-ja.html>))] 
= Algebra::LocalizedRing
((*(局所化環クラス)*))

与えられた環を分子・分母にした分数環を構成します。
実際のクラスを生成するには、クラスメソッド ((<::create>)) 
あるいは関数 ((<Algebra.LocalizedRing>))() を用います。

== ファイル名:
* ((|localized-ring.rb|))

== スーパークラス:

* ((|Object|))

== インクルードしているモジュール:

なし

== 関連する関数:

--- Algebra.LocalizedRing(ring)
    ((<::create>))(ring) と同じです。

--- Algebra.RationalFunctionField(ring, obj)
    環 ((|ring|))、変数を表すオブジェクトを ((|obj|)) として有理関数体
    を作ります。クラスメソッド ((|::var|)) で変数を得ることができます。
    
    例: 有理関数体
      require "algebra/localized-ring"
      require "rational"
      F = Algebra.RationalFunctionField(Rational, "x")
      x = F.var
      p ( 1 / (x**2 - 1) - 1 / (x**3 - 1) )
        #=> x^2/(x^4 + x^3 - x - 1)

--- Algebra.MRationalFunctionField(ring, [obj1[, obj2, ...]])
    環 ((|ring|))、変数を表すオブジェクトを ((|obj1|)), ((|obj2|)),... として有理関数体を作ります。クラスメソッド ((|::vars|)) で変数を得ることができます。
    
    例: 有理関数体
      require "algebra/localized-ring"
      require "rational"
      G = Algebra.MRationalFunctionField(Rational, "x", "y", "z")
      x, y, z = G.vars
      f = (x + z) / (x + y) - z / (x + y)
      p f #=> (x^2 + xy)/(x^2 + 2xy + y^2)
      p f.simplify #=> x/(x + y)

== クラスメソッド:

--- ::create(ring)
    クラス((|ring|))で表現されるを環の元を分子・分母とする分数環
    を作ります。

    この戻り値は Algebra::LocalizedRing クラスのサブクラスです。
    このサブクラスにはクラスメソッドとして ((|::ground|)) が定義され
    ((|ring|)) を返します。
    
    生成したクラスにはクラスメソッド(({::[]}))が定義され、基礎環の
    元 (({x})) に対して分数環の元 (({x/1})) を返します。
    
    例: 有理数を作る
      require "localized-ring"
      F = Algebra.LocalizedRing(Integer)
      p F.new(1, 2) + F.new(2, 3) #=> 7/6

    例: 整数上の多項式環の商体
      require "polynomial"
      require "localized-ring"
      P = Algebra.Polynomial(Integer, "x")
      F = Algebra.LocalizedRing(P)
      x = F[P.var]
      p ( 1 / (x**2 - 1) - 1 / (x**3 - 1) )
        #=> (x^3 - x^2)/(x^5 - x^3 - x^2 + 1)

--- ::zero
    零元を返します。
    
--- ::unity
    単位元を返します。

#--- ::[](num, den = nil)

#--- ::reduce(num, den)


== メソッド:

#--- monomial?; true; end



--- zero?
    零元であるとき真を返します。

--- zero
    零元を返します。
    
--- unity
    単位元を返します。

--- ==(other)
    等しいとき真を返します。

--- <=>(other)
    大小関係を求めます。

--- +(other)
    和を計算します。

--- -(other)
    差を計算します。

--- *(other)
    積を計算します。

--- **(n)
    ((|n|)) 乗を計算します。

--- /(other)
    商を計算します。


#--- to_s

#--- inspect

#--- hash

=end
