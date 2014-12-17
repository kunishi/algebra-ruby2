# Multivariate polynomial ring class over arbitary ring
#
#   by Shin-ichiro Hara
#
# Version 1.6 (2002.02.05)

require "algebra/import-module-single-thread"
require "algebra/m-index"
require "algebra/algebraic-system"
module Algebra
autoload :Groebner, "algebra/groebner-basis"
def MPolynomial(ground, *vars)
  Algebra::MPolynomial.create(ground, *vars)
end
module_function :MPolynomial

class MPolynomial
  auto_req_init
  auto_req(:value_on, "algebra/polynomial-converter"){
    include MPolynomialConverter
  }
  auto_req_s_init
  auto_req_s(:convert_to, "algebra/polynomial-converter"){
    extend MPolynomialConvertTo
  }

=begin
  class MonomialOrder
    def initialize(ord = :lex, t = nil)
#      ord ||= :lex
      case ord
      when Symbol
	@ord_str = ord.id2name
	@ord_sym = ord
      when String
	@ord_sym = ord.intern
	@ord_str = ord
      else
	raise "want Symbol or String"
      end

      if t
	@t = t
	instance_eval("alias cmp #{@ord_str}_t")
      else
	instance_eval("alias cmp #@ord_str")
      end
    end

    def to_s; @ord_str; end
    def to_sym; @ord_sym; end
    def v_ord; @t; end

    #standerd ordering
    def lex(me, other)
      me.to_a <=> other.to_a
    end
    
    def grlex(me, other)
      s = (me.totdeg <=> other.totdeg)
      return s unless s.zero?
      lex(me, other)
    end
    
    def grevlex(me, other)
      s = (me.totdeg <=> other.totdeg)
      return s unless s.zero?
      n = [me.size, other.size].max
      (n-1).downto 0 do |i|
	x = other[i] - me[i]
	return x unless x.zero?
      end
      0
    end

    #ordering by transition array
    def lex_t(me, other)
      n = [me.size, other.size].max
      0.upto (n-1) do |i|
	x = me[@t[i]] - other[@t[i]]
	return x unless x.zero?
      end
      0
    end
    
    def grlex_t(me, other)
      s = (me.totdeg <=> other.totdeg)
      return s unless s.zero?
      lex_t(me, other)
    end
    
    def grevlex_t(me, other)
      s = (me.totdeg <=> other.totdeg)
      return s unless s.zero?
      n = [me.size, other.size].max
      (n-1).downto 0 do |i|
	x = other[@t[i]] - me[@t[i]]
	return x unless x.zero?
      end
      0
    end
  end
=end

  include Enumerable
  include Comparable
  extend AlgebraCreator
  include AlgebraBase
  auto_req :factorize, "algebra/m-polynomial-factor"
  auto_req :divmod_s, "algebra/groebner-basis"
  auto_req :S_pair, "algebra/groebner-basis"
  auto_req :S_pair_coeff, "algebra/groebner-basis"

  def initialize(ha = {})
    @bone = ha
    method_cash_clear
  end

  def self.create(ground, *vars)
    klass = super(ground)
    klass.sysvar(:order, nil)
    klass.sysvar(:v_order, nil)
    klass.set_ord(:lex)
    klass.sysvar(:variables, vars)
    klass.sysvar(:display_type, :norm)
    klass
  end

  def variables; self.class.variables; end
  def vars; self.class.vars; end
  
  def self.vars(*vs)
    if vs.size > 0
      vs = vs[0].scan(/[a-zA-Z]_?\d*/) if vs.size == 1 && vs[0].is_a?(String)
      vs.collect{|var| indeterminate(var)}
    else
      variables.collect{|var| indeterminate(var) }
    end
  end

  def self.to_ary
    [self, *vars]
  end

  def self.indeterminate(obj)
    ind = if i = variables.index(obj)
	    [0] * i + [1]
#	    Algebra::MIndex.monomial(i)
	  else
	    variables.push obj
