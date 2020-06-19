###############################################################################
## Makefile for apertium-grn
###############################################################################

LANG1=grn
BASENAME=apertium-$(LANG1)

TARGETS_COMMON =			\
	$(LANG1).automorf.hfst		\
	$(LANG1).automorf.bin		\
	$(LANG1).automorf.att.gz	\
	$(LANG1).autogen.hfst		\
	$(LANG1).autogen.bin		\
	$(LANG1).autogen.att.gz		\
	$(LANG1).autoseg.hfst		\
	$(LANG1).autoseg.bin		\
	$(LANG1).rlx.bin

# This include defines goals for install-modes, .deps/.d and .mode files:
@ap_include@

###############################################################################

grn.automorf.hfst: grn.mor.hfst 
	hfst-fst2fst -w $< -o $@

grn.autogen.hfst: grn.gen.hfst
	hfst-fst2fst -w $< -o $@

grn.autoseg.hfst: grn.seg.hfst 
	hfst-fst2fst -w $< -o $@

grn.mor.hfst: grn.gen.hfst grn.mor.twol.hfst grn.spellrelax.hfst
	hfst-compose-intersect -1 grn.gen.hfst -2 grn.mor.twol.hfst | hfst-compose -F -1 - -2 grn.spellrelax.hfst | hfst-invert -o $@

# <impf><o_pl1><s_pl3>tʼis<v><tv>+o<mark>:k>oj>ki>tʼis>o
grn.gen.hfst: grn.lexc.hfst grn.twol.hfst
	hfst-compose-intersect -1 grn.lexc.hfst -2 grn.twol.hfst -o $@

grn.twol.hfst: apertium-grn.grn.twol
	hfst-twolc $< -o $@

# <impf><o_pl1><s_pl3>tʼis<v><tv>+o<mark>:k>{o}j>k{i}>tʼis>o
grn.lexc.hfst: apertium-grn.grn.lexc
	hfst-lexc -A --Werror $< -o $@

grn.mor.twol.hfst: apertium-grn.grn.mor.twol
	hfst-twolc apertium-grn.grn.mor.twol -o grn.mor.twol.hfst

# kojkitʼiso:k>oj>ki>tʼis>o
grn.seg.hfst: grn.mor.hfst grn.gen.hfst
	hfst-compose -F -1 grn.mor.hfst -2 grn.gen.hfst -o grn.seg.hfst 

grn.spellrelax.hfst: apertium-grn.grn.spellrelax 
	hfst-regexp2fst -S -o $@ < $<

grn.rlx.bin: apertium-grn.grn.rlx
	cg-comp $< $@

$(LANG1).autogen.att.gz: $(LANG1).gen.hfst
	hfst-fst2txt $< | gzip -9 -c > $@

$(LANG1).automorf.att.gz: $(LANG1).mor.hfst
	hfst-fst2txt $< | gzip -9 -c > $@

$(LANG1).autoseg.att.gz: $(LANG1).seg.hfst
	hfst-fst2txt $< | gzip -9 -c > $@

$(LANG1).autogen.bin: $(LANG1).autogen.att.gz .deps/.d
	zcat < $< > .deps/$(LANG1).autogen.att
	lt-comp lr .deps/$(LANG1).autogen.att $@

$(LANG1).automorf.bin: $(LANG1).automorf.att.gz .deps/.d
	zcat < $< > .deps/$(LANG1).automorf.att
	lt-comp lr .deps/$(LANG1).automorf.att $@

$(LANG1).autoseg.bin: $(LANG1).autoseg.att.gz .deps/.d
	zcat < $< > .deps/$(LANG1).autoseg.att
	lt-comp lr .deps/$(LANG1).autoseg.att $@

###############################################################################
## Distribution
###############################################################################

EXTRA_DIST=$(BASENAME).$(LANG1).lexc		\
		$(BASENAME).$(LANG1).twol	\
		$(BASENAME).$(LANG1).spellrelax \
		$(BASENAME).$(LANG1).rlx	\
		modes.xml

###############################################################################
## Installation stuff
###############################################################################
#
#   apertium_grn_dir: This is where the compiled binaries go
#   apertium_grn_srcdir: This is where the source files go

apertium_grndir=$(prefix)/share/apertium/$(BASENAME)/
apertium_grn_srcdir=$(prefix)/share/apertium/$(BASENAME)/

EXTRA_TARGETS=

if HAVE_HFSTOSPELL
EXTRA_TARGETS += $(LANG1).zhfst
endif # HAVE_HFSTOSPELL

apertium_grn_DATA=$(TARGETS_COMMON) $(EXTRA_TARGETS) 

pkgconfigdir = $(prefix)/share/pkgconfig
pkgconfig_DATA = $(BASENAME).pc

noinst_DATA=modes/$(LANG1)-morph.mode

install-data-local: install-modes
	$(INSTALL_DATA) $(BASENAME).$(LANG1).lexc $(DESTDIR)$(apertium_grn_srcdir)
	$(INSTALL_DATA) $(BASENAME).$(LANG1).twol $(DESTDIR)$(apertium_grn_srcdir)
	$(INSTALL_DATA) $(BASENAME).$(LANG1).rlx $(DESTDIR)$(apertium_grn_srcdir)


###############################################################################
## Cleanup
###############################################################################

CLEANFILES = $(TARGETS_COMMON)
clean-local:
	-rm -rf .deps modes

###############################################################################
