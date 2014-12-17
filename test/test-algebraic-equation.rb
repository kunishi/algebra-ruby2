######################################################
#                                                    #
#  This is test script for 'algebraic-equation.rb'  #
#                                                    #
######################################################
require "rubyunit"
require "algebra/algebraic-equation.rb"
require "algebra/rational"
class Rational;def inspect; to_s; end;end
#class Rational < Numeric;def inspect; to_s; end;end

PQ = Algebra.Polynomial(Rational, "x")
Q2 = Algebra.AlgebraicExtensionField(Rational, "a") {|a|
  a**2 - 2
}


class TestPolyDecompose < Runit
  def test_mdf
    x = PQ.var
    #    f = x**2 - 3*x + 2
    #    f = (x**2 - 2*x - 1)*(x**2 + x + 1)
    #    f = x**4 + 1
    [
      (x**2 + x + 1)**2,
      x**3 - 3*x + 1,
      x**3 - x + 1,
      x**3 - 2,
      x**4 + 2,
    ].each do |f|
      puts
      p f
      field, modulus, facts, roots, addelems = f.decompose
      fp = Algebra.Polynomial(field, "x")
      facts = facts.collect{|g, n| [g.evaluate(fp.var), n]}
      p( {:modulus => modulus})
      p( {:facts => facts})
      p( {:roots => roots, :addelems => addelems})
      assert_equal(facts.pi, f.convert_to(fp))
      #    g = f.convert_to(Algebra.Polynomial(field, "y"))
      #    p g
      #    p g.factorize
      #    a = Q2.var
      #    assert_equal(y, poly)
    end
  end
  
  def _test_perm
    x = PQ.var
    [
      x**3 - 3*x + 1,
      x**3 - x + 1,
      x**3 - 2,
      x**4 - 2,
    ].each do |f|
      puts
      p f
      field, modulus, facts, roots, addelems = f.decompose
      fp = Algebra.Polynomial(field, "x")
      facts = facts.collect{|g, n| [g.evaluate(fp.var), n]}
      p( {:modulus => modulus})
      p( {:facts => facts})
      p( {:roots => roots, :addelems => addelems})
      assert_equal(facts.pi, f.convert_to(fp))
      l = addelems.size-1
      fix = modulus[l]
      aj = roots[l+1]
      p [fix, aj, fix.evaluate(aj)]
      #    g = f.convert_to(Algebra.Polynomial(field, "y"))
      #    p g
      #    p g.factorize
      #    a = Q2.var
      #    assert_equal(y, poly)
    end
    
  end
end

Tests(TestPolyDecompose)
