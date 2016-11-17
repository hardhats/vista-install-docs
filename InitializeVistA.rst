VistA Initialization
====================

Device Configuration
--------------------

NOTE Always use VT-220 or VT-320

NOTE Page up and page down don't work on Linux

There should only be one device named "NULL".

.. raw:: html
    
    <code>><strong>D Q^DI</strong>
    
    MSC Fileman 22.2
    
    Select OPTION: <strong>1</strong>  ENTER OR EDIT FILE ENTRIES
    
    Input to what File: DEVICE// <strong>&lt;enter&gt;</strong>             (53 entries)
    EDIT WHICH FIELD: ALL// <strong>&lt;enter&gt;</strong>
    
    Select DEVICE NAME: NULL
         1   NULL      NT SYSTEM     /dev/null     
         2   NULL  GTM-UNIX-NULL    Bit Bucket (GT.M-Unix)     /dev/null     
         3   NULL-DSM      Bit Bucket     _NLA0:     
    CHOOSE 1-3: <strong>1</strong>  NULL    NT SYSTEM     /dev/null     
    NAME: NULL// <strong>NT-NULL</strong>
    LOCATION OF TERMINAL: NT SYSTEM// <strong>^</strong>
    
    Select DEVICE NAME: <strong>NULL</strong>
         1   NULL  GTM-UNIX-NULL    Bit Bucket (GT.M-Unix)     /dev/null     
         2   NULL-DSM      Bit Bucket     _NLA0:     
    CHOOSE 1-2: 2  NULL-DSM    Bit Bucket     _NLA0:     
    NAME: NULL-DSM// <strong>DSM-NULL</strong>
    LOCATION OF TERMINAL: Bit Bucket// <strong>^</strong>
    
    Select DEVICE NAME: <strong>NULL</strong>  GTM-UNIX-NULL    Bit Bucket (GT.M-Unix)     /dev/null 
    
    NAME: GTM-UNIX-NULL// <strong>NULL</strong>
    LOCATION OF TERMINAL: Bit Bucket (GT.M-Unix)  Replace 
    Select MNEMONIC: NULL// <strong>@</strong>
       SURE YOU WANT TO DELETE? <strong>Y</strong>  (Yes)
    Select MNEMONIC: GTM-LINUX-NULL// <strong>@</strong>
       SURE YOU WANT TO DELETE? <strong>Y</strong>  (Yes)
    Select MNEMONIC: 
    LOCAL SYNONYM: <strong>^</strong></code>
    
    Select DEVICE NAME: <strong>&lt;enter&gt;</strong></code>

CPRS is one of many users of the VistA NULL device, but the ``$I`` value, which
contains the name or path to the device, is correct only for a VMS platform.
It is necessary to change it to match the local platform before it is able
to be accessed correctly.  The Sign-On capability also needs to be removed from
the device.

.. raw:: html
    
    <code>Select OPTION: <strong>1</strong>  ENTER OR EDIT FILE ENTRIES
    
    Input to what File: DEVICE// <strong>&lt;enter&gt;</strong>             (53 entries)
    EDIT WHICH FIELD: ALL// <strong>$I</strong>  
    THEN EDIT FIELD: <strong>SIGN-ON/SYSTEM DEVICE</strong>  
    THEN EDIT FIELD: <strong>&lt;enter&gt;</strong>
    
    Select DEVICE NAME: NULL      Bit Bucket (GT.M-Unix)     /dev/null</code>

On Windows
**********

On Windows machines, the ``$I`` value should be set to ``//./nul``.

.. raw:: html
    
    <code>$I: NLA0:// <strong>//./nul</strong>
    SIGN-ON/SYSTEM DEVICE: NO// N  NO
    
    Select DEVICE NAME: <strong>&lt;enter&gt;</strong></code>

On Linux
********

On Linux machines, the ``$I`` value should be set to ``/dev/null``.

.. raw:: html
    
    <code>$I: /dev/null// /dev/null
    SIGN-ON/SYSTEM DEVICE: NO// N  NO
    
    Select DEVICE NAME: <strong>&lt;enter&gt;</strong></code>

Remote Instance Domain Name Creation
------------------------------------

To send messages to Q-PATCH.OSEHRA.ORG from your own VISTA system, you can send
it via the internet by setting up postfix and having it do the work for you (as
above). An easier alternative is to configure a direct link, as follows: (NB:
This example is only for GT.M. Use the Cache Mailman Conduits for Cache.) To
send HFS checksum messages (for packages exported via HFS) you need to create
FORUM.OSEHRA.ORG.

.. raw:: html
    
    <code>><strong>D Q^DI</strong>
    
    MSC Fileman 22.2
    
    Select OPTION: <strong>1</strong>  ENTER OR EDIT FILE ENTRIES
    
    Input to what File: DEVICE// <strong>DOMAIN</strong>       (89 entries)
    EDIT WHICH FIELD: ALL// <strong>&lt;enter&gt;</strong>
    
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
    ></code>

Instance Domain
---------------

Next, a domain should be set up for the VistA instance.  A domain name is
typically used to uniquely identify an instance on a network.  While this
is not necessary to do for test instances, it is recommended that a new domain
be added.  The OSEHRA script adds a domain called ``DEMO.OSEHRA.ORG``, and this
example will do the same.

First we add the entry to the ``DOMAIN`` file through FileMan.

.. raw:: html
    
    <code>> <strong>S DUZ=.5 D Q^DI</strong>
    
    VA FileMan 22.0
    
    Select OPTION: <strong>1</strong>  ENTER OR EDIT FILE ENTRIES
    
    INPUT TO WHAT FILE: // <strong>DOMAIN</strong>
                                         (70 entries)
    EDIT WHICH FIELD: ALL// <strong>ALL</strong>
    
    Select DOMAIN NAME: <strong>DEMO.OSEHRA.ORG</strong>
      Are you adding 'DEMO.OSEHRA.ORG' as a new DOMAIN (the 71ST)? No// <strong>Y</strong>  (Yes)
    FLAGS: <strong>^</strong>
    
    Select DOMAIN NAME: <strong>&lt;enter&gt;</strong>
    
    Select OPTION: <strong>&lt;enter&gt;</strong>
    ></code>

The next step is to find the IEN of the newly created domain. This can be done
by inquiring about the entry using FileMan and printing the Record Number:

.. raw:: html
    
    <code>> <strong>S DUZ=.5 D Q^DI</strong>
    
    VA FileMan 22.0
    
    Select OPTION: <strong>5</strong>  INQUIRE TO FILE ENTRIES
    
    OUTPUT FROM WHAT FILE: DOMAIN// <strong>DOMAIN</strong>   (71 entries)
    Select DOMAIN NAME: <strong>DEMO.OSEHRA.ORG</strong>
    ANOTHER ONE: <strong>&lt;enter&gt;</strong>
    STANDARD CAPTIONED OUTPUT? Yes// <strong>Y</strong>  (Yes)
    Include COMPUTED fields:  (N/Y/R/B): NO// <strong>Record Number (IEN)</strong>
    
    NUMBER: 76                              NAME: DEMO.OSEHRA.ORG
    
    Select DOMAIN NAME: <strong>^</strong>
    
    Select OPTION: <strong>^</strong>
    ></code>

