=begin
[((<index-ja|URL:index-ja.html>))] 

= AlgebraicExtensionField
((*(�㐔�g���)*))

�㐔�g��̂�\������N���X

== �t�@�C����:
* ((|algebraic-Extension-feild.rb|))

== �X�[�p�[�N���X:

* ((|ResidueClassRing|))

== �C���N���[�h���Ă��郂�W���[��:

�Ȃ��B

== �֘A���郁�\�b�h:

--- Algebra.AlgebraicExtensionField(field, obj){|x| ... }
    ((<::create>)) �Ɠ����B

== �N���X���\�b�h:

--- ::create(k, obj){|x| p(x) }
    �� ((|k|)) ���A((|obj|)) �ŕ\�����ϐ� ((|x|)) �̑�����
    ((|p(x)|)) �Ŋg�債���� ((|k[x]/(p(x))|))��Ԃ��܂��B
    ���̊ɂ́A�N���X���\�b�h ((<::var>))�A((<::def_polys>))�A
    ((<::env_ring>)) ����`����܂��B

    
    ��: �L����������� (({x**2 + x + 1 == 0})) �Ŋg�債���� F �����B
      require "rational"
      require "algebraic-extension-field"
      F = Algebra::AlgebraicExtensionField.create(Rational, "x") {|x| x**2 + x + 1}
      x = F.var
      p( (x-1)** 3 / (x**2 - 1) ) #=> -3x - 3

--- ::to_ary
    (({[self, var]})) ��Ԃ��܂��B

    ��: �㐔�g��̂ƓY�����𓯎��ɒ�`����
      require "rational"
      require "algebraic-extension-field"
      F, a = Algebra.AlgebraicExtensionField(Rational, "a") {|a| a**2 + a + 1}

--- ::var
    ((<::create>)) �̕Ԃ�l ((|k[x]/(p(x))|)) �ɒ�`����A
    ���̏�]�ɂ����� ((|x|)) ��
    ��\������]�ނ�Ԃ��܂��B

--- ::modulus
    ((<::create>)) �̕Ԃ�l ((|k[x]/(p(x))|)) �ɒ�`����A((|k[x]|)) 
    �̗v�f ((|p(x)|))  ��Ԃ��܂��B

--- ::def_polys
    ((<::create>)) �̕Ԃ�l ((|k[x]/(p(x))|)) �ɒ�`����A
    ���� ((|n|)) �̊e ((<::modulus>)) �̔z���Ԃ��܂��B
    �����ŁA���g�́A��b�� ((|k0|)) �㍂�� ((|n|)) ��
    �ċA�I�� ((|AlgebraicExtensionField|)) �ł���Ƃ��܂��B


    ��: ��b�̂�L�����Ƃ��A2, 3, 5 �̗������ɂ��g��̂����
      require "algebra"
      # K0 == Rational
      K1 = AlgebraicExtensionField(Rational, "x1") { |x|
        x ** 3 - 2
      }
      K2 = AlgebraicExtensionField(K1, "x2") { |y|
        y ** 3 - 3
      }
      K3 = AlgebraicExtensionField(K2, "x3") { |z|
        z ** 3 - 5
      }

      p K3.def_polys #=> [x1^3 - 2, x2^3 - 3, x3^3 - 5]

      x1, x2, x3 = K1.var, K2.var, K3.var
      f = x1**2 + 2*x2**2 + 3*x3**2
      f0 = f.abs_lift

      p f0.type     #=> (Polynomial/(Polynomial/(Polynomial/Rational)))
      p f0.type == K3.env_ring #=> true

      p f #=> 3x3^2 + 2x2^2 + x1^2
      p f0.evaluate(x3.abs_lift, x2.abs_lift, x1.abs_lift)
          #=> x3^2 + 2x2^2 + 3x3^2


--- ::env_ring
    ((<::create>)) �̕Ԃ�l ((|k[x]/(p(x))|)) �ɒ�`����A
    ���ϐ��������� ((|k0[x1, x2,.., xn]|)) ��Ԃ��܂��B
    �����ŁA���g�́A��b�� ((|k0|)) �㍂�� ((|n|)) ��
    �ċA�I�� ((|AlgebraicExtensionField|)) �ł���Ƃ��܂��B

--- ::ground
    ��]�̂��ƂɂȂ鑽������ ((|k[x]|)) ��Ԃ��܂��B


== ���\�b�h
--- abs_lift
    ((<::env_ring>)) ���Ȃ킿��b�� ((|k0|)) ��
    �̑��ϐ��������� ((|k0[x1, x2,.., xn]|))
    �ւ̃��t�g��Ԃ��܂��B

--- [](n)
    ((<n>)) ���̌W����Ԃ��܂��B(({lift[n]})) �Ɠ����ł��B

    ��: Fibonacci ����
      require "algebra"
      t = AlgebraicExtensionField(Integral, "t"){|x| x**2-x-1}.var
      (0..10).each do |n|
        p( (t**n)[1] ) #=> 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55
      end

=end
