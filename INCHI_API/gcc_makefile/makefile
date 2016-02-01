# === Executable to build ===

ifndef INCHI_EXECUTABLE
  ifdef windir
    EXE = .exe
  else
    EXE =
  endif
  INCHI_EXECUTABLE = cInChI-1$(EXE)
endif

# === C Compiler ===============
ifndef C_COMPILER
  C_COMPILER = gcc
endif

# === C Compiler Options =======
ifndef C_OPTIONS
C_OPTIONS = -ansi -O3 -c
endif

# === Linker ===================
ifndef LINKER
  LINKER = gcc -s
endif

# === C Libraries ============
ifndef LINK_LIBS
  LINK_LIBS = -lm
endif

# === Source directories ======
ifndef P_MAIN
  P_MAIN = ../INCHI_MAIN/
endif
ifndef P_LIBR
  P_LIBR = ../INCHI_DLL/
endif

# === Source files ============

INCHI_SRCS = $(P_MAIN)e_ichimain_a.c    $(P_MAIN)e_ichimain.c   \
		$(P_MAIN)e_ichi_io.c    $(P_MAIN)e_ichi_parms.c \
		$(P_MAIN)e_inchi_atom.c $(P_MAIN)e_mol2atom.c   \
		$(P_MAIN)e_readinch.c   $(P_MAIN)e_readmol.c    \
		$(P_MAIN)e_readstru.c   $(P_MAIN)e_util.c       \
		$(P_MAIN)e_0dstereo.c          \
		$(P_LIBR)ichican2.c       $(P_LIBR)ichicano.c \
		$(P_LIBR)ichicans.c       $(P_LIBR)ichiisot.c \
		$(P_LIBR)ichilnct.c       $(P_LIBR)ichimak2.c \
		$(P_LIBR)ichimake.c       $(P_LIBR)ichimap1.c \
                 $(P_LIBR)ichimap2.c       $(P_LIBR)ichimap4.c \
                 $(P_LIBR)ichinorm.c       $(P_LIBR)ichiparm.c \
                 $(P_LIBR)ichiprt1.c       $(P_LIBR)ichiprt2.c \
                 $(P_LIBR)ichiprt3.c       $(P_LIBR)ichiqueu.c \
                 $(P_LIBR)ichiring.c       $(P_LIBR)ichisort.c \
                 $(P_LIBR)ichister.c       $(P_LIBR)ichitaut.c \
                 $(P_LIBR)ichi_bns.c       $(P_LIBR)inchi_dll.c \
                 $(P_LIBR)ichiread.c       $(P_LIBR)ichirvr1.c \
                 $(P_LIBR)ichirvr2.c       $(P_LIBR)ichirvr3.c \
                 $(P_LIBR)ichirvr4.c       $(P_LIBR)ichirvr5.c \
                 $(P_LIBR)ichirvr6.c       $(P_LIBR)ichirvr7.c \
                 $(P_LIBR)inchi_dll_main.c $(P_LIBR)runichi.c  \
                 $(P_LIBR)inchi_dll_a.c    $(P_LIBR)inchi_dll_a2.c  \
                 $(P_LIBR)ikey_dll.c       $(P_LIBR)ikey_base26.c  \
                 $(P_LIBR)sha2.c           $(P_LIBR)strutil.c  \
                 $(P_LIBR)util.c            


# === Object files ============

INCHI_OBJS = e_0dstereo.o      e_ichimain.o      \
             e_ichi_io.o       e_ichi_parms.o    \
             e_inchi_atom.o    e_mol2atom.o      \
             e_readinch.o      e_readmol.o       \
             e_readstru.o      e_util.o          \
             e_ichimain_a.o      \
             ichican2.o        ichicano.o        \
             ichicans.o        ichiisot.o        \
             ichilnct.o        ichimak2.o        \
             ichimake.o        ichimap1.o        \
             ichimap2.o        ichimap4.o        \
             ichiparm.o        ichinorm.o        \
             ichiprt1.o        ichiprt2.o        \
             ichiprt3.o        ichiqueu.o        \
             ichiring.o        ichisort.o        \
             ichister.o        ichitaut.o        \
             ichi_bns.o        inchi_dll.o       \
             ichiread.o        ichirvr1.o        \
             ichirvr2.o        ichirvr3.o        \
             ichirvr4.o        ichirvr5.o        \
             ichirvr6.o        ichirvr7.o        \
             inchi_dll_main.o  runichi.o         \
             strutil.o         util.o            \
             inchi_dll_a.o     inchi_dll_a2.o  \
             ikey_dll.o        ikey_base26.o  \
             sha2.o



# === Link rule ===============

$(INCHI_EXECUTABLE) : $(INCHI_OBJS)
	$(LINKER) -o $(INCHI_EXECUTABLE) $(INCHI_OBJS) $(LINK_LIBS)

# === Compile rules ===========

%.o: $(P_LIBR)%.c
	$(C_COMPILER) $(C_OPTIONS) $<

%.o: $(P_MAIN)%.c
	$(C_COMPILER) $(C_OPTIONS) $<
