#
# 'make depend' uses makedepend to automatically generate dependencies 
#               (dependencies are added to end of Makefile)
# 'make'        build executable file 'mycc'
# 'make clean'  removes all .o and executable files
#
TARGET=i386-pc-posnk

# define the C compiler to use
CC = @echo " [  CC  ]	" $< ; $(TARGET)-gcc
LD = @echo " [  LD  ]	" $@ ; $(TARGET)-gcc

# define the program name and path
PROGNAME=getty
PROGPATH=/sbin/getty

# define any compile-time flags
CFLAGS = -Wall -g

# define any directories containing header files other than /usr/include
#
INCLUDES = 

# define library paths in addition to /usr/lib
#   if I wanted to include libraries not in /usr/lib I'd specify
#   their path using -Lpath, something like:
LFLAGS = 

# define any libraries to link into executable:
#   if I want to link in libraries (libx.so or libx.a) I use the -llibname 
#   option, something like (this will link in libmylib.so and libm.so:
LIBS = 

# define the C source files
OBJS = $(BUILDDIR)getty.o \
$(BUILDDIR)issue.o \
$(BUILDDIR)tty.o 

# define the C object files 
#
# This uses Suffix Replacement within a macro:
#   $(name:string1=string2)
#         For each word in 'name' replace 'string1' with 'string2'
# Below we are replacing the suffix .c of all words in the macro SRCS
# with the .o suffix
#
all:	$(BUILDDIR)$(PROGNAME)

$(BUILDDIR)$(PROGNAME): $(OBJS)
	$(LD) $(LFLAGS) $(LIBS) -o $(BUILDDIR)$(PROGNAME) $(OBJS)

install: $(BUILDDIR)$(PROGNAME)
	install $(BUILDDIR)$(PROGNAME) $(DESTDIR)$(PROGPATH)

.PHONY: depend clean

# this is a suffix replacement rule for building .o's from .c's
# it uses automatic variables $<: the name of the prerequisite of
# the rule(a .c file) and $@: the name of the target of the rule (a .o file) 
# (see the gnu make manual section about automatic variables)
$(BUILDDIR)%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $<  -o $@

clean:
	$(RM) $(BUILDDIR)*.o $(BUILDDIR)*~ $(BUILDDIR)$(PROGNAME)

depend: $(SRCS)
	makedepend $(INCLUDES) $^

# DO NOT DELETE THIS LINE -- make depend needs it

