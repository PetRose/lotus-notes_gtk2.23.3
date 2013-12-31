#!/bin/bash
debfile="$1.deb"
fixedfile="$1-fixed.deb"
tempfile="$1"
minimumcontrolfile="$1_control"

if [ -f "$fixedfile" ] || [ -f "$tempfile" ];  then
	echo "You have already a workfiles in directory."
    echo "You have to remove $fixedfile and $tempfile before running script."
	echo "Aborts script..."
	exit 1
fi

if [ ! -f "$debfile" ] ;  then
	echo "You do not have the file $debfile in the current directory"
	echo "Pls. copy it to the current directory and run the script again."
	echo "Aborts script..."
	exit 1
fi

if [ ! -f "$minimumcontrolfile" ] ;  then
	echo "You do not have the needed minimum debian CONTROL file: $minimumcontrolfile"
	echo "Pls. download this and place in same directory before running script."
	echo "Aborts script..."
	exit 1
fi

# Now start the serious job...
dpkg-deb -R $debfile $tempfile
cp $minimumcontrolfile $tempfile/DEBIAN/control
dpkg-deb -b $tempfile $fixedfile

# a litle prompt here, to allow curious dudes to look at the debian control file structure.
echo -n "Do you want me to remove the temporary debian folder for you ? (y/n)"
read answer

if [ "$answer" = "y" ]; then
	rm -rf $tempfile
	echo "Temporary debian directory $tempfile removed."
else
	echo "Remember to manually delete temporary directory $tempfile after successful completion."
fi
echo "You will now be able to install on a debian based system using command:"
echo "   sudo dpkg -i $fixedfile"
exit 0
