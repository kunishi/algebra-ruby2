########################################################################
#                                                                      #
#   finite-set.rb                                                      #
#                                                                      #
########################################################################
=begin
[((<index-ja|URL:index-ja.html>))] 
[((<finite-map-ja|URL:finite-map-ja.html>))] 
((<Algebra::Set>))
/
((<Enumerable>))

= Algebra::Set
((*集合のクラス*))

集合を表現するクラスです。２つの集合 ((|s|)), ((|t|)) に関して、
((|s|)) が ((|t|)) に含まれる事は ((<all?>)) を使って、

  s.all?{|x| t.member?(x)}

で表現されます。

== ファイル名:
* ((|finite-set.rb|))

== スーパークラス:
* ((|Object|))

== インクルードしているモジュール:

* ((|Enumerable|))

== クラスメソッド:

--- ::[]([obj0, [obj1, [obj2, ...]]])
    引数の列から ((|Set|)) オブジェクトを生成します。
    
    例: 全て {"a", [1, 2], 0} を生成する。
      require "finite-set"
      p Algebra::Set[0, "a", [1, 2]]
      p Algebra::Set.new(0, "a", [1, 2])
      p Algebra::Set.new_a([0, "a", [1, 2]])
      p Algebra::Set.new_h({0=>true, "a"=>true, [1, 2]=>true})
    
--- ::new([obj0, [obj1, [obj2, ...]]])
    引数の列から ((|Set|)) オブジェクトを生成します。

--- ::new_a(a)
    配列 ((|a|)) から ((|Set|)) オブジェクトを生成します。

--- ::new_h(h)
    ((|Hash|)) から ((|Set|)) オブジェクトを生成します。

--- self.empty_set
    空集合を生成する。

--- ::phi
--- ::null
    ((<::empty_set>)) のエイリアスです。


--- ::singleton(x)
    ((|x|)) 一元のみで構成される集合を生成します。

== メソッド:

--- empty_set
    空集合を生成する。

--- phi
--- null
    ((<empty_set>)) のエイリアスです。

--- empty?
    空集合であるとき真を返します。

--- phi?
--- empty_set?
--- null?
    ((<empty?>)) のエイリアスです。

--- singleton(x)
    ((|x|)) 一元のみで構成される集合を生成します。

--- singleton?
    一元のみで構成される集合であるとき真を返します。

--- size
    集合の大きさを返します。

--- each
    集合の各要素に関して繰り返します。繰り返しの順番は不定です。

    例: 
      require "finite-set"
      include Algebra
      Set[0, 1, 2].each do |x|
        p x #=> 1, 0, 2
      end

--- separate
    集合の各要素をブロックパラメータに渡し、ブロックの値を真にする
    もので構成される集合を返します。

    例: 
      require "finite-set"
      include Algebra
      p Set[0, 1, 2, 3].separate{|x| x % 2 == 0} #=> {2, 0}

--- select_s
--- find_all_s
    ((<separate>)) のエイリアスです。

--- map_s
    集合の各要素をブロックパラメータに渡し、ブロックの値によって
    構成される集合を返します。

    例: 
      require "finite-set"
      include Algebra
      p Set[0, 1, 2, 3].map_s{|x| x % 2 + 1} #=> {2, 1}

--- pick
    集合の要素から一つ選んで値とします。どの要素が選ばれるかは
    不定です。空集合に対しては ((|nil|)) を返します。

--- shift
    集合の要素から一つ選んで取り出し値とします。どの要素が選ばれる
    かは不定です。

    例: 
      require "finite-set"
      include Algebra
      s = Set[0, 1, 2, 3]
      p s.shift #=> 2
      p s #=> {0, 1, 3}

--- dup
    集合の複製を返します。（内部の Hash の複製によります。）

--- append!(x)
    集合に要素 ((|x|)) を付け加えます。返り値は ((|self|)) です。

--- push
--- <<
    ((|append!|)) のエイリアスです。

--- append(x)
    集合に要素 ((|x|)) を付け加えた複製を返します。

