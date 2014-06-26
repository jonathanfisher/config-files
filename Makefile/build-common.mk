# This file is intended to be used with a main Makefile for projects.  This
# shouldn't define any rules or do anything that would affect the build process.

# Account for the cross-compile command-line directive.
CXX     = $(CROSS_COMPILE)g++
CC      = $(CROSS_COMPILE)gcc
AS      = $(CROSS_COMPILE)as
AR      = $(CROSS_COMPILE)ar
NM      = $(CROSS_COMPILE)nm
LD      = $(CROSS_COMPILE)ld
OBJDUMP = $(CROSS_COMPILE)objdump
OBJCOPY = $(CROSS_COMPILE)objcopy
RANLIB  = $(CROSS_COMPILE)ranlib
STRIP   = $(CROSS_COMPILE)strip

# For some reason, the copy command doesn't seem to exist by default.
CP := cp

# Generate dependencies by default.
CFLAGS += -MMD

