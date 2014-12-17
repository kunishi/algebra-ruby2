########################################################################
#                                                                      #
#   lib/permutation-group.rb                                           #
#                                                                      #
########################################################################
=begin
[((<index-ja|URL:index-ja.html>))] 
((<Algebra::PermutationGroup>))
/
((<Algebra::Permutation>))

= Algebra::PermutationGroup
置換群のクラスです。要素として ((<Permutation>)) のインスタンス
が指定されているとします。


== ファイル名:
* ((|permutation-group.rb|))

== スーパークラス:
* ((|Group|))

== クラスメソッド:

--- ::new(u, [g0, [g1, ...]])
    ((|u|)) を単位元とし、((|g0|)), ((|g1|)), ... で構成される群を
    返します。

--- ::unit_group(d)
    次数が ((|d|)) の単位群を返します。

--- ::unity(n)
    次数が ((|n|)) の単位元を返します。

--- ::perm(a)
    配列 ((|a|)) で表される置換を返します。

--- ::symmetric(n)
    ((|n|)) 次の対称群を返します。

--- ::alternate(n)
    ((|n|)) 次の交代群を返します。

= Algebra::Permutation
置換を表現するクラスです。


== ファイル名:
* ((|permutation-group.rb|))

== スーパークラス:
* ((|Object|))

== インクルードしているモジュール:

* ((|Enumerable|))
* ((|Powers|))

== クラスメソッド:

--- ::new(x)
    ((|x|)) という配列で表現される置換を生成します。

--- ::[]([n0, [n1, [n2, ..., ]]])
    (({[n0, n1, n2, ..., ]})) という置換を生成します。
    例
      a = Permutation[1, 2, 0]
      p a**2 #=> [2, 0, 1]
      p a**3 #=> [0, 1, 2]

--- ::unity(d)
    ((|d|)) 次の単位元を返します。

--- ::cyclic2perm(c, n)
    ((|c|)) という巡回置換を表す配列の配列から、((<Permutation>))
    オブジェクトを生成します。((|n|)) は次数です。
    ((<decompose_cyclic>)) の逆です。

    例: 
      Permutation.cyclic2perm([[1,6,5,4], [2,3]], 7) #=> [0, 6, 3, 2, 1, 4, 5]
      Permutation[0, 6, 3, 2, 1, 4, 5].decompose_cyclic #=> [[1,6,5,4], [2,3]]

== メソッド:
--- unity
    単位元を返します。

--- perm
    配列表現を返します。

--- degree
    次数を返します。

--- size
    ((<degree>)) のエイリアスです。

--- each
    置換の各元について繰り返します。

--- eql?(other)
    ((|other|)) と等しいとき真を返します。

--- ==
    ((|eql?|)) のエイリアスです。

--- hash
    ハッシュ値を返します。

--- [](i)
    ((|i|)) の置換先を返します。

--- call
    ((<[]>)) のエイリアスです。

--- index(i)
    ((|i|)) の置換元を返します。

--- right_act(other)
    ((|other|)) に右からかけます。すなわち
    (({(g.right_act(h))[x] == h[g[x]]})) が成立します。

--- *
    ((<right_act>)) のエイリアスです。

--- left_act(other)
    ((|other|)) に左からからかけます。すなわち
    (({(g.left_act(h))[x] == g[h[x]]})) が成立します。

--- inverse
    逆元を返します。

--- inv
    ((|inverse|)) のエイリアスです。

--- sign
    符号を返します。

--- conjugate(g)
    ((|g|)) による共役 (({g * self * g.inv})) を返します。

--- decompose_cyclic
    配列による巡回表現の配列を返します。
    ((<::cyclic2perm(c, n)>)) の逆です。

--- to_map
    ((<Map|URL:finite-map-ja.html>)) オブジェクト化します。

--- decompose_transposition
    互換の配列に分解したものを返します。

=end

