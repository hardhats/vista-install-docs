Set-up HL7 Messages from and to VistA
=====================================
Authors: Sam Habiel.

License: |license|

.. |license| image:: https://i.creativecommons.org/l/by/4.0/80x15.png 
   :target: http://creativecommons.org/licenses/by/4.0/ 

Last updated in December 2018.

  Before proceeding with this section, you should have completed
  `Initializing VistA<./InitializeVistA.html>`_.

Purpose of this Tutorial
------------------------
This tutorial will help you set-up both outgoing and incoming connections to
HL7 in VistA via
`TCP<https://en.wikipedia.org/wiki/Transmission_Control_Protocol>`_ only. The
tutorial will be very thin on theoretical content on HL7 itself. For a fuller
treatment of the subject matter, consult the manuals in the `VistA
Documentation Library<https://www.va.gov/vdl/application.asp?appid=8>`_, in
particular, `this
manual<https://www.va.gov/vdl/documents/Infrastructure/Health_Level_7_(HL7)/hl71_6p56_p66.pdf>`_.
There is a newer HL7 messaging system in VistA called "HL7 Optimized (HLO)" --
we wont be discussing that here as HLO is not widely used.

What is HL7?
------------
HL7 means Health Level 7, the number 7 corresponding to the Application Layer
in the `OSI Model<https://en.wikipedia.org/wiki/OSI_model>`_. In brief, it is
a messaging format used in Medicine. It's important because when deploying
VistA in a healthcare setting, you almost always have to talk to other machines,
such a lab instruments, ECG/EKG instruments, X-ray machines, and the list goes
on forever. The way to talk to all of these instruments is using HL7.

When we speak of HL7 in this document, we specifically mean HL7 versions 2.1,
2.2, 2.3, and 2.4, which are all similar to each other. We will not talk about
HL7 v3 and later, which include CDA documents and the like as these are not
used for interfacing with Medical Devices.

What is an HL7 message?
-----------------------
The following description is taken from `this manual<https://www.va.gov/vdl/documents/Infrastructure/Health_Level_7_(HL7)/hl71_6p56_p66.pdf>`_.

An HL7 message is the atomic unit for transfe rring data between systems in the
HL7 standard.  Each message has a header segment composed of a number of
fields, including a field containing the message type and (HL7 versions 2.2 and
a bove) event type. These are each three-character codes, defined by the HL7
standard. The type of a transaction is defined by the message type/event type
pair (again for HL7 versions 2.2 and above). Rules for constructing message
headers and messages are provided in the "Control/Query" chapter of the HL7
standard.  

An HL7 message consists of one or more HL7 segments . A segment is similar to a
record in a file. Each segment consists of one or more fi elds separated by a
special character called the field separator . The field separator character is
defined in the Message Header (MSH) segment of an HL7 message. The MSH segment
is always the first segment in every HL7 message (except for batch HL7
messages, which begin with BHS or FHS segments).  

In addition to the field separator character, four other special characters,
called encoding characters, are used as delimiters. Encoding characters are
also defined in the MSH segment.  Each encoding character must be unique, and
serves a specific purpose. None of the encoding characters can be the same as
the field separator character. The four delimiters for which there are
encoding characters are: 

* Component separator. Some data fields can be divided into multiple
  components. The component separator character separates adjacent components
  within a data field.
* Repetition separator. Some data fields can be repeated multiple times in a
  segment. The repetition separator character separates multiple occurrences of
  a field.
* Escape character. Data fields defined as text or formatted text can include
  escape sequences. The escape character separates escape sequences from the
  actual text.
* Sub-component separator. Some data fields can be divided into components, and
  each component can be further divided into sub-components. The sub-component
  separator character separates adjacent sub-components within a component of a
  field.

Here's an example of an HL7 message:

::

  MSH|^~\&|INFOLIO TEST|BOSTON VAMC|IB TEST|500|19900314130405|ORU^R01|523123|D|2.3|
  PID||7777790^2^M10||HL7Patient^One||||||||123456789|
  OBR||2930423.08^1^L||199304230800|||||||DERMATOLOGY|
  OBX|CE|10040|OV|1^0^0^0^0|
  OBX|CE|11041|PR|
  OBX|CE|216.6|P|
  OBX|ST|VW^WEIGHT^L||120|KG
  OBX|ST|VB^BLOOD PRESSURE^L||120/80|MM HG
  OBX|ST|VT^TEMPERATURE^L||99|C
  OBX|ST|VP^PULSE^L||75|/MIN 

