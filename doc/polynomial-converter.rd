=begin
[((<index|URL:index.html>))] 
= Utility of Conversion of Polynomials

== File Name
* ((|polyomimial-converter.rb|))

== Methods:

--- Algebra::Polynomial.convert_to(ring)
    Returns the ring converted to ((|ring|)) of
    ((<Algebra::MPolynomial|URL:m-polynomial.html>)).

--- Algebra::Polynomial#value_on(ring)
    Returns the ring converted to ((|ring|)) of
    ((<Algebra::MPolynomial|URL:m-polynomial.html>)).
        
    Example:
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
    Returns the ring converted to ((|ring|)) of
    ((<Algebra::Polynomial|URL:m-polynomial.html>))

--- Algebra::MPolynomial#value_on(ring)
    Returns the ring converted to ((|ring|)) of
    ((<Algebra::Polynomial|URL:m-polynomial.html>)).

    Example:
        require "m-polynomial"
        require "polynomial"

        MP = Algebra::MPolynomial(Integer, "x", "y", "z")
        x, y, z = MP.vars
        f = x**2 + y**2 + z**2 - x*y - y*z - z*x

        P = MP.convert_to(Algebra::Polynomial)
        p f = f.value_on(P) #=> x^2 + (-y - z)x + y^2 - zy + z^2
        x, y, z = P.vars
        p f == x**2 + y**2 + z**2 - x*y - y*z - z*x #=> true

=end

