DESTDIR =
PREFIX = $(HOME)
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man

CC = tcc
CFLAGS = -g -Wall -Werror -O0

PROGS = \
	cat \
	echo \
	false \
	fuzzy \
	rm \
	seq \
	sort \
	true \
	yes

MANDOCS = \
	cat.1 \
	echo.1 \
	fuzzy.1 \
	seq.1 \
	sort.1

HTMLDOCS = \
	cat.html \
	echo.html \
	fuzzy.html \
	seq.html \
	sort.html

##############################

all: $(PROGS)

# Programs
.c:
	@echo ' ' CC ' ' $@; $(CC) $(CFLAGS) -o $@ $<

# Documentation
doc: man html
html: $(HTMLDOCS)
man: $(MANDOCS)
	@echo ' ' FIX ' ' man; \
	sed -i -e '10s/ "\[FIXME: source\]" "\[FIXME: manual\]"//' ${MANDOCS}

%.html: %.txt
	@echo ' ' HTML ' ' $@; asciidoc $<

%.xml: %.txt
	@echo ' ' XML ' ' $@; asciidoc -d manpage -b docbook $<

%.1: %.xml
	@echo ' ' MAN ' ' $@; xmlto -m .manpage-normal.xsl man $<

# Housekeeping
clean:
	@for i in $(PROGS); do \
		test -f $$i && echo ' ' CLEAN ' ' $$i && rm $$i; \
	done || true
	@for i in *.1 *.2 *.3 *.4 *.5 *.6 *.7 *.8; do \
		test -f $$i && echo ' ' CLEAN ' ' $$i && rm $$i; \
	done || true
	@for i in *.html; do \
		test -f $$i && echo ' ' CLEAN ' ' $$i && rm $$i; \
	done || true
	@for i in *.xml; do \
		test -f $$i && echo ' ' CLEAN ' ' $$i && rm $$i; \
	done || true

# Installation
install: all
	@echo ' ' DIR ' ' $(DESTDIR)/$(BINDIR); mkdir $(DESTDIR)/$(BINDIR)/
	@for i in $(PROGS); do \
		echo ' ' INSTALL ' ' $$i; cp -f $$i $(DESTDIR)/$(BINDIR)/$$i; \
	done

install-man: man
	@echo ' ' DIR ' ' $(DESTDIR)/$(MANDIR)/man1; mkdir $(DESTDIR)/$(MANDIR)/man1
	@for i in $(MAN1DOCS); do \
		echo ' ' MAN ' ' $$i; cp -f $$i $(DESTDIR)/$(MANDIR)/man1/$$i; \
	done

uninstall:
	@for i in $(PROGS); do \
		test -f $(DESTDIR)/$(BINDIR)/$$i && \
		echo ' ' UNINS ' ' $$i && \
		rm -f $(DESTDIR)/$(BINDIR)/$$i; \
	done || true
	@-rmdir $(DESTDIR)/$(BINDIR)/
	@for i in $(MAN1DOCS); do \
		test -f $(DESTDIR)/$(MANDIR)/man1/$$i && \
		echo ' ' UNMAN ' ' $$i && \
		rm -f $(DESTDIR)/$(MANDIR)/man1/$$i; \
	done || true
	@-rmdir $(DESTDIR)/$(MANDIR)/man1
