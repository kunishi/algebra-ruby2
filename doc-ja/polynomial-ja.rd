=begin
[((<index-ja|URL:index-ja.html>))] 
((<Algebra::Polynomial>))
/
((<Algebra::PolynomialFactorization>))
/
((<Algebra::SplittingField>))
/
((<Algebra::Galois>))

= Algebra::Polynomial
((*(1変数多項式環クラス)*))

1変数の多項式環を表現します。実際のクラスを生成するには環を指定して、クラスメソッド ((<::create>)) あるいは関数 ((<Algebra.Polynomial>))() を用います。

== ファイル名:
* ((|polynomial.rb|))

== スーパークラス:

* ((|Object|))

== インクルードしているモジュール:

* ((|Enumerable|))
* ((|Comparable|))
* ((<Algebra::EuclidianRing|URL:euclidian-ring-ja.html>))
* ((<Algebra::PolynomialFactorization>))
* ((<Algebra::SplittingField>))
* ((<Algebra::Galois>))

== 関連するメソッド:

--- Algebra.Polynomial(ring [, obj0 , obj1 [, ...]])
    ((<::create>))(ring, obj0[, obj1 [, ...]])> に同じ。

== クラスメソッド:

--- ::create(ring, obj0[, obj1[, ...]])
    ((|ring|)) で表現されるクラスを係数環とする多項式環クラスを
    生成します。
    
    (({obj0, obj1, ...})) で指定されたオブジェクトが変数を
    表現し、これが複数ならば、再帰的に多項式環上の多項
    式環を生成します。

    このメソッドの戻り値は Polynomial クラスのサブクラス
    です。このサブクラスにはクラスメソッドとして ((|ground|)) と
    ((|var|))、((|vars|)) が定義され、それぞれ、係数環 ((|ring|))、
    主変数オブジェクト（最後に指定された変数）、全ての変数オ
    ブジェクトを返します。

    オブジェクト(({obj0, obj1, ...}))は変数の名（((|to_s|))の値）
    に利用されるだけです。
        
    例: 整数を係数とする多項式環の生成
      require "polynomial"
      P = Algebra::Polynomial.create(Integer, "x")
      x = P.var
      p((x + 1)**100) #=> x^100 + 100x^99 + ... + 100x + 1
      p P.ground #=> integer


    例: 整数を係数とする複数変数多項式環の生成
      require "polynomial"
      P = Algebra::Polynomial.create(Integer, "x", "y", "z")
      x, y, z = P.vars
      p((-x + y + z)*(x + y - z)*(x - y + z))
      #=> -z^3 + (y + x)z^2 + (y^2 - 2xy + x^2)z - y^3 + xy^2 + x^2y - x^3
      p P.var #=> z
    
    この例の (({P})) は

      Algebra::Polynomial.create(
        Algebra::Polynomial.create(
          Algebra::Polynomial.create(
            Integer,
          "x"),
        "y"),
      "z")

    と同値で、最後の変数 ((|z|)) が主変数となります。

--- ::var
    多項式環の変数（主変数）を返します。

--- ::vars
    再帰的に各多項式環の変数を集めた配列を返します。

--- ::mvar
    ((<::vars>)) と同じです。

--- ::to_ary
    (({[self, *vars]})) を返します。

    例: 多項式環と変数を同時に定義する。
      P, x, y, z = Algebra::Polynomial.create(Integer, "x", "y", "z")

--- ::variable
    変数（主変数）を表現するオブジェクトを返します。

--- ::variables
    再帰的に各多項式環の変数を表現するオブジェクトを
    集めた配列を返します。

--- ::indeterminate(obj)
    ((|obj|)) で表現される変数を再帰的に探して返します。

--- ::monomial([n])
    ((|n|)) 次の単項式を返します。
    
    例:
      P = Algebra::Polynomial(Integer, "x")
      P.monomial(3) #=> x^3

--- ::const(c)
    値 ((|c|)) の定数項を返します。

    例:
      P = Algebra::Polynomial(Integer, "x")
      P.const(3)      #=> 3
      P.const(3).type #=> P

--- ::zero
    零元を返します。
    
--- ::unity
    単位元を返します。

#--- ::euclidian?

== メソッド:

--- var
    ((<::var>)) と同じです。

--- variable
    ((<::variable>)) と同じです。

--- each(&b)
    各次の係数を昇冪順に繰り返します。
    
    例:
      P = Algebra::Polynomial(Integer, "x")
      x = P.var
      (x**3 + 2*x**2 + 4).each do |c|
        p c #=> 4, 0, 2, 1
      end

