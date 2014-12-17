=begin
[((<index-ja|URL:index-ja.html>))] 
((<Algebra::MPolynomial>))
/
((<Algebra::MPolynomial::Monomial>))
/
((<Algebra::MPolynomialFactorization>))
/
((<Algebra::Groebner>))

= Algebra::MPolynomial
((*(多変数多項式環クラス)*))

多変数の多項式環を表現します。実際のクラスを生成するには環を指定して、
クラスメソッド((<::create>))あるいは関数((<Algebra.MPolynomial>))()を
用います。

== ファイル名:
* ((|m-polynomial.rb|))

== スーパークラス:

* ((|Object|))

== インクルードしているモジュール:

* ((|Enumerable|))
* ((|Comparable|))
* ((<Algebra::Groebner>))

== 関連する関数:

--- Algebra.MPolynomial(ring [, obj0 [, obj1 [, ...]]])
    ((<::create(ring [, obj0[, obj1[, ...]]])>))に同じ。

== クラスメソッド:

--- ::create(ring [, obj0 [, obj1 [, ...]]])
    ((|ring|))で表現されるクラスを係数環とする多変数多項式環
    クラスを生成します。
    
    オブジェクト(({obj0, obj1, ...}))で変数を登録し、戻り値である
    多変数多項式環クラスは Algebra::MPolynomial クラスのサブクラスです。
    
    オブジェクト(({obj0, obj1, ...}))は変数の区別と
    名（((|to_s|))の値）に利用されるだけです。

    このサブクラスにはクラスメソッドとして((|ground|))と
    ((|vars|))が定義され、それぞれ、係数環((|ring|))、変数
    の配列を返します。    
    
    登録されたオブジェクト (({obj0, obj1, ...})) で表現される
    される変数は(({var(obj0)})), (({var(obj1)})),...
    で得ることができます。すなわち(({vars == [var(obj0), var(obj1), ...]}))
    です。
    
    各変数の大小関係は(({obj0 > obj1 > ...}))となります。各単項式
    の順序は((<::set_ord>))で指定します。


    例: 整数を係数とする多項式環の生成
      require "m-polynomial"
      P = Algebra::MPolynomial.create(Integer, "x", "y", "z")
      x, y, z = P.vars
      p((-x + y + z)*(x + y - z)*(x - y + z))
      #=> -x^3 + x^2y + x^2z + xy^2 - 2xyz + xz^2 - y^3 + y^2z + yz^2 - z^3
      p P.ground #=> integer

--- ::vars([obj0 [, obj1 [, ...]]])
    ((*引数が1つもないとき*))、既に登録されている全ての変数を
    配列として返します。
    
    例:
      P = Algebra.MPolynomial(Integer, "x", "y", "z")
      p P.vars #=> [x, y, z]
    
    ((*引数がただ1つで文字列であるとき*))、文字列を「英字1字+数字の列」
    に分解し、それで表現される変数を登録します。オブジェクトが既
    に登録されていれば新たな登録はしません。戻り値はそれぞれのオ
    ブジェクトに対応する変数の配列です。
    
    例: 
      P = Algebra.MPolynomial(Integer)
      x, y, z, w = P.vars("a0b10cd")
      p P.vars #=> [a0, b10, c, d]
      p [x, y, z, w] #=> [a0, b10, c, d]

    ((*それ以外のとき*))、引数であるオブジェクト
    (({obj0, obj1, ...})) で表現される変数
    を登録します。オブジェクトが既に登録されていれば新たな登録
    はしません。戻り値は(({obj0, obj1, ...}))に対応する変数
    の配列です。

    例:
      P = Algebra.MPolynomial(Integer)
      p P.vars("x", "y", "z") #=> [x, y, z]

--- ::mvar([obj0 [, obj1 [, ...]]])

    ((*引数が1つもないとき*))、既に登録されている全ての変数を
    配列として返します。

    ((*それ以外のとき*))、引数であるオブジェクト
    (({obj0, obj1, ...})) で表現される変数
    を登録します。オブジェクトが既に登録されていれば新たな登録
    はしません。戻り値は (({obj0, obj1, ...})) に対応する変数
    の配列です。

