all: update
install:
	@for file in *; do \
		if [ '$$file' != 'Makefile' ] && [ '$$file' != 'readme.md' ]; then \
			if [ -e "$$HOME/.$$file" ]; then \
				echo "$$HOME/.$$file exists"; \
			else \
				ln -s "$$PWD/$$file" "$$HOME/.$$file"; \
			fi \
		fi \
		done
	@git submodule update --init
	@make -s powerline_font

powerline_font:
	-mkdir ~/.fonts
	@cd ~/.fonts/ && git clone https://github.com/scotu/ubuntu-mono-powerline.git

update:
	@git submodule foreach git checkout master
	@cd vim/bundle/powerline && git checkout develop
	@git submodule foreach git pull
	@make -s pathogen

pathogen:
	@cd vim/autoload && rm pathogen.vim && curl -O https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