#	    [0] * (variables.size-1) + [1]
	    Algebra::MIndex.monomial(variables.size-1)
	  end
    monomial(ind)
  end

  def self.var(obj)
    indeterminate(obj)
  end

  def self.mvar(*array)
    if array.empty?
      variables.collect{|var| indeterminate(var) }
    else
      array.collect{|var| indeterminate(var)}
    end
  end

  def self.monomial(ind = [1], c = ground.unity)
     new({Algebra::MIndex[*ind] => c})
  end

  def monomial(ind = [1], c = ground.unity)
    self.class.monomial(ind, c)
  end

  def self.const(x)
    new({Algebra::MIndex::Unity => x})
  end

  def self.regulate(x)
    if x.is_a? self
      x
    elsif y = ground.regulate(x)
      const(y)
    else
      nil
    end
  end

  def self.[](*x)
    new(Hash[*x])
  end

  def self.euclidian?
    ground.euclidian? && variables.size <= 1
  end

  def self.ufd?
    euclidian? || ground.field?
  end

  def each(&b); @bone.each(&b); end

  def keys; @bone.keys; end

  def values; @bone.values; end

  def [](ind)
    @bone[ind] || 0
  end

  def []=(ind, c)
    @bone[ind] = c
  end

  def monomial?
    flag = false
    each do |m, c|
      unless c.zero?
	if flag
	  return false
	else
	  flag = true
	end
      end
    end
    flag
  end

  def constant?
    each do |m, c|
      if m.totdeg > 0 && !c.zero?
	return false
      end
    end
    true
  end

  def unit?
    constant? && lc.unit?
  end

  def constant_coeff
    # we assume {[]=>2, [0]=>3} is not appeared.
    # it must be reduced to {[]=>6}.
    @bone[Algebra::MIndex::Unity]
#    k = ground.unity
#    @bone.each do |ind, c|
#      unless c.zero?
#	k *= c if ind.totdeg == 0
#      end
#    end
#    k
  end

  def include?(k)
    @bone.include?(k)
  end

  def self.zero; new; end

  def self.unity; const(ground.unity); end

  def zero?; !find{|m, c| !c.zero?}; end

  def self.set_ord(ord = nil, v_ord = nil)
#    @@order = MonomialOrder.new(ord, v_ord)
    if ord.is_a? String
      ord = ord.intern
    elsif ord.is_a?(Symbol) || ord.nil?
    else
      raise "#{ord} must be String or Symbol"
    end
    if v_ord.is_a? String
      v_ord = v_ord.intern
    elsif v_ord.is_a?(Symbol) || v_ord.nil?
    else
      raise "#{v_ord} must be String or Symbol"
    end

    if ord.nil?
      ord = get_ord
    end
#    self.order = MonomialOrder.new(ord, v_ord) #o
    self.order = ord if ord #n
    self.v_order = v_ord if v_ord #n
    
    MIndex.set_ord(ord) if ord #n
    MIndex.set_v_ord(v_ord) if v_ord #n
  end

  def self.ord=(ord)
    self.set_ord(ord, nil)
  end

  def self.get_ord
    order
  end

  def self.ord
    get_ord
  end

  def self.get_v_ord
    v_order
  end

  def self.with_ord_old(ord = nil, v_ord = nil, methods = [])
    method_cash_clear(*methods)
    o_ord, o_v_ord = get_ord, get_v_ord
    result = nil
    begin
      set_ord(ord, v_ord)
      result = yield
    ensure
      set_ord(o_ord, o_v_ord)
    end
    result
  end

  def self.with_ord(ord = nil, v_ord = nil, methods = [])
    method_cash_clear(*methods)
    o_ord, o_v_ord = get_ord, get_v_ord
    ord = o_ord unless ord
    result = nil

    if v_ord
      MIndex.set_v_ord(ord, v_ord)
      MIndex.import_module(MIndex.get_module(ord || self.order, v_ord)) do
	result = yield
      end
      MIndex.set_v_ord(o_ord, o_v_ord)
    else
      MIndex.import_module(MIndex.get_module(ord || self.order)) do
	result = yield
      end
    end
    result
  end

  def self.method_cash_clear(*m)
