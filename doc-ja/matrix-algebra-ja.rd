=begin
[((<index-ja|URL:index-ja.html>))] 
((<Algebra::MatrixAlgebra>))
/
((<Algebra::Vector>))
/
((<Algebra::Covector>))
/
((<Algebra::SquareMatrix>))
/
((<Algebra::GaussianElimination>))

= Algebra::MatrixAlgebra
((*(行列クラス)*))

行列を表現します。実際のクラスを生成するには基底環とサイズを指定して、
クラスメソッド ((<::create>)) あるいは関数 ((<Algebra::MatrixAlgebra>))()
を用います。

サブクラスとして ((<Algebra::Vector>))(縦ベクトル）, 
((<Algebra::Covector>))(横ベクトル), 
((<Algebra::SquareMatrix>))(正方行列) を持ちます。

== ファイル名:
* ((|matrix-algebra.rb|))

== スーパークラス:

* ((|Object|))

== インクルードしているモジュール:

* ((<Algebra::GaussianElimination>))
* Enumerable

== 関連する関数:

--- Algebra.MatrixAlgebra(ring, m, n)
    ((<::create>))(ring, m, n)と同じです。

== クラスメソッド:

--- ::create(ring, m, n)
    環 ((|ring|)) を要素とする, (({ (m, n) })) 型の行列を
    表現するクラスを生成します。

    このメソッドの戻り値は ((<Algebra::MatrixAlgebra>)) クラスのサブクラス
    です。このサブクラスにはクラスメソッドとして ((|ground|)) と
    ((|rsize|)), ((|csize|)),  ((|sizes|)) が定義され、それぞれ、
    基底となる環 ((|ring|))、行のサイズ ((|m|))、列のサイズ ((|n|))、
    それらの配列 (({ [m, n] })) を返します。

    実際に行列を作るには ((<::new>)),  ((<::matrix>)), 
    ((<::[]>)) を使います。

--- ::new(array)
    ((|array|)) を配列の配列とするとき、それを要素とする行列を返します。

    例:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M.new([[1, 2, 3], [4, 5, 6]])
      a.display
        #=> [1, 2, 3]
        #=> [4, 5, 6]

--- ::matrix{|i, j| ... }
    ((|i|)) と ((|j|)) に行と列のインデックスを与え ... を評価した値を
    (({ (i, j) })) 成分にした行列を返します。
    
    例:
      M = Alebra.MatrixAlgebra(Integer, 2, 3)
      a = M.matrix{|i, j| 10*(i + 1) + j + 1}
      a.display
        #=> [11, 12, 13]
        #=> [21, 22, 23]

--- ::[](array1, array2, ..., arrayr)
    配列 (({array1, array2, ..., arrayr})) をそれぞれ行とする配列を返します。

    例:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M[[1, 2, 3], [4, 5, 6]]
      a.display
        #=> [1, 2, 3]
        #=> [4, 5, 6]

--- ::collect_ij{|i, j| ... }
    ((<::matrix>)) によく似ていますが、
    返り値は Algebra::MatrixAlgebra でなく、2重配列(Array の Array)です。

--- ::collect_row{|i| ... }
    第 i 行に ... を評価して得た配列を並べた行列を返します。

    例:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      A = M.collect_row{|i| [i*10 + 11, i*10 + 12, i*10 + 13]}
      A.display
        #=> [11, 12, 13]
        #=> [21, 22, 23]

--- ::collect_column{|j| ... }
    第 j 列に ... を評価して得た配列を並べた行列を返します。

    例:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      A = M.collect_column{|j| [11 + j, 21 + j]}
      A.display
        #=> [11, 12, 13]
        #=> [21, 22, 23]

--- ::*(otype)
    2つの行列の型を掛けた新しいクラスを返します。

    例:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      N = Algebra.MatrixAlgebra(Integer, 3, 4)
      L = M * N
      p L.sizes #=> [3, 4]

--- ::vector_type
    ((<rsize>)) と同じサイズの縦ベクトル(Vector)クラスを返します。

--- ::covector_type
    ((<csize>)) と同じサイズの横ベクトル(CoVector)クラスを返します。

--- ::transpose
    転置を行った新しい行列クラスを返します。

--- ::zero
    零行列を返します。

#--- ::matrices; Matrices; end
#--- ::regulate(x)

== メソッド:
#--- dup
--- [](i, j)
    (({(i, j)})) 成分を返します。

--- []=(i, j, x)
    (({(i, j)})) 成分を x にします。

--- rsize
    行サイズを返します。((<::rsize>)) と同じです。

--- csize
    列サイズを返します。((<::csize>)) と同じです。

--- sizes
    [((<rsize>)), ((<csize>))] の配列を返します。
    ((<::sizes>)) と同じです。

--- rows
    各行を要素とする配列を返します。
    
    例:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M.new([[1, 2, 3], [4, 5, 6]])
      p a.rows #=> [[1, 2, 3], [4, 5, 6]]
      p a.row(1) #=> [4, 5, 6]
      a.set_row(1, [40, 50, 60])
      a.display #=> [1, 2, 3]
                #=> [40, 50, 60]

--- row(i)
    i 行目を配列として返します。

--- set_row(i, array)
    i 行目を配列 array に入れ換えます。

--- columns
    各列を要素とする配列を返します。
    
    例:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M.new([[1, 2, 3], [4, 5, 6]])
      p a.columns #=> [[1, 4], [2, 5], [3, 6]]
      p a.column(1) #=> [2, 5]
      a.set_column(1, [20, 50])
      a.display #=> [1, 20, 3]
                #=> [4, 50, 6]

--- column(j)
    j 列目を配列として返します。

--- set_column(j, array)
    j 列目を配列 array に入れ換えます。

--- each{|row| ...}
    各行を配列にして ((|row|)) に入れるイテレータです。

--- each_index{|i, j| ...}
    各添え字 (({ (i, j) })) に関するイテレータです。

--- each_i{|i| ...}
    各行の添え字 (({i})) に関するイテレータです。

--- each_j{|j| ...}
    各列の添え字 (({j})) に関するイテレータです。

--- each_row{|r| ... }
    各行を配列にして ((|r|)) に入れるイテレータです。
    ((<each>)) と同じです。

--- each_column{|c| ... }
    各列を配列にして ((|c|)) に入れるイテレータです。

--- matrix{|i, j| ... }
    ((<::matrix>)) と同じです。

--- collect_ij{|i, j| ... }
    ((<::collect_ij>)) と同じです。

--- collect_row{|i| ... }
    ((<::collect_row>)) と同じです。

--- collect_column{|j| ... }
    ((<::collect_column>)) と同じです。

--- minor(i, j)
    ((|i|)) 行 ((|j|)) 列を除いた小行列を返します。

--- cofactor(i, j)
    ((|i|)) 行 ((|j|)) 列を除いた小行列式に (-1)**(i+j) を掛けたものを
    返します。(({minor(i, j) ** (i + j)})) と同じです。

--- cofactor_matrix
    余因子行列を返します。(({self.class.transpose.matrix{|i, j| cofactor(j, i)}})) と同じです。

--- adjoint
    ((<cofactor_matrix>)) と同じです。

--- ==(other)
    等しいとき真を返します。

--- +(other)
    和を計算します。

--- -(other)
    差を計算します。

--- *(other)
    積を計算します。
    
    例:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      N = Algebra.MatrixAlgebra(Integer, 3, 4)
      L = M * N
      a = M[[1, 2, 3], [4, 5, 6]]
      b = N[[-3, -2, -1, 0], [1, 2, 3, 4], [5, 6, 7, 8]]
      c = a * b
      p c.type  #=> L
      c.display #=> [14, 20, 26, 32]
                #=> [23, 38, 53, 68]

--- **(n)
    ((|n|)) 乗を計算します。

--- /(other)
    商を計算します。

--- rank
    階数を返します。

--- dsum(other)
    直和を返します。

    例:
      a = Algebra.MatrixAlgebra(Integer, 2, 3)[
            [1, 2, 3],
            [4, 5, 6]
          ]
      b = Algebra.MatrixAlgebra(Integer, 3, 2)[
            [-1, -2],
            [-3, -4],
            [-5, -6]
          ]
      (a.dsum b).display #=> 1,   2,   3,   0,   0
                         #=> 4,   5,   6,   0,   0
                         #=> 0,   0,   0,  -1,  -2
                         #=> 0,   0,   0,  -3,  -4
                         #=> 0,   0,   0,  -5,  -6

--- convert_to(ring)
    ((|self|)) の各成分を行列環 ((|ring|)) にコンバートします。

    Example:
      require "matrix-algebra"
      require "residue-class-ring"
      Z3 = Algebra.ResidueClassRing(Integer, 3)
      a = Algebra.MatrixAlgebra(Integer, 2, 3)[
        [1, 2, 3],
        [4, 5, 6]
      ]
      a.convert_to(Algebra.MatrixAlgebra(Z3, 2, 3)).display
                                          #=>  1,   2,   0
                                          #=>  1,   2,   0

--- to_ary
    ((|to_a|)) を返します。((|to_a|)) は ((|Enumerable|)) で定義されています。

--- flatten
    ((|to_a.flatten|)) を返します。

--- diag
    対角成分を配列で返します。

--- transpose
    転置行列を返します。

    例:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M.new([[1, 2, 3], [4, 5, 6]])
      Mt = M.transpose
      b = a.transpose
      p b.type  #=> Mt
      b.display #=> [1, 4]
                #=> [2, 5]
                #=> [3, 6]

#--- to_s

--- dup
    複製します。
    
    例:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M.new([[1, 2, 3], [4, 5, 6]])
      b = a.dup
      b[1, 1] = 50
      a.display #=> [1, 2, 3]
                #=> [4, 5, 6]
      b.display #=> [1, 2, 3]
                #=> [4, 50, 6]

--- display([out])
    行列を ((|out|)) に表示します。((|out|)) が省略されると ((|$stdout|))
    に表示します。
    
#--- inspect

= Algebra::Vector
((*(縦ベクトルクラス)*))

ベクトルのクラスです。

== スーパークラス:

* ((|Algebra::MatrixAlgebra|))

== インクルードしているモジュール:

なし

== 関連する関数:

--- Algebra.Vector(ring, n)
    ((<Algebra::Vector::create>))(ring, n) と同じです。

== クラスメソッド:

--- Algebra::Vector::create(ring, n)
    環 ((|ring|)) を要素とする, ((|n|)) 次元のベクトル（縦ベクトル）
    表現するクラスを生成します。

    このメソッドの戻り値は ((<Algebra::Vector>)) クラスのサブクラス
    です。このサブクラスにはクラスメソッドとして ((|ground|)) と
    ((|size|)) が定義され、それぞれ、基底となる環 ((|ring|))、
    サイズ ((|n|)) を返します。

    実際にベクトルを作るにはクラスメソッド ((|new|)),  
    ((|matrix|)), 
    ((|[]|)) を使います。
    
    ((<Algebra::Vector>)) は ((|n|)) 行 1 列の 
    ((<Algebra::MatrixAlgebra>)) と同一視されます。

--- Algebra::Vector::new(array)
    ((|array|)) を配列とするとき、それを要素とす
    る縦ベクトルを返します。

    例:
      V = Algebra.Vector(Integer, 3)
      a = V.new([1, 2, 3])
      a.display
        #=> [1]
        #=> [2]
        #=> [3]

--- Algebra::Vector::vector{|i| ... }
    第 ((|i|)) 成分を ... にしたベクトルを返します。

    例:
      V = Algebra.Vector(Integer, 3)
      a = V.vector{|j| j + 1}
      a.display
        #=> [1]
        #=> [2]
        #=> [3]

--- Algebra::Vector::matrix{|i, j| ... }
    第 ((|i|)) 成分を ... にしたベクトルを返します。
    ((|j|)) には常に 0 が代入されます。

== メソッド:

--- size
    次元を返します。

--- to_a
    各成分を配列にして返します。

--- transpose
    横ベクトル ((<Algebra::Covector>)) に転置します。

--- inner_product(other)
    ((|other|)) との内積を返します。

--- inner_product_complex(other)
    ((|other|)) との内積を返します。
    (({inner_product(other.conjugate)}))と同じです。

--- norm2
    ノルムを返します。
    (({inner_product(self)}))と同じです。

--- norm2_complex
    ノルムを返します。
    (({inner_product(self.conjugate)}))と同じです。


= Algebra::Covector
((*(横ベクトルクラス)*))

ベクトルのクラスです。

== スーパークラス:
* ((|Algebra::MatrixAlgebra|))

== インクルードしているモジュール:

なし

== 関連する関数:

--- Algebra.Covector(ring, n)
    ((<Algebra::Covector::create>)) (ring n)と同じです。

== クラスメソッド:

--- Algebra::Covector::create(ring, n)
    環 ((|ring|)) を要素とする, ((|n|)) 次元のベクトル（横ベクトル）
    表現するクラスを生成します。

    このメソッドの戻り値は ((<Algebra::Covector>)) クラスのサブクラス
    です。このサブクラスにはクラスメソッドとして ((|ground|)) と
    ((|size|)) が定義され、それぞれ、基底となる環 ((|ring|))、
    サイズ ((|n|)) を返します。

    実際にベクトルを作るにはクラスメソッド ((|new|)), 
    ((|matrix|)), 
    ((|[]|)) を使います。
    
    ((<Algebra::Covector>)) は 1 行 ((|n|)) 列の ((<Algebra::MatrixAlgebra>)) と
    同一視されます。

--- Algebra::Covector::new(array)
    ((|array|)) を配列とするとき、それを要素とす
    る横ベクトルを返します。

    例:
      V = Algebra.Covector(Integer, 3)
      a = V.new([1, 2, 3])
      a.display
        #=> [1, 2, 3]

--- Algebra::Covector::covector{|j| ... }
    第 j 成分を ... にしたベクトルを返します。

    例:
      V = Algebra.Covector(Integer, 3)
      a = V.covector{|j| j + 1}
      a.display
        #=> [1, 2, 3]

--- Algebra::Covector::matrix{|i, j| ... }
    第 j 成分を ... にしたベクトルを返します。i には常に 0 が代入されます。

== メソッド:

--- size
    次元を返します。

--- to_a
    各成分を配列にして返します。

--- transpose
    横ベクトル ((<Algebra::Vector>)) に転置します。

--- inner_product(other)
    ((|other|)) との内積を返します。

--- inner_product_complex(other)
    ((|other|)) との内積を返します。
    (({inner_product(other.conjugate)}))と同じです。

--- norm2
    ノルムを返します。
    (({inner_product(self)}))と同じです。

--- norm2_complex
    ノルムを返します。
    (({inner_product(self.conjugate)}))と同じです。

= Algebra::SquareMatrix
((*(正方行列環クラス)*))

正方行列の作る環を表現するクラスです。

== スーパークラス:

* ((|Algebra::MatrixAlgebra|))

== インクルードしているモジュール:

なし

== 関連する関数:

--- Algebra.SquareMatrix(ring, size)
    ((<Algebra::SquareMatrix::create>))(ring, n) と同じです。

== クラスメソッド:

--- Algebra::SquareMatrix::create(ring, n)

    正方行列表現するクラスを生成します。

    このメソッドの戻り値は 
    ((<Algebra::SquareMatrix>)) クラスのサブクラス
    です。このサブクラスにはクラスメソッドとして 
    ((|ground|)) と
    ((|size|)) が定義され、それぞれ、基底となる環 ((|ring|))、
    サイズ ((|n|)) を返します。

    SquareMatrix は ((|n|)) 行 ((|n|)) 列の Algebra::MatrixAlgebra と同一視されます。

    実際に行列を作るにはクラスメソッド ((|new|)),  
    ((|matrix|)), 
    ((|[]|)) を使います。
    
--- Algebra::SquareMatrix.determinant(aa)
    配列の配列 ((|aa|)) の行列式を返します。

--- Algebra::SquareMatrix.det(aa)
    ((<Algebra::SquareMatrix.determinat>))と同じです。

--- Algebra::SquareMatrix::unity
    単位行列を返します。

--- Algebra::SquareMatrix::zero
    零行列を返します。

--- Algebra::SquareMatrix.const(x)
    成分が ((|x|)) のスカラー行列を返します。

#--- self.regulate(x)

== メソッド
--- size
    サイズを返します。

--- const(x)
    成分が ((|x|)) のスカラー行列を返します。
#--- self.matrices
--- determinant
    行列式を返します。

--- inverse
    逆行列を返します。

--- /(other)
    (({self * other.inverse})) を返します。((|other|)) がスカラーなら
    各要素を ((|other|)) で割ります。

#--- sign(a)
#--- perm

--- char_polynomial(ring)
    ((|ring|)) に多項式環を与えると、特性多項式を返します。

--- char_matrix(ring)
    ((|ring|)) に多項式環を与えると、特性行列を返します。

--- _char_matrix(poly_ring_matrix)
    ((|poly_ring_matrix|)) に多項式成分の行列環を与えると、特性行列を返します。

= Algebra::GaussianElimination
((*(ガウスの消去法モジュール)*))

ガウスの掃き出し法を実現するモジュールです。

== ファイル名:
((|gaussian-elimination.rb|))

== インクルードしているモジュール:

なし

== クラスメソッド:

なし

== メソッド

--- swap_r!(i, j)
    ((|i|)) 行と ((|j|)) 行を入れ換えます。

--- swap_r(i, j)
    ((|i|)) 行と ((|j|)) 行を入れ換えたものを返します。

--- swap_c!(i, j)
    ((|i|)) 列と ((|j|)) 列を入れ換えます。

--- swap_c(i, j)
    ((|i|)) 列と ((|j|)) 列を入れ換えたものを返します。

--- multiply_r!(i, c)
    ((|i|)) 行目を ((|c|)) 倍します。

--- multiply_r(i, c)
    ((|i|)) 行目を ((|c|)) 倍したものを返します。

--- multiply_c!(j, c)
    ((|j|)) 列目を ((|c|)) 倍します。

--- multiply_c(j, c)
    ((|j|)) 列目を ((|c|)) 倍したものを返します。

--- divide_r!(i, c)
    ((|i|)) 行目を ((|c|)) で割ります。

--- divide_r(i, c)
    ((|i|)) 行目を ((|c|)) 割ったものを返します。

--- divide_c!(j, c)
    ((|j|)) 列目を ((|c|)) で割ります。

--- divide_c(j, c)
    ((|j|)) 列目を ((|c|)) 割ったものを返します。

--- mix_r!(i, j, c)
    ((|i|)) 行目に ((|j|)) 行目の ((|c|)) 倍を足します。

--- mix_r(i, j, c)
    ((|i|)) 行目に ((|j|)) 行目の ((|c|)) 倍を足したものを返します。

--- mix_c!(i, j, c)
    ((|i|)) 列目に ((|j|)) 列目の ((|c|)) 倍を足します。

--- mix_c(i, j, c)
    ((|i|)) 列目に ((|j|)) 列目の ((|c|)) 倍を足したものを返します。

--- left_eliminate!
    左からの基本変形で階段行列に変形します。
    
    戻り値は、変形するのに使った正方行列の積とその正方行列の
    行列式と階数の配列です。
    
    例:
      require "matrix-algebra"
      require "mathn"
      class Rational < Numeric
        def inspect; to_s; end
      end
      M = Algebra.MatrixAlgebra(Rational, 4, 3)
      a = M.matrix{|i, j| i*10 + j}
      b = a.dup
      c, d, e = b.left_eliminate!
      b.display #=> [1, 0, -1]
                #=> [0, 1, 2]
                #=> [0, 0, 0]
                #=> [0, 0, 0]
      c.display #=> [-11/10, 1/10, 0, 0]
                #=> [1, 0, 0, 0]
                #=> [1, -2, 1, 0]
                #=> [2, -3, 0, 1]
      p c*a == b#=> true
      p d       #=> 1/10
      p e       #=> 2

--- left_inverse
    左からの基本変形による一般逆行列です。

--- left_sweep
    左からの基本変形で階段行列にして返します。

--- step_matrix?
    階段行列であるとき、軸(pivot)の配列を返します。そうでないとき、nil
    を返します。

--- kernel_basis
    右から掛けて零になるベクトルの空間の基底の配列を返します。
    各基底は ((<Algebra::Vector>)) の要素です。

    例:
      require "matrix-algebra"
      require "mathn"
      M = Algebra.MatrixAlgebra(Rational, 5, 4)
      a = M.matrix{|i, j| i + j}
      a.display #=>
        #[0, 1, 2, 3]
        #[1, 2, 3, 4]
        #[2, 3, 4, 5]
        #[3, 4, 5, 6]
        #[4, 5, 6, 7]
      a.kernel_basis.each do |v|
        puts "a * #{v} = #{a * v}"
          #=> a * [1, -2, 1, 0] = [0, 0, 0, 0, 0]
          #=> a * [2, -3, 0, 1] = [0, 0, 0, 0, 0]
      end

--- determinant_by_elimination
    体上の正方行列の行列式を掃き出し法で求めます。
    
=end

