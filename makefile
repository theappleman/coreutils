DESTDIR =
PREFIX = $(HOME)
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man

CC = tcc
CFLAGS =

PROGS = \
	cat \
	echo \
	false \
	rm \
	seq \
	true \
	yes

MANDOCS = \
	cat.1 \
	echo.1 \
	seq.1

HTMLDOCS = \
	cat.html \
	echo.html \
	seq.html

##############################

all: $(PROGS)

# Programs
cat: license.h cat.c
	@echo ' ' CC ' ' cat; $(CC) $(CFLAGS) -o cat cat.c

echo: license.h echo.c
	@echo ' ' CC ' ' echo; $(CC) $(CFLAGS) -o echo echo.c

false: license.h false.c
	@echo ' ' CC ' ' false; $(CC) $(CFLAGS) -o false false.c

rm: license.h rm.c
	@echo ' ' CC ' ' rm; $(CC) $(CFLAGS) -o rm rm.c

seq: license.h seq.c
	@echo ' ' CC ' ' seq; $(CC) $(CFLAGS) -o seq seq.c

true: license.h true.c
	@echo ' ' CC ' ' true; $(CC) $(CFLAGS) -o true true.c

yes: license.h yes.c
	@echo ' ' CC ' ' yes; $(CC) $(CFLAGS) -o yes yes.c

# Documentation
doc: man html
html: $(HTMLDOCS)
man: $(MANDOCS)
	@echo ' ' FIX ' ' man; \
	sed -i -e '10s/ "\[FIXME: source\]" "\[FIXME: manual\]"//' ${MANDOCS}

cat.html: cat.txt
	@echo ' ' HTML ' ' cat; asciidoc cat.txt

cat.xml: cat.txt
	@echo ' ' XML ' ' cat; asciidoc -d manpage -b docbook cat.txt

cat.1: cat.xml
	@echo ' ' MAN ' ' cat; xmlto -m .manpage-normal.xsl man cat.xml

echo.html: echo.txt
	@echo ' ' HTML ' ' echo; asciidoc echo.txt

echo.xml: echo.txt
	@echo ' ' XML ' ' echo; asciidoc -d manpage -b docbook echo.txt

echo.1: echo.xml
	@echo ' ' MAN ' ' echo; xmlto -m .manpage-normal.xsl man echo.xml

seq.html: seq.txt
	@echo ' ' HTML ' ' seq; asciidoc seq.txt

seq.xml: seq.txt
	@echo ' ' XML ' ' seq; asciidoc -d manpage -b docbook seq.txt

seq.1: seq.xml
	@echo ' ' MAN ' ' seq; xmlto -m .manpage-normal.xsl man seq.xml

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
