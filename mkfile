DESTDIR =
PREFIX = ${HOME}
BINDIR = ${PREFIX}/bin
MANDIR = ${PREFIX}/share/man

CC = tcc
CFLAGS =

PROGS = \
	cat \
	create \
	echo \
	false \
	rm \
	seq \
	sort \
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

all:QV: ${PROGS}

# Programs
%:Q: %.c
	echo ' ' CC ' ' $stem; ${CC} ${CFLAGS} -o $stem $stem.c

# Documentation
doc:QV: man html
html:QV: ${HTMLDOCS}
man:QV: ${MANDOCS}
	echo ' ' FIX ' ' man; \
	sed -i -e '10s/ "\[FIXME: source\]" "\[FIXME: manual\]"//' ${MANDOCS}

%.html:Q: %.txt
	echo ' ' HTML ' ' $stem; asciidoc $stem.txt

%.xml:Q: %.txt
	echo ' ' XML ' ' $stem; asciidoc -d manpage -b docbook $stem.txt

%.1:Q: %.xml
	echo ' ' MAN ' ' $stem; xmlto -m .manpage-normal.xsl man $stem.xml

# Housekeeping
clean:QV:
	for i in ${PROGS}; do \
		test -f $i && echo ' ' CLEAN ' ' $i && rm $i; \
	done || true
	for i in *.1 *.2 *.3 *.4 *.5 *.6 *.7 *.8; do \
		test -f $i && echo ' ' CLEAN ' ' $i && rm $i; \
	done || true
	for i in *.html; do \
		test -f $i && echo ' ' CLEAN ' ' $i && rm $i; \
	done || true
	for i in *.xml; do \
		test -f $i && echo ' ' CLEAN ' ' $i && rm $i; \
	done || true

# Installation
install:QV: all
	echo ' ' DIR ' ' ${DESTDIR}/${BINDIR}; mkdir ${DESTDIR}/${BINDIR}/
	for i in ${PROGS}; do \
		echo ' ' INSTALL ' ' $i; cp -f $i ${DESTDIR}/${BINDIR}/$i; \
	done

install-man:QV: man
	echo ' ' DIR ' ' ${DESTDIR}/${MANDIR}/man1; mkdir ${DESTDIR}/${MANDIR}/man1
	for i in ${MAN1DOCS}; do \
		echo ' ' MAN ' ' $i; cp -f $i ${DESTDIR}/${MANDIR}/man1/$i; \
	done

uninstall:QV:
	for i in ${PROGS}; do \
		test -f ${DESTDIR}/${BINDIR}/$i && \
		echo ' ' UNINS ' ' $i && \
		rm -f ${DESTDIR}/${BINDIR}/$i; \
	done || true
	rmdir ${DESTDIR}/${BINDIR}/ || true
	for i in ${MAN1DOCS}; do \
		test -f ${DESTDIR}/${MANDIR}/man1/$i && \
		echo ' ' UNMAN ' ' $i && \
		rm -f ${DESTDIR}/${MANDIR}/man1/$i; \
	done || true
	rmdir ${DESTDIR}/${MANDIR}/man1 || true
