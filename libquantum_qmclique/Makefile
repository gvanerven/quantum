# Makefile: Build simClique
# 
# Copyright 2016 Gustavo C. Galvão van Erven
#
# simClique is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published
# by the Free Software Foundation; either version 3 of the License,
# or (at your option) any later version.
#
# simClique is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with simClique; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA

# Every Makefile should contain this line

SHELL=/bin/sh

# Target directory prefix

PREFIX=$(DESTDIR)/usr/local
EPREFIX=$(PREFIX)

# Other directories

LIBDIR=$(EPREFIX)/lib
INCLUDEDIR=$(PREFIX)/include
BINDIR=$(PREFIX)/bin
top_builddir=.
ALLDIRS=$(LIBDIR) $(INCLUDEDIR) $(BINDIR)

# Version information

VERSION=1.1.1

# Tools needed to build libquantum

CC=gcc
INSTALL=/usr/bin/install -c
#LIBTOOL=$(SHELL) $(top_builddir)/libtool
LIBTOOL=/usr/bin/libtool

# Flags passed to C compiler

CFLAGS=-g -O2 -Wall -fopenmp
LDFLAGS=-rpath $(LIBDIR) -version-info 8:0:0

# Dependencies

all:  simClique	

# Build demos of Shor's and Grover's algorithms

simClique: simClique.c Makefile
	$(LIBTOOL) --mode=link $(CC) $(CFLAGS) -o simClique simClique.c -I./ -lquantum \
	-static	-lm

clean:
	-rm -rf .libs
	-rm simClique *.lo *.o

