=begin
[((<index-ja|URL:index-ja.html>))] 
= 多項式環相互変換ユーティリティー

Polynomial <-> MPolynomial の相互変換ユーティリティーです。

== ファイル名:
* ((|polyomimial-converter.rb|))

== メソッド

--- Algebra::Polynomial.convert_to(ring)
    ((<Algebra::MPolynomial|URL:m-polynomial-ja.html>)) である ((|ring|))
    に変換します。

--- Algebra::Polynomial#value_on(ring)
    ((<Algebra::MPolynomial|URL:m-polynomial-ja.html>)) である ((|ring|))
    における値を返します。
    
    例:
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
    ((<Algebra::Polynomial|URL:m-polynomial-ja.html>)) である ((|ring|))
    に変換します。

--- Algebra::MPolynomial#value_on(ring)
    ((<Algebra::Polynomial|URL:m-polynomial-ja.html>)) である ((|ring|))
    における値を返します。

    例:
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
