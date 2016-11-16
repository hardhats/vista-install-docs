Download VistA for GT.M
=======================

A Mumps database (like VistA) is a series of routines and globals (a global
in Mumps really means a file on disk). To load VistA into GT.M, you need to
obtain the these from the CACHE.DAT distribued by the VA. Efforts are
underway to lobby the VA to distribute the FOIA instance as a set of globals
and routines; rather than in a proprietary format.

Since the establishment of OSEHRA, each update monthly update of FOIA is
exported as routines and globals in zwrite format at `Github <https://github.com/OSEHRA/VistA-M>`_.
In addition, DSS vxVistA can be obtained from `this repository <https://github.com/OSEHRA/vxVistA-M>`_
and WorldVistA can be obtained from `this repository <https://github.com/glilly/wvehr2-dewdrop>`_.

In our example, for setting up a VistA Database, we will use FOIA VistA.

Before downloading VistA, we will start by creating an empty database.

Creating an Empty GT.M Database suitable for VistA
--------------------------------------------------
Create a directory where you will place your environment. These two steps need
to be done as a superuser. The directory name doesn't matter. In this case,
it's ``foia201608`` under ``/var/db``::

    $ sudo mkdir -p /var/db/foia201608
    $ sudo chown $USER. /var/db/foia201608
    $ cd /var/db/foia201608

Then create folders to hold your routines, globals, journals, and objects. The
convention in the VistA community is to call these folders r g j and o::
    
    $ mkdir r g j o

 | Aside: Fidelity (the company behind GT.M) recommends versioning objects
 | and global directories to allow for rolling upgrades. I personally don't 
 | think this is necessary for VistA. More details can be found at the
 | `GT.M Acculturation Workshop <https://sourceforge.net/projects/fis-gtm/files/GT.M%20Acculturation%20Workshop/>`_.

 | Another aside: Various people in the VistA community create another directory
 | called "p" for patches, so that you can apply unix style "patches" to routines
 | in the "r" directory and not overwrite the original routine. The intent is
 | reasonable, but what what almost always happens is that I get calls or emails
 | on why aren't my changes showing up. VistA tools (KIDS, Fileman, VPE) are all
 | written just expecting a single routine list.

At this point, we need to create an environment file that we will need to
source in order to tell GT.M where are our routines and globals are. The reason
we need to do this is simple: GT.M bases its operations almost entirely on
environment variables from the shell. Here's the file, which I called ``env.vista``::
   
    #!/bin/bash
    # This is just a temporary variable so I don't have to type the same thing
    # over and over again.
    export vista_home="/var/db/foia201608"

    # This will set the prompt. This can be anything you want.
    # I make it something meaningful to let me know which environment I am on.
    export gtm_prompt="FOIA 2016-08>"

    # Intial Value of error trap upon VistA start-up
    #export gtm_etrap='W !,"ERROR IN STARTUP",!! D ^%ZTER HALT' # for production environments
    export gtm_etrap='B'             # for development environments

    # The location of the global directory. A global directory tells GT.M in
    # which database file we will locate a global
    export gtmgbldir="${vista_home}/g/mumps.gld"

    # The location of where GT.M was installed. 
    # You may need to adjust this based on where you installed it
    export gtm_dist="/usr/lib/fis-gtm/current/"     

    # Where the routines are. 
    # If you run 32 bit GT.M, you need to remove libgtmutil.so
    # On older versions of GT.M (<6.2), the * isn't recognized.
    export gtmroutines="${vista_home}/o*(${vista_home}/r) $gtm_dist/libgtmutil.so"
    
    # Allow relink of routine even if it is on the stack
    export gtm_link="RECURSIVE"

    # Adjust QUIT behavior to accomodate Cache bug/feature of 
    # C style function/procedure unification rather than M/Pascal style function/procedure
    # dichotomy
    export gtm_zquit_anyway=1

    # Run this routine when a process is asked to interrogate itself.
    export gtm_zinterrupt='I $$JOBEXAM^ZU($ZPOS)'

    # GT.M has non-standard default behavior for null subscripts for local
    # variables. Make it standard
    export gtm_lvnullsubs=2

    # Add GT.M to the path if not already there.
    [[ ":$PATH:" != *":${gtm_dist}"* ]] && export PATH="${PATH}:${gtm_dist}"

    # GT.M should not short-cut $SELECT and binary boolean operators
    # A default optimization.
    export gtm_side_effects=1
    export gtm_boolean=1

    # $SYSTEM Output to use to identify the box the system is running on
    export gtm_sysid="foia.2016.08.memphis.smh101.com"

    # This is for journaling. Don't turn this on yet.
    #if [ -f j/mumps.mjl ]                                                           
    #then                                                                        
    #    $gtm_dist/mupip journal -recover -backward j/mumps.mjl                      
    #fi                                                                              
    #$gtm_dist/mupip set -journal="enable,on,before,f=j/mumps.mjl" -region DEFAULT   