--- concat(other)
    集合に別の集合 ((|other|)) の要素を付け加えます。
    （((|+|)) の破壊版です。）

--- rehash
    内部の ((|Hash|)) オブジェクトを ((|rehash|)) します。

--- eql?(other)
    集合 ((|other|)) と等しいとき、真を返します。
    (({ self >= other and self <= other})) と同値です。

--- ==
    ((<eql?>)) のエイリアスです。

--- hash
    自身が ((|Hash|)) あるいは ((|Set|)) の要素となるときに利用される
    ハッシュ値関数です。

--- include?(x)
    集合が ((|x|)) を要素としているとき、真を返します。

--- member?
--- has?
--- contains?
    ((<include?>)) のエイリアスです。

--- superset?(other)
    集合が他の集合 ((|other|)) を包含するとき真を返します。
    (({other.all{|x| member?(x)}})) と同値です。

--- >=
--- incl?
    (({superset?})) のエイリアスです。

--- subset?(other)
    集合が他の集合 ((|other|)) の部分集合であるとき真を返します。
    (({self.all{|x| other.member?(x)}})) と同値です。

--- <=
--- part_of?
    ((|subset?|)) のエイリアスです。

--- <(other)
    ((|self|)) が ((|other|)) の真部分集合の時真を返します。

--- >(other)
    ((|self|)) が ((|other|)) を真に含む時真を返します。

--- union([other])
    ((|self|)) と ((|other|)) の合併集合を返します。
    ((|other|)) が省略された場合、自身を集合の集合とみなし、全ての
    要素の合併を返します。
    
    例:
      require "finite-set"
      include Algebra
      p Set[0, 2, 4].cup Set[1, 3] #=> {0, 1, 2, 3, 4}
      s = Set[*(0...15).to_a]
      s2 = s.separate{|x| x % 2 == 0}
      s3 = s.separate{|x| x % 3 == 0}
      s5 = s.separate{|x| x % 5 == 0}
      p Set[s2, s3, s5].union #=> {1, 7, 11, 13}

--- |
--- +
--- cup
    ((|union|)) のエイリアスです。

--- intersection([other])
    ((|self|)) と ((|other|)) の交わりの集合を返します。
    ((|other|)) が省略された場合、自身を集合の集合とみなし、全ての
    要素の共通部分を返します。

    例:
      require "finite-set"
      include Algebra
      p Set[0, 2, 4].cap(Set[4, 2, 0]) #=> {0, 2, 4}
      s = Set[*(0..30).to_a]
      s2 = s.separate{|x| x % 2 == 0}
      s3 = s.separate{|x| x % 3 == 0}
      s5 = s.separate{|x| x % 5 == 0}
      p Set[s2, s3, s5].cap #=> {0, 30}

--- &
--- cap
    ((|intersection|)) のエイリアスです。


--- difference(other)
    ((|self|)) から ((|other|)) に含まれる要素を取り除いたものを返します。

--- -
    ((|difference|)) のエイリアスです。


--- each_pair
    集合から異なる２つの要素を取り出して、ブロックパラメータに
    代入して繰り返します。

    例: 
      require "finite-set"
      include Algebra
      s = Set.phi
      Set[0, 1, 2].each_pair do |x, y|
        s.push [x, y]
      end
      p s == Set[[0, 1], [0, 2], [1, 2]] #=> true

--- each_member(n)
    集合から異なる ((|n|)) 個の要素を取り出して、ブロックパラメータに
    代入して繰り返します。

    例: 
      require "finite-set"
      include Algebra
      s = Set.phi
      Set[0, 1, 2].each_member(2) do |x, y|
        s.push [x, y]
      end
      p s == Set[[0, 1], [0, 2], [1, 2]] #=> true

--- each_subset
    集合の全ての部分集合をブロックパラメータに代入して繰り返します。

    例: 
      require "finite-set"
      include Algebra
      s = Set.phi
      Set[0, 1, 2].each_subset do |t|
        s.append! t
      end
      p s.size = 2**3 #=> true