Then we propogate that entry to the ``Kernel System Parameters`` and
``RPC Broker Site Parameters`` files.  The value that is being set should
be the same as the ``NUMBER`` value from the above result.

.. raw:: html

    <code>> <strong>S $P(^XWB(8994.1,1,0),"^")=76</strong>
    > <strong>S $P(^XTV(8989.3,1,0),"^")=76</strong></code>

Re-index the files after making this change.

.. raw:: html
    
    <code>><strong>F DIK="^XTV(8989.3,","^XWB(8994.1," S DA=1 D IXALL2^DIK,IXALL^DIK</strong></code>

Christening
-----------

System is christened using menu option XMCHIRS with FORUM.OSEHRA.ORG as the parent.

.. raw:: html
    
    <code>><strong>S DUZ=.5 D ^XUP</strong>
    
    Setting up programmer environment
    This is a TEST account.
    
    Terminal Type set to: C-VT320
    
    Select OPTION NAME: <strong>XMCHRIS</strong>       Christen a domain
    Christen a domain
    
             * * * *  WARNING  * * * *
    
    You are about to change the domain name of this facility
    in the MailMan Site Parameters file.
    
    Currently, this facility is named: ANDRONICUS.VISTAEXPERTISE.NET
    
    You must be extremely sure before you proceed!
    
    Are you sure you want to change the name of this facility? NO// <strong>YES</strong>
    Select DOMAIN NAME: ANDRONICUS.VISTAEXPERTISE.NET//   
    
    The domain name for this facility remains: ANDRONICUS.VISTAEXPERTISE.NET
    PARENT: DOMAIN.EXT// <strong>FORUM.OSEHRA.ORG</strong>
    TIME ZONE: EST// <strong>PST</strong>       PACIFIC STANDARD
    
    FORUM.OSEHRA.ORG has been initialized as your 'parent' domain.
    (Forum is usually the parent domain, unless this is a subordinate domain.)
    
    You may edit the MailMan Site Parameter file to change your parent domain.
    
    We will not initialize your transmission scripts.
    
    Use the 'Subroutine editor' option under network management menu to add your
    site passwords to the MINIENGINE script, and the 'Edit a script' option
    to edit any domain scripts that you choose to.
    ></code>


Set Box-Volume pair
-------------------

The first step is to find the box volume pair for the local machine.

.. raw:: html
    
    <code>> <strong>D GETENV^%ZOSV W Y</strong></code>

which will print out a message with four parts separated by ``^`` that could
look something like:

.. raw:: html
    
    <code>VISTA^VISTA^palaven^VISTA:CACHE</code>

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

For this demonstration instance, the Volume Set will be ``VISTA`` which is the
Caché namespace that holds the files.  On GT.M instances, the default value of
``PLA`` can be maintained.


.. raw:: html

    <code>> <strong>S DUZ=.5 D Q^DI</strong>


    VA FileMan 22.0

    Select OPTION: <strong>1</strong>  ENTER OR EDIT FILE ENTRIES

    INPUT TO WHAT FILE: DEVICE// <strong>14.5</strong>  VOLUME SET  (1 entry)
    EDIT WHICH FIELD: ALL// <strong>VOLUME SET</strong>
    THEN EDIT FIELD: <strong>TASKMAN FILES UCI</strong>
    THEN EDIT FIELD: <strong>&lt;enter&gt;</strong>


    Select VOLUME SET: <strong>&#96;1</strong>  PLA
    VOLUME SET: PLA// <strong>VISTA</strong>
    TASKMAN FILES UCI: PLA// <strong>VISTA</strong>


    Select VOLUME SET: <strong>&lt;enter&gt;</strong>


    INPUT TO WHAT FILE: TASKMAN SITE PARAMETERS// <strong>14.7</strong>  TASKMAN SITE PARAMETERS
                                          (1 entry)
    EDIT WHICH FIELD: ALL// <strong>&lt;enter&gt;</strong>


    Select TASKMAN SITE PARAMETERS BOX-VOLUME PAIR: <strong>\&#96;1</strong>  PLA:PLAISCSVR
    BOX-VOLUME PAIR: PLA:PLAISCSVR// <strong>VISTA:CACHE</strong>
    RESERVED: <strong>^</strong>


    Select TASKMAN SITE PARAMETERS BOX-VOLUME PAIR: <strong>&lt;enter&gt;</strong>
    Select OPTION: <strong>&lt;enter&gt;</strong></code>

Next, Edit the ``Kernel System Parameters`` file to add the new Volume Set to
the ``DEMO.OSEHRA.ORG`` domain and set some constraints about signing on.

.. raw:: html

    <code>Select OPTION: <strong>1</strong>  ENTER OR EDIT FILE ENTRIES



    INPUT TO WHAT FILE: RPC BROKER SITE PARAMETERS// <strong>KERNEL SYSTEM PARAMETERS</strong>
                                          (1 entry)
    EDIT WHICH FIELD: ALL// <strong>VOLUME SET</strong>    (multiple)
      EDIT WHICH VOLUME SET SUB-FIELD: ALL// <strong>&lt;enter&gt;</strong>
    THEN EDIT FIELD: <strong>&lt;enter&gt;</strong>


    Select KERNEL SYSTEM PARAMETERS DOMAIN NAME: <strong>DEMO.OSEHRA.ORG</strong>
         ...OK? Yes// <strong>Y</strong> (Yes)

    Select VOLUME SET: PLA// <strong>VISTA</strong>
      Are you adding 'VISTA' as a new VOLUME SET (the 2ND for this KERNEL SYSTEM PARAMETERS)? No// <strong>Y</strong>
      (Yes)
      MAX SIGNON ALLOWED: <strong>500</strong>
      LOG SYSTEM RT?: <strong>N</strong>  NO
    Select VOLUME SET: <strong>&lt;enter&gt;</strong>


    Select KERNEL SYSTEM PARAMETERS DOMAIN NAME: <strong>&lt;enter&gt;</strong>

    Select OPTION: <strong>&lt;enter&gt;</strong></code>

Setup RPC Broker
----------------

The next step is to edit entries in the ``RPC Broker Site Parameters`` file
and the ``Kernel System Parameters`` file.  The RPC Broker steps will set up
information that references both the the Port that the listener will listen
on and the Box Volume pair of the instance.

