#  import-module.rb  ... create scope of methods by module
#    by Shin-ichiro Hara
#
#  This library is based on the algorithm of `scope-in-state'
#    by Keiju ISHIZUKA
#
#  Ver. 0.78
#    beta1: adopt ruby-1.8.0
#    beta2: 
#    beta3: 
#    beta4: 
#    beta5: 
#
#  2003.04.30
#
#  Example:
#
#  require "import-module"
#
#  class Foo
#    def hello
#      puts 'hello'
#    end
#  end
#
#  module Bar
#    def hello
#      puts 'bye'
#    end
#  end
#
#  module Baz
#    def hello
#      puts 'good-bye'
#    end
#  end
#
#  foo = Foo.new
#  foo.hello                   #=> hello
#  Foo.import_module(Bar) do
#    foo.hello                 #=> bye
#    Foo.import_module(Baz) do
#      foo.hello               #=> good-bye
#    end
#    foo.hello                 #=> bye
#  end
#  foo.hello                   #=> hello
#
#  Foo.import(Bar) do
#    Foo.hello                 #=> bye
#  end

#$IMPORT_MODULE_debug = true

################################################################ kk
module Import_Module
  IMPORT_MODULE_Version = "0.78beta1"

  module API
    def import_module(mod)
      scope = adopt_module(mod) #not upper compatible
      if block_given?
	begin
	  yield
	ensure
	  scope.pop
	end
      end
    end
    
    def adopt_module(mod)
      sw = Thread.critical or Thread.critical = true # this 'or' is safe
      unless scope = (@__IMPORT_MODULE_PREFIX_scopes ||= {})[mod.object_id]
	scope = Scope.create(self, mod)
	@__IMPORT_MODULE_PREFIX_scopes[mod.object_id] = scope
      end
      scope.push
      Thread.critical = sw
      scope
    end

    def set_orig_method(meth, orig)
      meth = meth.id2name if meth.is_a? Symbol
      orig = orig.id2name if orig.is_a? Symbol
      meth0 = Import_Module.name(orig, :orig)
      module_eval "def #{meth}(*a, &b); #{meth0}(*a, &b); end\n"
    end
  end

  def self.name(meth, s, prefix = true)
    name = s.to_s.gsub(/_|::|[^\w]/){|c| "_%03d" % [c[0]]}
    if meth =~ /^[_a-zA-Z][_\w]*$/
      meth = "__" + meth
    else
      meth = "_op" + meth.gsub(/[^\w]/){|c| "%03d" % [c[0]]} + "__"
    end
    (prefix ? "__IMPORT_MODULE_PREFIX_" : "") + name + meth
  end

################################################################ kk
  class Scope
    attr_reader :target, :klass, :source, :mod
    @@cm_no = -1

    def self.create(klass, mod)
      target = Target.enclose(klass)
      source = Source.enclose(mod)
      scope = enclose(target, source)
      scope.set_methods
      scope
    end

    def self.enclose(target, source)
      target.scopes[source.mod] ||= new(target, source)
    end

    def initialize(target, source)
      @target = target
      @klass = target.klass
      @source = source
      @mod = source.mod
    end

    def activate
      push
      begin
	yield
      ensure
	pop
      end
    end

    def set_methods
      meths = @target.get_orig_methods(@source)
      @target.def_orig_methods(meths)
      set_meth_no
      def_methods
      mod = @mod
      @klass.class_eval do include mod end
    end

    def inspect
      "Scope(#{@target.inspect}, #{@source.inspect})"
    end

    def push()
      c = Thread.current.__IMPORT_MODULE_PREFIX_stack.current
      Thread.current.__IMPORT_MODULE_PREFIX_stack.push(update(c))
    end

    def pop
      Thread.current.__IMPORT_MODULE_PREFIX_stack.pop
    end

