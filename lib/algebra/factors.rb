# Expression of Divisors
#
#   by Shin-ichiro Hara
#
# Version 1.1 (2001.08.12)

module Algebra
  class Factors
    include Enumerable
    
    def self.[](*a)
      fact = new
      a.each do |x|
        fact.multiply(x)
      end
      fact
    end
    def self.mk(*a)
      k = 0
      b = []
      while k < a.size
        f = a[k]; k += 1
        i = a[k]; k += 1
        raise "parameter error (#{i})" unless i.is_a? Integer
        b.push [f, i]
      end
      new(b)
    end
    def self.seki(a)
      k = a.first
      a[1..-1].each do |m|
        k *= m
      end
      k
    end
    def initialize(array = [])
      @bone = array
    end
    def dup; self.class.new(@bone.collect{|f, i| [f, i]}); end
    def to_a; @bone; end
    alias to_ary to_a
    def each(&b); @bone.each(&b); end
    def size; @bone.size; end
    def shift; @bone.shift; end
    def fact_size;
      n = 0
      each do |f, i|; n += i; end
      n
    end
    def fact(i); @bone[i].first; end
    def empty?; @bone.empty?; end
    def head; @bone.first; end
    def tail; self.class.new(@bone[1..-1]); end
    def push(other); @bone.push other; self; end
    def unshift(other); @bone.unshift(other); self; end
    def collect(&b); self.class.new(@bone.collect(&b)); end
    def map(&b); self.class.new(@bone.collect{|f, i| [yield(f), i]}); end
    def collect!(&b); @bone.collect!(&b); self; end
    def map!(&b); @bone.collect!{|f, i| [yield(f), i]}; self; end

    def normalize!
      c = nil
      @bone.delete_if do |fact|
        f, i = fact
        if f.respond_to?(:constant?) and f.constant?
          c and c *= f**i or c = f**i
          true
        end
      end
      if c
        unless c.respond_to?(:unity?) && c.unity? && @bone.size > 0
          @bone.unshift [c, 1]
        end
      end
      self
    end

    def multiply(other, n = 1)
      flag = false
      @bone.each do |fact|
        f, i = fact
        if f == other
          fact[1] = fact[1]+ 1
          flag = true
          break
        end
      end
      @bone.push [other, n] unless flag
      normalize!
      self
    end

    def gcd(other)
      bone = []
      @bone.each do |f, n|
        i = n
        until i == 0 || (other % [f ** i]).zero?
          i -= 1
        end
        bone.push [f, i]
      end
      self.class.new(bone)
    end
    
    def concat(facts)
      facts.each do |f, i|
        multiply f, i
      end
      self
    end
    
    def *(o)
      case o
      when self.class
        dup.concat(o)
      else
        #self.class.new(dup.multiply(o).to_a)
        dup.multiply(o)
      end
    end

    alias << multiply

    def **(n)
      fac = self.class.new
      n.times do
        fac *= self
      end
      fac
    end

    def pi
      x = 1
      @bone.each do |f_i|
        f, i = f_i
        if i
          x *= f**i
        else
          x *= f
        end
      end
      x
    end

    def ==(fact)
      if pi == fact.pi
	flag = false
	@bone.each do |f, i|
	  fact.each do |g, j|
	    if f == g || f == -g # this will be improved.
	      unless i == j
		return false
	      end
	    end
	  end
	end
	true
      else
	false
      end
    end

    def to_s
      return "1" if @bone.empty?
      a, b = @bone.size == 1 && @bone.first.last == 1? ["", ""] : ["(", ")"]
      @bone.collect{|x|
        "#{a}#{x.first}#{b}" + (x.last > 1 ? "^#{x.last}" : "")
      }.join("")
    end
    alias inspect to_s

    def each_product0 #create non trivial powers
      if size > 0
        fact0, e0 = head
        yield fact0
        tail.each_product do |fact, e|
          yield fact
        end
        tail.each_product do |fact, e|
          yield fact0*fact # e is ignored
        end
      end
    end

    def each_product #create non trivial powers
      idx0 = (0...size).to_a
      indices = []
      idx0.each do |i|
        break if i >= size
        indices.push [idx0[i...size], [i], fact(i)]
      end
      
      avoid = []
      until indices.empty?
        idx, rdx, f = indices.shift
        i = idx.first
        next if avoid.find{|x| !(rdx & x).empty? }
        #print rdx.inspect + " : "
        r = yield(f)
        if r
          avoid.push rdx
          next
        end
        idx.each_index do |k|
          if k > 0 and k < idx.size
            idx1 = idx[k..-1]
            rdx1 = rdx + [idx[k]]
            next if avoid.find{|x| !(rdx1 & x).empty?}
            f1 = f * fact(idx[k])
            indices.push [idx1, rdx1, f1]
          end
        end
      end
    end

    def fact_all(f)
      facts = self.class.new
      each do |g, e|
	next if e <= 0
	i = 0
	loop do
	  q, r = f.divmod_ED g
	  if r.zero?
	    f = q
	    i += 1
	  else
	    facts.push [g, i]
	    break
	  end
	end
      end
      facts
    end

    def fact_all_u(f)
      facts = self.class.new
      each do |g, e|
	next if e <= 0
	next if g.constant?
	i = 0
	loop do
	  q, r = f.divmod g
	  if r.zero?
	    f = q.first
	    i += 1
	  else
	    facts.push [g, i]
	    break
	  end
	end
      end
      facts
    end

    def correct_lc!(f)
      k = f.ground.unity
      each_with_index do |(g, i), j|
        glc = g.lc
        if glc != glc.unity && glc.unit?
          @bone[j] = [g/glc, i]
        else
          k *= glc ** i
        end
      end
      m = f.lc / k
      unless m == f.ground.unity
        unshift([m*f.unity, 1])
      end
      self
    end

    def mcorrect_lc!(f, an)
#      k = f.ground.unity
      k = f.unity
      each_with_index do |(g, i), j|
        glc = g.lc_at(an)
        if glc.unit? && glc != glc.unity
          @bone[j] = [g/glc, i]
        else
          k *= glc ** i
        end
      end
      m = f.lc_at(an).divmod(k).first.first
      unless  m == f.ground.unity
        concat yield(m)
      end
      self
    end
  end
end

if $0 == __FILE__
  include Algebra
  p Factors.new([[2, 2], [3, 2], [5, 2]]).pi == (2*3*5)**2
  
  facts = Factors.new
  facts << 2 << 3 << 5 << 7 << 11 << 13
 k = 0
  facts.each_product do |x|
    k += 1
    p x
    x == 21
  end
  p k
end