* The first line of the message is the message header (MSH) segment 
  * The field separator is ‘|’, the component separator is ‘^’, the repetition
    separator is ‘~’, the escape character is ‘\’ and the subcomponent
    separator is ‘&’. This is the recommended set.
  * The sending application is INFOLIO TEST and the receiving application is
    IBTEST.
  * The sending facility is BOSTON VAMC and the receiving facility is 500. 
  * The message type is Observation Result/Unsolicited (ORU) and the event type
    is an unsolicited transmission of an observation message (R01). 
* The message type (from the MSH segment) is Observation Result/Unsolicited
  (ORU) 
* The second line of the message is the second segment, Patient Identification
  (PID)  
* The third line of the message is the third segment, an Observation Request
  (OBR) 
* The subsequent lines of the message are multiple observation/results (OBX)
  segments 

Most HL7 messages are unsolicited. They are sent to VistA; or VistA sends them;
without either party knowing beforehand that they are getting a message.

HL7 messages typically require an acknowledgement message to be sent. A sample
acknowledgement looks like this:

::

  MSH|^~\&|CATH|StJohn|AcmeHIS|StJohn|20061019172719||ACK^O01|MSGID12349876|P|2.3
  MSA|AA|MSGID12349876

The second piece of the MSA segement is either:

* AA – Application Accept
* AE – Application Error
* AR – Application Reject

There is one more thing that's important to mention: The messages above are
just the contents. The actual message transmitted over TCP contains several
control characters to delimit the start and the end of the message. (TCP is a
stream protocol; so you must provide either message lengths or delimiters to
deliniate the beginning and end of a message). This is called the HL7 Minimal
Lower Layer Protocol (MLLP). So a full HL7 message over TCP looks like this:

::
  
  <ASCII VERTICAL TAB - $C(11)/0X0B>
  HL7 MESSAGE
  <ASCII FILE SEPARATOR - $C(28)/0X1C>
  <ASCII CARRIAGE RETURN - $C(13)/0X0D>

HL7 System Startup
------------------
There are some persistent taskman tasks that need to be created in order for
the HL7 system to initialize itself. The tasks are ``HL AUTOSTART LINK
MANAGER`` and ``HL TASK RESTART``, which need to be set to start-up persistent.
On a production system, you must schedule ``HL PURGE TRANSMISSIONS`` nightly to
ensure that you don't run out of disk space.

To schedule these tasks, go to `this section<./InitializeVistA.html#back-to-taskman>`_
of the Intialize VistA document. Remember, two of the tasks are to be marked
as Startup Persistent, and one is recurring every night.

Here's a screen capture in Fileman 

.. raw:: html

  <pre>FOIA201805&gt;D P^DI


  MSC FileMan 22.1060


  Select OPTION: <strong>ENTER</strong> OR EDIT FILE ENTRIES



  Input to what File: OPTION SCHEDULING// <strong>&lt;enter&gt;</strong>  (18 entries)
  EDIT WHICH FIELD: ALL//<strong>&lt;enter&gt;</strong>  

  Select OPTION SCHEDULING NAME: <strong>HL AUTOSTART LINK </strong>MANA  GER       Autostart Link Manager
    Are you adding 'HL AUTOSTART LINK MANAGER' as
      a new OPTION SCHEDULING (the 16TH)? No// <strong>Y</strong>  (Yes)
  QUEUED TO RUN AT WHAT TIME:<strong>&lt;enter&gt;</strong>
  DEVICE FOR QUEUED JOB OUTPUT:<strong>&lt;enter&gt;</strong>
  OTHER DEVICE PARAMETERS:<strong>&lt;enter&gt;</strong>
  QUEUED TO RUN ON VOLUME SET:<strong>&lt;enter&gt;</strong>
  RESCHEDULING FREQUENCY:<strong>&lt;enter&gt;</strong>
  SPECIAL QUEUEING: <strong>SP</strong>  Startup Persistent
  Select VARIABLE NAME:<strong>&lt;enter&gt;</strong>
  USER TO RUN TASK: <strong>^</strong>


  Select OPTION SCHEDULING NAME: <strong>HL TASK RESTART</strong>       Restart/Start All Links and Filers
    Are you adding 'HL TASK RESTART' as
      a new OPTION SCHEDULING (the 17TH)? No// <strong>Y</strong>  (Yes)
  QUEUED TO RUN AT WHAT TIME: <strong>^SPECIAL QUEUEING</strong>
  SPECIAL QUEUEING: <strong>SP</strong>  Startup Persistent
  Select VARIABLE NAME: <strong>^</strong>


  Select OPTION SCHEDULING NAME: <strong>HL,PUR</strong>
       1   HL PURGE JOB REVIEW       Purge jobs monitoring
       2   HL PURGE QUEUE (TCP)       Purge Outgoing Queue (TCP Only)
       3   HL PURGE TRANSMISSIONS       Purge Messages
  CHOOSE 1-3: <strong>3</strong>  HL PURGE TRANSMISSIONS     Purge Messages
    Are you adding 'HL PURGE TRANSMISSIONS' as
      a new OPTION SCHEDULING (the 18TH)? No// <strong>Y</strong>  (Yes)
  QUEUED TO RUN AT WHAT TIME: <strong>T+1@0100</strong>  (DEC 28, 2018@01:00)
  DEVICE FOR QUEUED JOB OUTPUT:
  OTHER DEVICE PARAMETERS:
  QUEUED TO RUN ON VOLUME SET:
  RESCHEDULING FREQUENCY: <strong>1D</strong>
  SPECIAL QUEUEING: <strong>^</strong></pre>