Once this is done, source the file using ``$ . env.vista``. Then test that
what you did works by running ``$ mumps -dir``. You should see this::

    FOIA 2016-08>

Type Control-D or "HALT" to get out.

Now we need to create the database. You can create a default database by just
running ``mupip create``, but rather than do that, we need to write some code
to tell GT.M to change its default database for VistA. I will create a file 
called ``g/db.gde``::

    ! Change the default segment's file 
    ! to be g/mumps.dat
    ! to have 4096 byte blocks
    ! to have an initial DB size of 262144*4096=1GB
    ! to allow 1000 locks
    ! On production environments, add -extension_count=0 to prevent the database
    ! -> from growing automatically. You need to monitor it and expand it yourself.
    change -segment DEFAULT -file="$vista_home/g/mumps.dat" -access_method=BG -allocation=262144  -block_size=4096 -lock_space=1000 !-extension_count=0

    ! Ditto pretty much, except this is smaller. Note that we create a new segment
    ! rather than modify an existing one.
    ! TEMPGBL unlike the others will be memory mapped to the RAM to allow instant
    ! access.
    add    -segment TEMPGBL -file="$vista_home/g/tempgbl.dat" -access_method=MM -allocation=10000   -block_size=4096 -lock_space=1000 !-extension_count=0

    ! Non-journaled static data (3 GB, intentionally not expandable)
    add    -segment STATIC -file="$vista_home/g/static.dat"   -access_method=BG -allocation=786432  -block_size=4096 -lock_space=1000 -extension_count=0

    ! Journaled mail data (1 GB, intentionally not expandable)
    add    -segment MAILMAN -file="$vista_home/g/mailman.dat" -access_method=BG -allocation=262144  -block_size=4096 -lock_space=1000 -extension_count=0

    ! Error data (not to be journaled, intentionally not expandable)
    add    -segment ERRORS -file="$vista_home/g/errors.dat"   -access_method=BG -allocation=100000  -block_size=4096 -lock_space=1000 -extension_count=0

    ! Each global node can be 16384 bytes long; subscripts can be combined to be 1019 bytes long
    change -region  DEFAULT -record_size=16384 -stdnullcoll -key_size=1019

    ! Ditto, but note that we need to assign the new region to its associated segment
    add    -region  TEMPGBL -record_size=16384 -stdnullcoll -key_size=1019 -dyn=TEMPGBL
    add    -region  STATIC  -record_size=16384 -stdnullcoll -key_size=1019 -dyn=STATIC
    add    -region  MAILMAN -record_size=16384 -stdnullcoll -key_size=1019 -dyn=MAILMAN
    add    -region  ERRORS  -record_size=16384 -stdnullcoll -key_size=1019 -dyn=ERRORS


    ! Add globals to the temporary region
    add    -name    HLTMP   -region=TEMPGBL
    add    -name    TMP     -region=TEMPGBL
    add    -name    UTILITY -region=TEMPGBL
    add    -name    XTMP    -region=TEMPGBL
    add    -name    BMXTMP  -region=TEMPGBL
    add    -name    XUTL    -region=TEMPGBL
    add    -name    VPRHTTP -region=TEMPGBL
    add    -name    ZZ*     -region=TEMPGBL

    ! Add globals to the static segment
    add    -name    %Z        -region=STATIC
    add    -name    DOPT      -region=STATIC
    add    -name    DIA(50.6:50.68) -region=STATIC
    add    -name    DIA(56)    -region=STATIC
    add    -name    ICD*       -region=STATIC
    add    -name    ICPT       -region=STATIC
    add    -name    LEX*       -region=STATIC
    add    -name    PSNDF      -region=STATIC
    add    -name    XVEMS      -region=STATIC

    ! Add globals to the mail segment
    add    -name    XM*        -region=MAILMAN

    ! Add globals to the Error segment
    add    -name    %ZTER     -region=ERRORS

    ! show all for verification
    show -all


