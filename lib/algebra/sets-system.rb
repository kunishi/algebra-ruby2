class Class
  def use_setname
    const = 'C__names__'
    evalstr = <<-__END_OF_EVAL__
    class #{name}
      raise '#{const} is already defined.' if defined? #{const}
      
      #{const} = {}
      
      raise 'setname is already defined.' if defined? setname

      def setname(s)
	#{const}[self] = s
      end
      
      alias inspect! inspect
      
      def inspect
	#{const}[self] || super
      end
      
    end
    __END_OF_EVAL__
    eval(evalstr, TOPLEVEL_BINDING)
  end
end

module Marshal
  def self.put(obj, filename)
    open(filename, "wb") do |f|
      Marshal.dump(obj, f)
    end
  end
  def self.get(filename)
    open(filename, "rb") do |f|
      Marshal.load(f)
    end
  end
end

def p!(x); puts x.inspect!; end