If Taskman is running, it should "catch" the new persistent tasks and start
them. If you run the system status from direct mode, you should see a bunch
of HL7 tasks now running (italicized).

.. raw:: html

  <pre>FOIA201805&gt;<strong>X ^%ZOSF("SS")</strong>

  GT.M System Status users on 27-DEC-18 21:30:16
  <strong>PID   PName   Device       Routine            Name                CPU Time</strong>
  1136  mumps   BG-0         STARTOUT+17^HLCSOUTPOSTMASTER          18:44:51
  1816  mumps   BG-0         GETTASK+3^%ZTMS1   Sub 1816            21:00:32
  <i>4776  mumps   BG-0         LOOP+2^HLCSMM1     POSTMASTER          18:44:51</i>
  <i>5960  mumps   BG-0         LOOP+2^HLCSMM1     POSTMASTER          18:44:52</i>
  6512  mumps   BG-0         GETTASK+3^%ZTMS1   Sub 6512            18:44:51
  8756  mumps   BG-0         GO+12^XMTDT        POSTMASTER          18:44:52
  <i>8800  mumps   BG-0         LOOP+7^HLCSLM      POSTMASTER          18:44:50</i>
  <i>9456  mumps   BG-0         LOOP+2^HLCSMM1     POSTMASTER          18:44:51</i>
  9580  mumps   BG-0         GETTASK+3^%ZTMS1   Sub 9580            18:44:52
  10020 mumps   BG-0         GETTASK+3^%ZTMS1   Sub 10020           20:44:58
  <i>10132 mumps   BG-0         STARTIN+28^HLCSIN  POSTMASTER          18:44:51</i>
  10220 mumps   BG-0         IDLE+3^%ZTM        Taskman ROU 1       18:44:49
  10764 mumps   BG-0         GO+26^XMKPLQ       POSTMASTER          18:44:52
  12096 mumps   BG-0         GETTASK+3^%ZTMS1   Sub 12096           18:45:08
  12388 mumps   BG-0         GETTASK+3^%ZTMS1   Sub 12388           21:00:33
  12476 mumps   /dev/pty0    INTRPTALL+8^ZSY    사용자,하나         17:56:44
  12616 mumps   BG-0         GETTASK+3^%ZTMS1                       20:00:31
  12876 mumps   BG-0         GETTASK+3^%ZTMS1   Sub 12876           20:44:56
  12968 mumps   BG-S9000     LGTM+25^%ZISTCPS   POSTMASTER          18:44:50
  13308 mumps   BG-0         GETTASK+3^%ZTMS1                       18:44:51</pre>



HL7 Send Setup
--------------
What I will show here is a typical scenario of sending messages out to other
systems. VistA sends messages at specific events (the messages sent and the
event at which a message is sent is typically documented in the technical
manual for a package on the `VDL<https://www.va.gov/vdl>`_). The event is
something that happens inside of VistA, such as the registration of a patient,
the availability of lab results, or the scheduling of an appointment. The
example we will use is patient registration, upon which VistA can send an HL7
ADT/A04 message, which is a patient registration message.

Introduction to Outgoing Message Routing in VistA
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This part is confusing, mainly because the way an outgoing message is processed
is almost identical to how an incoming message is processed. So we will discuss
this again in the context of incoming messages.

To send an outgoing message from VistA, you need to create an EVENT DRIVER
protocol (it actually lives in a file called PROTOCOL in Fileman). The EVENT
DRIVER is also known as a SERVER (which I personally find confusing, but oh
well). Here's the one we will use: (NB: to reach this form, you need to
navigate to EVE > HL7 Main Menu > Interface Developer Options > Protocol Edit
and select ``VAFC ADT-A04 SERVER``.)

