CFLAGS = -O3 -Wall $(shell gimptool-2.0 --cflags && pkg-config --cflags lensfun exiv2) -fopenmp 
LIBS = $(shell gimptool-2.0 --libs && pkg-config --libs lensfun exiv2)
PLUGIN = gimplensfun
SOURCES = src/gimplensfun.c
CC = g++
# LD = gcc-4.4
# END CONFIG ##################################################################

.PHONY: all install userinstall clean uninstall useruninstall

all: $(PLUGIN)

OBJECTS = $(subst .c,.o,$(SOURCES))

$(PLUGIN): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c -o $@ $*.c
	
install: $(PLUGIN)
	@gimptool-2.0 --install-admin-bin $^

userinstall: $(PLUGIN)
	@gimptool-2.0 --install-bin $^

uninstall:
	@gimptool-2.0 --uninstall-admin-bin $(PLUGIN)

useruninstall:
	@gimptool-2.0 --uninstall-bin $(PLUGIN)

clean:
	rm -f src/*.o $(PLUGIN)