#!/usr/local/bin/ruby
ENV["RUBYLIB"] ||= ""
ENV["RUBYLIB"] = "tests:../lib:" + ENV["RUBYLIB"]

SKIPED = []
def skip(s)
  SKIPED.push s
end

def allow(script)
  # slow
  if !ENV["TESTS"] || ENV["TESTS"].empty?
    case script
    when /^sample-factorize04\.rb$/ ; skip(script); return false
    end
  end

  # little slow
  if ENV["TESTF"] && !ENV["TESTF"].empty?
    case script
    when /\bsample-factorize05\.rb$/; skip(script); return false
    when /\bsample-jordan-form\.rb$/; skip(script); return false
    when /\bsample-jordan-form01\.rb$/; skip(script); return false
    end
  end

  # 1.8.0 BUG
  if ENV["TEST8"] && !ENV["TEST8"].empty?
    case script
    when /\bsample-m-factorize01\.rb$/; skip(script); return false
    when /\bsample-galois-group01\.rb$/; skip(script); return false
    when /\btest-algebraic-equation\.rb$/; skip(script); return false
    when /\btest-jordan-form\.rb$/; skip(script); return false
    when /\btest-splitting-field\.rb$/; skip(script); return false
    end
  end
  true
end

$SUDDEN_DETH = true

def mktitle(head, ch = "#", ch0 = ch)
  title = ch0 + "  #{head}  " + ch0
  f = ""
  f << ch * (title.size/ch.size) << "\n"
  f << ch0 <<  " " * (title.size-ch0.size*2) << ch0 << "\n"
  f << title << "\n"
  f << ch0 <<  " " * (title.size-ch0.size*2) << ch0 << "\n"
  f << ch * (title.size/ch.size) << "\n"
  f
end

def testscript(fname)
  script = File.basename(fname)
  command = "ruby" + " " + fname
  print mktitle("TEST of '#{script}'")
  r = system(command)
  if r
    print mktitle("TEST SUCCEEDED. '#{script}'", "*", "|")
    puts
  else
    print mktitle("TEST FAILED. '#{script}'", "X")
    puts
    if $SUDDEN_DETH
      puts "\007"
      exit(255)
    end
  end
end

starttime = Time.new
ARGV.each do |fname|
  script = File.basename(fname)
  dir = File.dirname(fname)
  if script =~ /^test-.*.list$/
    open(fname) do |f|
      f.each do |line|
	next if line =~ /^#/ || line =~ /^\s*$/
	x = dir + "/" + line.chomp
	testscript(x)
      end
    end
  elsif script =~ /^test-00-.*\.rb$/
    #testscript(fname)
  elsif script =~ /^test-.*\.rb$/ && allow(script)
    testscript(fname)
  elsif script =~ /^sample-.*\.rb$/ && allow(script)
    testscript(fname)
  else
    puts "SKIP: #{fname}"
    next
  end
end
spendtime = Time.now - starttime
puts
SKIPED.each do |s|
  puts "SKIPED: #{s}."
end
puts "\007"; sleep 0.2; puts "\007"
print mktitle("     ALL TEST SUCCEEDED. (#{spendtime} sec.)     ", "o", "|")
