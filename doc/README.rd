=begin
= Algebra

2006.09.14

*Version: 0.72
*Author: Shin-ichiro HARA
*e-mail: sinara@blade.nagaokaut.ac.jp
*Home Page: ((<URL:http://blade.nagaokaut.ac.jp/~sinara/ruby/math/>))

== Preface

This is a library for mathematical computations. 
Our purpose is to express the mathematical object naturally in Ruby.
Though it is not operated fast, we can see the algorithm of the
mathematical processing not in black box but in scripts.

This library is in development stage.
At present, things we can handle are as follows:

* One-variate polynomial
  * Fundamental operations (addition, multiplication, quotient/remainder, ...)
  * factorization
  * Galois group
* Multi-variate polynomial
  * Fundamental operations (addition, multiplication, ...)
  * factorization
  * Creating Groebner-basis, quotient/remainder by Groebner-basis.
* Algebraic systems
  * Creating quotient fields
  * Creating residue class fields
  * Operating matrices
  * Operating permutation groups
* Sets and Maps

== Installation

Install Ruby (See: ((<URL:http://www.ruby-lang.org/>)) ).

After expanding this archive, do

  ruby install.rb

Then all files and directories under ((|lib|)) are copyed in
the directory where Ruby can load.

To accelerate calculation, it is better to use an extension 
library of rational number:
(((<URL:http://blade.nagaokaut.ac.jp/~sinara/ruby/rational/>))
than to use the stardard library rational.rb.

== Usage and Samples

See ((<index.html|URL:index.html>)) in ((|doc|)) directory, where 
manuals and sample codes are.

== Reference
* D.Cox, J.Little and D.O'Shea, "IDEALS, VARIETIES AND ALGORITHMS", 1997, Springer.
* K. Kodama, "Polynomial", ((<URL:http://www.math.kobe-u.ac.jp/HOME/kodama/tips-RubyPoly.html>))
* H.Anai, M.Noro and K.Yokoyama, "Computation of the splitting fields and the Galois groups of polynomials", Progres in Mathematics, 28-50, Vo.143, 1996


=end
