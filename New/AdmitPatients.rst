Admit Patients into Hospital
============================
Authors: Sam Habiel. Thank you for the transcripts provided by Joanne Brougham for setting up ADT.

License: |license|

.. |license| image:: https://i.creativecommons.org/l/by/4.0/80x15.png 
   :target: http://creativecommons.org/licenses/by/4.0/ 

Last updated in May 2018.

If you have reached this point, it means that you have finished `setting up the
wards <./WardSetup.html>`_.

This is the last step for configuring a hospital. We will admit two patients to
cardiology, and one patient to dermatology; and then show the display in CPRS.
We will also show the printout of the Gains and Losses report tomorrow after the
task we scheduled runs overnight.

We can register patients at the same time as admitting them; so that simplifies
things somewhat. From the same ADT Manager Menu we visited before, we go to the
``Bed Control Menu``. From there, we pick ``Admit a Patient``.

.. raw:: html

  <pre>Select ADT Manager Menu <TEST ACCOUNT> Option: Bed Control Menu


            Admit a Patient
            Cancel a Scheduled Admission
            Check-in Lodger
            Delete Waiting List Entry
            Detailed Inpatient Inquiry
            Discharge a Patient
            DRG Calculation
            Extended Bed Control
            Lodger Check-out
            Provider Change
            Schedule an Admission
            Seriously Ill List Entry
            Switch Bed
            Transfer a Patient
            Treating Specialty Transfer
            Waiting List Entry/Edit

  Select Bed Control Menu <TEST ACCOUNT> Option: Admit a Patient

  Admit PATIENT: DUCK,DAFFY
     ARE YOU ADDING 'DUCK,DAFFY' AS A NEW PATIENT (THE 2ND)? No// Y  (Yes)
     PATIENT SEX: M MALE
     PATIENT DATE OF BIRTH: 11/11/78  (NOV 11, 1978)
     PATIENT SOCIAL SECURITY NUMBER: P  202111178P
     PATIENT PSEUDO SSN REASON: N NO SSN ASSIGNED
     PATIENT TYPE: NON-VETERAN (OTHER)
     PATIENT VETERAN (Y/N)?: N NO
     PATIENT SERVICE CONNECTED?: N NO
     PATIENT MULTIPLE BIRTH INDICATOR: N NO

     ...searching for potential duplicates

     No potential duplicates have been identified.

     ...adding new patient...new patient added

  Patient name components--
  FAMILY (LAST) NAME: DUCK//
  GIVEN (FIRST) NAME: DAFFY//
  MIDDLE NAME:
  PREFIX:
  SUFFIX:
  DEGREE:

  NEW PATIENT!  WANT TO LOAD 10-10 DATA NOW? Yes// N  (No)

  Means Test not required based on available information

  Status      : PATIENT HAS NO INPATIENT OR LODGER ACTIVITY IN THE COMPUTER

  Religion    :                          Marital Status :
  Eligibility :  (NOT VERIFIED)

  <C>ontinue, <M>ore, or <Q>uit?  CONTINUE// CONTINUE

  Select ADMISSION DATE:  NOW//   (MAY 17,2018@14:27:36)

  SURE YOU WANT TO ADD 'MAY 17,2018@14:27:36' AS A NEW ADMISSION DATE? // Y  (Yes)
  DOES THE PATIENT WISH TO BE EXCLUDED FROM THE FACILITY DIRECTORY?: N  NO
  ADMITTING REGULATION: ??
     When admitting a patient, you must choose an active ADMITTING REGULATION
     which best describes the category under which this patient is being
     admitted.


     Choose from:
     1            ACTIVE PSYCHOSIS                  17.33
     4            OBSERVATION & EXAMINATION         17.45
     5            ACTIVE SERVICE                    17.46(b)
     8            EMERGENCY FOR PUBLIC              17.46(c)(1)
     24           OTHER FEDERAL AGENCIES            17.46(b)
     25           ALLIED VETERANS                   17.46(b)
     26           INELIGIBLE/PRESUMED DISCHARGE     17.46(c)(2)
     27           VA EMPLOYEES/FAMILY               17.46(c)(3)
     28           SHARING AGREEMENT                 17.46(d)
     29           RESEARCH VOLUNTEERS (NONVET)      17.46(c)
     30           SC VET FOR ANY CONDITION          17.47(a)(1)
     31           RECEIPT/ELIGIBLE 38 USC 1151      17.47(a)(3)
     32           DISCHARGED FOR DISABILITY         17.47(a)(2)
     33           FORMER PRISONER OF WAR            17.47(a)(4)
     34           AO/IR/EC EXPOSURE                 17.47(a)(5)
     35           SAW, MB, & WW1                    17.47(a)(6)
     36           ELIGIBLE FOR STATE MEDICAID       17.48(d)(1)(i)
     37           IN RECEIPT OF VA PENSION          17.47(a)(7)
     38           CATEGORY A INCOME VETERANS        17.47(a)(7)
     41           CATEGORY C INCOME VETERANS        17.47(d)
     42           RESEARCH PATIENTS - VETERANS      17.47Z
     43           CZECH AND POLISH VETERANS         17.55
     44           NON-VA FOR SC DISABILITY          17.50b(a)(1)(i)
     45           NON-VA (DISABILITY DISCHARGED)    17.50b(a)(1)(ii)
     46           NON-VA FOR ADJUNCT CONDITION      17.50b(a)(1)(iv)
     47           NON-VA FOR VOCATIONAL REHAB       17.50b(a)(1)(v)
     48           NON-VA EMERGENCY (WHILE IN VA)    17.50b(a)(3)
     49           NON-VA FOR FEMALE VETERANS        17.50b(a)(4)
     52           NON-VA (AK,HA,VI,TERR)            17.50b(a)(6)
     53           NONVA EMERG DURING AUTH TRAVEL    17.50b(a)(8)
     54           NONVA INDEP VA OPT CLINICS        17.50b(a)(9)
     55           FEE SVC FOR OPT/NSC               17.50b(a)(2)(ii)
     56           FEE SVC FOR VETS 50% OR MORE      17.50b(a)(2)(i)
     57           FEE SVC FOR MB,WW1,A&A,HB         17.50b(a)(2)(iii)
     58           OPT DENTAL (POW >90 DAYS)         17.50(a)(7)
     59           NON-VA/UNAUTH FOR SC COND         17.80(a)(1)
     60           NONVA/UNAUTH (ADJUNCT COND)       17.80(a)(2)
     61           NONVA/UNAUTH (P&T DISABILITY)     17.80(a)(3)
     62           VOCATIONAL REHABILITATION         17.80(a)(4)
     63           STATE NH, DOM OR HOSP.            17.1666d
     67           DOMICILIARY CARE                  17.47(e)(1)
                                     to exit:
     68           COMMUNITY NURSING HOME CARE       17.51
     72           CHAMPVA                           17.54
     73           PRESUMPTION OF SC                 17.35(b)
     74           HOSP/NH IN PHILLIPINES (NONVA)    17.38
     75           NON-VA (P&T DISABILITY)           17.50b(a)(1)(iii)
     202          NON-VA FOR FEMALE VET+NEWBORN     17.38

  ADMITTING REGULATION: 4  OBSERVATION & EXAMINATION  17.45
  TYPE OF ADMISSION: ?
       Enter the type of movement for this patient on the date/time entered.
       Transaction types must match and only allowable types can be chosen.
   Answer with FACILITY MOVEMENT TYPE NUMBER, or NAME, or PRINT NAME
   Do you want the entire FACILITY MOVEMENT TYPE List? Y  (Yes)
     Choose from:
     1            DIRECT     ADMISSION     ACTIVE
     2            OPT-NSC     ADMISSION     ACTIVE
     3            OPT-SC     ADMISSION     ACTIVE
     4            A/C     ADMISSION     ACTIVE
     5            TRANSFER IN     ADMISSION     ACTIVE
     6            NON-VETERAN     ADMISSION     ACTIVE
     7            WAITING LIST     ADMISSION     ACTIVE
     8            PBC     ADMISSION     ACTIVE

  TYPE OF ADMISSION: 1  DIRECT     ADMISSION     ACTIVE
  DIAGNOSIS [SHORT]: Hates Bugs Bunny!
  WARD LOCATION: ?
          Enter the ward on which the patient was placed.
          Don't allow an inactive ward or one not on bed census
      Answer with WARD LOCATION NAME, or SERVICE, or NSERV, or SYNONYM
     Choose from:
     3 EAST
     3 WEST

  WARD LOCATION: 3 WEST
  ROOM-BED: ?
       Enter the ROOM-BED to which this patient is assigned.
       Only those unoccupied beds on ward selected


  CHOOSE FROM

     301-A             301-B             302-A             302-B
     303-S

  Select from the above listing the bed you wish to assign this patient.
  Enter two question marks for a more detailed list of available beds.
  ROOM-BED: 301-A
  FACILITY TREATING SPECIALTY: ?
       Enter the TREATING SPECIALTY assigned to this patient with this movement.
       This must be an active treating specialty.
       Allows only active treating specialties.
   Answer with FACILITY TREATING SPECIALTY NAME
   Do you want the entire FACILITY TREATING SPECIALTY List? Y  (Yes)
     Choose from:
     ANESTHESIOLOGY        ANESTHESIOLOGY
     CARDIOLOGY        CARDIOLOGY     CARD
     DERMATOLOGY        DERMATOLOGY     DERM
     DOMICILIARY CHV        DOMICILIARY CHV
     ED OBSERVATION        ED OBSERVATION
     HOSPICE FOR ACUTE CARE        HOSPICE FOR ACUTE CARE
     MEDICAL OBSERVATION        MEDICAL OBSERVATION
     MEDICAL STEP DOWN        MEDICAL STEP DOWN
     NEUROLOGY OBSERVATION        NEUROLOGY OBSERVATION
     NH HOSPICE        NH HOSPICE
     NH LONG STAY DEMENTIA CARE        NH LONG STAY DEMENTIA CARE
     NH LONG STAY SPINAL CORD INJ        NH LONG STAY SPINAL CORD INJ
     NH LONG-STAY CONTINUING CARE        NH LONG-STAY CONTINUING CARE
     NH LONG-STAY MH RECOVERY        NH LONG-STAY MH RECOVERY
     NH RESPITE CARE (NHCU)        NH RESPITE CARE (NHCU)
     NH SHORT STAY DEMENTIA CARE        NH SHORT STAY DEMENTIA CARE
     NH SHORT STAY REHABILITATION        NH SHORT STAY REHABILITATION
     NH SHORT STAY RESTORATIVE        NH SHORT STAY RESTORATIVE
     NH SHORT STAY SKILLED NURSING        NH SHORT STAY SKILLED NURSING
     NH SHORT-STAY CONTINUING CARE        NH SHORT-STAY CONTINUING CARE
                                     to exit: ^

  FACILITY TREATING SPECIALTY: CARDIOLOGY       CARDIOLOGY     CARD
  PRIMARY PHYSICIAN: CPRS,USER       UC
  ATTENDING PHYSICIAN: CPRS,USER       UC
  DIAGNOSIS:
  Hates Bugs Bunny!

    Edit? NO//
  SOURCE OF ADMISSION: ??
     This field contains the source of admission of the veteran, or
     where he was admitted to the hospital from, i.e. community, other
     facility, etc.


     Choose from:
     1D        VA NURSING HOME CARE UNIT     HOSPITAL
     1E        VA DOMICILLARY     HOSPITAL
     1G        CONTRACT CNH (UNDER VA AUSPICES)     HOSPITAL
     1H        COMMUNITY NURSING HOME NOT UNDER VA AUSPICES     HOSPITAL
     1J        GOVNT(NON FED) MENTAL HOSP NOT UNDER VA AUSPICES     HOSPITAL
     1K        ALL OTHER NON VA HOSP NOT UNDER VA AUSPICES     HOSPITAL
     1L        STATE HOME (DOM OR NHC)     HOSPITAL
     1M        OTHER DIRECT     HOSPITAL
     1P        OUTPATIENT TREATMENT     HOSPITAL
     1R        RESEARCH - VETERAN     HOSPITAL
     1S        RESEARCH NON-VETERAN     HOSPITAL
     1T        OBSERVATION AND EXAMINATION     HOSPITAL
     2A        NON-VETERAN OTHER THAN MILITARY     HOSPITAL
     2B        MILITARY PERS NOT DIRECTLY FROM MILT HOSP     HOSPITAL
     2C        MILITARY PERS BY TRANSFER FROM A MILT HOSP     HOSPITAL
     3A        TRANSFER IN FROM ANOTHER VA HOSPITAL     HOSPITAL
     3B        TRANSFER IN FROM OTH FED HOSP UNDER VA AUSP     HOSPITAL
     3C        TRANS IN FROM ANY OTHER NON-VA HOSP UNDER VA AUSP     HOSPITAL
     3D        TRANS FROM VAMC TO MILITARY FAC. UNDER VA AUSP     MILITARY HOSPITA
  L
                                     to exit:
     3E        TRANS FROM VAH-VAH-CONT HOS SINCE 7/1/86 OR PRIOR     HOSPITAL
     4A        FROM VA HOSPITAL     DOMICILIARY
     4B        FROM VA HOSPITAL ON NON-BED-CARE     DOMICILIARY
     4C        FROM VA NURSING HOME CARE UNIT     DOMICILIARY
     4D        FROM ANOTHER VA DOM     DOMICILIARY
     4F        FROM COMMUNITY HOSPITAL UNDER VA AUSPICES     DOMICILIARY
     4G        FROM COMMUNITY HOSPITAL NOT UNDER VA AUSPICES     DOMICILIARY
     4H        FROM COMMUNITY NURSING HOME UNDER VA AUSPICES     DOMICILIARY
     4J        FROM COMMUNITY NURSING HOME NOT UNDER VA AUSPICES     DOMICILIARY
     4K        FROM STATE HOME DOM     DOMICILIARY
     4L        FROM STATE NURSING HOME CARE     DOMICILIARY
     4M        FROM MILITARY HOSP     DOMICILIARY
     4N        FROM OTHER FEDERAL HOSP UNDER VA AUSP     DOMICILIARY
     4P        FROM OTHER FEDERAL HOSP NOT UNDER VA AUSPICES     DOMICILIARY
     4Q        FROM OTHER GOV HOSP(NON FED) NOT UNDER VA AUSP     DOMICILIARY
     4R        OTHER GOVERNMENT HOSP(NON FED) UNDER VA AUSPICES     DOMICILIARY
     4S        REFERRED BY OUTPATIENT CLINIC     DOMICILIARY
     4T        REFERRED BY WELFARE AGENCY(LOCAL OR REGIONAL)     DOMICILIARY
     4U        REFERRED BY NATIONAL SERV ORGAN (LOCAL OR REG)     DOMICILIARY
     4W        SELF-WALKIN     DOMICILIARY
     4Y        ALL OTHER SOURCES, UNKNOWN OR NO INFO     DOMICILIARY
     5A        VA MEDICAL CENTER     NHCU
                                     to exit:
     5B        NON-VA HOSPITAL UNDER VA AUSPICES     NHCU
     5C        VA DOMICILLARY     NHCU
     5E        TRANSFER IN FROM ANOTHER VA NHCU     NHCU
     5F        TRANSFER IN FROM COMMUNITY HOME UNDER VA AUSPICES     NHCU
     5G        DIRECT ADMISSION FROM ALL OTHER SOURCES     NHCU
     6A        DIRECT ADMISSION FROM A VA HOSPITAL     CNH
     6B        TRANSFER IN FROM A VA NHCU     CNH
     6C        TRANS IN FROM ANOTHER CNH UNDER VA AUSPICES     CNH
     6D        DIRECT ADMISSION FROM ALL OTHER SOURCES     CNH
     7B        DIRECT ADM OF ACTIVE DUTY PERS FROM MILT HOSP     CNH

  SOURCE OF ADMISSION: 1T       OBSERVATION AND EXAMINATION     HOSPITAL
  Patient Admitted


  CONDITION: SERIOUSLY ILL//   SERIOUSLY ILL

  **** New Admission Message Transmitted to MIS ****

  Updating PTF Record #1...

  Now updating ward MPCR information...completed.

  Updating automated team lists...completed.
  Executing HL7 ADT Messaging
  Executing HL7 ADT Messaging (RAI/MDS)

  Updating claims tracking ... no action taken.

  ...Inpatient Medications check...
  ...discontinuing Inpatient Medication orders....done...
  Entering a request in the HINQ suspense file...
  No HINQ string created entry not entered.completed.

  Updating visit status...completed.
  
  Admit PATIENT: RUNNER,ROAD
   ARE YOU ADDING 'RUNNER,ROAD' AS A NEW PATIENT (THE 3RD)? No// Y  (Yes)
   PATIENT SEX: F FEMALE
   PATIENT DATE OF BIRTH: 11/11/22  (NOV 11, 1922)
   PATIENT SOCIAL SECURITY NUMBER: P  606111122P
   PATIENT PSEUDO SSN REASON: N NO SSN ASSIGNED
   PATIENT TYPE: NON-VETERAN (OTHER)
   PATIENT VETERAN (Y/N)?: N NO
   PATIENT SERVICE CONNECTED?: N NO
   PATIENT MULTIPLE BIRTH INDICATOR: N NO

   ...searching for potential duplicates

   No potential duplicates have been identified.

   ...adding new patient...new patient added

  Patient name components--
  FAMILY (LAST) NAME: RUNNER//
  GIVEN (FIRST) NAME: ROAD//
  MIDDLE NAME:
  PREFIX:
  SUFFIX:
  DEGREE:

  NEW PATIENT!  WANT TO LOAD 10-10 DATA NOW? Yes//   (Yes)
                PATIENT DEMOGRAPHIC DATA, SCREEN <1>
  RUNNER,ROAD;    606-11-1122P                                NON-VETERAN (OTHER)
  ===============================================================================

  [1]    Name: RUNNER,ROAD                    SS: 606-11-1122P
          DOB: NOV 11,1922           PSSN Reason: No SSN Assigned
       Family: RUNNER                  Birth Sex: FEMALE  MBI: NO
        Given: ROAD                    [2] Alias: < No alias entries on file >
       Middle:
       Prefix:
       Suffix:
       Degree:
       Self-Identified Gender Identity: UNANSWERED
  [3] Remarks: NO REMARKS ENTERED FOR THIS PATIENT
  [4] Permanent Mailing Address:                  [5] Temporary Mailing Address:
           STREET ADDRESS UNKNOWN                 NO TEMPORARY ADDRESS
           UNK. CITY/STATE

     County: UNANSWERED                      County: NOT APPLICABLE
      Phone: UNANSWERED                       Phone: NOT APPLICABLE
     Office: UNANSWERED                     From/To: NOT APPLICABLE
   Bad Addr:
  <RET> to CONTINUE, 1-5 or ALL to EDIT, ^N for screen N or '^' to QUIT: ^

  CONSISTENCY CHECKER TURNED OFF!!
  Patient is exempt from Copay.

  Means Test not required based on available information

  Status      : PATIENT HAS NO INPATIENT OR LODGER ACTIVITY IN THE COMPUTER

  Religion    :                          Marital Status :
  Eligibility :  (NOT VERIFIED)

  <C>ontinue, <M>ore, or <Q>uit?  CONTINUE// CONTINUE

  Select ADMISSION DATE:  NOW//   (MAY 17,2018@17:03:32)

  SURE YOU WANT TO ADD 'MAY 17,2018@17:03:32' AS A NEW ADMISSION DATE? // Y  (Yes)
  DOES THE PATIENT WISH TO BE EXCLUDED FROM THE FACILITY DIRECTORY?: N  NO
  ADMITTING REGULATION: 4  OBSERVATION & EXAMINATION  17.45
  TYPE OF ADMISSION: 1  DIRECT     ADMISSION     ACTIVE
  DIAGNOSIS [SHORT]: TIRED OF RUNNING
  WARD LOCATION: 3 WEST
  ROOM-BED: ?
       Enter the ROOM-BED to which this patient is assigned.
       Only those unoccupied beds on ward selected


  CHOOSE FROM

     301-B             302-A             302-B             303-S

  Select from the above listing the bed you wish to assign this patient.
  Enter two question marks for a more detailed list of available beds.
  ROOM-BED: 303-S
  FACILITY TREATING SPECIALTY: CARDIOLOGY       CARDIOLOGY     CARD
  PRIMARY PHYSICIAN:  ??
       Enter the PROVIDER assigned to this patient with this movement.
       Select active providers only.


     Choose from:
     CPRS,USER      CPRS,USER     UC

  PRIMARY PHYSICIAN: CPRS,USER       UC
  ATTENDING PHYSICIAN:    CPRS,USER     UC
  DIAGNOSIS:
  TIRED OF RUNNING

    Edit? NO//
  SOURCE OF ADMISSION: 1T       OBSERVATION AND EXAMINATION     HOSPITAL
  Patient Admitted


  CONDITION: SERIOUSLY ILL// N??
       Enter 'S' if this patient is seriouslly ill or '@' to delete.  Enter
       nothing if the patient is not seriously ill.
       Choose from:
         S        SERIOUSLY ILL
  CONDITION: SERIOUSLY ILL// @

  **** New Admission Message Transmitted to MIS ****

  Updating PTF Record #2...

  Now updating ward MPCR information...completed.

  Updating automated team lists...completed.
  Executing HL7 ADT Messaging
  Executing HL7 ADT Messaging (RAI/MDS)

  Updating claims tracking ... no action taken.

  ...Inpatient Medications check...
  ...discontinuing Inpatient Medication orders....done...
  Entering a request in the HINQ suspense file...
  No HINQ string created entry not entered.completed.

  Updating visit status...completed.
  
  Admit PATIENT: COYOTE,WILEY
   ARE YOU ADDING 'COYOTE,WILEY' AS A NEW PATIENT (THE 4TH)? No// Y  (Yes)
   PATIENT SEX: M MALE
   PATIENT DATE OF BIRTH: 11/11/87  (NOV 11, 1987)
   PATIENT SOCIAL SECURITY NUMBER: P  801111187P
   PATIENT PSEUDO SSN REASON: N NO SSN ASSIGNED
   PATIENT TYPE: NON-VETERAN (OTHER)
   PATIENT VETERAN (Y/N)?: N NO
   PATIENT SERVICE CONNECTED?: N NO
   PATIENT MULTIPLE BIRTH INDICATOR: N NO

   ...searching for potential duplicates

   No potential duplicates have been identified.

   ...adding new patient...new patient added

  Patient name components--
  FAMILY (LAST) NAME: COYOTE//
  GIVEN (FIRST) NAME: WILEY//
  MIDDLE NAME:
  PREFIX:
  SUFFIX:
  DEGREE:

  NEW PATIENT!  WANT TO LOAD 10-10 DATA NOW? Yes// N  (No)

  Means Test not required based on available information

  Status      : PATIENT HAS NO INPATIENT OR LODGER ACTIVITY IN THE COMPUTER

  Religion    :                          Marital Status :
  Eligibility :  (NOT VERIFIED)

  <C>ontinue, <M>ore, or <Q>uit?  CONTINUE// CONTINUE

  Select ADMISSION DATE:  NOW//   (MAY 17,2018@17:10:14)

  SURE YOU WANT TO ADD 'MAY 17,2018@17:10:14' AS A NEW ADMISSION DATE? // Y  (Yes)
  DOES THE PATIENT WISH TO BE EXCLUDED FROM THE FACILITY DIRECTORY?: N  NO
  ADMITTING REGULATION: 4  OBSERVATION & EXAMINATION  17.45
  TYPE OF ADMISSION: 1  DIRECT     ADMISSION     ACTIVE
  DIAGNOSIS [SHORT]: Burned by Road Runner
  WARD LOCATION: 3 EAST
  ROOM-BED: ?
       Enter the ROOM-BED to which this patient is assigned.
       Only those unoccupied beds on ward selected


  CHOOSE FROM

     311-A             311-B             312-A             312-B
     313-S

  Select from the above listing the bed you wish to assign this patient.
  Enter two question marks for a more detailed list of available beds.
  ROOM-BED: 313-S
  FACILITY TREATING SPECIALTY: DERMATOLOGY       DERMATOLOGY     DERM
  PRIMARY PHYSICIAN:    CPRS,USER     UC
  ATTENDING PHYSICIAN:    CPRS,USER     UC
  DIAGNOSIS:
  Burned by Road Runner

    Edit? NO//
  SOURCE OF ADMISSION: 1T       OBSERVATION AND EXAMINATION     HOSPITAL
  Patient Admitted


  CONDITION: SERIOUSLY ILL// @

  **** New Admission Message Transmitted to MIS ****

  Updating PTF Record #3...

  Now updating ward MPCR information...completed.

  Updating automated team lists...completed.
  Executing HL7 ADT Messaging
  Executing HL7 ADT Messaging (RAI/MDS)

  Updating claims tracking ... entry added.

  ...Inpatient Medications check...
  ...discontinuing Inpatient Medication orders....done...
  Entering a request in the HINQ suspense file...
  No HINQ string created entry not entered.completed.

  Updating visit status...completed.</pre>

CPRS 

.. figure::
   images/AdmitPatients/patient_selection_with_ward.png
   :align: center
   :alt: Admit Patients
