ruby = ruby
all: sample list

sample:
	export RUBYLIB=../lib:$(RUBYLIB);\
	$(ruby) do-testscripts.rb sample-*.rb

list:
	export RUBYLIB=.:$(RUBYLIB);\
	$(ruby) do-testscripts.rb *.list
