=begin
[((<index-ja|URL:index-ja.html>))] 
= AlgebraicEqation
((*(�㐔�������̂��߂̃��[�e�B���e�B�[)*))

�������Ƒ̂̂��߂̃t�@�C��

== �t�@�C����:
* ((|algebraic-equation.rb|))

== ���W���[�����\�b�h:

--- minimal_polynomial(element, poly1[, poly2[, poly3...]])
    (({poly1, poly2, poly3...})) ��@�Ƃ����A((|element|)) �̍ŏ�������
    �����߂܂��B
    
    ��: ���[�g2 + ���[�g3 + ���[�g5 �̍ŏ������������߂�B
      PQ = MPolynomial(Rational)
      a, b, c = PQ.vars("abc")
      p AlgebraicEquation.minimal_polynomial(a + b + c, a**2-2, b**2-3, c**2-5)

      #=> x^8 - 40x^6 + 352x^4 - 960x^2 + 576

--- symmetric_product

=end