--- ::to_ary
    (({[self, *vars]})) を返します。

    例: 多項式環と変数を同時に定義する。
      P, x, y, z, w = Algebra.MPolynomial(Integer, "a", "b", "c", "d")

--- ::var(obj)
    ((|obj|)) で登録されたオブジェクトによって表現される変数を返します。
    
    例: 
      P = Algebra.MPolynomial(Integer, "X", "Y", "Z")
      x, y, z = P.vars
      P.var("Y") == y #=> true

--- ::variables
    既に登録されている変数を表現するオブジェクトの配列を返します。

--- ::indeterminate(obj)
    ((<::var>)) と同じです。

--- ::zero?
    零元であるとき真を返します。

--- ::zero
    零元を返します。
    
--- ::unity
    単位元を返します。

--- ::set_ord(ord [, v_ord])
    ((|ord|)) に単項式順序をシンボルで指定します。順序として可能な指定
    は (({:lex})) (辞書式順序(デフォルト))、(({:grlex})) (次数付き辞書
    式順序)、(({:grevlex})) (次数付き逆辞書式順序)の3つです。
    
    各変数間の順序は登録された順（先に登録されるほど大きい）に
    なります。((|v_ord|)) に配列を与えてこの順番を変更する事が
    できます。
    
    例: (({x, y, z = P.var("xyz")})) としたときの順位
      require "m-polynomial"
      P = Algebra.MPolynomial(Integer)
      x, y, z = P.vars("xyz")
      f = -5*x**3 + 7*x**2*z**2 + 4*x*y**2*z + 4*z**2

      P.set_ord(:lex)
      p f #=> -5x^3 + 7x^2z^2 + 4xy^2z + 4z^2

      f.method_cash_clear
      P.set_ord(:grlex)
      p f #=> 7x^2z^2 + 4xy^2z - 5x^3 + 4z^2

      f.method_cash_clear
      P.set_ord(:grevlex)
      p f #=> 4xy^2z + 7x^2z^2 - 5x^3 + 4z^2

      f.method_cash_clear
      P.set_ord(:lex, [2, 1, 0]) # z > y > x
      p f #=> 7x^2z^2 + 4z^2 + 4xy^2z - 5x^3

#    ((<::with_ord>)) も参照してください。

--- ::order=(x)
    ((<::set_ord(x)>)) と同じです。

#--- ::order=(obj)
#    ((<::set_ord(obj)>)) と同じです。

--- ::get_ord
    単項式順序(:lex, :grlex, :grevlex)を返します。

--- ::ord
    ((<::get_ord>)) と同じです。

#--- ::order
#    ((<::get_ord>)) と同じです。