::
  
  |                        HL7 INTERFACE SETUP                         PAGE 1 OF 2
  --------------------------------------------------------------------------------
  
              NAME: VAFC ADT-A04 SERVER
  
  DESCRIPTION (wp): + [This server protocol fires when a patient is re]
  
  
  ENTRY ACTION:
  
   EXIT ACTION:
  
  
          TYPE: event driver
  
  
  
  _______________________________________________________________________________
  
  Exit    Save    Refresh    Quit

On the second page of the form (to reach it, cursor down to "TYPE" field and
press enter), you will see the list of subscribers (we have two in this case:
``VBECS ADT-A04 CLIENT`` and ``HMP ADT-A04 CLIENT``).

::
  
  |                           HL7 EVENT DRIVER                         PAGE 2 OF 2
                           VAFC ADT-A04 SERVER
  --------------------------------------------------------------------------------
        SENDING APPLICATION: VAFC PIMS
   TRANSACTION MESSAGE TYPE: ADT                        EVENT TYPE: A04
          MESSAGE STRUCTURE:
              PROCESSING ID: P                          VERSION ID: 2.3
            ACCEPT ACK CODE: NE               APPLICATION ACK TYPE: NE
  
   RESPONSE PROCESSING RTN:
                             SUBSCRIBERS
    VBECS ADT-A04 CLIENT
    HMP ADT-A04 CLIENT
  
  
  
  
  _______________________________________________________________________________
  
  Exit    Save    Previous Page    Refresh    Quit

So bascially, when VistA calls ``VAFC ADT-A04 SERVER``, VistA will send the
message to the subscribers ``VBECS ADT-A04 CLIENT`` and ``HMP ADT-A04 CLIENT``.
For the curious, the registration HL7 message is generated in routine ``VAFCA04``
using this line of code: ``D GENERATE^HLMA("VAFC ADT-A04 SERVER","LM",1,.HLRST,"",.HL)``.

There are a couple more details we need to talk about. If you move your cursor
to one of the subscribers, and press enter, you will see a bunch of fields,
three of which are important.

::

  |                           HL7 EVENT DRIVER                         PAGE 2 OF 2
     ┌──────────────────────────HL7 SUBSCRIBER────────────────────────────────┐
  ---│                       VBECS ADT-A04 CLIENT                             │---
     │------------------------------------------------------------------------│
   TR│     RECEIVING APPLICATION: VBECS ADT                                   │
     │                                                                        │
     │     RESPONSE MESSAGE TYPE: ACK                         EVENT TYPE: A04 │
     │                                                                        │
     │SENDING FACILITY REQUIRED?:           RECEIVING FACILITY REQUIRED?:     │
   RE│                                                                        │
     │        SECURITY REQUIRED?:                                             │
    V│                                                                        │
    H│              LOGICAL LINK: VBECSPTU                                    │
     │                                                                        │
     │ PROCESSING RTN:                                                        │
     │  ROUTING LOGIC:                                                        │
     └────────────────────────────────────────────────────────────────────────┘
  _______________________________________________________________________________

The important fields we need to look at are ``LOGICAL LINK``, ``PROCESSING RTN``,
and ``ROUTING LOGIC``. The way they are used is confusing. They actually
override each other, in this order:

1. If the programmer creates an ``HLL("LINKS")`` array, that overrides
   everything, and none of the following steps take place. HLL("LINKS")
   basically tells VistA to ignore all the subscribers and use the subscribers
   in the HLL("LINKS") array. That means that steps 2-4 are evaluated for
   the subscribers in the HLL("LINKS") array.
2. If ``ROUTING LOGIC`` is specified, that is executed; and nothing else is.
3. If ``LOGICAL LINK`` is specified, the message is delivered to the IP address/
   domain name on the logical link and then we stop.
4. If neither ``LOGICAL LINK`` nor ``ROUTING LOGIC`` is specified, then the
   message is assumed to be an internal VistA to itself message, and the code
   for ``PROCESSING RTN`` is used. If ``PROCESSING RTN`` is not filled out,
   that's an error condition.

For most users, using a ``LOGICAL LINK`` to send a message out to an external
system is the correct thing to do.

Here are the steps for setting up to send a message from VistA to the outside:

* Create Logical Link
* Enable Logical Link
* Create Subscriber Client & Receiving Application
* (Application Specific) Enable Sending HL7 messages
* Test

In this example, what I will do is receive the message using the
`netcat<http://netcat.sourceforge.net/>`_ program, which is a generic socket
listener; and then we will download
`Mirth<https://www.nextgen.com/products-and-services/NextGen-Connect-Integration-Engine-Downloads>`_
and use it to receive a message. Mirth is an HL7 (and other formats) integration
engine -- and it's a realistic target to receive HL7 messages.

