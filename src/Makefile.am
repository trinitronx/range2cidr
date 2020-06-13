#####################################################################
# range2cidr Makefile template
#
#
# Copyright © 2020  James Cuzella <james.cuzella@lyraphase.com>
#
# range2cidr is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# range2cidr is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see
# <http://www.gnu.org/licenses/>.
#
#####################################################################
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