#    $stderr.puts "method_cash_clear is given no parameter" if m.empty?
    m.each do |x|
      x.method_cash_clear
    end
  end

  def method_cash_clear
    @lc = @lm = @lt = @rt = @multideg = nil
  end

  def compact!
    a = {}
    each do |m, c|
      a[m.compact] = c unless c.zero?
    end
    @bone = a
    self
  end

  def multideg
    if @multideg
      @multideg
    else
      d = Algebra::MIndex::Unity
      each do |m, c|
#	d = m if !c.zero? && m > d
#	d = m if !c.zero? && self.class.order.cmp(m, d) > 0 #o
	d = m if !c.zero? && (m <=> d) > 0 #n
      end
      @multideg = d
    end
  end

  def totdeg
    if zero?
      -1
    else
      max = 0
      each do |ind, c|
	unless c.zero?
	  t = ind.totdeg
	  max = t if t > max
	end
      end
      max
    end
  end

  def deg; multideg; end

  def ==(other)
    super{ |other|
      each do |m, c|
	return false unless c == other[m]
      end
      other.each do |m, c|
	if !include? m
	  return false unless c.zero?
	end
      end
      true
    }
  end
  
  def <=>(other)
    if o = regulate(other)
      # THIS IS RATHER VAGUE
      #      lm.ind <=> o.lm.ind
#      self.class.order.cmp(lm.ind, o.lm.ind) #o
      lm.ind <=> o.lm.ind #n
    else
       x , y = other.coerce(self)
      x <=> y
    end
  end

  def +(other)
    super{ |other|
      a = zero
      each do |m, c|
	a[m] = c + other[m]
      end
      other.each do |m, c|
	if !include? m
	  a[m] = self[m] + c
#	  a[m] = c + self[m]
	end
      end
      a
    }
  end

  def -(other)
    super{ |other|
      a = zero
      each do |m, c|
	a[m] = c - other[m]
      end
      other.each do |m, c|
	if !include? m
	  a[m] = self[m] - c
	end
      end
      a
    }
  end

  def *(other)
    super{ |other|
      a = zero
      each do |m0, c0|
	other.each do |m1, c1|
	  a[m0 + m1] +=  c0 * c1
	end
      end
#      a.compact!
      a
    }
  end

  def /(other) # other asume to be scalar
    #    if (o = regulate(other))
    super{ |o|
      if o.constant?
#	self * (ground.unity / o.constant_coeff)
	project{|c, ind|
	  c/o.constant_coeff
	}
      else
	a, r = divmod(other)
	if r.zero?
	  a.first
	else
	  raise "#{other} not divides #{self}"
	end
      end
    }
