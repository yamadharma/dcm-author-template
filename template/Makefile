FILE = `cat NAME`
LATEX = lualatex

all:
	$(LATEX) $(FILE)
	$(LATEX) $(FILE)
	-biber $(FILE)
	$(LATEX) $(FILE)
	$(LATEX) $(FILE)
	mkdir -p out
	mv $(FILE).pdf out

cleanall: clean

clean:
	-rm -f *.{log,toc,tac,aux,dvi,ps,bbl,blg,tmp,nav,out,snm,vrb,rel,thm,rel,*~,ilg,titlelist.tex} $(FILE).pdf
	-rm -f *.4o[mftsy] *.{ojs.ini,xml,mw,loa,idx} *_latexmk
	-rm -f split*
	rm -rf out auto
	for i in $(ALLSUBDIRS); do \
	    (cd $$i; make clean) || exit 1; \
	done


