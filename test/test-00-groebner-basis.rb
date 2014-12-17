#!/usr/local/bin/ruby
#
# TEST SCRIPT FOR groebner-basis.rb
#
# 2001.04.08 Version 1.05

$totS, $totK = 0, 0

#$lp = "~/ruby/poly"
#$lp = "~/ruby/poly-2001-0202"
#$lp = "~/ruby/poly-2001-0326"

if $lp
  $LOAD_PATH.unshift $lp
  require "algebra/polynomialm"
  require "algebra/gbasem"
end
$LOAD_PATH.push File.dirname($0)

require "algebra"
#require "algebra/m-polynomial"
require "algebra/algebraic-parser"
require "time-trial"
include Algebra

def gb(k, f, ord = :lex, sw = false)
  f0 = f.first
  print "Basis of: "
  sw ? puts('', *f) : puts(f.join(", "))
  gbase = b = nil
  $stot.start {
    a = Time.now
    k.with_ord(:lex, nil, f) do
      gbase = Groebner.basis(f)
    end
    b = Time.now - a
  }
  print "Is: "
  sw ? puts('', *gbase) : puts(gbase.join(", "))
  puts "(#{b} seconds.)"
  true
end

def mkarray(s, mod = 0, ord = :lex)
  if mod < 0
    require "mathn"
    require "algebra/rational"
    puts 'require "mathn"'
    fp = Rational
  elsif mod > 0
    puts "modulo #{mod}"
    require "algebra/residue-class-ring"
    fp = ResidueClassRing(Integer, mod)
  else
    puts "modulo #{mod}"
    require "algebra/rational"
    fp = Rational
  end
  k = MPolynomial(fp)
  if $variables
    k.variables = $variables
    $variables = nil
  end
  strs = s.collect{|str| str.split(/\s*,\s*/)}.flatten
  sf = strs.collect{|x| AlgebraicParser.eval(x, k)}
  kf = strs.collect{|x| PolynomialM(x)} if $lp
  $lp ? [k, kf, sf, fp] : [k, sf, fp]
end

def gb_ks(s, mod = 0, ord = :lex)
  k, kf, sf, fp = mkarray(s, mod, ord)

  stime = sg = ktime = kg = nil

  $stot.start {
    stime = Time.now
    k.with_ord(ord, nil, sf) do
      sg = Groebner.basis(sf)
    end
    stime = Time.now - stime
  }

  $ktot.start {
    ktime = Time.now
    kg = mod > 0 ? GBase.getGBaseZp(kf, mod) : GBase.getGBase(kf)
    ktime = Time.now - ktime
  }

  sg.rsort!
  puts(*sg)

  skg = kg.collect{|t| AlgebraicParser.eval(t.to_s, k)}

  skg.rsort!
  if skg == sg
    puts "Coinside. (#{stime}, #{ktime}) =-=-=-=-=-=-=-=-=-=-=-=-"
    true
  else
    puts "Defferent. (#{stime}, #{ktime}) !!!!!!!!!!!!!!!!!!!!"
    puts kg
    false
  end
end

def gbks(s, mod = 0, ord = :lex)
  print s.inspect + " => "
  if $lp
    gb_ks(s, mod, ord)
  else
    k, sf, fp = mkarray(s, mod, ord)
    gb(k, sf, ord, true)
#    gb(sf)
  end
end


def test_gb(n, m)
  case n
  when 0
    gbks(["x + y - 1", "x - y - 1"], m)
  when 1
    gbks(["3x^2*y+7y", "4x*y^2-5x"], m)
  when 2
#    MPolynomial.set_ord(:grlex)
    Monomial.setTermOrder("deglex") if $lp
    # "lex"(default), "deglex",  "degrevlex"
    gbks(["x**3 - 2*x*y", "x**2*y - 2*y**2 + x", "-x**2",
	   "-2*x*y", "-2*y**2 + x"], m, :grlex)
  when 3
    puts "It takes 8 minuites"
#    MPolynomial.set_ord(:lex)
    Monomial.setTermOrder("lex") if $lp
    gbks(["x**3 * y**2 - x**2 * y**3 + x", "3 * x**4 * y + y**2"], m, :lex)
  when 4
    gbks(["x**2 + y**2 + z**2 -1, x**2 + z**2 - y, x - z"], m)
  when 5
    $variables=["t","x","y","z"]
    Monomial.setVarOrder(["t","x","y","z"]) if $lp
    gbks(["t**4 - x, t**3 - y, t**2 - z"], m)
  when 6 #p145
    puts "It takes 3 minuites"
    $variables=["t","u","x","y","z"]