#    else
#      raise "other(#{o}, #{o.class}) must be monomial"
#    end
  end

  def divmod(*f)
    g = clone # not dup
    f_lts = f.collect{|x| x.lt}
    a = (0...f.size).collect{zero}
    r = zero
    until g.zero?
      flag = false
      f_lts.each_with_index do |f_lt, i|
	g_lt = g.lt
	if f_lt.divide? g_lt
	  d = g_lt / f_lt
          if d == 0 then exit; end
	  a[i] += d
	  g = g.rt - (d * f[i]).rt
	  g.compact!
	  flag = true
	  break
	end
      end
      unless flag
	r += g.lt
	g = g.rt #g.rt!
	g.compact!
      end
    end
    [a, r]
  end

  def divmod_variant(*f)
    g = clone # not dup
    f_lts = f.collect{|x| x.lt}
    a = (0...f.size).collect{zero}
    r = zero
    until g.zero?
      flag = false
      f_lts.each_with_index do |f_lt, i|
	g_lt = g.lt
	if f_lt.divide? g_lt
	  d = g_lt / f_lt
	  a[i] += d
	  g = g.rt - (d * f[i]).rt
	  g.compact!
	  flag = true
	  g.zero? ? break : redo
	end
      end
      unless flag
	r += g.lt
	g = g.rt #g.rt!
      end
    end
    [a, r]
  end

  def %(others)
    divmod(*others).last
  end

  def gcd(other)
    fact = factorize
    fact.gcd(other).pi
  end

  def lc
    @lc ||= self[multideg]
  end
  
  def lm
    #@lm ||= monomial(multideg).extend(Monomial)
    monomial(multideg).extend(Monomial)
  end
  
  def lt
    md = multideg
    @lt ||= monomial(md, self[md]).extend(Monomial)
  end

  def rt
    @rt ||= self - lt
  end

  def rt! # deepy destructive, do NOT use
    @bone.delete(multideg)
    method_cash_clear
    self
  end

  def index_eval(ring, ary, ind)
    e = ring.unity
    ind.each_with_index do |n, i|
      e *= ary[i]**n if n > 0
    end
    e
  end

  def project0(ring = self.class, ary = ring.vars)
    e = ring.zero
    each do |ind, c|
      e += yield(c, ind)
    end
    e
  end
  
  alias map_to project0

  def project(ring = self.class, ary = ring.vars)
    e = ring.zero
    each do |ind, c|
      e += index_eval(ring, ary, ind) * yield(c, ind)
    end
    e
  end

  def evaluate(*ary)
    project(ground, ary){|c, ind| c}
#    project(self.class, ary){|c, ind| c}
  end

  def sub(var, value)
    vs = self.class.vars
    if i = vs.index(var)
      vs = vs.dup
      vs[i] = value
      evaluate(*vs)
    else
      raise "#{var} is not a variable"
    end
  end

  alias call evaluate

  def derivate(v)
    if an = self.class.variables.index(v) || vars.index(v)
      derivate_at(an)
    else
      raise "#{var} is not a variable"
    end
  end

  def derivate_at(an)
    ary = vars
    project0 {|c, ind|
      if ind[an] < 1
	zero
      else
	ind0 = ind - Algebra::MIndex.monomial(an)
	index_eval(self.class, ary, ind0) * ind[an] * c
      end
    }
  end

  def move_const(pb, coef = ground.unity)
    vs = self.class.vars.dup
    a = []
    vs.each_with_index do |x, i|
      a << x + pb[i]*coef
    end
    evaluate(*a)
  end

  def convert_to(ring)
    project(ring){|c, ind| c}
  end

    def need_paren_in_coeff?
      if constant?
        c = constant_coeff
        if c.respond_to?(:need_paren_in_coeff?)
          c.need_paren_in_coeff?
        elsif c.is_a?(Numeric)
          false
        else
          true
        end
      elsif !monomial?
        true
      else
        false
      end
    end

  def to_s
    case self.class.display_type
    when :code
      pr, po =  "*",  "**"
    when :tex
      pr, po =  "",  "}^"
    else
      pr, po =  "",  "^"
    end
    a = []
#    (k = keys).sort!
#    k = keys.sort{|x, y| self.class.order.cmp(x, y)} #o
    k = keys.sort{|x, y| x <=> y} #n
    k.each do |m| c = self[m]
      next if c.zero?
      s =  if m.unity?
	    c.to_s
	   else
	     case c
	     when Numeric
	       c = c == 1 ? "" : c == -1 ? "-" : c.to_s
	     when self.class
	       c = "(#{c})"
	     else
	       c = if c == 1
                     ""
                   elsif c == -1
                     "-"
                   elsif c.respond_to?(:need_paren_in_coeff?)
                     if c.need_paren_in_coeff?
                       "(#{c})"
                     else
                       c.to_s
                     end
                   elsif c.is_a?(Numeric)
                     c.to_s
                   else
                     "(#{c})"
                   end
	     end

             ms = m.to_s(variables, pr, po)
             c.empty? ? ms : c + pr + ms
	   end
      a.unshift s
    end
    a.unshift "0" if a.empty?
    a.join(" + ").gsub(/\+ -/, "- ")
  end

  alias inspect to_s unless $DEBUG

