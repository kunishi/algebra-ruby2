ruby = ruby
all: sample rb list

sample:
	export RUBYLIB=../lib:$(RUBYLIB);\
	$(ruby) do-testscripts.rb ../sample/sample-*.rb

rb:
	export RUBYLIB=.:$(RUBYLIB);\
	$(ruby) do-testscripts.rb *.rb

list:
	export RUBYLIB=.:$(RUBYLIB);\
	$(ruby) do-testscripts.rb *.list
