override CFLAGS  += -Wall -Wextra `pkg-config --cflags gtk+-2.0` -shared -m32
override LDFLAGS += -ldl

all: libnotesgtkfix.so

libnotesgtkfix.so: libnotesgtkfix.c
	${CC} ${CFLAGS} -o $@ $< ${LDFLAGS}

fixdesktop85:
	sed -i -e '/Exec=/ s/notes /notes-wrapper /' /usr/share/applications/LotusNotes8.5.desktop

fixdesktop90:
	sed -i -e '/Exec=/ s/notes /notes-wrapper /' /usr/share/applications/IBMNotes9.0.desktop

install90: fixdesktop90
	install -m 755 notes-wrapper-9.0 /opt/ibm/notes/notes-wrapper

install: all fixdesktop85
	install -m 644 libnotesgtkfix.so /opt/ibm/lotus/notes
	install -m 755 notes-wrapper     /opt/ibm/lotus/notes/notes-wrapper

clean:
	rm -f libnotesgtkfix.so
