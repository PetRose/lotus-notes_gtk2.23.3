#!/bin/bash
# Amendment made by PetRose to support Notes 9.0.1 on Debian (in fact Linux Mint 32 bit).
# You should probably sudo in order to run his successfully
fixedfile="ibm-notes-9.0.1.i586-fixed.deb"
tempfile="ibm-notes-9.0.1.i586"
minimumcontrolfile="ibm-notes-9.0.1.minimum.i586_control"

if [ -f "$fixedfile" ] || [ -f "$tempfile" ];  then
	echo "You have already a workfiles in directory."
    echo "You have have to remove $fixedfile and $tempfile before running script."
	echo "Aborts script..."
	exit 1
fi

if [ -f "$minimumcontrolfile" > 0 ] ;  then
	echo "You do not have the needed minimum debian CONTROL file: $minimumcontrolfile"
    echo "Pls. download this and place in same directory before running script."
	echo "Aborts script..."
	exit 1
fi

# Now start the serious job...
dpkg-deb -R ibm-notes-9.0.1.i586.deb $tempfile
sudo cp ibm-notes-9.0.1.minimum.i586_control $tempfile/DEBIAN/control
dpkg-deb -b ibm-notes-9.0.1.i586 $fixedfile

# a litle prompt here, to allow curious dudes to look at the debian control file structure.
echo -n "Do you want me to remove the temporary debian folder for you ? (y/n)"
read answer

if [ "$answer" = "y" ]; then
	sudo rm -rf $tempfile
	echo "Temporary debian folder $tempfile removed."
else
	echo "Remember to delete the folder (after watching) the temporary debian folder:"
	echo "   $tempfile"
fi
echo "You should now be able to make a debian install using command:"
echo "   sudo dpkg -i $fixedfile"
exit 0
