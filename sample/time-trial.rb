# Time Trial
#
#   by Shin-ichiro Hara
#
# Version 1.0 (2001.04.01)

class TimeTrial
  def initialize(name = type.name)
    @name = name
    @time = 0
    @ntime = 0
    @open = false
  end

  def start
    begin
      open
      yield @ntime
    ensure
      close
    end
  end

  def open
    @ntime += 1
    if @open
      $stderr.puts "TimeTrial: warning (duplicate open)"
    end
    @open = true
    @stime = Time.now
  end

  def close
    @time += Time.now - @stime
    unless @open
      $stderr.puts "TimeTrial: warning (duplicate close)"
    end
    @open = nil
  end
  
  def to_s
    "#{@name}: #{@time} sec. (#{@ntime} times)"
  end

  def self.[](s)
    s.split("\s*,\s*").collect{ |name| new(name) }
  end

  alias inspect to_s
end

if __FILE__ == $0
  $a, $b = TimeTrial["addition, multiplication"]
  x = 0
  y = 1
  0.upto 10000 do |i|
    $a.start{
      x += i
    }
    $b.start{
      y *= i
    }
  end
  puts $a, $b
end
