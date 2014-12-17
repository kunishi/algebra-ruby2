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
((*(�s��N���X)*))

�s���\�����܂��B���ۂ̃N���X�𐶐�����ɂ͊��ƃT�C�Y���w�肵�āA
�N���X���\�b�h ((<::create>)) ���邢�͊֐� ((<Algebra::MatrixAlgebra>))()
��p���܂��B

�T�u�N���X�Ƃ��� ((<Algebra::Vector>))(�c�x�N�g���j, 
((<Algebra::Covector>))(���x�N�g��), 
((<Algebra::SquareMatrix>))(�����s��) �������܂��B

== �t�@�C����:
* ((|matrix-algebra.rb|))

== �X�[�p�[�N���X:

* ((|Object|))

== �C���N���[�h���Ă��郂�W���[��:

* ((<Algebra::GaussianElimination>))
* Enumerable

== �֘A����֐�:

--- Algebra.MatrixAlgebra(ring, m, n)
    ((<::create>))(ring, m, n)�Ɠ����ł��B

== �N���X���\�b�h:

--- ::create(ring, m, n)
    �� ((|ring|)) ��v�f�Ƃ���, (({ (m, n) })) �^�̍s���
    �\������N���X�𐶐����܂��B

    ���̃��\�b�h�̖߂�l�� ((<Algebra::MatrixAlgebra>)) �N���X�̃T�u�N���X
    �ł��B���̃T�u�N���X�ɂ̓N���X���\�b�h�Ƃ��� ((|ground|)) ��
    ((|rsize|)), ((|csize|)),  ((|sizes|)) ����`����A���ꂼ��A
    ���ƂȂ�� ((|ring|))�A�s�̃T�C�Y ((|m|))�A��̃T�C�Y ((|n|))�A
    �����̔z�� (({ [m, n] })) ��Ԃ��܂��B

    ���ۂɍs������ɂ� ((<::new>)),  ((<::matrix>)), 
    ((<::[]>)) ���g���܂��B

--- ::new(array)
    ((|array|)) ��z��̔z��Ƃ���Ƃ��A�����v�f�Ƃ���s���Ԃ��܂��B

    ��:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M.new([[1, 2, 3], [4, 5, 6]])
      a.display
        #=> [1, 2, 3]
        #=> [4, 5, 6]

--- ::matrix{|i, j| ... }
    ((|i|)) �� ((|j|)) �ɍs�Ɨ�̃C���f�b�N�X��^�� ... ��]�������l��
    (({ (i, j) })) �����ɂ����s���Ԃ��܂��B
    
    ��:
      M = Alebra.MatrixAlgebra(Integer, 2, 3)
      a = M.matrix{|i, j| 10*(i + 1) + j + 1}
      a.display
        #=> [11, 12, 13]
        #=> [21, 22, 23]

--- ::[](array1, array2, ..., arrayr)
    �z�� (({array1, array2, ..., arrayr})) �����ꂼ��s�Ƃ���z���Ԃ��܂��B

    ��:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M[[1, 2, 3], [4, 5, 6]]
      a.display
        #=> [1, 2, 3]
        #=> [4, 5, 6]

--- ::collect_ij{|i, j| ... }
    ((<::matrix>)) �ɂ悭���Ă��܂����A
    �Ԃ�l�� Algebra::MatrixAlgebra �łȂ��A2�d�z��(Array �� Array)�ł��B

--- ::collect_row{|i| ... }
    �� i �s�� ... ��]�����ē����z�����ׂ��s���Ԃ��܂��B

    ��:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      A = M.collect_row{|i| [i*10 + 11, i*10 + 12, i*10 + 13]}
      A.display
        #=> [11, 12, 13]
        #=> [21, 22, 23]

--- ::collect_column{|j| ... }
    �� j ��� ... ��]�����ē����z�����ׂ��s���Ԃ��܂��B

    ��:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      A = M.collect_column{|j| [11 + j, 21 + j]}
      A.display
        #=> [11, 12, 13]
        #=> [21, 22, 23]

--- ::*(otype)
    2�̍s��̌^���|�����V�����N���X��Ԃ��܂��B

    ��:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      N = Algebra.MatrixAlgebra(Integer, 3, 4)
      L = M * N
      p L.sizes #=> [3, 4]

--- ::vector_type
    ((<rsize>)) �Ɠ����T�C�Y�̏c�x�N�g��(Vector)�N���X��Ԃ��܂��B

--- ::covector_type
    ((<csize>)) �Ɠ����T�C�Y�̉��x�N�g��(CoVector)�N���X��Ԃ��܂��B

--- ::transpose
    �]�u���s�����V�����s��N���X��Ԃ��܂��B

--- ::zero
    ��s���Ԃ��܂��B

#--- ::matrices; Matrices; end
#--- ::regulate(x)

== ���\�b�h:
#--- dup
--- [](i, j)
    (({(i, j)})) ������Ԃ��܂��B

--- []=(i, j, x)
    (({(i, j)})) ������ x �ɂ��܂��B

--- rsize
    �s�T�C�Y��Ԃ��܂��B((<::rsize>)) �Ɠ����ł��B

--- csize
    ��T�C�Y��Ԃ��܂��B((<::csize>)) �Ɠ����ł��B

--- sizes
    [((<rsize>)), ((<csize>))] �̔z���Ԃ��܂��B
    ((<::sizes>)) �Ɠ����ł��B

--- rows
    �e�s��v�f�Ƃ���z���Ԃ��܂��B
    
    ��:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M.new([[1, 2, 3], [4, 5, 6]])
      p a.rows #=> [[1, 2, 3], [4, 5, 6]]
      p a.row(1) #=> [4, 5, 6]
      a.set_row(1, [40, 50, 60])
      a.display #=> [1, 2, 3]
                #=> [40, 50, 60]

--- row(i)
    i �s�ڂ�z��Ƃ��ĕԂ��܂��B

--- set_row(i, array)
    i �s�ڂ�z�� array �ɓ��ꊷ���܂��B

--- columns
    �e���v�f�Ƃ���z���Ԃ��܂��B
    
    ��:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M.new([[1, 2, 3], [4, 5, 6]])
      p a.columns #=> [[1, 4], [2, 5], [3, 6]]
      p a.column(1) #=> [2, 5]
      a.set_column(1, [20, 50])
      a.display #=> [1, 20, 3]
                #=> [4, 50, 6]

--- column(j)
    j ��ڂ�z��Ƃ��ĕԂ��܂��B

--- set_column(j, array)
    j ��ڂ�z�� array �ɓ��ꊷ���܂��B

--- each{|row| ...}
    �e�s��z��ɂ��� ((|row|)) �ɓ����C�e���[�^�ł��B

--- each_index{|i, j| ...}
    �e�Y���� (({ (i, j) })) �Ɋւ���C�e���[�^�ł��B

--- each_i{|i| ...}
    �e�s�̓Y���� (({i})) �Ɋւ���C�e���[�^�ł��B

--- each_j{|j| ...}
    �e��̓Y���� (({j})) �Ɋւ���C�e���[�^�ł��B

--- each_row{|r| ... }
    �e�s��z��ɂ��� ((|r|)) �ɓ����C�e���[�^�ł��B
    ((<each>)) �Ɠ����ł��B

--- each_column{|c| ... }
    �e���z��ɂ��� ((|c|)) �ɓ����C�e���[�^�ł��B

--- matrix{|i, j| ... }
    ((<::matrix>)) �Ɠ����ł��B

--- collect_ij{|i, j| ... }
    ((<::collect_ij>)) �Ɠ����ł��B

--- collect_row{|i| ... }
    ((<::collect_row>)) �Ɠ����ł��B

--- collect_column{|j| ... }
    ((<::collect_column>)) �Ɠ����ł��B

--- minor(i, j)
    ((|i|)) �s ((|j|)) ������������s���Ԃ��܂��B

--- cofactor(i, j)
    ((|i|)) �s ((|j|)) ������������s�񎮂� (-1)**(i+j) ���|�������̂�
    �Ԃ��܂��B(({minor(i, j) ** (i + j)})) �Ɠ����ł��B

--- cofactor_matrix
    �]���q�s���Ԃ��܂��B(({self.class.transpose.matrix{|i, j| cofactor(j, i)}})) �Ɠ����ł��B

--- adjoint
    ((<cofactor_matrix>)) �Ɠ����ł��B

--- ==(other)
    �������Ƃ��^��Ԃ��܂��B

--- +(other)
    �a���v�Z���܂��B

--- -(other)
    �����v�Z���܂��B

--- *(other)
    �ς��v�Z���܂��B
    
    ��:
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
    ((|n|)) ����v�Z���܂��B

--- /(other)
    �����v�Z���܂��B

--- rank
    �K����Ԃ��܂��B

--- dsum(other)
    ���a��Ԃ��܂��B

    ��:
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
    ((|self|)) �̊e�������s��� ((|ring|)) �ɃR���o�[�g���܂��B

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
    ((|to_a|)) ��Ԃ��܂��B((|to_a|)) �� ((|Enumerable|)) �Œ�`����Ă��܂��B

--- flatten
    ((|to_a.flatten|)) ��Ԃ��܂��B

--- diag
    �Ίp������z��ŕԂ��܂��B

--- transpose
    �]�u�s���Ԃ��܂��B

    ��:
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
    �������܂��B
    
    ��:
      M = Algebra.MatrixAlgebra(Integer, 2, 3)
      a = M.new([[1, 2, 3], [4, 5, 6]])
      b = a.dup
      b[1, 1] = 50
      a.display #=> [1, 2, 3]
                #=> [4, 5, 6]
      b.display #=> [1, 2, 3]
                #=> [4, 50, 6]

--- display([out])
    �s��� ((|out|)) �ɕ\�����܂��B((|out|)) ���ȗ������� ((|$stdout|))
    �ɕ\�����܂��B
    
#--- inspect

= Algebra::Vector
((*(�c�x�N�g���N���X)*))

�x�N�g���̃N���X�ł��B

== �X�[�p�[�N���X:

* ((|Algebra::MatrixAlgebra|))

== �C���N���[�h���Ă��郂�W���[��:

�Ȃ�

== �֘A����֐�:

--- Algebra.Vector(ring, n)
    ((<Algebra::Vector::create>))(ring, n) �Ɠ����ł��B

== �N���X���\�b�h:

--- Algebra::Vector::create(ring, n)
    �� ((|ring|)) ��v�f�Ƃ���, ((|n|)) �����̃x�N�g���i�c�x�N�g���j
    �\������N���X�𐶐����܂��B

    ���̃��\�b�h�̖߂�l�� ((<Algebra::Vector>)) �N���X�̃T�u�N���X
    �ł��B���̃T�u�N���X�ɂ̓N���X���\�b�h�Ƃ��� ((|ground|)) ��
    ((|size|)) ����`����A���ꂼ��A���ƂȂ�� ((|ring|))�A
    �T�C�Y ((|n|)) ��Ԃ��܂��B

    ���ۂɃx�N�g�������ɂ̓N���X���\�b�h ((|new|)),  
    ((|matrix|)), 
    ((|[]|)) ���g���܂��B
    
    ((<Algebra::Vector>)) �� ((|n|)) �s 1 ��� 
    ((<Algebra::MatrixAlgebra>)) �Ɠ��ꎋ����܂��B

--- Algebra::Vector::new(array)
    ((|array|)) ��z��Ƃ���Ƃ��A�����v�f�Ƃ�
    ��c�x�N�g����Ԃ��܂��B

    ��:
      V = Algebra.Vector(Integer, 3)
      a = V.new([1, 2, 3])
      a.display
        #=> [1]
        #=> [2]
        #=> [3]

--- Algebra::Vector::vector{|i| ... }
    �� ((|i|)) ������ ... �ɂ����x�N�g����Ԃ��܂��B

    ��:
      V = Algebra.Vector(Integer, 3)
      a = V.vector{|j| j + 1}
      a.display
        #=> [1]
        #=> [2]
        #=> [3]

--- Algebra::Vector::matrix{|i, j| ... }
    �� ((|i|)) ������ ... �ɂ����x�N�g����Ԃ��܂��B
    ((|j|)) �ɂ͏�� 0 ���������܂��B

== ���\�b�h:

--- size
    ������Ԃ��܂��B

--- to_a
    �e������z��ɂ��ĕԂ��܂��B

--- transpose
    ���x�N�g�� ((<Algebra::Covector>)) �ɓ]�u���܂��B

--- inner_product(other)
    ((|other|)) �Ƃ̓��ς�Ԃ��܂��B

--- inner_product_complex(other)
    ((|other|)) �Ƃ̓��ς�Ԃ��܂��B
    (({inner_product(other.conjugate)}))�Ɠ����ł��B

--- norm2
    �m������Ԃ��܂��B
    (({inner_product(self)}))�Ɠ����ł��B

--- norm2_complex
    �m������Ԃ��܂��B
    (({inner_product(self.conjugate)}))�Ɠ����ł��B


= Algebra::Covector
((*(���x�N�g���N���X)*))

�x�N�g���̃N���X�ł��B

== �X�[�p�[�N���X:
* ((|Algebra::MatrixAlgebra|))

== �C���N���[�h���Ă��郂�W���[��:

�Ȃ�

== �֘A����֐�:

--- Algebra.Covector(ring, n)
    ((<Algebra::Covector::create>)) (ring n)�Ɠ����ł��B

== �N���X���\�b�h:

--- Algebra::Covector::create(ring, n)
    �� ((|ring|)) ��v�f�Ƃ���, ((|n|)) �����̃x�N�g���i���x�N�g���j
    �\������N���X�𐶐����܂��B

    ���̃��\�b�h�̖߂�l�� ((<Algebra::Covector>)) �N���X�̃T�u�N���X
    �ł��B���̃T�u�N���X�ɂ̓N���X���\�b�h�Ƃ��� ((|ground|)) ��
    ((|size|)) ����`����A���ꂼ��A���ƂȂ�� ((|ring|))�A
    �T�C�Y ((|n|)) ��Ԃ��܂��B

    ���ۂɃx�N�g�������ɂ̓N���X���\�b�h ((|new|)), 
    ((|matrix|)), 
    ((|[]|)) ���g���܂��B
    
    ((<Algebra::Covector>)) �� 1 �s ((|n|)) ��� ((<Algebra::MatrixAlgebra>)) ��
    ���ꎋ����܂��B

--- Algebra::Covector::new(array)
    ((|array|)) ��z��Ƃ���Ƃ��A�����v�f�Ƃ�
    �鉡�x�N�g����Ԃ��܂��B

    ��:
      V = Algebra.Covector(Integer, 3)
      a = V.new([1, 2, 3])
      a.display
        #=> [1, 2, 3]

--- Algebra::Covector::covector{|j| ... }
    �� j ������ ... �ɂ����x�N�g����Ԃ��܂��B

    ��:
      V = Algebra.Covector(Integer, 3)
      a = V.covector{|j| j + 1}
      a.display
        #=> [1, 2, 3]

--- Algebra::Covector::matrix{|i, j| ... }
    �� j ������ ... �ɂ����x�N�g����Ԃ��܂��Bi �ɂ͏�� 0 ���������܂��B

== ���\�b�h:

--- size
    ������Ԃ��܂��B

--- to_a
    �e������z��ɂ��ĕԂ��܂��B

--- transpose
    ���x�N�g�� ((<Algebra::Vector>)) �ɓ]�u���܂��B

--- inner_product(other)
    ((|other|)) �Ƃ̓��ς�Ԃ��܂��B

--- inner_product_complex(other)
    ((|other|)) �Ƃ̓��ς�Ԃ��܂��B
    (({inner_product(other.conjugate)}))�Ɠ����ł��B

--- norm2
    �m������Ԃ��܂��B
    (({inner_product(self)}))�Ɠ����ł��B

--- norm2_complex
    �m������Ԃ��܂��B
    (({inner_product(self.conjugate)}))�Ɠ����ł��B

= Algebra::SquareMatrix
((*(�����s��N���X)*))

�����s��̍���\������N���X�ł��B

== �X�[�p�[�N���X:

* ((|Algebra::MatrixAlgebra|))

== �C���N���[�h���Ă��郂�W���[��:

�Ȃ�

== �֘A����֐�:

--- Algebra.SquareMatrix(ring, size)
    ((<Algebra::SquareMatrix::create>))(ring, n) �Ɠ����ł��B

== �N���X���\�b�h:

--- Algebra::SquareMatrix::create(ring, n)

    �����s��\������N���X�𐶐����܂��B

    ���̃��\�b�h�̖߂�l�� 
    ((<Algebra::SquareMatrix>)) �N���X�̃T�u�N���X
    �ł��B���̃T�u�N���X�ɂ̓N���X���\�b�h�Ƃ��� 
    ((|ground|)) ��
    ((|size|)) ����`����A���ꂼ��A���ƂȂ�� ((|ring|))�A
    �T�C�Y ((|n|)) ��Ԃ��܂��B

    SquareMatrix �� ((|n|)) �s ((|n|)) ��� Algebra::MatrixAlgebra �Ɠ��ꎋ����܂��B

    ���ۂɍs������ɂ̓N���X���\�b�h ((|new|)),  
    ((|matrix|)), 
    ((|[]|)) ���g���܂��B
    
--- Algebra::SquareMatrix.determinant(aa)
    �z��̔z�� ((|aa|)) �̍s�񎮂�Ԃ��܂��B

--- Algebra::SquareMatrix.det(aa)
    ((<Algebra::SquareMatrix.determinat>))�Ɠ����ł��B

--- Algebra::SquareMatrix::unity
    �P�ʍs���Ԃ��܂��B

--- Algebra::SquareMatrix::zero
    ��s���Ԃ��܂��B

--- Algebra::SquareMatrix.const(x)
    ������ ((|x|)) �̃X�J���[�s���Ԃ��܂��B

#--- self.regulate(x)

== ���\�b�h
--- size
    �T�C�Y��Ԃ��܂��B

--- const(x)
    ������ ((|x|)) �̃X�J���[�s���Ԃ��܂��B
#--- self.matrices
--- determinant
    �s�񎮂�Ԃ��܂��B

--- inverse
    �t�s���Ԃ��܂��B

--- /(other)
    (({self * other.inverse})) ��Ԃ��܂��B((|other|)) ���X�J���[�Ȃ�
    �e�v�f�� ((|other|)) �Ŋ���܂��B

#--- sign(a)
#--- perm

--- char_polynomial(ring)
    ((|ring|)) �ɑ�������^����ƁA������������Ԃ��܂��B

--- char_matrix(ring)
    ((|ring|)) �ɑ�������^����ƁA�����s���Ԃ��܂��B

--- _char_matrix(poly_ring_matrix)
    ((|poly_ring_matrix|)) �ɑ����������̍s���^����ƁA�����s���Ԃ��܂��B

= Algebra::GaussianElimination
((*(�K�E�X�̏����@���W���[��)*))

�K�E�X�̑|���o���@���������郂�W���[���ł��B

== �t�@�C����:
((|gaussian-elimination.rb|))

== �C���N���[�h���Ă��郂�W���[��:

�Ȃ�

== �N���X���\�b�h:

�Ȃ�

== ���\�b�h

--- swap_r!(i, j)
    ((|i|)) �s�� ((|j|)) �s����ꊷ���܂��B

--- swap_r(i, j)
    ((|i|)) �s�� ((|j|)) �s����ꊷ�������̂�Ԃ��܂��B

--- swap_c!(i, j)
    ((|i|)) ��� ((|j|)) �����ꊷ���܂��B

--- swap_c(i, j)
    ((|i|)) ��� ((|j|)) �����ꊷ�������̂�Ԃ��܂��B

--- multiply_r!(i, c)
    ((|i|)) �s�ڂ� ((|c|)) �{���܂��B

--- multiply_r(i, c)
    ((|i|)) �s�ڂ� ((|c|)) �{�������̂�Ԃ��܂��B

--- multiply_c!(j, c)
    ((|j|)) ��ڂ� ((|c|)) �{���܂��B

--- multiply_c(j, c)
    ((|j|)) ��ڂ� ((|c|)) �{�������̂�Ԃ��܂��B

--- divide_r!(i, c)
    ((|i|)) �s�ڂ� ((|c|)) �Ŋ���܂��B

--- divide_r(i, c)
    ((|i|)) �s�ڂ� ((|c|)) ���������̂�Ԃ��܂��B

--- divide_c!(j, c)
    ((|j|)) ��ڂ� ((|c|)) �Ŋ���܂��B

--- divide_c(j, c)
    ((|j|)) ��ڂ� ((|c|)) ���������̂�Ԃ��܂��B

--- mix_r!(i, j, c)
    ((|i|)) �s�ڂ� ((|j|)) �s�ڂ� ((|c|)) �{�𑫂��܂��B

--- mix_r(i, j, c)
    ((|i|)) �s�ڂ� ((|j|)) �s�ڂ� ((|c|)) �{�𑫂������̂�Ԃ��܂��B

--- mix_c!(i, j, c)
    ((|i|)) ��ڂ� ((|j|)) ��ڂ� ((|c|)) �{�𑫂��܂��B

--- mix_c(i, j, c)
    ((|i|)) ��ڂ� ((|j|)) ��ڂ� ((|c|)) �{�𑫂������̂�Ԃ��܂��B

--- left_eliminate!
    ������̊�{�ό`�ŊK�i�s��ɕό`���܂��B
    
    �߂�l�́A�ό`����̂Ɏg���������s��̐ςƂ��̐����s���
    �s�񎮂ƊK���̔z��ł��B
    
    ��:
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
    ������̊�{�ό`�ɂ���ʋt�s��ł��B

--- left_sweep
    ������̊�{�ό`�ŊK�i�s��ɂ��ĕԂ��܂��B

--- step_matrix?
    �K�i�s��ł���Ƃ��A��(pivot)�̔z���Ԃ��܂��B�����łȂ��Ƃ��Anil
    ��Ԃ��܂��B

--- kernel_basis
    �E����|���ė�ɂȂ�x�N�g���̋�Ԃ̊��̔z���Ԃ��܂��B
    �e���� ((<Algebra::Vector>)) �̗v�f�ł��B

    ��:
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
    �̏�̐����s��̍s�񎮂�|���o���@�ŋ��߂܂��B
    
=end

