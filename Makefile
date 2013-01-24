override CFLAGS  += -Wall -Wextra `pkg-config --cflags gtk+-2.0` -shared -m32
override LDFLAGS += -ldl

all: libnotesgtkfix.so

libnotesgtkfix.so: libnotesgtkfix.c
	${CC} ${CFLAGS} -o $@ $< ${LDFLAGS}

install: all
	install -m 644 libnotesgtkfix.so /opt/ibm/lotus/notes
	install -m 755 notes-wrapper     /opt/ibm/lotus/notes
	sed -i -e '/Exec=/ s/notes /notes-wrapper /' /usr/share/applications/LotusNotes8.5.desktop

clean:
	rm -f libnotesgtkfix.so
