require "rubyunit"
require "algebra/rational"
#class Rational < Numeric;def inspect; to_s; end;end
class Rational;def inspect; to_s; end;end
require "algebra/linear-algebra"
#include Algebra

class TestDiagonalize < Runit

  def test_diagonalize
    m = Algebra.SquareMatrix(Rational, 4)
    as = [
      m.symmetric(1, 0, 1, 0, 1, 0, 1, 0, 1, 0), ## 2 sec.
      m.symmetric(1, 1, 1, 0, 1, 0, 1, 0, 1, 0), # 100 sec.
    ]

    as.each_with_index do |m0, i|
      tmatrix, extfield, evalues, elms = _test_diagonalize(m0)
      m1 = Algebra.SquareMatrix(extfield, 4)
      a, b, c, d = elms
      case i
      when 0
	ans = m1[
	  [ -1,   1, -a - 1, a - 1],
	  [1,   1,  -1,  -1],
	  [-1,   1, a + 1, -a + 1],
	  [1,   1,   1,   1],
	]
=begin
	ans = m[
	  [-1,   1,   1, a - 1],
	  [1,   1,   1,  -1],
	  [-1,   1,   1, -a + 1],
	  [1,   1,   1,   1],
	]
=end
      when 1
	ans = m1[
	  [a**2 - a - 2, -a**2 + a + 1,
	    (-a**3 + 2*a**2 + a - 1)*b + a**3 - 2*a**2 - a,
	    (a**3 - 2*a**2 - a + 1)*b - a**3 + 2*a**2 + a - 1],
	  [a**3 - 2*a**2 - a + 2, a**3 - 2*a**2 - a + 2,
	    -a**3 + 2*a**2 + a - 1, -a**3 + 2*a**2 + a - 1],
	  [-a**3 + 2*a**2 + 2*a - 2, -a + 1, b + a**3 - 2*a**2 - a + 1,
	    -b + 1],
	  [1,   1,   1,   1]
	]
=begin
	ans = m[
	  [a**2 - a - 2, (-a**3 + 2*a**2 + a - 1)*b + a**3 - 2*a**2 - a, -a**2 + a + 1, (a**3 - 2*a**2 - a + 1)*b - a**3 + 2*a**2 + a - 1],
	  [a**3 - 2*a**2 - a + 2, -a**3 + 2*a**2 + a - 1, a**3 - 2*a**2 - a + 2, -a**3 + 2*a**2 + a - 1],
	  [-a**3 + 2*a**2 + 2*a - 2, b + a**3 - 2*a**2 - a + 1, -a + 1, -b + 1],
	  [1,   1,   1,   1],
	]
=end
      end
      #      sleep 1
      assert_equal(ans, tmatrix)
    end
  end

  def _test_diagonalize(a)
    puts "A = "; a.display; puts
    
    extfield, proots, tmatrix, evalues, elms, evectors, espaces,
      chpoly, facts = a.diagonalize

    puts "Charactristic Polynomial: #{chpoly}"
    puts "                          => #{facts}"
    puts
    
    puts "Algebraic Numbers:"
    proots.each do |po, rs|
      puts "#{rs.join(', ')} : roots of #{po} == 0"
    end
    puts
    
    puts "Eigen Spaces: "
    evalues.uniq.each do |ev|
      puts "W_{#{ev}} = <#{espaces[ev].join(', ')}>"
    end
    
    puts
    
    puts "P = "; tmatrix.display; puts

    q = tmatrix.inverse
    puts "P^-1 = "; q.display; puts
    puts "P^-1 * A * P = "; (q * a * tmatrix).display; puts

    [tmatrix, extfield, evalues, elms]
  end
end

Tests(TestDiagonalize)
