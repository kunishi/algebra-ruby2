#######################################################
#                                                     #
#  This is test script for 'groebner-basis-coeff.rb'  #
#                                                     #
#######################################################
require 'test/unit'
require 'algebra'

class TestGroebnerBasisCoeff < Test::Unit::TestCase
  def setup
    @P = MPolynomial(Rational)
  end

  def gbc(f)
    f0 = f.first
    print 'Basis of: '
    p f.class
    f.each do |elem|
      p elem.class
      p elem.to_s
    end
    p f
    puts(f.map(&:to_s).join(', '))
    c, g = Groebner.basis_coeff(f)
    print 'is: '
    puts(g.map(&:to_s).join(', '))
    puts 'Coeefitients are: '
    c.each do |x|
      puts x.map(&:to_s).join(', ')
    end
    p 3333
    p g
    p c.collect { |x| f.inner_product x }

    if g == c.collect { |x| f.inner_product x }
      puts 'Success!'
    else
      puts 'Fail.'
    end
    puts
  end

  def test_gbc
    x, y, z = @P.vars('xyz')

    f1 = x**2 + y**2 + z**2 - 1
    f2 = x**2 + z**2 - y
    f3 = x - z

    f = [f1, f2, f3]

    # gbc([f1, f2, f3])
    # f0 = f.first
    # print "Basis of: "
    # p f.class
    # f.each do |elem|
    #   p elem.class
    #   p elem.to_s
    # end
    # p f
    # puts(f.map { |v| v.to_s }.join(", "))
    c, g = Groebner.basis_coeff(f)
    # print "is: "
    # puts(g.map { |v| v.to_s }.join(", "))
    # puts "Coeefitients are: "
    # c.each do |x|
    #   puts x.map { |v| v.to_s }.join(", ")
    # end
    # p 3333
    # p g
    # p c.collect{|x| f.inner_product x}

    assert_equal(g, c.collect { |x| f.inner_product x })
    #   if g == c.collect{|x| f.inner_product x}
    #     puts "Success!"
    #   else
    #     puts "Fail."
    #   end
    #   puts
  end

  #  require "algebra/residue-class-ring"
  #  Z5 = ResidueClassRing(Integer, 5)
  #  P = MPolynomial(Z5)
  def test_groebner_basis_coeff_01
    x, y, z = @P.vars('xyz')

    f1 = x**2 + y**2 + z**2 - 1
    f2 = x**2 + z**2 - y
    f3 = x - z

    g = x**3 + y**3 + z**3
    q, r = g.divmod_s(f1, f2, f3)
    # p q
    # p r
    assert_equal(g, q.inner_product([f1, f2, f3]) + r)
    # if g == q.inner_product([f1, f2, f3]) + r
    #   puts "Success!"
    # else
    #   puts "Fail."
    # end
  end
end
