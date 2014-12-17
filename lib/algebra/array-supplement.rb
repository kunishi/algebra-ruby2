# Array Supplements
#
#   by Shin-ichiro Hara
#
# Version 1.2 (2001.07.23)

class Array
  def each_pair
    each_with_index do |x, i|
      (i+1).upto(size-1) do |j| y = self[j]
	yield(x, y)
      end
    end
  end

  def each_pair_with_index
    each_with_index do |x, i|
      (i+1).upto(size-1) do |j| y = self[j]
	yield(x, y, i, j)
      end
    end
  end

  def rsort!
    sort!
    reverse!
    self
  end

  def rsort
    s = sort
    s.reverse!
    s
  end

  def inner_product(other)
    sum = 0
    each_with_index do |x, i|
      sum += x * other[i]
    end
    sum
  end

  def sumation
    sum = 0
    each do |x|
      sum += x
    end
    sum
  end
end
