CC=gcc
SRC=src/main.c
#CSRC=
CFLAGSX=-fprofile -arcs -ftest -coverage
LDLIBS= -lgov
#Create library
CFLAGS=-std=c99 -pedantic -Wextra -Wall -Werror -fPIC
CHECKDIR=check
COBJ=$(addprefix $(CHECKDIR)/, $(CSRC:.c=.o))
OBJS=$(addprefix $(OBJDIR)/, $(SRC:.c=.o))
OBJS=$(SRC:.c=.o)
LIBS=libstring.a
LIBD=libmalloc.so
EXE=exe

all: $(LIBD)

release:$(EXE)


$(OBJDIR):
	mkdir -p $@

$(OBJDIR)/%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $^

$(CHECKDIR)/%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $^

$(EXE): $(OBJS) $(COBJ)
	$(CC) $(CFLAGS) -o $(EXE) $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $^

$(LIBS):$(OBJS)
	ar csr -o $@ $^

static:$(OBJS)
	ar csr -o $@ $^

$(LIBD):$(OBJS) $(COBJ)
	$(CC) $(CFLAGS) -shared -o $@ $^

dynamique:$(OBJS)
	$(CC) $(CFLAGS) -shared -o $@ $^

exe:$(EXE)

debug: CFLAGS +=-g -ggdb3

debug:release

check:$(EXE)
	check/check.sh
#	$(CC) $(CFLAGSX) $(LDLIBS) -o $@ $^

clean:
	rm -f $(OBJS) $(COBJ)

distclean:
	rm -f $(OBJS) $(LIBS) $(LIBD) $(EXE)
