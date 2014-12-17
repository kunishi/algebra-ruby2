# Combinatorial Calculation Library
#
#   by Shin-ichiro Hara
#
# Version 2.0 (2001.09.14)

module Combinatorial
  def power(n, m = n)
    if m == 0
      yield([])
    else
      power(n, m - 1) do |x|
        (0...n).each do |i|
          yield([i] + x)
        end
      end
    end
  end

  def perm(n, m = n)
    if m == 0
      yield([])
    else
      perm(n - 1, m - 1) do |x|
        (0...n).each do |i|
          yield([i] + x.collect{|j| j < i ? j : j + 1})
        end
      end
    end
  end

  def comb(n, m = n)
    if m == 0
      yield([])
    else
      comb(n, m - 1) do |x|
        (((x[0] || -1) + 1)...n).each do |i|
          yield([i] + x)
        end
      end
    end
  end

  def rep_comb(n, m)
     if m == 0
       yield([])
     else
       rep_comb(n, m - 1) do |x|
         ((x.empty? ? 0 : x.last)...n).each do |i|
          yield(x+[i])
         end
       end
     end
  end

  def power0(n, m = n)
    0.upto n**m-1 do |i|
      yield( (0...m).collect{ (i, = i.divmod n).last } )
    end
  end

  def perm0(n, stack = [])
    (0...n).each do |x|
      unless stack.include? x
	stack.push x
	if stack.size < n
	  perm0(n, stack) do |y|; yield y; end
	else
	  yield stack.self
	end
	stack.pop
      end
    end
  end

  module_function :power, :perm, :comb, :rep_comb, :power0, :perm0

  module Diagonal
    def diagonal_cone(n, m)
      0.upto n do |i|
	co_diagonal(i, m) do |a|
	  yield a
	end
      end
    end
    
    def co_diagonal(n, m)
      rep_comb(n+1, m-1) do |a|
	yield difference_seq(0, a, n)
      end
    end
    
    def difference_seq(n0, ary, n1)
      x = n0
      a = []
      ary.each do |y|
	a.push y - x
	x = y
      end
      a.push n1 - x
      a
    end
    private :difference_seq
  end
  include Diagonal
  extend Diagonal

  module Cubic
    # power in order of (point, eadges, surfaces, bodies, ..)
    def power_cubic(n, m)
      if n < 1
	raise "cubic(< 1, m) called"
      elsif n == 1
	yield( (0...m).collect{0} )# point of origin
      else
	0.upto m do |dim|
	  Combinatorial.comb(m, dim) do |s|
	    power_cubic(n-1, dim) do |a|
	      yield inject(a, s.sort, m)
	    end
	  end
	end
      end
    end

    def inject(ary, inds, n = inds.size+1)
      (0...n).collect{|i| (k = inds.index(i)) ? 1 + ary[k] : 0}
    end
    private :inject
  end
  include Cubic
  extend Cubic
end

if __FILE__ == $0
#  include Combinatorial
  n, dim = ARGV.collect{|x|x.to_i}
#  n, dim = 2, 3
#  diagonal_cone(n, m) do |a|; p a; end
  Combinatorial::power_cubic(n, dim) do |a|
#  Combinatorial::power_cubic_nested(n, dim) do |a|
    p a
  end
#  $stderr.puts( (2*n+1)**dim )
end
