CC=gcc
CXX=g++
RM=rm -f
CPPFLAGS=-g $(shell root-config --cflags)
LDFLAGS=-g $(shell root-config --ldflags)
LDLIBS=$(shell root-config --libs)

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
