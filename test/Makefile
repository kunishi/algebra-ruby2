ruby = ruby
all: rb

rb:
	export RUBYLIB=.:$(RUBYLIB);\
	$(ruby) do-testscripts.rb test-*.rb
