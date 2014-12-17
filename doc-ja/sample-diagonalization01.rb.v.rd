=begin
  # sample-diagonalization01.rb

  require "algebra"
  M = SquareMatrix(Rational, 3)
  a = M[[1,-1,-1], [-1,1,-1], [2,1,-1]]
  puts "A = "; a.display; puts
  #A =
  #  1,  -1,  -1
  # -1,   1,  -1
  #  2,   1,  -1
  
  e = a.diagonalize
  
  puts "Charactoristic Poly.: #{e.chpoly} => #{e.facts}";puts
  #Charactoristic Poly.: t^3 - t^2 + t - 6 => (t - 2)(t^2 + t + 3)
  
  puts "Algebraic Numbers:"
  e.roots.each do |po, rs|
    puts "#{rs.join(', ')} : roots of #{po} == 0"
  end; puts
  #Algebraic Numbers:
  #a, -a - 1 : roots of t^2 + t + 3 == 0
  
  puts "EigenSpaces: "
  e.evalues.uniq.each do |ev|
    puts "W_{#{ev}} = <#{e.espaces[ev].join(', ')}>"
  end; puts
  #EigenSpaces:
  #W_{2} = <[4, -5, 1]>
  #W_{a} = <[1/3a + 1/3, 1/3a + 1/3, 1]>
  #W_{-a - 1} = <[-1/3a, -1/3a, 1]>
  
  puts "Trans. Matrix:"
  puts "P ="
  e.tmatrix.display; puts
  puts "P^-1 * A * P = "; (e.tmatrix.inverse * a * e.tmatrix).display; puts
  #P =
  #  4, 1/3a + 1/3, -1/3a
  # -5, 1/3a + 1/3, -1/3a
  #  1,   1,   1
  #
  #P^-1 * A * P =
  #  2,   0,   0
  #  0,   a,   0
  #  0,   0, -a - 1
((<_|CONTENTS>))
=end
