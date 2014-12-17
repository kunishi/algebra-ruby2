## AUTO Require LIBRARY
##  by Shin-ichiro HARA
##
##  version 1.21 (2002.04.22)
##

class Module
  def _auto_req_init(sw)

    if sw
      code = "AUTO_LOAD = {} unless self.class.const_defined? 'AUTO_LOAD'\n"
    else
      code = "AUTO_LOAD = {} unless const_defined? 'AUTO_LOAD'\n"
    end

    code.concat <<-__CODE__
    def method_missing(sym, *param, &block)
      begin
	file, work = AUTO_LOAD[sym]
	unless file
	  raise NameError,
	    "undefined method `\#{sym.id2name}' for \#{inspect}"
	end
	require file
	work.call if work

	unless respond_to?(sym, true)
	  raise "(auto_req) `\#{sym.id2name}' is not defined for `\#{self}' in file:`\#{file}' \#{self.class.superclass.superclass}"
	end
	send(sym, *param, &block)
      rescue Exception
	$@.delete_if{|trace| trace =~ /^\\(eval\\):/}
	raise
      end
    end
    __CODE__

    sw ? instance_eval(code) : module_eval(code)
  end

  private :_auto_req_init
  def auto_req_init; _auto_req_init(false); end
  def auto_req_s_init; _auto_req_init(true); end

  def _auto_req(meths, file, sw = nil, &b)
    meths = [meths] unless meths.is_a? Array
    meths.each_index do |x, i|
      meth[i] = x.intern if x.is_a? String
    end

    meths.each do |symb|
      code = <<-__CODE__
      AUTO_LOAD[symb.is_a?(String) ? symb.intern : symb] = [file, b]
      __CODE__
      
      sw ? instance_eval(code) : module_eval(code)
    end
  end

  private :_auto_req
  def auto_req(*a, &b); _auto_req(a[0...-1], a[-1], false, &b); end
  def auto_req_s(*a, &b); _auto_req(a[0...-1], a[-1], true, &b); end
end

def auto_req_init
  Object.auto_req_init
end

def auto_req(*a, &b)
  Object.auto_req(*a, &b)
end

if $0 == __FILE__
  class Foo
    auto_req_init
    auto_req(:hello, "hello.rb") {include Hello; extend Hello}
  end
  class Bar < Foo
  end
  Bar.new.hello
  Bar.hello
end