end

class MPolynomial
  module Monomial# < MPolynomial
    attr_reader :ind, :coeff

    def self.extend_object(obj)
#      p [obj, obj.class, obj.monomial?, obj == 0]
#      exit unless obj.monomial?
      raise "'#{obj}' must be monomial" unless obj.monomial?
      super
      obj.ind
      obj.coeff
      self
    end
    
    def ind
      return @ind if @ind
      each do |@ind, @coeff|
	return @ind
      end
      raise "internal error"
    end
    
    def coeff
      return @coeff if @coeff
      each do |@ind, @coeff|
	return @coeff
      end
      raise "internal error"
    end

    def <=>(other)
      #@ind <=> other.ind
#      self.class.order.cmp(@ind, other.ind) #o
      @ind <=> other.ind #n
    end
    
    def divide?(other)
      return true if other.zero?
      case other
      when Monomial
	ind.devide?(other.ind) && (ground.field? ||
                                                  ground.euclidian? &&
                                                  coeff.devide?(other.coeff))
      else
	raise "unkown self.class #{other}(#{other.class})"
      end
    end
    
    def divide_or?(other0, other1)
      return true if other0.zero? && other1.zero?
      if other0.is_a? Monomial and other1.is_a? Monomial
	ind.devide_or?(other0.ind, other1.ind)
      else
	raise "unkown self.class #{other0.class}, #{other1.class}"
      end
    end
    
    def prime_to?(other)
      return false if other.zero?
      case other
      when Monomial
	ind.prime_to?(other.ind)
      else
	raise "unkown self.class #{other}(#{other.class})"
      end
    end
    
    def /(other)
      case other
      when self.class
	self.class[(ind - other.ind), coeff / other.coeff]
      else
	super
      end
    end
    
    def lcm(other)
      monomial(ind.lcm(other.ind)).extend(Monomial)
    end
  end
end
end

if $0 == __FILE__
  include Algebra
  Foo = MPolynomial(Integer)
  f = Foo[Algebra::MIndex[1,1]=>1, Algebra::MIndex[1,3]=>4, Algebra::MIndex[]=>9]
  g = Foo[Algebra::MIndex[1,1]=>1, Algebra::MIndex[1,3]=>4, Algebra::MIndex[]=>9,
    Algebra::MIndex[0,2,3]=>6, Algebra::MIndex[2,3]=>-1, Algebra::MIndex[2]=>-5,Algebra::MIndex[0,1]=>7]
  $DEBUG = true

  puts f, g, f*g

  $DEBUG = false
  puts

  require "algebra/polynomial-converter"
  require "algebra/mathn"
  P = MPolynomial(Rational)
  x, y, z = P.vars("xyz")
  f = x**2*y + x*y**2 + y*2 + z**3
  g = x*y-z**3
  h = y*2-6*z

  P.set_ord(:lex)
  puts "LEX:"
  puts "(#{f}).divmod([#{g}, #{h}]) =>"
  fgh = f.divmod(g, h)
  puts fgh
  puts

  P.method_cash_clear(f, g, h)
  P.set_ord(:grlex)
  puts "GRLEX:"
  puts "(#{f}).divmod([#{g}, #{h}]) =>"
  fgh = f.divmod(g, h)
  puts fgh
  puts

  P.method_cash_clear(f, g, h)
  P.set_ord(:grevlex)
  puts "GREVLEX:"
  puts "(#{f}).divmod([#{g}, #{h}]) =>"
  fgh = f.divmod(g, h)
  puts fgh
  puts

  P.variables.clear
  z, y, x = P.vars("zyx")
  f = x**2*y + x*y**2 + y*2 + z**3
  g = x*y-z**3
  h = y*2-6*z
  puts "GREVLEX: order z, y, x"
  puts "(#{f}).divmod([#{g}, #{h}]) =>"
  fgh = f.divmod(g, h)
  puts fgh
  puts
end