Once you save the file, run it::

	$ mumps -run ^GDE < g/db.gde |& tee g/db.gde.out

A successful invocation will show you this output on the screen and saved into
g/db.gde.out as well::

	%GDE-I-GDUSEDEFS, Using defaults for Global Directory 
		/var/db/foia201608/g/mumps.gld

	...
	GDE> 

								   *** TEMPLATES ***
																			  Std      Inst
												 Def     Rec   Key Null       Null     Freeze   Qdb      Epoch
	 Region                                     Coll    Size  Size Subs       Coll Jnl on Error Rndwn    Taper
	 -----------------------------------------------------------------------------------------------------------
	 <default>                                     0     256    64 NEVER      N    N   DISABLED DISABLED ENABLED

	 Segment          Active              Acc Typ Block      Alloc Exten Options
	 ------------------------------------------------------------------------------
	 <default>          *                 BG  DYN  1024        100   100 GLOB =1024
																		 LOCK = 40
																		 RES  =   0
																		 ENCR = OFF
																		 MSLT =1024
																		 DALL=YES
	 <default>                            MM  DYN  1024        100   100 DEFER
																		 LOCK = 40
																		 MSLT =1024
																		 DALL=YES

			 *** NAMES ***
	 Global                             Region
	 ------------------------------------------------------------------------------
	 %Z                                 STATIC
	 %ZTER                              ERRORS
	 *                                  DEFAULT
	 BMXTMP                             TEMPGBL
	 DIA(50.6:50.68)                    STATIC
	 DIA(56)                            STATIC
	 DOPT                               STATIC
	 HLTMP                              TEMPGBL
	 ICD*                               STATIC
	 ICPT                               STATIC
	 LEX*                               STATIC
	 PSNDF                              STATIC
	 TMP                                TEMPGBL
	 UTILITY                            TEMPGBL
	 VPRHTTP                            TEMPGBL
	 XM*                                MAILMAN
	 XTMP                               TEMPGBL
	 XUTL                               TEMPGBL
	 XVEMS                              STATIC
	 ZZ*                                TEMPGBL

									*** REGIONS ***
																									Std      Inst
									 Dynamic                          Def      Rec   Key Null       Null     Freeze   Qdb      Epoch
	 Region                          Segment                         Coll     Size  Size Subs       Coll Jnl on Error Rndwn    Taper
	 ----------------------------------------------------------------------------------------------------------------------------------
	 DEFAULT                         DEFAULT                            0    16384  1019 NEVER      Y    N   DISABLED DISABLED ENABLED
	 ERRORS                          ERRORS                             0    16384  1019 NEVER      Y    N   DISABLED DISABLED ENABLED
	 MAILMAN                         MAILMAN                            0    16384  1019 NEVER      Y    N   DISABLED DISABLED ENABLED
	 STATIC                          STATIC                             0    16384  1019 NEVER      Y    N   DISABLED DISABLED ENABLED
	 TEMPGBL                         TEMPGBL                            0    16384  1019 NEVER      Y    N   DISABLED DISABLED ENABLED

									*** SEGMENTS ***
	 Segment                         File (def ext: .dat)Acc Typ Block      Alloc Exten Options
	 -------------------------------------------------------------------------------------------
	 DEFAULT                         $vista_home/g/mumps.dat
														 BG  DYN  4096     262144   100 GLOB=1024
																						LOCK=1000
																						RES =   0
																						ENCR=OFF
																						MSLT=1024
																						DALL=YES
	 ERRORS                          $vista_home/g/errors.dat
														 BG  DYN  4096     100000     0 GLOB=1024
																						LOCK=1000
																						RES =   0
																						ENCR=OFF
																						MSLT=1024
																						DALL=YES
	 MAILMAN                         $vista_home/g/mailman.dat
														 BG  DYN  4096     262144     0 GLOB=1024
																						LOCK=1000
																						RES =   0
																						ENCR=OFF
																						MSLT=1024
																						DALL=YES
	 STATIC                          $vista_home/g/static.dat
														 BG  DYN  4096     786432     0 GLOB=1024
																						LOCK=1000
																						RES =   0
																						ENCR=OFF
																						MSLT=1024
																						DALL=YES
	 TEMPGBL                         $vista_home/g/tempgbl.dat
														 MM  DYN  4096      10000   100 GLOB=1024
																						LOCK=1000
																						RES =   0
																						ENCR=OFF
																						MSLT=1024
																						DALL=YES

									  *** MAP ***
	   -  -  -  -  -  -  -  -  -  - Names -  -  - -  -  -  -  -  -  -
	 From                            Up to                            Region / Segment / File(def ext: .dat)
	 --------------------------------------------------------------------------------------------------------------------------
	 %                               %Z                               REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 %Z                              %Z0                              REG = STATIC
																	  SEG = STATIC
																	  FILE = $vista_home/g/static.dat
	 %Z0                             %ZTER                            REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 %ZTER                           %ZTER0                           REG = ERRORS
																	  SEG = ERRORS
																	  FILE = $vista_home/g/errors.dat
	 %ZTER0                          BMXTMP                           REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 BMXTMP                          BMXTMP0                          REG = TEMPGBL
																	  SEG = TEMPGBL
																	  FILE = $vista_home/g/tempgbl.dat
	 BMXTMP0                         DIA(50.6)                        REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 DIA(50.6)                       DIA(50.68)                       REG = STATIC
																	  SEG = STATIC
																	  FILE = $vista_home/g/static.dat
	 DIA(50.68)                      DIA(56)                          REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 DIA(56)                         DIA(56)++                        REG = STATIC
																	  SEG = STATIC
																	  FILE = $vista_home/g/static.dat
	 DIA(56)++                       DOPT                             REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 DOPT                            DOPT0                            REG = STATIC
																	  SEG = STATIC
																	  FILE = $vista_home/g/static.dat
	 DOPT0                           HLTMP                            REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 HLTMP                           HLTMP0                           REG = TEMPGBL
																	  SEG = TEMPGBL
																	  FILE = $vista_home/g/tempgbl.dat
	 HLTMP0                          ICD                              REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 ICD                             ICE                              REG = STATIC
																	  SEG = STATIC
																	  FILE = $vista_home/g/static.dat
	 ICE                             ICPT                             REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 ICPT                            ICPT0                            REG = STATIC
																	  SEG = STATIC
																	  FILE = $vista_home/g/static.dat
	 ICPT0                           LEX                              REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 LEX                             LEY                              REG = STATIC
																	  SEG = STATIC
																	  FILE = $vista_home/g/static.dat
	 LEY                             PSNDF                            REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 PSNDF                           PSNDF0                           REG = STATIC
																	  SEG = STATIC
																	  FILE = $vista_home/g/static.dat
	 PSNDF0                          TMP                              REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 TMP                             TMP0                             REG = TEMPGBL
																	  SEG = TEMPGBL
																	  FILE = $vista_home/g/tempgbl.dat
	 TMP0                            UTILITY                          REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 UTILITY                         UTILITY0                         REG = TEMPGBL
																	  SEG = TEMPGBL
																	  FILE = $vista_home/g/tempgbl.dat
	 UTILITY0                        VPRHTTP                          REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 VPRHTTP                         VPRHTTP0                         REG = TEMPGBL
																	  SEG = TEMPGBL
																	  FILE = $vista_home/g/tempgbl.dat
	 VPRHTTP0                        XM                               REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 XM                              XN                               REG = MAILMAN
																	  SEG = MAILMAN
																	  FILE = $vista_home/g/mailman.dat
	 XN                              XTMP                             REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 XTMP                            XTMP0                            REG = TEMPGBL
																	  SEG = TEMPGBL
																	  FILE = $vista_home/g/tempgbl.dat
	 XTMP0                           XUTL                             REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 XUTL                            XUTL0                            REG = TEMPGBL
																	  SEG = TEMPGBL
																	  FILE = $vista_home/g/tempgbl.dat
	 XUTL0                           XVEMS                            REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 XVEMS                           XVEMS0                           REG = STATIC
																	  SEG = STATIC
																	  FILE = $vista_home/g/static.dat
	 XVEMS0                          ZZ                               REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 ZZ                              Za                               REG = TEMPGBL
																	  SEG = TEMPGBL
																	  FILE = $vista_home/g/tempgbl.dat
	 Za                              ...                              REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	 LOCAL LOCKS                                                      REG = DEFAULT
																	  SEG = DEFAULT
																	  FILE = $vista_home/g/mumps.dat
	GDE> 
	%GDE-I-VERIFY, Verification OK

	%GDE-I-GDCREATE, Creating Global Directory file 
		/var/db/foia201608/g/mumps.gld

