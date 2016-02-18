
vhdl_dir := ../../vhdl

# images to be converted
images := $(wildcard src/images/*.svg)
images += $(wildcard src/images/*.pdf)
images += $(wildcard src/images/*.ps)
images := $(images:.ps=.pdf)
images := $(images:.svg=.pdf)
images := $(patsubst src/%,obj/%,$(images))

#images_eps := $(images)
#images_eps += $(wildcard src/images/*.svg)
#images_eps += $(wildcard src/images/*.png)
#images_eps += $(wildcard src/images/*.jpg)
#images_eps := $(images_eps:.pdf=.eps)
#images_eps := $(images_eps:.svg=.eps)
#images_eps := $(images_eps:.png=.eps)
#images_eps := $(images_eps:.jpg=.eps)
#images_eps := $(patsubst src/%,obj/%,$(images_eps))
 
latex_flags := -output-directory obj
latex_flags += -interaction=batchmode
latex_flags += -halt-on-error

latex_deps := obj/memtabs.tex
latex_deps += obj/logictab.tex
latex_deps += obj/bibliography.tex
latex_deps += src/common_defs.tex
 
doc_name     := c64_pla_dissected
pdf_variants := a4ss a4ds ebook

.SECONDARY:

.PHONY: all
all: $(pdf_variants)

 
###############################################################################
define pdflatex_template
	pdflatex $(latex_flags) -jobname $(doc_name)_$(1) \
		'\newcommand{\documentheader}{\input{src/header_$(1).tex}}' \
		'\input{src/$(doc_name).tex}'
endef

define pdf_template
# newline
.PHONY: $(1)
$(1): obj/$(doc_name)_$(1).pdf
obj/$(doc_name)_$(1).pdf: src/$(doc_name).tex src/header_$(1).tex \
		$$(images) $(latex_deps)
	$(call pdflatex_template,$(1))
	$(call pdflatex_template,$(1))
	cat obj/$(doc_name)_$(1).log | grep -i warning
endef

#$(error $(foreach pdf,$(pdf_variants),$(call pdf_template,$(pdf)))))
$(foreach pdf,$(pdf_variants),$(eval $(call pdf_template,$(pdf))))

###############################################################################
obj/memtabs.tex: $(vhdl_dir)/C64APLA.jed.txt $(vhdl_dir)/pla_jed2tables.py
	$(vhdl_dir)/pla_jed2tables.py $< $@

###############################################################################
obj/logictab.tex: $(vhdl_dir)/C64APLA.jed.txt $(vhdl_dir)/pla_jed2tables.py
	$(vhdl_dir)/pla_jed2tables.py --logic $< $@

###############################################################################
obj/bibliography.tex: src/bibliography.in.tex obj
	cat $< | python sortbib.py > $@ 

###############################################################################
#obj/images/%.eps: obj/images/%.pdf obj/images
#	pdftops -eps $< $@

###############################################################################
#obj/images/%.eps: src/images/%.png obj/images
#	convert $< $@

###############################################################################
#obj/images/%.eps: src/images/%.jpg obj/images
#	convert $< $@

###############################################################################
obj/images/%.v15.pdf: src/images/%.svg obj/images
	inkscape $< --export-pdf=$@ 

###############################################################################
obj/images/%.pdf: src/images/%.ps obj/images
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dEPSCrop \
		-dNOPAUSE -dQUIET -dBATCH -sOutputFile=$@ $<
	
###############################################################################
# Convert version 1.5 PDF files to version 1.4 (cairosvg/inkscape cmd line
# creates 1.5, latex wants 1.4) 
#
%.pdf: %.v15.pdf
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 \
		-dNOPAUSE -dQUIET -dBATCH -sOutputFile=$@ $<

###############################################################################
# create directories 
#
obj:
	mkdir -p $@

obj/images:
	mkdir -p $@

.PHONY: eps
eps: $(images_eps)


###############################################################################
.PHONY: always
always:

###############################################################################
.PHONY: clean
clean:
	rm -rf obj
