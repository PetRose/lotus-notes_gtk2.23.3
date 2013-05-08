dpkg-deb -R ibm-lotus-notes-8.5.2.i586.deb ibm-lotus-notes-8.5.2.i586
cp ibm-lotus-notes-8.5.2.i586_control ibm-lotus-notes-8.5.2.i586/DEBIAN/control
dpkg-deb -b ibm-lotus-notes-8.5.2.i586 ibm-lotus-notes-8.5.2.i586-fixed.deb
