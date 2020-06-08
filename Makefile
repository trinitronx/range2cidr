CC=gcc
CXX=g++
RM=rm -f
CPPFLAGS=-g $(shell dpkg-buildflags --get CPPFLAGS)
LDFLAGS=-g $(shell dpkg-buildflags --get LDFLAGS)
#LDLIBS=$(shell root-config --libs)

SRCS=range2cidr.cpp
OBJS=$(subst .cpp,.o,$(SRCS))

all: range2cidr

range2cidr: $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $(OBJS) $(LDLIBS)

#tool.o: tool.cc support.hh

clean:
	$(RM) $(OBJS)

distclean: clean
	$(RM) range2cidr

.PHONY: all install clean distclean uninstall