Outgoing Message Setup
^^^^^^^^^^^^^^^^^^^^^^
Create Logical Link
"""""""""""""""""""
In real life, you will have a destination machine with an ip/domain name and
port number you need to communicate to. For the purposes of this demostration,
I will initially set-up a netcat listener on my local machine on port 6661.
That means that my new logical link will call 127.0.0.1 port 6661. I will call
my link MEMPHIS. Logical links are not typically namespaced. To create a new
logical link, goto EVE > HL7 Main Menu > Interface Developer Options > Link
Edit [EL]

.. raw:: html

  <pre>Select HL LOGICAL LINK NODE: <strong>MEMPHIS</strong>
    Are you adding 'MEMPHIS' as a new HL LOGICAL LINK (the 77TH)? No// <strong>Y</strong>
                            HL7 LOGICAL LINK
  --------------------------------------------------------------------------------


                  NODE: MEMPHIS                        DESCRIPTION:

           INSTITUTION:

        MAILMAN DOMAIN:

             AUTOSTART:

            QUEUE SIZE: 10

              LLP TYPE:

            DNS DOMAIN:
  _______________________________________________________________________________

  Exit    Save    Refresh    Quit</pre>

On the Screenman form, scroll to "LLP TYPE" and type "TCP". Fill in the fields
as shown in bold below:

.. raw:: html

  <pre>                      HL7 LOGICAL LINK
  --------------------------------------------------------------------------------
    ┌──────────────────────TCP LOWER LEVEL PARAMETERS─────────────────────────┐
    │                      MEMPHIS                                            │
    │                                                                         │
    │  TCP/IP SERVICE TYPE: <strong>CLIENT (SENDER)</strong>                                   │
    │       TCP/IP ADDRESS: <strong>127.0.0.1</strong>                                         │
    │          TCP/IP PORT: <strong>6661</strong>                                              │
    │          TCP/IP PORT (OPTIMIZED):                                       │
    │                                                                         │
    │   ACK TIMEOUT: <strong>1</strong>                     RE-TRANSMISION ATTEMPTS:           │
    │  READ TIMEOUT: <strong>1</strong>                   EXCEED RE-TRANSMIT ACTION:           │
    │    BLOCK SIZE:                                      SAY HELO:           │
    │                                      TCP/IP OPENFAIL TIMEOUT:           │
    │STARTUP NODE:                                      PERSISTENT:           │
    │   RETENTION:                            UNI-DIRECTIONAL WAIT:           │
    └─────────────────────────────────────────────────────────────────────────┘
  _______________________________________________________________________________

  Close    Refresh</pre>

Type C for Close when you are at the command window; and then type S to Save,
then E to exit. You will be given the message: "If you shut down this link to
edit, please remember to restart if appropriate." That's what we are going to
do next.

Enable Logical Link
"""""""""""""""""""
To enable the link we just created, we go to HL7 Main Menu > 
Filer and Link Management Options > Start/Stop Links [SL].

.. raw:: html

  <pre>Select Filer and Link Management Options Option: <strong>SL</strong>  Start/Stop Links

  This option is used to launch the lower level protocol for the
  appropriate device.  Please select the node with which you want
  to communicate

  Select HL LOGICAL LINK NODE: <strong>MEMPHIS</strong>
  This LLP has been enabled!</pre>


Create Subscriber Client & Receiving Application
""""""""""""""""""""""""""""""""""""""""""""""""
The easiest way to add a client to the EVENT DRIVER ``VAFC ADT-A04 SERVER`` is
to edit the event driver and add a subscriber to the multiple on the second
page. Go to HL7 Main Menu > Interface Developer Options > Protocol Edit [EP],
and then select ``VAFC ADT-A04 SERVER``.

::
  
  |                        HL7 INTERFACE SETUP                         PAGE 1 OF 2
  --------------------------------------------------------------------------------
  
              NAME: VAFC ADT-A04 SERVER
  
  DESCRIPTION (wp): + [This server protocol fires when a patient is re]
  
  
  ENTRY ACTION:
  
   EXIT ACTION:
  
  
          TYPE: event driver
  
  
  
  _______________________________________________________________________________
  
  Exit    Save    Refresh    Quit

Cursor down to "TYPE" field and press enter to reach the second page of the
form. 

::
  
  |                           HL7 EVENT DRIVER                         PAGE 2 OF 2
                           VAFC ADT-A04 SERVER
  --------------------------------------------------------------------------------
        SENDING APPLICATION: VAFC PIMS
   TRANSACTION MESSAGE TYPE: ADT                        EVENT TYPE: A04
          MESSAGE STRUCTURE:
              PROCESSING ID: P                          VERSION ID: 2.3
            ACCEPT ACK CODE: NE               APPLICATION ACK TYPE: NE
  
   RESPONSE PROCESSING RTN:
                             SUBSCRIBERS
    VBECS ADT-A04 CLIENT
    HMP ADT-A04 CLIENT
  
  
  
  
  _______________________________________________________________________________
  
  Exit    Save    Previous Page    Refresh    Quit

