=begin
[((<index-ja|URL:index-ja.html>))] 
= ���������ݕϊ����[�e�B���e�B�[

Polynomial <-> MPolynomial �̑��ݕϊ����[�e�B���e�B�[�ł��B

== �t�@�C����:
* ((|polyomimial-converter.rb|))

== ���\�b�h

--- Algebra::Polynomial.convert_to(ring)
    ((<Algebra::MPolynomial|URL:m-polynomial-ja.html>)) �ł��� ((|ring|))
    �ɕϊ����܂��B

--- Algebra::Polynomial#value_on(ring)
    ((<Algebra::MPolynomial|URL:m-polynomial-ja.html>)) �ł��� ((|ring|))
    �ɂ�����l��Ԃ��܂��B
    
    ��:
        require "m-polynomial"
        require "polynomial"

        P = Algebra::Polynomial(Integer, "x", "y", "z")
        x, y, z = P.vars
        f = x**2 + y**2 + z**2 - x*y - y*z - z*x

        MP = P.convert_to(Algebra::MPolynomial)
        p f = f.value_on(MP) #=> z^2 - zy - zx + y^2 - yx + x^2
        x, y, z = MP.vars
        p f == x**2 + y**2 + z**2 - x*y - y*z - z*x #=> true

--- Algebra::MPolynomial.convert_to(ring)
    ((<Algebra::Polynomial|URL:m-polynomial-ja.html>)) �ł��� ((|ring|))
    �ɕϊ����܂��B

--- Algebra::MPolynomial#value_on(ring)
    ((<Algebra::Polynomial|URL:m-polynomial-ja.html>)) �ł��� ((|ring|))
    �ɂ�����l��Ԃ��܂��B

    ��:
        require "m-polynomial"
        require "polynomial"

        MP = Algebra::MPolynomial(Integer, "x", "y", "z")
        x, y, z = MP.vars
        f = x**2 + y**2 + z**2 - x*y - y*z - z*x

        P = MP.convert_to(Algebra::Polynomial)
        p f = f.value_on(P) #=> x^2 + (-y - z)x + y^2 - zy + z^2
        x, y, z = P.vars
        p f == x**2 + y**2 + z**2 - x*y - y*z - z*x #=> ture

=end
