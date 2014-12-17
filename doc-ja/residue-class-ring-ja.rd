=begin
[((<index-ja|URL:index-ja.html>))] 
= Algebra::ResidueClassRing
((*(剰余環クラス)*))

環からその1つの元を法とした剰余環を構成します。実際のクラスを生成するには環
と法とを指定して、クラスメソッド ((<::create>)) あるいは
関数 ((<Algebra.ResidueClassRing>))() を用います。


== ファイル名:
* ((|residue-class-ring.rb|))

== スーパークラス:

* ((|Object|))

== インクルードしているモジュール:

なし

== 関連する関数:

--- Algebra.ResidueClassRing(ring, mod)
    ((<::create>))(ring, mod) と同じです。

== クラスメソッド:

--- ::create(ring, mod)

    クラス ((|ring|)) で表現されるを環とその環の元 ((|mod|)) から、
    その元を法とした剰余環を表現するクラスを返します。
    
    この戻り値は ((<Algebra::ResidueClassRing>)) クラスのサブクラスです。
    このサブクラスにはクラスメソッドとして ((|::ground|)) と
    ((|::modulus|)) と (({[x]})) が定義され、それぞれ、基礎環 ((|ring|))、
    法 ((|mod|))、x を代表元とする剰余類を返します。
        
    例: 多項式環を法 (({x**2 + x + 1})) で割る。
      require "rational"
      require "polynomial"
      require "residue-class-ring"
      Px = Algebra.Polynomial(Rational, "x")
      x = Px.var
      F = Algebra.ResidueClassRing(Px, x**2 + x + 1)
      p F[x + 1]**100     #=> -x - 1
      
    ((|ring|)) が Integer である場合に限り、全ての逆数を予め計算して
    保管します。また (({0, 1, ... , mod-1})) に対応する剰余類の配列を
    ((|to_ary|)) で得ることができます。
    
    例: modulo 7 の素体
      require "residue-class-ring"
      F7 = Algebra::ResidueClassRing.create(Integer, 7)
      a, b, c, d, e, f, g = F7
      p [e + c, e - c, e * c, e * 2001, 3 + c, 1/c, 1/c * c]
        #=> [6, 2, 1, 3, 5, 4, 1]
      p( (1...7).collect{|i| F7[i]**6} )
        #=> [1, 1, 1, 1, 1, 1]

--- ::[](x)
    ((|x|)) で代表される剰余類を返します。
    
#--- ::indeterminate(obj)

--- ::zero
    零元を返します。
    
--- ::unity
    単位元を返します。


== メソッド:

--- lift
    剰余類の代表元を返します。

#--- monomial?

--- zero?
    零元であるとき真を返します。

--- zero
    零元を返します。
    
--- unity
    単位元を返します。

--- ==(other)
    等しいとき真を返します。

--- +(other)
    和を計算します。

--- -(other)
    差を計算します。

--- *(other)
    積を計算します。

--- **(n)
    ((|n|)) 乗を計算します。

--- /(other)
    ((<inverse>)) を利用して商を計算します。

--- inverse
    基礎環がユークリッド環であることを仮定して、逆数を返します。
    逆数が存在しない場合の値は nil です。

#--- to_s

=end