On the second page of the form, move your cursor down to the end of the
list of the subscribers (there are normally 3 in FOIA, so you should be at the
4th position, whish should be empty). Start typing a namespaced name of your
client (a namespace is a place where you put your code; if you don't have one
use ZZ) -- which will be "ZZ ADT-A04 CLIENT". You will be asked:

* Are you adding "ZZ ADT-A04 CLIENT" as a new PROTOCOL? Answer Yes.
* PROTOCOL ITEM TEXT: Enter "ADT A04 TEST CLIENT"
* PROTOCOL IDENTIFIER: Leave blank

Once you do that, you will see this:

::

  |                         HL7 EVENT DRIVER                         PAGE 2 OF 2
     ┌──────────────────────────HL7 SUBSCRIBER────────────────────────────────┐
  ---│                       ZZ ADT-A04 CLIENT                                │---
     │------------------------------------------------------------------------│
   TR│     RECEIVING APPLICATION:                                             │
     │                                                                        │
     │     RESPONSE MESSAGE TYPE:                             EVENT TYPE:     │
     │                                                                        │
     │SENDING FACILITY REQUIRED?:           RECEIVING FACILITY REQUIRED?:     │
   RE│                                                                        │
     │        SECURITY REQUIRED?:                                             │
    V│                                                                        │
    H│              LOGICAL LINK:                                             │
    Z│                                                                        │
     │ PROCESSING RTN:                                                        │
     │  ROUTING LOGIC:                                                        │
     └────────────────────────────────────────────────────────────────────────┘
  _______________________________________________________________________________

  c        CLOSE
  r        REFRESH

Fill in the RECEIVING APPLICATION, RESPONSE MESSAGE TYPE, EVENT TYPE, and 
LOGICAL LINK.

* RECEIVING APPLICATION: Create a new one called NETCAT. Make sure it's marked
  as ACTIVE.
* RESPONSE MESSAGE TYPE: ACK
* EVENT TYPE: A04
* LOGICAL LINK: MEMPHIS (or whatever you called it).

This is what you will see for the new RECEIVING APPLICATION:

::

  --┌────────────────────Receiving Application Edit───────────────────────────┐---
    │                                                                         │
   T│         NAME: NETCAT                          ACTIVE/INACTIVE: ACTIVE   │
    │                                                                         │
    │FACILITY NAME:                                    COUNTRY CODE:          │
    │                                                                         │
    │   MAIL GROUP:                                                           │
   R└─────────────────────────────────────────────────────────────────────────┘


This is the final display.

::

  |                         HL7 EVENT DRIVER                         PAGE 2 OF 2
     ┌──────────────────────────HL7 SUBSCRIBER────────────────────────────────┐
  ---│                       ZZ ADT-A04 CLIENT                                │---
     │------------------------------------------------------------------------│
   TR│     RECEIVING APPLICATION: NETCAT                                      │
     │                                                                        │
     │     RESPONSE MESSAGE TYPE: ACK                         EVENT TYPE: A04 │
     │                                                                        │
     │SENDING FACILITY REQUIRED?:           RECEIVING FACILITY REQUIRED?:     │
   RE│                                                                        │
     │        SECURITY REQUIRED?:                                             │
    V│                                                                        │
    H│              LOGICAL LINK: MEMPHIS                                     │
    Z│                                                                        │
     │ PROCESSING RTN:                                                        │
     │  ROUTING LOGIC:                                                        │
     └────────────────────────────────────────────────────────────────────────┘
  _______________________________________________________________________________

Go to the command area, type "C" for close, and then "E" for exit.

At this point, we should be theoretically ready to send an HL7 message to the
MEMPHIS channel.

