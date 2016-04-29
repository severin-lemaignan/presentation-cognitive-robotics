
LATEX=lualatex
TARGET=presentation.tex

DOT=$(wildcard figs/*.dot)
SVG=$(wildcard figs/*.svg)

all: paper

%.pdf: %.svg
	inkscape --export-pdf $(@) $(<)

%.aux: paper

%.svg: %.dot

	twopi -Tsvg -o$(@) $(<)

thumbs:

	./make_video_preview.py ${TARGET}

bib: $(TARGET:.tex=.aux)

	BSTINPUTS=:./style bibtex $(TARGET:.tex=.aux)

paper: $(TARGET) $(SVG:.svg=.pdf) $(DOT:.dot=.pdf)

	TEXINPUTS=:./style $(LATEX) --shell-escape $(TARGET)

clean:
	rm -f *.vrb *.spl *.idx *.aux *.log *.snm *.out *.toc *.nav *intermediate *~ *.glo *.ist *.bbl *.blg $(SVG:.svg=.pdf) $(DOT:.dot=.svg) $(DOT:.dot=.pdf)
	rm -rf _minted*

distclean: clean
	rm -f $(TARGET:.tex=.pdf)
