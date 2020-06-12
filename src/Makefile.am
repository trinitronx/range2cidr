#SRCS=range2cidr.cpp
#OBJS=$(subst .cpp,.o,$(SRCS))
#CLEANFILES=$(OBJS)

bin_PROGRAMS = range2cidr
range2cidr_PROGRAM  = range2cidr

noinst_HEADERS      = verbose.h global.h
range2cidr_SOURCES  = range2cidr.cpp verbose.cpp
range2cidr_CXXFLAGS = $(WARN_CXXFLAGS)
range2cidr_LDFLAGS  = $(WARN_LDFLAGS)

#all: range2cidr

#range2cidr: $(OBJS)
#	$(CXX) $(LDFLAGS) -o $@ $(OBJS) $(LDLIBS)

#tool.o: tool.cc support.hh

#clean:
#	$(RM) $(OBJS)

#distclean: clean
#	$(RM) range2cidr

#.PHONY: all install clean distclean uninstall