.. raw:: html

    <code>> <strong>S DUZ=.5 D Q^DI</strong>


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
        TYPE OF LISTENER: <strong>1</strong>  New Style</code>

The final questions of this section asks if the listener should be started
and then if it should be controlled by the Listener starter.

The answer to these questions is dependent on the MUMPS platform that is in
use:


On Caché
********

Caché systems can use the Listener Starter to control the RPC Broker Listener.

.. raw:: html

    <code>  STATUS: STOPPED// <strong>1</strong> START
            Task: RPC Broker Listener START on VISTA-VISTA:CACHE, port 9210
            has been queued as task 1023
      CONTROLLED BY LISTENER STARTER: <strong>1</strong>  YES

    Select RPC BROKER SITE PARAMETERS DOMAIN NAME: <strong>&lt;enter&gt;</strong>
    </code>

On GT.M
*******

Since GT.M systems do not use the Listener as Caché systems, we will answer
"No" or "0" to both of those questions.  More information on setting up the
listener for GT.M will follow.

.. raw:: html

    <code>  STATUS: STOPPED// <strong>&lt;enter&gt;</strong>
      CONTROLLED BY LISTENER STARTER: <strong>0</strong>  No

    Select RPC BROKER SITE PARAMETERS DOMAIN NAME: <strong>&lt;enter&gt;</strong>
    </code>

Start RPC Broker
----------------

On Caché
********

The OSEHRA setup scrpt will also start the RPC Broker Listener which
CPRS uses to communicate with the VistA instance.  These steps only happen on
platforms with a Caché instance.  They create a task for the
XWB Listener Starter that will be run when the Task Manager is started.

.. raw:: html

    <code>> <strong>S DUZ=.5 D ^XUP</strong>
    
    Setting up programmer environment
    This is a TEST account.
    
    Terminal Type set to: C-VT220
    
    Select OPTION NAME: <strong>Systems Manager Menu</strong>  EVE     Systems Manager Menu
    
    
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
    
    Select OPTION to schedule or reschedule: <strong>XWB LISTENER STARTER</strong>       Start All RP
    C Broker Listeners
           ...OK? Yes// <strong>Y</strong>  (Yes)
        (R)
    </code>
    
After answering that question another ScreenMan form will open with six
options.  To have the XWB Listener Starter be run on the start up of Taskman,
enter ``STARTUP`` as the value for ``SPECIAL QEUEING``:

.. raw:: html

    <code>                        Edit Option Schedule
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


    COMMAND:                                      Press <PF1>H for help    Insert</code>

To save the information put the ScreenMan form, navigate to the ``COMMAND`` entry
point and enter ``S`` or ``Save``.  The same input location is used to exit, with
an ``E`` or ``Exit`` to leave the form.

.. raw:: html

    <code>Select OPTION to schedule or reschedule: <strong>&lt;enter&gt;</strong
    
    
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
    
    Select Systems Manager Menu <TEST ACCOUNT> Option: <strong>&lt;enter&gt;</strong></code>


On GT.M
*******

TODO Replace use of xinetd with Sam's native solution!!!


Start TaskMan
------------------------

The Task Manager is an integral part of a running VistA instance. It lets
actions and users schedule tasks to be performed at certain times or after
certain trigger events.  The XWB Listener Starter example is one example
of scheduling a task.

The OSEHRA script uses the ``TaskMan Management Utilities`` menu to control
TaskMan:

.. raw:: html

    <code>> <strong>S DUZ=.5 D ^XUP</strong>

    Setting up programmer environment
    This is a TEST account.

    Terminal Type set to: C-VT220

    Select OPTION NAME: <strong>TASKMAN MANAGEMENT UTILITIES</strong>  XUTM UTIL     Taskman Manageme
    nt Utilities


     MTM    Monitor Taskman
            Check Taskman's Environment
            Edit Taskman Parameters ...
            Restart Task Manager
            Place Taskman in a WAIT State
            Remove Taskman from WAIT State
            Stop Task Manager
            Taskman Error Log ...
            Clean Task File
            Problem Device Clear
            Problem Device report.
            SYNC flag file control


    You've got PRIORITY mail!


    Select Taskman Management Utilities <TEST ACCOUNT> Option: <strong>Restart Task Manager</strong>
    ARE YOU SURE YOU WANT TO RESTART TASKMAN? NO// <strong>Y</strong>  (YES)
    Restarting...TaskMan restarted!


     MTM    Monitor Taskman
            Check Taskman's Environment
            Edit Taskman Parameters ...
            Restart Task Manager
            Place Taskman in a WAIT State
            Remove Taskman from WAIT State
            Stop Task Manager
            Taskman Error Log ...
            Clean Task File<F5>
            Problem Device Clear
            Problem Device report.
            SYNC flag file control


    You've got PRIORITY mail!

    Select Taskman Management Utilities <TEST ACCOUNT> Option: <strong>^</strong></code>


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

    <code>> <strong>S DUZ=.5 D ^XUP</strong>

    Setting up programmer environment
    This is a TEST account.

    Terminal Type set to: C-VT220

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
    NPI: <strong>&lt;enter&gt;</strong></code>

Once in the ScreenMan form, you will need to set the necessary
information mentioned above. Four pieces of information are able to be set
on the first page of the ScreenMan form.  The arrows are for emphasis to
highlight where information needs to be entered and will not show up in the
terminal window.

To add an access or verify codes, you need to first answer ``Y`` to the
``Want to edit ...`` questions, it will then prompt you to change the codes.

.. raw:: html

    <code>                            Edit an Existing User
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


    COMMAND:                                     Press <PF1>H for help    Insert</code>

To change to other pages, press the down arrow key or <TAB> until the cursor
reaches the COMMAND box.  Then type ``N`` or ``Next Page`` and press &lt;enter&gt; to
display the next page.

There is nothing that needs to be set on the second or third pages, but the
CPRS Tab Access is set on the fourth page. Navigate the cursor to the location
under the ``Name`` header and enter ``COR``, which stands ``for Core Tab Access``,
and enter an effective date of yesterday, ``T-1`` is the notation to use.

.. raw:: html

    <code>                            Edit an Existing User
    NAME: CPRS,USER                                                     Page 4 of 5
    _______________________________________________________________________________
    RESTRICT PATIENT SELECTION:        OE/RR LIST:

    CPRS TAB ACCESS:
      Name  Description                          Effective Date  Expiration Date
    ->








    _______________________________________________________________________________





    COMMAND:                                       Press <PF1>H for help</code>

Once that is done, save and exit the ScreenMan form via the COMMAND box and
then answer the final questions regarding access letters, security keys
and mail groups:

