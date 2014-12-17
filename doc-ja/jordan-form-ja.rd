=begin
[((<index-ja|URL:index-ja.html>))] 
= Algebra::JordanForm
((*(�W�����_���s��N���X)*))

�W�����_���s���\������N���X�ł��B

== �t�@�C����:
* ((|jordan-form.rb|))

== �X�[�p�[�N���X:

* ((|Object|))

== �C���N���[�h���Ă��郂�W���[��:

�Ȃ�

== �֘A����֐�:

--- Algebra::MatrixAlgebra#jordan_form
    ((|self|))�̃W�����_���W���`��Ԃ��܂��B

--- Algebra::MatrixAlgebra#jordan_form_info
    ((<Algebra::JordanForm.decompose>))(self) �Ɠ����ł��B

== �N���X���\�b�h:

--- ::new(array)
    ((<JordanForm>)) �I�u�W�F�N�g��Ԃ��܂��B((|array|)) �́A
    (({[�Ίp����, �T�C�Y]})) ��v�f�Ƃ���z��ł��B�s��𓾂�ɂ�
    ���\�b�h ((<to_matrix>)) ���{�����Ƃɂ��A�i��O�p�j�W�����_��
    �s�񂪓����܂��B���O�p�ɂ���ɂ�((<to_matrix_l>))��p���܂��B

    ��:
      j = Algebra::JordanForm.new([[2, 3], [-1, 2]])
      j.to_matrix.display #=>
      #  2,   1,   0,   0,   0
      #  0,   2,   1,   0,   0
      #  0,   0,   2,   0,   0
      #  0,   0,   0,  -1,   1
      #  0,   0,   0,   0,  -1

--- ::construct(elem_divs, facts, field, pfield)
    ���B

--- ::decompose(m)
    �s�� ((|m|)) �̃W�����_���s��� ((|jm|))�A((|m|)) �� ((|jm|)) ��
    �ό`���邽�߂ɕK�v�ȍ��ό`�� ((|tL|))�A�E�ό`�� ((|sR|))�A�W�����_��
    ����������̂ɕK�v�ȍŏ�����̂� ((|field|)) �A�ŏ�����̂܂Ŋ�b��
    ���g�傷��̂ɕK�v�ȕ������̔z��� ((|modulus|)) �Ƃ���Ƃ��A

      [jm, tL, sR, field, modulus]

    ��Ԃ��܂��B�i(({tL * sR == �P�ʍs��})) �ł��B�j

    ��:
      m = Algebra.SquareMatrix(Rational, a.size)[
       [-1, 1, 2, -1],
       [-5, 3, 4, -2],
       [3, -1, 0, 1],
       [5, -2, -2, 0]
      ]
      jf, p, q, field, modulus = Algebra::JordanForm.decompose(m)
      jf.display; puts #=>
      #  2,   0,   0,   0
      #  0,   a,   0,   0
      #  0,   0,   b,   0
      #  0,   0,   0, -b - a

      p modulus #=> [a^3 + 3a - 1, b^2 + ab + a^2 + 3]

      print "P =\n"; p.display; puts
      print "P^-1 =\n"; q.display; puts

      m = m.convert_to(field)
      p jf == p * m * q #=> true

== ���\�b�h:

--- to_matrix(ring)
    ((|ring|)) ��̃W�����_���s��i��O�p�j��Ԃ��܂��B

    ��:
      j = Algebra::JordanForm.new([[2, 3], [-1, 2]])
      j.to_matrix(Integer).display #=>
      #  2,   1,   0,   0,   0
      #  0,   2,   1,   0,   0
      #  0,   0,   2,   0,   0
      #  0,   0,   0,  -1,   1
      #  0,   0,   0,   0,  -1

--- to_matrix_r(ring)
    ((<to_matrix>)) �Ɠ����B

--- to_matrix_l(ring)
    �W�����_���s��i���O�p�j��Ԃ��܂��B

=end
