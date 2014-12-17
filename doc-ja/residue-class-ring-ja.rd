=begin
[((<index-ja|URL:index-ja.html>))] 
= Algebra::ResidueClassRing
((*(��]�N���X)*))

���炻��1�̌���@�Ƃ�����]���\�����܂��B���ۂ̃N���X�𐶐�����ɂ͊�
�Ɩ@�Ƃ��w�肵�āA�N���X���\�b�h ((<::create>)) ���邢��
�֐� ((<Algebra.ResidueClassRing>))() ��p���܂��B


== �t�@�C����:
* ((|residue-class-ring.rb|))

== �X�[�p�[�N���X:

* ((|Object|))

== �C���N���[�h���Ă��郂�W���[��:

�Ȃ�

== �֘A����֐�:

--- Algebra.ResidueClassRing(ring, mod)
    ((<::create>))(ring, mod) �Ɠ����ł��B

== �N���X���\�b�h:

--- ::create(ring, mod)

    �N���X ((|ring|)) �ŕ\���������Ƃ��̊̌� ((|mod|)) ����A
    ���̌���@�Ƃ�����]��\������N���X��Ԃ��܂��B
    
    ���̖߂�l�� ((<Algebra::ResidueClassRing>)) �N���X�̃T�u�N���X�ł��B
    ���̃T�u�N���X�ɂ̓N���X���\�b�h�Ƃ��� ((|::ground|)) ��
    ((|::modulus|)) �� (({[x]})) ����`����A���ꂼ��A��b�� ((|ring|))�A
    �@ ((|mod|))�Ax ���\���Ƃ����]�ނ�Ԃ��܂��B
        
    ��: ��������@ (({x**2 + x + 1})) �Ŋ���B
      require "rational"
      require "polynomial"
      require "residue-class-ring"
      Px = Algebra.Polynomial(Rational, "x")
      x = Px.var
      F = Algebra.ResidueClassRing(Px, x**2 + x + 1)
      p F[x + 1]**100     #=> -x - 1
      
    ((|ring|)) �� Integer �ł���ꍇ�Ɍ���A�S�Ă̋t����\�ߌv�Z����
    �ۊǂ��܂��B�܂� (({0, 1, ... , mod-1})) �ɑΉ������]�ނ̔z���
    ((|to_ary|)) �œ��邱�Ƃ��ł��܂��B
    
    ��: modulo 7 �̑f��
      require "residue-class-ring"
      F7 = Algebra::ResidueClassRing.create(Integer, 7)
      a, b, c, d, e, f, g = F7
      p [e + c, e - c, e * c, e * 2001, 3 + c, 1/c, 1/c * c]
        #=> [6, 2, 1, 3, 5, 4, 1]
      p( (1...7).collect{|i| F7[i]**6} )
        #=> [1, 1, 1, 1, 1, 1]

--- ::[](x)
    ((|x|)) �ő�\������]�ނ�Ԃ��܂��B
    
#--- ::indeterminate(obj)

--- ::zero
    �댳��Ԃ��܂��B
    
--- ::unity
    �P�ʌ���Ԃ��܂��B


== ���\�b�h:

--- lift
    ��]�ނ̑�\����Ԃ��܂��B

#--- monomial?

--- zero?
    �댳�ł���Ƃ��^��Ԃ��܂��B

--- zero
    �댳��Ԃ��܂��B
    
--- unity
    �P�ʌ���Ԃ��܂��B

--- ==(other)
    �������Ƃ��^��Ԃ��܂��B

--- +(other)
    �a���v�Z���܂��B

--- -(other)
    �����v�Z���܂��B

--- *(other)
    �ς��v�Z���܂��B

--- **(n)
    ((|n|)) ����v�Z���܂��B

--- /(other)
    ((<inverse>)) �𗘗p���ď����v�Z���܂��B

--- inverse
    ��b�����[�N���b�h�ł��邱�Ƃ����肵�āA�t����Ԃ��܂��B
    �t�������݂��Ȃ��ꍇ�̒l�� nil �ł��B

#--- to_s

=end