.. raw:: html

    <code>Exit     Save     Next Page     Refresh
    
    Enter a command or '^' followed by a caption to jump to a specific field.
    
    
    COMMAND: <strong>E</strong>                                     Press <PF1>H for help    Insert
    
    Print User Account Access Letter? <strong>NO</strong>
    Do you wish to allocate security keys? NO// <strong>NO</strong>
    Do you wish to add this user to mail groups? NO// <strong>NO</strong>
    
    ...
    
    Select User Management <TEST ACCOUNT> Option: <strong>^&lt;enter&gt;</strong>
    ></code>

At this point, CPRS can successfully connect to the local VistA instance and
the ``CPRS,USER`` will be able to sign on and interact with the GUI.


Begin to Set Up the VistA System
================================

The routine ZTMGRSET defines VistA global variables and saves system wide M 
routines that are Caché specific. FileMan is the database system used by all 
VistA applications.

On Caché
    
At User prompt type ``D ^%CD``. At Namespace type ``VISTA``.

On Caché
********

.. raw:: html
    
    <code>> <strong>D ^%CD</strong>
    
    NAMESPACE// <strong>VISTA</strong></code>

ZTMGRSET
********

.. raw:: html
    
    <code>><strong>K ^%ZOSF</strong>
    
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
    
    NAME OF MANAGER'S UCI,VOLUME SET: VAH,ROU// PLA,PLA
    The value of PRODUCTION will be used in the GETENV api.
    PRODUCTION (SIGN-ON) UCI,VOLUME SET: VAH,ROU// PLA,PLA
    The VOLUME name must match the one in PRODUCTION.
    NAME OF VOLUME SET: PLA//
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
    ></code>

On Caché
********

.. raw:: html
    
    <code>NAME OF MANAGER'S NAMESPACE: VISTA// <strong>&lt;enter&gt;</strong>
    
    PRODUCTION (SIGN-ON) NAMESPACE: VISTA// <strong>&lt;enter&gt;</strong>
    
    NAME OF THIS CONFIGURATION: VISTA// <strong>&lt;enter&gt;</strong></code>

Fileman
*******

Initialize FileMan to set your site name and number.  

.. raw:: html
    
    <code>><strong>D ^DINIT</strong>
    
    VA FileMan V.22.2
    
    Initialize VA FileMan now?  NO// <strong>Y</strong>
    
    SITE NAME: DEMO.OSEHRA.ORG// <strong>&lt;enter&gt;</strong>
    
    SITE NUMBER: 6161// <strong>&lt;enter&gt;</strong>
    
    Now loading MUMPS Operating System File
    
    Do you want to change the MUMPS OPERATING SYSTEM File? NO//....
    
    Now loading DIALOG and LANGUAGE Files..............................................................
    
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

    Now loading other FileMan files--please wait.................................................................................................
    ........................................................................................................................................
    ..........

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
    ></code>


Also run D ^ZUSET to choose the correct version of ZU, the key login routine 
for the roll and scroll portions of VistA.

.. raw:: html
    
    <code>><strong>D ^ZUSET</strong>
    
    This routine will rename the correct routine to ZU for you.
    
    Rename ZUGTM to ZU, OK? No// <strong>Y</strong
    
    Routine ZUGTM was renamed to ZU</code>

ZOSV
****

If you have the latest version of Caché with CacheWeb, you will need to edit the 
routine ^%ZOSV. To do this, right click the Caché Cube and choose Studio, File, 
Change Namespace, select VISTA then click OK.

 
Christen the Domain
*******************

TODO Move this up after the earlier section on setting a domain!!!

Now to complete the DOMAIN set up by Christening the new domain. Go back to the
> prompt and type "D CHRISTEN^XMUDCHR".

 

 

>DO CHRISTEN^XMUDCHR



* * * * WARNING * * * *

You are about to change the domain name of this facility
in the MailMan Site Parameters file.

Currently, this facility is named: PLATINUM.VISTA.MED.VA.GOV

You must be extremely sure before you proceed!

Are you sure you want to change the name of this facility? NO// YES
Select DOMAIN NAME: PLATINUM.VISTA.MED.VA.GOV//  VISTA.MYDOMAIN.COM

The domain name for this facility is now: VISTA.MYDOMAIN.COM
PARENT: 4// PLATINUM.VISTA.MED.VA.GOV
TIME ZONE: MDT// PDT     PACIFIC DAYLIGHT

PLATINUM.VISTA.MED.VA.GOV has been initialized as your 'parent'
domain.
(Forum is usually the parent domain, unless this is a subordinate domain.)

You may edit the MailMan Site Parameter file to change your parent domain.

We will not initialize your transmission scripts.

Use the 'Subroutine editor' option under network management menu to add your
site passwords to the MINIENGINE script, and the 'Edit a script' option
to edit any domain scripts that you choose to.

 

43.

Determine the internal entry of the new domain. Remember this number as it will be used in subsequent steps. Get back to the Select OPTION: prompt and enter "INQUIRE" or "5" (once again, you can type ?? to see the available options and 5 is INQUIRE TO FILE ENTRIES) then at the Select DOMAIN NAME: prompt, enter the new domain name you just created. Answer "N" to STANDARD CAPTIONED OUTPUT and at PRINT FIELD: answer "NUMBER". The domain number is "printed" to the screen.

If you get the warning here that you do not have a home device, go to step 97, do what it says there and then come back to this step.

 

 

Select OPTION: 5 INQUIRE TO FILE ENTRIES



OUTPUT FROM WHAT FILE: DOMAIN//
Select DOMAIN NAME: VISTA.MYDOMAIN.COM
ANOTHER ONE:
STANDARD CAPTIONED OUTPUT? Yes// N (No)
FIRST PRINT FIELD: NUMBER
THEN PRINT FIELD:
Heading (S/C): DOMAIN LIST//
DEVICE: CONSOLE Right Margin: 80//
DOMAIN LIST                                   APR 11,2003 10:51 PAGE 1
NUMBER
------------------------------------------------------------------------

3

 

44.

From the VISTA prompt repoint the KERNEL SYSTEM PARAMETERS and RPC BROKER PARAMETERS files to the new domain, go back to the > prompt and enter 'S $P(^XTV(8989.3,1,0),"^")=3' and 'S $P(^XWB(8994.1,1,0),"^")=3' where 3 is the internal number of the new domain we just created in the previous step.

 

 

   >S $P(^XTV(8989.3,1,0),"^")=3
   >S $P(^XWB(8994.1,1,0),"^")=3

 

45.

Then from the > prompt again start FileMan with "D Q^DI". At Select OPTION: enter "6" (UTILITY FUNCTIONS) then select RE-INDEX FILE. At MODIFY WHAT FILE, enter "KERNEL SYSTEM PARAMETERS". Then do the same for the RPC BROKER PARAMETERS file. See example below for the rest of the dialogue.

 

 

>D Q^DI


VA FileMan 22.0


Select OPTION: UTILITY FUNCTIONS
Select UTILITY OPTION: RE-INDEX FILE

