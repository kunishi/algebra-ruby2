$N = 0
def assert(m, n = nil)
  return if $spot && self.to_s != $spot
  $N += 1
  unless n.nil?
    if m == n
      puts "#$N (#{self}): OK"
    else
      puts "NG (#{self}): #{m.inspect} != #{n.inspect}"
      puts caller#.first
      exit!(255)
    end
  else
    if m
      puts "#$N (#{self}): OK"
    else
      puts "NG (#{self}): #{m.inspect}"
      puts caller#.first
      exit!(255)
    end
  end
end