If you fail, you will see something similar to the following at the end of the
output::

	%GDE-I-VERIFY, Verification FAILED

	%GDE-E-VERIFY, Verification FAILED

At this point, we are ready to create our databases. This is easy::
	
	$ mupip create
	Created file /var/db/foia201608/g/mumps.dat
	Created file /var/db/foia201608/g/errors.dat
	Created file /var/db/foia201608/g/mailman.dat
	Created file /var/db/foia201608/g/static.dat
	Created file /var/db/foia201608/g/tempgbl.dat

To check that everything works fine, run ``mumps -dir`` and then ``DO ^%GD``
and ``DO ^%RD``. The first will open all the database files for searching and
open a shared memory segment on your machine. The second will make sure that
your ``$gtmroutines`` variable is correct::

    $ mumps -dir

    FOIA 2016-08>D ^%GD

    Global Directory

    Global ^*

    Total of 0 globals.

    Global ^

    FOIA 2016-08>D ^%RD

    Routine directory
    Routine: *

    Total of 0 routines.

    Routine: 

It's common with all Unix software relying on POSIX/SysV Shared Memory to
report errors with ``shmget()``. If you when you are trying to run ^%GD, 
you need to increase your shared memory limits. I will leave you to google
that on your own.

Loading VistA Into the GT.M Database we just Created
----------------------------------------------------
I said we will use FOIA VistA. Make sure that git is installed on your machine,
and then run the following command (this command may take up to 1 hour to
run, based on your internet connection)::

    $ git clone -b foia --single-branch --depth=1 https://github.com/OSEHRA/VistA-M.git

