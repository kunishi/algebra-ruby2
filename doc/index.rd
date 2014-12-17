=begin
[((<README|URL:README.html>))] [((<Japanese|URL:../doc-ja/index-ja.html>))]
= Algebra
  Version: 0.72 (2006.09.14)
  Author: Shin-ichiro HARA (sinara@blade.nagaokaut.ac.jp)

This is a library of one-variate and multi-variate polynomials.

== 0. First Step

Begin with 'require "algebra"'.

  require "algebra"
  x = Polynomial(Integer, "x").var
  puts( (x+1)**7 )
    #=> x^7 + 7x^6 + 21x^5 + 35x^4 + 35x^3 + 21x^2 + 7x + 1
  puts( (x**7 + 7*x**6 + 21*x**5 + 35*x**4 + 35*x**3 + 21*x**2 + 7*x + 1).factorize )
    #=> (x + 1)^7

== 1. Samples

* ((<Samples|URL:samples.html>))

== 2. Class and Module

 * ((<Algebra|URL:algebra.html>)) (Module of Algebra)
   * ((<Algebra::Polynomial|URL:polynomial.html>)) (Class of Polynomial Ring)
   * ((<Algebra::EuclidianRing|URL:euclidian-ring.html>)) (Eulcidian Ring Module)
   * ((<Algebra::MPolynomial|URL:m-polynomial.html>)) (Multi-variate Polynomial Ring Class)
   * ((<Algebra::ResidueClassRing|URL:residue-class-ring.html>)) (Residue Class Ring Class)
   * ((<Algebra::AlgebraicExtensionField|URL:algebraic-extension-field.html>)) (Algebraic Extension Class)
   * ((<Algebra::LocalizedRing|URL:localized-ring.html>)) (Localized Ring Class)
   * ((<Algebra::MatrixAlgebra|URL:matrix-algebra.html>)) (Matrix Algebra Class)
   * ((<Algebra::AlgebraicParser|URL:algebraic-parser.html>)) (evaluation of algebraic strings)
   * ((<Algebra::Set|URL:finite-set.html>)) (Sets)
   * ((<Algebra::Map|URL:finite-map.html>)) (Maps)
   * ((<Algebra::Group|URL:finite-group.html>)) (Groups)
   * ((<Algebra::PermutationGroup|URL:permutation-group.html>)) (PermutationGroups)

== 3. Other

 * ((<Algebra::ElementaryDivisor|URL:elementary-divisor.html>)) (Elementary Divisor Module)
 * ((<Algebra::JordanForm|URL:jordan-form.html>)) (Jordan Matrix Class)
 * ((<Algebra::MatrixAlgebraTriplet|URL:matrix-algebra-triplet.html>)) (Triplete of Matrices Class)
 * ((<Algebraic Equations|URL:algebraic-equation.html>))
 * ((<Conversions of Polynomial Classes|URL:polynomial-converter.html>))

== 4. Contents of package

=== General
  algebra.rb               File for using Algebra libraries

=== One variate polynomial
  polynomial.rb            Class of one variate polynomial
  euclidian-ring.rb        Module of Euclidian domain
  polynomial-factor.rb     Factorization:
    polynomial-factor-int.rb   Integer version
    polynomial-factor-zp.rb    Zp version
    polynomial-factor-alg.rb   Algebraic number version

=== Multi variate polynomial
  m-polynomial.rb         Class of multi-variate polynomial
    m-index.rb            Class of indices of degrees
  m-polynomial-factor.rb     Factorization:
    m-polynomial-factor-int.rb   Integer version
    m-polynomial-factor-zp.rb    Zp version
  groebner-basis.rb       Module of Groebner basis
  groebner-basis-coeff.rb Module of division by Groebner basis

=== Foundation
  finite-set.rb           Sets
    finite-map.rb         Maps
    finite-group.rb       Groups
      permutation-group.rb  Permutation Groups

=== Common part
  numeric-supplement.rb   Supplement of Numeric
  prime-gen.rb            Class of prime numbers
  polynomial-converter.rb Conversions between polynomial classes
  algebraic-parser.rb     Evaluation of strings
  algebra-system.rb       Common specification of algebras

=== General algebra
  localized-ring.rb       Quotient fields
  matrix-algebra.rb       Matrix
    elementary-divisor.rb Elementary Divisor Class
    matrix-algebra-triplet.rb  Triplet of Matrices Class
    jordan-form.rb        Jordan Block Class
  residue-class-ring.rb   Residue class ring
  algebraic-extention-field.rb Algebraic Extention Field of Polynomial
  splitting-field.rb      Minimal Splitting Field of Polynomial
  galois-group.rb         Galois Group of Polynomial
  linear-algebra.rb       library for linear algebra
  algebraic-equation.rb   library for algebraic equation

=== Others
  array-supplement.rb    Supplement of Array
  doc/                   English Manuals(RD, HTML, TXT)
  doc-ja/                Japanese Manuals(RD, HTML, TXT)
  sample/                Sample Codes
  work/                  (working directory for the developer)

== 5. ToDo
#<<< todo.rd
* ((<todo.html|URL:todo.html>))

== 6. Changes
#<<< changes.rd
* ((<changes.html|URL:changes.html>))

=end

