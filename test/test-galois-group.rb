############################################################
#                                                          #
#  This is test script for 'galois-group.rb'  #
#                                                          #
############################################################
require "rubyunit"
require "algebra/rational"
require "algebra/polynomial"
require "algebra/splitting-field"
require "algebra/galois-group"

class Rational;def inspect; to_s; end;end

class TestAEF < Runit
  P = Algebra.Polynomial(Rational, "x")

  def test_galois_gr
    x = P.var
    
    for i in 0..3
#      next if i != 2
      f = [
	x**2 - 1,             #0
	x**3 - 3*x + 1,       #1
	x**3 - 2,             #2
	(x**2 - 2)*(x**2 - 3),#3
	x**3 - x + 1,         #4
	x**4  + 1,            #5
      ][i]
      gsize = [1, 3, 6, 4, 6, 4]
      g = f.galois_group
      puts "Galois group of #{f} is"
      g.each do |h|
	p h
      end
      puts
      assert_equal(gsize[i], g.size)
    end
  end

end

Tests(TestAEF)