Check the Link Manager
""""""""""""""""""""""
Now, we should check that the Link Manager to make sure there are no messages
on the MEMPHIS Logical Link. Check it by going to HL7 Main Menu > Systems Link 
Monitor. This is what you will see, and it is what we expect.

::

  |                SYSTEM LINK MONITOR for PLATINUM (P System)                  
                MESSAGES  MESSAGES   MESSAGES  MESSAGES  DEVICE
     NODE       RECEIVED  PROCESSED  TO SEND   SENT      TYPE     STATE

    LISTENER    236       235        903       903        MS     2 server
    MCAR OUT                         10                          Shutdown
    ROR SEND    1         1          5         1          NC     Shutdown
    XUMF ACK    1738      1738       1035      1035       NC     Enabled
    XUMF FORUM                       3         3                 Enabled
    XUMF TEST                        4         4                 Enabled





     Incoming filers running => 1            TaskMan running
     Outgoing filers running => 1            Link Manager running
                                             Monitor current [next job 1.0 hr]
     Select a Command:
  (N)EXT  (B)ACKUP  (A)LL LINKS  (S)CREENED  (V)IEWS  (Q)UIT  (?) HELP:

Quit (Q) out of this, and exit the menu system and go back to the direct mode
in VistA. We need to run a simple test with a patient we registered `earlier
<./InitializeVistA.html#registering-your-first-patient>`_.

Creating a Test Message
"""""""""""""""""""""""
  
  NB: There is a recently introduced bug in HLCSTCP3 (patched up to 157 on the
  second line), line 69, which says:

  ``Q:(HLOS'["VMS")&(HLOS'["UNIX")  X "U IO:(::""-M"")"``

  This line is incorrect in many regards: it assumes all Cache systems run on
  VMS or UNIX; and it assumes that all UNIX systems will be Cache. Neither of 
  these assumptions are correct.

  It's safe to comment this line out. A more proper fix which takes into account
  other M systems can be found `here<https://raw.githubusercontent.com/shabiel/foia-vista-fixes/master/Routines/HLCSTCP3.m>`_.
  You need to comment the line out or get the new copy of the routine before
  proceeding any further.

::

  $ mumps -dir

  FOIA201805>S DUZ=1

  FOIA201805>D ^XUP

  Setting up programmer environment
  This is a TEST account.

  Terminal Type set to: C-VT220

  Select OPTION NAME:

  FOIA201805>N % S %=$$EN^VAFCA04(1,$$NOW^XLFDT)

If you crash, read this note:

  If you crash with this error: OBX+10^RGADTP, Undefined local variable:
  HL(SFN), it means that you did not change the station number that came with
  FOIA (050) and some downstream code is expecting 3 digit station numbers.
  This error comes from the subscriber ``RG ADT-A04 TRIGGER``, which you may
  have seen when editing the subscribers for EVENT DRIVER ``VAFC ADT-A04
  SERVER``. Without having to do the station numbers as described in
  `Initailize VistA<./InitializeVistA.html#setup-your-institution>`_, you can
  just go to the subscribers again, move the cursor to ``RG ADT-A04 TRIGGER``,
  and then type "@" to remove it.

If we go back to the System Link Monitor (DO ^XUP, type EVE, choose 1, then
navigate to HL7 Main Menu > Systems Link Monitor), we will see that MEMPHIS now
shows up as open. It will switch between Open and Openfail as we haven't opened
a server socket yet.

::

  |                SYSTEM LINK MONITOR for PLATINUM (P System)                  
                MESSAGES  MESSAGES   MESSAGES  MESSAGES  DEVICE
     NODE       RECEIVED  PROCESSED  TO SEND   SENT      TYPE     STATE

    LISTENER    236       235        903       903        MS     2 server
    MCAR OUT                         10                          Shutdown
    MEMPHIS                          1                    NC     Open
    ROR SEND    1         1          5         1          NC     Shutdown
    VBECSPTU    0         0          1         0          NC     Shutdown
    XUMF ACK    1738      1738       1035      1035       NC     Enabled
    XUMF FORUM                       3         3                 Enabled
    XUMF TEST                        4         4                 Enabled



     Incoming filers running => 1            TaskMan running
     Outgoing filers running => 1            Link Manager running
                                             Monitor current [next job 0.8 hr]
     Select a Command:
  (N)EXT  (B)ACKUP  (A)LL LINKS  (S)CREENED  (V)IEWS  (Q)UIT  (?) HELP:

Setup Netcat for Message Receipt
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
In another window, type the following

::

  nc -l 6661 >> hl7_msg.txt
 
Go back to the Link Monitor. You will see that MEMPHIS switches from being Open
to Retention to Inactive; and the column for MESSAGES SENT becomes 1.

Back to the netcat window, type CTRL-C to stop the listener, and then dump the
file using the cat command on Linux or type command on Windows. What you will
see would be similar to this:

::

  $ cat -v hl7_msg.txt
  ^KMSH^~|\&^VAFC PIMS^50^NETCAT^^20181228121041-0400^^ADT~A04^505356^P^2.3^^^NE^NE^USA^MEVN^A04^20181228121041-0400^^^1~M-lM-^BM-,M-lM-^ZM-)M-lM-^^M-^P~M-mM-^UM-^XM-kM-^BM-^X^MPID^1^500000001V075322^1~8~M10^1155P^M-kM-'M-^HM-lM-^ZM-0M-lM-^JM-$~M-kM-/M-8M-mM-^BM-$^""^19551111^M^^""~~0005~""~~CDC^ M-fM-^]M-1M-dM-:M-,M-dM-8M--M-eM-$M-.M-iM-^CM-5M-dM->M-?M-eM-1M-^@~ M-fM-^]M-1M-dM-:M-,M-iM-^CM-=M-dM-8M--M-eM-$M-.M-eM-^LM-:M-eM-^EM-+M-iM-^GM-^MM-fM-4M-2M-dM-8M-^@M-dM-8M-^AM-gM-^[M-.5M-gM-^UM-*3M-eM-^OM-7 ~M-fM-^]M-1M-dM-:M-,M-dM-8M--M-eM-$M-.M-iM-^CM-5M-dM->M-?M-eM-1M-^@~M-fM-^]M-1~100-8994~JAPAN~P~""~""|""~""~""~""~""~~VACAE~""~""~~~""&""|""~""~""~""~""~~VACAA~""~""~~~""&""|""~""~""~""~""~~VACAC~""~""~~~""&""|""~""~""~""~""~~VACAM~""~""~~~""&""|""~""~""~""~""~~VACAO~""~""~~~""&""^^""^""^^""^29^^505111155P^^^""~~0189~""~~CDC^ ^MPD1^^^PLATINUM~~050^""^MPV1^1^O^""^^^^^^^^^^^^^^^NON-VETERAN (OTHER)^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^104^MOBX^1^MZPD^1^""^""^""^""^""^""^""^""^""^0^""^""^""^""^0^""^0^""^""^""^MZSP^1^0^""^""^""^""^""^""^^""^""^MZEL^1^""^""^""^""^""^""^0^NON-VETERAN (OTHER)^""^""^""^""^""^""^""^""^""^""^""^""^""^^^^MZCT^1^1^""^""^""^""^""^""^""^MZEM^1^1^""^""^""^""^""^""^^MZFF^2^^MZIR^^MZEN^1^M^\^M