Next we need to copy the routines to VistA (takes about 30 seconds). There are
quotes around the ``{}`` because the paths contain ::

    $ find VistA-M -name '*.m' -exec cp "{}" r/ \;

Next we need to load the globals. We use the versatile ``mupip load`` command
for that. Note that mupip load wants quotes sent down from the shell for any
paths that contain spaces; and these do. Again, we tee our output because there
is so much of it and because we need to visually inspect that everything got
loaded::

    $ find VistA-M -name '*.zwr' -exec echo {} \; -exec mupip load \"{}\" \; |& tee g/foia201608-load.log

Verify that none of the globals failed to import::

    $ fgrep '%GTM' g/foia201608-load.log | wc -l

If you get an output that isn't zero, you need to visually inspect what
happened.

After we are done with this, we will repeat our smoke test with %GD and %RD::

    $ mumps -dir

    FOIA 2016-08>D ^%GD

    Global Directory

    Global ^*
    ...
    Total of 391 globals.

    FOIA 2016-08>D ^%RD

    Routine directory
    Routine: *
    ...
    Total of 35547 routines.

At this point we are done loading VistA. It's time to enable journaling on
all the regions we want. That can be a separate script, but I put it with my
env script so that everything can be in one place and I only have to source
one file to activate my VistA instance. Add this to the end. This recovers
the database if it was journaled and then enables journaling. ::

	# This is journaling.                                                                                                                                   
	if [ -f j/mumps.mjl ]; then                                                     
		$gtm_dist/mupip journal -recover -backward ${vista_home}/j/mumps.mjl                      
	fi                                                                              
	if [ -f j/mailman.mjl ]; then                                                   
		$gtm_dist/mupip journal -recover -backward ${vista_home}/j/mumps.mjl                      
	fi                                                                              
													
	if (( $(find ${vista_home}/j -name '*_*' -mtime +3 -print | wc -l) > 0 )); then 
		echo "Deleting old journals"                                                
		find ${vista_home}/j -name '*_*' -mtime +3 -print -delete                   
	fi                                                                              
								
	$gtm_dist/mupip set -journal="enable,on,before,f=j/mumps.mjl" -region DEFAULT   
	$gtm_dist/mupip set -journal="enable,on,before,f=j/mailman.mjl" -region MAILMAN   
