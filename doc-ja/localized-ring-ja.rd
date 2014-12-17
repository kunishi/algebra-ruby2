=begin
[((<index-ja|URL:index-ja.html>))] 
= Algebra::LocalizedRing
((*(�Ǐ����N���X)*))

�^����ꂽ�𕪎q�E����ɂ����������\�����܂��B
���ۂ̃N���X�𐶐�����ɂ́A�N���X���\�b�h ((<::create>)) 
���邢�͊֐� ((<Algebra.LocalizedRing>))() ��p���܂��B

== �t�@�C����:
* ((|localized-ring.rb|))

== �X�[�p�[�N���X:

* ((|Object|))

== �C���N���[�h���Ă��郂�W���[��:

�Ȃ�

== �֘A����֐�:

--- Algebra.LocalizedRing(ring)
    ((<::create>))(ring) �Ɠ����ł��B

--- Algebra.RationalFunctionField(ring, obj)
    �� ((|ring|))�A�ϐ���\���I�u�W�F�N�g�� ((|obj|)) �Ƃ��ėL���֐���
    �����܂��B�N���X���\�b�h ((|::var|)) �ŕϐ��𓾂邱�Ƃ��ł��܂��B
    
    ��: �L���֐���
      require "algebra/localized-ring"
      require "rational"
      F = Algebra.RationalFunctionField(Rational, "x")
      x = F.var
      p ( 1 / (x**2 - 1) - 1 / (x**3 - 1) )
        #=> x^2/(x^4 + x^3 - x - 1)

--- Algebra.MRationalFunctionField(ring, [obj1[, obj2, ...]])
    �� ((|ring|))�A�ϐ���\���I�u�W�F�N�g�� ((|obj1|)), ((|obj2|)),... �Ƃ��ėL���֐��̂����܂��B�N���X���\�b�h ((|::vars|)) �ŕϐ��𓾂邱�Ƃ��ł��܂��B
    
    ��: �L���֐���
      require "algebra/localized-ring"
      require "rational"
      G = Algebra.MRationalFunctionField(Rational, "x", "y", "z")
      x, y, z = G.vars
      f = (x + z) / (x + y) - z / (x + y)
      p f #=> (x^2 + xy)/(x^2 + 2xy + y^2)
      p f.simplify #=> x/(x + y)

== �N���X���\�b�h:

--- ::create(ring)
    �N���X((|ring|))�ŕ\���������̌��𕪎q�E����Ƃ��镪����
    �����܂��B

    ���̖߂�l�� Algebra::LocalizedRing �N���X�̃T�u�N���X�ł��B
    ���̃T�u�N���X�ɂ̓N���X���\�b�h�Ƃ��� ((|::ground|)) ����`����
    ((|ring|)) ��Ԃ��܂��B
    
    ���������N���X�ɂ̓N���X���\�b�h(({::[]}))����`����A��b��
    �� (({x})) �ɑ΂��ĕ����̌� (({x/1})) ��Ԃ��܂��B
    
    ��: �L���������
      require "localized-ring"
      F = Algebra.LocalizedRing(Integer)
      p F.new(1, 2) + F.new(2, 3) #=> 7/6

    ��: ������̑������̏���
      require "polynomial"
      require "localized-ring"
      P = Algebra.Polynomial(Integer, "x")
      F = Algebra.LocalizedRing(P)
      x = F[P.var]
      p ( 1 / (x**2 - 1) - 1 / (x**3 - 1) )
        #=> (x^3 - x^2)/(x^5 - x^3 - x^2 + 1)

--- ::zero
    �댳��Ԃ��܂��B
    
--- ::unity
    �P�ʌ���Ԃ��܂��B

#--- ::[](num, den = nil)

#--- ::reduce(num, den)


== ���\�b�h:

#--- monomial?; true; end



--- zero?
    �댳�ł���Ƃ��^��Ԃ��܂��B

--- zero
    �댳��Ԃ��܂��B
    
--- unity
    �P�ʌ���Ԃ��܂��B

--- ==(other)
    �������Ƃ��^��Ԃ��܂��B

--- <=>(other)
    �召�֌W�����߂܂��B

--- +(other)
    �a���v�Z���܂��B

--- -(other)
    �����v�Z���܂��B

--- *(other)
    �ς��v�Z���܂��B

--- **(n)
    ((|n|)) ����v�Z���܂��B

--- /(other)
    �����v�Z���܂��B


#--- to_s

#--- inspect

#--- hash

=end
