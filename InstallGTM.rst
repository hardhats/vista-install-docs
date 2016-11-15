Download and Install GT.M
=========================

The instructions are taken from the `GT.M Acculturation Workshop 
<https://sourceforge.net/projects/fis-gtm/files/GT.M%20Acculturation%20Workshop/>`_. 
They have been only slightly modified.

Using the Package Manager
-------------------------

If you are using Ubuntu Linux 14.04 LTS or later; or Debian Jessie, Testing, or 
Unstable; or other Linux distributions that may already have GT.M packages 
accessed using their normal package managers, you may be able to install GT.M 
using the package manager, e.g., apt-get install fis-gtm. However, as this 
workshop is intended to teach GT.M Administration and Operations, we will not 
use this approach here.

Using the Installation Script
----------------

The installation script, gminstall, is downloads and installs the current GT.M 
release. From http://sourceforge.net/projects/fis-gtm/files/GT.M%20Installer, 
download the latest version of the GT.M installer (currently version 0.13) into 
a temporary directory, either using a browser, or a program such as wget, and 
execute it.

Depending on your network configuration the wget command may need environment 
variables to be set to go through proxy servers, and the sudo command may 
require the -E option to pass your shell environment to root process invoked by 
the sudo.

  | ~$ **mkdir /tmp/tmp**
  | ~$ **cd /tmp/tmp**
  | /tmp/tmp$ **wget http://sourceforge.net/projects/fis-gtm/files/GT.M%20Installer/v0.13/gtminstall**
  | 
  | ...
  | 
  | /tmp/tmp$ **chmod +x gtminstall**
  | /tmp/tmp$ **sudo ./gtminstall --utf8 default**
  | [sudo] password for gtmuser: 
  | /tmp/tmp$ **ls -l /usr/lib/fis-gtm**
  | total 12
  | dr-xr-xr-x 5 root root 8192 Nov 13 10:57 V6.2-000_x86_64
  | /tmp/tmp$ **cd**
  | ~$ 


Traditional Technique
---------------------

First download GT.M for 64-bit GNU/Linux on the x86_64 platform from Source 
Forge. These instructions are based on V6.2-000; you can use it or any more 
recent GT.M release. Download it to a temporary directory, e.g., /tmp, with the 
wget program:

  | $ **wget -P /tmp http://sourceforge.net/projects/fis-gtm/files/GT.M-amd64-Linux/V6.2-000/gtm_V62000_linux_x8664_pro.tar.gz**

Then create a temporary directory and unpack the contents of the tarball into 
it. If you installed GT.M using the gtminstall technique, you should already 
have a /tmp/tmp directory.

  | ~$ **mkdir /tmp/tmp**
  | ~$ **cd /tmp/tmp**
  | /tmp/tmp$ **tar zxf ../gtm_V62000_linux_x8664_pro.tar.gz**
  | /tmp/tmp$ 

Then install GT.M in /usr/local/lib/fis-gtm/V6.2-000_x86_64 – since the 
gtminstall script would have already installed a GT.M in /usr/lib/fis-gtm/V6.2-000_x86_64. 
Note that this must be done as root.

  | /tmp/tmp$ **sudo ./configure**
  | [sudo] password for gtmuser: 
  | 
  | GT.M Configuration Script
  | Copyright 2009, 2014 Fidelity Information Services, Inc. Use of this
  | software is restricted by the provisions of your license agreement.
  | 
  | What user account should own the files? (bin) **root**
  | What group should own the files? (bin) **root**
  | Should execution of GT.M be restricted to this group? (y or n) **n**
  | In what directory should GT.M be installed? **/usr/local/lib/fis-gtm/V6.2-000_x86_64**
  | 
  | Directory /usr/local/lib/fis-gtm/V6.2-000_x86_64 does not exist. Do you wish to create it as part of
  | this installation? (y or n) **y**
  | 
  | Installing GT.M....
  | 
  | Should UTF-8 support be installed? (y or n) **y**
  | Should an ICU version other than the default be used? (y or n) **n**
  | 
  | All of the GT.M MUMPS routines are distributed with uppercase names.
  | You can create lowercase copies of these routines if you wish, but
  | to avoid problems with compatibility in the future, consider keeping
  | only the uppercase versions of the files.
  | 
  | Do you want uppercase and lowercase versions of the MUMPS routines? (y or n) **y**
  | 
  | Creating lowercase versions of the MUMPS routines.
  | ./CHK2LEV.m --->  ./chk2lev.m
  | ./CHKOP.m --->  ./chkop.m
  | ./GENDASH.m --->  ./gendash.m
  | 
  | ...
  | 
  | ./_UCASE.m --->  ./_ucase.m
  | ./_UTF2HEX.m --->  ./_utf2hex.m
  | ./_XCMD.m --->  ./_xcmd.m
  | 
  | Compiling all of the MUMPS routines. This may take a moment.
  | 
  | 
  | Object files of M routines placed in shared library /usr/local/lib/fis-gtm/V6.2-000_x86_64/libgtmutil.so
  | Keep original .o object files (y or n)? **n**
  | 
  | 
  | Installation completed. Would you like all the temporary files
  | removed from this directory? (y or n) **y**
  | /tmp/tmp$ cd
  | /tmp/tmp$

GT.M is now installed and operational.
