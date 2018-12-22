Updating A VistA System
=======================
Authors: Sam Habiel

License: |license|

.. |license| image:: https://i.creativecommons.org/l/by/4.0/80x15.png 
   :target: http://creativecommons.org/licenses/by/4.0/ 

Last updated in December 2018.

  While none of the previous sections are required for completing this section,
  you need to set-up the ``OPEN PARAMETERS`` of the HFS device entry as KIDS
  won't work without it. Look in `VistA Initialization
  <./InitializeVistA.html#hfs-device>`_ HFS Device section.

Introduction
------------
A VistA system, like a new car, is old by the time you drive it. One of the big
challenges for new users for VistA is understanding the large amount of on-going
updates, and then falling behind the updates. There is no automated system to
apply updates (there were many attempts; contact me if you are interested); so
it takes some discipline to keep up on the VistA updates. I do acknowledge that
the situation needs to be improved. The system that is used to update VistA is
the Kernel Installation Distribution System (KIDS). KIDS consists of files or
mail messages (rare for people outside of the VA) that you load into a VistA
system.

Quick TL;DR
-----------
TL;DR = Internet Slang for Too Long; Didn't Read

If you just want to know how to install a KIDS build, here are the steps:

Outside of VistA:

1. Download the KIDS build file.
2. If running on GT.M/YottaDB, ``dos2unix`` the file.
3. Note the path to the file. On Linux & Cygwin, you can get the path using ``readlink -f {filename}``.

Inside of VistA:

Prerequisite: ``XUPROG`` security key.

1. Log in to EVE
2. Programmer Options
3. KIDS
4. Installation
5. Load a Distribution (loads the KIDS build). Supply the path.
6. Install Package(s) (installs the KIDS build). Supply default answers.

An even shorter way to install a KIDS build is to run ``D ^XPDIL,^XPDI`` from
direct mode (aka programmer mode). This runs steps 5 and 6.

.. raw:: html

  <div class="code"><code>
          Core Applications ...
          Device Management ...
          Menu Management ...
          Programmer Options ...
          Operations Management ...
          Spool Management ...
          Information Security Officer Menu ...
          Taskman Management ...
          User Management ...
          Application Utilities ...
          Capacity Planning ...
          HL7 Main Menu ...

  Systems Manager Menu 옵션 선택: <strong>Prog</strong>rammer Options


   KIDS   Kernel Installation & Distribution System ...
   PG     Programmer mode
          Delete Unreferenced Options
          Error Processing ...
          Global Block Count
          Routine Tools ...

  Programmer Options 옵션 선택: <strong>KIDS</strong>  Kernel Installation & Distribution System


          Edits and Distribution ...
          Utilities ...
          Installation ...
          Patch Monitor Main Menu ...

  Kernel Installation & Distribution System 옵션 선택: <strong>I</strong>nstallation


   1      Load a Distribution
   2      Verify Checksums in Transport Global
   3      Print Transport Global
   4      Compare Transport Global to Current System
   5      Backup a Transport Global
   6      Install Package(s)
          Restart Install of Package(s)
          Unload a Distribution

  Installation 옵션 선택: <strong>1</strong> Load a Distribution

  Enter a Host File: <strong>/tmp/GMRV-5_SEQ-29_PAT-37.kids</strong>

  Released GMRV*5*37 SEQ #29
  Comment: Extracted from mail message

  This Distribution contains Transport Globals for the following Package(s):
     GMRV*5.0*37
  Distribution OK!

  Want to Continue with Load? 예// <strong>y</strong>  예
  Loading Distribution...

     GMRV*5.0*37
  Use INSTALL NAME: GMRV*5.0*37 to install this Distribution.



     1      Load a Distribution
     2      Verify Checksums in Transport Global
     3      Print Transport Global
     4      Compare Transport Global to Current System
     5      Backup a Transport Global
     6      Install Package(s)
            Restart Install of Package(s)
            Unload a Distribution

  <TEST ACCOUNT> Installation 옵션 선택: <strong>6</strong>  Install Package(s)
  Select INSTALL NAME: <strong>GMRV*5.0*37</strong>       Loaded from Distribution    2018-12-22@12
  :02:02
       => Extracted from mail message  ;Created on

  This Distribution was loaded on 2018-12-22@12:02:02 with header of
     Extracted from mail message  ;Created on
     It consisted of the following Install(s):
      GMRV*5.0*37
  Checking Install for Package GMRV*5.0*37

  Install Questions for GMRV*5.0*37



  Want KIDS to INHIBIT LOGONs during the install? 아니오// <strong>&lt;enter&gt;</strong>
  Want to DISABLE Scheduled Options, Menu Options, and Protocols? 아니오//<strong>&lt;enter&gt;</strong>

  Enter the Device you want to print the Install messages.
  You can queue the install by enter a 'Q' at the device prompt.
  Enter a '^' to abort the install.

  DEVICE: HOME// <strong>;p-other;</strong>  CONSOLE


   Install Started for GMRV*5.0*37 :
                 2018-12-22@12:02:36

  Build Distribution Date: 2018-01-10

   Installing Routines:..
                 2018-12-22@12:02:36

   Running Post-Install Routine: EN^GMV37PST.

  Updating system parameters.

   Updating Routine file......

   Updating KIDS files.......

   GMRV*5.0*37 Installed.
                 2018-12-22@12:02:36

   Not a VA primary domain

   NO Install Message sent


     1      Load a Distribution
     2      Verify Checksums in Transport Global
     3      Print Transport Global
     4      Compare Transport Global to Current System
     5      Backup a Transport Global
     6      Install Package(s)
            Restart Install of Package(s)
            Unload a Distribution

   Installation 옵션 선택:</code></div>