--- reverse_each(&b)
    各次の係数を降冪順に繰り返します。

    例:
      P = Algebra::Polynomial(Integer, "x")
      x = P.var
      (x**3 + 2*x**2 + 4).reverse_each do |c|
        p c #=> 1, 2, 0, 4
      end

--- [](n)
    ((|n|)) 次の係数を返します。

--- []=(n, v)
    ((|n|)) 次の係数を((|v|))に設定します。

--- monomial
    ((<::monomial>)) と同じです。

--- monomial?
    単項式であるとき真を返します。

--- zero?
    零元であるとき真を返します。

--- zero
    零元を返します。
    
--- unity
    単位元を返します。

#--- variable=(bf)
#--- size
#--- compact!
#--- ground_div(n, d)

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
    商を計算します。((<div>))と同じです。

--- divmod(other)
    ((|other|)) で割った商と余りの配列を返します。

--- div(other)
    ((|other|)) で割った商を返します。(({divmod(other).first}))
    と一致します。

--- %(other)
    ((|other|)) で割った余りを返します。(({divmod(other).last}))
    と一致します。

--- divide?(other)
    ((|other|)) で割り切れるとき真を返します。
    (({divmod(other).last == zero?}))と一致します。

--- deg
    次数を返します。

    例:
      P = Algebra::Polynomial(Integer, "x")
      x = P.var
      (5*x**3 + 2*x + 1).deg #=> 3

--- lc
    先頭係数(leading coeffcient)を返します。

    例:
      (5*x**3 + 2*x + 1).lc #=> 5

--- lm
    先頭単項式(leading monomial)を返します。

    例:
      (5*x**3 + 2*x + 1).lm #=> x**3

--- lt
    先頭項(leading term)を返します。(({lc * lm}))と等しい値を持ちます。

    例:
      (5*x**3 + 2*x + 1).lt #=> 5*x**3

--- rt
    残余項(rest term)を返します。(({self - lt}))と等しい値を持ちます。

    例:
      (5*x**3 + 2*x + 1).rt #=> 2*x + 1

--- monic
    最高次係数を1に直した式を返します。(({self / lc})) と同じ値を持
    ちます。

