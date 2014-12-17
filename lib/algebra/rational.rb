if ENV["RUBY_RAT"]
  $LOAD_PATH.unshift ENV["RUBY_RAT"]
  require "rational.rb"
elsif ENV["RUBY_USE_FRACTION"]
  require "frac"
  class Fraction < Numeric
    instance_eval do
      alias new! new
    end
    
    def initialize(n, d = 1)
      @numerator, @denominator = n, d
    end
  end

  Rational = Fraction
  alias Rational frac

  class Rational < Numeric
    def self.unity; new(1,1); end
    def self.zero; new(0,1); end
    def inverse; 1 / self; end
  end
else
  require "rational"
end

class Rational < Numeric
  public_class_method :new

#  def pdivmod(other); [self / other, zero]; end
  alias pdivmod divmod

  def self.ground; Integer; end

  def self.regulate(o)
    case o
    when self
      o
    when Numeric
      Rational(o)
    else
      nil
    end
  end

  def self.wedge(otype)
    if otype <= Integer || otype <= self
      self
    else
      otype
    end
  end

  def devide?(other); true; end

  def gcd_coeff(b)
    if b.zero?
      [self, self.class.unity, self.class.zero]
    else
      q, r = divmod b
      d, x, y = b.gcd_coeff(r)
      [d, y, x - y * q]
    end
  end

  def self.unity; new(1, 1); end
  def self.zero; new(0, 1); end

  def mod(o)
    raise ZeroDivisionError, "devided by 0" if o.zero?
    den, a, = denominator.gcd_coeff(o)
    num = (numerator * a) % o
    q, r = num.divmod den
    raise "denominator(#{denominator}) can not divide numerator(#{numerator}) mod #{o}" unless r.zero?
    q
  end
end