Setup Mirth for Message Receipt
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Now we are going to set-up Mirth to receive a message.
`Mirth<http://www.mirthcorp.com/>`_ is what is known as an integration engine.
An integration engine is essentially a store/transform/and forward software
for messages between different systems. Mirth is open source software and is
frequently used with VistA in production implementations. It can be downloaded
from `here<https://www.nextgen.com/products-and-services/NextGen-Connect-Integration-Engine-Downloads>`_.

Install Mirth

Set-up a Channel

Deploy Channel

Run the test again

View message in Mirth

Turn on HL7 messages in MAS Parameters
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Once we have confirmed that the system to send HL7 messages for patient
registrations seems to work, let's turn it on. You need to change field
``SEND PIMS HL7 V2.3 MESSAGES`` in file ``MAS PARAMETERS`` to ``SEND``. I
think it comes set that way by default in FOIA VistA.

.. raw:: html

  <pre>FOIA201805&gt;<strong>D P^DI</strong>


  MSC FileMan 22.1060


  Select OPTION: <strong>ENTER</strong> OR EDIT FILE ENTRIES



  Input to what File: PROTOCOL// <strong>MAS PARAMETERS</strong>    (0 entries)
  EDIT WHICH FIELD: ALL// <strong>SEND</strong>
       1   SEND PIMS HL7 V2.2 MESSAGES
       2   SEND PIMS HL7 V2.3 MESSAGES
  CHOOSE 1-2: <strong>2</strong>  SEND PIMS HL7 V2.3 MESSAGES
  THEN EDIT FIELD: <strong>&lt;enter&gt;</strong>


  Select MAS PARAMETERS ONE: <strong>`1</strong>
  SEND PIMS HL7 V2.3 MESSAGES: SEND// <strong>?</strong>
       Choose from:
         1        SEND
         0        STOP
         2        SUSPEND
  SEND PIMS HL7 V2.3 MESSAGES: SEND// <strong>1</strong>  SEND


  Select MAS PARAMETERS ONE:<strong>&lt;enter&gt;</strong>

Register a Patient
^^^^^^^^^^^^^^^^^^
Now it's time to register a patient, and see the HL7 come across. 

HL7 Receive Setup
-----------------
Xinetd Set-up
^^^^^^^^^^^^^
Message Set-up
^^^^^^^^^^^^^^
Sending Application
"""""""""""""""""""
Receiving Application
"""""""""""""""""""""
Server Protocol
"""""""""""""""
Client Protocol
"""""""""""""""
Code invoked by Client Protocol
"""""""""""""""""""""""""""""""

