VistA Initialization
====================

If you have reached this point, it means that you have finished `Install Cache
<./InstallCache.html>`_; or `Install GT.M <./InstallGTM.html>`_ and `Install VistA on GT.M
<./InstallVistAOnGTM.html>`_.

Getting into the Direct Mode (aka) Programmer Mode
--------------------------------------------------
Before there were `REPLs <https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop>`_,
Mumps always has had something called Direct Mode, which is a simplified REPL. It's also
known as Programmer Mode. Normally, end users are not allowed to access Programmer Mode, as
it is essentially like running as root on a Unix System.

To connect to VISTA and start configuring it, you need a terminal emulator. Make sure that
your terminal emulator emulates VT-100, VT-220, VT-320 or VT-52. By default, most terminal emulators
do that already. You specifically cannot use the rxvt terminal emulator though.

If you modified your $TERM, you need to make sure it's either ``xterm`` or ``ansi``. Others generally
will work, but I am sure of these two.

To get into Direct Mode using Cache, on Windows you need to right click on the Cache Cube and
choose Terminal. If you have a licnesed version of Cache, you can also use Telnet to connect
to the Terminal. Please note that while you can use Windows Telnet, it does not emulate VT-200
series terminals properly, so you may have some issues. If you want to use Telnet, I recommend downloading
PuTTY or TeraTerm. 

PuTTY: http://www.chiark.greenend.org.uk/~sgtatham/putty/.

TeraTerm: https://ttssh2.osdn.jp/index.html.en.

If you use PuTTY, change the function key bindings so that they behave like
VT-100+. See here: https://the.earth.li/~sgtatham/putty/0.58/htmldoc/Chapter4.html#config-funkeys.

