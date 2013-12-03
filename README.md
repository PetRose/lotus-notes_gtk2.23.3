General instructions to get Lotus/IBM Notes to install
======================================================

Lotus/IBM Notes is generally only supported on LTS-version of Ubuntu, and
since packagenames tends to change over releases typically deb-files
like this will typically fail to because of their specific package requirements.

Cases are that the thing will work just fine, no matter what name the CUPS
printing system package is called.

So there are three scripts that can be used to fix dependencies in Lotus/IBM
Notes debian-packages.

   * fix-9.0.1-dependencies.sh to fix ibm-notes-9.0.1.i586.deb
   * fix-9.0.0-dependencies.sh to fix ibm-notes-9.0.i586.deb
   * fix-8.5.2-dependencies.sh to fix ibm-lotus-notes-8.5.2.i586.deb

All scripts will unpack the package and created an additional one postfixed
with 'fixed'. Install the fixed package and everything should be ready to
for performing the next setup steps.


For IBM Notes 9.0.1
===================

IBM Notes has some dependencies set in the Debian CONTROL file, that are either
- to old by referencing back-level packages
- referencing not so usual xwindows libraries 
So please do this carefully on a system that you can undo changes to.

The unsetting the GTK2_RC_FILES environment variable, done by the wrapper 
for Notes 9.0, is no longer needed (at least in my case).

Pre-Requisites
--------------
Ensure the following packages, or newer are on your system, and if not install them:

	sudo apt-get install ia32-libs

	sudo apt-get install libgnomeprintui2.2-0 ttf-xfree86-nonfree t1-xfree86-nonfree
but also these:
	libgnomeprintui2.2-0 libgnomeprint2.2-0 libgnomevfs2-0 libgnomeui-0
	libxkbfile1 libstartup-notification0 libsepol1 libselinux1 libgsf-1-114 libgsf-1-dev
	librsvg2-2 librsvg2-common libavahi-client3 libavahi-common3 libavahi-glib1
	libbonoboui2-0 libcroco3 libdbus-1-3 libdbus-glib-1-2
	libgnome2-0 libgnomecanvas2-0 libgnome-keyring0 libgnome-menu2 libesd0
	gtk2-engines libgnome-desktop-2-17 libmotif4 libavahi-glib1 gtk2-engines-oxygen
	gtk2-engines-qtcurve gtk2-engines-murrine gtk2-engines-equinox alsa-base alsa-utils
	iproute libgnome-desktop-3-2 liborbit2 libbonobo2-0 libgconf2-4 libx11-6 libxt6 libc6
	libgcc1 libgtk2.0-0 libxkbfile1 libglib2.0-0 libstdc++6 bash libart-2.0-2 libpopt0
	libgnomeui-0 libmotif3 libgnome-desktop-3-0 gtk2-engines-aurora libxext6
	libgnome2-common gnome-keyring
(according to : http://rayslinux.blogspot.dk/2013/11/creating-mint-15-workstation-server.html)

Then copy the 'minimum' debian CONTROL file here
	ibm-notes-9.0.1.minimum.i586_control
into same folder where you should run the fix script. 


Installation
------------

Just run the fix script, and you don't need to run the make, like the other Notes variants.
	./fix-9.0.1-dependencies.sh

It should end succesfully by creating a new packaged deb file:
	ibm-notes-9.0.1.i586-fixed.deb

Post-Installation
-----------------
The Installation step ends by telling you which dpkg command you can use to install.
This should be this:
	sudo dpkg -i ibm-notes-9.0.1.i586-fixed.deb
Once done, you should now see 'IBM Notes' as application within the Office section
of LMDE Desktop.
Once you click this, it should display the Notes splash screen and then - first time only - bring a little xterm window in front where you should Accept the licence, Read the licence or Abort. If you Accept, you will a few moments later see the Notes Setup window where
you typically want to connect to an existing Domino server using your ID-file.
And the rest is the same as for any other IBM Notes distribution.

Enjoy !


For IBM Notes 9.0
=================

IBM Notes have works out of the box, except that weird things happen in
relation to the oxygen-gtk theme that are use primarily on KDE. Notes will
crash after sending email and many other places too. Selecting another theme
avoid the crash - but do you realy whant to look at firefox in Raleigh?

Luckily this can be fixed by unsetting the GTK2_RC_FILES environment variable
before starting Notes.

Installation
------------

Just run 'make install90' to install the wrapper that reset the environment
variable.


For Lotus Notes 8.5.x
=====================

Recent versions of Ubuntu and most likely all other distributions package
GTK 2.23.3 ir higher. That version contains an optimization that somehow
breaks Lotus Notes making it unable to draw things correctly on the screen.
Things tend to get drawn as gray areas instead of real content. This
software works around that problem.

Prerequisites
-------------
On Ubuntu the required libraries can be installed by running the following
command.

   $ sudo apt-get install libgtk2.0-dev

On 64bit Ubuntu g++-multilib also needs to be installed.

   $ sudo apt-get install g++-multilib


Installation
------------
Run 'make' to build the library. Remember to have all the required libraries
installed. Then run 'sudo make install85' to install the files and modify the
desktop-file. You can now run Lotus Notes from application-menu on your desktop.


Manual installation
-------------------
To install copy the files 'notes-wrapper' and 'libnotesgtkfix.so' to the
location of the 'notes' binary. For me it is in /opt/ibm/lotus/notes, but
for you it might be different.

Now fire up Lotus Notes with the 'notes-wrapper'-script instead of 'notes'.

With the current version of Lotus Notes (8.5.2) on linux the systemwide
desktop-files is at /usr/share/applications/LotusNotes8.5.desktop. Editing that
files changing the shortcut there, will make notes run for all local users.
