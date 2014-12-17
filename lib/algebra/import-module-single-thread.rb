#$IMPORT_MODULE_debug = true
require "algebra/import-module"
module Import_Module
  class Scope
    def set_methods
      meths = @target.get_orig_methods(@source)
      @target.def_orig_methods meths
      #def_methods
      mod = @mod
      @klass.class_eval do include mod end
    end

    def push()
      def_methods
      c = @target.stack.current
      @target.stack.push(update(c))
    end

    def pop
      c = @target.stack.pop
      recov_methods(c)
    end

    private
    def update(c)
      d = c.dup
      @source.methods.__each__ do |meth|
	d[meth] = @mod
      end
      d
    end

    def def_methods
      mod = @mod
      target = @target
      @source.methods.__each__ do |meth|
	@klass.module_eval do
	  alias_method meth, Import_Module.name(meth, mod)
	  protected(meth) if target.protecteds.include?(meth)
	  private(meth) if target.privates.include?(meth)
	end
      end
    end

    def recov_methods(c)
      orig_methods = @target.orig_methods
      d = @target.stack.current
      c.__each__ do |meth, mod|
	@klass.module_eval do
	  if m = d[meth] || orig_methods[meth] && :orig
	    alias_method meth, Import_Module.name(meth, m)
	  else
	    undef_method meth
	  end
	end
      end
    end
  end

  class Target
    def initialize(klass)
      @scopes = {}
      @klass = klass
      @publics = @klass.public_instance_methods(true)#.find_all{|m| @klass.public_method_defined? m}
      @privates = @klass.private_instance_methods(true)#.find_all{|m| @klass.private_method_defined? m}
      @protecteds = @klass.protected_instance_methods(true)#.find_all{|m| @klass.protected_method_defined? m}
      @orig_methods = {}
      @saved_methods = {}
      resist_orig_methods
      @stack = Stack.new([Hash.new]) # diff
    end
  end

  class Stack
    private
    def export_current; end
  end
end

class << Thread
  alias new new_org
  alias start new_org
  alias fork new_org
end
