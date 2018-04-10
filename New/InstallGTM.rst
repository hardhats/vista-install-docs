Install GT.M or YottaDB
=======================

Authors: KS Bhaskar, Sam Habiel

License: GNU Free Documentation License, Version 1.3 or any later (http://www.gnu.org/licenses/fdl.txt).
 
These instructions are a slightly modified version from the `GT.M Acculturation Workshop <https://sourceforge.net/projects/fis-gtm/files/GT.M%20Acculturation%20Workshop/>`_.

Quick Introduction
------------------
There are more ways to install GT.M than there are for YottaDB, since YottaDB is a fork of GT.M. Either one can be used for VistA implementation.

Using the Installation Script (YottaDB)
---------------------------------------
Follow the instructions at https://yottadb.com/product/get-started/. Note the location where YottaDB was installed, presented after the last step. As an example, mine said: 

::

    YottaDB version r1.10 installed successfully at /usr/local/lib/yottadb/r110

This location will be entered for the variable $gtm_dist in the next section.

Using the Package Manager (GT.M)
--------------------------------

If you are using Ubuntu Linux 14.04 LTS or later; Debian Jessie, Testing, or Unstable; or other Linux distributions that may already have GT.M packages accessed using their normal package managers, you may be able to install GT.M using the package manager, e.g., as root/via sudo, ``apt install fis-gtm``.

Using the Installation Script (GT.M)
------------------------------------

Download the installation script, gtminstall, to install the current GT.M release. Download and execute the latest version of the GT.M installer (currently version 0.13) from http://sourceforge.net/projects/fis-gtm/files/GT.M%20Installer into a temporary directory, using either a browser or a program such as wget.

Note: depending on your network configuration, the wget command may need environment variables to be set to go through proxy servers, and the sudo command may require the -E option to pass your shell environment to the root process invoked by the sudo.

.. raw:: html
    
    <div class="code"><code>$ <strong>mkdir /tmp/tmp</strong>
    $ <strong>cd /tmp/tmp</strong>
    /tmp/tmp$ <strong>wget http://sourceforge.net/projects/fis-gtm/files/GT.M%20Installer/v0.13/gtminstall</strong>
    
    ...
    
    /tmp/tmp$ <strong>chmod +x gtminstall</strong>
    /tmp/tmp$ <strong>sudo ./gtminstall --utf8 default</strong>
    [sudo] password for gtmuser: 
    /tmp/tmp$ <strong>ls -l /usr/lib/fis-gtm</strong>
    total 12
    dr-xr-xr-x 5 root root 8192 Nov 13 10:57 V6.2-000_x86_64
    /tmp/tmp$ <strong>cd</strong>
    $</code></div>


Traditional Technique (GT.M)
----------------------------
These instructions are based on V6.2-000; you can use it or any more recent GT.M release. Download GT.M for 64-bit GNU/Linux on the x86_64 platform from SourceForge to a temporary directory, e.g., /tmp, with the wget program:

.. raw:: html
    
    <div class="code"><code>$ <strong>wget -P /tmp http://sourceforge.net/projects/fis-gtm/files/GT.M-amd64-Linux/V6.2-000/gtm_V62000_linux_x8664_pro.tar.gz</strong></code></div>


Then create another temporary directory and unpack the contents of the tarball into it. If you installed GT.M using the gtminstall technique, you should already have a /tmp/tmp directory.

.. raw:: html
    
    <div class="code"><code>$ <strong>mkdir /tmp/tmp</strong>
    $ <strong>cd /tmp/tmp</strong>
    /tmp/tmp$ <strong>tar zxf ../gtm_V62000_linux_x8664_pro.tar.gz</strong>
    /tmp/tmp$</code></div> 


Finally, install GT.M in /usr/lib/fis-gtm/V6.2-000_x86_64. Note this MUST be done as root.

.. raw:: html
    
    <div class="code"><code>/tmp/tmp$ <strong>sudo ./configure</strong>
    [sudo] password for gtmuser: 
    
    GT.M Configuration Script
    Copyright 2009, 2014 Fidelity Information Services, Inc. Use of this
    software is restricted by the provisions of your license agreement.
    
    What user account should own the files? (bin) <strong>root</strong>
    What group should own the files? (bin) <strong>root</strong>
    Should execution of GT.M be restricted to this group? (y or n) <strong>n</strong>
    In what directory should GT.M be installed? <strong>/usr/lib/fis-gtm/V6.2-000_x86_64</strong>
    
    Directory /usr/local/lib/fis-gtm/V6.2-000_x86_64 does not exist. Do you wish to create it as part of
    this installation? (y or n) <strong>y</strong>
    
    Installing GT.M....
    
    Should UTF-8 support be installed? (y or n) <strong>y</strong>
    Should an ICU version other than the default be used? (y or n) <strong>n</strong>
    
    All of the GT.M MUMPS routines are distributed with uppercase names.
    You can create lowercase copies of these routines if you wish, but
    to avoid problems with compatibility in the future, consider keeping
    only the uppercase versions of the files.
    
    Do you want uppercase and lowercase versions of the MUMPS routines? (y or n) <strong>y</strong>
    
    Creating lowercase versions of the MUMPS routines.
    ./CHK2LEV.m --->  ./chk2lev.m
    ./CHKOP.m --->  ./chkop.m
    ./GENDASH.m --->  ./gendash.m
    
    ...
    
    ./_UCASE.m --->  ./_ucase.m
    ./_UTF2HEX.m --->  ./_utf2hex.m
    ./_XCMD.m --->  ./_xcmd.m
    
    Compiling all of the MUMPS routines. This may take a moment.
    
    
    Object files of M routines placed in shared library /usr/local/lib/fis-gtm/V6.2-000_x86_64/libgtmutil.so
    Keep original .o object files (y or n)? <strong>n</strong>
    
    
    Installation completed. Would you like all the temporary files
    removed from this directory? (y or n) <strong>y</strong>
    /tmp/tmp$ cd
    /tmp/tmp$</code></div>


GT.M is now installed and operational and you are ready to continue to `Install VistA on GT.M/YottaDB <./InstallVistAOnGTM.html>`_.
