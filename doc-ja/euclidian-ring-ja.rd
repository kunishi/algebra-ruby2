=begin
[((<index-ja|URL:index-ja.html>))] 
= Algebra::EuclidianRing

((*(G.C.D.�v�Z���W���[��)*))

((|divmod|)) ���� G.C.D(�ő����)�����v�Z���郂�W���[���ł��B
����� ((|Integer|)) �� ((|Algebra::Polynomial|)) �ɃC���N���[�h����܂��B

== �t�@�C����:
* ((|euclidian-ring.rb|))

== ���\�b�h:

--- gcd(other)
    ((|self|)) �� ((|other|)) �Ƃ̍ő���񐔂�Ԃ��܂��B

--- gcd_all(other0 [, other1[, ...]])
    ((|self|)) �� ((|other0|)), ((|other1|)),... �Ƃ̍ő���񐔂�Ԃ��܂��B

--- gcd_coeff(other)
    ((|self|)) �� ((|other|)) �Ƃ̍ő���񐔂ƁA�����\������W����
    �z���Ԃ��܂��B
    
    ��:
      require "polynomial"
      require "rational"
      P = Algebra.Polynomial(Rational, "x")
      x = P.var
      f = (x + 2) * (x**2 - 1)**2
      g = (x + 2)**2 * (x - 1)**3
      gcd, a, b = f.gcd_coeff(g)
      p gcd #=> 4x^3 - 12x + 8
      p a   #=> -x + 2
      p b   #=> x - 1
      p gcd == a*f + b*g #=> true

--- gcd_ext(other)
    ((<gcd_coeff>)) �Ɠ����ł��B

--- gcd_coeff_all(other0 [, other1[, ...]])
    ((|self|)) �� ((|other0|)), ((|other1|)),... �Ƃ̍ő���񐔂ƁA����
    ��\������W���̔z���Ԃ��܂��B

    ��:
      require "polynomial"
      require "rational"
      P = Algebra.Polynomial(Rational, "x")
      x = P.var
      f = (x + 2) * (x**2 - 1)**2
      g = (x + 2)**2 * (x - 1)**3
      h = (x + 2) * (x + 1) * (x - 1)
      gcd, a, b, c = f.gcd_coeff_all(g, h)
      p gcd #=> -8x^2 - 8x + 16
      p a   #=> -x + 2
      p b   #=> x - 1
      p c   #=> -4
      p gcd == a*f + b*g + c*h #=> true

--- gcd_ext_all(other)
    ((<gcd_coeff_all>)) �Ɠ����ł��B

--- lcm(b)
    ((|self|)) �� ((|other|)) �Ƃ̍ŏ����{����Ԃ��܂��B

--- lcm_all(other0 [, other1[, ...]])
    ((|self|)) �� ((|other0|)), ((|other1|)),... �Ƃ̍ŏ����{����Ԃ��܂��B

=end
