
HAS_BOXOLOGY := $(shell command -v boxology --help 2> /dev/null)
LATEX_ENGINE=lualatex
HAS_LATEX := $(shell command -v $(LATEX_ENGINE) -v 2> /dev/null)
HAS_DVISVGM := $(shell command -v dvisvgm 2> /dev/null)
LATEX_MODE ?= batchmode

BOXOLOGY_TEMPLATE = tikz_tpl.tex

############################################################
# Generation of the PAL architecture diagram

.PRECIOUS: %.tex

%.tex: %.json ${BOXOLOGY_TEMPLATE}
ifndef HAS_BOXOLOGY
	$(error "boxology is not available. Please install it from https://github.com/severin-lemaignan/boxology and ensure it is in your PATH")
endif
	boxology -t `dirname $@`/tikz_tpl.tex $< > $@

%.svg: %.tex
ifndef HAS_LATEX
	$(error "LaTeX is not available. Please install it with your package manager")
endif
ifndef HAS_DVISVGM
	$(error "dvisvgm is not available. Please install it with your package manager")
endif
	cd `dirname $<`; $(LATEX_ENGINE) --output-format=dvi --interaction=$(LATEX_MODE) -shell-escape `basename $<`; if [ $$? -gt 0 ]; then echo "Error while compiling $<"; touch `basename $<`; fi
	dvisvgm -O --font-format=woff --linkmark=none --exact $(<:.tex=.dvi) -o $@
	rm -f `dirname $<`/*.aux `dirname $<`/*.log `dirname $<`/*.dvi `dirname $<`/*.out
	# change the size of the SVG to 100% width
	sed -i -E 's/(<svg.+width=).+height.+(viewBox)/\1"100%" \2/' $@

architecture: architecture.svg

all: architecture
