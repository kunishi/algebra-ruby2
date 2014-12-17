=begin
= Algebra::AlgebraicParser
((*(������̑㐔�I�]���N���X)*))

== �t�@�C����:
* ((|algebraic-parser.rb|))

== �X�[�p�[�N���X:

* ((|Object|))

== �C���N���[�h���Ă��郂�W���[��:

�Ȃ�

== �N���X���\�b�h:
--- Algebra::AlgebraicParser.eval(string, ring)
    ((|string|)) �̎l�����Z���� ((|ring|)) ��Ōv�Z���܂��B

== ���\�b�h:

�Ȃ�

== �d�l

=== �]���̎菇

�ϐ��̒l�́A���̕ϐ����������Ƃ��� ((|ring|)) �̃N���X���\
�b�h ((|indeterminate|)) �̈����Ƃ��ēn����A���̖߂�l
�Ƃ��ĕ]������܂��B�܂����l�� ((|ring.ground|)) �̃N���X
���\�b�h ((|indterminate|)) �ŕ]������܂��B

      require "algebraic-parser"
      class A
        def self.indeterminate(str)
          case str
          when "x"; 7
          when "y"; 11
          end
        end
        def A.ground
          Integer
        end
      end
      p Algebraic::AlgebraicParser.eval("x * y - x^2 + x/8", A)
          #=> 7*11 - 7**2 + 7/8 = 28
      
�����ŁAInteger �� indeterminate �� algebraic-parser.rb �� require
���Ă��� algebra-supplement.rb �Ŏ��̂悤�ɒ�`����Ă��܂��B
    
        def Integer.indeterminate(x)
          eval(x)
        end
      
=== ���ʎq
���ʎq�́A�u�p��1�����{����0�����ȏ�v�Œ�`����܂��B����������

        "a13bc04def0"
      
�́A

        "a13 * b * c04 * d * e * f0"

�Ɖ��߂���܂��B

=== ���Z�q
���Z�q�������̎ア���ɕ��ׂ܂��B

  ;       ���ԕ]��
  +, -    �a, ��
  +, -    �P�� +, �P�� -
  *, /    ��, ��
  ���u    ��
  **, ^   �p

=== �p��
�N���X ((|Algebra::Polynomial|))�A�N���X ((|Algebra::MPolynomial|)) �ɂ͓K
�؂� ((|indeterminate|)), ((|ground|))
����`����Ă��܂��B���������Ď��̂悤�ɕ�����]�����ł��܂��B

      require "algebraic-parser"
      require "rational"
      require "m-polynomial"
      F = Algebra::MPolynomial(Rational)
      p Algebra::AlgebraicParser.eval("- (2*y)**3 + x", F) #=> -8y^3 + x

((|Algebra::MPolynomial|)) �ł́A((|indeterminate|)) �͕ϐ���\������I�u�W�F
�N�g�̓o�^���s���̂ŁA�o�^�����ϐ��Ԃ̏����ɂȂ�܂��B���������� ; ��
�g���Đ�ɕϐ���]�������鎖�ɂ���āA�����̕ύX�����鎖���ł��܂��B

      F.variables.clear
      p Algebra::AlgebraicParser.eval("x; y; - (2*y)**3 + x", F) #=> x - 8y^3

=end

