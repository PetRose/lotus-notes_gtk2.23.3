General instructions to get Lotus/IBM Notes to install
======================================================

Lotus/IBM Notes is generally only supported on LTS-version of Ubuntu, and
packagenames tend to chenge over releases typically deb-files will fail to
install because it need some specific package.

Cases are that the thing will work just fine, no matter what name the CUPS
printing system package is called.

So there are two script that can be used to fix dependencies in Lotus/IBM
Notes debian-packages.

   * fix-8.5.2-dependencies.sh to fix ibm-lotus-notes-8.5.2.i586.deb
   * fix-9.0.0-dependencies.sh to fix ibm-notes-9.0.i586.deb

Both scripts will unpack the package and created an additional one postfixes
with 'fixed'. Installed the fixed package and everything should be ready to
do the next steps depending on Notes-version.

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
