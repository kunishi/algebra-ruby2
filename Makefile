project = project
workdir = work

.PHONY: test doc

main:
	@echo Hello.

install:
	ruby install.rb

install-man: 
	ruby install.rb --man

test:
	cd test; make