--- ::with_ord(ord [, v_ord[ [, array_of_polys]])
    ((|ord|)) を単項式順序、((|v_ord|)) を変数の順序の変換配列として、
    ブロックを実行します。
    ブロックを抜けると以前の順序に戻ります。
    多項式の配列 ((|array_of_polys|)) が与えられれば、それらに対して
    ((<method_cash_clear>)) が実行されてから、ブロックが実行されます。
    (このブロックはスレッドセーフではありません。)

    例:
      require "m-polynomial"
      P = Algebra.MPolynomial(Integer)
      x, y, z = P.vars("xyz")
      f = -5*x**3 + 7*x**2*z**2 + 4*x*y**2*z + 4*z**2

      P.with_ord(:lex, nil, [f]) do
        p f    #=> -5x^3 + 7x^2z^2 + 4xy^2z + 4z^2
        p f.lt #=> -5x^3
      end

      P.with_ord(:grlex, nil, [f]) do
        p f    #=> 7x^2z^2 + 4xy^2z - 5x^3 + 4z^2
        p f.lt #=> 7x^2z^2
      end

      P.with_ord(:grevlex, nil, [f]) do
        p f    #=> 4xy^2z + 7x^2z^2 - 5x^3 + 4z^2
        p f.lt #=> 4xy^2z
      end

      P.with_ord(:lex, [2, 1, 0], [f]) do # z > y > x
        p f    #=> 7x^2z^2 + 4z^2 + 4xy^2z - 5x^3
        p f.lt #=> 7x^2z^2
      end

    ((<::set_ord>)) も参照してください。

--- ::monomial(ind[, c])
    multi-degree ((|ind|)) で、係数が ((|c|)) の単項式を返します。
    （ただし、((<Algebra::MPolynomial::Monomial>)) は extend
    されていない。）
    ((|c|)) が省略されれば、単位元とみなされます。

#--- ::const(x)
#--- ::regulate(x)
#--- ::[](*x)
#--- ::method_cash_clear(*m)

== メソッド:

--- monomial(ind[, c])
    ((<::monomial>)) と同じ。

#--- each
#--- keys
#--- values
#--- [](ind)
#--- []=(ind, c)
#--- constant_coeff
#--- include?
#--- compact!
#--- rt!

--- constant?
    定数(0次式)であるとき、真を返します。

--- monomial?
    単項式であるとき、真を返します。

--- zero?
    零であるとき、真を返します。    

--- zero
    零元を返します。
    
--- unity
    単位元を返します。

--- method_cash_clear
    このライブラリは、同じ計算を繰り返ししないように結果を保存
    していますが、それをクリアします。この操作は単項式順序の変
    更などを行った後に必要になります。
    
    結果が保存されているメソッドは、
    ((<lc>)), ((<lm>)), ((<lt>)), ((<rt>)), ((<multideg>))
    です。
    
    例:
      P = Algebra.MPolynomial(Integer)
      x, y, z = P.vars("xyz")
      f = -5*x**3 + 7*x**2*z**2 + 4*x*y**2*z + 4*z**2
      P.set_ord(:lex)
      p f.lt #=> -5x^3
      P.set_ord(:grlex)
      p f.lt #=> -5x^3
      f.method_cash_clear
      p f.lt #=> 7x^2z^2

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
    ((|other|)) が、定数(0次式)であるとき、商を計算します。

--- divmod(f0 [, f1 [,...]])
    多項式 (({f0, f1,...})) による割り算をし、商の配列と剰余を計算します。

      P = Algebra.MPolynomial(Integer)
      x, y = P.vars("xy")
      f = x**2*y + x*y**2 + y**2
      f0 = x*y - 1
      f1 = y**2 - 1
      p f.divmod(f0, f1) #=> [[x + y, 1], x + y + 1]
      p f % [f0, f1]     #=> x + y + 1

--- %(others)
    ((|others|)) を多項式の配列としたとき、それによる割り算の剰余を返します。
    これは (({divmod(*others)[1]})) と同じです。

--- multideg
    （多重）次数を返します。
    
    例: (lex オーダーで)
      P = Algebra.MPolynomial(Integer)
      x, y, z = P.vars("xyz")
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.multideg #=> [3, 1]

--- totdeg
    次数（多重次数の和）を返します。

    例: (lex オーダーで)
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.totdeg   #=> 4

--- deg
    multideg と同じです。

--- lc
    先頭係数(leading coeffcient)を返します。

    例: (lex オーダーで)
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.lc       #=> -5

--- lm
    先頭単項式(leading monomial)を返します。
    この戻り値は((<Algebra::MPolynomial::Monomial>))というモジュールが
    extend されます。

    例: (lex オーダーで)
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.lm       #=> x^3y

--- lt
    先頭項(leading term)を返します。(({lc * lm}))と等しい値を持ちます。

    例: (lex オーダーで)
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.lt       #=> -5x^3y

--- rt
    残余項(rest term)を返します。(({self - lt}))と等しい値を持ちます。

    例: (lex オーダーで)
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.rt       #=> 4*z**2 - 5*x**3*y + 7*x**2*z**2

--- to_s
    文字列表現を得ます。表示形式を変えるには((|display_type|))を用います。
    ((|display_type|))に与えられる値は ((|:norm|))(デフォルト), ((|:code|))
    です。
    
    例:
      P = Algebra.MPolynomial(Integer)
      x, y, z = P.vars("xyz")
      f = -5*x**3 + 7*x**2*z**2 + 4*x*y**2*z + 4*z**2
      p f #=> -5x^3 + 7x^2z^2 + 4xy^2z + 4z^2
      P.display_type = :code
      p f #=> -5*x**3 + 7*x**2*z**2 + 4*x*y**2*z + 4*z**2

--- map_to(ring[, vs]){|c, ind| ... }
    多項式に含まれる各単項式について、
    multi-degree を ((|ind|))、係数を ((|c|)) に代入し、
    ... を評価して、((|ring|)) 上で和を取った値を
    返します。((|vs|)) が省略されると ((<::vars>)) の値が用いら
    れます。
    (({f}))が(({P}))上の多項式なら、
    (({f.map_to(P) {|c, ind| c * P.monomial(ind)}})) は (({f}))と一致します。

--- project(ring[, vs]){|c, ind| ... }
    多項式に含まれる各単項式について、
    multi-degree を ((|ind|))、係数を ((|c|)) に代入し、
    ... を評価して((|ind|))次の単項式に掛けて、
    ((|ring|)) 上で和を取った値を
    返します。((|vs|)) が省略されると ((<::vars>)) の値が用いら
    れます。

    (({f}))が(({P}))上の多項式なら、
    (({f.map_to(P) {|c, ind| c}})) は (({f}))と一致します。

    (({project(ring){|c, ind| f(c, ind)}})) は (({map_to(ring){|c, ind| f(c, ind) * self.class.monomial(ind)}}))に一致します。
    
    例:
      require "m-polynomial"
      require "rational"
      P = Algebra::MPolynomial(Integer, "x", "y", "z")
      x, y, z = P.vars
      f = x**2 + 2*x*y - z**3
      PQ = Algebra::MPolynomial(Rational, "x", "y", "z")
      p f.project(PQ) {|c, ind| Rational(c) / (ind[0] + 1)}
                        #=> 1/3x^2 + xy - z^3
      p f.convert_to(PQ)      #=> x^2 + 2xy - z^3

--- evaluate(obj0[, [obj1, [obj2,..]]])
    各変数に ((|obj0, obj1, obj2,...|)) を代入した値を返します。
    ((<project>))(({(ground, [obj0, obj1, obj2,..]){|c, ind| c}}))
    の値と一致します。

    例:
      require "m-polynomial"
      P = Algebra::MPolynomial(Integer, "x", "y", "z")
      x, y, z = P.vars
      f = x**2 + 2*x*y - z**3
      p f.evaluate(1, -1, -1) #=> 0 (in Integer)
      p f.evaluate(y, z, x)   #=> -x^3 + y^2 + 2yz (in P)

--- call(obj0[, [obj1, [obj2,..]]])
    ((<evaluate>))と同じです。

--- sub(var, value)
    変数 ((|var|)) に ((|value|)) を代入した値を返します。

    例:
      require "m-polynomial"
      P = Algebra::MPolynomial(Integer)
      x, y, z = P.vars("x", "y", "z")
      f = (x - y)*(y - z - 1)
      p f.sub(y, z+1)    #=> 0

--- convert_to(ring)
    各項を((|ring|))上で評価します。((<project>))(({(ring){|c, ind| c}}))の
    値と一致します。

--- derivate(var)
    ((<var>))での偏微分を返します。
    
= Algebra::MPolynomial::Monomial
(単項式の性質を集めたモジュール)

((<lt>)), ((<lm>)) の戻り値である多項式にはこのモジュールがextendされます。

== メソッド:

#--- ind
#--- coeff
#--- <=>(other)
--- divide?(other)
    単項式 ((|other|)) で割り切れるとき真を返します。

--- /(other)
    単項式 ((|other|)) で割り切ります。

--- prime_to?(other)
    単項式 ((|other|)) と素なとき真を返します。

--- lcm(other)
    単項式 ((|other|)) との最小公倍数である単項式を返します。

--- divide_or?(other0, other1)
    ((|divide?(other0.lcm(other1))|)) と同じ値を返します。


= Algebra::MPolynomialFactorization
((*(因数分解モジュール)*))

因数分解をするためのモジュールです。

== ファイル名:
((|m-polynomial-factor.rb|))

== メソッド:
--- factorize
    因数分解します。
    
    因数分解可能な係数環は
    * Integer
    * Rational
    * 素体

    です。


= Algebra::Groebner
(グレブナ基底計算モジュール)

== ファイル名:
* ((|groebner-basis.rb|))
* ((|groebner-basis-coeff.rb|))

== クラスメソッド:

--- Groebner.basis(f)
    基底の配列 ((|f|)) から簡約グレブナ基底を作り、配列として返します。
    ((<Groebner.basis(Groebner.minimal_basis(Groebner.basis_159A(f)))>))
    と同等です。

    例:
      require "m-polynomial"
      require "rational"
      P = Algebra.MPolynomial(Rational)
      P.set_ord :grevlex
      x, y, z = P.vars("xyz")
      f1 = x**2 + y**2 + z**2 -1
      f2 = x**2 + z**2 - y
      f3 = x - z
      b = Groebner.basis([f1, f2, f3])
      p b #=> [y^2 + y - 1, z^2 - 1/2y, x - z]

--- Groebner.basis_159A(f)
    基底の配列 ((|f|)) からグレブナ基底を作り配列として返します。

--- Groebner.minimal_basis(f)
    グレブナ基底の配列 ((|f|)) から極小グレブナ基底の配列を作り返します。

--- Groebner.reduced_basis(f)
    極小グレブナ基底の配列 ((|f|)) から簡約グレブナ基底の配列を作り返します。

--- Groebner.basis_coeff(f)
    基底の配列 ((|f|)) から簡約グレブナ基底の配列と、各基底を生成
    するための係数を返します。
    
    例:
      require "m-polynomial"
      require "rational"
      P = Algebra.MPolynomial(Rational)
      P.set_ord :grevlex
      x, y, z = P.vars("xyz")
      f1 = x**2 + y**2 + z**2 -1
      f2 = x**2 + z**2 - y
      f3 = x - z
      fs = [f1, f2, f3]
      c, b = Groebner.basis_coeff(fs)
      p b #=> [y^2 + y - 1, z^2 - 1/2y, x - z]
      p c #=> [[1, -1, 0], [0, 1/2, -1/2x - 1/2z], [0, 0, 1]]
      for i in 0..2
        p c[i].inner_product(fs) == b[i] #=> true
      end

--- Groebner.basis?(f)
    ((|f|)) がグレブナ基底の配列か否かを返します。
    
--- Groebner.minimal_basis?(f)
    ((|f|)) が極小グレブナ基底の配列か否かを返します。
    
--- Groebner.reduced_basis?(f)
    ((|f|)) が極小グレブナ基底の配列か否かを返します。
    
== メソッド:
--- S_pair(other)
    ((|other|)) との S-pair を取ります。
    
    例:
      (x**2*y + y**2 + z**2 -1).S_pair(x**2*z + z**2 - y)
        #=> y^2z + y^2 - yz^2 + z^3 - z

--- divmod_s(f1[, f2[, f3...]])
    基底 (({f1, f2, f3, ...})) で割った商（各基底の係数の配列）
    と余り (({[[q1, q2, q3, ...], r]})) を返します。
    
    一度 (({f1, f2, f3, ...})) をグレブナ基底に変換してから
    割り算を行うので、(({divmod(f1, f2, ...).last == 0})) と ((|self|)) が
    イデアル (({(f1, f2, ...)})) に属することは同値です。
    
    例:
      require "m-polynomial"
      require "rational"
      P = Algebra.MPolynomial(Rational)
      P.set_ord :grevlex
      x, y, z = P.vars("xyz")
      f1 = x**2 + y**2 + z**2 -1
      f2 = x**2 + z**2 - y
      f3 = x - z
      fs = [f1, f2, f3]
      f = x**3 + y**3 + z**3
      c, r = f.divmod_s(*fs)
      p r #=> yz + 2y - 1
      p c #=> [y - 1, -y + z + 1, x^2]
      p f == c.inner_product(fs) + r #=> true

--- div_cg(f, cg)
    基底の配列 ((|f|)) から ((<Groebner.basis_coeff>))(f)
    で求めた値 ((|cg|)) を用いて((|self|)) を基底 ((|f|)) で
    割った商（各基底の係数の配列）と余り (({[q, r]})) を返します。
    ((<divmod_s>))(f) は
    (({div_cg(f, Groebner.basis_coeff(f))})) を返しています。

=end