--- each_non_trivial_subset
    集合の空集合でない真部分集合をブロックパラメータに代入して繰り返します。

--- power_set
    集合の全ての部分集合の集合を返します。

--- each_product(other)
    ((|self|)) と ((|other|)) の全ての要素 ((|x|)), ((|y|)) に
    ついて、繰り返します。

   例:
      require "finite-set"
      include Algebra
      Set[0, 1].each_prodct(Set[0, 1]) do |x, y|
        p [x, y] #=> [0,0], [0,1], [1,0], [1,1]
      end

--- product(other)
    ((|self|)) と ((|other|)) の積集合を返します。積集合の各元
    は配列 (({[x, y]})) です。ブロックが与えられた時は、ブロック
    を評価した値で構成される集合を返します。

    例: 
      require "finite-set"
      include Algebra
      p Set[0, 1].product(Set[0, 1]) #=> {[0,0], [0,1], [1,0], [1,1]}
      p Set[0, 1].product(Set[0, 1]){|x, y| x + 2*y} #=> {0, 1, 2, 3]

--- *
    ((<product>)) のエイリアスです。

--- equiv_class([equiv])
    集合を同値関係で割った商集合を返します。同値関係の与え方は次の３通りあります。
    
    (1) ブロックの評価値を真にする同値関係
          require "finite-set"
          include Algebra
          s = Set[0, 1, 2, 3, 4, 5]
          p s.equiv_class{|a, b| (a - b) % 3 == 0} #=> {{0, 3}, {1, 4}, {2, 5}}
    (2) 引数に与えられたオブジェクトに対するメソッド ((|call(x, y)|)) 
        の真偽値による同値関係
          require "finite-set"
          include Algebra
          o = Object.new
          def o.call(x, y)
            (x - y) % 3 == 0
          end
          s = Set[0, 1, 2, 3, 4, 5]
          p s.equiv_class(o) #=> {{0, 3}, {1, 4}, {2, 5}}
    (3) 引数に与えられた ((|Symbol|)) に応じたメソッドによる同値関係
          require "finite-set"
          include Algebra
          s = Set[0, 1, 2, 3, 4, 5]
          def q(x, y)
            (x - y) % 3 == 0
          end
          p s.equiv_class(:q) #=> {{0, 3}, {1, 4}, {2, 5}}

--- /
    ((<equiv_class>)) のエイリアスです。

--- to_a
    集合を配列にして返します。要素の並びの順は不定です。

--- to_ary
    ((<to_a>)) のエイリアスです。

--- sort
    ((<to_a>)) の値をソートして返します。

--- power(other)
    ((|other|)) から ((|self|)) への写像全ての集合を返します。
    写像は ((<Map|URL:finite-map-ja.html>)) の元として表現されます。
 
    例: 
      require "finite-map"
      include Algebra
      a = Set[0, 1, 2, 3]
      b = Set[0, 1, 2]
      s = 
      p( (a ** b).size )      #=> 4 ** 3 = 64
      p b.surjections(a).size #=> S(3, 4) = 36
      p a.injections(b).size  #=> 4P3 = 24

--- **
    ((<power>)) のエイリアスです。

--- identity_map
    自分への恒等写像を返します。

--- surjections(other)
    ((|other|)) から ((|self|)) への全射全ての集合を返します。

#--- injections0(other)

--- injections(other)
    ((|other|)) から ((|self|)) への単射全ての集合を返します。


--- bijections(other)
    ((|other|)) から ((|self|)) への全単射全ての集合を返します。


#--- monotonic_series #what is this?

= Enumerable

== ファイル名:
* ((|finite-set.rb|))

== メソッド:

--- any?
    ブロックを真にする要素があるとき、真を返します。
    ((|Enumerable#find|)) の別名です。(built-in of ruby-1.8)

--- all?
    全ての要素についてブロックが真であるとき、真を返します。

      !any?{|x| !yield(x)}

    と定義されています。(built-in of ruby-1.8)

=end