#    private ### this declearation makes it slow

    def set_meth_no
      @source.methods.__each__ do |meth|
	@target.meth_no[meth] || @target.meth_no[meth] = (@@cm_no += 1)
      end
    end

    def update(c)
      d = c.dup
      @source.methods.__each__ do |meth|
	d[@target.meth_no[meth]] = @mod.object_id
      end
      d
    end

    def def_methods
      # Define new methods in the target class
      t = ""
      @source.methods.__each__ do |meth|
	puts "#{@klass}> def #{meth}(#{@source.param(meth)})" if $IMPORT_MODULE_debug
	s, = method_code(meth)
	t << s
      end
      @klass.module_eval t
    end

    def method_code(meth)
      param = @source.param(meth)
      no = @target.meth_no[meth]
      line_no = __LINE__ + 1
      s = "def #{meth}(#{param})\n"
      s << "  modid = Thread.current.__IMPORT_MODULE_PREFIX_proxy[#{no}]\n"
      i = 0
      @target.scopes.each_key do |mod|
	s << (i == 0 ? "  " : "  els") << "if modid == #{mod.object_id}\n"
	s << "    #{Import_Module.name(meth, mod)}(#{param})\n"
	i += 1
      end
      s << "  else\n" if i > 0
      s << "    #{Import_Module.name(meth, :orig)}(#{param})\n"
      s << "  end\n" if i > 0
      s << "end\n"
      s << "protected(:#{meth})\n" if @target.protecteds.include?(meth)
      s << "private(:#{meth})\n" if @target.privates.include?(meth)
      [s, __FILE__, line_no]
    end
  end

################################################################ kk
  class Target
    attr_reader :scopes, :meth_no
    attr_accessor :klass, :stack
    attr_accessor :orig_methods, :saved_methods
    attr_accessor :publics, :privates, :protecteds
    
    def self.enclose(klass)
      s = self
      klass.instance_eval do
	@__IMPORT_MODULE_PREFIX_target ||= s.new(klass)
      end
    end
    
    def initialize(klass)
      @scopes = {}
      @meth_no = {}
      @klass = klass
      @publics = @klass.public_instance_methods(true)#.find_all{|m| @klass.public_method_defined? m}
      @privates = @klass.private_instance_methods(true)#.find_all{|m| @klass.private_method_defined? m}
      @protecteds = @klass.protected_instance_methods(true)#.find_all{|m| @klass.protected_method_defined? m}
      @orig_methods = {}
      @saved_methods = {}
      resist_orig_methods
    end

    def inspect
      "Target(#{@klass})"
    end

    def def_orig_methods(meths, pub_sw = false)
      # Store original methods of the root class
      @klass.module_eval do
	meths.__each__ do |meth|
	  meth0 = Import_Module.name(meth, :orig)
	  alias_method meth0, meth
	  public meth0 if pub_sw
	end
      end
    end

    def get_orig_methods(source)
      meths = []
      source.methods.__each__ do |meth|
	if @orig_methods[meth] && !@saved_methods[meth]
	  @saved_methods[meth] = true
	  meths.push meth
	end
      end
      meths
    end

    private

    def resist_orig_methods
      @publics.__each__ do |x|
	@orig_methods[x] = true
      end
      @protecteds.__each__ do |x|
	@orig_methods[x] = true
      end
      @privates.__each__ do |x|
	@orig_methods[x] = true
      end
    end
  end

################################################################ kk
  class Source
    attr_reader :mod, :methods
    def self.enclose(mod)
      s = self
      mod.instance_eval do
	@__IMPORT_MODULE_PREFIX_source or
	   @__IMPORT_MODULE_PREFIX_source = s.new(mod)
      end
    end

    def initialize(mod)
      @mod = mod
      @methods = _methods
      store
    end

    def inspect
      "Source(#{@mod})"
    end

    def param(meth)
      s = ""
      if (n = @mod.instance_method(meth).arity) >= 0
	n.times do |i| s << "x#{i}, " end
	s << "&b"
      else
	(-n-1).times do |i| s << "x#{i}, " end
	s << "*a, &b"
      end
    end

    def param0(meth)
      s = ""
      if (n = @mod.instance_method(meth).arity) >= 0
	n.times do |i| s << "x#{i}, " end
	s << "b"
      else
	(-n-1).times do |i| s << "x#{i}, " end
	s << "a, b"
      end
    end

    private

    def _methods
      meths = @mod.instance_methods(true)
      meths.concat @mod.protected_instance_methods(true)
      meths.concat @mod.private_instance_methods(true)
      meths.reject!{|f| f =~ /^__IMPORT_MODULE_PREFIX_/ }
      meths
    end

    def store
      # Store Soruce methods
      methods = @methods
      @mod.module_eval do
	methods.__each__ do |meth|
	  meth0 = Import_Module.name(meth, self)
	  unless method_defined? meth0
	    alias_method meth0, meth
	    public meth0 if true
	  end
	end
      end
    end
  end

