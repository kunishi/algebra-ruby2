########################################################################
#                                                                      #
#   lib/finite-group.rb                                                #
#                                                                      #
########################################################################
=begin
[((<index-ja|URL:index-ja.html>))] 
((<Algebra::OperatorDomain>))
/
((<Algebra::Set>))
/
((<Algebra::Group>))
/
((<Algebra::QuotientGroup>))

= Algebra::OperatorDomain

群が作用する集合の性質を集めたモジュールです。
((<Group>)) クラスがインクルードしています。

== ファイル名:
* ((|finite-group.rb|))

== メソッド:

--- right_act(other)
    ((|self|)) と ((|other|)) の積を返します。すなわち ((|self|))
    の元 ((|x|)) と ((|other|)) の元 ((|y|)) に対して (({x * y})) の
    形の元の集合（((|Set|))）を返します。

--- act
    ((<right_act>)) のエイリアスです。

--- left_act(other)
    ((|self|)) と ((|other|)) の積を返します。すなわち ((|self|))
    の元 ((|x|)) と ((|other|)) の元 ((|y|)) に対して (({y * x})) の
    形の元の集合（((|Set|))）を返します。

--- right_quotient(other)
    ((|self|)) を ((|other|)) で割った右剰余類の集合（((|Set|))）
    を返します。

--- quotient
--- right_coset
--- coset
    ((<right_quotient>)) のエイリアスです。

--- left_quotient(other)
    ((|self|)) を ((|other|)) で割った左剰余類の集合（((|Set|))）
    を返します。

--- left_coset
    ((<left_quotient>)) のエイリアスです。

--- right_representatives(other)
    右剰余類 ((<right_quotient>)) から取った代表元の集合を返します。

--- representatives
    ((<right_representatives>)) のエイリアスです。

--- left_representatives(other)
    左剰余類 ((<left_quotient>)) から取った代表元の集合を返します。

--- right_orbit!(other)
    ((|self|)) を ((|other|)) を繰り返し右から作用させて広げます。
    作用は ((|*|)) によります。

--- orbit!
    ((<right_orbit!>)) のエイリアスです。

--- left_orbit!(other)
    ((|self|)) を ((|other|)) を繰り返し左から作用させて広げます。
    作用は ((|*|)) によります。
    

= Algebra::Set

== ファイル名:
* ((|finite-group.rb|))
  ここでは ((|finite-set.rb|)) で定義された ((<Set|URL:finite-set.html>))
  に付け加えるべきメソッドを定義しています。

== インクルードしているモジュール:

* ((|OperatorDomain|))

== メソッド:

--- *
    ((<act>)) のエイリアスです。

--- /
    ((<quotient>)) のエイリアスです。

--- %
    ((<representatives>)) のエイリアスです。

--- increasing_series([x])
    ((|x|)) から始まる増大列の配列を返します。これは次のコードと同値
    です。

      def increasing_series(x = unit_group)
        a = []
        loop do
          a.push x
          if x >= (y = yield x)
            break
          end
          x = y
        end
        a
      end

--- decreasing_series([x])
    ((|x|)) から始まる減少の配列を返します。これは次のコードと同値
    です。

      def decreasing_series(x = self)
        a = []
        loop do
          a.push x
          if x <= (y = yield x)
            break
          end
          x = y
        end
        a
      end

= Algebra::Group

== ファイル名:
* ((|finite-group.rb|))

== スーパークラス:
* ((|Set|))

== クラスメソッド:

--- ::new(u, [g0, g1, ...]])
    ((|u|)) を単位元とし、((|g0|)), ((|g1|)), ... で構成される群を
    返します。

--- ::generate_strong(u, [g0, [g1, ...]])
    単位元を ((|u|))、強生成元を ((|g0|)), ((|g1|)), ... として、
    生成される群を返します。

== メソッド:

--- quotient_group(u)
    正規部分群 ((|u|)) による剰余群を返します。

--- separate
    ブロックを真とする元からなる部分群を返します。

--- to_a
    各要素を配列にして返します。最初の要素は単位元です。

--- unity
    単位元を返します。

--- unit_group
    単位元で生成される単位群を返します。

--- semi_complete!
    現在の要素を掛け合わせて半群を構成します。

--- semi_complete
    現在の要素を掛け合わせて半群を構成たものを返します。

--- complete!
    現在の要素を掛け合わせて群を構成します。

--- complete
    現在の要素を掛け合わせて群を構成たものを返します。

--- closed?
    群として閉じているとき真を返します。

--- subgroups
    全ての部分群の集合を返します。

--- centralizer(s)
    ((|self|)) における ((|s|)) の中心化群を返します。

--- center
    ((|self|)) の中心化群を返します。

--- center?(x)
    ((|self|)) の中で元 ((|x|)) が中心に含まれているとき、真を返します。

--- normalizer(s)
    ((|self|)) における ((|s|)) の正規化群を返します。

--- normal?(s)
    ((|s|)) が ((|self|)) の正規部分群であるとき真を返します。

--- normal_subgroups
    全ての正規部分群の集合を返します。

--- conjugacy_class(x)
    元 ((|x|)) の共役類を返します

--- conjugacy_classes
    ((|self|)) の全ての共役類の集合を返します。

--- simple?
    単純群であるとき、真を返します。

--- commutator([h])
    ((|self|)) と ((|h|)) との交換子群を返します。((|h|)) を省略
    すると ((|self|)) が用いられます。

--- D([n])
    ((|n|)) 番目の交換子群を返します。(({D(0) = 自分自身})),
    (({D(n+1) = [D[n], D[n]]})) で定義されています。
    ((|n|)) を省略すると 1 が用いられます。

--- commutator_series
    (({[D(0), D(1), D(2),..., D(n)]})) という配列を返します。この配列は
    (({D(n) == D(n+1)})) となる ((|n|)) で停止します。 

--- solvable?
    可解群であるとき真を返します。

--- K([n])
    (({K(0) = 自分自身})),
    (({K(n+1) = [self, K[n]]})) で定義される群を返します。
    ((|n|)) を省略すると 1 が用いられます。

--- descending_central_series
    降中心列
    (({[K(0), K(1), K(2),..., K(n)]})) という配列を返します。この配列は
    (({K(n) == K(n+1)})) となる ((|n|)) で停止します。 

--- Z([n])
    (({Z(0) = 単位群})),
    (({Z(n+1) = separate{|x| commutator(Set[x]) <= Z(n-1)}})) 
    で定義される群を返します。
    ((|n|)) を省略すると 1 が用いられます。

--- ascending_central_series
    昇中心列
    (({[Z(0), Z(1), Z(2),..., Z(n)]})) という配列を返します。この配列は
    (({Z(n) == Z(n+1)})) となる ((|n|)) で停止します。 

--- nilpotent?
    冪零群であるとき真を返します。

--- nilpotency_class
    冪零クラスを返します。冪例群でないとき ((|nil|)) を返します。


= Algebra::QuotientGroup

== ファイル名:
* ((|finite-group.rb|))

== スーパークラス:
* ((|Group|))

== クラスメソッド:
--- new(u, [g0, [g1,...]])
    ((|self|)) の正規部分群を ((|u|)) として、
    ((|u|)), ((|g0|)), ((|g1|)), .. を剰余類とする剰余群を返します。

== メソッド:

--- inverse
    逆元を返します

--- inv
    ((<inverse>)) のエイリアスです。

=end