MODIFY WHAT FILE: DOMAIN// 8989.3   KERNEL SYSTEM PARAMETERS (1 entry)

THERE ARE 13 INDICES WITHIN THIS FILE
DO YOU WISH TO RE-CROSS-REFERENCE ONE PARTICULAR INDEX? No// (No)
OK, ARE YOU SURE YOU WANT TO KILL OFF THE EXISTING 13 INDICES? No// Y (Yes)
DO YOU THEN WANT TO 'RE-CROSS-REFERENCE'? Yes// (Yes)
...EXCUSE ME, LET ME THINK ABOUT THAT A MOMENT...
FILE WILL NOW BE 'RE-CROSS-REFERENCED'................


Select UTILITY OPTION: RE-INDEX FILE

MODIFY WHAT FILE: KERNEL SYSTEM PARAMETERS// 8994.1   RPC BROKER SITE PARAMETERS            (1 entry)

THERE ARE 5 INDICES WITHIN THIS FILE
DO YOU WISH TO RE-CROSS-REFERENCE ONE PARTICULAR INDEX? No//   (No)
OK, ARE YOU SURE YOU WANT TO KILL OFF THE EXISTING 5 INDICES? No// Y   (Yes)
DO YOU THEN WANT TO 'RE-CROSS-REFERENCE'? Yes//   (Yes)
...HMMM, HOLD ON...
FILE WILL NOW BE 'RE-CROSS-REFERENCED'......

 

46.