#    MPolynomial.set_ord(:lex)
    Monomial.setVarOrder(["t","u","x","y","z"]) if $lp
    Monomial.setTermOrder("lex") if $lp
    gbks(["x - (t+u), y - (t**2 + 2*t*u), z - (t**3 + 3 * t**2 * u)"], m, :lex)
  when 7 #p136
    $variables=["x","y","z", "w"]
#    MPolynomial.set_ord(:lex)
    Monomial.setVarOrder(["x","y","z","w"]) if $lp
    Monomial.setTermOrder("lex") if $lp
    gbks(["3*x-6*y-2*z, 2*x-4*y+4*w, x-2*y-z-w"], m, :lex)
  when 8
    $variables=["x","y","z", "w"]
#    MPolynomial.set_ord(:lex)
    Monomial.setVarOrder(["x","y","z","w"]) if $lp
    Monomial.setTermOrder("lex") if $lp
    gbks(["3x^2*y+7y","4x*y^2-5x"], m, :lex)
  when 9
    puts "It takes long time"
#    MPolynomial.set_ord(:lex)
    Monomial.setTermOrder("lex") if $lp
    gbks(["x**3 * y**2 - x**2 * y**3 + x", "3 * x**4 * y + y**2"], m, :lex)
  when 10 #p141
    puts "It takes very long time"
    $variables=["w", "x", "y", "z"]
#    MPolynomial.set_ord(:lex)
    Monomial.setVarOrder(["w", "x", "y", "z"]) if $lp
    Monomial.setTermOrder("lex") if $lp
    gbks(["3x**2 + 2yz - 2xw","2xz - 2yw","2xy - 2z - 2zw", "x**2 + y**2 + z**2 - 1"], m, :lex)
  when 11
    gbks(["x**2 + y**2 + z**2 -1, x**2 + z**2 - y, x - z"], m)
  when 12
    #
    gbks(["2x+3y+3","x+5y+2"], m)
  when 13
    puts "raise error!"
    gbks(["2x+3y+3","x+5y+2","x*y-1"], m)
  when 14
    gbks(["3x^2*y+7y","4x*y^2-5x"], m)
  when 15  
    $variables=(["y","x"])
#    MPolynomial.set_ord(:lex)
    Monomial.setVarOrder(["y","x"]) if $lp
    Monomial.setTermOrder("lex") if $lp
    
    gbks(["2x*y-x,3y-x^2"], m, :lex)
  when 16
    Monomial.setTermOrder("deglex") if $lp
#    MPolynomial.set_ord(:grlex)
    
    gbks(["3x^2y-3y*z+y", "5x^2z-8z^2"], m, :grlex)
  when 17
    Monomial.setTermOrder("lex") if $lp
#    MPolynomial.set_ord(:lex)
    
    gbks(["6x^2+y^2", "10x^2y+2x*y"], m, :lex)
  else
    puts "All tests succeed."
    puts
    nil
  end
end

$stot, $ktot = TimeTrial["stot, ktot"]

if false
  $atime, $btime = TimeTrial["atime, btime"]

  $sbas, $smin, $sred, $sdiv, $sspa, $slt, $smul, $llc =
    TimeTrial["sbas, smin, sred, sdiv, sspa, slt, smul, llc"]

  $kbas, $kmin, $kred, $kdiv, $kspa, $klt, $kmul =
    TimeTrial["kbas, kmin, kred, kdiv, kspa, klt, ksml"]
end

m = ARGV.shift
m = Integer(m) if m

if m
  m = Integer(m)
  if m < 0
    m = -1
  end
else
  m = 0
end

k = ARGV.shift
k = Integer(k) if k

if k
  test_gb(k, m)
else
  n = -1
  loop do
    n += 1
    puts "======================= test #{n} ======================"
    case n
    when 10
      puts "takes very long time. skip."
      next# if $lp
    when 9, 3
      puts "takes long time. skip."
      next
    when 13
      puts "error. skip."
      next
    end
    k = nil if k && k < 0
    r = test_gb(n, m)
    break unless r
  end
end

unless k
  puts "<< This is a test script for groebner-basis calculators. >>"
  puts "USAGE: #$0 [modulo [num]]"
  puts "  mod ... modulo (= -1, 0, 2, 3, 5... (-1 means 'by mathn')"
  puts "  num ... No. of test (if omitted, test all)"
  puts
  puts "S : K =\n#$stot\n#$ktot"
end

if false
puts $atime, $btime
puts $sbas, $kbas
puts $smin, $kmin
puts $sred, $kred
puts $sdiv, $kdiv
puts $sspa, $kspa
puts $slt, $klt
puts $smul, $llc
end
