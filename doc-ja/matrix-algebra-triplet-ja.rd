=begin
[((<index-ja|URL:index-ja.html>))] 
((<Algebra::MatrixAlgebraTriplet>))
/
((<Algebra::MatrixAlgebraQuint>))


= Algebra::MatrixAlgebraTriplet

((*(3�g�s��̃N���X)*))

�s��ƍs��ɑ΂��鍶�E�̊�{�ό`���L�^����2�̍s���\���N���X�B���ʃN���X
��5�g�݃N���X ((<Algebra::MatrixAlgebraQuint>)) ������B

== �t�@�C����:
* ((|matrix-algebra-triplet.rb|))

== �X�[�p�[�N���X:

* ((|Object|))

== �C���N���[�h���Ă��郂�W���[��:
* ((|GaussianElimination|))
* ((|ElementaryDivisor|))


=== �N���X���\�b�h:

--- :new(matrix[, left[, right]])
    ((|matrix|)) ��{�́A((|left|))���i�s�j�ό`�̋L�^�A((|right|))
    ���E�i��j�ό`�̋L�^�Ƃ���3�g�݃I�u�W�F�N�g�𐶐����܂��B

== ���\�b�h:

--- body
    �{�̂�Ԃ��܂��B

--- left
    ���i�s�j�ό`�̋L�^��Ԃ��܂��B

--- right
    �E�i��j�ό`�̋L�^��Ԃ��܂��B

--- to_a
    (({[body, left, right]})) �Ƃ����z���Ԃ��܂��B

--- to_ary
    ((<to_a>)) �Ɠ����B

--- dup
    ���g�̕�����Ԃ��܂��B

--- transpose
    �]�u�s���Ԃ��܂��B
    
      [type.new(body.transpose, right.transpose, left.transpose]

    �Ɠ����ł��B

--- replace(other)
    ������ ((|other|)) �ƒu�������܂��B

--- display
    ������\�����܂��B

--- [](i, j)
    ������ (({(i, j)})) ������Ԃ��܂��B

--- rsize
    �s�T�C�Y��Ԃ��܂��B

--- csize
    ��T�C�Y��Ԃ��܂��B

--- each_i
    ���ׂĂ̍s�C���f�b�N�X�ɑ΂��ČJ��Ԃ��C�e���[�^�ł��B

--- each_j
    ���ׂĂ̗�C���f�b�N�X�ɑ΂��ČJ��Ԃ��C�e���[�^�ł��B

--- row!(i)
    �{�̂� ((|i|)) �s�ڂ��̂��̂�Ԃ��܂��B
    
--- sswap_r!(i, j)

--- swap_r!(i, j)

--- swap_c!(i, j)

--- multiply_r!(i, c)

--- multiply_c!(j, c)

--- divide_r!(i, c)

--- divide_c!(j, c)

--- mix_r!(i, j[, c])

--- mix_c!(i, j[, c])

--- left_eliminate!
    �ȏ�A((|Algebra::GauusianElimination|)) �̓������\�b�h���Q�ƁB


= Algebra::MatrixAlgebraQuint

((*(5�g�s��̃N���X)*))

�s��ƍs��ɑ΂��鍶�E�̊�{�ό`�A�����̋t�s����L�^�����v5��
�s���\���N���X�B��ʃN���X��3�g�݃N���X ((<Algebra::MatrixAlgebraTriplet>)) ������B

== �X�[�p�[�N���X:

* ((|Algebra:MatrixAlgebraTriplet|))


== ���\�b�h:

--- lefti
    ((<left>)) �̋t�s���Ԃ��܂��B

--- righti
    ((<right>)) �̋t�s���Ԃ��܂��B

--- to_a
    (({[body, left, right, lefti, righti]})) �Ƃ����z���Ԃ��܂��B

=end