On a Mac, Terminal is a fully featured terminal emulator. You may wish to tell it via System Preferences that you want your function keys to send Function commands, rather than dimming your screen or muting your volume. Otherwise, you have to use FN all the time to override the function keys (https://support.apple.com/en-us/HT204436).

On Linux, you can use any Terminal Emulator program, with the exception of rxvt. You can actually even use PuTTY on Linux.
F1 may be bound to do help. You need to unmap that in the Terminal application. 
(http://askubuntu.com/questions/37313/how-do-i-deactivate-f1-and-f10-keybindings-in-gnome-terminal).

After you open your terminal emulator, do the following:

On Cache on Linux or Mac, you need to run ``ccontrol list`` to find your instance name, and then
run ``csession <instance name>``.

On GT.M, you need to source your environement file (if you followed this guide, it should be in
/var/db/<name> as env.vista). To source, type ``. /var/db/<name>/env.vista``. The dot is all
by itself. Then type ``mumps -dir`` to go into direct mode.

You will see something like this:

.. raw:: html
    
    <div class="code"><code>GTM></code></div>

or in Cache:

.. raw:: html

    <div class="code"><code>USER></code></div>

If you are in Cache, you need to switch namespaces. (If you don't remember, type ? to see your choices.)

.. raw:: html
    
    <div class="code"><code>><strong>D ^%CD</strong>
    
    NAMESPACE// <strong>VISTA</strong></code></div>

Note to GT.M Users
------------------
Due to the fact that Cache does not enforce the M standard as strictly, many illegal instructions
have found themselves into VistA code. In addition, neither Cache nor GT.M is fully M95 standards
compliant. As a result, there is always the game of making sure what we write supports both systems.
For these reasons, the hardhats community maintains fixes for these routines
and when possible sends the fixes back to the VA. In the future, the OSEHRA repositories
will contain the fixes so that end users don't have to download the code and fix it themselves.

The WorldVistA Distrubution of VistA is GT.M compatible; you don't need any fixes for it; but the
below provides a lot more functionality.

If you downloaded vxVistA or FOIA VistA, you need to copy the routines from this repository
to your routines directory: https://github.com/shabiel/Kernel-GTM. Here's how to do it:

.. code-block:: bash

    $ git clone https://github.com/shabiel/Kernel-GTM && cd Kernel-GTM
    $ cp -v $(git diff --name-only 29bc19..a7565b -- Kernel/Routines) /var/db/foia201611-gtm/r/

Note to Cache Users
-------------------
The evaluation version of Cache won't let you run more than one foreground process and 20 background processes. You can certainly configure VistA and run the RPC broker, and then connect CPRS; but you won't be able to have more than one session open at once; and you may need to restart Cache repeatedly as it sometimes "forgets" that you logged off.

Commands and what they mean (a short M primer)
----------------------------------------------
In the excerpts below, you will enter Mumps (M) commands into direct mode. Here are a few
interesting ones:

.. code-block:: M

    S DUZ=.5 ; S is a shortcut for SET, DUZ means user number; .5 is a user that is always present on VistA systems.

    D ^XUP ; D is a shortcut for DO, ^XUP is the name of the routine. ^XUP is the programmer mode menu runner.

    ; A semicolon, like in GAS assembly, is the comment character. M, like C, was written to replace assembly.

    D Q^DI ; Do starting from Label Q in Routine DI. Q^DI is how to enter Fileman.

VistA Text Mode Conventions
---------------------------
There are a few confusing conventions that outsiders don't understand right away. Here they are:

* ``//`` means that the preceding text is the default. If you press enter, you will accept it.
* ``Replace`` means that the existing text is long and you can edit it. Typing ``...`` means that you will replace the entire thing; ``END`` appends to the end. You can also use ``...`` to signify a range between two elements.
* ``@`` deletes an item.
* ``^`` usually lets you quit what you are in the middle of.
* ``^FIELD NAME`` lets you jump to a field while editing other fields. You may be blocked depending on what the programmer decides you are allowed to do.
* ``?`` Short Help. Typically it tells you that you need to type a number or text.
* ``??`` More Help. Should tell you what the field you are filling does. In the menu system, show all menus with what security keys they need.
* ``???`` In the menu system, display help for each immediate submenu.
* ``????`` In the menu system, display help for current menu.
* ``<enter>`` key is the main navigation key in VistA. Typing it after an entry enters that entry; typing when nothing is entered will move you forward or up, depending on the context.
* ``Select <item>`` Whenever you see select, you can select or add an item; after that, you can edit it.

Begin to Set Up the VistA System
================================
Before you Start
----------------
You need to either invent or be given a few pieces of data:

* What are you going to call your Hospital or Clinic?
* What's your station number? If you use VISTA or RPMS deployed by VA, IHS, or an external vendor; they will assign you your station number. Otherwise, pick a number from 130 to 199; or 971 to 999. These numbers are not used by VISTA. In this guide, we will use 999.
* What's your domain name? If you have a domain, use it; otherwise, invent one like ``WWW.HABIEL.NAME``.
* What's your parent domain? If you are not part of VA or IHS, your parent domain is ``FORUM.OSEHRA.ORG``.
* You need to know if you are running on Cache vs GT.M; and what operating system you are running on. If you followed this guide from the very beginning, you would certainly know; but day to day users of VistA have no idea actually what it is running on.
* You need to decide what port number you will have VistA listen on for the RPC Broker. By convention, it's either 9000, 9200, or 9211.
* What's the maximum number of processes that you will allow at once on a VistA system? Today (2016), commodity hardware (a good laptop, for example), can handle up to 200 concurrent processes. I usually set my test instances with a maximum of 30 processes, which is the number I use below.
* What's your DNS Server? If you don't know, just use 8.8.8.8.

Device Configuration
--------------------
The very first thing we want to do is to set-up 4 devices: NULL, CONSOLE, VIRTUAL, and HFS.
(known historically as TELNET due to what often accessed it). The NULL device corresponds
to a place where we dump data we don't want; that's ``/dev/null`` on all Unices; ``//./nul``
on Windows. The NULL device is also known as the "BIT BUCKET", for obvious reasons.

CONSOLE stands for the device the terminal presents itself as if directly connected to
a computer. These days, no computer has real console devices. 
Linux still has an emulated console device: ``/dev/tty``. Cache Terminal
presents a console device called ``|TRM|``.

VIRTUAL stands for all connections from Virtual Emulators. Unfortunately every different
operating system provides a different console device:

* Linux: ``/dev/pts`` (Use with both Cache and GT.M)
* macOS: ``/dev/ttys`` (ditto)
* Cygwin: ``/dev/cons`` (GT.M)
* Cache Telnet: ``|TNT|`` (Cache/Windows ONLY)

The way set up devices is to edit the DEVICE file in Fileman. Fileman is the Database 
Management System for VistA; unlike most databases in the market, it provides a user
interface as well, albiet a text-based one.

To get into Fileman, you need to set your user (DUZ) to .5, and then go in.

NULL Device
***********
There should only be one device named "NULL". Unfortunately, there are three NULLs of
various flavors in the FOIA; we need to make sure there is only one. Follow the following.
We rename the nulls we don't want, and we delete a synonym.


.. raw:: html
    
    <div class="code"><code>><strong>S DUZ=.5</strong>
    <strong>D Q^DI</strong>
    
    VA Fileman 22.2
    
    Select OPTION: <strong>1</strong>  ENTER OR EDIT FILE ENTRIES
    
    Input to what File: DEVICE// <strong>&lt;enter&gt;</strong>    (53 entries)
    EDIT WHICH FIELD: ALL// <strong>&lt;enter&gt;</strong>
    
    Select DEVICE NAME: <strong>NULL</strong>
         1   NULL      NT SYSTEM     NLA:
         2   NULL  GTM-UNIX-NULL    Bit Bucket (GT.M-Unix)     /dev/null     
         3   NULL-DSM      Bit Bucket     _NLA0:     
    CHOOSE 1-3: <strong>1</strong>  NULL    NT SYSTEM     NLA:
    NAME: NULL// <strong>NT-NULL</strong>
    LOCATION OF TERMINAL: NT SYSTEM// <strong>^</strong>
    
    Select DEVICE NAME: <strong>NULL</strong>
         1   NULL  GTM-UNIX-NULL    Bit Bucket (GT.M-Unix)     /dev/null     
         2   NULL-DSM      Bit Bucket     _NLA0:     
    CHOOSE 1-2: 2  NULL-DSM    Bit Bucket     _NLA0:     
    NAME: NULL-DSM// <strong>DSM-NULL</strong>
    LOCATION OF TERMINAL: Bit Bucket// <strong>^</strong>
    
    Select DEVICE NAME: <strong>NULL</strong>  GTM-UNIX-NULL    Bit Bucket (GT.M-Unix)    /dev/null 
    
    NAME: GTM-UNIX-NULL// <strong>NULL</strong>
    LOCATION OF TERMINAL: Bit Bucket (GT.M-Unix)  Replace <strong>&lt;enter&gt;</strong>
    Select MNEMONIC: NULL// <strong>@</strong>
       SURE YOU WANT TO DELETE? <strong>Y</strong>  (Yes)
    Select MNEMONIC: GTM-LINUX-NULL// <strong>@</strong>
       SURE YOU WANT TO DELETE? <strong>Y</strong>  (Yes)
    Select MNEMONIC: <strong>&lt;enter&gt;</strong>
    LOCAL SYNONYM: <strong>^</strong>
    
    Select DEVICE NAME: <strong>&lt;enter&gt;</strong></code></div>

At this point, we need to make sure that $I (short for $IO) for the device is correct
for the system. All Unices have ``/dev/null``; Windows is ``//./nul``.

.. raw:: html

    <div class="code"><code>Select OPTION: <strong>EN</strong>TER OR EDIT FILE ENTRIES

    Input to what File: DEVICE// <strong>&lt;enter&gt;</strong>             (54 entries)
    EDIT WHICH FIELD: ALL// $I  

    Select DEVICE NAME: <strong>NULL</strong>
    $I: /dev/null// <strong>//./nul</strong> (or leave it alone as it is correct for Unix).
    
    Select DEVICE NAME: <strong>&lt;enter&gt;</strong></code></div>

CONSOLE Device
**************
If you use Cache on Windows or Linux; or GT.M, you should be *theoretically* set; however,
the FOIA set-up is incomplete or overspecified. I would prefer to select an entry and make
sure it's properly specified:

You need to fill these fields as follows; and no others:

* NAME = CONSOLE
* $I = /dev/tty on Linux; |TRM| on Cache/Windows.
* LOCATION OF TERMINAL = Physical Console
* TYPE = VIRTUAL TERMINAL
* SUBTYPE = C-VT220
* SIGN-ON/SYSTEM DEVICE = YES

Here's an example:

.. raw:: html

    <div class="code"><code>Select OPTION: <strong>EN</strong>TER OR EDIT FILE ENTRIES  



    Input to what File: DEVICE//  <strong>&lt;enter&gt;</strong>            (54 entries)
    EDIT WHICH FIELD: ALL// <strong>NAME</strong>  
    THEN EDIT FIELD: <strong>$I</strong>
    THEN EDIT FIELD: <strong>LOCATION OF TERMINAL  </strong>
    THEN EDIT FIELD: <strong>TYPE</strong>
         1   TYPE  
         2   TYPE-AHEAD  
    CHOOSE 1-2: 1  <strong>TYPE</strong>
    THEN EDIT FIELD: <strong>SUBTYPE</strong>
    THEN EDIT FIELD: <strong>SIGN-ON/SYSTEM DEVICE</strong>
    THEN EDIT FIELD: <strong>&lt;enter&gt;</strong>
    STORE THESE FIELDS IN TEMPLATE: <strong>&lt;enter&gt;</strong>


    Select DEVICE NAME: <strong>CONSOLE</strong>
         1   CONSOLE      CONSOLE     OPA     
         2   CONSOLE  GTM-UNIX-CONSOLE    Console (GT.M)     /dev/tty     
         3   CONSOLE  CACHE-WINDOWS-CONSOLE    Console (Cache' on Windows)     |TRM|
         
    CHOOSE 1-3: <strong>2</strong>  GTM-UNIX-CONSOLE    Console (GT.M)     /dev/tty     
    NAME: GTM-UNIX-CONSOLE// <strong>&lt;enter&gt;</strong>
    $I: /dev/tty// <strong>&lt;enter&gt;</strong>
    LOCATION OF TERMINAL: Console (GT.M)// <strong>&lt;enter&gt;</strong>
    TYPE: VIRTUAL TERMINAL// <strong>&lt;enter&gt;</strong>
    SUBTYPE: C-VT100// <strong>C-VT220</strong>      Digital Equipment Corporation VT-220 terminal
    SIGN-ON/SYSTEM DEVICE: <strong>Y</strong>  YES
    </code></div>

VIRTUAL Device
**************
The FOIA only comes with Linux Virtual Terminal. As before, here's what you need
to fill it out. 

* NAME = VIRTUAL TERMINAL
* $I = /dev/pts on Linux; /dev/ttys on macOS; /dev/cons on Cygwin; |TNT| on Cache/Windows.
* LOCATION OF TERMINAL = Virtual Terminal
* TYPE = VIRTUAL TERMINAL
* SUBTYPE = C-VT220
* SIGN-ON/SYSTEM DEVICE = YES

HFS Device
**********
The HFS device is necessary because KIDS (the installation system used by VISTA) uses it
to open files on the operating system. (Technically, it only uses the Open Parameters field.)
The one that comes in FOIA looks like this:

.. code-block::

    NAME: HFS                               $I: USER$:[TEMP]TMP.DAT
    ASK DEVICE: YES                       ASK PARAMETERS: YES
    LOCATION OF TERMINAL: Host File Server
    ASK HOST FILE: YES                    ASK HFS I/O OPERATION: YES
    OPEN COUNT: 870                       OPEN PARAMETERS: "WNS"
    SUBTYPE: P-OTHER                      TYPE: HOST FILE SERVER

You need to select it and change the settings as follows:

* NAME = HFS
* $I  = /tmp/hfs.dat or /dev/shm/hfs.dat or d:\hfs\, depending on your operating system (All Unices has /tmp/; only Linux has /dev/shm; last one is an example on Windows)
* ASK DEVICE = YES
* ASK PARAMETERS = @ (Delete it)
* LOCATION OF TERMINAL = Host File Server
* ASK HOST FILE = YES
* ASK HFS I/O OPERATION = @ (Delete it)
* OPEN PARAMETERS: "WNS" for Cache, (newvesrion) for GT.M (note quotes on Cache and their abcense on GT.M)
* SUBYTPE: P-HFS/80/99999
* TYPE: HOST FILE SERVER

ZTMGRSET
--------
The routine ZTMGRSET defines VistA global variables and saves system wide M 
routines that are M and OS specific. We need to kill ^%ZOSF to make sure we don't have
old answers here; and sometimes having ^%ZOSF when you have just switched M implementations
causes a catch 22 problem. The text scrape below is for GT.M; Cache follows.

.. raw:: html
    
    <div class="code"><code>><strong>K ^%ZOSF</strong>
    
    ><strong>D ^ZTMGRSET</strong>
    
    
    ZTMGRSET Version 8.0 Patch level **34,36,69,94,121,127,136,191,275,355,446,584**
    HELLO! I exist to assist you in correctly initializing the current account.
    Which MUMPS system should I install?
    
    1 = VAX DSM(V6), VAX DSM(V7)
    2 = MSM-PC/PLUS, MSM for NT or UNIX
    3 = Cache (VMS, NT, Linux), OpenM-NT
    4 = 
    5 = 
    6 = 
    7 = GT.M (VMS)
    8 = GT.M (Unix)
    System: <strong>8</strong>
    
    I will now rename a group of routines specific to your operating system.
    Routine:  ZOSVGUX Loaded, Saved as    %ZOSV
    
    Routine:  ZIS4GTM Loaded, Saved as    %ZIS4
    Routine:  ZISFGTM Loaded, Saved as    %ZISF
    Routine:  ZISHGTM Loaded, Saved as    %ZISH
    Routine:  XUCIGTM Loaded, Saved as    %XUCI
    Routine: ZOSV2GTM Loaded, Saved as   %ZOSV2
    Routine:  ZISTCPS Loaded, Saved as %ZISTCPS
    
    NAME OF MANAGER'S UCI,VOLUME SET: VAH,ROU//
    The value of PRODUCTION will be used in the GETENV api.
    PRODUCTION (SIGN-ON) UCI,VOLUME SET: VAH,ROU//
    The VOLUME name must match the one in PRODUCTION.
    NAME OF VOLUME SET: ROU//
    The temp directory for the system: '/tmp/'// <strong>&lt;enter&gt;</strong>
    ^%ZOSF setup
    
    
    Now to load routines common to all systems.
    Routine:   ZTLOAD Loaded, Saved as  %ZTLOAD
    Routine:  ZTLOAD1 Loaded, Saved as %ZTLOAD1
    Routine:  ZTLOAD2 Loaded, Saved as %ZTLOAD2
    Routine:  ZTLOAD3 Loaded, Saved as %ZTLOAD3
    
    ...
    
    Routine:   ZTRDEL Loaded, Saved as  %ZTRDEL
    Routine:   ZTMOVE Loaded, Saved as  %ZTMOVE
    Routine:    ZTBKC Loaded, Saved as   %ZTBKC
    Want to rename the FileMan routines: No// <strong>Y</strong>
    Routine:     DIDT Loaded, Saved as      %DT
    Routine:    DIDTC Loaded, Saved as     %DTC
    Routine:    DIRCR Loaded, Saved as     %RCR
    Setting ^%ZIS('C')
    
    Now, I will check your % globals...........
     
    ALL DONE
    ></code></div>

On Caché
********

On Cache, you will see different prompts.

.. raw:: html
    
    <div class="code"><code>NAME OF MANAGER'S NAMESPACE: VISTA// <strong>&lt;enter&gt;</strong>
    
    PRODUCTION (SIGN-ON) NAMESPACE: VISTA// <strong>&lt;enter&gt;</strong>
    
    NAME OF THIS CONFIGURATION: VISTA// <strong>&lt;enter&gt;</strong></code></div>

Fileman
-------

Initialize FileMan to set your domain name and number and Operating System (GT.M shown below).

.. raw:: html
    
    <div class="code"><code>><strong>D ^DINIT</strong>
    
    VA FileMan V.22.2
    
    Initialize VA FileMan now?  NO// <strong>Y</strong>
    
    SITE NAME: DEMO.OSEHRA.ORG// <strong>&lt;enter&gt;</strong>
    
    SITE NUMBER: 999// <strong>&lt;enter&gt;</strong>
    
    Now loading MUMPS Operating System File
    
    Do you want to change the MUMPS OPERATING SYSTEM File? NO//....
    
    Now loading DIALOG and LANGUAGE Files.......................................
    
    TYPE OF MUMPS SYSTEM YOU ARE USING: GT.M(UNIX)// <strong>?</strong>
        Answer with MUMPS OPERATING SYSTEM NAME
       Choose from:
       CACHE/OpenM   
       DSM for OpenVMS   
       DTM-PC   
       GT.M(UNIX)   
       GT.M(VAX)   
       MSM   
       OTHER   
   
    TYPE OF MUMPS SYSTEM YOU ARE USING: GT.M(UNIX)// <strong>&lt;enter&gt;</strong>

    Now loading other FileMan files--please
    wait........................................................................

    The following files have been installed:
       .11     INDEX
       .2      DESTINATION
       .31     KEY
       
       ...
       
      1.5219   SQLI_FOREIGN_KEY
      1.52191  SQLI_ERROR_TEXT
      1.52192  SQLI_ERROR_LOG
      
      
    Re-indexing entries in the DIALOG file..........................
    
    Compiling all forms ...
    
       DICATT                          (#.001)
       DIPTED                          (#.1001)
       DIKC EDIT                       (#.1101)
       
       ...
       
       SPNLP MS FM1                    (#45)
       SPNE ENTER/EDIT SYNONYM         (#46)
       LREPI                           (#47)

    File #80 does not contain a field #3.
    THE FORM "LREPI" COULD NOT BE COMPILED.

       ENPR MS                         (#48)
       ENPR ALL                        (#49)
       ENPR PRELIM                     (#50)
       
       ...
       
       PXRM TAXONOMY EDIT              (#125)
       PXRM TAXONOMY CHANGE LOG        (#126)
       PXRM DIALOG TAXONOMY EDIT       (#127)
       
       
    INITIALIZATION COMPLETED IN 4 SECONDS.
    ></code></div>

ZUSET
-----
Also run D ^ZUSET to choose the correct version of ZU, the key login routine 
for the roll and scroll portions of VistA (GT.M shown).

.. raw:: html
    
    <div class="code"><code><strong>D ^ZUSET</strong>
    
    This routine will rename the correct routine to ZU for you.
    
    Rename ZUGTM to ZU, OK? No// <strong>Y</strong>
    Routine ZUGTM was renamed to ZU</code></div>

Instance Domain, Parent Domain, and Q-PATCH domain
--------------------------------------------------
Next, a domain should be set up for the VistA instance.  A domain name is
typically used to uniquely identify an instance on a network.  The parent domain
is the domain responsible for routing your traffic to the outside world. The
Q-PATCH domain is only necessary for developers wishing to use OSEHRA Forum. 
First we add the entry to the ``DOMAIN`` file through FileMan.

.. raw:: html
    
    <div class="code"><code>><strong>S DUZ=.5 D Q^DI</strong>
    
    VA FileMan 22.0
    
    Select OPTION: <strong>1</strong>  ENTER OR EDIT FILE ENTRIES
    
    INPUT TO WHAT FILE: // <strong>DOMAIN</strong>
                                         (70 entries)
    EDIT WHICH FIELD: ALL// <strong>ALL</strong>
    
    Select DOMAIN NAME: <strong>DEMO.OSEHRA.ORG</strong>
      Are you adding 'DEMO.OSEHRA.ORG' as a new DOMAIN (the 71ST)? No// <strong>Y</strong>  (Yes)
    FLAGS: <strong>^</strong>
    
    Select DOMAIN NAME: <strong>Q-PATCH.OSEHRA.ORG</strong>
    NAME: Q-PATCH.OSEHRA.ORG// <strong>&lt;enter&gt;</strong>
    FLAGS: Q// <strong>&lt;enter&gt;</strong>
    SECURITY KEY: <strong>&lt;enter&gt;</strong>
    VALIDATION NUMBER: <strong>&lt;enter&gt;</strong>
    NEW VALIDATION NUMBER: <strong>&lt;enter&gt;</strong>
    DISABLE TURN COMMAND: <strong>&lt;enter&gt;</strong>
    RELAY DOMAIN: <strong>&lt;enter&gt;</strong>
    Select TRANSMISSION SCRIPT: <strong>MAIN</strong>
      Are you adding 'MAIN' as a new TRANSMISSION SCRIPT (the 1ST for this DOMAIN)?
     No// <strong>Y</strong>  (Yes)
      PRIORITY: <strong>1</strong>
      NUMBER OF ATTEMPTS: <strong>2</strong>
      TYPE: <strong>Simple</strong>  Simple Mail Transfer Protocol
      PHYSICAL LINK / DEVICE: <strong>NULL</strong> Stored internally as NULL
      NETWORK ADDRESS (MAILMAN HOST): <strong>FORUM.OSEHRA.ORG</strong>
      OUT OF SERVICE: <strong>&lt;enter&gt;</strong>
      TEXT:
      1><strong>O H="FORUM.OSEHRA.ORG",P=TCP/GTM</strong>
      2><strong>C TCPCHAN-SOCKET25/GTM</strong>
      3><strong>&lt;enter&gt;</strong>
    EDIT Option: <strong>^</strong>
      TRANSMISSION SCRIPT NOTES:
      1><strong>&lt;enter&gt;</strong>
    Select TRANSMISSION SCRIPT: <strong>^</strong>
    
    Select DOMAIN NAME: <strong>FORUM.OSEHRA.ORG</strong>
    NAME: FORUM.OSEHRA.ORG// <strong>&lt;enter&gt;</strong>
    FLAGS: <strong>Q</strong>
    SECURITY KEY: <strong>&lt;enter&gt;</strong>
    VALIDATION NUMBER: <strong>&lt;enter&gt;</strong>
    NEW VALIDATION NUMBER: <strong>&lt;enter&gt;</strong>
    DISABLE TURN COMMAND: <strong>&lt;enter&gt;</strong>
    RELAY DOMAIN: <strong>&lt;enter&gt;</strong>
    Select TRANSMISSION SCRIPT: <strong>MAIN</strong>
      Are you adding 'MAIN' as a new TRANSMISSION SCRIPT (the 1ST for this DOMAIN)?
     No// <strong>Y</strong>  (Yes)
      PRIORITY: <strong>1</strong>
      NUMBER OF ATTEMPTS: <strong>2</strong>
      TYPE: <strong>Simple</strong>  Simple Mail Transfer Protocol
      PHYSICAL LINK / DEVICE: <strong>NULL</strong> Stored internally as NULL
      NETWORK ADDRESS (MAILMAN HOST): <strong>FORUM.OSEHRA.ORG</strong>
      OUT OF SERVICE: <strong>&lt;enter&gt;</strong>
      TEXT:
      1><strong>O H="FORUM.OSEHRA.ORG",P=TCP/GTM</strong>
      2><strong>C TCPCHAN-SOCKET25/GTM</strong>
      3><strong>&lt;enter&gt;</strong>
    EDIT Option: ^
      TRANSMISSION SCRIPT NOTES:
      1><strong>&lt;enter&gt;</strong>
    Select TRANSMISSION SCRIPT: ^
    
    Select DOMAIN NAME: <strong>&lt;enter&gt;</strong>
    
    Select OPTION: <strong>&lt;enter&gt;</strong>
    ></code></div>

The next step is to find the IEN of the instance domain. This can be done
by inquiring about the entry using FileMan and printing the Record Number:

.. raw:: html
    
    <div class="code"><code>><strong>S DUZ=.5 D Q^DI</strong>
    
    VA FileMan 22.2
    
    Select OPTION: <strong>5</strong>  INQUIRE TO FILE ENTRIES
    
    OUTPUT FROM WHAT FILE: DOMAIN// <strong>DOMAIN</strong>   (71 entries)
    Select DOMAIN NAME: <strong>DEMO.OSEHRA.ORG</strong>
    ANOTHER ONE: <strong>&lt;enter&gt;</strong>
    STANDARD CAPTIONED OUTPUT? Yes// <strong>Y</strong>  (Yes)
    Include COMPUTED fields:  (N/Y/R/B): NO// <strong>Record Number (IEN)</strong>
    
    NUMBER: 76                              NAME: DEMO.OSEHRA.ORG
    
    Select DOMAIN NAME: <strong>&lt;enter&gt;</strong>
    
    Select OPTION: <strong>&lt;enter&gt;</strong>
    ></code></div>


Then we propogate that entry to the ``Kernel System Parameters`` and
``RPC Broker Site Parameters`` files.  The value that is being set should
be the same as the ``NUMBER`` value from the above result.

.. raw:: html
    
    <div class="code"><code>><strong>S $P(^XWB(8994.1,1,0),"^")=76</strong>
    ><strong>S $P(^XTV(8989.3,1,0),"^")=76</strong></code></div>

Re-index the files after making this change.

.. raw:: html
    
    <div class="code"><code>><strong>F DIK="^XTV(8989.3,","^XWB(8994.1," S DA=1 D IXALL2^DIK,IXALL^DIK</strong></code></div>

Christening
-----------
System is christened using menu option XMCHIRS with FORUM.OSEHRA.ORG as the parent.

.. raw:: html
    
    <div class="code"><code>><strong>S DUZ=.5 D ^XUP</strong>
    
    Setting up programmer environment
    This is a TEST account.
    
    Terminal Type set to: C-VT320
    
    Select OPTION NAME: <strong>XMCHRIS</strong>       Christen a domain
    Christen a domain
    
             * * * *  WARNING  * * * *
    
    You are about to change the domain name of this facility
    in the MailMan Site Parameters file.
    
    Currently, this facility is named: FOIA.DOMAIN.EXT
    
    You must be extremely sure before you proceed!
    
    Are you sure you want to change the name of this facility? NO// <strong>YES</strong>
    Select DOMAIN NAME: FOIA.DOMAIN.EXT// <strong>DEMO.OSEHRA.ORG</strong>

    The domain name for this facility is now: DEMO.OSEHRA.ORG
    
    PARENT: DOMAIN.EXT// <strong>FORUM.OSEHRA.ORG</strong>
    TIME ZONE: EST// <strong>PST</strong>       PACIFIC STANDARD
    
    FORUM.OSEHRA.ORG has been initialized as your 'parent' domain.
    (Forum is usually the parent domain, unless this is a subordinate domain.)
    
    You may edit the MailMan Site Parameter file to change your parent domain.
    
    We will not initialize your transmission scripts.
    
    Use the 'Subroutine editor' option under network management menu to add your
    site passwords to the MINIENGINE script, and the 'Edit a script' option
    to edit any domain scripts that you choose to.
    ></code></div>

Set-up Taskman
--------------
Taskman is the VistA subsystem that is repsonsible for running processes in
the background.

The first step is to find the box volume pair for the local machine.

.. raw:: html
    
    <div class="code"><code>><strong>D GETENV^%ZOSV W Y</strong></code></div>

which will print out a message with four parts separated by ``^`` that could
look something like (Cache):

.. raw:: html
    
    <div class="code"><code>VISTA^VISTA^palaven^VISTA:CACHE</code></div>

or (GT.M)

.. raw:: html

    <div class="code"><code>VAH^ROU^Macintosh^ROU:Macintosh</code></div>

The four pieces of the string are:

``UCI^VOL^NODE^VOLUME:BOX``

The fourth piece, the VOLUME:BOX pair, is referred to as the "BOX VOLUME pair".
The first component of the Box Volume pair is the Volume Set, which is used to
determine where the VistA system will be able to find the routines. The second
component Box, which references the system that the instance is on. In a Caché
system, it would be the name of the Caché instance while on GT.M, it should
reference the hostname of the machine.

The Volume Set result needs to be altered in the ``VOLUME SET`` file,
and we will reuse some setup by writing over the name of the first entry that
is already in the VistA system.  The first entry, the entry with an IEN of 1,
can be selected by entering ```1``.

Then we rename the first Box-Volume pair in the ``TaskMan Site Parameters``
file to match what was found above.

For this demonstration instance, the Volume Set will be ``ROU``, as per the 
output above. 

.. raw:: html
    
    <div class="code"><code>&gt;<strong>D Q^DI</strong>
    
    VA Fileman 22.2
    
    Select OPTION: 1  ENTER OR EDIT FILE ENTRIES
    
    Input to what File: RPC BROKER SITE PARAMETERS// 14.5  VOLUME SET
                                              (1 entry)
    EDIT WHICH FIELD: ALL// <strong>&lt;enter&gt;</strong>
    
    Select VOLUME SET: <strong>`1</strong>
    VOLUME SET: ROU// <strong>&lt;enter&gt;</strong>
    TYPE: GENERAL PURPOSE VOLUME SET// <strong>&lt;enter&gt;</strong>
    INHIBIT LOGONS?: NO// <strong>&lt;enter&gt;</strong>
    LINK ACCESS?: NO// <strong>&lt;enter&gt;</strong>
    OUT OF SERVICE?: NO// <strong>&lt;enter&gt;</strong>
    REQUIRED VOLUME SET?: NO// <strong>&lt;enter&gt;</strong>
    TASKMAN FILES UCI: VAH// <strong>&lt;enter&gt;</strong>
    TASKMAN FILES VOLUME SET: ROU// <strong>&lt;enter&gt;</strong>
    REROUCEMENT VOLUME SET: <strong>&lt;enter&gt;</strong>
    DAYS TO KEEP OLD TASKS: 4// <strong>14</strong>
    SIGNON/PRODUCTION VOLUME SET: Yes// <strong>&lt;enter&gt;</strong>
    RE-QUEUES BEFORE UN-SCHEDULE: 12// <strong>&lt;enter&gt;</strong>
    
    Select VOLUME SET: <strong>&lt;enter&gt;</strong></code></div>
   
The next step is there to tell Taskman what the parameters are to run itself:

.. raw:: html
    
    <div class="code"><code>Select OPTION: <strong>1</strong>  ENTER OR EDIT FILE ENTRIES
    
    Input to what File: UCI ASSOCIATION// 14.7  TASKMAN SITE PARAMETERS
                                              (1 entry)
    EDIT WHICH FIELD: ALL// <strong>&lt;enter&gt;</strong>
    
    Select TASKMAN SITE PARAMETERS BOX-VOLUME PAIR: <strong>`1</strong> 
    BOX-VOLUME PAIR: PLA:PLAISCSVR// <strong>?</strong>  ; Type a ? to see what is the correct value you should enter.
         Answer must be 3-30 characters in length.

         The value for the current account is ROU:Macintosh
    BOX-VOLUME PAIR: PLA:PLAISCSVR// <strong>ROU:Macintosh</strong> ; Enter that value.
    RESERVED: <strong>&lt;enter&gt;</strong>
    LOG TASKS?: NO// <strong>@</strong>
       SURE YOU WANT TO DELETE? <strong>y</strong>  (Yes)
    DEFAULT TASK PRIORITY: <strong>&lt;enter&gt;</strong>
    TASK PARTITION SIZE: <strong>&lt;enter&gt;</strong>
    SUBMANAGER RETENTION TIME: 0// <strong>&lt;enter&gt;</strong>
    TASKMAN JOB LIMIT: 100// <strong>24</strong> ; Must be 80% of maximum; in our case that's 30.
    TASKMAN HANG BETWEEN NEW JOBS: 1// <strong>0</strong> ; No need to throttle process creation.
    MODE OF TASKMAN: GENERAL PROCESSOR// <strong>&lt;enter&gt;</strong>
    VAX ENVIROMENT FOR DCL: <strong>&lt;enter&gt;</strong>
    OUT OF SERVICE: NO// <strong>&lt;enter&gt;</strong>
    MIN SUBMANAGER CNT: 5// <strong>1</strong> ; Change that to 1
    TM MASTER: <strong>&lt;enter&gt;</strong>
    Balance Interval: <strong>&lt;enter&gt;</strong>
    LOAD BALANCE ROUTINE: <strong>&lt;enter&gt;</strong>
    Auto Delete Tasks: <strong>Y</strong>  Yes ; Delete Tasks automatically
    Manager Startup Delay: <strong>1</strong> ; Don't wait to start the Manager when first starting.
    
    Select TASKMAN SITE PARAMETERS BOX-VOLUME PAIR: <strong>&lt;enter&gt;</strong></code></div>

Kernel Set-Up
-------------
We are not done with setting Taskman up yet; but our next stop is the Kernel System Parameters file.
We need to fix the Volume multiple there; but since we are there, we will fix several other items
as well:

* AGENCY CODE = EHR (We are not running this inside of the VA)
* VOLUME SET:VOLUME SET = ROU
* VOLUME SET:MAX SIGNON ALLOWED = 30 (That's the maximum number of processes allowed to run)
* VOLUME SET:LOG SYSTEM RT? = @ (delete)
* DNS IP = Your DNS Server, or a public one
* DEFAULT AUTO-MENU = YES (print menus automatically)
* INTRO MESSSAGE (word-processing) = Put whatever you want here. This is what users see when they log-on.
* PRIMARY HFS DIRECTORY = Default directory where to write things to. Put an appropriate directory for your OS.

.. raw:: html
    
    <div class="code"><code>><strong>D Q^DI</strong>
    
    VA Fileman 22.2
    
    Select OPTION: <strong>1</strong>  ENTER OR EDIT FILE ENTRIES
    
    Input to what File: UCI ASSOCIATION// <strong>KERNEL SYSTEM PARAMETERS</strong>
                                              (1 entry)
    EDIT FIELD: <strong>AGENCY</strong> CODE  
    THEN EDIT FIELD: <strong>VOLUME</strong> SET    (multiple)
       EDIT WHICH VOLUME SET SUB-FIELD: ALL//<strong>&lt;enter&gt;</strong> 
    THEN EDIT FIELD: <strong>DNS</strong> IP  
    THEN EDIT FIELD: <strong>DEFAULT</strong> AU
         1   DEFAULT AUTO SIGN-ON  
         2   DEFAULT AUTO-MENU  
    CHOOSE 1-2: <strong>2</strong>  DEFAULT AUTO-MENU
    THEN EDIT FIELD: <strong>INTRO</strong> MESSAGE    (word-processing)
    THEN EDIT FIELD: <strong>PRIMARY</strong> HFS DIRECTORY  
    THEN EDIT FIELD: <strong>&lt;enter&gt;</strong>
    
    Select KERNEL SYSTEM PARAMETERS DOMAIN NAME: <strong>`1</strong> DEMO.OSEHRA.ORG
             ...OK? Yes// <strong>&lt;enter&gt;</strong>  (Yes)
             
    AGENCY CODE: VA// <strong>E</strong>  EHR
    Select VOLUME SET: PLA// <strong>@</strong>
       SURE YOU WANT TO DELETE THE ENTIRE 'PLA' VOLUME SET? Y  (Yes)
    Select VOLUME SET: <strong>ROU</strong>
      Are you adding 'ROU' as a new VOLUME SET? No// <strong>Y</strong>  (Yes)
      MAX SIGNON ALLOWED: <strong>30</strong>
      LOG SYSTEM RT?:<strong>&lt;enter&gt;</strong>
    Select VOLUME SET: 
    DNS IP: 127.0.0.1,127.0.0.12  Replace <strong>...</strong> With <strong>8.8.8.8</strong>
      Replace 
       8.8.8.8
    DEFAULT AUTO-MENU: NO// <strong>Y</strong>  YES
    INTRO MESSAGE:
      1>NEW SYSTEM 304-262-7078
    EDIT Option: <strong>1</strong>
      1>NEW SYSTEM 304-262-7078
      Replace <strong>...</strong> With <strong>This is my test system.</strong>  Replace 
       This is my test system.
    Edit line: <strong>&lt;enter&gt;</strong>
    EDIT Option: <strong>&lt;enter&gt;</strong>
    PRIMARY HFS DIRECTORY: /tmp/// <strong>&lt;enter&gt;</strong>


    Select KERNEL SYSTEM PARAMETERS DOMAIN NAME:</code></div>

Back to Taskman
---------------
At this point, we are ready to go back to getting taskman to run. We will now run ``^ZTMCHK`` which checks our work and makes sure we didn't royally screw up.

.. raw:: html
    
    <div class="code"><code>><strong>D ^ZTMCHK</strong>
    Checking Task Manager's Environment.

    Checking Taskman's globals...
         ^%ZTSCH is defined!
         ^%ZTSK is defined!
         ^%ZTSK(-1) is defined!
         ^%ZIS(14.5,0) is defined!
         ^%ZIS(14.6,0) is defined!
         ^%ZIS(14.7,0) is defined!

    Checking the ^%ZOSF nodes required by Taskman...
         All ^%ZOSF nodes required by Taskman are defined!

    Checking the links to the required volume sets...
         There are no volume sets whose links are required!

    Checks completed...Taskman's environment is okay!

    Press RETURN to continue or '^' to exit: 

    Here is the information that Taskman is using:
         Operating System:  GT.M (Unix)
         Volume Set:  ROU
         Cpu-volume Pair:  ROU:Macintosh
         TaskMan Files UCI and Volume Set:  VAH,ROU

         Log Tasks?  
         Submanager Retention Time: 0
         Min Submanager Count: 1
         Taskman Hang Between New Jobs: 0
         TaskMan running as a type: GENERAL

         Logons Inhibited?:  N
         Taskman Job Limit:  24
         Max sign-ons: 30
         Current number of active jobs: 1

    End of listing.  Press RETURN to continue:</code></div>

If ANY of the fields in the last screen are empty except "Log Tasks?", you made a mistake. Double check your work.

Next we need to initialize the recurring and start-up tasks that VistA will run.  The set of tasks you want your system to run with is very variable; you can see my page here for guidance: http://www.vistapedia.com/index.php/Taskman_Recurring_Tasks. We will set-up these base tasks on your VistA system, which every VistA system ought to have:

Start-up Jobs:

* XWB LISTENER STARTER  (Starts RPC Broker)
* XOBV LISTENER STARTUP (Starts VistALink Broker)
* XUSER-CLEAR-ALL (Cleans signed on users for a system that just got booted)
* XUDEV RES-CLEAR (Clear resource devices for a system that just got booted)
* XMMGR-START-BACKGROUND-FILER (Start mailman background processor)

Nightly Jobs:

* XMAUTOPURGE (Delete unreferenced mail messages)
* XMCLEAN (Delete from system messages deleted by users)
* XMMGR-PURGE-AI-XREF (Delete duplicate network messages)
* XQBUILDTREEQUE (Rebuild the menus in the menu system)
* XQ XUTL $J NODES (IMPORTANT: Delete left over temp globals from process activity)
* XUERTRP AUTO CLEAN (Cleans the error trap after 7 days)
* XUTM QCLEAN (Clean Task file from completed tasks if the task didn't delete itself after it ran)

Beyond these tasks, what tasks you want to run depends on what's important to you. If you write notes, you will want TIU tasks; if you use Drug Accountability, you will want PSA tasks, etc.

FOIA VistA comes with a lot of junk; so I advise starting from a clean slate. Be careful with the next few commands: they should never be run on an existing system, otherwise they may delete patient data:

.. raw:: html
    
    <div class="code"><code>><strong>K ^%ZTSK,^%ZTSCH</strong> ; clean taskman Globals
    ><strong>D DT^DICRW S DIK="^DIC(19.2," F DA=0:0 S DA=$O(^DIC(19.2,DA)) Q:'DA  D ^DIK</strong> ; Delete all tasks</code></div>

Next add the tasks outlined above to OPTION SCHEDULING (#19.2). The startup entries will only need the NAME and SPECIAL QUEUING fields; the nightly jobs will need NAME, QUEUED TO RUN AT WHAT TIME, and RESCHEDULING FREQUENCY fields.

.. raw:: html

    <div class="code"><code>><strong>S DUZ=.5 D Q^DI</strong>
    Select OPTION:    <strong>ENTER OR EDIT FILE ENTRIES</strong>

    Input to what File: OPTION SCHEDULING// <strong>&lt;enter&gt;</strong> (0 entries)
    EDIT WHICH FIELD: ALL// <strong>.01</strong>  NAME
    THEN EDIT FIELD: <strong>2</strong>  QUEUED TO RUN AT WHAT TIME
    THEN EDIT FIELD: <strong>6</strong>  RESCHEDULING FREQUENCY
    THEN EDIT FIELD: <strong>9</strong>  SPECIAL QUEUEING
    THEN EDIT FIELD: <strong>&lt;enter&gt;</strong>
    
    Select OPTION SCHEDULING NAME: <strong>XWB LISTENER STARTER</strong>       Start All RPC Broker Listeners
      Are you adding 'XWB LISTENER STARTER' as 
        a new OPTION SCHEDULING (the 1ST)? No// <strong>Y</strong>  (Yes)
    QUEUED TO RUN AT WHAT TIME: <strong>&lt;enter&gt;</strong>
    RESCHEDULING FREQUENCY: <strong>&lt;enter&gt;</strong>
    SPECIAL QUEUEING: <strong>S</strong>  STARTUP


    Select OPTION SCHEDULING NAME: <strong>XOBV LISTENER STARTUP</strong>       Start VistaLink Listener Configuration
      Are you adding 'XOBV LISTENER STARTUP' as 
        a new OPTION SCHEDULING (the 2ND)? No// <strong>Y</strong>  (Yes)
    QUEUED TO RUN AT WHAT TIME: <strong>&lt;enter&gt;</strong>
    RESCHEDULING FREQUENCY: <strong>&lt;enter&gt;</strong>
    SPECIAL QUEUEING: <strong>S</strong>  STARTUP


    Select OPTION SCHEDULING NAME: <strong>XUSER-CLEAR-ALL</strong>       Clear all users at startup
      Are you adding 'XUSER-CLEAR-ALL' as 
        a new OPTION SCHEDULING (the 3RD)? No// <strong>Y</strong>  (Yes)
    QUEUED TO RUN AT WHAT TIME: <strong>&lt;enter&gt;</strong>
    RESCHEDULING FREQUENCY: <strong>&lt;enter&gt;</strong>
    SPECIAL QUEUEING: <strong>S</strong>  STARTUP


    Select OPTION SCHEDULING NAME: <strong>XUDEV RES-CLEAR</strong>
      Are you adding 'XUDEV RES-CLEAR' as 
        a new OPTION SCHEDULING (the 4TH)? No// <strong>Y</strong>  (Yes)
    QUEUED TO RUN AT WHAT TIME: <strong>&lt;enter&gt;</strong>
    RESCHEDULING FREQUENCY: <strong>&lt;enter&gt;</strong>
    SPECIAL QUEUEING: <strong>S</strong>  STARTUP


    Select OPTION SCHEDULING NAME: <strong>XMMGR-START-BACKGROUND-FILER</strong>       START background filer
      Are you adding 'XMMGR-START-BACKGROUND-FILER' as 
        a new OPTION SCHEDULING (the 5TH)? No// <strong>Y</strong>  (Yes)
    QUEUED TO RUN AT WHAT TIME: <strong>&lt;enter&gt;</strong>
    RESCHEDULING FREQUENCY: <strong>&lt;enter&gt;</strong>
    SPECIAL QUEUEING: <strong>S</strong>  STARTUP

    Select OPTION SCHEDULING NAME:    <strong>XMAUTOPURGE</strong>
      Are you adding 'XMAUTOPURGE' as 
        a new OPTION SCHEDULING (the 6TH)? No// <strong>Y</strong>  (Yes)
    QUEUED TO RUN AT WHAT TIME: <strong>T+1@0001</strong>  (DEC 01, 2016@00:01)
    RESCHEDULING FREQUENCY: <strong>1D</strong>
    SPECIAL QUEUEING: <strong>&lt;enter&gt;</strong>


    Select OPTION SCHEDULING NAME: <strong>XMCLEAN</strong>       Clean out waste baskets
      Are you adding 'XMCLEAN' as a new OPTION SCHEDULING (the 7TH)? No// <strong>Y</strong>  (Yes)
    QUEUED TO RUN AT WHAT TIME: <strong>T+1@0005</strong>  (DEC 01, 2016@00:05)
    RESCHEDULING FREQUENCY: <strong>1D</strong>
    SPECIAL QUEUEING: <strong>&lt;enter&gt;</strong>


    Select OPTION SCHEDULING NAME: <strong>XMMGR-PURGE-AI-XREF</strong>      AI x-Ref Purge of Received Network Messages
      Are you adding 'XMMGR-PURGE-AI-XREF' as 
        a new OPTION SCHEDULING (the 8TH)? No// <strong>Y</strong>  (Yes)
    QUEUED TO RUN AT WHAT TIME: <strong>T+1@0010</strong>  (DEC 01, 2016@00:10)
    RESCHEDULING FREQUENCY: <strong>1D</strong>
    SPECIAL QUEUEING: <strong>&lt;enter&gt;</strong>


    Select OPTION SCHEDULING NAME: <strong>XQBUILDTREEQUE</strong>       Non-interactive Build Primary Menu Trees
      Are you adding 'XQBUILDTREEQUE' as a new OPTION SCHEDULING (the 9TH)? No// <strong>Y</strong>
      (Yes)
    QUEUED TO RUN AT WHAT TIME: <strong>T+1@0015</strong>  (DEC 01, 2016@00:15)
    RESCHEDULING FREQUENCY: <strong>1D</strong>
    SPECIAL QUEUEING: <strong>&lt;enter&gt;</strong>


    Select OPTION SCHEDULING NAME: <strong>XQ XUTL $J NODES</strong>       Clean old Job Nodes in XUTL
      Are you adding 'XQ XUTL $J NODES' as 
        a new OPTION SCHEDULING (the 10TH)? No// <strong>Y</strong>  (Yes)
    QUEUED TO RUN AT WHAT TIME: <strong>T+1@0020</strong>  (DEC 01, 2016@00:20)
    RESCHEDULING FREQUENCY: <strong>1D</strong>
    SPECIAL QUEUEING: <strong>&lt;enter&gt;</strong>


    Select OPTION SCHEDULING NAME: <strong>XUERTRP AUTO CLEAN</strong>       Error trap Auto clean
      Are you adding 'XUERTRP AUTO CLEAN' as 
        a new OPTION SCHEDULING (the 11TH)? No// <strong>Y</strong>  (Yes)
    QUEUED TO RUN AT WHAT TIME: <strong>T+1@0025</strong>  (DEC 01, 2016@00:25)
    RESCHEDULING FREQUENCY: <strong>1D</strong>
    SPECIAL QUEUEING: <strong>&lt;enter&gt;</strong>


    Select OPTION SCHEDULING NAME: <strong>XUTM QCLEAN</strong>       Queuable Task Log Cleanup
      Are you adding 'XUTM QCLEAN' as a new OPTION SCHEDULING (the 12TH)? No// <strong>Y</strong>
      (Yes)
    QUEUED TO RUN AT WHAT TIME: <strong>T+1@0030</strong>  (DEC 01, 2016@00:30)
    RESCHEDULING FREQUENCY: <strong>1D</strong>
    SPECIAL QUEUEING: <strong>&lt;enter&gt;</strong></code></div>


There are actually just two more steps:

* Run ``DO ^ZTMB`` to start Taskman. *NOTE THAT IS THIS THE ONLY WAY TO START TASKMAN!* Restarting Taskman means that data control structure from the old system will be assumed to be correct. Don't do it!
* Run ``DO ^ZTMON`` to confirm that everything is running.

You should see this (press enter serveral times to update the screen; it should take at least 1 second to start); to exit, type ``^``.

.. raw:: html

    <div class="code"><code>><strong>D ^ZTMB,^ZTMON</strong>

    Checking Taskman.   Current $H=64252,53277  (Nov 30, 2016@14:47:57)
                          RUN NODE=64252,53274  (Nov 30, 2016@14:47:54)
    Taskman is current..
    Checking the Status List:
      Node        weight  status      time       $J
     ROU:Macintosh        RUN      T@14:47:54   81569     Main Loop

    Checking the Schedule List:
         Taskman has 3 tasks scheduled.
         None of them are overdue.

    Checking the IO Lists:  Last TM scan: 2 sec, 
         There are no tasks waiting for devices.

    Checking the Job List:
         There are no tasks waiting for partitions.

    Checking the Task List:
         There are no tasks currently running.
    Checking Sub-Managers:
         On node ROU:Macintosh there is  1 free Sub-Manager(s). Status: Run</code></div>

On CACHE, you can run ``D THIS^%SS`` to find out what started; on GT.M, you should have a ZSY which does the same thing. If ZSY isn't present on your instance, you can do something similar to this until you find a ZSY:

Cache:

.. raw:: html
    
    <div class="code"><code>><strong>D THIS^%SS</strong>

                       Cache System Status:  3:16 pm 30 Nov 2016
     Process  Device      Namespace      Routine         CPU,Glob  Pr User/Location
       72316* /dev/ttys004FOIA1611       shell       3506713,3993500  UnknownUser
       85180  /dev/null   FOIA1611       %ZTM          11266,1562  0  UnknownUser
       85393  /dev/null   FOIA1611       %ZTMS1         5177,203   0  UnknownUser
       85404  /dev/null   FOIA1611       %ZTMS1         5177,203   0  UnknownUser
       85218  /dev/null   FOIA1611       %ZTMS1         5288,214   0  UnknownUser
       85230  /dev/null   FOIA1611       %ZTMS1         5287,214   0  UnknownUser
       85242  /dev/null   FOIA1611       %ZTMS1         5287,214   0  UnknownUser
       85254  /dev/null   FOIA1611       %ZTMS1         5287,214   0  UnknownUser
       85266  /dev/null   FOIA1611       %ZTMS1         5287,214   0  UnknownUser
       85269  /dev/null   FOIA1611       %ZTMS1         5287,214   0  UnknownUser
       85295  /dev/null   FOIA1611       %ZTMS1         5287,214   0  UnknownUser
       85398  /dev/null   FOIA1611       %ZTMS1         5177,203   0  UnknownUser
       85409  /dev/null   FOIA1611       %ZTMS1         5177,203   0  UnknownUser
       85414  /dev/null   FOIA1611       %ZTMS1         5063,187   0  UnknownUser
       85342  /dev/null   FOIA1611       %ZTMS1         5287,214   0  UnknownUser
       85348  /dev/null   FOIA1611       %ZTMS1         5287,214   0  UnknownUser
       85354  /dev/null   FOIA1611       %ZTMS1         5177,203   0  UnknownUser
       85359  /dev/null   FOIA1611       %ZTMS1         5177,203   0  UnknownUser
       85419  /dev/null   FOIA1611       %ZTMS1         5063,187   0  UnknownUser
       85424  /dev/null   FOIA1611       %ZTMS1         5063,187   0  UnknownUser
       85430  /dev/null   FOIA1611       %ZTMS1         5063,187   0  UnknownUser
       85435  /dev/null   FOIA1611       %ZTMS1         5063,187   0  UnknownUser
       85441  /dev/null   FOIA1611       %ZTMS1         5063,187   0  UnknownUser</code></div>


GT.M:

``DO ^ZSY``. If you get not found, you can do it manually.

.. raw:: html

    <div class="code"><code>><strong>K ^XUTL("XUSYS")</strong>
    ><strong>zsy "kill -SIGUSR1 $(lsof -t ${vista_home}/g/mumps.dat)"</strong>

    ><strong>zwrite ^XUTL("XUSYS",:,"INTERRUPT")</strong>
    ^XUTL("XUSYS",81732,"INTERRUPT")="+1^GTM$DMOD"
    ^XUTL("XUSYS",81826,"INTERRUPT")="IDLE+3^%ZTM"
    ^XUTL("XUSYS",81842,"INTERRUPT")="LOOP+7^HLCSLM"
    ^XUTL("XUSYS",81847,"INTERRUPT")="GO+26^XMKPLQ"
    ^XUTL("XUSYS",81928,"INTERRUPT")="GO+12^XMTDT"
    ^XUTL("XUSYS",81932,"INTERRUPT")="STARTIN+28^HLCSIN"
    ^XUTL("XUSYS",81936,"INTERRUPT")="LOOP+2^HLCSMM1"
    ^XUTL("XUSYS",81940,"INTERRUPT")="PAUSE+1^HLUOPTF2"
    ^XUTL("XUSYS",81944,"INTERRUPT")="STARTOUT+17^HLCSOUT"
    ^XUTL("XUSYS",81948,"INTERRUPT")="LOOP+2^HLCSMM1"
    ^XUTL("XUSYS",81954,"INTERRUPT")="LOOP+2^HLCSMM1"
    ^XUTL("XUSYS",81970,"INTERRUPT")="PAUSE+1^HLUOPTF2"
    ^XUTL("XUSYS",81974,"INTERRUPT")="GO+28^XMTDL"</code></div>


Setup RPC Broker
----------------
The next step is to edit entries in the RPC Broker Site Parameters file
and the Kernel System Parameters file.  The RPC Broker steps will set up
information that references both the the Port that the listener will listen
on and the Box Volume pair of the instance.

.. raw:: html
    
    <div class="code"><code>><strong>S DUZ=.5 D Q^DI</strong>
    
    VA FileMan 22.0
    
    Select OPTION: <strong>1</strong>  ENTER OR EDIT FILE ENTRIES
    
    INPUT TO WHAT FILE: VOLUME SET// <strong>8994.1</strong>  RPC BROKER SITE PARAMETERS
                                             (1 entry)
    EDIT WHICH FIELD: ALL// <strong>LISTENER</strong>    (multiple)
        EDIT WHICH LISTENER SUB-FIELD: ALL// <strong>&lt;enter&gt;</strong>
    THEN EDIT FIELD: <strong>&lt;enter&gt;</strong>
    
    Select RPC BROKER SITE PARAMETERS DOMAIN NAME: <strong>DEMO.OSEHRA.ORG</strong>
            ...OK? Yes// <strong>Y</strong>   (Yes)
            
    Select BOX-VOLUME PAIR: // <strong>VISTA:CACHE</strong>
      BOX-VOLUME PAIR: VISTA:CACHE//
      Select PORT: <strong>9210</strong>
      Are you adding '9210' as a new PORT (the 1ST for this LISTENER)? No// <strong>Y</strong>  (Yes)
        TYPE OF LISTENER: <strong>1</strong>  New Style</code></div>

The final questions of this section asks if the listener should be started
and then if it should be controlled by the Listener starter.

The answer to these questions is dependent on the MUMPS platform that is in
use:


On Caché
********

Caché systems can use the Listener Starter to control the RPC Broker Listener.

.. raw:: html
    
    <div class="code"><code>  STATUS: STOPPED// <strong>1</strong> START
            Task: RPC Broker Listener START on VISTA-VISTA:CACHE, port 9210
            has been queued as task 1023
      CONTROLLED BY LISTENER STARTER: <strong>1</strong>  YES

    Select RPC BROKER SITE PARAMETERS DOMAIN NAME: <strong>&lt;enter&gt;</strong></code></div>

On GT.M
*******

Since GT.M systems do not use the Listener as Caché systems, we will answer
``No`` or ``0`` to both of those questions.  More information on setting up the
listener for GT.M will follow.

.. raw:: html
    
    <div class="code"><code>  STATUS: STOPPED// <strong>&lt;enter&gt;</strong>
      CONTROLLED BY LISTENER STARTER: <strong>0</strong>  No
    
    Select RPC BROKER SITE PARAMETERS DOMAIN NAME: <strong>&lt;enter&gt;</strong></code></div>

Start RPC Broker
----------------

On Caché
********

The OSEHRA setup scrpt will also start the RPC Broker Listener which
CPRS uses to communicate with the VistA instance.  These steps only happen on
platforms with a Caché instance.  They create a task for the
XWB Listener Starter that will be run when the Task Manager is started.

.. raw:: html
    
    <div class="code"><code>><strong>S DUZ=.5 D ^XUP</strong>
    
    Setting up programmer environment
    This is a TEST account.
    
    Terminal Type set to: C-VT220
    
    Select OPTION NAME: <strong>Systems Manager Menu</strong>  EVE    Systems Manager Menu
    
    
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
            
            
    You have PENDING ALERTS
            Enter  "VA to jump to VIEW ALERTS option
            
    Select Systems Manager Menu <TEST ACCOUNT> Option: <strong>Taskman Management</strong>
    
    
            Schedule/Unschedule Options
            One-time Option Queue
            Taskman Management Utilities ...
            List Tasks
            Dequeue Tasks
            Requeue Tasks
            Delete Tasks
            Print Options that are Scheduled to run
            Cleanup Task List
            Print Options Recommended for Queueing
            
            
    You have PENDING ALERTS
            Enter  "VA to jump to VIEW ALERTS option
            
    Select Taskman Management <TEST ACCOUNT> Option: <strong>Schedule/Unschedule Options</strong>
    
    Select OPTION to schedule or reschedule: <strong>XWB LISTENER STARTER</strong>    
    Start All RPC Broker Listeners
           ...OK? Yes// <strong>Y</strong>  (Yes)
        (R)
    </code></div>
    
After answering that question another ScreenMan form will open with six
options.  To have the XWB Listener Starter be run on the start up of Taskman,
enter ``STARTUP`` as the value for ``SPECIAL QEUEING``:

.. raw:: html
    
    <div class="code"><code>                        Edit Option Schedule
      Option Name: XWB LISTENER STARTER
      Menu Text: Start All RPC Broker Listeners            TASK ID:
    __________________________________________________________________________
    
      QUEUED TO RUN AT WHAT TIME:
      
    DEVICE FOR QUEUED JOB OUTPUT:
    
     QUEUED TO RUN ON VOLUME SET:
     
          RESCHEDULING FREQUENCY:
          
                 TASK PARAMETERS:
                 
          ----> SPECIAL QUEUEING:
          
    _______________________________________________________________________________
    Exit     Save     Next Page     Refresh
    
    Enter a command or '^' followed by a caption to jump to a specific field.
    
    
    COMMAND:                                      Press <PF1>H for help    Insert</code></div>

To save the information put the ScreenMan form, navigate to the ``COMMAND`` entry
point and enter ``S`` or ``Save``.  The same input location is used to exit, with
an ``E`` or ``Exit`` to leave the form.

.. raw:: html
    
    <div class="code"><code>Select OPTION to schedule or reschedule: <strong>&lt;enter&gt;</strong>
    
    
            Schedule/Unschedule Options
            One-time Option Queue
            Taskman Management Utilities ...
            List Tasks
            Dequeue Tasks
            Requeue Tasks
            Delete Tasks
            Print Options that are Scheduled to run
            Cleanup Task List
            Print Options Recommended for Queueing
            
            
    You have PENDING ALERTS
            Enter  "VA to jump to VIEW ALERTS option
            
    Select Taskman Management <TEST ACCOUNT> Option: <strong>&lt;enter&gt;</strong>
    
    Select Systems Manager Menu <TEST ACCOUNT> Option: <strong>&lt;enter&gt;</strong></code></div>






Start TaskMan
------------------------

The Task Manager is an integral part of a running VistA instance. It lets
actions and users schedule tasks to be performed at certain times or after
certain trigger events.  The XWB Listener Starter example is one example
of scheduling a task.

.. raw:: html
    
    <div class="code"><code>><strong>D ^ZTMB</strong></code></div>

Set Yourself Up as the System Manager
-------------------------------------

This is a super user who will have elevated privileges. You can add other users
such as Physicians, Pharmacists, etc. later. Set up the System Manager user
with minimal information. We will add more information later.

.. raw:: html
    
    <div class="code"><code>Select OPTION: <strong>1</strong>   ENTER OR EDIT FILE ENTRIES
    
    INPUT TO WHAT FILE: RPC BROKER PARAMETERS// <strong>200</strong>   NEW PERSON
              (2 entries)
    EDIT WHICH FIELD: ALL// <strong>.01</strong>   NAME
    THEN EDIT FIELD: <strong>ACCESS CODE</strong>   Want to edit ACCESS CODE (Y/N)
    THEN EDIT FIELD: <strong>&lt;enter&gt;</strong>
    
    Select NEW PERSON NAME: <strong>MANAGER,SYSTEM</strong>
      Are you adding 'MANAGER,SYSTEM' as a new NEW PERSON (the 3RD)? No// <strong>Y</strong>   (Yes)
    Checking SOUNDEX for matches.
    No matches found.
      NEW PERSON INITIAL: <strong>SM</strong>
      NEW PERSON MAIL CODE: <strong>&lt;enter&gt;</strong>
    Want to edit ACCESS CODE (Y/N): <strong>Y</strong>
    Enter a new ACCESS CODE <Hidden>: <strong>******</strong>
    Please re-type the new code to show that I have it right: <strong>******</strong>
    OK, Access code has been changed!
    The VERIFY CODE has been deleted as a security measure.
    The user will have to enter a new one the next time they sign-on.
    
    Select NEW PERSON NAME: <strong>&lt;enter&gt;</strong></code></div>

Next give your user privileges appropriate for a system manager.

.. raw:: html
    
    <div class="code"><code>><strong>S DUZ=1</strong>
    ><strong>S $P(^VA(200,DUZ,0),"^",4)="@"</strong>
    ><strong>D ^XUP</strong>
    
    Setting up programmer environment
    Select TERMINAL TYPE NAME: <strong>C-VT320</strong>
    Terminal Type set to: C-VT320
    
    Select OPTION NAME: <strong>XUMAINT</strong> Menu Management
    
    Select Menu Management Option: <strong>KEY</strong> Management
    
    Select Key Management Option: <strong>ALLO</strong>cation of Security Keys
    
    Allocate key: <strong>XUMGR</strong>
    
    Another key: <strong>XUPROG</strong>
       1   XUPROG
       2   XUPROGMODE
    CHOOSE 1-2: <strong>1</strong>   XUPROG
    
    Another key: <strong>XUPROGMODE</strong>
    
    Another key: <strong>XMMGR</strong>
    
    Another key:
    
    Holder of key: <strong>MANAGER,SYSTEM</strong>       SM
    
    Another holder:
    
    You've selected the following keys:
    XUPROG     XUMGR     XUPROGMODE     XMMGR
    
    You've selected the following holders:
    
    MANAGER,SYSTEM
    
    You are allocating keys. Do you wish to proceed? YES//
    
    XUPROG being assigned to:
       MANAGER,SYSTEM
       
    XUMGR being assigned to:
       MANAGER,SYSTEM
       
    XUPROGMODE being assigned to:
       MANAGER,SYSTEM
       
    XMMGR being assigned to:
       MANAGER,SYSTEM
    
    Select Key Management Option: <strong>&lt;enter&gt;</strong></code></div>


Set Up More Parameters
----------------------

These are parameters that are more applicable to the VistA application
software. If you are planning to use the VistA applications such as
Registration, Scheduling etc. you need to add new Institution to the
INSTITUTION File.

.. raw:: html
    
    <div class="code"><code>><strong>S XUMF=1 D Q^DI</strong>
    
    VA FileMan 22.0
    
    Select OPTION: <strong>1</strong>   ENTER OR EDIT FILE ENTRIES
    
    INPUT TO WHAT FILE: NEW PERSON// <strong>4</strong>   INSTITUTION (27 entries)
    EDIT WHICH FIELD: ALL// <strong>STATION NUMBER</strong>
    THEN EDIT FIELD: <strong>&lt;enter&gt;</strong>
    
    Select INSTITUTION NAME: <strong>VISTA HEALTH CARE</strong>
      Are you adding 'VISTA HEALTH CARE' as a new INSTITUTION (the 28TH)? No// <strong>Y</strong>   (Yes)
    STATION NUMBER: <strong>6100</strong>
    
    Select INSTITUTION NAME:<strong>&lt;enter&gt;</strong></code></div>

Then you need to add a Medical Center Division.

.. raw:: html
    
    <div class="code"><code>Select OPTION: <strong>1</strong>   ENTER OR EDIT FILE ENTRIES
    
    INPUT TO WHAT FILE: INSTITUTION// <strong>40.8</strong>   MEDICAL CENTER DIVISION (1 entry)
    EDIT WHICH FIELD: ALL// <strong>FACILITY NUMBER</strong>
    THEN EDIT FIELD: <strong>INSTITUTION FILE POINTER</strong>
    THEN EDIT FIELD: <strong>&lt;enter&gt;</strong>
    
    Select MEDICAL CENTER DIVISION NAME: <strong>VISTA MEDICAL CENTER</strong>
       Are you adding 'VISTA MEDICAL CENTER' as
       a new MEDICAL CENTER DIVISION (the 2ND)? No// <strong>Y</strong>   (Yes)
       MEDICAL CENTER DIVISION NUM: 2// <strong>&lt;enter&gt;</strong>
       MEDICAL CENTER DIVISION FACILITY NUMBER: <strong>6100A</strong>
    FACILITY NUMBER: 6100A//v<strong>&lt;enter&gt;</strong>
    INSTITUTION FILE POINTER:<strong> VISTA HEALTH CARE</strong>    6100
    
    Select MEDICAL CENTER DIVISION NAME: <strong>&lt;enter&gt;</strong></code></div>

You are now ready to enter additional information for the system manager user
like PRIMARY MENU, VERIFY CODE etc.

.. raw:: html
    
    <div class="code"><code>><strong>D ^XUP</strong>
    
    Setting up programmer environment
    Terminal Type set to: C-VT320
    
    Select OPTION NAME: <strong>XUSERED</strong>
        1   XUSEREDIT   Edit an Existing User
        2   XUSEREDITSELF   Edit User Characteristics
    CHOOSE 1-2: <strong>1</strong> XUSEREDIT  Edit an Existing User
    Edit an Existing User
    Select NEW PERSON NAME: <strong>MANAGER,SYSTEM</strong>    SM</code></div>

Now you will be presented with a screen with multiple options. You can navigate
the screen with the TAB key. For navigation help, use your keyboard arrows to
move down to the command line and hold down either the Num Lock key (which is
mapped as PF1 of a VT-320 terminal by Caché) or F1 for other terminal
emulations and hit "H" and then Enter for help. You can exit by typing "^" on
the command line and the change you made will be saved. At a minimum, assign
EVE as the PRIMARY MENU and enter IRM (it's the only choice) as
SERVICE/SECTION. If you plan to use CPRS, enter OR CPRS GUI CHART as a
SECONDARY MENU OPTION. Enter other data as you deem appropriate.

.. figure::
   images/InitializeVistA/pic25.gif
   :align: center
   :alt:  Edit an existing user 1

Type "N"EXT PAGE at COMMAND: to go to page 2 to update the TIMED READ field and
other fields you wish to update. For DEFAULT TIMED-READ (SECONDS): if you
change it to 3600 you will be allow an hour before being automatically signed
off. It makes it easier to work when you are learning and setting things up.

Press <PF1> refers to notations for use of Vista on Terminals. For example, the
original VT-320 keyboard had additional character sets and keys which include
Find, Select, Insert, Remove, Previous Screen, Next Screen, an arrow cluster
and F1 to F20. With Caché, the Keys are "mapped", which means when you push a
given key it acts as the key would in a terminal. For instance, F1, F2, F3 and
F4 are equivalent to the PF1, PF2, PF3 and PF4 keys on the terminal keyboard
and Page Up and Page Down on the computer keyboard correspond to Previous
Screen and Next Screen. A listing of other mappings can be found at the Caché
Cube Terminal window under Help and search Keyboard Mappings. Also there is
lots of information about terminal if you are interested at www.VT100.net.

.. figure::
   images/InitializeVistA/pic26.gif
   :align: center
   :alt:  Edit an existing user 1

Set Up Menus for the System Manager
-----------------------------------

EVE is the System Manager menu and XUCOMMAND is a common menu available to all
users.

The next step is to make FileMan, MailMan, and Manage MailMan menus accessible
to the System Manager user from the menu system. From the VISTA prompt, type ``D
^XUP``. At Select OPTION NAME: enter ``XUMAINT``. Then at Select Menu Management,
type ``EDIT OPTIONS``, then pick ``EVE``.

.. raw:: html
    
    <div class="code"><code>Select OPTION to edit: <strong>XUCOMMAND</strong>     SYSTEM COMMAND OPTIONS
    NAME: XUCOMMAND// <strong>^10</strong>   MENU
    Select ITEM: XQALERT// <strong>XMUSER</strong>   MailMan Menu
      Are you adding 'XMUSER' as a new MENU (the 8TH for this OPTION)? No// <strong>Y</strong>   (Yes)
      MENU SYNONYM: <strong>MM</strong>
      SYNONYM: MM// <strong>&lt;enter&gt;</strong>
      DISPLAY ORDER: <strong>&lt;enter&gt;</strong>
    Select ITEM: <strong>&lt;enter&gt;</strong>
    CREATOR: MANAGER,SYSTEM// <strong>^</strong>
    
    Select OPTION to edit:</code></div>

Change the default time it takes before users are automatically signed off
the system from the default of 300 seconds. This, again, is to give you more
time to work as you are learning. Back out to the VISTA prompt. At the VISTA
prompt, Type ``D ^ZU``.

At ACCESS CODE, type in the code you chose when setting up MANAGER, SYSTEM as a
NEW PERSON. At VERIFY CODE, hit ENTER. When asked for a new verify code, type the code you
choose and remember it.

At Select Systems Manager Menu Option: Type ``OPER``, (short for operations
management) and hit enter. You can see all of the choices available to you if
you type ``??``.

At Select Operations Management Option: Type ``KER`` short for Kernel Management
Menu and hit enter. At Select Kernel Management Menu Option: Type ``ENT``, short
for Enter/Edit Kernel Site Parameters. Hit enter.

You will be presented with a similar screen as in editing the SYSTEM MANAGER
characteristics. You can navigate the screen with the ``TAB`` key. For DEFAULT
TIMED-READ (SECONDS): change it to ``3600`` to allow an hour before being
automatically signed off, or whatever you choose.

.. figure::
   images/InitializeVistA/pic27.gif
   :align: center
   :alt: Kernel Parameters

Update the Devices, Start Taskman and Mail a Message
----------------------------------------------------

These are basic devices to complete the setup. You can setup other devices,
such as printers, later. The Platinum CACHE.DAT already comes with
preconfigured devices. It is best to leave the VOLUME SET(CPU) field blank. The
help text for the field states: "If no name has been entered for this field,
this device is assumed to be accessible from all CPUs in the network. In other
words, when this device is referenced, the device handler will operate as if
this device is resident on the local CPU". The SIGN-ON/SYSTEM DEVICE: field
should be set to ``NO`` or left blank for output devices and ``YES`` if the
device isused to log on to the system. Use FileMan to edit the CONSOLE, NULL,
HFS, and TELNET devices. CONSOLE is the primary logon device. The NULL device
is used by the Vista RPC Broker and HFS is used by the Kernel Installation and
Distribution System (KIDS) to install application patches and new applications
when they are released. On the single user Caché PC you will not need the
TELNET device since it does not allow remote access.

.. raw:: html
    
    <div class="code"><code>><strong>D Q^DI</strong>
    
    VA FileMan 22.0
    
    Select OPTION: <strong>1</strong>   ENTER OR EDIT FILE ENTRIES
    
    INPUT TO WHAT FILE: PACKAGE// <strong>3.5</strong>   DEVICE (35 entries)
    EDIT WHICH FIELD: ALL// <strong>&lt;enter&gt;</strong>
    
    Select DEVICE NAME: <strong>CONSOLE</strong>     CONSOLE |TRM|
    NAME: CONSOLE// <strong>&lt;enter&gt;</strong>
    LOCATION OF TERMINAL: CONSOLE// <strong>&lt;enter&gt;</strong>
    Select MNEMONIC: <strong>&lt;enter&gt;</strong>
    LOCAL SYNONYM: <strong>&lt;enter&gt;</strong>
    $I: |TRM|// <strong>&lt;enter&gt;</strong>
    VOLUME SET(CPU): <strong>&lt;enter&gt;</strong>
    SIGN-ON/SYSTEM DEVICE: <strong>Y</strong>   YES
    TYPE: VIRTUAL TERMINAL// <strong>&lt;enter&gt;</strong>
    SUBTYPE: C-VT320// <strong>^</strong>
    
    Select DEVICE NAME: <strong>TELNET</strong>     TELNET |TNT| VISTA
    NAME: TELNET// <strong>&lt;enter&gt;</strong>
    LOCATION OF TERMINAL: TELNET// <strong>&lt;enter&gt;</strong>
    Select MNEMONIC: <strong>&lt;enter&gt;</strong>
    LOCAL SYNONYM: <strong>&lt;enter&gt;</strong>
    $I: |TNT|// <strong>&lt;enter&gt;</strong>
    VOLUME SET(CPU): VISTA// <strong>@</strong>
      SURE YOU WANT TO DELETE? <strong>Y</strong>   (Yes)
    SIGN-ON/SYSTEM DEVICE: <strong>Y</strong>   YES
    TYPE: VIRTUAL TERMINAL// <strong>&lt;enter&gt;</strong>
    SUBTYPE: C-VT320// <strong>^</strong>
    
    Select DEVICE NAME: <strong>HFS</strong>     Host File Server C:\PLATINUM\TMP.DAT
    NAME: HFS// <strong>&lt;enter&gt;</strong>
    LOCATION OF TERMINAL: Host File Server// <strong>&lt;enter&gt;</strong>
    Select MNEMONIC: <strong>&lt;enter&gt;</strong>
    LOCAL SYNONYM: <strong>&lt;enter&gt;</strong>
    $I: C:\PLATINUM\TMP.DAT// <strong>C:\TEMP\TMP.TXT</strong>
    VOLUME SET(CPU): <strong>&lt;enter&gt;</strong>
    SIGN-ON/SYSTEM DEVICE: <strong>^</strong>
    
    Select DEVICE NAME: NULL
        1   NULL     NT SYSTEM NALO:
        2   NULL-DSM     Bit Bucket _NLA0:
    CHOOSE 1-2: <strong>1</strong>   NULL     NT SYSTEM     NALO: 
    NAME: NULL// <strong>&lt;enter&gt;</strong>
    LOCATION OF TERMINAL: NT SYSTEM// <strong>&lt;enter&gt;</strong>
    Select MNEMONIC: <strong>&lt;enter&gt;</strong>
    LOCAL SYNONYM: <strong>&lt;enter&gt;</strong>
    $I: NALO:// <strong>//./nul</strong>
    VOLUME SET(CPU): <strong>&lt;enter&gt;</strong>
    SIGN-ON/SYSTEM DEVICE: YES// <strong>N</strong>   NO
    TYPE: TERMINAL// <strong>&lt;enter&gt;</strong>
    SUBTYPE: C-VT320// <strong>^</strong>
    
    Select DEVICE NAME: <strong>&lt;enter&gt;</strong><code></div>

Again from the VISTA promt, enter ``D ^ZTMCHK`` to check if TaskMan's environment
is OK. This will present you with two screens with information on TaskMan's
environment.

.. figure::
   images/InitializeVistA/pic28.gif
   :align: center
   :alt: Check TaskMan Environment 1

Screen #1

.. figure::
   images/InitializeVistA/pic29.gif
   :align: center
   :alt: Check TaskMan Environment 2

Screen #2

If TaskMan's environment is OK, you are ready to start TaskMan. Go back to the
VISTA prompt and type ``D ^ZTMB`` to start TASKMAN.

To monitor TaskMan, enter ``D ^ZTMON`` from the VISTA prompt. Enter ``^`` at the
UPDATE// prompt to exit the monitor or enter a ``?`` to see what the other
options are.

.. figure::
   images/InitializeVistA/pic30.gif
   :align: center
   :alt: Monitor Taskman

From the > programmer prompt you can check the system status with ``D ^%SS``. You
should see at least two Taskman processes - %ZTM and %ZTMS.

.. figure::
   images/InitializeVistA/pic31.gif
   :align: center
   :alt: System Status with TM

Now send a message using Postmaster to your DUZ number. Use D ^%CD to get into
the namespace, VISTA, and then type ``S DUZ=.5 D ^XUP``. You will get the
response SETTING UP PROGRAMMER ENVIROMENT then TERMINAL TYPE SET TO: (your
default) and Select OPTION NAME:. You will need to respond: ``XMUSER``. At Select
Mailman Menu Option: type ``S`` (for send). At Subject: enter your subject, such
as Test, and then hit enter. You will then be prompted You may enter the text
of the message and you will be offered the line number 1> where you can type
your message, such as the infamous Hello world. Next will be line 2> and if you
are done, just hit enter and at EDIT Option: you can do the same. At Send mail
to: POSTMASTER// enter the initials you used for your DUZ which were probably
SM for System Manager. You will then be told when MailMan was last used, which
is probably NEVER. Hit enter at And Send to: and you should receive the message
Select Message option: Transmit now// at which you hit enter and will hopefully
receive the message Sending [1] Sent. Type ``^`` to exit.

Now see if you received it. Log on using ``D ^ZU``. At the Systems Manager
prompt, type ``MAIL``. Then at the Select MailMan Menu Option: type ``NEW``
Messages and Responses. Read the mail.

.. figure::
   images/InitializeVistA/pic32.gif
   :align: center
   :alt: Read Mail

Start and test the RPC Broker.

The RPC Broker is VistA's Client/Server software and is needed by VistA's GUI client.

Now to see of the RPC BROKER will start. To start the broker, type ``D
STRT^XWBTCP(port)`` at the VISTA prompt. The system status should now show the
broker listener (XWBTCPL) running.

.. raw:: html
    
    <div class="code"><code>><strong>D STRT^XWBTCP(9210)</strong>
    Start TCP Listener...
    Checking if TCP Listener has started...
    TCP Listener started successfully.
    ></code></div>

Now run ``D ^%SS`` again. You should see something like the following with XWBPTCL running.

.. figure::
   images/InitializeVistA/pic33.gif
   :align: center
   :alt: Broker

If you have the RPCTEST.EXT on your workstation, you test your connection to
the localhost. Download the file XWB1_1WS.EXE from
ftp://ftp.va.gov/vista/Software/Packages/RPC%20Broker%20-%20XWB/PROGRAMS/. (Note: The
VA's ftp site is not compatible with Netscape's ftp. Either use Windows
Explorer or FTP software). Double click on this file once you have downloaded
it. Accept the defaults. It will install RPC Broker's Client software including
RPCTEST.EXE. Then go to C:\program files\vista\broker\rcptest.exe and double
click on it or create a shortcut on your desktop.

.. figure::
   images/InitializeVistA/pic34.gif
   :align: center
   :alt: RPC Test

You should see a Vista logon screen.

.. figure::
   images/InitializeVistA/pic35.gif
   :align: center
   :alt: VistA Logon

If you connect successfully, the link state will turn green.

.. figure::
   images/InitializeVistA/pic36.gif
   :align: center
   :alt: Broker Connect

To stop TaskMan, use ``D STOP^ZTMKU`` and answer ``YES`` to stopping the submanagers.

To stop Broker, use ``D STOP^XWBTCP(9210)``. This is the last time you should be
using these direct access to the routines to manage VistA. You should be using
the menu system from now on to manage starting and stopping Taskman, the
background filers and the RPC Broker. That way any code changes, etc., will be
accounted for. Programmers will usually enter from the programmer prompt
beginning with D ^XUP. The system managers menu option is EVE.

Add User
--------

The next step is to create a user that can sign on to the CPRS GUI.
The things to make sure that this new user has are

* A Secondary menu option of "OR CPRS GUI CHART"
* CPRS Tab Access
* An ACCESS CODE
* A VERIFY CODE
* Service/Section (required for any user)

The menu option ensures that the user has the proper permissions to access
CPRS after signing in with their ACCESS and VERIFY codes.  The Tab access
can limit the amount of things a user can access once they have signed in.

The adding of the user is done through the User Management menu in the
menu system, which will ask for information in a series of prompts then will
open a Screenman form to complete the task.

The following steps will add a generic ``CPRS,USER`` person who will be able to
sign into CPRS.

.. raw:: html
    
    <div class="code"><code>><strong>S DUZ=.5 D ^XUP</strong>
    
    Setting up programmer environment
    This is a TEST account.
    
    Terminal Type set to: C-VT320
    
    Select OPTION NAME:  <strong>Systems Manager Menu</strong>
    
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
            
            
    You have PENDING ALERTS
            Enter  "VA to jump to VIEW ALERTS option
            
    Select Systems Manager Menu <TEST ACCOUNT> Option: <strong>User Management</strong>
    
            Add a New User to the System
            Grant Access by Profile
            Edit an Existing User
            Deactivate a User
            Reactivate a User
            List users
            User Inquiry
            Switch Identities
            File Access Security ...
               \**> Out of order:  ACCESS DISABLED
            Clear Electronic signature code
            Electronic Signature Block Edit
            List Inactive Person Class Users
            Manage User File ...
            OAA Trainee Registration Menu ...
            Person Class Edit
            Reprint Access agreement letter
            
            
    You have PENDING ALERTS
            Enter  "VA to jump to VIEW ALERTS option
            
    Select User Management <TEST ACCOUNT> Option: <strong>Add a New User to the System</strong>
    Enter NEW PERSON's name (Family,Given Middle Suffix): <strong>CPRS,USER</strong>
      Are you adding 'CPRS,USER' as a new NEW PERSON (the 56TH)? No// <strong>Y</strong>  (Yes)
    Checking SOUNDEX for matches.
    No matches found.
    Now for the Identifiers.
    INITIAL: <strong>UC</strong>
    SSN: <strong>000000002</strong>
    SEX: <strong>M</strong>  MALE
    NPI: <strong>&lt;enter&gt;</strong></code></div>

Once in the ScreenMan form, you will need to set the necessary
information mentioned above. Four pieces of information are able to be set
on the first page of the ScreenMan form.  The arrows are for emphasis to
highlight where information needs to be entered and will not show up in the
terminal window.

To add an access or verify codes, you need to first answer ``Y`` to the
``Want to edit ...`` questions, it will then prompt you to change the codes.

.. raw:: html
    
    <div class="code"><code>                            Edit an Existing User
    NAME: CPRS,USER                                                     Page 1 of 5
    _______________________________________________________________________________
       NAME... CPRS,USER                                   INITIAL: UC
        TITLE:                                           NICK NAME:
          SSN: 000000002                                       DOB:
       DEGREE:                                           MAIL CODE:
      DISUSER:                                     TERMINATION DATE:
      Termination Reason:
      
               PRIMARY MENU OPTION:
     Select SECONDARY MENU OPTIONS:   <---
    Want to edit ACCESS CODE (Y/N):   <---  FILE MANAGER ACCESS CODE:
    Want to edit VERIFY CODE (Y/N):   <---
    
                  Select DIVISION:
             ---> SERVICE/SECTION:
    _______________________________________________________________________________
     Exit     Save     Next Page     Refresh
     
    Enter a command or '^' followed by a caption to jump to a specific field.
    
    
    COMMAND:                                     Press <PF1>H for help    Insert</code></div>

To change to other pages, press the down arrow key or <TAB> until the cursor
reaches the COMMAND box.  Then type ``N`` or ``Next Page`` and press &lt;enter&gt; to
display the next page.

There is nothing that needs to be set on the second or third pages, but the
CPRS Tab Access is set on the fourth page. Navigate the cursor to the location
under the ``Name`` header and enter ``COR``, which stands ``for Core Tab Access``,
and enter an effective date of yesterday, ``T-1`` is the notation to use.

.. raw:: html
    
    <div class="code"><code>                            Edit an Existing User
    NAME: CPRS,USER                                                     Page 4 of 5
    _______________________________________________________________________________
    RESTRICT PATIENT SELECTION:        OE/RR LIST:
    
    CPRS TAB ACCESS:
      Name  Description                          Effective Date  Expiration Date
    ->
    
    
    
    
    
    
    
    
    _______________________________________________________________________________
    
    
    
    
    
    COMMAND:                                       Press <PF1>H for help</code></div>

Once that is done, save and exit the ScreenMan form via the COMMAND box and
then answer the final questions regarding access letters, security keys
and mail groups:

.. raw:: html
    
    <div class="code"><code>Exit     Save     Next Page     Refresh
    
    Enter a command or '^' followed by a caption to jump to a specific field.
    
    
    COMMAND: <strong>E</strong>                                     Press <PF1>H for help    Insert
    
    Print User Account Access Letter? <strong>NO</strong>
    Do you wish to allocate security keys? NO// <strong>NO</strong>
    Do you wish to add this user to mail groups? NO// <strong>NO</strong>
    
    ...
    
    Select User Management <TEST ACCOUNT> Option: <strong>^&lt;enter&gt;</strong>
    ></code></div>

At this point, CPRS can successfully connect to the local VistA instance and
the ``CPRS,USER`` will be able to sign on and interact with the GUI.
