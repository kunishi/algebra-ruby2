# Numeric Supplements
#
#   by Shin-ichiro Hara
#
# Version 1.01 (2001.04.10)

class Numeric
  def self.unity; 1; end
  def self.zero; 0; end
  def zero; self.class.zero; end
  def unity; self.class.unity; end
  def self.indeterminate(x)
    eval(x)
  end
  def self.const(x); x; end
  def each; end
  def pdivmod(other); divmod(other); end
  def unity?; self == 1; end
  def unit?; self == unity or self == -unity; end
  def monomial?; true; end
  def inverse; self == -1 ? -1 : 1; end
  def self.field?; true; end
  def self.euclidian?; true; end
  def self.ufd?; true; end

  def self.regulate(x)
#    if x.is_a? self
    if x.is_a? Numeric
      x # Numeric's can be operated each other.
    else
      nil
    end
  end
  def regulate(x)
    self.class.regulate(x)
  end
  private :regulate
end

class Integer < Numeric
  def self.ground; self; end
  def self.field?; false; end
#  def self.field?; respond_to?(:from_prime_division); end #mathn loaded
  def self.euclidian?; true; end
  def devide?(other)
    case other
    when Integer
      (other % self).zero?
    else
      # this case will occur when mathn is required
      (other / self) * self == other
#      raise "devide?: unkown self.class(#{other})"
    end
  end
end

class Float < Numeric
  def self.unity; 1.0; end
  def self.zero; 0.0; end
end

class Complex < Numeric
  def self.unity; new(1); end
  def self.zero; new(0); end
end
