
#source code location
ifndef P_MAIN
  P_MAIN = ../main
endif
ifndef P_LIBR
  P_LIBR = ../common
endif

# C Compiler include option
P_INCL = -I$(P_MAIN) -I$(P_LIBR)

ifndef INCHI_EXECUTABLE
  ifdef windir
    EXE = .exe
  else
    EXE =
  endif
  INCHI_EXECUTABLE = cInChI-1$(EXE)
endif

# === Linker to create Main program =====
ifndef LINKER
  LINKER = gcc -s
endif

# === C Compiler ===============
ifndef C_COMPILER
  C_COMPILER = gcc
endif

# === C Compiler Options =======
ifndef C_OPTIONS
  C_OPTIONS = $(P_INCL) -ansi -O3 -c
#  C_OPTIONS = $(P_INCL) -ansi -O1 -fsigned-char -ffunction-sections -fexpensive-optimizations -fstack-check -fexceptions -Wall -pedantic -Wbad-function-cast -Wreturn-type -Wformat -Wuninitialized -Wcast-align -Wshadow -Wunused -Wunused-value -Wunused-variable -Wunused-function -Wunused-parameter -Wunused-label -Wcomment -Wcast-qual -Wconversion -Wimplicit-function-dec -Wimplicit-int -Wmissing-braces -Wmissing-declarations -Wmissing-prototypes -Wredundant-decls -Wsign-compare -Wfloat-equal -Wstrict-prototypes -Wwrite-strings -Wundef -Waggregate-return -Wchar-subscripts -Wformat-nonliteral -Wnested-externs -Wsequence-point -Wpointer-arith -m32 -mfancy-math-387 -mieee-fp -mno-soft-float -c
endif


INCHI_SRCS = $(P_LIBR)/ichican2.c  $(P_LIBR)/ichiprt1.c \
             $(P_LIBR)/ichicano.c  $(P_LIBR)/ichiprt2.c \
             $(P_LIBR)/ichicans.c  $(P_LIBR)/ichiprt3.c \
             $(P_LIBR)/ichiisot.c  $(P_LIBR)/ichiqueu.c \
             $(P_LIBR)/ichiring.c \
             $(P_LIBR)/ichimak2.c  $(P_LIBR)/ichisort.c \
             $(P_LIBR)/ichimake.c  $(P_LIBR)/ichister.c \
             $(P_LIBR)/ichimap1.c  $(P_LIBR)/ichitaut.c \
             $(P_LIBR)/ichimap2.c  $(P_LIBR)/ichi_bns.c \
             $(P_LIBR)/runichi.c  \
             $(P_LIBR)/ichiread.c  $(P_LIBR)/ichirvr1.c \
             $(P_LIBR)/ichirvr2.c  $(P_LIBR)/ichirvr3.c \
             $(P_LIBR)/ichirvr4.c  $(P_LIBR)/ichirvr5.c \
             $(P_LIBR)/ichirvr6.c  $(P_LIBR)/ichirvr7.c \
             $(P_LIBR)/ichimap4.c  $(P_LIBR)/strutil.c  \
             $(P_LIBR)/ichinorm.c  $(P_LIBR)/util.c     \
             $(P_LIBR)/ichiparm.c \
             $(P_MAIN)/dispstru.c  $(P_MAIN)/mol2atom.c \
             $(P_MAIN)/readinch.c \
             $(P_MAIN)/ichimain.c  $(P_MAIN)/readmol.c  \

INCHI_OBJS = ichican2.o  ichiprt1.o \
             ichicano.o  ichiprt2.o \
             ichicans.o  ichiprt3.o \
             ichiisot.o  ichiqueu.o \
             ichiring.o \
             ichimak2.o  ichisort.o \
             ichimake.o  ichister.o \
             ichimap1.o  ichitaut.o \
             ichimap2.o  ichi_bns.o \
             runichi.o  \
             ichiread.o  ichirvr1.o \
             ichirvr2.o  ichirvr3.o \
             ichirvr4.o  ichirvr5.o \
             ichirvr6.o  ichirvr7.o \
             ichimap4.o  strutil.o  \
             ichinorm.o  util.o     \
             ichiparm.o \
             dispstru.o  mol2atom.o \
             readinch.o \
             ichimain.o  readmol.o  \



$(INCHI_EXECUTABLE) : $(INCHI_OBJS)
	$(LINKER) -o $(INCHI_EXECUTABLE)  $(INCHI_OBJS) -lm

%.o: $(P_LIBR)/%.c
	$(C_COMPILER) $(C_OPTIONS) $<

%.o: $(P_MAIN)/%.c
	$(C_COMPILER) $(C_OPTIONS) $<