Check the VOLUME SET File (#14.5). If you accepted the default VISTA when you ran ZTMGRSET (see previous steps), the VOLUME SET File should not need any changes. At Select OPTION: enter "1" for EDIT OR ENTER FILE ENTRIES. The choice should be INPUT TO WHAT FILE: VOLUME SET//. Accept the default if it is VOLUME SET else type "14.5", and at EDIT WHICH FIELD: ALL// hit enter. At Select VOLUME SET prompt type "??" to see a list of entries. When asked which volume set again, type in VISTA or whatever it is exactly as it is (all caps). Leave TASKMAN FILES UCI: VISTA// as VISTA. The values should match what is shown below.

 

 

Select OPTION: 1   ENTER OR EDIT FILE ENTRIES

INPUT TO WHAT FILE: VOLUME SET// 14.5   VOLUME SET (1 entry)
EDIT WHICH FIELD: ALL//

Select VOLUME SET: ??
   VISTA

   You may enter a new VOLUME SET, if you wish
   Answer should be the name of a volume set.
     When each cpu can have only one volume set, this is also the cpu name.
     Answer will be used in extended global references to reach this volume.

Select VOLUME SET: VISTA
VOLUME SET: VISTA//
TYPE: GENERAL PURPOSE VOLUME SET//
INHIBIT LOGONS?: NO//
LINK ACCESS?: YES//
OUT OF SERVICE?: NO//
REQUIRED VOLUME SET?: NO//
TASKMAN FILES UCI: VISTA//
TASKMAN FILES VOLUME SET: VISTA//
REPLACEMENT VOLUME SET:
DAYS TO KEEP OLD TASKS: 4//
SIGNON/PRODUCTION VOLUME SET: Yes//


Select VOLUME SET:

 

47.

This step is to get the proper value for the BOX-VOLUME PAIR in the TASKMAN SITE PARAMETERS File. Edit the TASKMAN SITE PARAMETER File (# 14.7) to update the BOX-VOLUME PAIR. Note that when you enter a "?" at the BOX-VOLUME PAIR prompt, it tells you what the correct value should be.

 

 

Select OPTION: 1   ENTER OR EDIT FILE ENTRIES 


INPUT TO WHAT FILE: VOLUME SET// 14.7   TASKMAN SITE PARAMETERS
                (1 entry)
EDIT WHICH FIELD: ALL//

Select TASKMAN SITE PARAMETERS BOX-VOLUME PAIR: ?
    Answer with TASKMAN SITE PARAMETERS BOX-VOLUME PAIR:
   VISTA:CACHE

     You may enter a new TASKMAN SITE PARAMETERS, if you wish
     Answer must be 3-30 characters in length.

The value for the current account is VISTA:CACHEWEB
Select TASKMAN SITE PARAMETERS BOX-VOLUME PAIR: VISTA:CACHE
BOX-VOLUME PAIR: VISTA:CACHE// VISTA:CACHEWEB
RESERVED: ^


Select TASKMAN SITE PARAMETERS BOX-VOLUME PAIR:

 

48.

Now update the RPC BROKER SITE PARAMETER File.

 

 

Select OPTION: 1   ENTER OR EDIT FILE ENTRIES

INPUT TO WHAT FILE: TASKMAN SITE PARAMETERS// 8994.1   RPC BROKER SITE PARAMETERS
EDIT WHICH FIELD: ALL//


Select RPC BROKER SITE PARAMETERS DOMAIN NAME: VISTA.MYDOMAIN.COM
     ...OK? Yes// (Yes)

DOMAIN NAME: VISTA.MYDOMAIN.COM//
Select BOX-VOLUME PAIR: VISTA:CACHEWEB//
   BOX-VOLUME PAIR: VISTA:CACHEWEB//
   Select PORT: 9210//
    PORT: 9210//
    *UCI:
    STATUS: STOPPED//
    CONTROLLED BY LISTENER STARTER: YES// N   NO

 

Set Yourself Up as the System Manager

This is a super user who will have elevated privileges. You can add other users such as Physicians, Pharmacists, etc. later.

49.

Now to set up the System Manager user with minimal information. We will add more information later. At Select OPTION: Type "1" (Type "??" to see Option 1 if you wish)

50.

At INPUT TO WHAT FILE: Type "200", the number of the NEW PERSON file.

51.

At EDIT WHICH FIELD: ALL// Type ".01" and hit enter. It will echo back NAME.

52.

It may respond with finish with NEW PERSON, 2 ENTRIES and then prompt you.

53.

At THEN EDIT FIELD: Type "ACCESS CODE" and the computer will finish it with Want to edit access code (Y/N)? Hit Enter and hit enter until you are prompted with Select NEW PERSON NAME.

54.

At Select NEW PERSON NAME, Type "MANAGER,SYSTEM" or whatever you choose.

55.

At Are you adding "MANAGER,SYSTEM" as a NEW PERSON (the 2nd [or whatever it offers you])? No// type "Y".

56.

It will respond Checking SOUNDEX for matches. No matches found. NEW PERSON INITIAL:

57.

Type "SM" or whatever you choose.

58.

At Want to Edit ACCESS Code (Y/N): Type "Y". For NEW PERSON MAIL CODE: hit ENTER.

59.

Then enter an access code. (Type "??" and hit enter to see what the options are for access codes if you wish.) At least 6 mixed alphanumeric characters. If not, just type the code and hit enter.

60.

Retype the code as directed. FileMan will respond OK, Access code has been changed! The VERIFY CODE has been deleted as a security measure. The user will have to enter a new one the next time they sign-on.

61.

At Select NEW PERSON NAME: Hit enter.

 

 

Select OPTION: 1   ENTER OR EDIT FILE ENTRIES



INPUT TO WHAT FILE: RPC BROKER PARAMETERS// 200   NEW PERSON
          (2 entries)
EDIT WHICH FIELD: ALL// .01   NAME
THEN EDIT FIELD: ACCESS CODE   Want to edit ACCESS CODE (Y/N)
THEN EDIT FIELD:


Select NEW PERSON NAME: MANAGER,SYSTEM
  Are you adding 'MANAGER,SYSTEM' as a new NEW PERSON (the 3RD)? No// Y   (Yes)
Checking SOUNDEX for matches.
No matches found.
  NEW PERSON INITIAL: SM
  NEW PERSON MAIL CODE:
Want to edit ACCESS CODE (Y/N): Y
Enter a new ACCESS CODE <Hidden>: ******
Please re-type the new code to show that I have it right: ******
OK, Access code has been changed!
The VERIFY CODE has been deleted as a security measure.
The user will have to enter a new one the next time they sign-on.



Select NEW PERSON NAME:

 

62.

At the Select OPTION: prompt Type "5".

63.

At OUTPUT FROM WHAT FILE: NEW PERSON// Hit Enter.

64.

At Select NEW PERSON NAME: Type "MANAGER,SYSTEM", or whatever you chose for the system manager name and hit enter.

65.

At ANOTHER ONE: Hit enter.

66.

At STANDARD CAPTIONED OUTPUT? YES// Hit enter or "Y".

67.

At Include COMPUTED fields: (N/Y/R/B): NO// type "B".

68.

The response will be a screen full of data. At the upper left hand corner will be NUMBER: followed by a number. This number will be the DUZ number that will be used in what follows below.

69.

Hit Enter until you back out to >.

70.

At > Type "SET DUZ= " and after the = sign, type in that number you found above for your DUZ number, and hit Enter.

71.

At the next > prompt, type S $P(^VA(200,DUZ,0),"^",4)="@". This will identify this user as a programmer to VA FileMan.

72.

At the next > prompt, type "D ^XUP". This is the VA Kernel's Programmer entry point.

73.

The first time, you will be asked to select a TERMINAL TYPE NAME:. Enter "C-VT100" and select 1.

74.

At Select OPTION NAME: Type "XUMAINT", it will echo back Menu Management.

75.

At Select Menu Management Option: type "KEY" Management; then at Select Key Management Option: "ALLO"cation of Security Keys.

76.

Proceed to allocate the following keys - XUMGR, XMMGR, XUPROG, XUPROGMODE, and ZTMQ.

77.

When it asks Holder of the key, enter "MANAGER,SYSTEM" or whatever name you selected.

 

 

>S DUZ=1
>S $P(^VA(200,DUZ,0),"^",4)="@"
>D ^XUP

Setting up programmer environment
Select TERMINAL TYPE NAME: C-VT100
   1 C-VT100 Digital Equipment Corporation VT-100 video
   2 C-VT100HIGH Normal display of characters in BOLD !
CHOOSE 1-2: 1 C-VT100 Digital Equipment Corporation VT-100 video
Terminal Type set to: C-VT100

Select OPTION NAME: XUMAINT Menu Management

Select Menu Management Option: KEY Management

Select Key Management Option: ALLOcation of Security Keys

Allocate key: XUMGR

Another key: XUPROG
   1   XUPROG
   2   XUPROGMODE
CHOOSE 1-2: 1   XUPROG

Another key: XUPROGMODE

Another key: XMMGR

Another key:

Holder of key: MANAGER,SYSTEM       SM

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


Select Key Management Option:

 

Set Up More Parameters

These are parameters that are more applicable to the VistA application software.

78.

If you are planning to use the VistA applications such as Registration, Scheduling etc. you need to add new Institution to the INSTITUTION File. Go back to the > prompt and "SET XUMF=1" then "D Q^DI". Select Option #1 and edit File #4. Edit the field STATION NUMBER. For Station Number, you must enter the same number as the Site Number when you initialized FileMan. (See Start FileMan and Begin Setting Up Vista section.)

 

 

>S XUMF=1 D Q^DI


VA FileMan 22.0


Select OPTION: 1   ENTER OR EDIT FILE ENTRIES



INPUT TO WHAT FILE: NEW PERSON// 4   INSTITUTION (27 entries)
EDIT WHICH FIELD: ALL// STATION NUMBER
THEN EDIT FIELD:


Select INSTITUTION NAME: VISTA HEALTH CARE
  Are you adding 'VISTA HEALTH CARE' as a new INSTITUTION (the 28TH)? No// Y   (Yes)
STATION NUMBER: 6100


Select INSTITUTION NAME:

79.

Then you need to add a Medical Center Division. Select File #40.8 and edit fields FACILITY NUMBER and INSTITUTION FILE POINTER. Enter the Institution STATION NUMBER for FACILITY NUMBER and the name of the Institution in INSTITUTION FILE POINTER.

 

 

Select OPTION: 1   ENTER OR EDIT FILE ENTRIES



INPUT TO WHAT FILE: INSTITUTION// 40.8   MEDICAL CENTER DIVISION (1 entry)
EDIT WHICH FIELD: ALL// FACILITY NUMBER
THEN EDIT FIELD: INSTITUTION FILE POINTER
THEN EDIT FIELD:


Select MEDICAL CENTER DIVISION NAME: VISTA MEDICAL CENTER
   Are you adding 'VISTA MEDICAL CENTER' as
   a new MEDICAL CENTER DIVISION (the 2ND)? No// Y   (Yes)
   MEDICAL CENTER DIVISION NUM: 2//
   MEDICAL CENTER DIVISION FACILITY NUMBER: 6100A
FACILITY NUMBER: 6100A//
INSTITUTION FILE POINTER: VISTA HEALTH CARE    6100


Select MEDICAL CENTER DIVISION NAME:

80.

You are now ready to enter additional information for the system manager user like PRIMARY MENU, VERIFY CODE etc.

81.

Go back to the VISTA prompt and type "D ^XUP".

82.

At Select OPTION NAME: Type "XUSEREDIT", it will give you two choices, select 1.

83.

At Select NEW PERSON NAME: Type the name you chose for Manager, System.

 

 

>D ^XUP

Setting up programmer environment
Terminal Type set to: C-VT100

Select OPTION NAME: XUSERED
    1   XUSEREDIT   Edit an Existing User
    2   XUSEREDITSELF   Edit User Characteristics
CHOOSE 1-2: 1 XUSEREDIT  Edit an Existing User
Edit an Existing User
Select NEW PERSON NAME: MANAGER,SYSTEM    SM

 

84.

Now you will be presented with a screen with multiple options. You can navigate the screen with the TAB key. For navigation help, use your keyboard arrows to move down to the command line and hold down either the Num Lock key (which is mapped as PF1 of a VT-320 terminal by Caché) or F1 for other terminal emulations and hit "H" and then Enter for help. You can exit by typing "^" on the command line and the change you made will be saved. As a minimum, assign EVE as the PRIMARY MENU and enter IRM (it's the only choice) as SERVICE/SECTION. If you plan to use CPRS, enter OR CPRS GUI CHART as a SECONDARY MENU OPTION. Enter other data as you deem appropriate.

 

pic 25 - System Manager Edit1

 

85.

Type "N"EXT PAGE at COMMAND: to go to page 2 to update the TIMED READ field and other fields you wish to update. For DEFAULT TIMED-READ (SECONDS): if you change it to 3600 you will be allow an hour before being automatically signed off. It makes it easier to work when you are learning and setting things up.

 

 

Press <PF1> refers to notations for use of Vista on Terminals. For example, the original VT-320 keyboard had additional character sets and keys which include Find, Select, Insert, Remove, Previous Screen, Next Screen, an arrow cluster and F1 to F20. With Caché, the Keys are "mapped", which means when you push a given key it acts as the key would in a terminal. For instance, F1, F2, F3 and F4 are equivalent to the PF1, PF2, PF3 and PF4 keys on the terminal keyboard and Page Up and Page Down on the computer keyboard correspond to Previous Screen and Next Screen. A listing of other mappings can be found at the Caché Cube Terminal window under Help and search Keyboard Mappings. Also there is lots of information about terminal if you are interested at www.VT100.net.

 

pic 26 - System Manager Edit2

 

Set Up Menus for the System Manager

EVE is the System Manager menu and XUCOMMAND is a common menu available to all users.

86.

The next step is to make FileMan, MailMan, and Manage MailMan menus accessible to the System Manager user from the menu system. From the VISTA prompt, type "D ^XUP". At Select OPTION NAME: enter "XUMAINT". Then at Select Menu Management, type "EDIT OPTIONS", then pick EVE.

87.

Select 1 from the list then at NAME: EVE// type "^10".

88.

At Select ITEM: enter "DIUSER". Hit enter until you get to Select ITEM again (you may enter data for the other fields like SYNONYM if you wish).

89.

At the next Select ITEM: enter "XMMGR".

 

 

>D ^XUP

Setting up programmer environment
Terminal Type set to: C-VT10

Select OPTION NAME: XUMAINT     Menu Management

Select Menu Management Option: EDit options

Select OPTION to edit: EVE
    1 EVE Systems Manager Menu
    2 EVENT CAPTURE (ECS) EXTRACT AU ECX ECS SOURCE AUDIT Event Capture (ECS) Extract Audit
    3 EVENT CAPTURE DATA ENTRY ECENTER Event Capture Data Entry
    4 EVENT CAPTURE EXTRACT ECXEC Event Capture Extract
    5 EVENT CAPTURE MANAGEMENT MENU ECMGR Event Capture Management Menu
Press <RETURN> to see more, '^' to exit this list, OR
CHOOSE 1-5: 1   EVE Systems Manager Menu
NAME: EVE// ^10   MENU
Select ITEM: HL MAIN MENU// DIUSER VA FileMan
  Are you adding 'DIUSER' as a new MENU (the 13TH for this OPTION)? No// Y (Yes)
   MENU SYNONYM: FM
   SYNONYM: FM//
  DISPLAY ORDER:
Select ITEM: XMMGR
    1   XMMGR     Manage Mailman
    2   XMMGR-BACKGROUND-FILER     Background Filer (XMAD)
    3   XMMGR-BKFILER-ACT     Active Users/Deliveries Report
    4   XMMGR-BKFILER-EDIT-NORMALIZED     Edit numbers to Normalize
Reports
    5   XMMGR-BKFILER-GROUP     Deliveries by Group
Press <RETURN> to see more, '^' to exit this list, OR
CHOOSE 1-5: 1   XMMGR     Manage Mailman
  Are you adding 'XMMGR' as a new MENU (the 14TH for this OPTION)? No// Y (Yes)
  MENU SYNONYM:
  SYNONYM:
  DISPLAY ORDER:
Select ITEM:
CREATOR: MANAGER,SYSTEM// ^

 

90.

Exit by entering "^" at any prompt. At the next Select OPTION to edit: enter "XUCOMMAND". Then at NAME: XUCOMMAND// type "^10". At Select ITEM: enter "XMUSER".

 

 

Select OPTION to edit: XUCOMMAND     SYSTEM COMMAND OPTIONS
NAME: XUCOMMAND// ^10   MENU
Select ITEM: XQALERT// XMUSER   MailMan Menu
  Are you adding 'XMUSER' as a new MENU (the 8TH for this OPTION)? No// Y   (Yes)
  MENU SYNONYM: MM
  SYNONYM: MM//
  DISPLAY ORDER:
Select ITEM:
CREATOR: MANAGER,SYSTEM// ^

Select OPTION to edit:

 

91.

To change the default time it takes before users are automatically signed off the system from the default of 300 seconds. This, again, is to give you more time to work as you are learning. Back out to the VISTA prompt. At the VISTA prompt, Type "D ^ZU".

92.

At ACCESS CODE, type in the code you chose when setting up MANAGER, SYSTEM as a NEW PERSON.

93.

At VERIFY CODE, hit ENTER. When asked for a new verify code, type the code you choose and remember it.

94.

At Select Systems Manager Menu Option: Type "OPER", (short for operations management) and hit enter. You can see all of the choices available to you if you type "??".

95.

At Select Operations Management Option: Type "KER" short for Kernel Management Menu and hit enter. At Select Kernel Management Menu Option: Type "ENT", short for Enter/Edit Kernel Site Parameters. Hit enter.

96.

You will be presented with a similar screen as in editing the SYSTEM MANAGER characteristics. You can navigate the screen with the TAB key. For DEFAULT TIMED-READ (SECONDS): change it to 3600 to allow an hour before being automatically signed off, or whatever you choose.

 

pic 27 - Kernel Parameters

 

Update the Devices, Start Taskman and Mail a Message

These are basic devices to complete the setup. You can setup other devices, such as printers, later.

97.

Now to update devices. The Platinum CACHE.DAT already comes with preconfigured devices. It is best to leave the VOLUME SET(CPU) field blank. The help text for the field states: "If no name has been entered for this field, this device is assumed to be accessible from all CPUs in the network. In other words, when this device is referenced, the device handler will operate as if this device is resident on the local CPU". The SIGN-ON/SYSTEM DEVICE: field should be set to NO or left blank for output devices and YES if the device is used to log on to the system. Use FileMan to edit the CONSOLE, NULL, HFS, and TELNET devices. CONSOLE is the primary logon device. The NULL device is used by the Vista RPC Broker and HFS is used by the Kernel Installation and Distribution System (KIDS) to install application patches and new applications when they are released. On the single user Caché PC you will not need the TELNET device since it does not allow remote access. At the > prompt, type "D Q^DI" to invoke VA Fileman. At Select OPTION: type "1" (ENTER OR EDIT FILE ENTRIES) and at INPUT TO WHAT FILE:, enter "3.5".

 

 

VA FileMan 22.0


Select OPTION: 1   ENTER OR EDIT FILE ENTRIES



INPUT TO WHAT FILE: PACKAGE// 3.5   DEVICE (35 entries)
EDIT WHICH FIELD: ALL//


Select DEVICE NAME: CONSOLE     CONSOLE |TRM|
NAME: CONSOLE//
LOCATION OF TERMINAL: CONSOLE//
Select MNEMONIC:
LOCAL SYNONYM:
$I: |TRM|//
VOLUME SET(CPU):
SIGN-ON/SYSTEM DEVICE: Y   YES
TYPE: VIRTUAL TERMINAL//
SUBTYPE: C-VT100// ^


Select DEVICE NAME: TELNET     TELNET |TNT| VISTA
NAME: TELNET//
LOCATION OF TERMINAL: TELNET//
Select MNEMONIC:
LOCAL SYNONYM:
$I: |TNT|//
VOLUME SET(CPU): VISTA// @
  SURE YOU WANT TO DELETE? Y   (Yes)
SIGN-ON/SYSTEM DEVICE: Y   YES
TYPE: VIRTUAL TERMINAL//
SUBTYPE: C-VT320// ^


Select DEVICE NAME: HFS     Host File Server C:\PLATINUM\TMP.DAT
NAME: HFS//
LOCATION OF TERMINAL: Host File Server//
Select MNEMONIC:
LOCAL SYNONYM:
$I: C:\PLATINUM\TMP.DAT// C:\TEMP\TMP.TXT
VOLUME SET(CPU): 
SIGN-ON/SYSTEM DEVICE: ^


Select DEVICE NAME: NULL
    1   NULL     NT SYSTEM NALO:
    2   NULL-DSM     Bit Bucket _NLA0:
CHOOSE 1-2: 1   NULL     NT SYSTEM     NALO: 
NAME: NULL//
LOCATION OF TERMINAL: NT SYSTEM//
Select MNEMONIC:
LOCAL SYNONYM:
$I: NALO:// //./nul
VOLUME SET(CPU):
SIGN-ON/SYSTEM DEVICE: YES// N   NO
TYPE: TERMINAL//
SUBTYPE: C-VT100// ^


Select DEVICE NAME:

 

98.

Again from the VISTA promt, enter "D ^ZTMCHK" to check if TaskMan's environment is OK. This will present you with two screens with information on TaskMan's environment.

 

pic 28 - Check TaskMan Environment1

Screen #1

 

pic 29 - Check TaskMan Environment2

Screen #2

 

99.

If TaskMan's environment is OK, you are ready to start TaskMan. Go back to the VISTA prompt and type "D ^ZTMB" to start TASKMAN.

100.

To monitor TaskMan, enter "D ^ZTMON" from the VISTA prompt. Enter "^" at the UPDATE// prompt to exit the monitor or enter a "?" to see what the other options are.

 

pic 30 - Monitor TaskMan

 

101.

From the > programmer prompt you can check the system status with "D ^%SS". You should see at least two Taskman processes - %ZTM and %ZTMS.

 

pic 31 - System Status with TM

 

102.

Now send a message using Postmaster to your DUZ number. Use D ^%CD to get into the namespace, VISTA, and then type "S DUZ=.5 D ^XUP". You will get the response SETTING UP PROGRAMMER ENVIROMENT then TERMINAL TYPE SET TO: (your default) and Select OPTION NAME:. You will need to respond: "XMUSER". At Select Mailman Menu Option: type "S" (for send). At Subject: enter your subject, such as Test, and then hit enter. You will then be prompted You may enter the text of the message and you will be offered the line number 1> where you can type your message, such as the infamous Hello world. Next will be line 2> and if you are done, just hit enter and at EDIT Option: you can do the same. At Send mail to: POSTMASTER// enter the initials you used for your DUZ which were probably SM for System Manager. You will then be told when MailMan was last used, which is probably NEVER. Hit enter at And Send to: and you should receive the message Select Message option: Transmit now// at which you hit enter and will hopefully receive the message Sending [1] Sent. Type "^" to exit.

103.

Now see if you received it. Log on using "D ^ZU". At the Systems Manager prompt, type "MAIL". Then at the Select MailMan Menu Option: type "NEW" Messages and Responses. Read the mail.

 

pic 32 - Read Mail

 

Start and test the RPC Broker.

The RPC Broker is VistA's Client/Server software and is needed by VistA's GUI client.

104.

Now to see of the RPC BROKER will start. To start the broker, type "D STRT^XWBTCP(port)" at the VISTA prompt. The system status should now show the broker listener (XWBTCPL) running.

 

 

>D STRT^XWBTCP(9210)
Start TCP Listener...
Checking if TCP Listener has started...
TCP Listener started successfully.
>

 

Now run "D ^%SS" again. You should see something like the following with XWBPTCL running.

 

pic 33 - Broker

 

105.

If you have the RPCTEST.EXT on your workstation, you test your connection to the localhost. Download the file XWB1_1WS.EXE from ftp://ftp.va.gov/vista/Software/Packages/RPC Broker - XWB/PROGRAMS/. (Note: The VA's ftp site is not compatible with Netscape's ftp. Either use Windows Explorer or FTP software). Double click on this file once you have downloaded it. Accept the defaults. It will install RPC Broker's Client software including RPCTEST.EXE. Then go to C:\program files\vista\broker\rcptest.exe and double click on it or create a shortcut on your desktop.

 

pic 34 - RPC Test

 

106.

You should see a Vista logon screen.

 

pic 35 - Vista Logon

 

108.

If you connect successfully, the link state will turn green.

 

pic 36 - Broker Connect

 

109.

To stop TaskMan, use "D STOP^ZTMKU" and answer "YES" to stopping the submanagers.

110.

To stop Broker, use "D STOP^XWBTCP(9210)". This is the last time you should be using these direct access to the routines to manage VistA. You should be using the menu system from now on to manage starting and stopping Taskman, the background filers and the RPC Broker. That way any code changes, etc., will be accounted for. Programmers will usually enter from the programmer prompt beginning with D ^XUP. The system managers menu option is EVE.

 

Last edited 5/27/06 7:40 AM EST

End of Chapter 1 ---> Chapter 2