=begin
[((<README-ja|URL:README-ja.html>))]  [((<English|URL:../doc/index.html>))]
= �㐔�p�b�P�[�W

  Version: 0.72  (2006.09.16)
  Author: �� �M��Y (sinara@blade.nagaokaut.ac.jp)

  ����͂P�ϐ����邢�͑��ϐ��̑��������v�Z���邽�߂̃��C�u�����ł��B

== 0. �ŏ��̈��

�ł��ȒP�ȗ��p�@�� require "algebra" �Ƃ��āA�v�Z���n�߂邱�Ƃł��B

  require "algebra"
  x = Polynomial(Integer, "x").var
  puts( (x+1)**7 )
    #=> x^7 + 7x^6 + 21x^5 + 35x^4 + 35x^3 + 21x^2 + 7x + 1
  puts( (x**7 + 7*x**6 + 21*x**5 + 35*x**4 + 35*x**3 + 21*x**2 + 7*x + 1).factorize )
    #=> (x + 1)^7
  
== 1. ���

 * ((<Samples|URL:samples-ja.html>))

== 2. ��ȃN���X�E���W���[��

 * ((<Algebra|URL:algebra-ja.html>)) (�㐔���W���[��)
   * ((<Algebra::Polynomial|URL:polynomial-ja.html>)) (1�ϐ��������N���X)
   * ((<Algebra::EuclidianRing|URL:euclidian-ring-ja.html>)) (���[�N���b�h���W���[��)
   * ((<Algebra::MPolynomial|URL:m-polynomial-ja.html>)) (���ϐ��������N���X)
   * ((<Algebra::ResidueClassRing|URL:residue-class-ring-ja.html>)) (��]�N���X)
   * ((<Algebra::AlgebraicExtensionField|URL:algebraic-extension-field-ja.html>)) (�㐔�g��̃N���X)
   * ((<Algebra::LocalizedRing|URL:localized-ring-ja.html>)) (�Ǐ����N���X)
   * ((<Algebra::MatrixAlgebra|URL:matrix-algebra-ja.html>)) (�s��㐔�N���X)
   * ((<Algebra::AlgebraicParser|URL:algebraic-parser-ja.html>)) (�㐔����\��������̕]���N���X)
   * ((<Algebra::Set|URL:finite-set-ja.html>)) (�W���̃N���X)
   * ((<Algebra::Map|URL:finite-map-ja.html>)) (�ʑ��̃N���X)
   * ((<Algebra::Group|URL:finite-group-ja.html>)) (�Q�̃N���X)
   * ((<Algebra::PermutationGroup|URL:permutation-group-ja.html>)) (�u���Q�̃N���X)
== 3. ���̑�

 * ((<Algebra::ElementaryDivisor|URL:elementary-divisor-ja.html>)) (�P���q���W���[��)
 * ((<Algebra::JordanForm|URL:jordan-form-ja.html>)) (�W�����_���s��N���X)
 * ((<Algebra::MatrixAlgebraTriplet|URL:matrix-algebra-triplet-ja.html>)) (3�g�s��̃N���X)
 * ((<�㐔�������n���h�����[�e�B���e�B�[|URL:algebraic-equation-ja.html>))
 * ((<���������ݕϊ����[�e�B���e�B�[|URL:polynomial-converter-ja.html>))

== 4. �p�b�P�[�W���e

=== ����
  algebra.rb             Algebra ���C�u������ʗ��p�t�@�C��

=== ��ϐ��֌W
  polynomial.rb          �P�ϐ��������̃N���X
  euclidian-ring.rb      ���[�N���b�h���惆�e�B���e�B�[(G.C.D.�̌v�Z)
  polynomial-factor.rb   �P�ϐ������������������C�u����
    polynomial-factor-int.rb   �����W����
    polynomial-factor-zp.rb    Zp�W����
    polynomial-factor-alg.rb   �㐔�I���W����

=== ���ϐ��֌W
  m-polynomial.rb         ���ϐ��������̃N���X
    m-index.rb            m-polynomial.rb �̉�����
  m-polynomial-factor.rb   �P�ϐ������������������C�u����
    m-polynomial-factor-int.rb   �����W����
    m-polynomial-factor-zp.rb    Zp�W����
  groebner-basis.rb       �O���u�i���̌v�Z���W���[��
  groebner-basis-coeff.rb ���Z�̌v�Z���W���[��

=== �㐔�S��
  localized-ring.rb       ���̍쐬���C�u����
  matrix-algebra.rb       �s��㐔�̃N���X
    elementary-divisor.rb �P���q���샂�W���[��
    matrix-algebra.triplete.rb  3�g�s��N���X
    jordan-form.rb        �W�����_���s��N���X
  residue-class-ring.rb   �������̏�]��
  algebraic-extention-field.rb �㐔�g���
  splitting-field.rb      �������̍ŏ������
  galois-group.rb         Galois �Q
  linear-algebra.rb       ���`�㐔���C�u����
  algebraic-equation.rb   �㐔���������C�u����

=== ��b����

  finite-set.rb           �W���̃N���X
    finite-map.rb         �ʑ��̃N���X
    finite-group.rb       �Q�̃N���X
      permutation-group.rb  �u���Q�̃N���X

=== ���ʕ���
  prime-gen.rb            �f�������N���X
  numeric-supplement.rb   Numeric �̕⊮
  polynomial-converter.rb ���������ݕϊ����[�e�B���e�B�[
  algebra-system.rb       �㐔�n�̋��ʎd�l
  algebraic-parser.rb     �����̎��̕�����\����]�����郂�W���[��

=== ���̑�
  array-supplement.rb     Array �̕⊮
  doc-ja/                 �}�j���A�����{���(RD, HTML, TXT)
  doc/                    �}�j���A���p���(RD, HTML, TXT)
  sample/                 �T���v���R�[�h
  work/                   �i�J����Əꏊ�j

== 5. ToDo
#<<< todo.rd
* ((<todo.html|URL:todo.html>))

== 6. Changes
#<<< changes.rd
* ((<changes.html|URL:changes.html>))

=end
