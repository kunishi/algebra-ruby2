# Prime Generator
#
#   by Shin-ichiro Hara
#
# Version 1.0 (2001.09.07)

class Primes
  List = [2, 3]
  def [](n); List[n]; end
  def succ
    n = List[-1] + 2
    n += 2 while List.find{|k| n % k == 0}
    List << n
    n
  end

  def each
    List.each do |x|
      yield x
    end
    loop do
      yield succ
    end
  end

  def self.include?(x)
    new.each do |prm|
      return false if prm > x
      return true if prm == x
    end
  end
end
