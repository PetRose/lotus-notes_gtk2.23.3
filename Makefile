
all: libnotesgtkfix.so

libnotesgtkfix.so: libnotesgtkfix.c
	gcc -Wall -Wextra -m32 `pkg-config --cflags gtk+-2.0` -shared libnotesgtkfix.c -o libnotesgtkfix.so -ldl

clean:
	rm -f libnotesgtkfix.so
