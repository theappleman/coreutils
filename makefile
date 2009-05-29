DESTDIR =
PREFIX = $(HOME)
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man

CC = tcc
CFLAGS =

PROGS = am \
	echo \
	false \
	rm \
	seq \
	true \
	yes

MANDOCS= echo.1 \
	seq.1
HTMLDOCS = echo.html \
	seq.html

##############################

all: $(PROGS)

# Programs
am: license.h am.c
	@echo ' ' CC ' ' am; $(CC) $(CFLAGS) -o am am.c

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
doc: $(MANDOCS) $(HTMLDOCS)
man: $(MANDOCS)

seq.html: seq.txt
	@echo ' ' HTML ' ' seq; asciidoc seq.txt

seq.xml: seq.txt
	@echo ' ' XML ' ' seq; asciidoc -d manpage -b docbook seq.txt

seq.1: seq.xml
	@echo ' ' MAN ' ' seq; xmlto -m .manpage-normal.xsl man seq.xml

echo.html: echo.txt
	@echo ' ' HTML ' ' echo; asciidoc echo.txt

echo.xml: echo.txt
	@echo ' ' XML ' ' echo; asciidoc -d manpage -b docbook echo.txt

echo.1: echo.xml
	@echo ' ' MAN ' ' echo; xmlto -m .manpage-normal.xsl man echo.xml

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
		echo ' ' UNINS ' ' $$i; \
		rm -f $(DESTDIR)/$(PREFIX)/$$i; \
	done
	@-rmdir $(DESTDIR)/$(PREFIX)/
	@for i in $(MAN1DOCS); do \
		echo ' ' UNMAN ' ' $$i; \
		rm -f $(DESTDIR)/$(MANDIR)/man1/$$i; \
	done
	@-rmdir $(DESTDIR)/$(MANDIR)/man1
