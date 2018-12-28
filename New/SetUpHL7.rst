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
actually the full content of the message. The actual message transmitted over
TCP contains several control characters to delimit the start and the end of the
message. (TCP is a stream protocol; so you must provide either message lengths
or delimiters to deliniate the beginning and end of a message). This is called
the HL7 Minimal Lower Layer Protocol (MLLP). So a full HL7 message over TCP
looks like this:

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

If taskman is already running, run ``D ^XUP`` and run ``HL AUTOSTART LINK MANAGER``
and ``HL TASK RESTART`` in turn.

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

In this example, what I will do is receive the message using the netcat program,
which is a generic socket listener; and then we will download Mirth and use it
to receive a message.

Create Logical Link
^^^^^^^^^^^^^^^^^^^
Enable Logical Link
^^^^^^^^^^^^^^^^^^
Create Subscriber Client & Receiving Application
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Remember to put the Logical Link

Setup Netcat for Message Receipt
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Setup Mirth for Message Receipt
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Turn on HL7 messages in MAS Parameters
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Register a Patient
^^^^^^^^^^^^^^^^^^
Note RGADP crash

View Message
^^^^^^^^^^^^

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