################################################################ kk
  class Stack
    def initialize(a)
      @stack = a
      export_current
    end

    def dup
      self.class.new(@stack.dup)
    end

    def current
      @stack.last
    end

    def push(c)
      @stack.push c
      export_current
    end

    def nop(scope)
      NO USE
    end

    def pop
      c = @stack.pop
      export_current
      c
    end

    private
    def export_current
      Thread.current.__IMPORT_MODULE_PREFIX_proxy = current
    end
  end
end

################################################################ kk
Module.module_eval do
  include Import_Module::API
end

class Thread
  attr_accessor :__IMPORT_MODULE_PREFIX_proxy
  attr_accessor :__IMPORT_MODULE_PREFIX_stack
end

class << Thread
  alias new_org new
  
  def new(*opts, &b)
    Thread.new_org(Thread.current, *opts) do |parent, *opts|
      Thread.current.__IMPORT_MODULE_PREFIX_stack =
	parent.__IMPORT_MODULE_PREFIX_stack.dup
      yield *opts
    end
  end
  alias start new
  alias fork new
end

Thread.current.__IMPORT_MODULE_PREFIX_stack =
  Import_Module::Stack.new([Array.new])
#  Import_Module::Stack.new([Hash.new])

class Object
  def import(mod)
    (class << self; self; end).import_module(mod) do
      yield self
    end
  end

  def adopt(mod)
    (class << self; self; end).adopt_module(mod)
    self
  end
end

class Array
  alias __each__ each
end

class Hash
  alias __each__ each
end

################################################################ kk
if $IMPORT_MODULE_debug
  class Module
    alias include_orig include
    def include(mod)
      puts "#{self}> includes #{mod}"
      include_orig mod
    end

    alias alias_method_orig alias_method
    def alias_method(a, b)
      a0 = a.sub(/__IMPORT_MODULE_PREFIX_/, "@").sub(/\d+(\d{3})/, '\1')
      b0 = b.sub(/__IMPORT_MODULE_PREFIX_/, "@").sub(/\d+(\d{3})/, '\1')
      puts "#{self}> #{a0} = #{b0}"
      alias_method_orig a, b
    end

    alias remove_method_orig remove_method
    def remove_method(a)
      a0 = a.sub(/__IMPORT_MODULE_PREFIX_/, "@").sub(/\d+(\d{3})/, '\1')
      puts "#{self}> remove #{a0}"
      remove_method_orig a
    end

    alias undef_method_orig undef_method
    def undef_method(a)
      a0 = a.sub(/__IMPORT_MODULE_PREFIX_/, "@").sub(/\d+(\d{3})/, '\1')
      puts "#{self}> undef #{a0}"
      undef_method_orig a
    end
  end
end

################################################################ kk
if $0 == __FILE__
  class Foo
    def hello
      puts 'hello'
    end
  end

  module Bar
    def hello
      puts 'bye'
    end
  end

  module Baz
    def hello
      puts 'good-bye'
    end
  end

  foo = Foo.new
  foo.hello                   #=> hello
  Foo.import_module(Bar) do
    foo.hello                 #=> bye
    Foo.import_module(Baz) do
      foo.hello               #=> good-bye
    end
    foo.hello                 #=> bye
  end
  foo.hello                   #=> hello
  puts

  Foo.import(Bar) do
    Foo.hello                 #=> bye
  end
end
