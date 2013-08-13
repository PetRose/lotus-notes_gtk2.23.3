dpkg-deb -R ibm-notes-9.0.i586.deb ibm-notes-9.0.i586
cp ibm-notes-9.0.i586_control ibm-notes-9.0.i586/DEBIAN/control
dpkg-deb -b ibm-notes-9.0.i586 ibm-notes-9.0.i586-fixed.deb
rm -rf ibm-notes-9.0.i586