--- cont
    係因数(content(全ての係数の最大公約数)）を返します。

--- pp
    原始的部分(primitive part)を返します。(({self / cont}))と
    同じ値を持ちます。

--- to_s
    文字列表現を得ます。表示形式を変えるには ((|display_type|)) を用います。
    ((|display_type|)) に与えられる値は ((|:norm|))(デフォルト), ((|:code|))
    です。
    
    例:
      P = Algebra::Polynomial(Integer, "x")
      x = P.var
      p 5*x**3 + 2*x + 1 #=>5x^3 + 2x + 1
      P.display_type = :code
      p 5*x**3 + 2*x + 1 #=> 5*x**3 + 2*x + 1

--- derivate
    微分した値を返します。
    
    例:
      (5*x**3 + 2*x + 1).derivate #=> 15*x**2 + 2

--- sylvester_matrix(other)
    ((|other|)) とのシルベスター行列を返します。

--- resultant(other)
    ((|other|)) との集結式返します。予め

--- project(ring[, obj]){|c, n| ... }
    各単項式について、
    次数を ((|n|)) に、係数 ((|c|)) に代入し ... を評価したものを
    その単項式の値に置き換え、((|ring|)) 上で和を取った値を
    返します。((|obj|)) が省略されると (({ring.var})) が用いら
    れます。
    
    例:
      require "polynomial"
      require "rational"
      P = Algebra::Polynomial(Integer, "x")
      PQ = Algebra::Polynomial(Rational, "y")
      x = P.var
      f = 5*x**3 + 2*x + 1
      p f.convert_to(PQ) #=> 5y^3 + 2y + 1
      p f.project(PQ) {|c, n| Rational(c) / (n + 1)} #=> 5/4y^3 + y + 1

--- evaluate(obj)
    主変数に ((|obj|)) を代入した値を返します。
    (({ project(ground, obj){|c, n| c} })) の値と一致します。

    例:
      require "polynomial"
      P = Algebra::Polynomial(Integer, "x")
      x = P.var
      f = x**3 - 3*x**2 + 1
      p f.evaluate(-1)    #=> -3 (in Integer)
      p f.evaluate(x + 1) #=> x^3 - 3x - 1 (in P)

--- call(obj)
    ((<evaluate>))と同じです。

--- sub(var, value)
    変数 ((|var|)) に ((|value|)) を代入した値を返します。

    例:
      require "polynomial"
      P = Algebra::Polynomial(Integer, "x", "y", "z")
      x, y, z = P.vars
      f = (x - y)*(y - z - 1)
      p f.sub(y, z+1)    #=> 0

--- convert_to(ring)
    各項を((|ring|))上で評価します。(({ project(ring){|c, n| c} }))の
    値と一致します。

= Algebra::PolynomialFactorization
((*(因数分解モジュール)*))

因数分解をするためのモジュールです。

== ファイル名:
((|polynomial-factor.rb|))

== メソッド:

--- sqfree
    無平方化します。

--- sqfree?
    無平方なら真を返します。

--- irreducible?
    既約なら真を返します。

--- factorize
    因数分解します。
    
    因数分解可能な係数環は
    * Integer
    * Rational
    * 素体
    * 代数体（Rational 上の有限次拡大）
    です。


= Algebra::SplittingField
((*(分解体モジュール)*))

多項式の最小分解体を求めるためのモジュール


== ファイル名:
* ((|splitting-field.rb|))


== メソッド:


--- decompose([fac0])
    自身の最小分解体を ((|field|))、拡大に要した既約多項式
    の配列を ((|def_polys|))、最小分解体上で1次式の積に因数分解し
    たものを ((|facts|))、多項式の根の配列を ((|roots|))、
    ((|roots|)) を基礎体に添加した元が前に来るように並べ替えた
    の配列を ((|proots|)) として、

      [field, def_polys, facts, roots, proots]

    を返します。基礎体上の因数分解 ((|fac0|)) を添えると高速化に役立ちます。
    （((|facts|)) の要素と ((|fact0|)) は ((|Algebra::Factors|)) オブジェクト
    、((|field|)) は
    ((<AlgebraicExtensionField|algebraic-extension-field.html>))
    オブジェクトです。ただし、自身が一次因子に分解されるときは
    ((<groud>)) そのものを返します。

    例:
      require "algebra"
      PQ = Polynomial(Rational, "x")
      x = PQ.var
      f = x**5 - x**4 + 2*x - 2
      field, def_polys, facts, roots, proots = f.decompose
      p def_polys #=> [a^4 + 2, b^2 + a^2]
      p facts    #=> (x - 1)(x - a)(x + a)(x - b)(x + b)
      p roots    #=> [1, a, -a, b, -b]
      p proots   #=> [a, b, 1, -a, -b]
      fp = Polynomial(field, "x")
      x = fp.var
      facts1 = Factors.new(facts.collect{|g, n| [g.call(x), n]})
      p facts1.pi == f.convert_to(fp) #=> true

--- splitting_field([fac0]))
    自身の最小分解体の情報を返します。返り値の各フィールドの値は以下
    の通りです。poly_exps 以外は ((<decompose>)) の以下のものに相当します。

    poly, field, roots, proots, def_polys

    ただし、((|roots|))、((|proots|)) の各要素は ((|field|)) の
    要素として変換されています。
    
    例:
      require "algebra"
      PQ = Polynomial(Rational, "x")
      x = PQ.var
      f = x**5 - x**4 + 2*x - 2
      sf = f.splitting_field
      p sf.roots     #=> [1, a, -a, b, -b]
      p sf.proots     #=> [a, b, 1, -a, -b]
      p sf.def_polys #=> [a^4 + 2, b^2 + a^2]

= Algebra::Galois
((*(ガロア群)*))

多項式のガロア群を求めるためのモジュール

== ファイル名:
* ((|galois-group.rb|))

== インクルードしているモジュール:
* なし

== 関連するメソッド:

--- GaloisGroup.galois_group(poly)
    ((<galois_group>)) と同じ

== モジュールメソッド:
* なし

== メソッド:

--- galois_group
    多項式のガロア群を返します。群は各元が 
    ((<PermutationGroup|permutation-group.html>)) である 
    ((<FiniteGroup|finite-group.html>)) オブジェクトとして表現されます。

    例:
      require "rational"
      require "polynomial"

      P = Algebra.Polynomial(Rational, "x")
      x = P.var
      p( (x**3 - 3*x + 1).galois_group.to_a )
      #=>[[0, 1, 2], [1, 2, 0], [2, 0, 1]]

      (x**3 - x + 1).galois_group.each do |g|
        p g
      end
      #=> [0, 1, 2]
      #   [1, 0, 2]
      #   [2, 0, 1]
      #   [0, 2, 1]
      #   [1, 2, 0]
      #   [2, 1, 0]

=end
