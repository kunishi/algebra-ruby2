########################################################
#                                                      #
#  This is test script for 'polynomial-factor-alg.rb'  #
#                                                      #
########################################################
require "algebra/rational"
require "algebra/polynomial-factor-alg.rb"
include Algebra

def test(f, s = "")
  print "#{f}#{s}\n"
  a = f.factorize
  sw = (f == a.pi)
  puts "#{a.inspect}, #{sw}"
  raise unless sw
end

require "algebra/polynomial"
require "algebra/polynomial-factor"
require "algebra/rational"
require "algebra/residue-class-ring"

n, i, j, k = ARGV.collect{|v| v.to_i}
fss = [
  "x**4 + 1",#0
  "x**2 + x + 1",#1
  "x**4 + 1 + a",#2
  "(x**4 + 1)*(x**2 + x + 1)",#3
  "x**4 + 4",#4
  "x**2 + 4*x + 1",#5
  "x**2 + 1",#6
  "x**3 - 1",#7
  "x**3 - 2",#8
]
fs = fss[n||0]
ass = [
  "a**2 + 1",#0
  "a**2 - 2",#1
  "a**3 - 2",#2
  "a**2 - 3",#3
]
bss = [
  "b**2 - 2",#0
  "b**3 - 2",#1
  "b**2 + b + 1",#2
  "b**2 + 1",#3
  "b**2 - 3",#4
]
css = [
  "c**3 - 2",#0
  "c**2 - 3",#1
]

as = ass[i||0]
bs = bss[j||0]
cs = css[k||0]

unless i
  [fss, ass, bss, css].each do |xs|
    puts "-----------"
    xs.each_with_index do |f, i|
  puts "#{i}: #{f}"
    end
  end
else
  ka = AlgebraicExtensionField(Rational, "a") {|a| eval as }
  a = ka.var    
  unless j
    pka = Polynomial(ka, "x")
    x = pka.var
    f = eval fs
    test(f, ", in Q[a, x]/(#{as})")
  else
    kab = AlgebraicExtensionField(ka, "b") { |b| eval bs}
    
    unless k
  pkab = Polynomial(kab, "x")
  x = pkab.var
  f = eval fs
  test(f, ", in Q[a, b, x]/(#{as}, #{bs})")
    else
  kabc = AlgebraicExtensionField(kab, "c") { |c| eval cs}
  pkabc = Polynomial(kabc, "x")
  x = pkabc.var
  f = eval fs
  test(f, ", in Q[a, b, c, x]/(#{as}, #{bs}, #{cs})")
    end
  end
end
