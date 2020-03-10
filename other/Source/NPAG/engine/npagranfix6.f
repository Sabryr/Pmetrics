c  npagranfix6.f                                           3/9/16

c  npagranfix6 has the following changes from npagranfix5:

c  1. In Subroutine SUBRES, after loop 800, and the call from NOTINT, 
c  PYJ is tested to verify it is not 0. This test has always been in 
c  main at the same point, but not in SUBRES since it didn't seem to be
c  needed there. But it is possible, if the user is doing a MAXCYC = 0
c  run, that the apriori density may not include any points which give
c  predicted values close enough to those of the new subject being 
c  analyzed (especially if this subject's assay coefficients are 
c  relatively small). So the message to the user in this case will
c  be to try the run again after increasing the size of the assay 
c  coefficients.

c  2. Formats 1657 and 7124 are changed to show that the output file
c  is made by npagranfix6 rather than npagranfix5.

c-----------------------------------------------------------------------

c  npagranfix5.f                                           10/24/15

c  npagranfix5 has the following changes from npagranfix4:

c  1. RANFIXEST and NRANFIX are added to a !$omp statement just above 
c  the DO 800 loop in main. This will now enable this program to be
c  run in parallel (npagranfix4.f could only be run in serial mode).

c  2. Formats 1657 and 7124 are changed to show that the output file
c  is made by npagranfix5 rather than npagranfix4.

c-----------------------------------------------------------------------

c  npagranfix4.f                                           10/11/15

c  npagranfix4 has the following changes to npagranfix3:

c  1. NRANFIX, PARRANFIX(.), and RANFIXEST(.) are now added to DENFIL, 
c  both files 23 and 33. This means that the code at the top of these
c  files will be changed from DENSITY APR_10 to DENSITY OCT_15. 
c  Similarly for the output file, file 25, whose code at the top will 
c  change from VERSION 42 on line 1 to VERSION 43, and whose code on 
c  line 2 will change from VER_BAK JUL_11 to VER_BAK OCT_15.

c  2. Similarly, NRANFIX, PARRANFIX(.), and RANFIXEST(.) are added to 
c  the writing of the NP_RFxxxx.TXT file by Subroutine READOUT, which
c  means the code for that file on the top line will change to 
c  VERSION 1.8 - OCT 2015. The module which has Subroutine READOUT will 
c  change from read22.f to read23.f.

c  3. Two of the modules linked with the main "engine" module will be
c  updated. idm2x17.f will be replaced by idm2x18.f, and idm3x18.f will
c  be replaced by idm3x19.f. The changes will not be functional, just
c  comments that NPP now also includes the no. of RANFIX parameters
c  (in addition to the no. of random and fixed parameters).


c  4. This "engine" program will be part of the NPAG119.FOR program.
c  Note that NPAG119.FOR will have many changes related to items 1. and
c  2. above, and also because npag102.inp will be updated to be  
c  npag103.inp, which will include NRANFIX, PARRANFIX(.), and 
c  RANFIXEST(.).

c  5. Formats 1657 and 7124 are changed to show that the output file
c  is made by npagranfix4 rather than npagranfix3.

c-----------------------------------------------------------------------

c  npagranfix3.f                                           10/06/15

c  npagranfix3 has the following changes to npagranfix2:

c  1. CALCRF is changed so that it rejects any candidate vectors which
c  have random variable values outside their input ranges. In such
c  case, FNTVAL is returned as an unattractive value, 1.D30.
 
c  2. Formats 1657 and 7124 are changed to show that the output file
c  is made by npagranfix3 rather than npagranfix2.

c-----------------------------------------------------------------------

c  npagranfix2.f                                          10/05/15

c  npagranfix2 has the following change to npagranfix:

c  1. The ELDERY code now optimizes over not just the NRANFIX parameters
c  which are unknown but the same for all subjects, but also the 
c  NVAR random parameters (using the current cycle means as the 
c  initial estimates for these NVAR parameters). This will take more
c  time, but is intended to bring all parameters up to their best
c  current estimates simultaneously. At the end of this block of code,
c  the grid values in CORDEN(.,.) are adjusted so the means of each
c  of the NVAR random parameters are equal to the just found new
c  estimates from ELDERY. But this code is only executed after cycle
c  no. 1.

c  2. The SIG(I,J) code in Subroutine CALCRF now has the ierrmod
c  code following it, as it should always have had.

c  3. Formats 1657 and 7124 are changed to show that the output file
c  is made by npagranfix2 rather than npagranfix.


c-----------------------------------------------------------------------

c  npagranfix.f                                            9/20/15

c  npagranfix is an extension to npageng30. It has the added capability
c  to estimate the value of parameters that are the same for all 
c  subjects.

c  This means that now the user can designate parameters as fixed
c  (IRAN(.) = 0), random (IRAN(.) = 1), or ranfix (IRAN(.) = 2).

c  Formats 1657 and 7124 are changed to show that the output file
c  is made by npagranfix rather than npageng29.

c-----------------------------------------------------------------------

c  npageng30.f                                             3/11/15

c  npageng30 has the following change from npageng29:

c  All numbers written out in F or G format are now tested to see if
c  they are inside [-1.D-99, 1.D-99]. If so, they are changed to be
c  0. The reason is that otherwise they will be printed out without 
c  the accompanying D or E (e.g., as .934-106, rather than .934E-106).

c  Note that a new Subroutine, VERIFYVAL is added to the code to 
c  do the indicated testing above.

c-----------------------------------------------------------------------

c  npageng29.f                                             12/16/14

c  npageng29 has the following changes to npageng28:

c  1. The statement preceding the DO 800 loop in MAIN is changed from 
c  !$omp Do Schedule(guided)  to  !$omp Do 

c  This change removes the slight randomness (typically in about the
c  12th significant digit in the log-liks) that sometimes appears 
c  when the program is run repeatedly on the same problem.

c  2. Formats 1657 and 7124 are changed to show that the output file
c  is made by npageng29 rather than npageng28.

c-----------------------------------------------------------------------

c  npageng28.f                                             11/25/14

c  npageng28 has the following changes to npageng27:


c  1. It has the parallel code (i.e., the Threadprivate and
c  other statements) to make this program run in parallel, using the
c  compilation command, 
c  gfortran -O3 -fopenmp -fmax-stack-var-size=32768 -o npageng28p.exe 
c  npageng28.f ... npagdriv.f.

c  Note that all the accompanying modules (except blasnpag.f and
c  read21.f) will be updated to have the necessary parallel code
c  (the Threadprivate, Save, etc. commands).

c  Note that !$omp lines are not comments, but statements read by the
c  compiler to tell it how to parallelize. But lines beginning with
c  just ! are simple comment lines.

c  So, shift9.f will be updated to shift10.f; idm1x16.f will be 
c  updated to idm1x17.f; idm2x15.f will be updated to idm2x16.f;
c  idm3x16.f will be updated to idm3x17.f. And, the new template 
c  model file will be TSTMULTN.FOR (updated from TSTMULTM.FOR).

c  Note that CALL SYMBOL has been removed from idm1x17.f/Subroutine
c  IDPC, and instead inserted into MAIN just above label 1001.


c  2. The code for AICC is changed. If the denominator,
c  NOBTOT-KP-1 is .LE. 0, then AICC will be set = the AIC
c  (i.e., in this case, the old version of AIC will be used).

c  3. Formats 1657 and 7124 are changed to show that the output file
c  is made by npageng28 rather than npageng27.

c-----------------------------------------------------------------------

c  npageng27.f                                             8/20/14

c  npageng27 has the following change to npageng26:

c  1. Subroutine NEWWORK1 is modified so that a steady state regimen 
c  now translates to 101 dose sets, rather than 100. The effect is
c  that if, for example, a patient has an observation at time t = 2 hrs.
c  after a steady state regimen with an inter-dose interval (II) of
c  24 hours, this observation will now be 2 hours after the beginning of
c  the last (the 101st) dose set, as opposed to 26 hours (after the
c  100th dose set in the previous program).


c  Also note that an extra check is put into Subroutine NEWWORK1 to
c  make sure that no two dose times are the same. This could happen,
c  for example, if the 101st dose set of a steady state dose regimen
c  had an ending IV time of 3 hours, and the first non-steady-state
c  IV dose following started at t = 3 hours. Having two dose times which
c  are the same can confuse the logic in Subroutine Shift, and cause
c  it to get into an infinite loop (see NPAG115.EXP, TESTCASE 5).

c  2. Formats 1657 and 7124 are changed to show that the output file

c  is made by npageng27 rather than npageng26.

c  3. The formula for AIC is changed.

c-----------------------------------------------------------------------

c  npageng26.f                                             8/05/14

c  npageng26 has the following changes to npageng25:

c  1. Formats 1657 and 7124 are changed to show that the output file
c  is made by npageng26 rather than npageng25.

c  2. The 3 ID modules are updated: idm1x15.f to idm1x16.f; idm2x14.f
c  to idm2x15.f; and idm3x15.f to idm3x16.f.

c  3. The formulas for AIC and BIC are changed.

c-----------------------------------------------------------------------

c  npageng25.f                                             3/10/14

c  npageng25 has the following changes from npageng24:

C  1. ICENT WILL NOW BE IRRELEVANT. PREVIOUSLY, THE USER ENTERED ICENT
C  AS 1, 2, OR, 3 TO SELECT WHETHER HE WANTED THE PREDICTED VALUES 
C  WRITTEN TO PRTBxxxx TO BE BASED ON THE BAYESIAN MEANS, MEDIANS, OR
C  MODES, RESPECTIVELY. NOW, ICENT WILL BE UNUSED SINCE THE PRTBxxxx 
C  FILE WILL INCLUDE THE PREDICTED VALUES FOR ALL 3 OF THESE
C  MEASURES. SIMILARLY THE OUTPUT FILE WILL NOW HAVE AUC TABLES FOR ALL
C  3 OF THESE MEASURES (PREVIOUSLY IT JUST HAD THE AUC TABLE BASED ON
C  THE MEASURE SPECIFIED BY ICENT). NOTE THAT THE NEW PC PREP PROGRAM
C  IS NPAG113.FOR.

C  2. THE MAXIMUM NO. OF OUTPUT EQUATIONS WILL BE CHANGED FROM 6 TO 
C  NUMEQT, WHICH IS SUPPLIED IN THE ARGUMENT LIST TO SUBROUTINE NPAG.
C  THIS MEANS THAT NUMEQT WILL NOW BE PASSED TO ALL THE SUBROUTINES
C  THAT NEED IT; AND IN THOSE SUBROUTINES, ANY 6 REFERRING TO THE MAX.
C  NO. OF OUTPUT EQUATIONS WILL BE CHANGED TO NUMEQT.

C  NOTE THAT THIS ALSO INCLUDES PASSING NUMEQT TO IDCALCY AND IDCALCYY
C  SO THAT YPRED AND YYPRED, RESPECTIVELY, AND BE VARIABLY DIMENSIONED
C  IN THOSE MODULES.

C  ALSO, IN THOSE ROUTINES WHERE ARRAYS ARE PASSED IN COMMON STATEMENTS,
C  OR EXIST ONLY IN THOSE ROUTINES, DIMENSIONS RELATED TO THE 
C  MAX. NO. OF OUTPUT EQS. WILL BE DIMENSIONED BY A PARAMTER STMT.
C  SETTING MAXNUMEQ = 7, THE CURRENT LIMIT (SINCE THESE ARRAYS CANNOT
C  BE VARIABLY DIMENSIONED BY A CALLING ARGUMENT). THIS INCLUDES IN 
C  MAIN, FILRED, AND OTHER ROUTINES IN THE ID MODULES WHERE YOO IS
C  PASSED IN COMMON/OBSER. IT ALSO INCLUDES OBSBLOCK IN SUBROUTINES
C  NEWWORK1 AND READOUT. AND IT INCLUDES SUBROUTINE OUTPUT IN THE NEW
C  TEMPLATE MODEL FILE, TSTMULTM.FOR (SEE CHANGE 3.).

C  THE NEW ID MODULES TO BE LINKED WITH THIS MAIN MODULE ARE
C  idm1x15.f, idm2x14.f, AND idm3x15.f.

C  3. NOTE THAT THE TEMPLATE MODEL FILE FOR THIS PROGRAM HAS BEEN
C  CHANGED FROM TSTMULTL.FOR TO TSTMULTM.FOR (SEE COMMENT 2. ABOVE).

C  4. read19.f IS CHANGED TO read20.f. THIS IS BECAUSE THAT MODULE
C  NO LONGER WILL READ AUC VALUES FROM THE OUTxxxx FILE. I.E., AUC
C  VALUES WILL NO LONGER BE INCLUDED IN THE NP_RFxxxx.TXT FILE.

c  5. Formats 1657 and 7124 are changed to show that the output file
c  is made by npageng25 rather than npageng24.


c-----------------------------------------------------------------------

c  npageng24.f                                             6/2/13

C  npageng24 has the following changes to npageng23:

C  1. THE CODE TO READ extnum TO GET THE 4-DIGIT JOB NUMBER IS MOVED TO

C  THE TOP OF THE CODE, SO ERRORxxxx CAN BE OPENED AND THEN FILLED 
C  AT EARLIER LOCATIONS IF THE PROGRAM STOPS ABNORMALLY. IN PARTICULAR,
C  ERRFIL IS ADDED TO THE ARG. LIST OF SUBROUTINE GETIPATF SO IT CAN BE
C  WRITTEN TO IF THERE IS AN ERROR IN THAT ROUTINE. ALSO, FORMATS
C  4706 (SEE BELOW) AND 1721 ARE NOW WRITTEN TO ERRFIL IF THERE IS AN
C  ERROR IN THOSE LOCATIONS.

C  NOTE THAT A NEW FORMAT, 4706, IS USED INSTEAD OF FREE FORMAT TO TELL
C  THE USER THAT npag102.inp IS NOT AVAILABLE, AND THE PROGRAM IS
C  THEREFORE STOPPING.

C  2. FORMAT 26 IS CHANGED TO INCLUDE JSUB, SO THE USER WILL KNOW WHICH
C  IS THE FIRST SUBJECT TO CAUSE THE ALL P(YJ|X) = 0 ERROR.

C  3. npageng24 is the main module for NPAG112.FOR.

c  4. Formats 1657 and 7124 are changed to show that the output file
c  is made by npageng24 rather than npageng23.

c-----------------------------------------------------------------------

c  npageng23.f                                             4/14/13

c  npageng23 has the following changes to npageng22:

c  1. TOL is no longer read in from npag102.inp. The read-in value 
c  wasn't used anyway since TOL was subsequently hardcoded to be 1.D-4.

c  Instead, the tolerance parameter read in is now TOLC, and this value
c  will be the one against which checkbig is compared from now on 
c  (rather than a hardcoded value of .01 as was used previously).

c  Note that the following is a quick summary of how the tolerance 
c  parameters are used to establish convergence of the algorithm:

c  a. The program keeps track of the log-lik improvement between 2 
c  consecutive regular cycles. If this improvement is not at least
c  TOL (1.D-4), then some perturbed grid points are added to the grid,
c  at a resolution of 20% of the range of the parameters. This process
c  continues with the resolution halved each time a regular cycle 
c  doesn't have a log-lik improvement of at least TOL, and it continues
c  until the resolution gets down to .0001. That marks the end of a
c  "major cycle".
 
c  b. The log-lik difference between 2 consecutive "major cycles" must
c  be .LE. TOLC (which is now read in from npag102.inp, rather than 
c  hardcoded to be .01).

c  Note that Format 1223 is changed so that TOLC is now included in the
c  output file.

c  2. If the program bombs, the message that is written to the screen 
c  will now also be written to the file ERRFIL = ERRORxxxx, where xxxx
c  is the 4-digit run no. In this way, if the program is being run using
c  Pmetrics, the Pmetrics program can respond appropriately. Note that
c  ERRFIL must be passed to all the routines which could write to it
c  using COMMON/ERR/ERRFIL.

c  3. Formats 1657 and 7124 are changed to show that the output file
c  is made by npageng23 rather than npageng22.

c  4. Subroutine SUBRES now also stores each subject's Bayesian 
c  posterior density into arrays BAYPOS and NACTSUB, which are passed
c  via COMMON/BAY to Subroutine READOUT. They will be written into
c  the NP_RFxxxx.TXT file. But note that, due to size restrictions
c  (see NPAG111.EXP), only the first 100 subjects worth of values can
c  be stored at present.

c  Also note that only the grid points that are active for each subject
c  are used to calculate Bayesian subject values now, rather than all the
c  NACTVE grid points from the population final density.

c  5. This program is now compiled with read19.f, which replaces
c  read18.f. The other modules remain unchanged.

c  6. Change 4. in npageng20.f is reversed. Now the previous cycle's 
c  density will again be saved each cycle, except for cycle 1. But this
c  can be manually changed by changing the value of ISAVEDEN (below 
c  label 1243) to something other than 1.

c  7. Several C???DEBUG comments are removed in MAIN ...
c  from write(*,*)' About to create density file ...'  to
c  NOW CLOSE THE FILES USED BY READOUT. These statements are no longer
c  debug statements.


c-----------------------------------------------------------------------

c  npageng22.f                                             11/8/12

c  npageng22 has the following change from npageng21:

c  1. It comments out the PAUSE statement following Format 164 in 
c  Subroutine emint. Reason: the program will not complete properly if 
c  it is run under  Pmetrics (which cannot supply a keyboard response
c  during a run). 

c  2. Formats 1657 and 7124 are changed to show that the output file
c  is made by npageng22 rather than npageng21. 

c-----------------------------------------------------------------------

c  npageng21.f                                             10/15/12

c  npageng21 has the following changes from npageng20:


c  1. The 3 id modules linked to this program have been updated; they
c  are now idm1x14.f, idm2x13.f, and idm3x14.f. These 3 id modules
c  correct a bug. Now R(.) are set = RS(.,.) before GETIX is called
c  in the time reset section (see details in those modules).

c  2. A bug which was introduced in npageng18.f (see change 1. there)

c  has been corrected. Instead of writing TPREDREL(.) to File 31 below
c  Format 2131, TTPREDREL(JSUB,.) is written. Note that TPREDREL(.) 
c  holds the values for the last subject only (no. NSUB), but Format
c  2131,which is in loop 7000 over all NSUB subjects, requires that
c  TTPREDREL(JSUB,.) be used so that each subject has its own predicted
c  times  written.

c  3. Another bug is fixed in the AUC part of the code ... by using a
c  new parameter, IELAST, and initializing it to be 0 just below where
c  ILAST is initialized = 0 for each new subject. IELAST must be used in
c  addition to ILAST for those subjects whose AUC tables start with a 
c  partial period, rather than a whole period. In this case, for 
c  JSUB > 2, without IELAST, the index of which YYPRED(.,.) value starts
c  the current AUC would not be set correctly. See the details in the
c  code.

c  4. Formats 1657 and 7124 are changed to show that the output file
c  is made by npageng21 rather than npageng20. 

c  Note that npageng21.f is the main "engine" module for the new PC
c  prep program, NPAG110.FOR.

c-----------------------------------------------------------------------

c  npageng20.f                                             10/04/12

c  npageng20 has the following changes from npageng19:

c  1. It will now be linked with read18.f, rather than read17.f. The 
c  reason is that NOMAXTIM(.) in Subroutine CONVERGE2 must be 
c  initialized to be all 0's to avoid a possible bug if the program
c  is compiled and linked with gfortran (see details in read18.f). Also,
c  note that since the individual files needed by read18.f will now be
c  left open when that module is called, the combined output file,
c  OUTFILE, will no longer be needed as a calling argument to
c  read18.f (i.e., Subroutine READOUT). 

c  Note that not having Subroutine READOUT separate the combined output
c  file into the 4 needed individual files can save a lot of execution
c  time if this program is compiled and linked with gfortran.

c  2. It will now be linked with shift9.f, rather than shift7.f. The
c  reason is to fix a bug which occurred if a steady state dose had
c  bolus inputs (see details in shift9.f).

c  3. It will be linked with idm1x13.f (updated from idm1x12.f),
c  idm2x12.f (updated from idm2x11.f), and idm3x13.f (updated from
c  idm3x12.f). Each of the new id modules have new code to make sure
c  that Subroutine GETFA has the initial values for R(.) when it is
c  called the first time, and to make sure that GETFA is called just
c  before each time FA(.) are used, so the FA(.) are updated to current
c  values (see details in the id modules). 

c  4. See the code below Format 1243. Starting with this program, the
c  joint density will be saved only after cycle no. 2, not after every
c  cycle. See code below 1243 for the reasons.

c  5. Formats 1657 and 7124 are changed to show that the output file
c  is made by npageng20 rather than npageng19. 

c  Note that npageng20.f is the main "engine" module for the new PC
c  prep program, NPAG109.FOR.

c-----------------------------------------------------------------------

c  npageng19.f                                             8/19/12

c  npageng19 has the following changes to npageng18:

c  1. Preset NACTLAST TO BE NACTVE just below label 30. This avoids a
c  very unlikely and subtle error that would occur if the first
c  cycle of a run has a Hessian error. See comments below label 30

c  in main.

c  2. When a Hessian error occurs in Subroutine emint, now the value
c  of info will be reported to the user. If it is positive, it is 
c  the subject no. which  caused the Hessian error (see


c  \ALAN3\NEELY\VORI2\VORI2.EXP for example).

C  3. NEW CODE IN SUBROUTINE NEWWORK1 IS USED TO ESTABLISH THE VALUES
C  FOR DOSEBLOCK, WITHOUT USING A BACKSPACE COMMAND. THE REASON IS THAT
C  DEPENDING ON WHICH COMPILER IS USED TO MAKE THE PR PREP PROGRAM
C  (CURRENT ONE IS NPAG108.FOR), IT IS POSSIBLE FOR A DOSE EVENT
C  TO LOOK LIKE SEVERAL LINES RATHER THAN ONE LONG WORD-WRAPPED LINE.
C  IN THE FORMER CASE, BACKSPACING ONE LINE WILL NOT BACKSPACE TO THE
C  BEGINNING OF THE DOSE EVENT AS SHOULD BE DONE. SO TO BE SAFE, THE
C  LOGIC TO USE BACKSPACE(23) WILL BE COMMENTED OUT, AND 
C  DOSEBLOCK(.,.,.) WILL BE ESTABLISHED DIRECTLY.

C  4. npageng19.f WILL BE COMPILED AND LINKED WITH NEW id MODULES:
C  idm1x11.f REPLACED BY idm1x12.f;
C  idm2x10.f REPLACED BY idm2x11.f;
C  idm3x11.f REPLACED BY idm3x12.f;

C  THE REASON IS TO CORRECT A BUG WHEN N = 0 (ANALYTIC SOLUTIONS CODED
C  INTO SUBROUTINE OUTPUT). IN THIS CASE, THE NDO = ND, 
C  SIGO(.) = SIG(.), ETC. SECTION IS SKIPPED; AND THIS MEANS THAT AT THE
C  END OF idm1x11.f, ND = ND0 BECOMES 0 --> THE NEXT TIME idpc IS 
C  CALLED, THE PROGRAM IS SCREWED UP.

C  THIS BUG ONLY HAPPENS IF N = 0 AND NO TESTCASES WITH N = 0, WHICH
C  WOULD HAVE DISCOVERED THE PROBLEM, WERE RUN SINCE idm1x9.f WAS 
C  USED.



C  THE SOLUTION, IN THE NEW id ROUTINES, IS TO MOVE THE NDO = ND, 
C  SIG0(.) = SIG(.), ETC. ... CODE TO JUST AFTER CALL GETFA.

c  See \ALAN3\NEELY\EMAX\EMAX.EXP for details.


c  5. Formats 1657 and 7124 are changed to show that the output file

c  is made by npageng19 rather than npageng18. 

c  Note that npageng19.f is the main "engine" module for the new PC
c  prep program, NPAG108.FOR.


c-----------------------------------------------------------------------

c  npageng18.f                                             7/01/12

c  npageng18 has the following changes from npageng17:

c  1. "Relative" rather than "real" times are written to the output 
c  files. This means that if a steady state dose set occurs, the output
c  times in the AUC tables, the DENxxxx file, the PTRTxxxx file, etc.
c  will now be based on the end of the steady state dose set rather than
c  the beginning. As an example, if the interdose interval of a steady
c  state dose set is 4 hours, and the last observation for that region

c  is 20 hours, the previous program would have written into PTRBxxxx
c  and the DENxxxx files times of 400.00, 400.0333,..., 444.00 (i.e.,
c  24 hours after the last observation time). Those are the "real" times
c  that are used by the id modules in this program. But now, the times
c  written to these files will be 0.00, 0.033,..., 44.00, which are the
c  "relative" times (i.e., those starting at the end of the 400 hours
c  of steady state dosing).

c  This change is made by having Subroutine CALCTPRED calculate
c  TPREDREL(.) in addition to TPRED(.). TPRED(.) is still used in the
c  call to Subroutine IDCALCYY (i.e., that routine must see the real
c  times), but the times in TPREDREL(.) are the ones written to the
c  output files).

c  Also, when writing the AUC tables, the "relative" times are written
c  rather than the "real" times ... by not adding TBEGGSUB(.,.) to the
c  calculation of IHRST (in the above example, TBEGGSUM(.,.) = 400 is
c  the length of the 100 steady state dose sets).

c  In addition, now Subroutine NEWWORK1 establishes TIMOBREL(JSUB,J)
c  which give the original ("relative") observation times passed via
c  npag102.inp, and these values, rather than the "real" ones stored
c  to File 27 by NEWWORK1, will be written to the end of the PRTBxxxx
c  file.

c  2. The module read16.f linked to this program will be updated to be
c  read17.f. read17.f will no longer read DOSEBLOCK(.,.,.) and
c  OBSBLOCK(.,.,.) from file 27; instead this info will be passed via
c  COMMON/DOSEOBS from Subroutine NEWWORK1. These values will be the
c  values from the patient files in the npag102.inp (i.e., before these
c  working copy format files are converted by SUBROUTINE NEWWORK1 to
c  have a full 100 dose lines for each steady state set, and to have
c  "real" rather than "relative" times in the dose/cov and observation
c  blocks).

c  All other modules linked with the main module, are unchanged.

c  3. Format 2053 has a typo correction (which required a corresponding
c  change in read17.f - see comment 1. in that file).

c  4. If a Hessian Matrix is singular in Subroutine emint, instead of
c  stopping immediately without writing the output files, now the
c  program sets IHESS = -1, and returns to MAIN, where control is
c  transferred to label 900, so the output files can be created, based
c  on the previous cycle's values. Then the program stops.

c  Note that in this case (IHESS = -1), the program will write into the
c  output file that it stopped because of a Hessian error, and it will
c  re-establish CORDEN to be = CORDLAST, which was the joint density
c  array from the previous cycle. This way, when Subroutine SUBRES is
c  called in loop 7000 at the end of the run, the values will all be
c  based on the values from the last fully completed cycle. Otherwise,
c  CORDEN would have been some hybrid combination of the CORDEN from
c  the previous cycle and the partially updated CORDEN from the
c  incomplete current cycle). And because of this new array, CORDLAST,
c  SUBROUTINE MAKEDRIV in the new NPAG107.FOR must be changed to 

c  include this array with variable dimensions as a calling argument
c  to Subroutine NPAG in this module (and CORDLAST must be dimensioned
c  below also).

c  5. Formats 1657 and 7124 are changed to show that the output file
c  is made by npageng18 rather than npageng17. 

c-----------------------------------------------------------------------

c  npageng17.f                                             4/10/12

c  npageng17.f has the following changes from npageng16:

c  It is the main engine module for NPAG106.FOR. The change is that this
c  program allows steady state dose sets to have bolus doses as well as
c  IVs (rather than being limited to just IVs). 

c  But each drug in a steady state dose set can have either
c  an IV or a bolus, not both. The reason is that the dose column in 
c  the .csv file is used for the total amount of drug given. If the
c  corresponding duration is 0, this represents a bolus; if the 
c  corresponding duration > 0, this represents the total amount of the
c  IV (with the indicated duration). If one wanted both an IV
c  and a bolus, there would be no way to impart this information in 
c  the two entries (DUR and DOSE).

c  To affect this change, several code changes are made to Subroutine
c  NEWWORK1.

c  In addition, the 3 id modules require code changes are updated to be
c  idm1x10.f, idm2x10.f, and idm3x11.f.

c  Also, formats 1657 and 7124 are changed to show that the output file
c  is made by npageng17 rather than npageng16. 

c-----------------------------------------------------------------------

c  npageng16.f                                             11/23/11

c  npageng16 has the following changes from npageng15:

c  1. It is the main engine module for the new PC prep program, 
c  NPAG104.FOR (which will be completed later). For now, it is 
c  compatible with NPAG103.FOR, as long as any subjects with steady
c  state dose sets are input in working copy format. The new
c  NPAG104.FOR/npageng16.f program now allows patient files to have 
c  steady state dose sets. In particular, this program now calls new
c  subroutine NEWWORK1 (based on the stand-a-lone program of the same
c  name) to read each working copy file in npag102.inp, which may have
c  steady state dose indicator lines, and convert it to the typical form
c  that that the id routines require, except that the steady steady 

c  state dose indicators themselves (negative dose times) remain in the
c  file.

c  2. blasnpag.f is not changed, but the other 5 permanent engine .f
c  files linked to this program, read15.f, shift6.f, idm1x6.f, 
c  idm2x6.f, and idm3x6.f, will be updated to be read16.f, shift7.f,
c  idm1x7.f, idm2x7.f, and idm3x7.f. The changes in the id routines will
c  allow them to read steady state dose indicators and know how to 
c  integrate through each set, testing for convergence of the steady
c  state compartment amounts to see if the program can fast forward to
c  the end of that set. The changes for read16.f are simply in the
c  dimensions related to no. of doses, which will change from 500 to 
c  5000 (see comment 4. below). The changes in shift7.f are the 
c  dimensions changes of read16.f, and some edited code required since

c  now a dose (time) reset occurs when a dose time is .LE. 0, rather 
c  than .EQ. 0.

c  3. All 500's related to dose times dimensions (which are passed in

c  COMMON/OBSER) are changed to 5000's to be compatible with the new
c  id routines. This is because in those routines, because of steady
c  state dose sets, the no. of dose times can expand to be much 
c  bigger than 500. All 500's will also be changed to 5000 in 
c  Subroutine FILRED.

c  4. Many changes are made in Subroutine CALCTPRED and Main (where

c  the AUC tables are calculated) to take into account that the 


c  predicted values to be calculated by IDCALCYY only start at t=0
c  if there is no active steady state dose set; if there is an active
c  steady state dose set, then the predicted values start at the end
c  of that dose set.

c  5. A bug in loop 2050 (calculating AUCs) is corrected (see code
c  involving new parameter ILAST).

c  6. When the variance of a parameter in a cycle is numerically .LE. 0,

c  rather than suppress all covariance-related output for that cycle,
c  as was done in previous programs, now the covariances, std. devs.,
c  and coefficients of variations will all be written as 0's, and the
c  correlations as -99's. This change is because suppressing the output
c  means that the NP_RFxxxx.TXT file (made by Subroutine READOUT) has 
c  fewer than expected std. devs., which screws up the R program which
c  reads that file. This same change is made in Subroutine SUBRES
c  for the Bayesian statistics for each subject.

c  7. Variables PRCN, tbeg, PRFIX2, EXT2, IFORMT, NSTORESV, IPRED, JCOL,
c  T1000A, saveres are now removed, as they are no longer used (and 

c  haven't been for some time).

c  8. Formats 1657 and 7124 are changed to show that the output file is
c  made by npageng16 rather than npageng15. 

c-----------------------------------------------------------------------

c  npageng15.f                                             7/29/11

c  npageng15 has the following changes from npageng14:

c  1. This module is part of the NPAG102.FOR program. That program was
c  changed to provide an npagdriv.f file (rather than an npemdriv.f 
c  file), and one of the changes in the new npagdriv.f file is the 
c  CALL NPAG statement, rather than a CALL BIGNPAG statement. As a 

c  result, the SUBROUTINE BIGNPAG statement below is replaced by 
c  SUBROUTINE NPAG.


c  2. The instruction file made by the PC prep program (NPAG102.FOR is
c  the first in the series) is changed from npembg34.inp to 
c  npag102.inp. This was done since now NDRUG and AF(I),I=1,NDRUG will
c  be in the file, as opposed to just AF (i.e., it is no longer
c  assumed that all drugs have the same active salt fraction).

c  3. Formats 1657 and 7124 are changed to show that the output file is
c  made by npageng15 rather than npageng14. Also in Format 1657, the
c  version no. is changed from 41 to 42 (since NDRUG and 
c  AF(I),I=1,NDRUG will be written to the output file, rather than
c  just AF).

c  4. This program will now be linked with read15.f, updated from
c  read14.f (which must be updated to write NDRUG and AF(I),I=1,NDRUG,
c  rather than just AF). Also, it reads info regarding ICONVERGE
c  differently now (see 5. below). The other permanent modules, 
c  blasnpag.f, shift6.f, idm1x6.f, idm2x6.f, and idm3x6.f are unchanged.

c  5. New code involving IMAXCYC enables the program to test whether
c  the analysis converged at MAXCYC. Previously, if ICYCLE = MAXCYC,
c  the program would stop without checking to see if convergence was
c  also achieved. Now convergence will still be tested even if ICYCLE
c  = MAXCYC. Note that new parameter, ICONVERG, along with IMAXCYC
c  will enable the program to write below label 900 the reason the

c  program stopped (because of MAXCYC being run; because the analysis
c  converged; or because of both of the above) - see formats 5197 
c  through 6001.

c-----------------------------------------------------------------------

c  npageng14.f                                             6/29/11

c  npageng14 has the following changes to npageng13:

c  1. The comment in the output file regarding the stopping criterion is
c  changed (JSTOP has been ignored since Bob Leary's adaptive grid
c  algorithm was inserted in 2000). TOL was still used in a complicated
c  way in the stopping criterion, but was not allowed to be < 1.D-4. To
c  simplify the code, TOL will now not be used as read in from 
c  npembg34.inp. Instead it will always be hardcoded to be 1.D-4.

c  Note that though JSTOP and TOL are not used, they are still read in
c  from npembg34.inp, so the format of this file does not have to be
c  changed.

c  Formats 1221 and 1222 are changed to report the starting cycle no.,
c  and the maximum cycle no., and new format 1223 reports that the 

c  program will stop prior to the max. cycle no. if convergence is
c  achieved.

c  Note also that all code involving PRESLP, which was related to JSTOP,
c  has been removed.


c  New formats 5197 and 5198 write to the output file why the analysis

c  stopped (i.e., either MAXCYC reached or convergence was obtained).

c  2. New formats 9771 and 9772 write to output file 25 whether the
c  apriori density is uniform or is a prior run's density file; they
c  replace the previously unformatted write statements.

c  3. Since all ATOL(I) are set = RTOL, the comment in the output file
c  is simplified to report just RTOL as the value of the tolerance used
c  in the differential equation solver (VODE). See FORMAT 9769.

c  4. The comment in the output file that the no. of intervals used
c  in calculating the marginal density approximations is 100 is removed
c  since this value (NINT) is always 100.

c  5. Formats 1657 and 7124 are changed to show that the output file is
c  made by npageng14 rather than npageng13. Also in Format 1657, the
c  version no. is changed from 40 to 41 (since new/changed info will be
c  written to the output file).


c  6. Parameter ilast is removed from MAIN. It was set but never used.

c  7. This program will now be linked with read14.f, updated from
c  read13.f. The other permanent modules, blasnpag.f, shift6.f,
c  idm1x6.f, idm2x6.f, and idm3x6.f are unchanged.

c-----------------------------------------------------------------------

c  npageng13.f                                             4/28/11

c  npageng13.f has the following changes from bigmlt12.f:

c  1. This is the main module in the program whose PC Prep program is
c  the new NPAG100.FOR. As in that .FOR module, the formula for NI in 
c  Subroutine FILRED is changed from  NI = 2*NDRUG + 2 + NADD  to  
c  NI = 2*NDRUG + NADD, because from now on, WT and CCR will not be 
c  considered special covariates. If they are included in the working 
c  copy file, they will be part of the NADD 'additional' covariates 
c  (beyond the 4 permanent ones in Common DESCR).

c  Because of the above change, the shift5.f module linked to this
c  program will be updated to shift6.f.

c  2. This program will be linked with read13.f, updated from read11.f
c  and then two versions of read12.f.
 

c  The difference is that read13.f will include the assay coefficients
c  for each observation in the rfile, which will be renamed to be
c  NP_RFxxxx.TXT from RFILExxxx.TXT.

c  3. Formats 1657 and 7124 are changed to show that the output 
c  files are made by npageng13 rather than bigmlt12.

c-----------------------------------------------------------------------

c  bigmlt12.f                                              01/11/11



c  bigmlt12 has the following changes from bigmlt11:

c  1. Messages to the user are written after the end of the first cycle
c  (see format 1243 in MAIN) and in Subroutine emint (see format 123) 
c  so that he will know the program has not 'hung' if the adaptive grid
c  optimization takes several minutes (as it can with a large no. of 
c  subjects and grid points).

c  2. The Akaike Information Criterion (AIC), and the Schwartz 
c  (Bayesian) Information Criterion (BIC) are written to the output 
c  file. They are calculated similarly to how they are in the Big 
c  IT2B program. 


c  Note that this main "engine" module is now linked with read11.f, 
c  rather than read10.f. The difference is that read11.f stores the new
c  AIC and BIC values.

c  Also, of course, formats 1657 and 7124 are changed to show bigmlt12,
c  rather than bigmlt11.f.

c  Note that the first PC Prep program to use the bigmlt11.f "engine"
c  is NPBG15E6.FOR.

c-----------------------------------------------------------------------

c  bigmlt11.f                                              12/20/10

c  bigmlt11 is the same, functionally, as bigmlt10.f. The difference 
c  is that it is linked with idm1x6.f, idm2x6.f, and idm3x6.f, all
c  updated from the _____5.f versions. The other permanent .f files, 
c  blasnpag.f, shift5.f, and read10.f are unchanged.

c  Also, of course, formats 1657 and 7124 are changed to show bigmlt11,
c  rather than bigmlt10.f.


c  Note that the first PC Prep program to use the bigmlt11.f "engine"
c  is NPBG15E5.FOR.

c-----------------------------------------------------------------------

c  bigmlt10.f                                              12/13/10

c  bigmlt10 has the following changes to bigmlt9:


c  1. In Subroutine SUBRES, the NACTVE grid points from the final cycle
c  are checked and the no. which are "active" for each subject (i.e.,
c  within 1.D-10 of the maximum density for that subject) is printed to

c  the screen and File 25 (previously just the no. of active grid pts.
c  from the joint density of the final cycle was printed).

c  2. When Andreas' Intel compiler compiles the program, it objects to
c  RPAR and IPAR being dimensioned (as (*)) in Subroutine DVODE (and
c  routines called by DVODE) when they are not dimensioned in 
c  Subroutine USERANAL (in idm1x5.f). The comments in DVODE state that
c  if these values are not being used, they do not need to be 
c  dimensioned in routines that call DVODE. Nevertheless, to remove the

c  Intel objection, RPAR(*) and IPAR(*) are removed from the 5 routines
c  in this module which declare them arrays.

c  Similarly, RTOL supposedly does not need to be dimensioned in 
c  USERANAL since it is a scalar, but the Intel compiler objects to
c  having it dimensioned (*) in DVODE, etc. when it is a scalar in
c  USERANAL. So, all RTOL(*) occurrences are removed in this module,
c  and all references to RTOL(1), RTOL(I), etc. are changed to RTOL.

c  3. Formats 1657 and 7124 are changed to show bigmlt10, rather than 
c  bigmlt9.

c  Note that the first PC Prep program to use the bigmlt10.f "engine"
c  is NPBG15E4.FOR.

c-----------------------------------------------------------------------

c  bigmlt9.f                                               11/21/10

c  bigmlt9 has one major change to bigmlt8:

C  A CALL TO NEW SUBROUTINE PAUSE REPLACES EACH PAUSE STATEMENT. 
C  THIS IS BECAUSE A PAUSE STATEMENT CAUSES A WARNING WHEN THE PROGRAM
C  IS COMPILED AND LINKED USING gfortran (AND IT FORCES THE USER TO 
C  TYPE "go" INSTEAD OF SIMPLY HITTING THE ENTER KEY). ALSO, SEVERAL
C  PAUSE STATEMENTS THAT WERE PREVIOUSLY COMMENTED OUT ARE NOW 
C  "REINSTATED" WITH CALL PAUSE COMMANDS.

c  Also, formats 1657 and 7124 are changed to show bigmlt9, rather than 
c  bigmlt8.

C  Note that one of the modules linked to the bigmlt9.f "engine" is
c  read10.f (updated from read9.f). The only change in read10.f is the
c  same one as above in this module.

c  Note that the first PC Prep program to use the bigmlt9.f "engine"
c  is NPBG15E3.FOR.

C-----------------------------------------------------------------------

c  bigmlt8.f                                               11/10/10



c  bigmlt8 has the following changes to bigmlt7:

c  1. In Subroutine CALCTPRED, a code change is made so that an initial 
c  observation time of 0 does not trigger a "time reset".

c  2. Formats 1657 and 7124 are changed to show bigmlt8, rather than 
c  bigmlt7.

c  3. At the end of the run, the logic of read9.f (SEE
c  \ALAN3\NEELY\READOUT\READOUT.EXP) will create RFILExxxx.txt, an 
c  output file which is easy to use with the program, R. This will
c  be done by calling READOUT, the main routine in the module read9.f,
c  which is now compiled with this program. 

c-----------------------------------------------------------------------

c  bigmlt7.f - revised                                        11/05/10

c  The revised version of bigmlt7.f is identical to the original, except
c  that formats 1657 and 7124 are changed to show that the output 
c  files are made by bigmlt7.f, rather than bigmlt6.f

c-----------------------------------------------------------------------

c  bigmlt7.f                                                  10/26/10

c  bigmlt7 is the same as bigmlt6 except at the end of the run, new 
c  Subroutine CONDENSE (based on the free standing program, 
c  CONDENSE.FOR) is used when writing lines to the combined output 
c  file, OUTxxxx. This makes OUTxxxx a much smaller file - by only 
c  using line sizes which are required for each line, rather than 
c  always using A1000 as the the format.

c-----------------------------------------------------------------------

c  bigmlt6.f						   4/3/10


c  bigmlt6 has the following changes to bigmlt5:


c  1. In bigmlt5.f, the PRTB file was not completely written in the case
c  where there were time resets in the patient data files. This was
c  because the following condition in idm3x4.f just below label 45
c  was never engaged ...
c	IF(TPRED(KNT) .EQ. 0.D0 .AND. SIG(KNS) .EQ. 0.D0) THEN
c  ... since the predicted times went monotonically from 0 to 24 hours
c      past the last observed value time over all the subjects (this
c      value, T_END, was calculated by NPBIG15D.FOR and passed to 
c      bigmlt5.f in npembg34.inp). Instead the observed value times 
c      should have gone from 0 to 24 hours past the largest observation 
c      time before the next time reset value of 0, for each subject 
c      individually. This logic will be done in bigmlt6; these 
c      predicted value times will be calculated by routine CALCTPRED 
c      for each subject in turn. i.e., there will now be as many 
c      predicted sets of concentrations as there are time resets.

c  Also note that the AUCs in bigmlt5.f were not calculated correctly
c  when the patients had time resets, for the same reason as indicated
c  in the above paragraph. But now there will be one AUC table for 
c  each time reset for each output equation for each subject.

c  See new Subroutine CALCTPRED which calculates the NUMT(JSUB) values
c  in TPRED, based on each subject's observed value times. Note that
c  these observed value times will be IDELTA minutes apart, and will
c  consist of times up to 24 hours after each max. observed value time 
c  (and there will be as many sets of times for each subject as there
c  are time resets).

c  2. The code for the density file will now be changed since NUMT will
c  now be an array (since it will be different for each subject).
c  i.e., NUMT(JSUB) and TTPRED(JSUB,.) will have to be written for each 
c  subject (see code). Also, since the combined output file includes the 
c  density file, its code will be changed also. i.e., formats 1657 and 
c  7124 now show bigmlt6 as the main "engine" module. Note that TPREDD
c  is now changed to TTPRED to be consistent with the names in 
c  NPBIG15E.FOR (the PC Prep program) associated with this program.


c  Note that, though T_END will not be used anymore, it will still be
c  read in from npembg34.inp so the structure of this file will not
c  have to change. Note that IDELTA will still be used.

c  3. bigmlt6.f will now be linked with 3 new id modules (idm1x5.f,

c  idm2x5.f, and idm3x5.f). The previous id modules had a bug related
c  to the time resets (see code in the new id modules).

c-----------------------------------------------------------------------

c  bigmlt5.f							12/12/09

c  bigmlt5.f is exactly the same as bigmlt4.f, except ...
c  formats 1657 and 7124 now show bigmlt5 as the main "engine"
c  module.

c  The new name (bigmlt5 vs. bigmlt4) is used since the 3 id files
c  this program calls (idm1x4.f, idm2x4.f, and idm3x4.f) are updated

c  from the previous set (idm1x3.f, idm2x3.f, and idm3x3.f).

c-----------------------------------------------------------------------

c  bigmlt4.f							9/18/09

c  bigmlt4 has the following changes from bigmlt3:

c  1. The modules with which it is linked are changed:
c  idm1x2.f, idm2x2.f, and idm3x2.f are changed, respectively to
c  idm1x3.f, idm2x3.f, and idm3x3.f. Also, shift4.f is changed to
c  shift5.f.

c  2. Subroutine XERRWD is changed so that it writes no warning


c  messages to the screen. Instead, the no. of calls to XERRWD is
c  passed back to main and written to the screen in loop 800 (see
c  code related to NXE in several places). The reason is that if 
c  there are a lot of warnings written to the screen, it can slow the 
c  overall program down a lot (in one example, it slowed the program 

c  by a factor of almost 2.5).

c  3. All references to NTLAG have been removed. The reason is that
c  the user now codes explicitly his/her formulas for TLAG (and FA and
c  IC) into his model file (the new template is TSTMULTG.FOR).

c  4. bigmlt4.f is the new main "engine" module for NPBIG15C.FOR 
c  (updated from NPBIG15B.FOR).

c  5. Formats 1657 and 7124 now show bigmlt4 as the main "engine"

c  module.


c-----------------------------------------------------------------------

c  bigmlt3.f							9/4/09


c  bigmlt3 is the same as bigmlt2 except that formats 2048, 2049, 2051,
c  and 2052 have been changed to allow for larger numbers.


c  Also, the modules it calls are changed:
c  idm1x1.f, idm2x1.f, and idm3x1.f are changed, respectively to
c  idm1x2.f, idm2x2.f, and idm3x2.f.

c-----------------------------------------------------------------------

c  bigmlt2.f							7/7/09

c  Slight correction from original bigmlt2.f (dated 6/1/09):


c  BS(500,3) is changed to BS(500,7) in the dimension statement of
c  the main module (this change should have been made at the same time
c  the chnage was made in Subroutine FILRED - with the program
c  bignpaglap2.f.

c-----------------------------------------------------------------------

c  bigmlt2.f							6/1/09

c  bigmlt2 is the main module for the "engine" which corresponds to 
c  the most recent multiple drug PC PREP PROGRAM, NPBIG15A.FOR. The

c  other modules of the "engine" are idm1x1.f, idm2x1.f, idm3x1.f,
c  shift3.f, and blasnpag.f (the latter two of which are unchanged from 
c  the previous version). The changes in this modules from bigmlt1.f are
c  essentially the changes that the single drug program, big28.f, had
c  from big24.f. They are as follows:

c  1. The time interval for AUCs, instead of being hardcoded to be 24
c  hours, will be read in from the instruction file, npembg34.inp
c  (changed from npembig33.inp). This value is called AUCINT.

c  The first Big NPAG PC Prep program which is compatible with this
c  program (i.e., makes npembg34.inp) is NPBIG15A.FOR.

c  Also, formats 1657 and 7124 are changed so the name of this "engine"
c  program, bigmlt2.f, is written.

c  2. THE DIMENSIONS OF AB, PAR, PARFIX, VALFIX, AND IRAN ARE 

C  MADE CONSISTENT WITH THE MAXIMUM ALLOWED VALUES (A MAXIMUM OF 30 
C  RANDOM PARAMETERS AND 20 FIXED PARAMETERS). IN PARTICULAR:
C  ALL ARRAYS RELATED TO THE NO. OF RANDOM VARIABLES ARE NOW DIMENSIONED 
C  30; ALL ARRAYS RELATED TO THE NO. OF FIXED PARAMETERS ARE NOW 
C  DIMENSIONED 20; AND IRAN IS STIL DIMENSIONED 32.

C  ALSO, ALL FORMATS RELATED TO THE NO. OF RANDOM VARIABLES ARE CHANGED
C  TO 30 FROM 25; SIMILARLY THOSE RELATED TO THE NO. OF FIXED VARIABLES

C  ARE CHANGED FROM 12 TO 20.

C  NOTE THAT THIS PROGRAM WILL BE COMPILED AND LINKED WITH A NEW MODEL
C  FILE TEMPLATE, TSTMULTE.FOR, IN WHICH PSYM IS DIMENSIONED 32 
C  (INCREASED FROM 25) IN SUBROUTINE SYMBOL. ALSO SEE BELOW FOR ANOTHER
C  CHANGE TO TSTMULTE.FOR.


c  3. READLARG has been changed from *300 to *1000, and FORMAT
c  2717 has been changed from A300 to A1000. The reason is that in a
c  run using George's 24 parameters (see \ALAN3\GEORGE\DRUSANO7.EXP),
c  NPBIG10H bombed when doing option 5 on \ALAN3\BIGNPAG\OUT0436 - the 
c  reason is that big25.f cut off the output file lines at entry 300
c  and this cut off the means, covs, etc. of parameter no. 24. Then,
c  NPBIG10H couldn't read the 24th no. and bombed with an 
c  "invalid numeric input" error.

c  4. READLINE has been changed from *78 to *300 in several routines,
c  and the corresponding format for READLINE has been changed to
c  A300 from A78 in each of those routines. The reason is that
c  in one of the patient data files that George sent, his observed

c  values went past column 78 (which --> the values were cut off
c  when read by big25).

c  5.In addition to storing YPREDPOP, this program now stores 
c  YPREDPOPT(JSUB,IEQ,J,ICENTER) = the predicted value for Y for
c  subject JSUB, for output equation IEQ, for time J, for 
c  ICEN = 1 (means), 2 (medians), AND 3 (modes), where the means, 
c  medians, and modes are from the final cycle population density.



c  These values differ from YPREDPOP in that the observed values
c  do not occur at the J=1,NOBSER observation times in a patient's
c  data file. Instead, they occur at the values of t inside TTPRED

c  (see the logic for forming the PRTBxxxx file = file 31), which are
c  all the times from t = 0 till t = 24 hours past the last obs. time
c  among all the patient data files ... but the no. of values is
c  capped at 7201 (see logic below for doing this).

c  Because the density file, and therefore the combined output file,
c  have extra info (YPREDPOPT) in them, they will have a new code.
c  In particular, format 1657 will be changed to specify VERSION 39
c  (and MADE BY bigmlt2.f), and format 7124 will be changed to specify
c  DENSITY JUN_09 (and MADE BY bigmlt2.f).

c  6. 3 modules which are linked into this program are changed. In
c  particular, idfix5g.f, idcy_53g.f, and idcy_63g.f are changed, 
c  respectively, to idm1x1.f, idm2x1.f, and idm3x1.f. These new modules 
c  allow the extra option of setting initial compartment amounts from 
c  their initial concentrations - see code in Subroutines FUNC, FUNC2, 
c  and FUNC3. And they allow patient data files to have "reset" values 
c  of 0 in the dosage and sampling blocks. Whenever, in Subroutine FUNC 
c  (or FUNC2 or FUNC3) the program sees a SIG(.) = 0 and a TIM(.) = 0, 
c  it knows that a large enough time has passed since the last dose
c  that all compartment amounts are to be reset = 0. Subsequent dose
c  and observed value times are values from this point.

c  Note that the modules blasnpag.f and shift3.f are unchanged.
c  Note that the new model file template, TSTMULTE.FOR, has code in
c  Subroutine SYMBOL that allows the user to set up the option indicated
c  above of setting initial compartment amounts from their initial
c  concentrations.


c-----------------------------------------------------------------------

c  bigmlt1.f							1/6/08

c  bigmlt1.f is the main module for the "engine" which corresponds to 
c  the most recent multiple drug PC PREP PROGRAM, NPBIG15.FOR. The

c  other modules of the "engine" (idfix5g.f, idcy_53g.f, idcy_63g.f,
c  shift3.f, and blasnpag.f) are unchanged. The changes in this module


c  from bignpaglap4.f are as follows:

c  1. It reads in a different instruction file, npembig33.inp (updated

c  from npembig3.inp). npembig33.inp has extra info. Instead of just

c  NSUB, the no. of subjects, it also has NSUBTOT and IPATVEC(I),
c  I=1,NSUB, where NSUBTOT is the total no. of subjects in the


c  patient population (all of these subject files are concatenated
c  on npembig33.inp), NSUB is the no. of these subjects which are to
c  be analyzed in this run, and IPATVEC(I),I=1,NSUB are the indices
c  of these "active" subjects for this run. Note that the first
c  PC PREP program which creates npembig33.inp is NPBIG15.FOR.


c  The code will be changed to write just the "active" subject data
c  files (IPATVEC(I),I=1,NSUB) onto the scratch file (27) to be analyzed

c  during this run (see code below label 1717).

c  2. This program will write just the "active" NSUB patient data files
c  into the output file, along with IPATVEC(I),I=1,NSUB, so the PC PREP 
c  program will know which subjects were analyzed. Because of the extra 
c  info to be put into the output file (NSUBTOT, IPATVEC), the code for 
c  the output file will be changed from VERSION 37 to VERSION 38 in 
c  FORMAT 1657.

c  3. New subroutines, WRITEPT2, GETIPATF, GETNUMSF, GETSUB are
c  added.

c  4. Note that formats 1657 and 7124 are changed to write out this
c  program "bigmlt1. And VER_BAK AUG_02 is changed to VER_BAK NOV_07
c  just below format 1657.

c  5. In subroutine EMINT,  rmax = -1.e100  is changed to  rmax = -1.e38
c  to be compatible with the Fortran F77L3 compiler (i.e., e100 is too
c  big for that compiler). In addition, all etime(dummy) references are
c  changed to 0 (since the PC compiler doesn't recognize etime).

c  6. In SUBROUTINE DPOTRF, both references to  ILAENV are removed. It
c  is never used, and being declared EXTERNAL causes an error when
c  the program is linked on the PC using the F77L3 linker.

c  7. The screen dump of all output info from the main module has 
c  been replaced by four lines having just the cycle no., convergence 
c  criterion, and the medians. The exception is that until
c  NACTVE .LE. NSTORE, the program will print to the screen the update 
c  on what % of grid points have been calculated since otherwise the 
c  user might think his computer has locked up (once NACTVE .LE. NSTORE, 
c  all the P(YJ|X)'s will already be stored into PYJGX --> the DO 800 
c  loop will go very fast.


c  Note that ISUPRES will be hardcoded = 1 (this will tell the user
c  the the above minimal info is to be printed to the screen). If
c  for some reason the full info is needed again, I can just change
c  ISUPRES = 0 in the code.

c  8. The user will be told before the run begins that he can 
c  execute the batch file, CHMAXCYC.BAT (by typing CHMAXCYC at 
c  a DOS prompt), in the working directory of a PC and that will
c  cause the program to stop safely at the end of whatever cycle it 
c  is on, as if the maximum no. of cycles has been reached.


c  This batch file will simply copy to the file CHMAXCYC.OLD the file

c  CHMAXCYC.NEW. Note that CHMAXCYC.BAT, CHMAXCYC.OLD and CHMAXCYC.NEW 
c  are made by this program before cycle calculations begin. 
c  CHMAXCYC.OLD has a 1 on the first line and CHMAXCYC.NEW has a 0 on 
c  the first line. The program will open and read CHMAXCYC.OLD at the 
c  beginning of each new cycle. If it reads a 1, it will continue the 
c  calculations as before. If it reads a 0, it will change the value of 
c  MAXCYC to whatever ICYCLE is currently, which will cause the program 

c  to halt at the end of that cycle just as if MAXCYC had been set
c  to the changed value originally. If this happens, the program will
c  write a comment to the console and file 25 of why the program

c  has stopped prematurely.

c  Note that the user may want to exercise this option if he wants to
c  see the results from a slowly converging run, and then, because
c  the density file from the last cycle will have been correctly 
c  created, still be able to start another run using the final cycle 
c  joint density from the halted run (with different parameters if 
c  desired).

c  Note that because of the messages to the user, accompanied by
c  PAUSE commands, this program must be run interactively at least
c  at the start. I.e., if this program is to be run without user
c  oversight, I will have to take out the PAUSE commands, and of 
c  course then the option described here will be moot (i.e., without
c  user interaction, the user would not know that the program is
c  converging slowly).


c  9. ADDITIONAL INFO WILL BE WRITTEN INTO FILE 31 (PRTBxxxx). 
C  PREVIOUSLY, FOR EACH SUBJECT THE PREDICTED VALUES (BASED ON EITHER 
C  THE MEANS, MEDIANS, OR MODES FROM THAT SUBJECT'S BAYESIAN POSTERIOR 
C  DISTRIBUTION) WERE CALCULATED AND WRITTEN FOR THE TIMES IN TPRED. 
C  NOW, IN ADDITION, FOR EACH SUBJECT AND EACH OUTPUT EQUATION, THE 
C  OBSERVATION TIMES AND OBSERVED VALUES (FROM EACH SUBJECT'S PATIENT 
C  FILE), AND PREDICTED VALUES (BASED ON THE MEANS, MEDIANS, OR MODES 
C  FROM THAT SUBJECT'S BAYESIAN POSTERIOR DISTRIBUTION) WILL BE WRITTEN.

c  10. New format 5456 has been added to clarify the results in the
c  output file.

c  11. Every STOP statement, except the one that terminates the program 
c  after a complete run, is now preceeded by a PAUSE statement. This is
c  done so that when this program is run unders windows, the window 

c  will not disappear immediately with no explanation. i.e., with the
c  PAUSE statements, the explanation for the stopping of the program

c  will remain on the screen until the user presses the enter key.

c  12. The limitation of 250000 for maxactem in Subroutine emint is 
c  changed to be 10000000.

C  13. THE CODE AT THE END OF MAIN (TO REMOVE THE fort.27 FILE, AND
C  TO WRITE THE TIME OF THE RUN INTO FILE 91) ARE COMMENTED OUT
C  SINCE THEY ARE NO LONGER APPLICABLE.

C  14. The combined output file is made using READLARG (and format 2717) 
c  instead of using READLINE (and format 1717). READLARG is a 
c  character 300 variable, where READLINE is a character 78 variable. 
c  The extra characters ensures that no lines will be cut off.

C  15. At the end of each cycle, the program now
c  writes the 1st part of the density file into DENFIL (i.e., it 
c  overwrites this info from the previous cycle). This will be 
c  useful if the program crashes after a long run ... since then the 
c  user can simply run the PC prep program and restart the run using 
c  the latest density file as the aprior density (i.e., the engine will
c  pick up where it crashed). big1 only made the density file (and

c  the combined output file) at the end of the run.

c  Note that the density file created at the end of each cycle is
c  not the full density file created at the end of the run. It only
c  includes the info down to CORDEN, which is all that the PC prep
c  program needs for its apriori density.

c  16. It checks MAXCYC to see if it is 0. If so, it means that the user
c  wants to bypass the usual NPAG analysis, and instead calculate the
c  output files based on the input density (which becomes the "final
c  cycle joint density") and the patient data files. This option is
c  used to get the Bayesian Posterior Joint Densities (and predicted
c  values, etc.) for a set of subjects, based on a joint density from
c  a previous Big NPAG run.


c  Note that Subroutine SUBRES (and its argument list) is changed to
c  accomadate the calculation of PYJGX in case MAXCYC = 0 (see 
c  explanation before the call to SUBRES).


c  17. The no. of random variables is now .LE. 25 rather than .LE. 20. 
c  Also, the no. of fixed parameters is now .LE. 7 rather than .LE. 12.

c  18. In the DO 800 loop, the % increment reported during the cycle 
c  calculations for each subject is changed to every 1% rather than

c  every .1%.

C  19. NOTE THAT THE PATIENT DATA FILES WILL BE CONCATENATED AS USUAL
C  AT THE END OF npembig33.inp, REGARDLESS OF WHETHER IFORMT = 1 OR 3.
C  I.E., AFTER READING IN IFORMT, THE PROGRAM WILL READ IN PREFIX AND 
C  EXT. I.E., THERE WILL BE NO PRFIX2/EXT2, ETC.

c-----------------------------------------------------------------------

c  bignpaglap4.f						8-31-03


c  bignpaglap4.f has the following changes from bignpaglap3.f:

c  1. In the output file, NGRID is written using format 9869 so 
c  SUBROUTINE PREVRUN in the PC PREP PROGRAM will easily be able to 
c  read in NGRID. Previously, NGRID was established from the reading 
c  in of INDPTS in the density file, but this could cause a problem 
c  if NGRID was reset because it was larger than MAXACT, since INDPTS 
c  is not reset (see comments in NPBIG14.FOR).

c  2. Note that formats 1657 and 7124 are changed to write out this
c  program "bignpaglap4.

c  3. VERSION 36 in FORMAT 1657 is changed to VERSION 37, because

c  SUBROUTINE PREVRUN in the PC PREP PROGRAM will only read NGRID
c  from the output file (see format 9869) from this version on.

c  4. Subroutine STAZ has a bug fix. Previously, grid points which 
c  landed exactly on the upper boundary value didn't get counted.
c  Now, they will be (see code).

c  5. A bug is fixed which could occur when the program concatenates 
c  the density file onto the combined output file. Line are truncated to 

c  72 characters, and so when the the following line is copied:
c  198.532739532312       0.314723681391700       0.405442300013591D-001
c  it will be written as 
c  198.532739532312       0.314723681391700       0.405442300013591D-
c  and then when the PC preparation program (currently NPBIG14.EXE)
c  reads this line, it will bomb since it expects 3 nos. in this line,
c  but the last no. is not read as a number (because of the "D-").

c  The fix is to read and write 78 characters rather than just 72 
c  characters. So, format 1717 will be changed to A78, and READLINE
C  will be changed to CHARACTER*78. Also, in Subroutine Filred, 
c  the same change will be made since it doesn't hurt, and this
c  keeps the code consistent throughout.

c-----------------------------------------------------------------------


c  bignpaglap3.f						8-29-02

c  bignpaglap3 has the following changes from bignpaglap2:


c  1. Instead of hardcoding ierrmod = 1, ierrmod (and gamlam0) will
c  be read in from npembig3.inp (changed from npembig2.inp). There is
c  corresponding new code to assign the inital value of gamma or flat 
c  from gamlam0.

c  2. For each cycle, ierrmod and gamlam are now written into the
c  output file. The code "bignpaglap2" is changed to bignpaglap3 in
c  both the output and density file. Also, the version code in the
c  output file is changed from VER_BAK DEC_01 to VER_BAK AUG_02 
c  (because of the additional information, ierrmod and gamlam, which
c  is written to the file).


c  3. New output formats 2112, ..., 2117 are put into the output file
c  to remind the user what the assay std. dev. model is in the run.

c  4. New code involving LASTCYC prevents the cycle no. from being
c  written 3 times for each cycle if ierrmod .GE. 2 (since the code

c  to estimate gamma/lambda if ierrmod .GE. 2 requires the loop which 
c  includes writing the cycle no. to be executed 3 times for each
c  cycle).

c-----------------------------------------------------------------------

c  bignpaglap2.f						7-24-02

c  bignpaglap2 is the multiple drug version of bignpaglap1 (which only

c  allows one drug). It essentially makes the same changes to 

c  bignpaglap1 (in this regard) that npbig8adapt.f made to 
c  npbig7adapt.f. 

c  Note that just as bignpaglap1.f is at the same "level" as 
c  npbig7aadapt.f [except that the former has Bob Leary's updated 
c  efficiency improvements, and multiplicative GAMMA and additive LAMBDA 
c  options (which are turned off for now)], bignpaglap2.f will be at the
c  same "level" as npbig8adapt.f [with same exceptions as indicated
c  above].


c  The changes are as follows:



c  1. bignpaglap2 allows multiple drugs. Coding changes are required
c  in Subroutine FILRED to read in multiple drug info. Note that each 
c  drug will have one column for IV values and one column for bolus 
c  values. In addition, there are other changes to the formatting 
c  (see 2DRUG001 for an example of a typical new working copy patient 
c  data file). Note that the only dimension changes in Subroutine FILRED
c  are: BS(500,3) is changed to BS(500,7), and NTLAG is now a vector 
c  instead of a scalar (it has dimension 7).

c  This file is now compiled with blasnpag.f, idfix5g.f (updated from 
c  idfix5f.f), idcy_53g.f (updated from idcy_53f.f), idcy_63g.f (updated 
c  from idcy_63f.f), and shift3.f (updated from shift2.f).

c  2. In the regular OUTPUT file and the density file, 
c  "MADE BY bignpaglap1" is replaced by "MADE BY bignpaglap2".

c  3. SUBROUTINE BIGNPEM is replaced by SUBROUTINE BIGNPAG to emphasize 


c  that the new code for multiple inputs is only applicable for the
c  BIG NPAG program (note that the first PC preparation program used 
c  with this program was NPBIG11.FOR).

c-----------------------------------------------------------------------


c  bignpaglap1.f						7-19-02

c  Note that bignpaglap1.f is at the same "level" as npbig7aadapt.f,
c  but it has Bob Leary's updated efficiency improvements, and 
c  multiplicative GAMMA and additive LAMBDA options (which are 
c  turned off for now).

c  bignpaglap1.f has the following changes from bignpaglap.f
c  (bignpag.f):

c  1. All information needed by the Big PC Prep Program (currently 
c  NPBIG10B.FOR) will now be put into one combined output file. That is,
c  this program will essentially concatenate 4 files which were 
c  previously kept separate, OUTFIL, DENFIL, npembig2.inp (actually 
c  just the patient data portion of npembig2.inp), and npemdriv.f. This 
c  will enable the user to run the PC Prep Program with just this one
c  combined output file (i.e., even the working copy patient data files
c  will no longer be needed).


c  THE name for the OUTPUT FILE is now changed to 'OUTT'//NAME SINCE 
c  'OUT//NAME will be reserved for the combined OUTPUT FILE formed at 
c  the end of the run.

c  2. In the regular OUTPUT file, on line 1, the version no. is changed 
c  from 35 to 36, and "MADE BY bignpaglap1" is added to the 1st lines 
c  in the output and density files. See formats 1657 (changed) and
c  7124 (new). Also, the 2nd line in the output file is changed to 
c  VER_BAK DEC_01.

c  3. The convergence index (HOWCLOSE), and how close the current 
c  density is to the M.L.E. of the density (MAX(DXI) - NSUB), are
c  removed. DXI is left in only as an argument to BIGNPEM, and DORIG is 
c  left in only to be read and written to the density file so that the 
c  format of that file does not have to be changed.

c  4. This module will no longer contain the modules idfix5*.f, 


c  idcy_53*.f, idcy_63*.f, and shift2.f. These modules will be
c  compiled and linked separately.


c  5. The I/O to input ierrmod will be suppressed since there can be
c  no user interaction with this program. For now, ierrmod will be
c  hardcoded = 1.

c  6. Note that the PARAMETER statement in Subroutine emint has the
c  following line to set the values for MAXACTem and MAXSUBem:
c      parameter (MAXSUBem=999,MAXACTem=250000)
c  These values can be reset as needed.


c-----------------------------------------------------------------------

c bignpag.f                                                     07-05-2002
C BIGNPAG with multiplicative GAMMA and additive LAMBDA options
c this is the bignpag version with time lags and initial conditions
c This version is consistent with BIGNPEM version 5 (see  npbig5.f below)
c Changes in July 2002 involve replacing the LINPACK-based linear equation solver
c in subnroutine emint with the Cholesky sovler from LAPACK.
c changes in July 01 include new, more efficient Hessian construcution routine
c This version is dimensioned for a MAXSUBem (maximum number of subjects)
C of 400 - this is easily changed by changing the MAXSUBem PARAMETER
C statement in subroutine EMINT.  Also, the max number of grid points is
c 250,000 - this is also adjustable by the PARAMETER statement for
C MAXACTem in emint.


C July 05 2002 changes
c repalced calls to Linpacksymmetric indefinite linear equation solver
c dsifa and dsisl with lapack cholesky solver DPOTRF and DPOTRS
c begin 01/02/02 changes

c saved density results in denstor(*,4)  for best of base, plus,

c and minus case, so proper statistics would be generated based
c on the best case.
c begin 12/31/01 changes
c renamed iteration logfile itlog to ILOGxxxx, where xxxx is current run
c number from 'extnum' file.
c end 12/31/01 changes
c begin 12/16/01 changes
c added error model selection capability - currently four choices:
c 1 - use error polynomial as given in input file,
c 2 - optimally scale error polynomial by multiplicative factor gamma

c 3 - optimally find an additive error lambda, such that error^2 =

c     lambda^2 + polynomial^2
c 4 - find optimal flat weighting - this is equivalent to using a
c     polynomial with only a constatn term, and finding the optimal
c     value of that constant with option 1)
c end 12/16/01 changes
c begin 7/04/01 changes
c ROUTINE STAT change to STAZ to avoid conflict with system routine
c Also, first '0.0' agrument changed in CALL OUTPUT(0.0,...' to 0.0D0
c to agree with argument typing
c end 7/04/01 changes
c  NPBIGADAPT
c  4/06/2000 - April 6, 2000 - New adaptive grid version
 
c  This version is built on top of the previous fixed
c  grid version of BIGNPEM and represents a major algorithmic
c  change. NPGIGADAPT is the adaptive grid version of BIGNPEM -
c  It is designed to work with exactly the same driver file
c  npemdriv.f and input file npembig2.inp as previous versions
c  of BIGNPEM.  Results in terms of the log likelihood of the

c  final density produced are typically much better than
c  previous versions, which used a fixed grid, even when the

c  adaptive version is started from a small grid and the previous
c  fixed grid version is started from a very large grid.

c  Thus the NPBIGADAPT version can be run on a workstation or PC
c  in moderate amounts of time and with relatively low
c  memory requirements and still produce results equivalent to or
c  better than a large fixed grid version run for many processor
c  hours on a parallel supercomputer.
 
 
c  This version works on the following logic
 
c  Step 0 (intialization) ;
c  The data file npembig2.inp is read and the initial grid of
c  size NGRID (as specified by the INDPTS variable in the
c  iput file) is generated using a low-discrepancy (or
c  'quasirandom') Faure generator.
c  Note that we require that all points fit in memory, so if
c  NGRID is larger than the memory limit MAXACT in the driver
c  program npemdriv.f, we reset NGRID to
c  MAXACT.  Also, the old termination criteria JSTOP and
c  TOL in npembig2.inp are now still read but ignored - they
c  are replaced with hardwired criteria (see below).  However,
c  the MAXCYCLE criterion is retained but changes its meaning.
c  It now represents a limit on the number of grid condensation -

c  expansion cycles, not the limit on the number of cycles in
c  the EM algorithm (the EM algorithm is no longer used, having
c  been replaced by the more efficient interior point algorithm
c  developed by Jim Burke at University of Washington).

 
c  Step 1; (solve ODEs on current grid)

c  solve all the ordinary differential equations defining the
c  PK model on the current set of grid points and compute
c  the corresponding likeihoods for each combination of

c  subject and grid point to produce the likelihood matrix
c  PYJGX(J,IG)  (J=subject index, IG = grid point index)
 
c  Step 2 (grid condensation)
 
c  Solve the maximum likelihood EM problem  defined by the likelihood
c  matrix PYJGX corresponding to the current grid
c  via the interior point method implemented in subroutine emint.
c  On the first cycle this condenses the number of active gridpoints
c  NACTVE from the  starting value of NGRID to approximately
c  NSUB, the number of subjects.  On subsequent cycles, this step

c  will condense the current set of NACTVE (usually now much
c  smaller than NGRID but still several times larger than NSUB)
c  points to NSUB points.

 
c  Step 3 (grid expansion).
c  Each of the NSUB active grid points is perturbed in each
c  parameter with a +EPS and -EPS percentage perturbation while
c  holding the other parameters fixed.  Thus if there
c  are NPARAM parameters, there are 2*NPARAM perturbed points.
c  These checked to see if they lie within the original parameter
c  bounds specified in npembig2.inp.  Those perturbed grid points
c  that lie within the bound are added to the NSUB active grid points
c  to form a new set of approximately NACTVE = NSUB*(1+2*NPARAM).

c  Note that in general this is much smaller than the original set of
c  NGRID points.  EPS is initially set to 20% of the range of
c  the corresponding parameter.  As the algorithm proceeds, the
c  grid resolution will be lowered in stages to 0.01% of the
c  range.
 
c  Step 4 (termination check)
c  If the LOG-LIKELIHOOD of the current grid is at least a
c  tolerance TOL (hardwired in the current verison to 0.001), we
c  maintain EPS at the current value and
c  continue.  If the LOG-LIKELIHOOD does not improve by at least TOL,
c  we cut EPS in half, generate a new grid, and continue.

c  The algorithm terminates when either
c  a) the designated maximum number of cycles MAXCYC in npembig2.inp
c     is reached, or
c  b) EPS reaches the (currently hardwired) limit of 0.01% AND the
c     improvement of the current cycle over the previous cycle

c     in log-likelihood is less that the (currently hardwired)
c     tolerance of 0.001
c

c
c-----------comments below refer to previous fixed grid versions ----
c  npbig5.f							2-17-00
 
c  npbig5 is the same as npbig4, except:
 
c  FORMAT 88 IN MAIN AND PRNTOP IS CHANGED TO INDICATE THAT A
C  CONVERGENCE INDEX OF .LE. 1 = CONVERGENCE (NOT JUST AN INDEX = 1).
 
C-----------------------------------------------------------------------
 
c  npbig4.f							1-23-00
 
c  npbig4 is exactly the same as npbig3. The only change is that it is
c  linked with new modules on the supercomputer. idfix5d.f is replaced
c  by idfix5e.f; idcy_53d.f is replaced by idcy_53e.f; and idcy_63d.f is
c  replaced by idcy_63e.f. These 3 new modules have updated code to
c  allow initial conditions of the amounts in the compartments to be set
c  = paramater values, rather than always fixed = 0.0.
 
c  SUBROUTINE SYMBOL in the Fortran model file (see, e.g.,

c  INITCOND.FOR) now contains an additional COMMON/INITCOND/IC, and the
c  user sets IC(I) = J for each compartment, I, which will have its
c  initial amount set = value of parameter J. This info is passed to
c  the above 3 id modules. Also, the dimension of P in OUTPUT and
c  DIFFEQ is changed to 32.
 
c  Note that the 3 new id modules above have a lot of code
c  simplification (see notes in their code). In particular, the
c  square root transformations are no longer done --> the results
c  for this program will differ possibly a little from previous
c  results.
 
c-----------------------------------------------------------------------
 
c  npbig3.f							1-19-00
 
c  npbig3 is exactly the same as npbig2. The only change is that it is
c  linked with new modules on the supercomputer. idfix5c.f is replaced


c  by idfix5d.f; idcy_53c.f is replaced by idcy_53d.f; and idcy_63c.f is
c  replaced by idcy_63d.f. These 3 new modules have updated code to


c  correctly allow the IDIFF = 0 option, which bypasses the calling
c  of USERANAL (and its calls to DIFFEQ). Instead the value(s) for
c  the output(s) will be coded explicitly into SUBROUTINE OUTPUT. Also,

c  SUBROUTINE OUTPUT has an additional argument, the time at which the
c  output value(s) is(are) desired.
 
c-----------------------------------------------------------------------

 
c  npbig2.f							11-8-99
 
c  npbig2 is the same as npbig1 except for a change in COMMON/CNST
c  in subroutine FILRED. NTLAG is now added.

 
c  This change, and others, are required for all modules in this
c  program, which allow time lags.
 
c-----------------------------------------------------------------------
 
c  npbig1.f							10-12-99
 
c  npbig1 has the following changes from m2_19aca.f:
 
C  1. THE GRID POINT SELECTION PROCEDURE IS CHANGED. SUBROUTINE GETCOF
C  IS REMOVED, AND SUBROUTINE CALGRD IS REPLACED BY A NEW CALGRD, ALONG
C  WITH ROUTINES INFAUR AND GOFAUR. NOTE THAT ALL REFERENCES TO THE
C  NUMBER THEORETIC INTEGRATION SCHEME ARE REMOVED.
 
C  2. THE CONVERGENCE CRITERION IS CHANGED TO HAVE AN ABSOLUTE VALUE
C  SIGN AROUND (SLPYJ-PRESLP). THIS SHOULDN'T BE NECESSARY SINCE THE
C  LOG-LIK IS MONOTONICALLY INCREASING, IN THEORY. THE ABS. VALUE
C  MEANS THAT IF A STRANGE NUMERICAL "GLITCH" OCCURS WHICH RESULTS
C  IN THE LOG-LIK DECREASING FROM 1 CYCLE TO THE NEXT, THE PROGRAM WON'T
C  AUTOMATICALLY HAVE SATISFIED THE CONVERGEGENCE CRITERION. OF COURSE,
C  IT'S POSSIBLE THAT IN SUCH A CASE, WE WOULD WANT THE PROGRAM TO STOP,
C  REGARDLESS.
 
C  3. SUBROUTINE STAT NO LONGER ALWAYS USES NINT = 100. INSTEAD, NINT
C  WILL BE THE MAX(100,2*NSUB). THE REASON IS THAT THE MARGINAL SCALED
C  INFO HAS A DENOMINATOR OF LN(NINT/NSUB) IN THE CALCULATION, WHICH
C  RESULTS IN A DIVIDE BY 0 ERROR IF NSUB = 100 (AND RESULTS IN
C  NEGATIVE SCALED INFO (WHICH IS SUPPOSED TO BE BETWEEN 0 AND 100),

C  WHEN NSUB > 100. BY MAKING NINT .GE. 2*NSUB, THIS PROBLEM WILL
C  DISAPPEAR.
 
C  4. AN ADDITIONAL STATISTIC IS OUTPUT EACH CYCLE, HOWCLOSE. IT
C  IS A MEASURE OF HOW CLOSE TO CONVERGENCE THE PROGRAM IS. THIS WILL BE
C  IN FORMAT 88, JUST BELOW THE FORMAT 8'S IN MAIN AND PRNTOP. HOWCLOSE
C  WILL BE ADDED AS AN ARGUMENT TO PRNTOP.
 

C  5. A CHANGE IS MADE TO FORMAT 1652 (IN MAIN AND SUBRES), AND THE
C  VALUES SK AND KU ARE SET TO WHEN ICOVL0 = 1 (WHICH OCCURS WHEN AT
C  LEAST ONE PARAMETER HAS VARIANCE NUMERICALLY .LE. 0). NOW KU AND SK

C  WILL BE WRITTEN OUT AS -99999999, RATHER THAN 1.D30. IT USED TO BE
C  THAT 1.D30 WOULD PRINT OUT AS *'S, BUT NOW WITH THE G FORMAT IT
C  PRINTS OUT AS A LEGITIMATE NUMBER, AND -99999999 IS A BETTER WAY TO
C  EXPRESS THAT THESE VALUES DO NOT EXIST.
 
c-----------------------------------------------------------------------
 
c  m2_19aca.f							5-23-99
 
c  m2_19aca has all the changes that m2_20cal thru m2_20bca made to
c  m2_19cal, except that the assay s.d.'s are still functions of

c  observed values, rather than predicted values.

 
c  The changes are:
 
 
c  1. RS(500,14) DIMENSIONS ARE CHANGED TO RS(500,34), TO ALLOW UP TO
c  30 USER-SUPPLIED COVARIATES.
 
C  2. A BUG IN THE CALCULATION OF ENTROPY IS CORRECTED. THE ENTROPY
C  ENTROPY CALCULATION IS MOVED TO BE AFTER SUM=SUM/DL2 STATEMENT.

 
C  3. FORMAT 6543 IN PRNTOP IS CHANGED TO BE SAME AS IN MAIN.
 
c-----------------------------------------------------------------------
 
 
c  m2_19cal.f							7-28-98
 
c  m2_19cal.f has the following changes from m2_18cal.f:
 

c  It corrects a "bug" in m2_18cal.f. m2_18cal.f never allowed for
c  an observed value to be missing. With multiple outputs, not all
c  output equations will necessarily have observed levels at all
c  observation times. An observed level which is "missing" has the
c  value -99 in its entry. m2_18cal.f just treated the -99 as a
c  regular value.
 
c  The only functional changes involve MISVAL in and after loop 140.
 
c  The only other module which needs to be changed is idfixed4.f -->
c  idfixed5.f (idcy_53.f and idcy_63.f just calculate predicted values
c  at all the observation times. This can be done for all output eqs.
c  for all the observation times, regardless of which observed values
c  are missing).
 
c-----------------------------------------------------------------------
 
c  m2_18cal.f							6-28-98
 
c  m2_18cal.f has the following changes from m2_17cal.f:
 
C  1. IT ALLOWS MULTIPLE OUTPUTS. THERE WILL BE NUMEQT OUTPUT EQUATIONS.

C  NUMEQT IS PASSED TO THIS ROUTINE (BIGNPEM) BY npemdriv.f (MADE BY
C  M2_18.FOR) IN THE ARGUMENT LIST. SEVERAL ARRAYS HAVE AN EXTRA
C  DIMENSION TO IDENTIFY THE OUTPUT EQUATION, INCLUDING YPREDPOP AND
C  YPREDBAY WHICH ARE ARGUMENTS FROM npemdriv.f.

 
C  THE INPUT FILE HAS BEEN RENAME npembig2.inp SINCE NEW INFORMATION
C  IS INCLUDED.

 
C  SUBROUTINE FILRED HAS CHANGES TO ACCOMODATE MULTIPLE OUTPUTS.
 
C  THIS MODULE WILL BE LINKED WITH OTHER CHANGED MODULES, idfixed4.f,
C  idcy_53.f, AND idcy_63.f, ALONG WITH vodtot.f (WHICH IS UNCHANGED).
 

C  2. SOME COMMENTS REGARDING WHAT'S IN THE INPUT FILE, npembig2.inp,
C  HAVE BEEN IMPROVED OR CORRECTED.
 
C  3. POPULATION VALUES FOR THE NUMEQT SETS OF C'S NOW WRITTEN TO FILE
C  25 USING FORMAT 162, INSTEAD OF 161.
 
C  4. INFIL NO LONGER READ FROM INPUT FILE npembig2.inp (IT WAS NEVER
C  USED).
 
C  5. CYCLE NO. IS ALSO WRITTEN OUT IN FORMAT 8888.
 
C-----------------------------------------------------------------------

 
c  m2_17cal.f							5-1-98
 
c  m2_17cal.f has the following changes from m2_16cal.f:

 

C  1. Input file fil01.inp IS renamed npembig1.inp. There are no
c  changes to this file, but now the name is more suggestive of what
c  it is.
 
C  2. FORMAT 161 REPLACES * FORMAT WHEN WRITING OUT THE C'S TO A FILE,
C  TO AVOID POSSIBILITY THAT PART OF LINE WRITTEN WILL BE TRUNCATED IF
C  IT EXTENDS PAST COLUMN 72.

 
c-----------------------------------------------------------------------
 
c  m2_16cal.f						2-12-98

 
c  m2_16cal.f has the following changes from m2_15cal.f:
 
c  1. m2_16cal.f has the same format changes from m2_15cal.f M2_16.FOR
c  has from M2_15.FOR, namely:
 
C  ALL F AND E FORMATS WILL BE CHANGED TO G FORMATS. SINCE THE G

C  FORMAT REQUIRES AT LEAST 6 SPACES IN ADDITION TO THE DECIMAL SPACES +
C  THE SPACE FOR THE DECIMAL POINT ITSELF (TO REPRESENT ALL POSSIBLE
C  NUMBERS, INCLUDING THE NEGATIVE SIGN IF THERE IS A NEGATIVE NO.),
C  THE FORMAT WILL BE Gw.d, WHERE w MUST BE AT LEAST 6 BIGGER THAN d.
 
C  THEREFORE, THE FOLLOWING LOGIC WILL BE USED TO CONVERT THE FORMATS.
C  GIVEN AN F OR E FORMAT w.d, THE REPLACING G FORMAT WILL BE ww.d,
C  WHERE ww = MAX(w,d+6). IF ANY ACCOMPANYING FORMATS ARE DEPENDENT ON
C  THE REPLACED FORMAT, IT WILL BE CHANGED ACCORDINGLY. FOR EXAMPLE,
C  FORMAT 5104 IS USED TO PLACE THE PARAMETER NAMES ABOVE MEANS,
C  MEDIANS, ETC. USING FORMAT 5103. PREVIOUSLY, THE FORMATS WERE:
 
C  5104   FORMAT(5X,20(A11,5X))
C  5103   FORMAT(1X,20(F11.6,5X))
 
C  IN THIS PROGRAM, SINCE 11.6 MUST BE CHANGED TO 12.6 FOR THE G FORMAT
C  (I.E., ww = MAX(11,6+6) = 12), AND SINCE 5X HAS BEEN CHANGED TO 1X,
C  FORMAT 5104 MUST BE CHANGED TO BE COMPATIBLE.
 
C  5104   FORMAT(5X,20(A11,2X))
C  5103   FORMAT(1X,20(G12.6,1X))
 
C  A COUPLE OF OTHER EXCEPTIONS FROM THE ABOVE RULE HAVE BEEN MADE FOR
C  COSMETIC REASONS, INCLUDING PRINTING OUT % VALUES (AND FORMATS
C  2049, 2051, 2052) IN MAIN.
 
 
c  2. The order of the arguments in COMMON/DESCR has been changed. For
c  some reason, the fortran compiler likes to see Real*8 variables
c  preceed integer variables. Otherwise, warning messages appear.
 
c-----------------------------------------------------------------------
 
c  m2_15cal.f							1-22-98


 
c  m2_15cal has the following changes from m2_14cal:

 
c  1. AGE, ISEX, HEIGHT, and IETHFLG are input in subroutine FILRED,

c  for each subject, and these values are now passed to subroutines
c  DIFFEQ and OUTPUT, part of the fortran file created by the
c  boxes-type program (or made manually). This fortran file is part
c  of npemdriv.f, uploaded by the user after running M2_15.EXE. These
c  values are passed via COMMON/DESCR.
c  The new boxes program is BOXNEW2.PAS, changed from BOXESNEW.PAS.
 
c  2. In subroutine FILRED, since RS must store all the psuedo "rates"
c  (i.e., all the covariate info input in the dosage regimen), RS

c  dimensions have been increased from (500,8) to (500,14). Since
c  RS is passed via COMMON/OBSER, modules idfixed3.f (changed from
c  idfixed2.f), idcy_52.f (changed from idcy_51.f), and idcy_62.f
c  (changed from idcy_61.f) must be changed correspondingly. Also,
c  these modules have changes related to a "bug" correction regarding
c  IDIFF.
 
c-----------------------------------------------------------------------
 
c  m2_14cal.f						   	11-6-97
 
c  m2_14cal has the following changes from m2_13cal.
 
c  1. This module is now SUBROUTINE BIGNPEM, called by npemdriv.f, which
c  is created by the PC preparation program, M2_14.FOR. This change was
c  made so a dynamic allocation of dimensions can be made, based on
c  how many subjects, random parameters, and grid points the user
c  has selected.
 
c  npemdriv.f, the "MAIN" module, HAS A PARAMETER STATEMENT WHICH

c  DEFINES THE PARAMETERS WHICH ESTABLISH THE DIMENSIONS IN THE VARIABLY
c  DIMENSIONED ARRAYS. IT THEN HAS THE STATEMENT:
C  CALL BIGNPEM( ...) , WHERE ALL VARIABLY DIMENSIONED ARRAYS (AND THE
C  VARIABLE PARAMETER DIMENSIONS) ARE PASSED IN THE ARGUMENT LIST.
 
C  NOTE THAT ARRAYS PYJGX, EXX, YPREDPOP, AND YPREDBAY NOW HAVE MAXSUB
C  AS A VARIABLE DIMENSION. ALSO, PYJGX'S 2ND DIMENSION, AND PYJGXX'S
C  SINGLE DIMENSION IN SUBROUTINE SUBRES HAVE BEEN CHANGED FROM MAXGRD
C  TO MAXACT (WHICH THEY WERE SUPPOSED TO HAVE BEEN ANYWAY).

 
c  2. Some unneeded format statements are eliminated.
 
c  3. ATOL(3) TO ATOL(20), WHICH IT SHOULD HAVE BEEN ALL ALONG.
 
c  4. THE VALUES FOR RTOL AND ATOL() ARE PRINTED TO THE OUTPUT FILE.
 
c  5. THE ORIGINAL NO. OF GRID POINTS, IN ADDITION TO THE CURRENTLY
C  ACTIVE NO. OF GRID POINTS, IS PRINTED OUT EACH CYCLE (INCLUDING
C  PARTIAL CYCLES PRINTED BY SUBROUTINE PRNTOP, AND THE MAP-BAYESIAN
C  CYCLE FOR EACH SUBJECT IN SUBROUTINE SUBRES).
 
c  6. Format 2314, if applicable, is written to the output file, in
c  addition to the screen.
 
c-----------------------------------------------------------------------
 
c  m2_13cal.f						   	8-31-97
 

c  m2_13cal is the same as m2_12cal except that the maximum no. of grid
c  points, MAXGRD, is increased from 16*80021 to 100*80021, the maximum

c  no. of subjects is increased  to 200, from 100, and the maximum no.
c  of dimensions is increased to 10 from 8.
 
c  Note that there is a limit to how big the program can be in more
c  than one way. In particular, the maximum number of double precision
c  entries in a matrix = 268,435,455. Since CORDEN and CORHOLD have
c  MAXGRD*(MAXDIM+1) entries, if MAXDIM = 20, since MAXGRD = MAX*80021
c  this --> MAX*80021*21 .LE. 268,435,455 --> MAX .LE. 159.74... But,
c  even though MAXGRD = 159*80021 will compile OK, the program is
c  killed or terminated ('segmentation fault') by the sun system when
c  execution is attempted. For now, the combination of parameter values
c  which is executable is MAXGRD = 100*80021, MAXACT = 100000 (see
c  below), MAXDIM = 10, and PYJGX dimensions set = (200,MAXGRD) in MAIN
c  and subroutine SUBRES.
 
c  This can be done by using a creating a new parameter, MAXACT = the
c  maximum no. of grid points which can be stored into PYJGX. MAXACT
c  will be set arbitrarily to 100000, so PYJGX has dimensions of
c  just (200,10000).
c  Then, in loop 800, when PYJGX is filled with values, at most 100000
c  grid points can be put into PYJGX. The rest, if there others, will
c  simply have to have their P(YJ|X)'s recalculated each cycle until
c  the no. of active grid points .LE. MAXACT, at which time all the
c  P(YJ|X)'s can be stored into PYJGX.
 
c  Note that, with the exception of PYJGXX the other matrices which had


c  MAXGRD in their dimensions (i.e., WORK, SPXGYJ, DXI, CORDEN, CORHOLD,
c  and DENSTOR) will still have dimensions based on MAXGRD. Also, a new
c  matrix, WORKK(MAXGRD) will be added.

 
c  The most significant changes in the code are in loop 800.
 


c-----------------------------------------------------------------------
 

c  m2_12cal.f						    8-27-97
 
c  m2_12cal is the same as m2_11cal, except that the no. of subjects
c  allowed is reduced from 999 to 100, the no. of dimensions allowed
c  is reduced from 20 to 8, and the no. of grid points allowed is
c  increased from 2*80021 to 16*80021.

 
c  In particular, PYJGX(999,MAXGRD) IS CHANGED TO PYJGX(100,MAXGRD) in
c  main and subroutine subres. Also, some other 999's in dimensions are
c  changed to 100. Also, MAXDIM is changed from 20 to 8 in the
c  PARAMETER statement, but no dimensions are changed from 20 to 8.
c  Finally, MAXGRD is changed from 2*80021 to 16*80021 in the
c  PARAMETER statement.

 
c-----------------------------------------------------------------------

 
c  m2_11cal.f						    8-18-97
 
C  m2_11cal.f HAS THE FOLLOWING CHANGES FROM m2_10cal.f
 
C  1. THE NO. OF GRID POINTS MAY NOW BE > 80021. IN FACT, THE USER
C  MAY SELECT UP TO 3 (FOR NOW) MULTIPLES OF 80021 POINTS. EACH MULTIPLE
C  OF 80021 GRID POINTS WILL BE PUT INTO A 'SLICE' OF THE GRID SPACE,
C  DEFINED BY THE 1ST PARAMETER'S BOUNDARIES.
 
C  A RELATED CHANGE IS THAT PREVIOUSLY INDPTS HAD TO
C  BE INSIDE [1,6], WITH NGRID DEFINED AS BEFORE, BUT NOW IT CAN ALSO
C  BE [101,...], WHERE NGRID = 80021*(INDPTS-100).
 
C  2. PYJGX, EXX, YPREDPOP,
c  AND YPREDBAY all have a their dimension of 19 changed to 999. 999
c  was the desired dimension, but space limitations previously limited
c  it to be 19. Now, the almaak machine allows more subjects. In fact,
c  the current limitation is that the no. of entries in any matrix be
c  less than or equal to 2**28 - 1 = 268,435,455. So, PYJGX can be
c  dimensioned as high as (999,268704). FOR NOW, THEREFORE, WE WILL

C  SET MAXGRD = 3*80021 = 240063 < 268704. NO. IT WAS TOO BIG (WHEN I
C  TRIED TO RUN m2_11cal.exe, almaak responded with 'killed'), BUT
C  MAXGRD = 2*80021 WAS O.K.
 
C  3. DEFAULT CONVERGENCE TOLERANCE (IF JSTOP=1) IS CHANGED FROM .00001
C  TO .000001.
 
C  4. THE MAXIMUM NO. OF PARAMETERS IS INCREASED FROM 7 TO 20. THIS
C  AFFECTS MOSTLY THE DIMENSION STATEMENTS OF THE AFFECTED ROUTINES.
C  BUT ALSO SOME FORMATS ARE CHANGED.
 
C  NOTE THAT THIS CHANGE REQUIRES CORRESPONDING DIMENSION CHANGES IN
C  idfixed.f --> idfixed2.f, idcy_5.f --> idcy_51.f, and
c  idcy_6.f --> idcy_61.f.
 
C  5. AT THE END OF THE ANALYSIS, ONE LAST CONDENSING OF POINTS IS
C  DONE. THIS IS PARTICULARLY IMPORTANT IF THE PROGRAM 'ACCELERATED'
C  MANY TIMES WITH OUT CONDENSING POINTS NEAR THE END OF THE RUN
C  (I.E., THE PROGRAM CANNOT THROW OUT POINTS IF IT IS CONSTANTLY
C  'ACCELERATING' -- SEE REASON IN CODE).
 
c-----------------------------------------------------------------------
 
c  m2_10calc.f = m2_9calc.f					6-11-97
 
c  m2_9calc.f has the following change from m2_8calc.f.
 
c  The assay noise coefficients, written to fil01.inp by M2_9.FOR,
c  have been written on two lines, instead of one. This prevents the
c  possibility that C3, if written with a "D-xxx" format at the end
c  (e.g. D-003) will be too long for the line, and therefore not
c  properly read by this program.
 
c-----------------------------------------------------------------------

 
c  m2_8calc.f						    6-5-97
 
c  m2_8calc.f has the following changes from m2_7calc.f.
 
C 1.  NAME CHANGES:
 
C   user_4.f IS CHANGED TO mod01.f (this is for info only. user_4.f
C   is never used explicitly in this code).
 
C   m2__calc.inp IS CHANGED TO fil01.inp.
 

 
C  2. NEW INFO IS INPUT BY USER (AND IS INCLUDED IN fil01.inp).
 

C   IDELTA, T_END, MIC, AND MEAN/MEDIAN/MODE SELECTION. THESE VALUES
C   WILL BE USED TO CALCULATE PREDICTED VALUES FOR EACH
C   SUBJECT AT TIMES 0, IDELTA, 2*IDELTA, ..., T-END, ALONG WITH AUC'S
C   (AREAS UNDER CURVES) AND AUC/MIC'S. NOTE THAT IDELTA = 2, 4, 6, OR
C   12 MINUTES, AND T_END IS IN HOURS.
 
C   NOTE THAT THE NSUB TABLES OF PREDICTED VALUES WILL BE PUT INTO
C   THE FILE PRTBxxxx, WHERE xxxx IS THE SAME AS xxxx FOR THE OUTxxxx
C   AND DENxxxx OUTPUT FILES. THE AUC'S AND AUC/MIC'S WILL ACCOMPANY


C   EACH SUBJECT'S BAYESIAN POSTERIOR INFO (AT THE END OF THE RUN).
 
c       PRTBxxxx will be used as input to an effects model. i.e.,
c       knowing the concentration of a drug at certain times (as
c       predicted by a previous run's analysis) will be compared to
c       corresponding info on some 'effect', whose values will be known
c       at a given set of times ... so that the relationship between
c       concentration and the 'effect' can be established.
 

 
C  Details:
 
c 1. using subject 1's bayesian posterior density, use either the means,
c    medians, or modes (as selected by user);
 
c    calculate:
 
c    time    ypred
c ----------------------

c     0       ___
c    delta    ---
c  2*delta    ___
c	.

c	.
c	.
c   t-end     ___
 
c Notes: this ypred column of values would be exactly the same as
c       YPREDBAY for the means, medians or modes (see below), except
c       that the 'observed' times are as shown (and therefore don't
c	necessarily match the observed times in the patient's data
c	file).
c
c  Calculate total AUC = area under the observed value curve (horizontal
c	axis is time) = delta * (y1/2 + sum (ypred) = ylast/2),
c       approximately, where y1 = y(0), ylast = y(t_end), and sum is
c 	the sum of the y's for indices between 1 and last.
 
c   Also, calculate AUC for each 24 hour period (up to t-end).
 
c   Also, calculate AUC/MIC, total
c         and AUC/MIC for each 24 hour period.
 
 
c  2., ..., nsub = same as 1. above, except for subjects 2, ..., nsub.
 
c  Note that comp.sh (in the working directory of the supercomputer)
c  must be changed (m2_7calc. f-->m2_8calc.f and user_4 --> mod01). And
c  new module, idcy_6.f must be included (in addition to idcy_5.f). It
c  it contains IDCALCYY/FUNC3/EVAL3, which are similar to
c  idcy_5's IDCALCY/FUNC2/EVAL2, except concentrations are calculated
c  at above specified times, rather than at observation times for each
c  subject.
c  Note that m2_7calc.sh must be changed to m2_8calc.sh.
 
c-----------------------------------------------------------------------
 
c  m2_7calc.f							2-11-97
 
c  m2_7calc.f has the following changes from m2_6calc.f.
 
c  1. The density file now contains, at the end, PYJGX(JSUB,IG),
c     IG=1,NACTVE, JSUB=1,NSUB. It also includes YPREDPOP, YPREDBAY,
c     and EXX (see no. 4 below).
 
c  2. m2__calc.inp includes extra info, which previously had been
c     obtained via COMMON/TOMAIN (note that subroutine SYMBOL has
c     changed since now it's a part of user_4.f (created by a 'BOXES'-
c     type program), instead of iduser_4.f. m2__calc.inp also includes
c     IRAN, THE vector which tells which of the parameters are random
c     and which are fixed.
 

c  3. The call to IDPC no longer includes NVAR as an argument. The no.
c     of parameter values passed is NP = NVAR+NOFIX, and NP is obtained
c     by IDPC via COMMON/CNST from SUBROUTINE SYMBOL.
 
c  4. The write statements to files 24 and 37 have been removed from
c     subroutine PRNTOP (they should have been removed before, since
c     no files 24 and 37 are needed on the mainframe).
 

c  5. Extra info will be included in the density file, which will be
c     read by the PC program, M2_7.FOR. The extra info includes
c     matrices PYJGX, YPREDPOP, YPREDBAY, AND EXX.
c     Since SUBROUTINE IDCALCY (of module IDCY_5.FOR) can no longer be
c     linked with M2_7.FOR (since it calls SUBROUTINE OUTPUT - of
c     module user_4.f, which changes analysis - to - analysis, and
c     therefore cannot be linked to the user's PC program), all the
c     code which uses IDCALCY must be included in this program (and so
c     IDCY_5.FOR = idcy_5.f will be linked with this program). Then,

c     in M2_7.FOR (SUBROUTINE PREVRUN), YPREDPOP, YPREDBAY, and EXX will
c     be read in, and options 6 and 7 will be available.
 
c     Note that YPREDPOP(JSUB,IOBS,ICEN) = the predicted value for Y for
c     subject JSUB, for observation IOBS, for ICEN = 1 (means),
c     2 (medians), AND 3 (modes), where the means, medians, and modes
c     are from the final cycle population density.
 
c     Also, YPREDBAY(JSUB,IOBS,ICEN) = the predicted value for Y for
c     subject JSUB, for observation IOBS, for ICEN = 1 (means),
c     2 (medians), AND 3 (modes), where the means, medians, and modes
c     are from subject's JSUB Bayesian posterior density (calculated by
c     SUBROUTINE SUBRES - now included in this program, in addition to
c     M2_7.FOR.

 
c     Also note that the output density file is now created only at the
c     end of the run, not after each cycle (the only reason it was
c     written at the end of each cycle previously was to provide
c     'protection' in case the program bombed before finishing -- the
c     program could then pick up where it left off with an apriori
c     density from the last completed cycle, rather than starting over;
c     but downloading this density from the mainframe, incorporating it
c     into another input file, and restarting this program is probably
c     more trouble than it's worth, given the low chance that the
c     program will bomb).

 
 
c-----------------------------------------------------------------------
 
c  m2_6calc.f							1-15-97
 
C  M2_6.FOR (PC PROGRAM) + m2_6calc.f (sun/mtha program) MAKE THE
C  SAME CHANGES TO M2_5.FOR + m2_5calc.f THAT MXEM2N60.FOR MADE TO
C  MXEM2N59.FOR. THE DETAILS ARE:
 
C  THE PROGRAM NOW ALLOWS EACH PATIENT FILE TO INCLUDE ITS OWN
C  ASSSAY NOISE COEFFICIENTS (BUT PATIENT FILES WITHOUT THEIR OWN
C  INDIVIDUAL COEFFICIENTS CAN STILL BE ANALYZED).
 
C  FOR EACH PATIENT, THE ASSAY COEFFICIENTS TO BE USED WILL BE EITHER

C  THE ONES ALREADY IN ITS FILE (IF ANY), THE DEFAULT (POPULATION)
C  VALUES, OR A SPECIFIC SET FOR THAT PATIENT.
 
C  AT THE BEGINNING OF THE RUN, THE C'S TO BE USED FOR EACH PATIENT WILL
C  BE WRITTEN AT THE END OF HIS/HER ADAPT-LIKE DATA FILE (IF THEY'RE NOT
C  ALREADY THERE).
 

C  MODULE CONVRTG.FOR IS CHANGED TO CONVRTH.FOR (THIS MODULE CONTAINS
C  SUBROUTINE CONVRT, WHICH CONVERTS USC*PACK FILES TO ADAPT-LIKE
C  FILES. CONVRT IS CHANGED TO READ THE C'S IN A USC*PACK FILE, IF
C  IF THEY'RE THERE, AND WRITE THEM INTO AN ADAPT-FILE.
 
C  NOTE THAT THE 'POPULATION' ASSAY NOISE COEFFICIENTS WILL BE CALLED
C  [C0P,C1P,C2P,C3P]. [C0,C1,C2,C3] WILL BE USED FOR THE INDIVIDUAL
C  VALUES FOR EACH PATIENT, IN TURN.
 
C  NOTE THAT SUBROUTINE SCATPLOT MUST BE CHANGED SO THAT IT CAN

C  INPUT THE ASSAY COEFFICIENTS, [C0,C1,C2,C3], FOR EACH SUBJECT
C  IF JSUB=0. NEW MATRIX COEFF STORES THESE VALUES AND IS PASSED VIA
C  COMMON/TOSCAT TO SCATPLT9.FOR (CHANGED FROM SCATPLT8.FOR).
 
C-----------------------------------------------------------------------
 
C  m2_5calc.f							11-14-96
 
C  M2_5.FOR (PC PROGRAM) + m2_5calc.f (sun/mtha program) ARE EQUIVALENT

C  TO MXEM2_5.FOR. M2_5.FOR DOES THE PREPARATION PART OF THE PROGRAM,
C  AS WELL AS THE EXAMINATION OF THE OUTPUT FILES FROM THE ANALYSIS. THE
C  ANALYSIS IS DONE ON THE SUN BY m2_5calc.f.

 
C  IN THE PREPARATION PHASE, M2_5.FOR DOES ALL THE USER I/O AND
C  CONCATENATING OF PATIENT FILES. IT OUTPUTS ONE FILE, m2__calc.inp,
C  WHICH CONTAINS THE INPUT INFO FOR THIS RUN, AS WELL AS THE
C  CONCATENATED PATIENT DATA FILES FOR THIS RUN.
 
C  m2_5calc.f CAN THEN BE RUN ON A SUPERCOMPUTER AFTER UPLOADING
C  m2__calc.inp TO IT.
 
C  THE SEPARATION OF MX3M2_5.FOR INTO THE M2_5.FOR AND m2_5calc.f IS AS
C  FOLLOWS:
 

C  M2_5.FOR <-- I/O PART OF MAIN + SUBROUTINES FILRED, STACK, VERIF1,
C		CHANGE, CALMAR, THREED1, FORMLC, CONVERGE, PLTCON,
C		MINMAX, PLOTS, SUBRES, GETOUT, PREVRUN, PRNLAST, SEEDIR,

C		CALCSER, NOTINT, STAT, DELAY, AND EXTREME, ... PLUS
C               MODULES DATABLK1 IDUSER_4 CONVRTG GHCSEL IDCY_4 SCATPLT8
C               AND VODTOT.
 
C  m2_5calc.f <-- CALCULATION PART OF MAIN + SUBROUTINES FILRED, GETCOF,
C		CALGRD, NOTINT, STAT, PREDCYC, AND PRNTOP, ALONG WITH
C		SUBROUTINE EQUIV FROM m246calc.f ... PLUS

C	        MODULES iduser_4.f, idcy_4.f, AND vodtot.f (= IDUSER.FOR
C		IDCY_4.FOR, AND VODTOT.FOR, RESPECTIVELY).
 
C  NOTE THAT SUBROUTINE DELAY IS NOT USED.
 
C  NOTE THAT SEVERAL OF THE OUTPUT FORMATS ARE CHANGED FROM
C  (25,*)' ...' TO (25,xxxx) WHERE xxxx IS A FORMAT LABEL. THIS
C  PREVENTS THE sun COMPUTER FROM INSERTING AN EXTRA SPACE IN THE
C  OUTPUT FILE, WHICH SCREWS UP SUBROUTINE PREVRUN'S READING IN OF

C  THE OUTPUT FILE.
 
C-----------------------------------------------------------------------
 
C  REFER TO THE CODE OF MXEM2_5.FOR FOR THE COMMENTS REGARDING THIS
C  SERIES OF PROGRAMS.
 
C-----------------------------------------------------------------------
 
C***********************************************************************

      SUBROUTINE NPAG(MAXSUB,MAXGRD,MAXDIM,MAXACT,
     1  NUMEQT,MAXOBS,WORK,WORKK,SPXGYJ,DXI,PYJGX,PYJGXX,
     2  DENSTOR,EXX,CORDEN,CORHOLD,YPREDPOP,YPREDPOPT,YPREDBAY,CORDLAST)
 
      IMPLICIT REAL*8(A-H,O-Z)
	REAL*8 KU
      PARAMETER(MAXNUMEQ=7)
 
        DIMENSION WORK(MAXGRD),WORKK(MAXGRD),

     1  SPXGYJ(MAXGRD),DXI(MAXGRD),PYJGX(MAXSUB,MAXACT),
     2  PYJGXX(MAXACT),DENSTOR(MAXGRD,4),EXX(MAXSUB,3,30),
     3  CORDEN(MAXGRD,MAXDIM+1),CORHOLD(MAXGRD,MAXDIM+1),
     4  YPREDPOP(MAXSUB,NUMEQT,MAXOBS,3),
     5  YPREDPOPT(MAXSUB,NUMEQT,7201,3),
     6  YPREDBAY(MAXSUB,NUMEQT,MAXOBS,3),IPATVEC(9999),AF(7),
     7  CORDLAST(MAXGRD,MAXDIM+1),XVERIFY(100),
     1  CORSUBRES(MAXGRD,MAXDIM+1)



C  NOTE THAT ALL THE DIMENSIONS = 25 BELOW 'SHOULD' BE CHANGED TO
C  MAXDIM, BUT SINCE THESE ARRAYS ARE SO SMALL, CHANGING THEM TO
C  VARIABLY DIMENSIONED ARRAYS (WHICH REQUIRE PASSING THE ARRAYS AND
C  MAXDIM THROUGH ALL RELATED CALLING STATEMENTS) IS NOT WORTH IT.
C  SIMILARLY FOR PX(32), SINCE 32 = 25 (MAXDIM) + 7 (MAX. NO. OF
C  FIXED PARAMETERS).
 
C  NOTE THAT ALL DIMENSIONS = 150 HAVE BEEN CHANGED TO 594, SINCE THIS
C  NO. REPRESENTS THE TOTAL NO. OF OBSERVATIONS (AND THE MAX. NO IS
C  6 OUTPUT EQUATIONS x 99 OBSERVATIONS/EQ). THIS COULD BE CHANGED
C  TO NUMEQT*MAXOBS, BUT IT WOULD BE MORE TROUBLE THAN IT'S WORTH TO
C  MAKE THESE DIMENSIONS VARIABLE.
C  ACTUALLY, IN THE PC PREP PROGRAM, MAXOBDIM IS SET = 150. SO THAT
C  REMAINS THE MAX. NO. OF OBSERVATION TIMES (AS OF NPAG113.FOR).



      DIMENSION YO(594,NUMEQT),SIG(594,MAXNUMEQ),AB(30,2),EX(30),
     1 COV(30,30),E(30,30),STD(30),CORR(30,30),COFVR(30),X(30),
     2 VALFIX(20),CENTER(3,30),EXXX(30),IRAN(32),PX(32),ATOL(20),
     3 TPRED(71281),YYPRED(71281,NUMEQT),YPRED(594,NUMEQT),C0P(NUMEQT),
     4 C1P(NUMEQT),C2P(NUMEQT),C3P(NUMEQT),C0(NUMEQT),C1(NUMEQT),
     5 C2(NUMEQT),C3(NUMEQT),XMED(30),TIMOB(594),DOSTIM(5000),
     5 RS(5000,34),YOO(594,MAXNUMEQ),BS(5000,7),NUMT(MAXSUB),
     6 TTPRED(MAXSUB,7200),TEND(99),NOMAXTIM(MAXSUB),TENDSUB(MAXSUB,99),
     7 TBEGG(99),TBEGGSUB(MAXSUB,99),TPREDREL(71281),
     8 TTPREDREL(MAXSUB,7200),TIMOBREL(MAXSUB,594),OPTVAR(32),EXO(30),
     9 YYYPRED(3,71281,NUMEQT),RANFIXEST(20),START(30),STEP(30)

C  NOTE THAT THE 2ND DIMENSION OF SIG AND YOO IS MAXNUMEQ, RATHER THAN
C  NUMEQT. THE REASON IS THAT THESE ARRAYS ARE PASSED IN COMMONS AND
C  THEREFORE CAN ONLY BE VARIABLY DIMENSIONED BY A VALUE SET IN
C  A PARAMETER STATEMENT.

      CHARACTER PREFIX*5,PAR(30)*11,READLINE*300,EXT*3,
     1PRIFIL2*20,DENFIL*20,PARFIX(20)*11,OUTFIL*20,NAME*4,PREDFIL*20,
     2OUTCOM*20,READLARG*1000,OUTFILER*20,ERRFIL*20,PARRANFIX(20)*11

      character*20 ITFIL
	COMMON SIG
   	COMMON/TOUSER/NDIM,MF,RTOL,ATOL
      COMMON/OBSER/TIMOB,DOSTIM,RS,YOO,BS 
	COMMON/SUPRES/ISUPRES
	COMMON/NXER/NXE
C NXE FROM ABOVE COMMON IS NO. OF TIMES XERRWD IS CALLED.

	COMMON/TOCALC/IRAN,PX,NOFIX,NSUB,gamma,flat,AB

C  COMMON/TOCALC IS PROVIDED TO SUBROUTINE CALCRF, WHICH IS CALLED
C  BY SUBROUTINE ELDERY.

      COMMON/ERR/ERRFIL 

C  THE BLANK COMMON ABOVE IS SUPPLIED TO SUBROUTINE IDPC.
C  COMMON/TOUSER IS SUPPLIED TO SUBROUTINE USERANAL IN idfixed.f.
C  COMMON/OBSER/ IS SUPPLIED FROM SUBROUTINE FILRED.
C  COMMON/SUPRES/ IS SUPPLIED TO SUBROUTINE EMINT.
C  COMMON/ERR/ IS SUPPLIED TO ALL THE ROUTINES WHICH COULD WRITE TO
C   ERRFIL.

      EXTERNAL CALCRF

C***********************************************************************
 
C-----------------------------------------------------------------------
 
    2 FORMAT(A20)
  222 FORMAT(A3)
 2222 FORMAT(A5)
 
C-----------------------------------------------------------------------
 
C  INPUT FILE npag103.inp FROM THE PREPARATION PROGRAM. npag103.inp 
C  CONTAINS THE USER DESIRED PARAMETER VALUES, ALONG WITH THE 
C  CONCATENATED PATIENT DATA FILES (IN ADAPT FORMAT).

CCCCCCCCCCCCCCCCCCCCCC  INPUT INFO  (BELOW) CCCCCCCCCCCCCCCCCCCCCCCCC
 
C  INPUT THE FOLLOWING DATA FROM FILE npag103.inp.

C  READ IN VALUES FOR MF, RTOL, AND ATOL, WHICH ARE NEEDED FOR THE

C  O.D.E. SOLVER USED BY ROUTINE USERANAL (IN MODULE IDUSER__.FOR).
 
C MF     = Method flag.  Standard values are..
C          10 for nonstiff (Adams) method, no Jacobian used.
C          21 for stiff (BDF) method, user-supplied full Jacobian.
C          22 for stiff method, internally generated full Jacobian.
C          24 for stiff method, user-supplied banded Jacobian.
C          25 for stiff method, internally generated banded Jacobian.
C RTOL   = Relative tolerance parameter (scalar).
C ATOL   = Absolute tolerance parameter.
C          The estimated local error in X(i) will be controlled so as
C          to be roughly less (in magnitude) than
C             EWT(i) = RTOL*abs(X(i)) + ATOL(i)  SINCE ITOL = 2.
C          Thus the local error test passes if, in each component,
C          either the absolute error is less than ATOL (or ATOL(i)),
C          or the relative error is less than RTOL.
C          Use RTOL = 0.0 for pure absolute error control, and
C          use ATOL = 0.0 (or ATOL(i) = 0.0) for pure relative error
C          control.  Caution.. Actual (global) errors may exceed these
C          local tolerances, so choose them conservatively.
 
C  IFORMT = 1 OR 3 IF PATIENT DATA FILES ARE IN ADAPT FORMAT. AND THEY 
C           ALWAYS ARE (ALTHOUGH THIS IS THE NEW MULTI-DRUG FORMAT).
C           NOTE THAT IFORMT IS STILL READ IN, BUT CALLED JUNK.
 
C       PREFIX = 5-CHARACTER PREFIX FOR ALL SUBJECT FILENAMES. THEN
C           001, 002,... UP TO 999  WILL COMPLETE THE 1ST NAMES OF THE
C           INDIVIDUAL FILENAMES WHICH ARE READ IN.
 
C       EXT = AN OPTIONAL 3-CHARACTER EXTENSION (AFTER DECIMAL POINT)
C             FOR THE INPUT FILENAMES.
 
C  	NVAR = NO. OF RANDOM VARIABLES FOR THE RUN.
C  	PAR(I) = NAME OF R.V. I; I=1,NVAR.
C 	NOFIX = NO. OF FIXED PARAMTER VALUES FOR THE RUN.
C 	PARFIX(I) = NAME OF FIXED PARAMETER I; I=1,NOFIX.
C     NRANFIX = NO. OF UNKNOWN PARAMETERS WHICH ARE THE SAME FOR 
C               ALL SUBJECTS FOR THE RUN.
C     PARRANFIX(I) = NAME OF UNKNOWN PARAMETER I; I=1,NRANFIX.

C  	IRAN(I) = 1 IF PARAMATER I IS RANDOM;
C	          0 IF PARAMETER I IS FIXED; 
C               2 IF PARAMETER I IS UNKNOWN BUT THE SAME FOR ALL
C                 SUBJECTS; I = 1,NVAR+NOFIX+NRANFIX.


C  NSUBTOT = TOTAL NO. OF SUBJECTS IN THE PATIENT POPULATION. 
C  NSUB = NO. OF SUBJECTS WHOSE DATA ARE TO USED FOR THE ANALYSIS (MAX
C         NO. = 999).
C  IPATVEC(I),I=1,NSUB = INDICES OF THE SUBJECTS WHICH ARE TO BE USED

C                        IN THIS ANALYSIS.
 
C  IF NOFIX > 0, VALFIX(I) = VALUE OF FIXED PARAMETER I, I=1,NOFIX.

C  IF NRANFIX > 0, RANFIXEST(I) = INITIAL ESTIMATE FOR RANFIX PARAMETER
C   I, I = 1,NRANFIX.

C   	AB(I,1) = LOWEST VALUE FOR VARIABLE I ON ITS GRID, I=1,NVAR.
C     AB(I,2) = HIGHEST VALUE FOR VARIABLE I ON ITS GRID,I=1,NVAR.

 
C	NUMEQT = NO. OF OUTPUT EQUATIONS.
C	C0P(I),C1P(I),C2P(I),C3P(I) = COEFFICIENTS FOR THE ASSAY STD.
C		DEV. (OF THE OBSERVED VALUES) FOR OUTPUT EQ. I;
C		I=1,NUMEQT. THEY'RE INCLUDED ONLY SO THEY CAN BE PUT
C		INTO THE OUTPUT FILE.

C  AS OF m2_6calc.f, EACH SUBJECT'S INDIVIDUAL C'S ARE INCLUDED IN THE
c  CONCATENATED PATIENT DATA FILES PORTION OF npag102.inp.
 
C  IERRMOD, GAMLAM0 = INFO ON THE ERROR PATTERN (SEE CODE).


C  NDRUG = NO. OF DRUGS IN THE PATIENT DATA FILES.
C  AF(I),I=1,NDRUG = ACTIVE (SALT) FRACTION FOR DRUG I.

C  INDPTS = THE INDEX OF THE NO. OF GRID POINTS TO BE USED.
C	    INDPTS = 1,2,3,4,5,6 FOR,
C           RESPECTIVELY, 2129, 5003, 10007, 20011, 40009, OR 80021 PTS.
C           IF INDPTS > 6, THE NO. OF GRID PTS = 80021*(INDPTS-100).
 
C    AS OF npbig1.f, THE GRID POINTS ARE FOUND DIRECTLY FROM

C    SUBROUTINE CALGRD (I.E., SUBROUTINE GETCOF IS NO LONGER USED).
 
 
C  MAXCYC = MAXIMUM NO. OF CYCLES; THE PROGRAM WILL STOP BEFORE THIS 
C           NO. OF CYCLES IF IT CONVERGES--SEE FORMATS 5197 AND 5198
C           IN THE CODE.


C  NOTE THAT JSTOP AND TOL ARE STILL READ IN, BUT ARE NOT USED. INSTEAD,
C  TOL IS HARDCODED TO BE 1.D-4 IN THIS PROGRAM.

C  IDELTA, T_END, XMIC, ICENT, AUCINT: THESE VALUES WILL BE USED TO 
C   CALCULATE PREDICTED VALUES FOR EACH SUBJECT AT TIMES 0, IDELTA,


C   2*IDELTA, ..., T-END, ALONG WITH AUC'S (AREAS UNDER CURVES) AND 
C   AUC/MIC'S. NOTE THAT IDELTA = 2, 4, 6, OR 12 MINUTES, AND T_END IS 
C   IN HOURS.

C   NO. AS OF bigmlt6.f, T_END WILL STILL BE READ, BUT NO LONGER USED,
C    SINCE SUBJECTS CAN HAVE TIME RESETS --> EACH SUBJECT WILL HAVE TO
C    HAVE ITS MAXIMUM TIMES (ONE FOR EACH SET OF TIMES BEFORE A TIME
C    RESET OR THE ENDING TIME) CALCULATED BY NEW SUBROUTINE CALCTPRED.
 
C  ICYCLE = NO. OF CYCLES RUN BY A PREVIOUS RUNNING OF THIS PROGRAM.
 

C  IF ICYCLE .GT. 1 --> THIS RUN IS PICKING UP WHERE A PREVIOUS RUN
C			LEFT OFF. IN THIS CASE, READ IN ALSO:
C	DORIG = THE UPPER BOUND FOR THE DIFFERENCE BETWEEN THE DENSITY
C		OF CYCLE 1 AND THE MAXIMUM LIKELIHOOD ESTIMATE OF THE
C		DENSITY.
 
C	NACTVE = THE NO. OF ACTIVE GRID POINTS IN THE PRIOR DENSITY.
C	CORDEN(I,.) = ITH ACTIVE GRID COORDINATES (1ST NVAR ENTRIES) +
C		      THE ASSOCIATED DENSITY (NVAR+1 ST ENTRY),
C		      I=1,NACTVE.

C	PRIFIL2 = NAME OF FILE GIVING THE PRIOR INFO (DORIG, CORDEN,
C		  ETC). NOTE THAT THIS PRIOR INFO HAS BEEN STORED
C		  INTO npembig3.inp. PRIFIL2 ITSELF IS NOT USED BY THE
C		  PROGRAM, BUT THE NAME IS INCLUDED SO THE USER WILL
C		  KNOW WHERE THE PRIOR DATA ORIGINATED.
 
CCCCCCCCCCCCCCCCCCCCCCCC  INPUT INFO (ABOVE) CCCCCCCCCCCCCCCCCCCC
 

2227        FORMAT(A11)

c  Read 'extnum' to get the 4 digit job number which will be used for
c  each of the files produced by this program. Read this integer now,
c  and replace the value by 1 greater (unless it is 9999, in which case
c  replace it by 1) and then close extnum.
 
C  OPEN FILE extnum AND READ THE NO. THERE.
 
	OPEN(25,FILE='extnum',STATUS='OLD')
	READ(25,*) INUM
 
C  OBTAIN THE CHARACTER*4 EQUIVALENT TO INUM.
 
	CALL EQUIV(INUM,NAME)
 

C  REPLACE THE NO. IN 'extnum' BY INUM+1 (EXCEPT INUM=9999 IS
C  TO BE REPLACED BY 1).
 
	JNUM=INUM+1
	IF(JNUM .EQ. 10000) JNUM = 1
	BACKSPACE(25)
	WRITE(25,*) JNUM
	CLOSE(25)

 
C  CREATE OUTPUT FILE WHICH HAS 'OUT' AS ITS 1ST 3 CHARACTERS AND

C  NAME AS ITS LAST 4. SIMILARLY, CREATE DENFIL, PREDFIL, ITFIL, AND
C  ERRFIL.

C  AS OF bignpaglap1.f, THE NAME FOR THE OUTPUT FILE IS CHANGED TO
C  'OUTT'//NAME SINCE 'OUT//NAME WILL BE RESERVED FOR THE COMBINED
C  OUTPUT FILE FORMED AT THE END OF THE RUN.
 
      OUTFIL = 'OUTT'//NAME
      DENFIL = 'DEN'//NAME
      PREDFIL = 'PRTB'//NAME
      ITFIL = 'ILOG'//NAME
      ERRFIL = 'ERROR'//NAME


      OPEN(23,FILE='npag103.inp',ERR=4705,STATUS='OLD')
      GO TO 4710
 4705	WRITE(*,4706)
 4706 FORMAT(/' INPUT FILE npag103.inp IS NOT AVAILABLE. THE'/
     1' PROGRAM STOPS. TRY AGAIN AFTER RUNNING THE PREPARATION PROGRAM'/
     2' TO CREATE npag103.inp, AND THEN PUTTING THAT FILE IN THE '/
     3' WORKING DIRECTORY.'/)

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,4706) 
        CLOSE(42)

		CALL PAUSE
		STOP

 4710		READ(23,*) NDIM
		READ(23,*) MF
		READ(23,*) RTOL
		READ(23,*) (ATOL(I),I=1,NDIM)
		READ(23,*) JUNK
		READ(23,2222) PREFIX
		READ(23,222) EXT
		READ(23,*) NVAR
		READ(23,2227) (PAR(I),I=1,NVAR)
		READ(23,*) NOFIX
		READ(23,2227) (PARFIX(I),I=1,NOFIX)
            READ(23,*) NRANFIX
            READ(23,2227) (PARRANFIX(I),I=1,NRANFIX)
		READ(23,*) (IRAN(I),I=1,NVAR+NOFIX+NRANFIX)


C  READ IN BOTH NSUBTOT AND NSUB AND THEN CALL ROUTINE GETIPATF WHICH 
C  READS THIS PORTION OF FILE 23 TO OBTAIN IPATVEC. NOTE THE 1ST 
C  ARGUMENT TELLS GETIPATF TO READ FILE 23.

C  NOTE THAT IF IERRR RETURNS AS -1, THERE IS A PROBLEM WITH THE
C  PATIENT NO. INFO ON THE FILE. IN THIS CASE, THE PROBLEM HAS ALREADY
C  BEEN WRITTEN TO THE SCREEN. SO STOP.

       READ(23,*) NSUBTOT
       READ(23,*) NSUB
       CALL GETIPATF(23,NSUBTOT,NSUB,IPATVEC,IERRR,ERRFIL)

       IF(IERRR .EQ. -1) THEN
        CALL PAUSE
        STOP
       ENDIF

       IF(NOFIX .GT. 0) READ(23,*) (VALFIX(I),I=1,NOFIX)
       IF(NRANFIX .GT. 0) READ(23,*) (RANFIXEST(I),I=1,NRANFIX)
 
       DO I=1,NVAR
        READ(23,*) (AB(I,J),J=1,2)
       END DO

 
C  NOTE THAT NUMEQT WAS PASSED IN ARGUMENT LIST FROM npagdriv.f
C  TO THIS MODULE, SUBROUTINE BIGNPAG, SO JUST READ(23,*) ON NEXT LINE.
 
		READ(23,*)
 
		DO IEQ=1,NUMEQT
		 READ(23,*) C0P(IEQ),C1P(IEQ),C2P(IEQ),C3P(IEQ)
		END DO
 
		READ(23,*) ierrmod,gamlam0		

C  NOTE THAT IN npag102.inp FROM NPBIG15.FOR, ierrmod AND gamlam0
C  (INITIAL EST. FOR gamma or lambda) WILL BE READ IN. AND NOTE THAT FOR
C  ierrmod = 4, THIS VALUE SHOULD BE READ IN AS flat, RATHER THAN AS


C  gamma, TO BE COMPATIBLE WITH THE CODE BELOW.


	gamma = 1.d0
	flat = 1.d0
	if(ierrmod .eq. 2) gamma = gamlam0
        if(ierrmod .eq. 3) gamma = gamlam0
        if(ierrmod .eq. 4) flat = gamlam0


	igamma = 0
        gamdel=0.1
        if(ierrmod.eq.1) gamdel=0.d0

        READ(23,*) NDRUG

        READ(23,*) (AF(I),I=1,NDRUG)

		READ(23,*) INDPTS
 
C  ESTABLISH THE NO. OF GRID POINTS TO BE USED.
 
	IF(INDPTS .EQ. 1) NGRID=2129
	IF(INDPTS .EQ. 2) NGRID=5003

	IF(INDPTS .EQ. 3) NGRID=10007
	IF(INDPTS .EQ. 4) NGRID=20011
	IF(INDPTS .EQ. 5) NGRID=40009
	IF(INDPTS .EQ. 6) NGRID=80021
	IF(INDPTS .GT. 6) NGRID = (INDPTS - 100)*80021
cadapt change 1 - reset ngrid to MAXACT if NGRID>MAXACT
 
        if(ngrid.gt.maxact) then
 
          write(6,*)
 
          write(6,*) 'requested NGRD = ',NGRID, ' gridpoints'
          write(6,*) 'maximum allowable is MAXACT=',MAXACT
          write(6,*) 'resetting NGRID = ',MAXACT
 

          write(6,*) 'to fit in available storage'
 
          write(6,*)
 
          ngrid = maxact
 
         endif
      ngridn=ngrid
 
 
      READ(23,*) MAXCYC
      READ(23,*) JSTOP
      IF(JSTOP .NE. 1) READ(23,*) TOLC

c  As of npageng23.f, TOL is no longer read in, as it is going to be

c  reset = 1.D-4 below anyway. Instead, TOLC (the value against which
c  checkbig is compared) will now be read in.

      TOL = 1.D-4

		NINT=100
 
		READ(23,*) IDELTA
		READ(23,*) T_END
		READ(23,*) XMIC
		READ(23,*) ICENT
		READ(23,*) AUCINT
		READ(23,*) ICYCLE
 
		IF(ICYCLE .GE. 1) THEN
		  READ(23,*) DORIG
 

		  READ(23,*) NACTVE

		  DO I=1,NACTVE
		   READ(23,*) (CORDEN(I,J),J=1,NVAR+1)
		  END DO
 
		  READ(23,2) PRIFIL2
		ENDIF
 
 
c  The patient data info is read in from npag103.inp, and is put onto 
c  scratch file 27 (because it will need to be reread each cycle --> 
c  file 27 will be rewound each cycle).

c  Note that there are NSUBTOT subjects, but only NSUB of them,
c  with indices IPATVEC(I),I=1,NSUB, will be put onto file 27.
 
        OPEN(27)

 1717  FORMAT(A300)
       NLAFIR = 0

       DO JSUB = 1,NSUB


C  THE NEXT SUBJECT WHOSE DATA SET IS TO BE PUT TO FILE 27 IS SUBJECT 
C  IPATVEC(JSUB). SO FAR, NLAFIR IS THE NO. OF LINES WHICH HAVE BEEN
C  READ WHICH HAVE 'LAST AND FIRST' AS CHARACTERS 3:16 (THIS LINE IS
C  THE FIRST LINE OF EACH SUBJECT'S DATA SET). READ UNTIL THE NEXT
C  SUCH LINE.

 1720    READ(23,1717,IOSTAT=IEND) READLINE

	 IF(IEND .LT. 0) THEN

C  NOTE THAT IEND .LT. 0 --> END OF FILE REACHED, BUT IF IT'S REACHED
C  AT THIS POINT, NOT ALL "ACTIVE" NSUB SUBJECT DATA SETS WERE READ

C  AND WRITTEN CORRECTLY TO FILE 27. IN THIS CASE, WRITE A MESSAGE TO
C  THE USER AND STOP.

        WRITE(*,1721)
 1721   FORMAT(/' PATIENT DATA INFORMATION WAS NOT READ CORRECTLY'/
     1' FROM THE INSTRUCTION FILE, npag103.inp. IF YOU EDITED THIS'/
     2' FILE MANUALLY, PLEASE RERUN THE PC PREP PROGRAM TO HAVE IT'/
     3' PREPARE npag103.inp AGAIN AND THEN RERUN THIS PROGRAM.'//


     4' IF YOU DID NOT MANUALLY EDIT npag103.inp, PLEASE SEND THE'/
     5' DETAILS OF THIS RUN (STARTING WITH THE PC PREP EXECUTION) TO'/
     5' THE LAPK. '//
     6' THANK YOU.'/)
  
C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,1721) 
        CLOSE(42)

	  CALL PAUSE

	  STOP

	 ENDIF


	 IF(READLINE(3:16) .NE. 'LAST AND FIRST') GO TO 1720

	  NLAFIR = NLAFIR+1

C  THIS READLINE IS THE BEGINNING OF A SUBJECT'S DATA. IF NLAFIR
C  = IPATVEC(JSUB), THIS SUBJECT'S DATA IS TO BE USED, SO PUT IT ON
C  FILE 27. IF NLAFIR .LT. IPATVEC(JSUB), KEEP READING UNTIL 
C  NLAFIR = IPATVEC(JSUB).

	   IF(IPATVEC(JSUB) .GT. NLAFIR) GO TO 1720

C  TO GET TO THIS POINT, IPATVEC(JSUB) = NLAFIR, SO PUT THIS SUBJECT'S
C  DATA ONTO FILE 27 BY CALLING SUBROUTINE NEWWORK1 (BASED ON THE 
C  STAND-A-LONE PROGRAM OF THE SAME NAME). NOTE THAT IF THE FILE HAS
C  NO STEADY STATE DOSE INDICATORS, IT WILL NOT BE CHANGED; IF IT DOES,
C  IT WILL BE ALTERED TO INCLUDE AN EXTRA 101 DOSES SETS FOR EACH STEADY
C  STATE DOSE INDICATOR. NOTE THAT, UNLIKE IN THE STAND-A-LONE PROGRAM,
C  SUBROUTINE NEWWORK1 WILL LEAVE IN THE NEGATIVE DOSE TIME (WHICH IS
C  THE STEADY STATE DOSE INDICATOR) BECAUSE THE ID ROUTINES NEED TO SEE
C  THIS INDICATOR TO KNOW THAT A STEADY STATE DOSE SET IS COMING.

       CALL NEWWORK1(MAXSUB,JSUB,TIMOBREL)

C  AS OF npageng18.f, NEWWORK1 ALSO ESTABLISHES TIMOBREL(JSUB,J).
C  THESE ARE THE "RELATIVE" OBSERVATION TIMES FOR THIS SUBJECT. 
C  IF THE SUBJECT CONTAINS STEADY STATE DOSE SETS, THESE TIMES WILL
C  DIFFER FROM THE TIMES WRITTEN TO FILE 27 SINCE THOSE TIMES WILL BE 
C  THE "REAL" TIMES STARTING FROM THE BEGINNING OF EACH STEADY STATE
C  DOSE SET, AND NEEDED BY THE ID MODULES, RATHER THAN THE "RELATIVE"
C  TIMES STARTING AT THE END OF EACH STEADY STATE DOSE SET).

  
	END DO

C  THE ABOVE END DO CLOSES THE  DO JSUB = 1,NSUB  LOOP.

 
 1730 REWIND(27)
	CLOSE(23)

C  NOTE THAT IF LABEL 1730 WAS REACHED VIA THE
C  IF(IEND .LT. 0) GO TO 1730    STATEMENT ABOVE, IT MUST BE BECAUSE
C  THE END OF THE FILE WAS REACHED AND THE LAST SUBJECT ON THE FILE
C  23 WAS ALSO THE LAST ONE (NO. IPATVEC(NSUB)) TO BE ANALYZED. THIS
C  MEANS JSUB SHOULD BE NSUB. IF, HOWEVER, JSUB .LT. NSUB, IT MEANS
C  THAT, SOMEHOW, NOT ALL NSUB SUBJECTS TO BE ANALYZED WERE ON THE
C  npag103.inp FILE. IN THIS CASE, WRITE A MESSAGE TO THE USER AND
C  STOP.

	 IF(JSUB .LT. NSUB) THEN
	  WRITE(*,1721)

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,1721)
        CLOSE(42)

	  CALL PAUSE
	  STOP
	 ENDIF


 
C  IF ISUPRES = 1 --> the output to the screen will be minimal ...
c  one line having just the cycle no., convergence criterion, and the 
c  medians. The exception is that until NACTVE .LE. NSTORE, the
c  program will print to the screen the update on what % of grid
c  points have been calculated since otherwise the user might think

c  his computer has locked up (once NACTVE .LE. NSTORE, all the
c  P(YJ|X)'s will already be stored into PYJGX --> the DO 800 loop
c  will go very fast.

c  IF ISUPRES = 0 --> the output to the screen will be the full set
c  of information that has been historically printed.

	ISUPRES = 1



C  OPEN THE OUTPUT FILE -- ALL OUTPUT FROM THE PROGRAM WILL BE PUT
C			   INTO THIS FILE.
 
	OPEN(25,FILE=OUTFIL)
 
C  SET IFIRST = THE 1ST CYCLE FOR THIS RUN. IFIRST MUST BE SAVED SO
C  LOOP 800 WILL ONLY NEED TO CALL IDPC IF ICYCLE=IFIRST.
 
	IFIRST=ICYCLE+1
 
c open the iteration log file
      open(91,file=ITFIL)
      if(ierrmod.eq.1.or.ierrmod.eq.2) write(91,9190)
      if(ierrmod.eq.4) write(91,9290)
      if(ierrmod.eq.3) write(91,9390)
cgam2_9190 format('  icycle',5x,'fobj1',10x,'fobj0',10x,'res',5x,
 9290 format('  icycle',5x,'fobj1',10x,'flat wt',8x,'res',5x,
     &      'grid points (start and end)')
 9190 format('  icycle',5x,'fobj1',10x,'gamma',10x,'res',5x,
     &      'grid points (start and end)')

 9390 format('  icycle',5x,'fobj1',10x,'lambda',9x,'res',5x,
     &      'grid points (start and end)')

c  Create the files CHMAXCYC.BAT, CHMAXCYC.OLD, and CHMAXCYC.NEW:
C  CHMAXCYC.OLD has one line with a 1 in it. CHMAXCYC.NEW has one
c  line with a 0 in it. CHMAXCYC.BAT is a DOS batch file which has
c  the system command to copy CHMAXCYC.NEW to CHMAXCYC.OLD.

C  Note that the program will open and read CHMAXCYC.OLD at the 
c  beginning of each new cycle. If it reads a 1, it will continue the 

c  calculations as before. If it reads a 0, it will change the value of 
c  MAXCYC to whatever ICYCLE is currently, which will cause the program 
c  to halt at the end of that cycle just as if MAXCYC had been set
c  to the changed value originally. If this happens, the program will
c  write a comment to the console and file 25 of why the program
c  has stopped prematurely.

c  Note that the user may want to exercise this option if he wants to
c  see the results from a slowly converging run, and then, because
c  the density file from the last cycle will have been correctly 
c  created, still be able to start another run using the final cycle 
c  joint density from the halted run (with different parameters if 
c  desired).

	OPEN(37,FILE='CHMAXCYC.OLD')
	 WRITE(37,*)'   1'
	CLOSE(37)

	OPEN(37,FILE='CHMAXCYC.NEW')
	 WRITE(37,*)'   0'
	CLOSE(37)

	OPEN(37,FILE='CHMAXCYC.BAT')
	 WRITE(37,*)'  COPY CHMAXCYC.NEW CHMAXCYC.OLD'
	CLOSE(37)

c  Tell the user that he can execute the batch file, CHMAXCYC.BAT 
c  (by typing CHMAXCYC at a DOS prompt), in the working directory of 
c  his PC and that will cause the program to stop safely at the end of 
c  whatever cycle it is on, as if the maximum no. of cycles has been 
c  reached.



	WRITE(*,1231)
 1231   FORMAT(/' IF YOU WOULD LIKE TO STOP THE PROGRAM BEFORE THE'/
     1' MAXIMUM NO. OF CYCLES HAVE BEEN RUN, ALT-TAB TO A DOS'/
     2' WINDOW IN THE WORKING DIRECTORY OF THE RUN AND TYPE: '//
     3' >CHMAXCYC   '//
     4' THIS WILL CAUSE THE PROGRAM TO STOP SAFELY AT THE END OF THE '/
     5' NEXT CYCLE, AFTER CREATING THE OUTPUT FILES.')
!	CALL PAUSE
C  COMMENTED OUT THE ABOVE ALL PAUSE AS OF npageng28.f

C  CALCULATE VOLSPA, THE 'VOLUME' OF THE INTEGRATION SPACE (NEEDED IN
C  CALLS TO NOTINT).
 
      VOLSPA=1.D0
      DO 170 I=1,NVAR
  170 VOLSPA = VOLSPA*(AB(I,2)-AB(I,1))
 
 
C  IF THE NO. OF PREVIOUS CYCLES, ICYCLE = 0, IT MEANS THAT THIS IS
C  A NEW RUN, USING A UNIFORM PRIOR JOINT DENSITY. IF ICYCLE .GE. 1,
C  THIS IS A CONTINUATION RUN, AND THE PRIOR JOINT DENSITY HAS BEEN
C  READ IN ABOVE.
 
	IF(ICYCLE .EQ. 0) THEN
 
C  FIND THE VALUE OF THE UNIFORM DENSITY OVER THE 'RECTANGULAR' NVAR-
C  DIM VECTOR SPACE [AB(1,1),AB(1,2)] x ... x [AB(NVAR,1),AB(NVAR,2)].
 
      CONST=1.D0/VOLSPA
 
C  CONST IS THE INITIAL VALUE OF THE JOINT DENSITY AT ALL THE GRID
C  POINTS TO BE DETERMINED BELOW. PUT IT INTO ALL ENTRIES OF COLUMN
C  NVAR+1 OF CORDEN.
 
C  NOTE: SINCE THE APRIORI DENSITY IS UNIFORM, ITS VALUES ARE
C        THE SAME REGARDLESS OF THE ACTUAL GRID POINTS USED (I.E., ONLY
C        THE BOUNDARIES OF THE RECTANGULAR GRID SPACE, [AB(I,1),AB(I,2)]
C        FOR I=1,NVAR ARE IMPORTANT).
 
C  ESTABLISH MATRIX CORDEN TO HAVE ALL THE GRID POINTS AND ASSOCIATED
C  DENSITY VALUES (FOR ROW K, THE 1ST NVAR VALUES = COORDINATES OF GRID
C  POINT K; LAST VALUE = ASSOCIATED DENSITY OF GRID POINT K).

C  AFTER THE DO 30 LOOP, SUBROUTINE CALGRD (WHICH GIVES THE COORDINATES
C  OF A DESIRED POINT) WILL NOT HAVE TO BE CALLED AGAIN, SINCE ALL THE
C  INFORMATION WILL BE STORED INTO CORDEN, WHICH WILL BE CONDENSED
C  AFTER EACH CYCLE TO INCLUDE ONLY THE 'HIGH PROBABILITY' POINTS.
 
	DO 30 IG = 1,NGRID
 


	  CORDEN(IG,NVAR+1)=CONST
 
C  GET THE COORDINATES OF THE IGTH GRID POINT.
 

C  AS OF npbig1.f, THE GRID POINTS ARE FOUND DIRECTLY FROM
C  SUBROUTINE CALGRD (I.E., ROUTINE GETCOF IS NO LONGER USED).
 
C  CALL CALGRD AND GET THE IGTH COORDINATES; THEN PUT THEM INTO THE
C  1ST NVAR ENTRIES OF ROW IG OF CORDEN. NOTE THAT THE 1ST TIME CALGRD
C  IS CALLED, A VARIABLE (FIRST) IS INITIALIZED, AND THEN EACH
C  SUCCEEDING TIME IT IS CALLED, CALGRD 'KNOWS' TO CONTINUE FINDING
C  THE SEQUENCE OF GRID POINTS.
 
	CALL CALGRD(NVAR,NGRID,AB,X)
	DO J=1,NVAR
	  CORDEN(IG,J) = X(J)
	END DO
	
   30   CONTINUE
 
 
C  INITIALIZE NACTVE (THE NO. OF ACTIVE GRID POINTS) TO = NGRID (WHEN

C  A PRIOR DENSITY IS USED, NACTVE IS READ IN).
 
	NACTVE=NGRID
 
 
	ENDIF
 
C  THE ABOVE ENDIF IS FOR THE  IF(ICYCLE .EQ. 0)  CONDITION.
 

C  AS OF npageng19.f, PRESET NACTLAST TO BE NACTVE. THIS WAY, IN THE
C  UNLIKELY EVENT THAT THE FIRST CYCLE OF A RUN HAS A HESSIAN ERROR
C  (WHICH MEANS THAT WHEN CONTROL COMES BACK TO MAIN FROM SUBROUTINE
C  emint, IT IS TRANSFERRED TO LABEL 900 AND THEREFORE SKIPS THE
C  cbegin statistics  SECTION WHERE NACTLAST = NACTVE IS SET), THERE
C  WON'T BE A PROBLEM WHEN NACTVE IS SET = NACTLAST JUST BELOW LABEL 
C  900. IN PREVIOUS PROGRAMS, IN THE ABOVE SITUATION, BELOW LABEL 900,
C  NACTVE = NACTLAST WOULD RESULT IN NACTVE BEING SET = 0 SINCE 
C  NACTLAST WAS UNITIALIZED.

      NACTLAST = NACTVE 


        prefobj=-1.d30
        prebig=-1.d30

 
C  THE 2ND LINE GIVES THE VERSION NO. OF THE PROGRAM ITSELF.

        WRITE(25,1657)
 1657   FORMAT(1X,'VERSION 43  ... Made by npagranfix6')

        WRITE(25,7123) 'VER_BAK OCT_15'
 7123   FORMAT(A14)


        WRITE(25,1212)
 1212   FORMAT(//' THE NEXT FEW LINES GIVE INPUT INFO FOR THIS RUN: '/)

	WRITE(25,9761) PREFIX,EXT
 9761   FORMAT(/' THE SUBJ. FILENAMES (IN "Adapt-Like" FORMAT) HAVE'/
     1' PREFIX ',A5,' AND EXT. ',A3)


	WRITE(25,9767) NSUBTOT
 9767   FORMAT(/' THE TOTAL NO. OF SUBJECTS IN THE DATA SET IS ',I4)
	WRITE(25,9762) NSUB
 9762   FORMAT(/' THE NO. OF SUBJECTS IS          ',I3)

C  CALL SUBROUTINE WRITEPT2 TO WRITE THE PATIENT NOS. TO BE USED IN 
C  THE ANALYSIS TO FILE 25 ... IN AN "EFFICIENT" WAY, AS OPPOSED TO
C  ONE INDEX PER LINE. NOTE THAT THE FIRST ARGUMENT TELLS WRITEPT2
C  TO WRITE TO FILE 25. NOTE THAT THE '    0' AFTER THE CALL TO
C  WRITEPT2 TELLS THE PROGRAM READING THIS FILE THAT THE PATIENT
C  NOS. HAVE ENDED.

	CALL WRITEPT2(25,NSUB,IPATVEC)
	WRITE(25,*) '    0'
 
	WRITE(25,9763)

 9763   FORMAT(/' THE RANDOM VARIABLES AND THEIR RANGES ARE: ')
	
C  REPLACE WRITING OF AB() WITH XVERIFY (SEE LOGIC IN SUBROUTINE
C  VERIFYVAL. SIMIARLY FOR ALL CALLS TO VERIFYVAL.

      DO I=1,NVAR
       XVERIFY(1) = AB(I,1)
       XVERIFY(2) = AB(I,2)
       CALL VERIFYVAL(2,XVERIFY)

C      WRITE(25,1217) PAR(I),AB(I,1),AB(I,2)
       WRITE(25,1217) PAR(I),XVERIFY(1),XVERIFY(2)
	END DO
 1217   FORMAT(/' ',A11,': ',G17.10,'   TO   ',G17.10)
 
  	IF(NOFIX .EQ. 0) WRITE(25,9764)
 9764   FORMAT(/' NO FIXED PARAMETER VALUES.')

 
  	IF(NOFIX .GT. 0) THEN
 
       WRITE(25,9766)
 9766  FORMAT(/' THE USER-ENTERED FIXED PARAMETER VALUE(S) IS (ARE):')
 
C  REPLACE WRITING OF VALFIX() WITH XVERIFY (SEE LOGIC IN SUBROUTINE
C  VERIFYVAL.

      DO I=1,NOFIX
       XVERIFY(1) = VALFIX(I)
       CALL VERIFYVAL(1,XVERIFY)
C      WRITE(25,1219) PARFIX(I),VALFIX(I)
       WRITE(25,1219) PARFIX(I),XVERIFY(1)
	END DO

 1219   FORMAT(/' ',A11,' =  ',G17.10)
	WRITE(25,*)
 
  	ENDIF

      IF(NRANFIX .EQ. 0) WRITE(25,9789)
 9789 FORMAT(/' NO "RANFIX" PARAMETER ESTIMATES.')


  	IF(NRANFIX.GT. 0) THEN
 
       WRITE(25,9768)
 9768  FORMAT(/' THE USER-ENTERED INITIAL ESTIMATES FOR THE PARAMETERS'/
     1' WHICH ARE UNKNOWN, BUT THE SAME FOR ALL SUBJECTS, IS (ARE):')

C  REPLACE WRITING OF RANFIXEST() WITH XVERIFY (SEE LOGIC IN SUBROUTINE
C  VERIFYVAL.
 
      DO I=1,NRANFIX
       XVERIFY(1) = RANFIXEST(I)
       CALL VERIFYVAL(1,XVERIFY)
C      WRITE(25,1219) PARRANFIX(I),RANFIXEST(I)
       WRITE(25,1219) PARRANFIX(I),XVERIFY(1)
	END DO
	WRITE(25,*)
 
  	ENDIF


C  AS OF bignpaglap4.f, NGRID is written on the line following the
c  text.

	WRITE(25,9869) NGRID
 9869   FORMAT(/' THE NO. OF GRID POINTS IS '/,I10)

	WRITE(25,*)' THE NO. OF CURRENTLY ACTIVE GRID POINTS IS ',NACTVE
 


C  REPLACE WRITING OF C0P(),...,C3P() WITH XVERIFY (SEE LOGIC IN 
C  SUBROUTINE VERIFYVAL.

	WRITE(25,2217) NUMEQT
 2217   FORMAT(/' THE POPULATION VALUES FOR [C0,C1,C2,C3] FOR EACH OF '/
     1' THE ',I2,' OUTPUT EQUATION(S), ARE SHOWN BELOW: '/)
      DO IEQ = 1,NUMEQT
       XVERIFY(1) = C0P(IEQ)
       XVERIFY(2) = C1P(IEQ)
       XVERIFY(3) = C2P(IEQ)
       XVERIFY(4) = C3P(IEQ)
       CALL VERIFYVAL(4,XVERIFY)
C	 WRITE(25,162) IEQ,C0P(IEQ),C1P(IEQ),C2P(IEQ),C3P(IEQ)
	 WRITE(25,162) IEQ,(XVERIFY(IXV),IXV=1,4)
	END DO

  162   FORMAT(' EQ. ',I2,': ',4(G16.10,1X))

	WRITE(25,2112)
 2112   FORMAT(/' YOU HAVE CHOSEN TO MODEL THE ASSAY ERROR FUNCTION,'/
     1' S.D. AS FOLLOWS (ASSUMING SD1 = C0+C1*Y+C2*Y**2+C3*Y**3):')

C  REPLACE WRITING OF GAMLAM0 WITH XVERIFY (SEE LOGIC IN 
C  SUBROUTINE VERIFYVAL.



     	 IF(IERRMOD .EQ. 1) WRITE(25,2113)
       XVERIFY(1) = GAMLAM0
       CALL VERIFYVAL(1,XVERIFY)


C      IF(IERRMOD .EQ. 2) WRITE(25,2114) GAMLAM0
C      IF(IERRMOD .EQ. 3) WRITE(25,2116) GAMLAM0
C      IF(IERRMOD .EQ. 4) WRITE(25,2117) GAMLAM0
       IF(IERRMOD .EQ. 2) WRITE(25,2114) XVERIFY(1)
       IF(IERRMOD .EQ. 3) WRITE(25,2116) XVERIFY(1)
       IF(IERRMOD .EQ. 4) WRITE(25,2117) XVERIFY(1)


 2113   FORMAT(/' S.D. = SD1')
 2114   FORMAT(/' S.D. = GAMMA*SD1, WITH GAMMA TO BE ESTIMATED, AND'/ 
     1'                  THE INITIAL GAMMA ESTIMATE TO BE ',G16.10)
 2116   FORMAT(/' S.D. = SQRT(SD1**2 + LAMBDA**2), WITH LAMBDA TO BE EST
     1IMATED'/
     2'                  AND THE INITIAL LAMBDA ESTIMATE TO BE ',G16.10)
 2117   FORMAT(/' S.D. = GAMMA, WITH GAMMA TO BE ESTIMATED, AND'/
     1'                   THE INITIAL GAMMA ESTIMATE TO BE ',G16.10)


        WRITE(25,1331) NDRUG
 1331   FORMAT(/' THE NO. OF DRUGS IS '/
     1' ',I2)
        WRITE(25,1329) NDRUG
 1329   FORMAT(/' THE ACTIVE (SALT) FRACTION(S) FOR THE ',I2,' DRUG(S)'/
     1' FOLLOW, IN ORDER: ')
        WRITE(25,*) (AF(I),I=1,NDRUG)

        WRITE(25,1221) ICYCLE+1
 1221   FORMAT(/' THE STARTING CYCLE NO. FOR THIS RUN IS ',I6)
        WRITE(25,1222) MAXCYC
 1222   FORMAT(/' THE LAST CYCLE NO. WILL BE .LE. ',I6)
        WRITE(25,1223) TOLC
 1223   FORMAT(//' BUT THE ANALYSIS WILL STOP BEFORE THE MAX. NO. OF'/
     1' CYCLES HAVE BEEN RUN IF CONVERGENCE IS ACHIEVED, AND'/
     2' CONVERGENCE IS ACHIEVED BASED ON LOGIC AND PRE-SET TOLERANCE'/
     3' PARAMETERS WHICH ARE APPROPRIATE FOR THE "INTERIOR POINT '/
     4' ALGORITHM" USED BY THIS PROGRAM. THIS ALGORITM WAS DEVELOPED'/
     5' BY JIM BURKE AT THE UNIVERSITY OF WASHINGTON, AND ADAPTED FOR'/
     6' THIS PROGRAM BY BOB LEARY.'//
     7' THE CYCLE TOL. PARAMETER SET BY THE USER IS ',F20.17/

     8' FOR CONVERGENCE, THE LOG-LIK BETWEEN 2 CONSECUTIVE "MAJOR CYCLES
     9"'/
     1' MUST BE .LE. THIS VALUE.') 

        WRITE(25,9769) 
 9769   FORMAT(/' THE TOLERANCE PARAMETER USED BY THE DIFFERENTIAL'/
     1' EQUATION SOLVER (VODE), IS: ')
        WRITE(25,*) RTOL
 
        IF(ICYCLE .GE. 1) WRITE(25,9771) PRIFIL2
 9771   FORMAT(/' THE APRIORI JOINT DENSITY IS FROM FILE ',A20)

        IF(ICYCLE .EQ. 0) WRITE(25,9772)
 9772   FORMAT(/' THE APRIORI JOINT DENSITY IS UNIFORM.')
 
	WRITE(25,*)
	WRITE(25,*)
	WRITE(25,*)' **************************************************'
	WRITE(25,*)' **************************************************'
 
	WRITE(25,1213)
 1213   FORMAT(///' THE FOLLOWING IS THE OUTPUT FROM THE PROGRAM.'///)

C  SET LASTCYC = LAST CYCLE NO. WHICH WAS PRINTED TO THE OUTPUT FILE
C  AND TO THE SCREEN. THIS IS NEEDED SINCE OTHERWISE ICYCLE IS PRINTED
C  OUT 3 TIMES (SEE FORMATS 1237 AND 1239) IF ierrmod .GE. 2. SEE THE 
C  NEW CODE WHICH RETURNS CONTROL TO 10001 TO RUN DIFFERENT 
C  "gammaplus/minus eps tries". THEN ONLY PRINT THE CYCLE NO. IF IT
C  HASN'T BEEN PRINTED BEFORE.

	LASTCYC = ICYCLE
 
C  CORDEN HOLDS, IN ITS FIRST NACTVE ROWS, THE STARTING JOINT DENSITY

C  AND COORDINATE VALUES. FOR K=1,NACTVE, CORDEN(K,J) = JTH COORDINATE
C  OF THE KTH ACTIVE POINT, J=1,NVAR; AND CORDEN(K,NVAR+1) IS THE
C  ASSOCIATED DENSITY FOR THE KTH ACTIVE POINT.
 
C  IF ICYCLE .GT. 0, CORDEN WAS READ IN.
C  IF ICYCLE = 0, NACTVE=NGRID, AND CORDEN WAS FILLED AT LABEL 30 ABOVE.
C		 IN THIS CASE, THE DENSITY IS UNIFORM, SO ALL
C		 CORDEN(K,NVAR+1) VALUES = 1/VOLSPA, K=1,NACTVE.
 
 
C	IPRED=11 + ICYCLE
C	JCOL=0
	ITEST=0
 
C  IPRED IS THE CYCLE NO. WHERE THE NEXT 2-CYCLE PREDICTION
C  ALGORITHM STARTS (IT IS NO LONGER USED). JCOL = COLUMN NO. OF DENSTOR
C  IN WHICH IS STORED THE DENSITY OF ONE OF THE 2-CYCLES USED IN THE
C  PREDICTION (IT IS NO LONGER USED). IT IS SET = 0 ABOVE, SINCE NO 

C  STORAGE IS REQUIRED UNTIL CYCLE NO. 11


C  (SEE BELOW). ITEST=0 --> THE NEXT CYCLE IS NOT (INITIALIZED) TO BE
C  A TEST CYCLE (SEE CODE BELOW WHEN ITEST=1,2, OR 3).
 
C    NEW FOR m2_13cal.f: NSTORE SET = 0. NSTORE IS THE NO. OF GRID
C    POINTS, WHOSE P(YJ|X) VALUES HAVE BEEN STORED IN PYJGX IN LOOP 800.
C    THIS NO. CAN BE CHANGED BY THE 'CONDENSING' CODE BELOW, SINCE
C    INACTIVE POINTS ARE THROWN OUT.
 
	NSTORE=0
cadapt    initialize grid resoution to 20%
          resolve=0.20

c  As of bigmlt1.f, the program checks to see if MAXCYC = 0. If so, no
c  cycle calculations are done. Instead control transfers to the end 
c  of the cycle calculations to pick up the means, medians, and modes

c  of the read-in density (which are needed to calculate YPREDPOP AND
c  YPREDPOPT), and then to label 900 to calculate the output files.

	IF(MAXCYC .EQ. 0) THEN
	 WRITE(*,2123) NSUB
	 WRITE(25,2123) NSUB
 2123    FORMAT(/' SINCE MAXCYC = 0, THIS RUN DOES NOT CONDUCT ANY'/
     1' NPAG ITERATIONS. INSTEAD, THE END-OF-THE RUN CALCULATIONS WILL'/
     2' TAKE PLACE WITH THE "FINAL CYCLE JOINT DENSITY" = THE PRIOR'/
     3' JOINT DENSITY READ IN, AND WITH THE ',I5,' PATIENT DATA FILES'/
     3' INPUT TO THIS PROGRAM.'//
     4' NOTE THAT THE FOLLOWING VALUES, DOWN TO THE BAYESIAN '/
     5' POSTERIOR DENSITY SECTION, ARE FOR THE APRIORI DENSITY, AND'/
     6' ARE ONLY INCLUDED BECAUSE THE PC PREP PROGRAM WHICH READS'/
     7' IN THIS OUTPUT FILE, EXPECTS TO SEE THEM.'//)
	 GO TO 2100
	ENDIF

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
      CALL SYMBOL  
   
 
 1001 ICYCLE=ICYCLE+1


C  Note that the program will open and read CHMAXCYC.OLD at the 
c  beginning of each new cycle. If it reads a 1, it will continue the 
c  calculations as before. If it reads a 0, it will change the value of 
c  MAXCYC to whatever ICYCLE is currently, which will cause the program 
c  to halt at the end of that cycle just as if MAXCYC had been set
c  to the changed value originally. If this happens, the program will
c  write a comment to the console and file 25 of why the program
c  has stopped prematurely.

	OPEN(37,FILE='CHMAXCYC.OLD')
	 READ(37,*) ICONTIN
	CLOSE(37)

	IF(ICONTIN .EQ. 0) THEN
	 MAXCYC0 = MAXCYC
	 MAXCYC = ICYCLE
	ENDIF


cgam3
10001 continue

c above is new entry point for gammaplus/minus eps tries
      itest = 0
 
 
cadapt  reset number of stored points to that before expansion
c     nstore=nstoresv
 
C+++++++++++++++ CODE ABOVE TO USE ONLY HIGH PROB POINTS ++++++++++++++
C  PRINT THE CYCLE NO. ONLY IF THIS CYCLE IS CERTAIN TO BE RUN (I.E.,
C  IF ITEST = 0). SUBROUTINE PRNTOP PRINTS THE CYCLE NO., ETC. FOR
C  ACCELERATED CYCLES.
 
	IF(ITEST .EQ. 0 .AND. ICYCLE .NE. LASTCYC) THEN
	 WRITE(*,1237) ICYCLE
	 WRITE(25,1239) ICYCLE
	 LASTCYC = ICYCLE
	ENDIF
 
 1237   FORMAT(///' CYCLE NO.',I5,'. SUBJECT NOS FOLLOW: ')
 1239   FORMAT(///' CYCLE NO.',I5,/)
	
 

C  ICYCLE IS THE NUMBER OF THE NEXT CYCLE TO BE RUN.
C
C  THIS IS WHERE EACH NEW CYCLE STARTS (FOR EACH CYCLE, THE DENSITY OF
C  X IS UPDATED FROM THE PREVIOUS DENSITY ESTIMATE, USING THE
C  OBSERVED SUBJECT DATA FROM THE INPUT DATA FILES WHICH ARE PASSED TO
C  SUBROUTINE IDPC BELOW.
C
C  ZERO OUT SPXGYJ. AFTER THE SUBJECT LOOP
C  (DO 1000), IT WILL BE THE VECTOR OF LENGTH NACTVE WHOSE ITH ELEMENT
C  IS THE SUM(P(X=X(I)|Y(J))) OVER J=1,NSUB, WHERE X = NVAR-
C  DIMENSIONAL. ALSO, ZERO OUT SLPYJ. AFTER THE SUBJECT LOOP, IT
C  WILL BE THE SCALAR SUM(LN(P(Y(J)))) OVER J=1,NSUB.

 
 

      DO 55 I=1,NACTVE
   55 SPXGYJ(I)=0.D0
!      SLPYJ=0.D0
C  COMMENTED OUT SLPYJ = 0 AS OF npageng28.f

 
C  START THE SUBJECT LOOP.
 
 

C  REWIND SCRATCH FILE 27 WHICH HAS ALL THE SUBJECT DATA FILES
C  CONCATENATED ON IT, IN ORDER.
 
	REWIND(27)
 



C  NOBTOT WILL BE THE RUNNING TOTAL OF ALL NON-MISSING OBSERVED VALUES
C  OVER ALL THE NSUB SUBJECTS. THIS IS NEEDED TO CALCULATE BIC BELOW.

        NOBTOT = 0


      DO 1000 JSUB=1,NSUB

 
	WRITE(*,*) JSUB
 
C  CALL SUBROUTINE FILRED TO READ, FOR THIS SUBJECT, FROM SCRATCH FILE
C  27, THE NO. OF OBSERVATION TIMES (NOBSER) AS WELL AS THE
C  OBSERVED VALUES THEMSELVES: YO(I,J) = THE 'NOISY' OBSERVED VALUES
C  FOR THIS SUBJECT; I=1,NOBSER, J=1,NUMEQT. THESE OBSERVED VALUES ARE
C  USED ONLY TO CALCULATE THE ASSAY STANDARD DEVIATIONS (USING THE
C  VECTORS, C0,C1,C2,C3, WHICH ARE ALSO READ IN). THE REST OF THE INFO
C  IN THE SUBJECT DATA FILE IS PASSED IN COMMONS TO THE IDPC MODULE
C  SUBROUTINES.
 
	CALL FILRED(NOBSER,YO,C0,C1,C2,C3,NUMEQT)

C  FIND THE ASSAY STANDARD DEVIATIONS FOR THIS SUBJECT. FOR EACH
C  OF THE NOBSER*NUMEQT OBSERVED VALUES (EXCEPT THAT YO(I,J) = -99 -->
C  OUTPUT EQ. J HAS NO OBSERVED LEVEL FOR OBSERVATION TIME I),
C  Y, SIG = C0 + C1*Y + C2*Y**2 + C3*Y**3.
C  NOTE THAT, THEORETICALLY, SIG SHOULD BE A CUBIC FNT. OF
C  THE 'TRUE' OBSERVED VALUES, NOT THE 'NOISY' OBSERVED VALUES (BUT THE

C  'TRUE' VALUES ARE UNKNOWN).
 
C  ALSO, CALCULATE SIGFAC, THE PRODUCT OF THE NON-MISSING STD. DEV.'S

C  (A NON-MISSING S.D. IS ONE FOR WHICH THE CORRESPONDING YO(I,J) IS
C  .NE. -99, THE MISSING VALUE CODE).
C  INITIALIZE SIGFAC=1, AND THEN UPDATE IT FOR EACH NON-MISSING
C  OBSERVATION.
 
C  MISVAL WILL BE THE RUNNING TOTAL OF MISSING VALUES AMONG ALL THE
C  NUMEQT x NOBSER POTENTIAL OBSERVED LEVELS.

	MISVAL = 0
 
        SIGFAC=1.D0
 
 	DO 140 I=1,NOBSER
 	 DO 140 J=1,NUMEQT
 
	  Y = YO(I,J)
 
C  IF Y = -99, IT MEANS THAT OUTPUT EQ. J HAD NO VALUE AT OBSERVATION
C  TIME I. IN THIS CASE, IGNORE THIS Y AND INCREASE MISVAL BY 1.
 

	  IF(Y .EQ. -99) THEN
	   MISVAL = MISVAL+1
	   GO TO 140
	  ENDIF
 
C  NOTE: FOR EACH SUBJECT, MUST ENSURE THAT ALL THE STD DEV'S ARE NON-
C        ZERO. OTHERWISE, THE PROGRAM WILL BLOW UP! THIS IS BECAUSE
C        P(YJ|X) INVOLVES SQUARED DIFFERNCES BETWEEN OBSERVED Y'S AND
C        EXPECTED Y'S (FOR EACH X GRID POINT)...EACH DIFFERENCE
C        NORMALIZED (I.E., DIVIDED) BY THE VARIANCE OF THE RESPECTED
C        OBSERSATION.
 
C 	 SEE M2_17CAL.F CODE FOR COMMENTS ON HOW A STD. DEV. COULD = 0.
 
C  ALSO TEST TO MAKE SURE NO STD. DEV. < 0, SINCE SIGFAC BEING NEGATIVE
C  WOULD RESULT IN A NEGATIVE PROBABILITY (SEE PYJGX CALCULATION BELOW).
 
      SIG(I,J) = C0(J)+C1(J)*Y+C2(J)*Y*Y+C3(J)*Y**3
cgam4
      if(ierrmod.eq.2) sig(i,j) = sig(i,j)*gamma
      if(ierrmod.eq.3) sig(i,j)=dsqrt(sig(i,j)**2 + gamma**2)
      if(ierrmod.eq.4) sig(i,j) = gamma*flat

      IF(SIG(I,J) .EQ. 0) THEN
		WRITE(*,2345) JSUB
		WRITE(25,2345) JSUB
2345            FORMAT(//' A S.D. IS 0 FOR JSUB = ',I5,'. RERUN THE '/
     1' PROGRAM WITH C0 NOT = 0  FOR THIS SUBJECT, OR WITH THIS'/
     2' SUBJECT ELIMINATED.')
	   	CLOSE(27)
	   	CLOSE(25)

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,2345) JSUB
        CLOSE(42)

		CALL PAUSE
       	STOP
      ENDIF
 
      IF(SIG(I,J) .LT. 0) THEN
		WRITE(*,2346) JSUB
		WRITE(25,2346) JSUB
2346            FORMAT(//' A S.D. < 0 FOR JSUB = ',I5,'. RERUN THE '/
     1' PROGRAM WITH A BETTER CHOICE FOR THE ASSAY ERROR POLYNOMIAL'/
     2' COEFFICIENTS.')
	   	CLOSE(27)
	   	CLOSE(25)

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,2346) JSUB
        CLOSE(42)

		CALL PAUSE
	   	STOP
      ENDIF
 
      SIGFAC=SIGFAC*SIG(I,J)
 
  140 CONTINUE

 
C  NOTE THAT SIGFAC WAS CALCULATED IN LOOP 140 ABOVE, AND THAT OFAC IS
C  NOW THE RESULT OF (NOBSER*NUMEQT - MISVAL) VALUES.
 
        OFAC=2.506628274631**(NOBSER*NUMEQT - MISVAL)

        NOBTOT = NOBTOT + NOBSER*NUMEQT - MISVAL

 
C  NOTE THAT 2.5066... = SQRT(2*PI).
 
C  FOR EACH SUBJECT, AND EACH GRID POINT, CALL IDPC, A SUBROUTINIZED
C  VERSION OF THE ADAPT PROGRAM ID3 TO CALCULATE THE SUM OF SQUARES OF
C  DIFFERENCES BETWEEN THE OBSERVED VALUES AND PREDICTED (BY THE MODEL)
C  VALUES (NORMALIZED BY THE ASSAY VARIANCE OF EACH OBSERVATION) ...
C  BUT THIS NEEDS TO BE DONE JUST ONCE (ICYCLE=IFIRST), BECAUSE THE
C  VALUES P(JSUB|IG), FOR SUBJECT JSUB AND GRID PT. IG, DON'T CHANGE
C  CYCLE - TO - CYCLE, AND CAN THEREFORE BE STORED INTO PYJGX(JSUB,IG).
 
 8888   FORMAT(' ',' CYCLE ',I5,',  SUBJECT ',I5,' ...  % COMPLETED = ',

     1F8.2)
	XNEXT = 1.D0

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$omp Parallel Default(PRIVATE) Shared(NACTVE,NSTORE,NVAR,CORDEN)
!$omp&Shared(IRAN,VALFIX,MAXACT,PYJGX,WORKK,JSUB,SIGFAC,OFAC,WORK)
!$omp&Shared(MAXTHREAD,NOFIX,RANFIXEST,NRANFIX)
C  ABOVE LINE EDITED AS OF npagranfix5.f.
!$omp Do



	DO 800 IG=1,NACTVE
 

C  PRINT TO THE SCREEN THE UPDATE ON WHAT % OF GRID POINTS HAVE BEEN
C  CALCULATED IF NACTVE > NSTORE (I.E., IF NACTVE .LE. NSTORE -->
C  ALL P(YJ|X)'s ARE ALREADY STORED INTO PYJGX AND SO THIS 8OO LOOP
C  WILL GO VERY FAST.
 
	IF(NACTVE .GT. NSTORE) THEN	
 
C  PRINT GRID PT. AND % COMPLETED TO SCREEN.
	XPER=IG*100.D0/NACTVE

	IF(XPER .GE. XNEXT) THEN

        IF(ICYCLE.eq.1) THEN

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$       GOTO 676        

	 WRITE(*,8888) ICYCLE,JSUB,XPER
  676	 IF(NXE .GT. 0) WRITE(*,1254) NXE
 1254    FORMAT('  TOTAL NO. OF NUM. INTEG. WARNINGS IS ',I20)
	ENDIF

	 XNEXT=XNEXT+1.D0
 
	ENDIF

	ENDIF 
 
	IF(IG .LE. NSTORE) GO TO 700
 
	

C  ESTABLISH THE IGTH GRID POINT. IT IS STORED IN ROW IG OF
C  CORDEN.
 
	DO J=1,NVAR
	 X(J)=CORDEN(IG,J)
	END DO
 
C  ESTABLISH THE COMBINED RANDOM AND FIXED PARAMETER VALUES INTO
C  PX -- IN THE CORRECT ORDER AS INDICATED BY VECTOR IRAN. CALL
C  MAKEVEC TO DO THIS. AS OF npagranfix.f, ADD NRANFIX AND RANFIXEST
C  TO THE ARGUMENT LIST TOO (I.E., THERE IS NOW A 3RD TYPE OF 
C  PARAMETER (THOSE WHICH ARE UNKNOWN BUT THE SAME FOR ALL SUBJECTS).

      CALL MAKEVEC(NVAR,NOFIX,NRANFIX,IRAN,X,VALFIX,RANFIXEST,PX)
	CALL IDPC(PX,W) 
 
C  W RETURNS AS THE SUM OF:
C  ((YO(I,J)-H(I,J))/SIG(I,J))**2, WHERE H(I,J) = PREDICTED VALUE OF THE
C  JTH OUTPUT EQ AT THE ITH OBSERVATION TIME, ASSUMING THE IGTH GRID
C  POINT, X, ... OVER THE NOBSER x NUMEQT QUANTITIES ABOVE WHICH DON'T
C  HAVE YO(I,J) = -99 (WHICH MEANS THAT OUTPUT EQ. J HAS NO OBSERVED
C  LEVEL FOR TIME I).
 
C  CALCULATE P(YJ|X) FOR X-GRID POINT NO. IG.


 
C  THIS NEXT TEST IS FOR THE PC. AS AN EXAMPLE, THE COMPAC COMPUTER
C  CANNOT HANDLE ARGUMENTS TO DEXP WHICH ARE SMALLER THAN -11354. SINCE
C  THE ARGUMENT TO DEXP BELOW IS -.5*W, SET PYJGX = 0 IF W IS .GT.
C  22708.
 
C  SEE CODE AFTER CALCULATION OF P(YJ) TO SEE WHAT HAPPENS IF ALL THE
C  P(YJ|X) ARE  SET = 0.
 
C  NOTE THAT WORKK WILL ALWAYS BE SET = P(YJ|X=IG GRID PT), WHICH IS
C  NEEDED IN THE CALCULATION OF DXI (NOTE DXI NOT USED AS OF 
C  bignpaglap1.f) SINCE PYJGX WILL NOT BE COMPLETE IF NACTVE > MAXACT.

	IF(IG .LE. MAXACT) PYJGX(JSUB,IG)=0.D0
	WORKK(IG) = 0.D0
 
	IF(W .LE. 22708.D0) THEN
	 IF(IG .LE. MAXACT) PYJGX(JSUB,IG) = DEXP(-.5D0*W)/SIGFAC/OFAC
	 WORKK(IG) = DEXP(-.5D0*W)/SIGFAC/OFAC
	ENDIF
 
C  CALCULATE P(X,YJ) FOR X-GRID POINT NO. IG. PUT IT INTO WORK(IG).
 
	IF(IG .GT. MAXACT) THEN
	 WORK(IG) = WORKK(IG)*CORDEN(IG,NVAR+1)
	 GO TO 800
	ENDIF
 
  700   WORK(IG)=PYJGX(JSUB,IG)*CORDEN(IG,NVAR+1)

	WORKK(IG) = PYJGX(JSUB,IG)
 	
  800   CONTINUE

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$omp   End Do
!$omp   End Parallel

	
 
C  CALCULATE P(YJ), A SCALAR WHICH IS THE INTEGRAL OF P(X,YJ) OVER

C  X-SPACE.
 
C  CALL NOTINT, AN INTEGRATION ROUTINE. THE

C  FOLLOWING IS SUPPLIED TO THIS ROUTINE:
C  VOLSPA = VOLUMNE OF THE INTEGRATION SPACE.
C  NGRID = NO. OF ORIGINAL GRID POINTS.
C  NACTVE = NO. OF ACTIVE GRID POINTS.
C  WORK(I), I=1,NACTVE = VALUE OF THE FUNCTION TO BE INTEGRATED, AT
C                       THE ITH GRID POINT.
C  MAXGRD  = THE DIMENSION OF WORK.
  

      CALL NOTINT(VOLSPA,NGRID,NACTVE,WORK,MAXGRD,PYJ)
 
C  IF PYJ RETURNS AS 0, IT IS BECAUSE P(X,YJ)=WORK IS 0 IN ALL ITS
C  NACTVE ENTRIES. THIS OCCURS WHEN EACH OF NACTVE VALUES OF W (WHICH
C  RETURNS FROM THE CALLS TO IDPC) IS LARGER THAN 1416 (SINCE P(YJ|X)
C  INVOLVES e RAISED TO THE POWER -.5*W, AND e RAISED TO A POWER
C  SMALLER THAN -708 IS SET TO 0 BY, FOR EXAMPLE, THE COMPAC COMPUTER).
C

C  IN CASE THIS HAPPENS, PRINT A MESSAGE TO THE USER AND STOP.
C
	IF (PYJ .EQ. 0.D0) THEN
       WRITE(*,26) JSUB
       WRITE(25,26) JSUB
   26  FORMAT(//' FOR SUBJECT, ',I6,' THE PROB. OF THE OBSERVED'/
     1' CONCENTRATIONS (FOR THE INDICATED DOSAGE REGIMEN), GIVEN EACH '/

     2' AND EVERY GRID POINT IN THE ESTABLISHED GRID, IS 0. THE '/

     3' PROGRAM STOPS. THE USER SHOULD CONSIDER INCREASING THE'/
     4' NO. OF GRID POINTS ALLOWED (HARDCODED INTO MAIN), AND/OR '/
     5' NARROWING THE GRID BOUNDARIES OF THE VARIABLES, AND/OR  '/
     6' INCREASING THE SIZES OF (C0,C1,C2,C3), THE ASSAY NOISE '/
     7' COEFFICIENTS. ALL OF THESE CHANGES WILL HAVE THE EFFECT OF'/
     8' MAKING SOME OF THE ABOVE CONDITIONAL PROBABILITES LARGER.')

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,26) JSUB 
        CLOSE(42)


        CALL PAUSE
        STOP
	ENDIF
 
 
C  ALSO, FROM LOOP 800 ABOVE, WORK(I) = P(X(I),YJ) --> WORK(I)/PYJ
C  = P(X(I)|Y=YJ). ADD THIS TO SPXGYJ(I) = SUM OF P(X(I)|Y=YJ) OVER ALL
C  NSUB SUBJECTS. DO THIS FOR ALL I=1,NACTVE.
 
! NEW PARALLEL CODE BELOW AS OF npageng28.f. 

!	DO I=1,NACTVE
!         SPXGYJ(I)=SPXGYJ(I)+WORK(I)/PYJ
!	END DO
 
C  ADD THIS SUBJECT'S CONTRIBUTION TO SLPYJ.
 
!	SLPYJ=SLPYJ+DLOG(PYJ)
 

 
 1000   CONTINUE


C  WRITE A MESSAGE TO THE USER IN CASE THIS RUN IS ANALYZING A LARGE

C  NO. OF SUBJECTS WITH A LARGE NO. OF INITIAL GRID POINTS ... SO HE
C  WILL KNOW THE PROGRAM HAS NOT 'HUNG'. ALSO SEE FORMAT 123 IN 
C  Subroutine emint.

      IF(ICYCLE .EQ. 1) WRITE(*,1243)
 1243 FORMAT(/' The Adaptive Grid optimization process could take '/
     1' several minutes if you are analyzing a large no. of subjects'/
     2' with a large no. of grid points. '//
     3' An approximate measure of how close the process is to being'/
     4' completed will be printed below: '/) 


C  AS OF npageng20.f, ONLY SAVE THE JOINT DENSITY AFTER CYCLE NO. 2.
C  REASON: CYCLE NO. 1 TYPICALLY HAS A LARGE NO. OF GRID POINTS AND
C   SO SAVING THE JOINT DENSITY AT THAT POINT COULD TAKE A LOT OF 
C   TIME. THAT, ALONG WITH THE FACT THAT THE PROBABILITY THE PROGRAM
C   WILL BOMB AFTER CYCLE 1 AND BEFORE CYCLE 2 IS VERY LOW, ARGUES
C   FOR SAVING THE DENSITY AFTER CYCLE NO. 2., WHEN THE TIME TO SAVE
C   WILL TYPICALLY BE MUCH LESS (SINCE THE NO. OF GRID POINTS WILL
C   PROBABLY HAVE DECREASED A LOT).

C   BY NOT SAVING THE DENSITY EVERY CYCLE, THE RUN WILL BE SPEEDED
C   UP, AND THERE WILL BE VERY LITTLE CHANCE THAT THE RUN, IF COMPILED
C   AND LINKED WITH gfortran, WILL STOP WITH A "Cannot write to file
C   opened for READ" error (referring to DENFIL).

C   ALSO, SINCE THE LION'S SHARE OF TIME FOR AN ANALYSIS IS USUALLY
C   GETTING THROUGH CYCLE 1, SAVING THE DENSITY AFTER CYCLE 2 WILL
C   TYPICALLY BE ALMOST AS GOOD AS SAVING IT AFTER, SAY, 100 CYCLES.

C  SO, IF ICYCLE = 2, STORE THIS CYCLE'S JOINT DENSITY (DOWN TO CORDEN
C  ONLY) INTO THE FILE DENFIL. THEN, IF THE RUN CRASHES BEFORE
C  COMPLETION, THE USER WILL BE ABLE TO PICK THE RUN UP AGAIN AFTER
C  THE END OF CYCLE 2, BY USING THE FOLLOWING DENSITY FILE AS AN 
C  APRIORI FILE.

C  NO! AS OF npageng23.f, THE SAVING OF EACH CYCLE'S DENSITY, EXCEPT
C  AFTER CYCLE 1, IS RESUMED. BUT THIS CAN BE MANUALLY CHANGED BY
C  CHANGING ISAVEDEN BELOW (IF ISAVEDEN IS SET TO SOMETHING OTHER THAN
C  1, EACH CYCLE'S DENSITY WILL NOT BE SAVED).

 
C???DEBUG. CHANGE ISAVEDEN TO BE 0 SO THE DENSITY IS NOT SAVED. THIS
C  IS BECAUSE I GOT SOME 'Cannot write to file opened for READ' 
C  execution errors while testing npagranfix2n.f.


      ISAVEDEN = 0

      IF(ISAVEDEN .EQ. 1 .AND. ICYCLE .NE. 1) THEN 

	OPEN(33,FILE=DENFIL)
 
	WRITE(33,7124)
 
	WRITE(33,*) NDIM
	WRITE(33,*) INDPTS
 
C  NEW CODE ABOVE FOR m2_11cal.f
 
	WRITE(33,*) NACTVE
	WRITE(33,*) NVAR
	WRITE(33,2227) (PAR(I),I=1,NVAR)
	WRITE(33,*) NOFIX
	WRITE(33,2227) (PARFIX(I),I=1,NOFIX)
      WRITE(33,*) NRANFIX
	WRITE(33,2227) (PARRANFIX(I),I=1,NOFIX)

 
	DO I=1,NVAR
	 WRITE(33,*) (AB(I,J),J=1,2)
	END DO
 
	WRITE(33,*) (VALFIX(I),I=1,NOFIX)
	WRITE(33,*) (RANFIXEST(I),I=1,NOFIX)
	

C  STARTING WITH MXEM2N36.FOR, NINT WILL ALWAYS BE 100. BUT, IN ORDER
C  NOT TO CHANGE THE STRUTURE OF PRIOR DENSITY FILES (SO THAT PRIOR
C  DENSITIES CAN STILL BE RUN WITH MXEM2N36.FOR), NINT WILL STILL
C  BE WRITTEN TO, AND READ FROM, THIS FILE.
 
	WRITE(33,*) NINT
 
	WRITE(33,*) ICYCLE
	WRITE(33,*) DORIG
 
	 DO I=1,NACTVE
	  WRITE(33,*) (CORDEN(I,J),J=1,NVAR+1)
	 END DO

	CLOSE(33)

      ENDIF

C  ABOVE ENDIF IS FOR THE IF(ISAVEDEN .EQ. 1 .AND. ICYCLE .NE. 1)
C   CONDITION.


c begin optimization
cgam5
cgam5 - from here (immediately after 1000   CONTINUE to
cgam5 - immediately before c end optimization was lifted
cgam5 - from gamadapt1.f, replacing old material beteen these limits
      igamma = igamma + 1
      if(ierrmod.eq.1) igamma=1
csdsc - added April 2, 2000
c con first iteration, call hte interior point method

      if(mod(igamma,3).eq.1) then
      IF(ISUPRES .EQ. 0) write(6,*)
      IF(ISUPRES .EQ. 0) write(6,*) 'icycle,igamma =',icycle,igamma
      IF(ISUPRES .EQ. 0) 
     1 write(6,*) 'condensing current ', nactve, ' point grid'
      IF(ISUPRES .EQ. 0) write(6,*) 'base gamma =',gamma

      gammab = gamma
      gammap = gamma * (1.d0+gamdel)
      gammam = gamma / (1.d0+gamdel)
      call emint(pyjgx,maxsub,corden,maxgrd,nactve,nsub,1,
     &corden(1,nvar+1),denstor(1,1),denstor(1,2),denstor(1,3),
     &fobj,gap,nvar,keep,IHESS)

C  AS OF npageng18.f, IHESS IS ADDED TO ARGUMENT LIST OF emint.
C  IF IHESS RETURNS AS -1, IT MEANS THE HESSIAN MATRIX IN THE INTERIOR
C  POINTS ALGORITHM WAS SINGULAR. IN THIS CASE, GO TO LABEL 900 TO
C  CREATE THE OUTPUT FILES BASED ON THE VALUES FROM THE PREVIOUS CYCLE.
C  NOTE THAT BY GOING TO LABEL 900, NOTHING FROM THIS CYCLE WILL BE
C  WRITTEN TO FILE 25, AND THE CORDEN(.,.) MATRIX WILL REMAIN WHAT IT
C  WAS FROM THE PREVIOUS CYCLE.

      IF(IHESS .EQ. -1) GO TO 900


      fobj1 = fobj
      nactve1 = nactve

      IF(ISUPRES .EQ. 0) 


     1 write(6,*) 'base job 1, fobj,keep,icycle=',fobj,keep,icycle
C      CALL PAUSE


      nactve = keep
      call emint(pyjgx,maxsub,corden,maxgrd,nactve,nsub,0,
     &corden(1,nvar+1),denstor(1,1),denstor(1,2),denstor(1,3),
     &fobj,gap,nvar,keep,IHESS)

C  AS OF npageng18.f, IHESS IS ADDED TO ARGUMENT LIST OF emint.

C  IF IHESS RETURNS AS -1, IT MEANS THE HESSIAN MATRIX IN THE INTERIOR
C  POINTS ALGORITHM WAS SINGULAR. IN THIS CASE, GO TO LABEL 900 TO
C  CREATE THE OUTPUT FILES BASED ON THE VALUES FROM THE PREVIOUS CYCLE.
C  NOTE THAT BY GOING TO LABEL 900, NOTHING FROM THIS CYCLE WILL BE
C  WRITTEN TO FILE 25, AND THE CORDEN(.,.) MATRIX WILL REMAIN WHAT IT
C  WAS FROM THE PREVIOUS CYCLE.


      IF(IHESS .EQ. -1) GO TO 900


      fobjbase = fobj


      IF(ISUPRES .EQ. 0)
     1 write(6,*) 'base job 0, fobj,keep,icycle=',fobj,keep,icycle
      IF(ISUPRES .EQ. 0) 
     1 write(6,*) 'base job 0 nactve,gamma=',nactve,gamma

      nactve0 = nactve
c new on Jan 2, 2002 - save otpimal solution in denstor(1,4)
c so that stat program can work on best of base, up, and down
c solutions
      do i=1,nactve
      denstor(i,4)=corden(i,nvar+1)
      enddo
      nstore = 0
      fobjbest = fobjbase

      IF(ISUPRES .EQ. 0) write(6,*) 'finished base case'

      if(ierrmod.eq.1) go to 14001
      gamma = gammap
      go to 10001

      endif
cgamma above endif is for mod(igamma,3).eq.1 case
      if(mod(igamma,3).eq.2) then


      IF(ISUPRES .EQ. 0) write(6,*) 'gamma plus =',gamma

      call emint(pyjgx,maxsub,corden,maxgrd,nactve,nsub,0,
     &corden(1,nvar+1),denstor(1,1),denstor(1,2),denstor(1,3),
     &fobj,gap,nvar,keep,IHESS)

C  AS OF npageng18.f, IHESS IS ADDED TO ARGUMENT LIST OF emint.
C  IF IHESS RETURNS AS -1, IT MEANS THE HESSIAN MATRIX IN THE INTERIOR
C  POINTS ALGORITHM WAS SINGULAR. IN THIS CASE, GO TO LABEL 900 TO
C  CREATE THE OUTPUT FILES BASED ON THE VALUES FROM THE PREVIOUS CYCLE.
C  NOTE THAT BY GOING TO LABEL 900, NOTHING FROM THIS CYCLE WILL BE
C  WRITTEN TO FILE 25, AND THE CORDEN(.,.) MATRIX WILL REMAIN WHAT IT
C  WAS FROM THE PREVIOUS CYCLE.

      IF(IHESS .EQ. -1) GO TO 900


      fobjplus = fobj



      IF(ISUPRES .EQ. 0) 

     1 write(6,*) 'fobjplus,gamma,icycle=',fobjplus,gamma,icycle

c new  Jan 2, 2002 - save solution if fobjplus is better than fobjbase
      if(fobjplus.gt.fobjbest) then
      fobjbest = fobjplus
      do i=1,nactve

      denstor(i,4) = corden(i,nvar+1)
      enddo
      endif
      gamma = gammam


      IF(ISUPRES .EQ. 0) write(6,*) 'finished plus case'


         go to 10001
      endif
      if(mod(igamma,3).eq.0) then

      IF(ISUPRES .EQ. 0) write(6,*) 'gamma minus=',gamma

      call emint(pyjgx,maxsub,corden,maxgrd,nactve,nsub,0,
     &corden(1,nvar+1),denstor(1,1),denstor(1,2),denstor(1,3),
     &fobj,gap,nvar,keep,IHESS)


C  AS OF npageng18.f, IHESS IS ADDED TO ARGUMENT LIST OF emint.

C  IF IHESS RETURNS AS -1, IT MEANS THE HESSIAN MATRIX IN THE INTERIOR
C  POINTS ALGORITHM WAS SINGULAR. IN THIS CASE, GO TO LABEL 900 TO
C  CREATE THE OUTPUT FILES BASED ON THE VALUES FROM THE PREVIOUS CYCLE.
C  NOTE THAT BY GOING TO LABEL 900, NOTHING FROM THIS CYCLE WILL BE
C  WRITTEN TO FILE 25, AND THE CORDEN(.,.) MATRIX WILL REMAIN WHAT IT
C  WAS FROM THE PREVIOUS CYCLE.

      IF(IHESS .EQ. -1) GO TO 900


      fobjminu = fobj

      IF(ISUPRES .EQ. 0) 
     1 write(6,*) 'fobjminu,gamma,icycle=',fobjminu,gamma,icycle

      if(fobjminu.gt.fobjbest) then
      fobjbest = fobjminu
      do i=1,nactve
      denstor(i,4) = corden(i,nvar+1)
      enddo
      endif

      IF(ISUPRES .EQ. 0) write(6,*) 'finished gamma minus case'

      endif
cgamma - above statement changed from "nstore = nactve" to force
c reevaluation of all points.
      
c now temporairily reset to gamma
      gamma = gammab
      fobj = fobjbase
      if(fobjplus.gt.fobjbase) then
      gamma = gammap

      fobj = fobjplus
      gamdel = 4.*gamdel
      endif
      if(fobjminu.gt.fobjbase) then
      gamma = gammam
      fobj = fobjminu
      gamdel = 4.*gamdel
      endif

      gamdel = gamdel*0.5
      if(gamdel.lt.0.01) gamdel=0.01
14001 continue
cgam5 above label is entry point for ierrmod = 1 (no  gamma) case

      IF(ISUPRES .EQ. 0) write(6,*) 'fobjbest=',fobj

c corden(*,nvar+1) sums to 1 when it comes out of emint
c Now reset forden(i,nvar+1) to best of three solutions
c and normalize to funny BIGNPEM factor
      fact=ngrid/volspa

      do i=1,nactve
      corden(i,nvar+1)=fact*denstor(i,4)
      enddo


cend optimization


cbegin statistics


c now we compute all hte statistical stuff using this distribution
c and the full nactve (before condensation) points.
c Later, in the condensation performed just before the grid refienment
c and subsequent expansion, we will condense by just using the
c 'keep' flags in DENSTOR(i,1) that emint left there.  The density will

c not be updated to refelct this cahnge (there is no need)
c until the next call to emint


c  As of npageng18.f, save CORDEN to CORDLAST AND NACTVE TO NACTLAST.
c  The reason is that if, somewhere during the next cycle's calculations
c  (during one of the calls to Subroutine emint), a Hessian Matrix is
c  singular, then IHESS will be set = -1, and the program will stop.
c  And in this case, the program must be able to write out all of the
c  information from this cycle (the last completed cycle). And that
c  means that the CORDEN from this cycle (which will be stored into 
c  CORDLAST), and NACTVE (store into NACTLAST) should be used in the
c  call to Subroutine SUBRES in loop 7000. Otherwise, the CORDEN and
c  NACTVE used in that call would have already partly updated in the
c  next cycle before the Hessian error occurred.

      DO I = 1,NACTVE
       DO J = 1,NVAR+1
       CORDLAST(I,J) = CORDEN(I,J)
       END DO
      END DO

      NACTLAST = NACTVE


 
 
C  SLPYJ IS NOW THE LOG-LIKELIHOOD OF ALL NSUB SUBJECT VECTORS, GIVEN
C  THE PRIOR DENSITY IN COL. NVAR+1 OF CORDEN.
 
C  PRINT OUT SLPYJ FOR THE PRIOR DENSITY:


	IF(ISUPRES .EQ. 0) WRITE(*,8) NSUB 

	WRITE(25,8) NSUB
    8 FORMAT(/' THE TRUE (NUMERICAL) LOG-LIKELIHOOD OF THE ',I3/

     1' SUBJECT VECTORS, GIVEN THE PRIOR DENSITY, IS: ')

	IF(ISUPRES .EQ. 0) WRITE(*,*) fobj

	WRITE(25,*) fobj


C  AS OF bigmlt12.f, CALCULATE AIC AND BIC, AS IN itbig13.f. THESE 
C  VALUES WILL PRINT EVERY CYCLE IN THE OUTPUT FILE.

C  AS OF npageng26.f, THE FORMULAS FOR AIC AND BIC ARE CHANGED.

C  CALCULATE TWO MEASURES OF INFORMATION: THE AKAIKE INFORMATION 
C  CRITERION (AIC), AND THE SCHWARTZ (BAYESIAN) INFORMATION CRITERION 
C  (BIC). IN GENERAL, THE MODEL WITH THE MINIMUM AIC AND/OR
C  BIC IS THE PREFERRED MODEL.

C  AIC = 2*(-TRULOG + (D + Q)), WHERE TRULOG = fobj (SEE ABOVE),
C	 D = NVAR, THE DIMENSION OF THE RANDOM PARAMETER VECTOR.
C   	 Q = NO. OF NOISE PARAMETERS = 
C	     = 0 IF IERRMOD = 1;
C          = 1 IF IERRMOD = 2,3, OR 4.
C  BUT AS OF npageng27.f, WE USE THE NEW FORMULA, AICC, WHERE
C  AICC = AIC + 2*KP(KP+1)/(NOBTOT-KP-1), WHERE KP = D + Q.

C  BIC = 2*(-TRULOG + .5*(D + Q)*LOG(NOBTOT)), WHERE TRULOG, D, AND Q
C      ARE AS ABOVE, AND NOBTOT IS THE TOTAL NO. OF NON-MISSING OBSERVED
C      VALUES OVER ALL SUBJECTS (INCLUDING ALL NUMEQT OUTPUT EQUATIONS).

        QVAL = 1
        IF(IERRMOD .EQ. 1) QVAL = 0
        KP = NVAR + QVAL

        AIC = 2.D0*(-FOBJ + KP)

C  AS OF npageng28.f, verify that NOBTOT-KP-1 is not .LE. 0. If it
C  is, set AICC = AIC.

        AICC = AIC
        IF(NOBTOT-KP-1 .GT. 0) AICC = AIC + 2.D0*KP*(KP+1)/(NOBTOT-KP-1)
        BIC = 2.D0*(-FOBJ + .5D0*(NVAR + QVAL)*DLOG(1.D0*NOBTOT))

        IF(ISUPRES .EQ. 0) THEN
         WRITE(*,3412)
 3412   FORMAT(/' THE AKAIKE AND BAYESIAN INFO CRITERIONS (AIC AND BIC) 
     1ARE: ') 
         WRITE(*,*) AICC,BIC
        ENDIF

         WRITE(25,3412)
         WRITE(25,*) AICC,BIC

C+++++++++++++++ CODE BELOW TO USE ONLY HIGH PROB POINTS ++++++++++++++
 

C  PRINT NACTVE ONLY IF THIS CYCLE IS CERTAIN TO RUN (I.E.,
C  ONLY IF ITEST = 0). SUBROUTINE PRNTOP PRINTS THIS INFO FOR
C  ACCELERATED CYCLES.
 
	IF(ITEST .EQ. 0) THEN
 
C  NOTE THAT SPXGYJ(I) FOR ALL INACTIVE GRID POINTS = 0 --- SEE CODE
C  NEAR LABEL 800. SO ALL INACTIVE GRID POINTS WILL REMAIN FOREVER
C  INACTIVE.
 
	IF(ISUPRES .EQ. 0) THEN
	 WRITE(*,*)
	 WRITE(*,*)' THE NO. OF ACTIVE GRID POINTS IS NOW ',NACTVE
	 WRITE(*,*)
	 WRITE(*,*)' THE INITIAL NO. OF GRID POINTS WAS ',ngridn
	 WRITE(*,*)
	ENDIF
 
	WRITE(25,*)
	WRITE(25,*)' THE NO. OF ACTIVE GRID POINTS IS NOW ',NACTVE
	WRITE(25,*)
	WRITE(25,*)' THE INITIAL NO. OF GRID POINTS WAS ',ngridn
	WRITE(25,*)
 
 

	ENDIF
 
C+++++++++++++++ CODE ABOVE TO USE ONLY HIGH PROB POINTS ++++++++++++++

	IF(ISUPRES .EQ. 0) WRITE(*,11)

	WRITE(25,11)
   11 FORMAT(//' THE FOLLOWING VALUES ARE FOR THE UPDATED DENSITY: ')
 
 
C  CALCULATE THE 'SCALED INFORMATION' FOR THIS CYCLE (STARTING WITH

C  PROGRAM m234calc.f, 11-6-94; BUT THE SCALED 'INFO' IS CHANGED
C  IN PROGRAM MXEM2N35.FOR/m235calc.f, 11-19-94):
 
C  INFO = SUM(PI*LOG(PI)), WHERE THE SUM IS OVER I=1,NACTVE, THE LOG
C    	  IS TO BASE 2, PI*LOG(PI) --> 0 IF PI = 0, AND
C	  PI = D(I)*VOLSPA/NGRID (SINCE SUM(D(I)) = NGRID/VOLSPA),
C 	  WHERE D(I) = CORDEN(I,NVAR+1), I=1,NACTVE.
 
 
C  THEN INFO IS SCALED: y = 100*ln(2)/ln(n/N)*(x + ln(n)/ln(2)), WHERE
C  y = SCALED INFO, x = ABOVE INFO, n = NGRID, N = NO. OF SUBJECTS. SO
C  y = 0 (%) IF DENSITY IS UNIFORM, and y = 100 (%) if DENSITY IS
C  CONCENTRATED AT N EQUALLY LIKELY POINTS, ... I.E., SCALED INFO = 0 %
C  FOR NO INFO, AND SCALED INFO = 100 % FOR PERFECT INFO.
 
	FACT=VOLSPA/NGRID
 
	SUM=0.D0

 
	DO I=1,NACTVE
 
	PI=CORDEN(I,NVAR+1)*FACT
	IF (PI .GT. 1.D-200) THEN

	  SUM=SUM+PI*DLOG(PI)
	ENDIF
 
	END DO
 
	DL2=DLOG(2.D0)
	SUM = SUM/DL2
	ENT = -SUM
 
C  BUG CORRECTION DONE FOR m2_19aca.f. ENTROPY CALCULATION MOVED TO
C  AFTER SUM=SUM/DL2 STATEMENT.
 

C  ENTROPY = -INFO = -SUM(PI*LOG(PI)) IS ALSO PRINTED OUT STARTING WITH
C  MXEM2N36.FOR.
 
 
C  SUM IS NOW THE INFO FOR THE JOINT DENSITY. SCALE IT AS SHOWN ABOVE,
C  AND PRINT IT OUT.
 
        DGRID=NGRID

	FACT=100.D0*DL2/DLOG(DGRID/NSUB)
	SUM = FACT*(SUM + DLOG(DGRID)/DL2)

C  REPLACE WRITING OF SUM AND ENT WITH XVERIFY (SEE LOGIC IN SUBROUTINE
C  VERIFYVAL.

      XVERIFY(1) = SUM
      XVERIFY(2) = ENT
      CALL VERIFYVAL(2,XVERIFY)


C     IF(ISUPRES .EQ. 0) WRITE(*,31) SUM
C	IF(ISUPRES .EQ. 0) WRITE(*,131) ENT
 
      IF(ISUPRES .EQ. 0) THEN
       WRITE(*,31) XVERIFY(1)
       WRITE(*,131) XVERIFY(2)
      ENDIF  
   
C	WRITE(25,31) SUM
C	WRITE(25,131) ENT

	WRITE(25,31) XVERIFY(1)
	WRITE(25,131) XVERIFY(2)


   31 FORMAT(/' THE SCALED INFO FOR THIS CYCLE IS ',F10.2,' %'/)
  131 FORMAT(/' THE ENTROPY FOR THIS CYCLE IS ',G11.4/)


 2100   CONTINUE


C  Starting with bigmlt1.f, this is an entry point to pick up needed
c  values.


C  CALCULATE EXPECTED VALUES FOR THIS CYCLE'S UPDATED DENSITY.
 
	DO 1100 I=1,NVAR
 
C  FORM THE VECTOR WORK TO BE THE PRODUCT OF THE COORDINATES OF
C  VARIABLE I (IN COL. I OF CORDEN) AND ITS ASSOCIATED DENSITY (IN
C  COLUMN NVAR+1 OF CORDEN).
 
	DO IG=1,NACTVE
	  WORK(IG)=CORDEN(IG,I)*CORDEN(IG,NVAR+1)
	END DO
 
	II=I
        CALL NOTINT(VOLSPA,NGRID,NACTVE,WORK,MAXGRD,EX(II))
 
	DO 1100 J=1,I
 
C  FORM THE VECTOR WORK TO BE THE PRODUCT OF THE COORDINATES OF
C  VARIABLES I AND J (IN COLS. I AND J OF CORDEN) AND THEIR ASSOCIATED
C  DENSITY (IN COLUMN NVAR+1 OF CORDEN).
 
	DO IG=1,NACTVE
	  WORK(IG)=CORDEN(IG,I)*CORDEN(IG,J)*CORDEN(IG,NVAR+1)
	END DO
 
	JJ=J
 1100   CALL NOTINT(VOLSPA,NGRID,NACTVE,WORK,MAXGRD,E(II,JJ))
 
 
C  STORE THE MEANS INTO CENTER(1,.). CENTER(2,.) AND CENTER(3,.)
C  THE MEDIANS AND MODES WILL BE STORED JUST BELOW THE CALL TO STAT.
C  THE VALUES IN CENTER WILL BE NEEDED BELOW IN THE CALLS TO IDCALCY
C  IF THIS TURNS OUT TO BE THE LAST CYCLE.
 
	 DO I=1,NVAR
	  CENTER(1,I)=EX(I)
	 END DO
 
 
C  CALCULATE THE COVARIANCES; THEN WRITE RESULTS.
 
      DO 190 I=1,NVAR
      DO 190 J=1,I
  190 COV(I,J)=E(I,J)-EX(I)*EX(J)
 
	IF(ISUPRES .EQ. 0)  WRITE(*,*)' THE MEANS ARE: ' 


	WRITE(25,*)' THE MEANS ARE: '
 
	IF(ISUPRES .EQ. 0) WRITE(*,5104) (PAR(I),I=1,NVAR)

	WRITE(25,5104) (PAR(I),I=1,NVAR)
 5104   FORMAT(5X,30(A11,2X))

      DO I = 1,NVAR
       XVERIFY(I) = EX(I)
      END DO
      CALL VERIFYVAL(NVAR,XVERIFY)      

C     IF(ISUPRES .EQ. 0) WRITE(*,5103) (EX(I),I=1,NVAR)
      IF(ISUPRES .EQ. 0) WRITE(*,5103) (XVERIFY(I),I=1,NVAR)


C     WRITE(25,5103) (EX(I),I=1,NVAR)
      WRITE(25,5103) (XVERIFY(I),I=1,NVAR)

 5103   FORMAT(1X,30(G12.6,1X))

C  IN CASE OF VERY SMALL VARIANCES, COV(I,I) COULD TURN OUT TO BE,
C  NUMERICALLY, A SMALL NEGATIVE NO. IN SUCH CASES, SET ALL COV'S
C  = 0 (WHICH MEANS THAT THE STD'S AND COFVR'S WILL ALSO BE SET = 0
C  BELOW), AND SET CORR'S = -99 BELOW. ALSO, SKEWNESS AND KURTOSIS WILL
C  HAVE -99999999 WRITTEN IN THEIR LOCATIONS.

      ICOVL0=0
 
      DO I=1,NVAR
       IF(COV(I,I) .LE. 0.D0) ICOVL0=1
      END DO

      IF(ICOVL0 .EQ. 1) THEN
       DO I = 1,NVAR
        DO J = 1,NVAR
         COV(I,J) = 0.D0
        END DO
       END DO

      ENDIF


	IF(ISUPRES .EQ. 0) WRITE(*,13) 

	WRITE(25,13)
   13 FORMAT(/' THE COV MATRIX IS, IN LOWER TRI FORM: ')
 
	IF(ISUPRES .EQ. 0) WRITE(*,5104) (PAR(I),I=1,NVAR)
	WRITE(25,5104) (PAR(I),I=1,NVAR)
 

      DO 200 I = 1,NVAR

       DO J = 1,I
        XVERIFY(J) = COV(I,J)

       END DO
       CALL VERIFYVAL(I,XVERIFY)



C       WRITE(25,5103) (COV(I,J),J=1,I)
        WRITE(25,5103) (XVERIFY(J),J=1,I)


C 200 IF(ISUPRES .EQ. 0) WRITE(*,5103) (COV(I,J),J=1,I)
  200 IF(ISUPRES .EQ. 0) WRITE(*,5103) (XVERIFY(J),J=1,I)	
	


C  CALCULATE AND PRINT OUT STANDARD DEVIATIONS, COEFFICIENTS OF
C  VARIATION, AND CORRELATION COEFFICIENTS.
 

      DO I = 1,NVAR


       STD(I)=DSQRT(COV(I,I))
       COFVR(I)=STD(I)*1.D2/EX(I)

        DO J = 1,I
         IF(ICOVL0 .EQ. 0) CORR(I,J) = COV(I,J)/STD(I)/STD(J)
         IF(ICOVL0 .EQ. 1) CORR(I,J) = -99.D0
        END DO


      END DO


      DO I = 1,NVAR
       XVERIFY(I) = STD(I)
      END DO
      CALL VERIFYVAL(NVAR,XVERIFY)      


	IF(ISUPRES .EQ. 0) WRITE(*,6071)
	WRITE(25,6071)
 6071 FORMAT(/' THE STANDARD DEVIATIONS ARE, RESPECTIVELY: ')
 
	IF(ISUPRES .EQ. 0) WRITE(*,5104) (PAR(I),I=1,NVAR)
	WRITE(25,5104) (PAR(I),I=1,NVAR)
 
C     IF(ISUPRES .EQ. 0) WRITE(*,5103) (STD(I),I=1,NVAR)


      IF(ISUPRES .EQ. 0) WRITE(*,5103) (XVERIFY(I),I=1,NVAR)
C     WRITE(25,5103) (STD(I),I=1,NVAR)
      WRITE(25,5103) (XVERIFY(I),I=1,NVAR)
 

      DO I = 1,NVAR
       XVERIFY(I) = COFVR(I)
      END DO
      CALL VERIFYVAL(NVAR,XVERIFY)
      


	IF(ISUPRES .EQ. 0) WRITE(*,6072)
	WRITE(25,6072)
 6072 FORMAT(/' THE PERCENT COEFFICIENTS OF VARIATION ARE, RESP.: ')
 
	IF(ISUPRES .EQ. 0) WRITE(*,5104) (PAR(I),I=1,NVAR)
	WRITE(25,5104) (PAR(I),I=1,NVAR)
 


C     IF(ISUPRES .EQ. 0) WRITE(*,5103) (COFVR(I),I=1,NVAR)
      IF(ISUPRES .EQ. 0) WRITE(*,5103) (XVERIFY(I),I=1,NVAR)


C     WRITE(25,5103) (COFVR(I),I=1,NVAR)
      WRITE(25,5103) (XVERIFY(I),I=1,NVAR)
 
	IF(ISUPRES .EQ. 0) WRITE(*,6073)
	WRITE(25,6073)
 6073 FORMAT(/' THE CORR. MATRIX IS, IN LOWER TRIANGULAR FORM: ')
 
	IF(ISUPRES .EQ. 0) WRITE(*,5104) (PAR(I),I=1,NVAR)
	WRITE(25,5104) (PAR(I),I=1,NVAR)


      DO 6080 I=1,NVAR

       DO J = 1,I
        XVERIFY(J) = CORR(I,J)
       END DO
       CALL VERIFYVAL(I,XVERIFY)



C      WRITE(25,5103) (CORR(I,J),J=1,I)
       WRITE(25,5103) (XVERIFY(J),J=1,I)


C6080   IF(ISUPRES .EQ. 0) WRITE(*,5103) (CORR(I,J),J=1,I)
 6080   IF(ISUPRES .EQ. 0) WRITE(*,5103) (XVERIFY(J),J=1,I)
 

	IF(ISUPRES .EQ. 0) WRITE(*,6091) NVAR
	WRITE(25,6091) NVAR
 6091   FORMAT(//' THE ',I2,' SETS OF LINES BELOW WILL GIVE ADDITIONAL'/
     1' STATISTICS FOR THE VARIABLES. FOR EACH SET:'//
     2' THE 1ST LINE WILL GIVE THE MODE, THE SKEWNESS, THE KURTOSIS,'/
     3' AND THE 2.5 %-TILE VALUE OF THE DISTRIBUTION. '//
     4' THE 2ND LINE WILL GIVE THE 25, 50, 75, AND 97.5 %-TILE VALUES'/
     5' OF THE DISTRIBUTION. '//
     6' THE 3RD LINE WILL GIVE THREE ADDITIONAL AD-HOC ESTIMATES OF'/
     7' THE STANDARD DEVIATION FOR THAT MARGINAL DENSITY. THE 1ST S.D.'/
     7' ESTIMATE IS THE STANDARD DEVIATION OF A NORMAL DISTRIBUTION '/
     8' HAVING THE SAME [25, 75] %-TILE RANGE AS THAT VARIABLE. THE'/
     9' 2ND ESTIMATE IS THE STANDARD DEVIATION OF A NORMAL DIST.'/
     1' HAVING THE SAME [2.5, 97.5] %-TILE RANGE AS THAT VARIABLE. THE'/
     2' 3RD ESTIMATE IS THE AVERAGE OF THE FIRST TWO. THE 4TH VALUE'/
     3' IN THE LINE IS THE THE % SCALED INFO FOR THAT MARGINAL DENS.'//)
 
C  CALC. THE MODE (XMODE) AND 5 %-TILE VALUES (X025,X25,X50,X75,X975)
C  FOR EACH VARIABLE (NOTE THAT X50 IS THE MEDIAN). ALSO, CALCULATE
C  SCALINFO, THE SCALED INFORMATION FOR EACH MARGINAL DENSITY.

 
	DO 6090 I=1,NVAR

 
	IND=I
 
C  NOTE: IN THE CALL TO STAT, THE ARGUMENT WORK IS A DUMMY ARRAY; IT
C        MUST BE AN AN ARGUMENT SINCE IT IS VARIABLY DIMENSIONED IN

C        STAT.
 
	CALL STAZ(VOLSPA,NGRID,NACTVE,NVAR,IND,CORDEN,WORK,MAXGRD,NINT,
     1  AB(IND,1),AB(IND,2),XMODE,X025,X25,X50,X75,X975,SCALINFO,NSUB,
     2  MAXDIM)
 
C  STORE THE MEDIANS AND MODES IN CASE THIS IS THE LAST CYCLE (IN WHICH
C  CASE THEY WILL BE NEEDED BELOW IN CALLS TO IDCALCY.
 
	CENTER(2,IND)=X50
	CENTER(3,IND)=XMODE

C  THE 1ST 'AD-HOC' ESTIMATE OF THE STD. DEV. IS THAT OF A NORMAL DIST.
C  HAVING THE SAME [25, 75] %-TILE RANGE AS THIS VARIABLE. SINCE 50 % OF
C  A STANDARD NORMAL DIST. IS BETWEEN MU +/- .6745*SD, THE INNER
C  50 %-TILE RANGE IS APPROX. 1.349*SD WIDE. I.E., SD IS APPROX.
C  (X75-X25)/1.349.
 
C  SIMILARLY, THE 2ND ESTIMATE OF THE SD IS THAT OF A NORMAL DIST.
C  HAVING THE SAME [2.5, 97.5] %-TILE RANGE AS THIS VARIABLE. IN THIS
C  CASE THE SD APPROX = (X975-X025)/3.92.
 
	SDEST1 = (X75-X25)/1.349
	SDEST2 = (X975-X025)/3.92
	SDEST3 = .5D0*(SDEST1+SDEST2)
 
C  CALCULATE KURTOSIS AND SKEWNESS FOR EACH VARIABLE.
C
C  THE COEFF OF SKEWNESS = EXP[(X-EXP(X))**3]/STDX**3, WHERE STDX IS
C                             THE STD DEV OF X.

C
C  SKEWNESS IS > 0 IF THE DISTRIBUTION SKEWS (EXTENDS OUT) TO THE RIGHT.
C  SKEWNESS IS < 0 IF THE DISTRIBUTION SKEWS (EXTENDS OUT) TO THE LEFT.
C  SKEWNESS IS = 0 IF THE DISTRIBUTION IS SYMMETRIC.
C
C  THE COEFF OF KURTOSIS = EXP[(X-EXP(X))**4]/STDX**4.

C
C  KURTOSIS = 3 IF THE DISTRIBUTION IS NORMAL.
C  KURTOSIS > 3 IF THE DISTRIBUTION IS MORE PEAKED THAN THE NORMAL DIST.
C  KURTOSIS < 3 IF THE DISTRIBUTION IS LESS PEAKED THAN THE NORMAL DIST.
C
C  FORM THE VECTOR WORK TO BE (X(I)-EXI)**3*CORDEN(I,NVAR+1), WHERE
C  EXI IS THE EXPECTED VALUE FOR VARIABLE I. THEN INTEGRATE IT TO
C  GET THE NUMERATOR OF SKEWNESS. THEN DO THE SAME FOR THE NUMERATOR
C  OF KURTOSIS, EXCEPT THE EXPONENT IS 4 INSTEAD OF 3.
 
C  NOTE: IF ICOVL0 = 1, STD'S HAVE NOT BEEN CALCULATED ABOVE (SINCE AT
C 	 LEAST 1 COV(I,I) WAS NUMERICALLY .LE. 0). IN SUCH A CASE,
C 	 ARBITRARILY SET SK AND KU = -99999999.
 
	IF(ICOVL0 .EQ. 1) THEN
	  SK = -99999999
	  KU = -99999999
	ENDIF
 
	IF(ICOVL0 .EQ. 0) THEN
 
      DO IG=1,NACTVE
       XX = CORDEN(IG,IND)
       WORK(IG) = CORDEN(IG,NVAR+1)*(XX-EX(IND))**3
      END DO
 
      CALL NOTINT(VOLSPA,NGRID,NACTVE,WORK,MAXGRD,SK)
      SK=SK/STD(I)**3
 
	DO IG=1,NACTVE
	  XX = CORDEN(IG,IND)
        WORK(IG) = CORDEN(IG,NVAR+1)*(XX-EX(IND))**4
	END DO

 
      CALL NOTINT(VOLSPA,NGRID,NACTVE,WORK,MAXGRD,KU)
      KU=KU/STD(I)**4
 
	ENDIF

C  THE ABOVE ENDIF IS FOR THE  IF(ICOVL0 .EQ. 1)  CONDITION.

 
	IF(ISUPRES .EQ. 0) WRITE(*,6092) PAR(IND)
	WRITE(25,6092) PAR(IND)
 6092 FORMAT(/' ',A11,':')
 

       XVERIFY(1) = XMODE
       XVERIFY(2) = SK
       XVERIFY(3) = KU   
       XVERIFY(4) = X025
       CALL VERIFYVAL(4,XVERIFY)



C      IF(ISUPRES .EQ. 0) WRITE(*,6093) XMODE,SK,KU,X025
       IF(ISUPRES .EQ. 0) WRITE(*,6093) (XVERIFY(IXV),IXV=1,4) 

C      WRITE(25,6093) XMODE,SK,KU,X025
       WRITE(25,6093) (XVERIFY(IXV),IXV=1,4) 



       XVERIFY(1) = X25
       XVERIFY(2) = X50
       XVERIFY(3) = X75  
       XVERIFY(4) = X975
       CALL VERIFYVAL(4,XVERIFY)

C      IF(ISUPRES .EQ. 0) WRITE(*,6093) X25,X50,X75,X975
       IF(ISUPRES .EQ. 0) WRITE(*,6093) (XVERIFY(IXV),IXV=1,4) 

C      WRITE(25,6093) X25,X50,X75,X975
       WRITE(25,6093) (XVERIFY(IXV),IXV=1,4) 

       XVERIFY(1) = SDEST1
       XVERIFY(2) = SDEST2
       XVERIFY(3) = SDEST3

       XVERIFY(4) = SCALINFO
       CALL VERIFYVAL(4,XVERIFY)



C      IF(ISUPRES .EQ. 0) WRITE(*,6093) SDEST1,SDEST2,SDEST3,SCALINFO
       IF(ISUPRES .EQ. 0) WRITE(*,6093) (XVERIFY(IXV),IXV=1,4) 

C      WRITE(25,6093) SDEST1,SDEST2,SDEST3,SCALINFO
       WRITE(25,6093) (XVERIFY(IXV),IXV=1,4)
 6093 FORMAT(1X,4(G15.8,2X))

       XMED(IND) = X50


 6090  CONTINUE



	IF(ISUPRES .EQ. 0) WRITE(*,*)

	WRITE(25,*)

C  WRITE IERRMOD AND GAMLAM TO FILE 25. NOTE THAT FOR IERRMOD = 1,
C  GAMMA WAS NOT ESTIMATED, SO USE A VALUE OF -99 FOR GAMMA.

	IF(IERRMOD .EQ. 1) GAMLAM = -99.D0
	IF(IERRMOD .EQ. 2) GAMLAM = GAMMA
	IF(IERRMOD .EQ. 3) GAMLAM = GAMMA
	IF(IERRMOD .EQ. 4) GAMLAM = FLAT*GAMMA
        WRITE(25,5454) 
 5454   FORMAT(/' IERRMOD AND THE ESTIMATE FOR GAMLAM ARE: ')
	WRITE(25,*) IERRMOD, GAMLAM
	IF(IERRMOD .EQ. 1) WRITE(25,5456)
 5456    FORMAT(/' WHICH MEANS THAT GAMMA WAS NOT ESTIMATED IN THIS RUN.
     1 ')



      IF(NRANFIX .GT. 0 .AND. ICYCLE .EQ. 1) THEN


C  IF NRANFIX .GT. 0, CALL ELDERY TO GET UPDATED ESTIMATES FOR THESE
C  NRANFIX PARAMETERS WHICH ARE UNKNOWN BUT THE SAME FOR ALL SUBJECTS.
C  ALSO AS OF npagranfix2.f., INCLUDE THE NVAR RANDOM VARIABLES AS 
C  PARAMETERS WHOSE NEW ESTIMATES WILL BE FOUND BY ELDERY. THE
C  INITIAL ESTIMATES FOR THESE PARAMETERS WILL BE THEIR CURRENT CYCLE
C  MEANS. NOTE THAT THIS WILL ONLY BE DONE AT END OF CYCLE NO. 1.

C  PREPARE TO CALL ELDERY. 

C  SET EACH RANDOM PARAMETER = ITS MEAN VALUE AND EACH FIXED PARAMETER
C  = ITS VALUE IN VALFIX.

      DO I = 1,NVAR
       X(I) = EX(I)
      END DO

      CALL MAKEVEC(NVAR,NOFIX,NRANFIX,IRAN,X,VALFIX,RANFIXEST,PX)

C  NOTE THAT PX NOW INCLUDES THE VALUES OF THE RANDOM PARAMETERS (SET
C  = TO THEIR MEANS FROM THE JUST COMPLETED CYCLE) AND THE FIXED 
C  PARAMETER VALUES. AND IT ALSO HAS THE VALUES IN RANFIXEST(.) IN THE
C  APPROPRIATE NRANFIX ENTRIES (I.E., FOR THOSE PARAMETERS WITH 
C  IRAN(.) = 2), BUT THESE LAST VALUES OF COURSE WILL BE RESET IN 
C  SUBROUTINE CALCRF EACH TIME IT IS CALLED BY ELDERY WITH ANOTHER SET 
C  OF VALUES SUPPLIED IN THE CANDIDATE VECTOR, VEC(.). AND, AS OF
C  npagranfix2.f., THE NVAR PARAMETER VALUES FOR THE RANDOM VARIABLES
C  WILL ALSO BE RESET IN SUBROUTINE CALCRF TO THEIR CANDIDATE VALUES
C  FROM VEC(.).

C  TO START THE PROCESS TO FIND THE BEST ESTIMATES FOR THE NRANFIX
C  PARAMETERS WITH IRAN(.) = 2, SINCE THE CURRENT ESTIMATES FOR THESE 
C  PARAMETERS ARE IN RANFIXEST(.), I=1,NRANFIX, THESE WILL BE THE 
C  STARTING ESTIMATES FOR THIS CALL TO ELDERY.

C  ALSO, AS OF npagranfix2.f., THE INITIAL ESTIMATES FOR THE NVAR
C  RANDOM VARIABLES WILL BE THE MEANS FROM THE JUST COMPLETED CYCLE.

       DO I = 1,NRANFIX
        START(I) = RANFIXEST(I)
        STEP(I) = -.2D0*START(I)
       END DO

       DO I = NRANFIX+1,NRANFIX+NVAR
        START(I) = EX(I-NRANFIX)
        STEP(I) = -.2D0*START(I)
       END DO


       CALL ELDERY(NRANFIX+NVAR,START,OPTVAR,VALMIN,1.D-10,STEP,1000,
     1  CALCRF,0,ICONV,NITER,ICNT,NUMEQT,YO,C0,C1,C2,C3)

C  OPTVAR(I),I=1,NRANFIX+NVAR = THE UPDATED SET OF ESTIMATES FOR THE
C    NRANFIX PARAMETERS WITH IRAN(.) = 2, AND THE NVAR PARAMETERS WITH

C    IRAN(.) = 1 (SEE ABOVE). 

C  VALMIN = MIN. VALUE OF FUNCTION ACHIEVED.

C  ICONV = 1 IF THE ESTIMATE CONVERGED; 0 OTHERWISE.


	IF(ICONV .EQ. 0 .AND. ISUPRES .EQ. 0) WRITE(*,9011) 
	IF(ICONV .EQ. 0) WRITE(25,9011) 
 9011 FORMAT(' ',' NO CONVERGENCE THIS CYCLE ON ESTIMATES FOR THE'/
     1' RANFIX AND RANDOM PARAMETERS. '/)
 
 
C  ESTABLISH THE NEW SET OF RANFIX AND RANDOM VARIABLES.

       DO I = 1,NRANFIX
        RANFIXEST(I) = OPTVAR(I)
       END DO

       DO I = NRANFIX+1,NRANFIX+NVAR
        EXO(I-NRANFIX) = OPTVAR(I)
       END DO


C  RESET THE VALUES IN CORDEN TO REFLECT THE FACT THAT THE MEANS OF
C  THE NVAR RANDOM VARIABLES SHOULD NOW BE EXO(.) RATHER THAN EX(.).
C  SO 

       DO J = 1,NVAR
        DO IG = 1,NACTVE
         CORDEN(IG,J) = CORDEN(IG,J)*EXO(J)/EX(J)
        END DO
       END DO


C  WRITE THE ESTIMATES FOR THESE NRANFIX RANFIX PARAMETERS FOR THIS 
C  CYCLE, AS WELL AS FOR THE REVISED NVAR RANDOM PARAMETERS.


	IF(ISUPRES .EQ. 0)  WRITE(*,9012) NRANFIX
	WRITE(25,9012) NRANFIX

 9012 FORMAT(//' FOR THIS CYCLE, THE ESTIMATES FOR THE ',I2,' PARAMETERS
     1'/
     2' WHICH ARE UNKNOWN BUT THE SAME FOR ALL SUBJECTS ARE: ')

	IF(ISUPRES .EQ. 0) WRITE(*,5104) (PARRANFIX(I),I=1,NRANFIX)

	WRITE(25,5104) (PARRANFIX(I),I=1,NRANFIX)
 
      DO I = 1,NRANFIX
       XVERIFY(I) = RANFIXEST(I)
      END DO
      CALL VERIFYVAL(NRANFIX,XVERIFY)      

      IF(ISUPRES .EQ. 0) WRITE(*,5103) (XVERIFY(I),I=1,NRANFIX)
      WRITE(25,5103) (XVERIFY(I),I=1,NRANFIX)


      IF(ISUPRES .EQ. 0)  WRITE(*,9013) NVAR
      WRITE(25,9013) NVAR

 9013 FORMAT(//' FOR THIS CYCLE, THE REVISED MEANS FOR THE ',I2,/
     1' RANDOM PARAMETERS ARE: ')

	IF(ISUPRES .EQ. 0) WRITE(*,5104) (PAR(I),I=1,NVAR)
	WRITE(25,5104) (PAR(I),I=1,NVAR)
 
      DO I = 1,NVAR
       XVERIFY(I) = EXO(I)
      END DO
      CALL VERIFYVAL(NVAR,XVERIFY)      

      IF(ISUPRES .EQ. 0) WRITE(*,5103) (XVERIFY(I),I=1,NVAR)
      WRITE(25,5103) (XVERIFY(I),I=1,NVAR)


      ENDIF
C  ABOVE ENDIF IS FOR THE  IF(NRANFIX .GT. 0 .AND. NRANFIX .EQ. 1)
C    CONDITION.




	IF(MAXCYC .EQ. 0) GO TO 900

C  Starting with bigmlt1.f, this is a jump point.


cend statistics


cbegin control
c we are now done wtih statistics - this is the best place to
c check for whether we can exit - if so , last printed statistic
c will agree with current density corden, and corden is still
c correct (e.g. after condensation-expansion, it is no longer
c correct until we call emint again)
cint.9 control section to check for exit criteria, resolution 
c  refinement, and end of major cycles

cint9.a  first, we exit if we have reached maxcyc on cycle counter

C  SET IMAXCYC = 0; IF IT CHANGES TO 1, IT MEANS THAT MAXCYC CYCLES
C  HAVE BEEN RUN, AND THE PROGRAM WILL STOP.

        IMAXCYC = 0

      if(icycle .ge. maxcyc) then


C  IF ICONTIN = 0, IT MEANS THE USER EXECUTED THE BATCH FILE,
C  CHMAXCYC.BAT TO STOP THE PROGRAM PREMATURELY (BY RESETTING MAXCYC
C  TO BE = THE CURRENT VALUE OF ICYCLE). IN THIS CASE, WRITE A
C  COMMENT TO FILE 25 AND TO THE SCREEN.

	IF(ICONTIN .EQ. 0) THEN
	 WRITE(25,1261) MAXCYC,MAXCYC0

 1261    FORMAT(/' THE USER CHOSE TO STOP THE PROGRAM AT CYCLE NO. '/
     1' ',I7,' ... THE ORIGINAL NO. OF MAXIMUM CYCLES WAS ',I7//)
	 WRITE(*,1261) MAXCYC,MAXCYC0
C	 CALL PAUSE
	ENDIF

C  SET IMAXCYC = 1 --> MAXCYC WAS REACHED.

        IMAXCYC = 1

C  COMMENT OUT THE GO TO 900 STATEMENT BELOW SINCE EVEN IF ICYCLE
C  = MAXCYC, THE PROGRAM STILL NEEDS TO TEST TO SEE IF CONVERGENCE
C  WAS ACHIEVED IN THE FINAL CYCLE.
C      go to 900

      endif

c  The above endif is for the  if(icycle .ge. maxcyc)  condition.


C  SET ICONVERG = 0; IF IT CHANGES TO 1, IT MEANS THAT CONVERGENCE HAS
C  BEEN ACHIEVED, AND THE PROGRAM WILL STOP.

        ICONVERG = 0

cint9.b  second, we check improvement from last cycle




      ximprove=fobj-prefobj

       XVERIFY(1) = fobj1
       XVERIFY(2) = gamma*flat
       XVERIFY(3) = resolve
       CALL VERIFYVAL(3,XVERIFY)



C      write(91,9191) icycle,fobj1,gamma*flat,resolve,
       write(91,9191) icycle,(XVERIFY(IXV),IXV=1,3),
     &nactve1,nactve0
 9191 format(i5,2f15.6,5x,f8.5,5x,2i5)

      IF(ISUPRES .EQ. 0) 
     1 write(6,*) 'icycle=',icycle,' fobj=',fobj,' resolution=',resolve
      IF(ISUPRES .EQ. 0) 

     1 write(6,*) 'improvement from last cycle =',ximprove
      IF(ISUPRES .EQ. 0 .AND. ierrmod.eq.2) 
     1 write(6,*) 'current gamma=',gamma
      IF(ISUPRES .EQ. 0 .AND. ierrmod.eq.3) 
     1 write(6,*) 'current additive lambda=',gamma
      IF(ISUPRES .EQ. 0 .AND. ierrmod.eq.4) 
     1 write(6,*) 'current flat weight = ',flat*gamma

      prefobj = fobj

cint9.c if ximprove is too low, refine the resolve criterion

      if(dabs(ximprove) .le. tol .and. resolve .gt. 0.0001) then
        resolve=resolve*0.5
      endif

cint9.d check to see if resolve bottoms out - if so, start a new
c major cycle by resetting it to its highest allowable value, or


c exit if the improvment from the last major cycle is too small ...

C  AND EXIT IF IMAXCYC = 1 (SEE ABOVE; THIS MEANS THAT THE MAX. NO.
C  OF CYCLES HAS ALREADY BEEN RUN AND THE ONLY REASON THIS PART OF THE
C  CODE IS BEING RUN IS TO SEE IF CONVERGENCE WAS ACHIEVED IN THE FINAL
C  CYCLE.

      if(resolve.le.0.0001) then


c      saveres = resolve
        resolve=0.2
        checkbig = fobj - prebig
      write(91,*) 'res set to .2 ',' checkbig=',checkbig
        prebig =fobj

C  PRINT OUT THE ONE LINE OF INFO IF ISUPRES = 1. NOTE THAT THE 
C  CONVERGENCE CRITERION IS THAT DABS(CHECKBIG) .LE. TOLC. ALSO NOTE
C  THAT XMED(I) ARE THE MEDIANS FROM THE JUST COMPLETED CYCLE.

	IF(ISUPRES .EQ. 1) THEN



	 WRITE(*,1023) ICYCLE
 1023    FORMAT(/' FOR CYCLE NO, ',I6,' THE CONVERGENCE CRITERION AND ME
     1DIANS ARE: ')

       XVERIFY(1) = checkbig
       XVERIFY(2) = TOLC
       CALL VERIFYVAL(2,XVERIFY)



C      WRITE(*,1024) DABS(checkbig),TOLC
       WRITE(*,1024) DABS(XVERIFY(1)),XVERIFY(2)
 1024    FORMAT(1X,G14.4,' <-- CONVERGENCE OCCURS WHEN THIS NO. < ',F20.
     117)
	 WRITE(*,5104) (PAR(I),I=1,NVAR)

       DO I = 1,NVAR
        XVERIFY(I) = XMED(I)
       END DO
       CALL VERIFYVAL(NVAR,XVERIFY) 
     



C      WRITE(*,5103) (XMED(I),I=1,NVAR)
       WRITE(*,5103) (XVERIFY(IXV),IXV=1,NVAR)



	ENDIF

c  As of npageng23.f, the tolerance value against which checkbig is
c  compared is now longer hardcoded to be .01. Instead it is input
c  from npag102.inp (now npag103.inp) as TOLC.

        if(dabs(checkbig) .le. TOLC) then

C  SET ICONVERG = 1 --> CONVERGENCE WAS ACHIEVED.

        ICONVERG = 1

          go to 900

        endif

      endif

c  above endif is for the  if(resolve .le. .0001)  condition.


C  IF IMAXCYC = 1, THE MAX. NO. OF CYCLES HAVE ALREADY BEEN RUN -->
C  GO TO 900. THE ONLY REASON THIS PART OF THE CODE WAS BEING RUN IS TO


C  SEE IF CONVERGENCE WAS ACHIEVED IN THIS FINAL CYCLE, AND THAT WAS
C  JUST TESTED ABOVE (SEE ICONVERG CODE).
 
        IF(IMAXCYC .EQ. 1) GO TO 900


cend control
cbegin expansion


      IF(ISUPRES .EQ. 0) write(6,*) 'Number of active points =', nactve
c now add more points near the current solution

      IF(ISUPRES .EQ. 0) write(6,*)
      IF(ISUPRES .EQ. 0) 
     1 write(6,*) 'expanding current grid with new points'
      IF(ISUPRES .EQ. 0) write(6,5200) 100.*resolve

 5200 format(' current grid resolution = ',f8.3, '%')
         new=2*nvar+1

         nactveold=nactve

         do ipoint=1,nactveold
c first, divide current probability into 2*nvar+1 pieces

           pcur=corden(ipoint,nvar+1)/(2*nvar+1)
c update original point
           corden(ipoint,nvar+1)=pcur

             do ivar=1,nvar
	       del=(ab(ivar,2)-ab(ivar,1))*resolve
c create first new trial point at -eps in coordinate ivar
               do i=1,nvar
                  corden(nactve+1,i)=corden(ipoint,i)
	       enddo
	       corden(nactve+1,ivar)=corden(nactve+1,ivar)-del
               corden(nactve+1,nvar+1)=pcur
               ntry=nactve+1
c icheck that new point is at least minimally distant from old points

               call checkd(corden,ntry,nactve,ab,maxgrd,nvar,iclose)
c only keep trial lower point if it lies above lower bound and satisfies
c minimal distance requirement
	       if(corden(nactve+1,ivar).ge.ab(ivar,1)) then

                if(iclose.eq.0) nactve=nactve+1
	       endif
c now create second trail point at +eps in coordinate ivar
               do i=1,nvar
                 corden(nactve+1,i)=corden(ipoint,i)
	       enddo
	       corden(nactve+1,ivar)=corden(nactve+1,ivar)+del
               corden(nactve+1,nvar+1)=pcur
c only keep upper point if it lies below upper bound and
c satisfies distance requirement
               ntry=nactve+1
               call checkd(corden,ntry,nactve,ab,maxgrd,nvar,iclose)
	       if(corden(nactve+1,ivar).le.ab(ivar,2)) then

	         if(iclose.eq.0) nactve=nactve+1

               endif
             enddo
c    above enddo for loop over ivar=1,nvar

           enddo
c    above enddo for loop over ipoint=1,nactveold


      IF(ISUPRES .EQ. 0) 
     1 write(6,*) 'Number of actve grid points after expansion =',nactve
      ngridn=nactve
      IF(ISUPRES .EQ. 0) write(6,*)

cend expansion
c go to begin new cycle

        prefobj=fobj


        GO TO 1001
 
  900 continue


c  As of npagranfix2.f, write the estimates for the parameters which are
c  unknown but the same for all subjects, if applicable. Note that 
c  these estimates were obtained only after cycle no. 1 and are now
c  written out again at the end of the run.

      IF(NRANFIX .GT. 0) THEN

       DO I = 1,NRANFIX
        XVERIFY(I) = RANFIXEST(I)
       END DO
       CALL VERIFYVAL(NRANFIX,XVERIFY) 

       WRITE(25,9014) NRANFIX

 9014 FORMAT(//' THE ESTIMATES FOR THE ',I2,' PARAMETERS WHICH ARE '/
     1' UNKNOWN BUT THE SAME FOR ALL SUBJECTS, AND WERE FOUND AT THE'/
     2' END OF CYCLE NO. 1, ARE: ')

       WRITE(25,5104) (PARRANFIX(I),I=1,NRANFIX)
       WRITE(25,5103) (XVERIFY(I),I=1,NRANFIX)


       IF(ISUPRES .EQ. 0) THEN
        WRITE(*,9014) NRANFIX
        WRITE(*,5104) (PARRANFIX(I),I=1,NRANFIX)
        WRITE(*,5103) (XVERIFY(I),I=1,NRANFIX)
       ENDIF

      ENDIF
C  THE ABOVE ENDIF IS FOR THE  IF(NRANFIX .GT. 0)  CONDITION.



C  AS OF npageng18.f, CONTROL CAN BE TRANSFERRED TO LABEL 900 DIRECTLY
C  AFTER RETURNING FROM A CALL TO SUBROUTINE emint. THIS HAPPENS WHEN
C  IHESS = -1, WHICH MEANS THAT THE HESSIAN MATRIX IN THE INTERIOR
C  POINT EM ALGORITHM WAS SINGULAR. RATHER THAN SIMPLY STOPPING AS IT
C  DID PREVIOUSLY, NOW THE PROGRAM WILL CREATE THE OUTPUT FILES BEFORE
C  STOPPING ... BASED ON THE VALUES FROM THE PREVIOUS CYCLE.
C  FIRST, WRITE THE REASON FOR STOPPING AS ICONVERGE = 3 BELOW. THEN
C  RESET CORDEN BACK TO CORDLAST (SEE ABOVE), WHICH WAS THE CORDEN
C  AT THE END OF THE PREVIOUS CYCLE.


C  WRITE WHY THE PROGRAM STOPPED.

        WRITE(25,5197)
 5197   FORMAT(//' THIS RUN STOPPED WITH ICONVERGE = ')

        IF(IHESS .EQ. -1) THEN

         WRITE(25,6002)
 6002    FORMAT(' 3 <-- THE PROGRAM STOPPED DUE TO HESSIAN ERROR.')


         NACTVE = NACTLAST

         DO I = 1,NACTVE
          DO J = 1,NVAR+1
           CORDEN(I,J) = CORDLAST(I,J)

          END DO
         END DO

         GO TO 910

        ENDIF



        IF(ICONVERG .EQ. 1 .AND. IMAXCYC .EQ. 1) WRITE(25,5198)
 5198   FORMAT(' 2 <-- THE PROGRAM CONVERGED AT MAXCYC CYCLES.')
        IF(ICONVERG .EQ. 1 .AND. IMAXCYC .EQ. 0) WRITE(25,5199)
 5199   FORMAT(' 1 <-- THE PROGRAM CONVERGED PRIOR TO MAXCYC CYCLES.')
        IF(ICONVERG .EQ. 0 .AND. IMAXCYC .EQ. 1) WRITE(25,6001)
 6001   FORMAT(' 0 <-- THE PROGRAM RAN MAXCYC CYCLES WITHOUT CONVERGING.
     1')


C  Starting with bigmlt1.f, this is an entry point to continue 
c  calculations


  910 CONTINUE


cbegin endgame
c we can only arrive here from the control section, which menas
c that we ahve completed optimizaiton but not done the subsequent
c expansion.  This means that the density is correct, and we can safely
c just write it out and exit


C  SINCE THE ANALYSIS IS OVER:
C  ESTABLISH THREE VECTORS, YPREDPOP, YPREDPOPT, AND YPREDBAY, WHICH 
C  WILL BE STORED INTO THE DENSITY FILE FOR USE BY THE PC PROGRAM.
 
C  ESTABLISH YPREDPOP(MAXSUB,NUMEQT,MAXOBS,3), WHERE

C  YPREDPOP(JSUB,J,IOBS,ICEN) = THE PREDICTED VALUE FOR SUBJECT
C  JSUB, OUTPUT EQ. J, OBSERVATION IOBS, AND ICEN (ICEN = 1 (MEANS),
C  2 (MEDIANS), AND 3 (MODES), WHERE THE MEANS, MEDIANS, AND MODES ARE
C  FROM THE FINAL CYCLE POPULATION DENSITY).

C  ESTABLISH YPREDPOPT(MAXSUB,NUMEQT,7201,3), WHERE

C  YPREDPOPT(JSUB,J,T,ICEN) = THE PREDICTED VALUE FOR SUBJECT
C  JSUB, OUTPUT EQ. J, AT TIME T, AND ICEN (ICEN = 1 (MEANS),
C  2 (MEDIANS), AND 3 (MODES), WHERE THE MEANS, MEDIANS, AND MODES ARE
C  FROM THE FINAL CYCLE POPULATION DENSITY), AND T IS A VALUE IN
C  TPRED, ESTABLISHED IN THE CALL TO CALCTPRED - SEE BELOW.

C  ESTABLISH YPREDBAY(MAXSUB,NUMEQT,MAXOBS,3), WHERE
C  YPREDBAY(JSUB,J,IOBS,ICEN) = THE PREDICTED VALUE FOR SUBJECT
C  JSUB, OUTPUT EQ. J, OBSERVATION IOBS, AND ICEN (ICEN = 1 (MEANS),
C  2 (MEDIANS), AND 3 (MODES), WHERE THE MEANS, MEDIANS AND MODES ARE
C  FROM SUBJECT'S JSUB BAYSESIAN POSTERIOR DENSITY (CALCULATED BY
C  SUBROUTINE SUBRES)).
 

C  ALSO, ESTABLISH PREDICTED VALUES SIMILAR TO YPREDBAY, BUT WHICH WILL
C  BE AT TIMES SPECIFIED BY IDELTA (SEE SUBROUTINE CALCTPRED) AND ONLY 
C  AT ONE SET OF PARAMETER VALUES (MEANS, MEDIANS, OR MODES OF THE 
C  BAYESIAN POSTERIOR DIST.) SPECIFIED BY ICENT (SEE DETAILS IN TOP OF 
C  CODE FOR m2_8calc.f). THESE VALUES WILL BE PUT INTO FILE PREDFIL. IN 
C  ADDITION, CALCULATE TOTAL AND 24 HOUR AUC'S AND AUC/MIC'S, WHICH WILL 

C  BE PUT INTO THE OUTPUT FILE, ACCOMPANYING EACH SUBJECT'S BAYESIAN 
C  POSTERIOR INFO.
C!! NO. AS OF npageng25.f, BOTH THE PREDICTED VALUES PUT INTO PREDFIL,
C  AND THE AUCs WILL BE CALCULATED FOR ALL OF THE MEANS, MEDIANS, AND
C  MODES (I.E., ICENT IS NO LONGER USED).

 
C 1ST CALCULATE YPREDPOP AND YPREDPOPT VALUES.
 
	REWIND(27)

 
C  FOR EACH SUBJECT, FIND THE PREDICTED VALUES (VIA SUBROUTINE IDCALCY
C  FOR YPREDPOP, AND VIA IDCALCYY FOR YPREDPOPT).
 
C  NOTE THAT THE LAST CYCLE'S MEANS ARE IN   CENTER(1,J), J = 1,NVAR;
C                             MEDIANS ARE IN CENTER(2,J), J = 1,NVAR;
C			            MODES ARE IN   CENTER(3,J), J = 1,NVAR.
 


	DO 6000 JSUB=1,NSUB
 
 
	CALL FILRED(NOBSER,YO,C0,C1,C2,C3,NUMEQT)


	DO ICENTER = 1,3
 

	 DO J=1,NVAR
	  EXXX(J) = CENTER(ICENTER,J)	
	 END DO

C  FIND YPREDPOP FIRST:  
C  CALL SUBROUTINE IDCALCY, A VERSION OF THE ID PROGRAM WHICH SIMPLY
C  CALCULATES THE PREDICTED VALUES OF YO(I,J) = OUTPUT CONCENTRATION OF
C  THE JTH OUTPUT EQUATION (J=1,NUMEQT) AT THE ITH OBSERVATION TIME
C  (I=1,NOBSER), ASSUMING THE PARAMETER VECTOR EXXX ...
 

C  BEFORE ALL CALLS TO IDCALCY, MUST INTEGRATE FIXED AND RANDOM
C  VALUES INTO PX, USING IRAN(I),I=1,NVAR+NOFIX. CALL MAKEVEC TO DO
C  THIS. AS OF npagranfix.f, ADD NRANFIX AND RANFIXEST
C  TO THE ARGUMENT LIST TOO (I.E., THERE IS NOW A 3RD TYPE OF 
C  PARAMETER (THOSE WHICH ARE UNKNOWN BUT THE SAME FOR ALL SUBJECTS).

      CALL MAKEVEC(NVAR,NOFIX,NRANFIX,IRAN,EXXX,VALFIX,RANFIXEST,PX)
	CALL IDCALCY(NVAR+NOFIX+NRANFIX,NDIM,PX,YPRED,NUMEQT)  

C  NOTE: PREDICTED VALUES WERE FOUND EVEN FOR OBSERVED LEVELS WHICH ARE
C  MISSING (I.E., OBSERVED LEVEL = -99) SINCE IT IS EASIER TO CALCULATE
C  ALL PREDICTED VALUES THAN TO KEEP TRACK OF WHICH DO AND WHICH DON'T
C  NEED TO BE CALCULATED.
 
C  STORE YPRED INTO YPREDPOP(JSUB,.,.,ICENTER)
 
	DO IOBS=1,NOBSER
	 DO IEQ=1,NUMEQT	
	 YPREDPOP(JSUB,IEQ,IOBS,ICENTER) = YPRED(IOBS,IEQ)
	 END DO
	END DO



C  FIND YPREDPOPT: 
C  CALL SUBROUTINE IDCALCYY, A VERSION OF THE ID PROGRAM WHICH SIMPLY
C  CALCULATES THE PREDICTED VALUES OF Y(I,J) (OUTPUT CONCENTRATION
C  OF THE JTH OUTPUT EQ. AT TIME TPRED(I),I=1,NUMT(JSUB)), ASSUMING THE
C  PARAMETER VECTOR EXXX. NOTE THAT IDCALCYY DIFFERS FROM IDCALCY IN
C  THAT THE TIMES FOR THE PREDICTED VALUES ARE SUPPLIED IN TPRED, 
C  RATHER THAN INPUT VIA COMMON/OBSER FROM THE PATIENT'S DATA FILE. 
C  ALSO, THE NO. OF OBSERVED TIMES IS NUMT(JSUB), RATHER THAN M WHICH IS 
C  SUPPLIED VIA COMMON/SUM2. AND NOTE THAT NUMT(JSUB) AND TPRED(.) ARE 
C  FOUND FROM THE CALL TO CALCTPRED BELOW.

C  CALL CALCTPRED TO CALCULATE THE NUMT(JSUB) TIMES TO BE IN TPRED FOR 
C  THIS SUBJECT. NOTE THAT, AFTER THE CALL TO FILRED ABOVE FOR THIS 
C  SUBJECT, THE NO. OF OBSERVED VALUE TIMES = NOBSER, AND THESE VALUES 
C  ARE IN ARRAY, TIMOB.

C  AS OF npageng16.f, TIMOBB IS NO LONGER NEEDED AS AN ARGUMENT TO
C  CALCTPRED, SINCE NOW CALCTPRED HAS COMMON/OBSER (WHICH PROVIDES
C  TIMOB) IN IT.

C  AS OF npageng18.f, CALCTPRED ALSO RETURNS TPREDREL, WHICH GIVES THE
C  "RELATIVE" RATHER THAN "REAL" TIMES AFTER A STEADY STATE DOSE SET.
C  THESE VALUES ARE THE ONES WHICH WILL BE WRITTEN TO THE OUTPUT FILES
C  FROM NOW ON.


      CALL CALCTPRED(JSUB,IDELTA,NOBSER,NUMT(JSUB),TPRED,TPREDREL,
     1   NOMAXTIM(JSUB),TEND,TBEGG)


C  STORE THE TIMES FOR THE PREDICTED CONCENTRATIONS INTO TTPRED. THEY
C  WILL BE NEEDED BELOW. ALSO STORE THE MAXIMUM ENDING TIME + 24 HOURS 
C  (TEND), AND BEGINNING TIME (TBEGG) FOR THIS SUBJECT ... FOR EACH
C  TIME RESET AND THE OVERALL MAXIMUM TIME. THESE VALUES WILL BE NEEDED
C  WHEN SUBJECT AUCs ARE CALCULATED BELOW.

C  ALSO, AS OF npageng18.f, STORE THE "RELATIVE" TIMES INTO TTPREDREL
C  (TTPRED STORES THE "REAL" TIMES). THESE ARE THE VALUES WHICH WILL BE
C  WRITTEN TO THE OUTPUT FILES.

	DO J = 1,NUMT(JSUB)
	 TTPRED(JSUB,J) = TPRED(J)
	 TTPREDREL(JSUB,J) = TPREDREL(J)
	END DO

	 DO J = 1,NOMAXTIM(JSUB)
	  TENDSUB(JSUB,J) = TEND(J)
        TBEGGSUB(JSUB,J) = TBEGG(J)
	 END DO


C  BEFORE ALL CALLS TO IDCALCYY, MUST INTEGRATE FIXED AND RANDOM
C  VALUES INTO PX, USING IRAN(I),I=1,NVAR+NOFIX. CALL MAKEVEC TO DO
C  THIS. AS OF npagranfix.f, ADD NRANFIX AND RANFIXEST
C  TO THE ARGUMENT LIST TOO (I.E., THERE IS NOW A 3RD TYPE OF 
C  PARAMETER (THOSE WHICH ARE UNKNOWN BUT THE SAME FOR ALL SUBJECTS).

      CALL MAKEVEC(NVAR,NOFIX,NRANFIX,IRAN,EXXX,VALFIX,RANFIXEST,PX)
	CALL IDCALCYY(NVAR+NOFIX+NRANFIX,NDIM,PX,TPRED,NUMT(JSUB),
     1  YYPRED,NUMEQT)

C  STORE YYPRED INTO YPREDPOPT(JSUB,.,.,ICENTER)
 
	DO J=1,NUMT(JSUB)
	 DO IEQ=1,NUMEQT	
	 YPREDPOPT(JSUB,IEQ,J,ICENTER) = YYPRED(J,IEQ)
	 END DO
	END DO

	END DO
 
C  THE ABOVE END DO IS FOR THE   DO ICENTER = 1,3  LOOP.
 
 
 6000   CONTINUE
 
 
 
C NEXT CALCULATE YPREDBAY AND PREDICTED VALUES AT SPECIFIED TIMES.
 
     	REWIND(27)
 
C  FOR EACH SUBJECT IN TURN, FIND THE BAYESIAN POSTERIOR P.D.F., GIVEN
C  THE FINAL JOINT P.D.F. OF THE ENTIRE POPULATION (IN CORDEN) AS THE
C  PRIOR. THEN FIND THE PREDICTED VALUES FOR THE MEANS, MEDIANS, AND
C  MODES OF THIS BAYESIAN P.D.F. (YPREDBAY), AS WELL AS THE PREDICTED
C  VALUES AT THE TIMES SPECIFIED IN TPRED FOR THE MEANS, MEDIANS, OR
C  MODES (SEE ICENT) OF THIS BAYESIAN P.D.F.
C!! NO. AS OF npageng25.f, ICENT IS NO LONGER USED. THE PREDICTED
C  VALUES WILL BE FOUND FOR ALL OF THE MEANS, MEDIANS, AND MODES.

  
C  STORE NACTVE AND CORDEN INTO NNACTVE AND CORHOLD, RESPECTIVELY.
C  THEY MUST BE RESET BEFORE EACH CALL TO SUBRES (WHICH ALTERS THEM).
 
	NNACTVE=NACTVE

 
	DO I=1,NACTVE
	DO J=1,NVAR+1
	 CORHOLD(I,J) = CORDEN(I,J)
	END DO
	END DO
 
C  OPEN THE PREDICTED CONCENTRATION FILE, PREDFIL (ESTABLISHED ABOVE
C  AS PRTBxxxx, WHERE xxxx IS THE RUN NO. WRITE EACH SUBJECT NO, EACH
C  FOLLOWED BY NUMT(JSUB) ROWS OF TPRED AND PREDICTED VALUES FOR EACH
C  OF THE MEANS, MEDIANS, AND MODES OF THE BAYESIAN POSTERIOR DENSITY.

	OPEN(31,FILE=PREDFIL)
 
 
	DO 7000 JSUB=1,NSUB
 

      NACTVE=NNACTVE
      DO I=1,NACTVE
       DO J=1,NVAR+1
        CORDEN(I,J) = CORHOLD(I,J)
       END DO
      END DO

 
 8506   FORMAT(////' THE FOLLOWING RESULTS ARE FOR SUBJECT ',I4)
	WRITE(*,8506) JSUB

	CALL FILRED(NOBSER,YO,C0,C1,C2,C3,NUMEQT)


C  CALCULATE SIGFAC AND OFAC FOR THIS SUBJECT. SEE COMMENTS IN LOOP 140
C  ABOVE.

	MISVAL = 0
 
        SIGFAC=1.D0
 
 	DO 240 I=1,NOBSER
 	 DO 240 J=1,NUMEQT
 
	  Y = YO(I,J)
 
	  IF(Y .EQ. -99) THEN
	   MISVAL = MISVAL+1
	   GO TO 240
	  ENDIF
 
          SIG(I,J) = C0(J)+C1(J)*Y+C2(J)*Y*Y+C3(J)*Y**3
cgam4

      if(ierrmod.eq.2) sig(i,j) = sig(i,j)*gamma
      if(ierrmod.eq.3) sig(i,j)=dsqrt(sig(i,j)**2 + gamma**2)
      if(ierrmod.eq.4) sig(i,j) = gamma*flat
      IF(SIG(I,J) .EQ. 0) THEN
		WRITE(*,2345) JSUB
		WRITE(25,2345) JSUB

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,2345) JSUB
        CLOSE(42)

	  	CALL PAUSE
	   	STOP
      ENDIF
 
      IF(SIG(I,J) .LT. 0) THEN

		WRITE(*,2346) JSUB
		WRITE(25,2346) JSUB

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,2346) JSUB
        CLOSE(42)

		CALL PAUSE
	   	STOP

      ENDIF
 
      SIGFAC=SIGFAC*SIG(I,J)
 

  240 CONTINUE
 
      OFAC=2.506628274631**(NOBSER*NUMEQT - MISVAL)

 
C  CALL SUBROUTINE SUBRES WHICH DOES THE ACTUAL CALCULATIONS FOR
C  THIS SUBJECT. SUBRES CALCULATES THE BAYESIAN POSTERIOR P.D.F. FOR
C  THIS SUBJECT. IT CALCULATES P(XI|Y), WHERE Y IS THE VECTOR OF
C  OBSERVED VALUES (ACTUALLY, Y IS A 2-DIM ARRAY IF THERE ARE MULTIPLE
C  OUTPUTS) FOR THIS SUBJECT, AND XI, I=1,NACTVE, ARE THE
C  REMAINING GRID POINTS FROM THE FINAL CYCLE OF THE POPULATION
C  ANALYSIS. IT ALSO RETURNS CENTER(I,J),J=1,NVAR, WHERE I = 1 -->
C  MEANS OF THE BAYESIAN POSTERIOR; I = 2 --> MEDIANS OF THE BAYESIAN
C  POSTERIOR; AND I = 3 --> MODES OF THE BAYESIAN POSTERIOR.

C  ALSO NOTE THAT SUBRES RETURNS PYJGXX IN CASE THIS RUN WAS A MAXCYC=0
C  RUN (I.E., A RUN USING A PRIOR DENSITY WITH A DIFFERENT SET OF
C  PATIENTS WHICH MEANS THAT PYJGX WAS NOT CALCULATED BECAUSE NO
C  CYCLES WERE RUN ABOVE - IN THIS CASE, PYJGX MUST BE CALCULATED 
C  IN ORDER TO BE WRITTEN INTO THE DENSITY FILE BELOW). SO PYJGX FOR
C  THIS SUBJECT WILL BE SET = PYJGXX AFTER THE CALL TO SUBRES.

C  ALSO, AS OF npageng23.f, SUBRES PASSES IN COMMON/BAY THE BAYESIAN
C  POSTERIOR DENSITY FOR EACH SUBJECT TO SUBROUTINE READOUT.


      CALL SUBRES(MAXSUB,MAXACT,JSUB,CORDEN,WORK,MAXGRD,MAXDIM,NVAR,
     1  NOFIX,VALFIX,SIGFAC,OFAC,AB,PAR,NACTVE,NGRID,VOLSPA,IRAN,CENTER,
     2  PYJGXX,NRANFIX,RANFIXEST)

	DO IG = 1,NACTVE
	 PYJGX(JSUB,IG) = PYJGXX(IG)
	END DO
 
C  FOR THIS SUBJECT, FIND THE PREDICTED VALUES (VIA SUBROUTINE IDCALCY),
C  FOR EACH OF THE MEANS, MEDIANS, AND MODES (ICENTER = 1,2,3,
C  RESPECTIVELY).
 
C  ALSO FIND THE PREDICTED VALUES AT THE TIMES SPECIFIED IN TPRED
C  FOR THE MEANS, MEDIANS, AND MODES.



	DO ICENTER = 1,3
 
	 DO J=1,NVAR
	  EXXX(J) = CENTER(ICENTER,J)	
	  EXX(JSUB,ICENTER,J) = CENTER(ICENTER,J)
	 END DO
 
C  NOTE THAT THE MEANS, MEDIANS, AND MODES FOR EACH SUBJECT ARE
C  STORED INTO EXX, FOR SUBSEQUENT STORAGE INTO THE DENSITY FILE.
 
C  CALL SUBROUTINE IDCALCY, A VERSION OF THE ID PROGRAM WHICH SIMPLY
C  CALCULATES THE PREDICTED VALUES OF YO(I,J) = OUTPUT CONCENTRATION OF
C  THE JTH OUTPUT EQUATION (J=1,NUMEQT) AT THE ITH OBSERVATION TIME
C  (I=1,NOBSER), ASSUMING THE PARAMETER VECTOR EXXX ...
 
C  BEFORE ALL CALLS TO IDCALCY, MUST INTEGRATE FIXED AND RANDOM
C  VALUES INTO PX, USING IRAN(I),I=1,NVAR+NOFIX. CALL MAKEVEC TO DO
C  THIS. AS OF npagranfix.f, ADD NRANFIX AND RANFIXEST
C  TO THE ARGUMENT LIST TOO (I.E., THERE IS NOW A 3RD TYPE OF 
C  PARAMETER (THOSE WHICH ARE UNKNOWN BUT THE SAME FOR ALL SUBJECTS).

      CALL MAKEVEC(NVAR,NOFIX,NRANFIX,IRAN,EXXX,VALFIX,RANFIXEST,PX)
	CALL IDCALCY(NVAR+NOFIX+NRANFIX,NDIM,PX,YPRED,NUMEQT)
 
C  NOTE: PREDICTED VALUES WERE FOUND EVEN FOR OBSERVED LEVELS WHICH ARE
C  MISSING (I.E., OBSERVED LEVEL = -99) SINCE IT IS EASIER TO CALCULATE
C  ALL PREDICTED VALUES THAN TO KEEP TRACK OF WHICH DO AND WHICH DON'T
C  NEED TO BE CALCULATED.
 
C  STORE YPRED INTO YPREDBAY(JSUB,.,.,ICENTER)

 
	DO IOBS=1,NOBSER
	 DO IEQ=1,NUMEQT	
	 YPREDBAY(JSUB,IEQ,IOBS,ICENTER) = YPRED(IOBS,IEQ)
	 END DO
	END DO


	END DO
 
C  THE ABOVE END DO IS FOR THE   DO ICENTER = 1,3  LOOP.
 
 
C  NOW CALCULATE THE PREDICTED VALUES TO BE STORED INTO FILE 31.
C  NOTE THAT AS OF npageng25.f, THESE VALUES ARE CALCULATED FOR ALL
C  3 MEASURES OF CENTRAL TENDENCY (MEANS, MEDIANS, AND MODES) FROM
C  THE BAYESIAN POSTERIOR DENSITY (IN PREVIOUS PROGRAMS, THE PREDICTED
C  VALUES WERE ONLY CALCULATED FOR THE MEASURE SPECIFIED BY ICENT, BUT
C  ICENT IS NOW IRRELEVANT, EVEN THOUGH IT IS STILL PASSED TO THIS
C  MODULE FROM THE PC PREP PROGRAM).
 
C  AND NOTE AS OF npageng18.f, INSTEAD OF WRITING TPRED(.) TO FILE 31,
C  TPREREL(.) IS WRITTEN (THE LATTER GIVE THE "RELATIVE" TIMES RATHER
C  THAN THE "REAL" TIMES). ESTABLISH THESE VALUES OUTSIDE THE 
C  ICENTER = 1,3 LOOP, SINCE THEY ARE THE SAME REGARDLESS OF THE VALUE
C  OF ICENTER.

	DO I=1,NUMT(JSUB)
	 TPRED(I) = TTPRED(JSUB,I)
	END DO


      DO ICENTER = 1,3



       DO J=1,NVAR
        EXXX(J) = CENTER(ICENTER,J)	
       END DO
 
C  CALL SUBROUTINE IDCALCYY, A VERSION OF THE ID PROGRAM WHICH SIMPLY
C  CALCULATES THE PREDICTED VALUES OF Y(I,J) (OUTPUT CONCENTRATION
C  OF THE JTH OUTPUT EQ. AT TIME TTPRED(JSUB,I),I=1,NUMT(JSUB)),ASSUMING 
C  THE PARAMETER VECTOR EXXX. NOTE THAT IDCALCYY DIFFERS FROM IDCALCY IN
C  THAT THE TIMES FOR THE PREDICTED VALUES ARE SUPPLIED IN TPRED,
C  RATHER THAN INPUT VIA COMMON/OBSER FROM THE PATIENT'S DATA FILE. 
C  ALSO, THE NO. OF OBSERVED TIMES IS NUMT(JSUB), RATHER THAN M WHICH IS 
C  SUPPLIED VIA COMMON/SUM2. AND NOTE THAT NUMT(JSUB) AND TTPRED(.,.)
C  WERE FOUND IN CALLS TO CALCTPRED ABOVE.

C  BEFORE ALL CALLS TO IDCALCYY, MUST INTEGRATE FIXED AND RANDOM
C  VALUES INTO PX, USING IRAN(I),I=1,NVAR+NOFIX. CALL MAKEVEC TO DO
C  THIS. AS OF npagranfix.f, ADD NRANFIX AND RANFIXEST
C  TO THE ARGUMENT LIST TOO (I.E., THERE IS NOW A 3RD TYPE OF 
C  PARAMETER (THOSE WHICH ARE UNKNOWN BUT THE SAME FOR ALL SUBJECTS).

      CALL MAKEVEC(NVAR,NOFIX,NRANFIX,IRAN,EXXX,VALFIX,RANFIXEST,PX)	
      CALL IDCALCYY(NVAR+NOFIX+NRANFIX,NDIM,PX,TPRED,NUMT(JSUB),
     1  YYPRED,NUMEQT)

C  STORE YYPRED INTO YYYPRED(ICENTER,J,IEQ).

       DO J = 1,NUMT(JSUB)
        DO IEQ = 1,NUMEQT
         YYYPRED(ICENTER,J,IEQ) = YYPRED(J,IEQ)
        END DO
       END DO

      END DO
C  THE ABOVE END DO IS FOR THE  DO ICENTER = 1,3  LOOP.


 
C  STORE YYYPRED(.,.,.) INTO FILE 31.
 
      WRITE(31,2131) JSUB
 2131 FORMAT('  SUBJECT NO. ',I5//
     1' COL. 1. = PREDICTION TIMES'/
     2' COL. 2. = PRED. VALUES FOR OUTPUT EQ. 1, BASED ON POSTERIOR MEAN
     3S'/
     4' COL. 3. = PRED. VALUES FOR OUTPUT EQ. 1, BASED ON POSTERIOR MEDI

     5ANS'/
     6' COL. 4. = PRED. VALUES FOR OUTPUT EQ. 1, BASED ON POSTERIOR MODE
     7S'/
     8' EACH ADDITIONAL OUTPUT EQ. HAS 3 COLUMNS OF PREDICTED VALUES'/
     9' BASED, IN ORDER, ON THE POSTERIOR MEANS, MEDIANS, AND MODES: '/
     1'-------------------------------------------------------------')




      DO J = 1,NUMT(JSUB)

       XVERIFY(1) = TTPREDREL(JSUB,J)
       IXV = 1

       DO IEQ = 1,NUMEQT
        IXV = IXV + 1
        XVERIFY(IXV) = YYYPRED(1,J,IEQ)
        IXV = IXV + 1     
        XVERIFY(IXV) = YYYPRED(2,J,IEQ)
        IXV = IXV + 1     
        XVERIFY(IXV) = YYYPRED(3,J,IEQ)
       END DO

       CALL VERIFYVAL(1+3*NUMEQT,XVERIFY)



C      WRITE(31,2167) TTPREDREL(JSUB,J),
C     1 (YYYPRED(1,J,IEQ),YYYPRED(2,J,IEQ),YYYPRED(3,J,IEQ),
C     2 IEQ=1,NUMEQT)

       WRITE(31,2167) (XVERIFY(IXV),IXV=1,1+3*NUMEQT)


 2167  FORMAT(90(G16.5,2X))



C  NOTE THAT THE MOST NOS. IN THE ABOVE FORMAT IS 1 + 3*NUMEQT. THIS 
C  WILL SURELY BE < 90, SO 90 IS SUFFICIENT.
      END DO

c  AS OF npageng21.f, TTPREDREL(JSUB,J) is written to file 31 above, 
C  rather than TPREDREL(J). Writing TPREDREL(J) was a mistake since it
C  holds the values for the last subject, not the values for each 
C  subject.


       DO IEQ = 1,NUMEQT

        WRITE(31,2132) JSUB,IEQ
 2132    FORMAT(//'  SUBJECT NO. ',I5,' ...  OUTPUT EQUATION NO. ',I2//
     1'     TIMES                   OBSERVED VALUES          PREDICTED V
     2ALUES, BASED ON POSTERIOR MEANS; THEN MEDIANS; THEN MODES'/
     2'-----------------------------------------------------------------
     3---------------------------------------------------------')
        DO IOBS=1,NOBSER
         WRITE(31,2167) TIMOBREL(JSUB,IOBS),YO(IOBS,IEQ),
     1   (YPREDBAY(JSUB,IEQ,IOBS,ICENTER),ICENTER=1,3)
C  SEE ABOVE COMMENT BELOW FORMAT 2167.
        END DO

       END DO

c  Note that as of npageng18.f, instead of writing TIMOBS(.) to File 31,
c  the program writes TIMOBREL(.,.) to the file. TIMOB(IOBS) are the
c  "real" times; and TIMOBREL(JSUB,IOBS) are the "relative" times. See
c  comments regarding change 1 at top of npageng18.f code.


	WRITE(31,*)
	WRITE(31,*) 

 
C  CALCULATE AUC'S AND AUC/MIC'S AND PUT THEM TO SCREEN AND TO THE
C  OUTPUT FILE ... ONE TABLE FOR EACH OUTPUT EQUATION. ACTUALLY, THERE
C  WILL NOW BE ONE TABLE FOR EACH OUTPUT EQUATION FOR EACH TIME RESET
C  FOR THE SUBJECT. 

C  AS OF npageng25.f, THERE WILL BE 1 SET OF AUC TABLES FOR EACH OF
C  THE MEAN, MEDIAN, AND MODE.



C  THE NO. OF MAXIMUM TIMES FOR THIS SUBJECT IS NOMAXTIM(JSUB), WHICH
C  IS 1 MORE THAN THE NO. OF TIME RESETS; THE ENDING TIMES (24 HOURS 
C  PAST THE LAST OBSERVATION TIME) ARE IN 
C  TENDSUB(JSUB,J), J=1,NOMAXTIM(JSUB); AND THE BEGINNING TIMES ARE IN
C  TBEGGSUB(JSUB,J), J=1,NOMAXTIM(JSUB). MAKE A TABLE FOR EACH OF THESE
C  NOMAXTIM(JSUB) PAIRS OF TIMES.

      ILAST = 0

C  ILAST IS THE RUNNING NO. OF YYPRED VALUES ALREADY USED IN CALCULATING
C  AUCs FROM THE PREVIOUS LOOP ON IMAXTIM (SEE LOGIC BELOW).

C  FOR npageng21.f, A BUG IS FIXED BY INITIALIZING IELAST = 0 HERE:
C  FOR EACH NEW SUBJECT, INITIALIZE IELAST = 0. REASON: IT IS SUPPOSED
C  TO BE SET IN LOOP 2050, BUT IF NWHOLE = 0 FOR THE 1ST TIME PERIOD 
C  (IMAXTIM = 1) FOR A NEW SUBJECT, LOOP 2050 IS SKIPPED AND THEN
C  IS = IELAST OCCURS IN THE   IF(NPAR .GT. 0)   SECTION, AND IF THIS
C  OCCURS FOR JSUB > 1, THEN IS WILL BE SET TO WHATEVER IELAST WAS FROM 
C  THE PREVIOUS SUBJECT (WHICH MEANS SUM WILL NOT START WITH YYPRED(1,.)
C  FOR THE NEW SUBJECT AS IT SHOULD). TO PREVENT THIS, INITIALIZE 
C  IELAST = 0 HERE, FOR EACH NEW SUBJECT.

      IELAST = 0


      DO IMAXTIM = 1,NOMAXTIM(JSUB)

       NUMTT = (TENDSUB(JSUB,IMAXTIM)-TBEGGSUB(JSUB,IMAXTIM))*60/IDELTA
	
C  NDELPER = NO. OF INTERVALS IN EACH AUCINT HOURS (1 PERIOD =
C            AUCINT*60 MINUTES).
C  NWHOLE = NO. OF WHOLE PERIODS.
C  NPAR = NO. OF INTERVALS ON THE LAST PARTIAL PERIOD, IF ANY.
C  NOTE: IF NUMTT/NDELPER IS AN INTEGER, THEN NPAR WILL = 0 --> THERE
C	   WILL BE NO LAST PARTIAL PERIOD.

C  RECALL THAT NUMTT IS THE TOTAL NO. OF INTERVALS FOR THE PREDICTED
C  CONCS. (NUMTT+1 IS THE NO. OF PREDICTED CONCS., SINCE THE 1ST
C  PREDICTED CONC. IS AT TIME = TBEGGSUB(JSUB,IMAXTIM)).

       NDELPER = AUCINT*60/IDELTA
       NWHOLE = NUMTT/NDELPER
       NPAR = NUMTT - NWHOLE*NDELPER


	 DO IEQ = 1,NUMEQT


        DO ICENTER = 1,3

 
	  WRITE(*,2053) IEQ
	  WRITE(25,2053) IEQ
        IF(ICENTER .EQ. 1) WRITE(*,3051)
        IF(ICENTER .EQ. 2) WRITE(*,3052)
        IF(ICENTER .EQ. 3) WRITE(*,3053)
        IF(ICENTER .EQ. 1) WRITE(25,3051)
        IF(ICENTER .EQ. 2) WRITE(25,3052)
        IF(ICENTER .EQ. 3) WRITE(25,3053)
 

 2053  FORMAT(//' THE FOLLOWING TABLE IS FOR OUTPUT EQUATION ',I2)
 3051  FORMAT(' BASED ON THE POSTERIOR MEANS: ')
 3052  FORMAT(' BASED ON THE POSTERIOR MEDIANS: ')
 3053  FORMAT(' BASED ON THE POSTERIOR MODES: ')


	  IF(NOMAXTIM(JSUB) .GT. 1) THEN
	   WRITE(*,2054) IMAXTIM
	   WRITE(25,2054) IMAXTIM

 2054      FORMAT(/' FOR MAXIMUM TIME NO. ',I3)
	  ENDIF

C  BEFORE CALCULATING THE AUC'S AND AUC/MIC'S EVERY AUCINT HOURS,
C  ESTABLISH THE HEADER INFO. FOR THE TABLE SHOWING THE AUC'S AND
C  THE AUC/MIC'S FOR THIS SUBJECT.
 
	WRITE(*,2048)

	WRITE(25,2048)
 2048   FORMAT(/'      PERIOD',10X,'TIME (HOURS)',8X,'  AUC',8X,'   AUC/
     1MIC'/
     1' ----------------------------------------------------------------
     1----')
 
C  OUTPUT ONE LINE IN THE AUC TABLE FOR EACH AUCINT HOURS, AND THEN ONE 
C  LINE FOR THE TOTALS.
 
C  AUCRUN = RUNNING TOTAL OF AUC'S THRU EACH AUCINT HOURS.

	AUCRUN = 0.D0

	DO 2050 IPERIOD = 1,NWHOLE


C  FOR WHOLE PERIOD, IPERIOD, CALCULATE THE STARTING AND ENDING INDICES
C  OF PREDICTED CONCENTRATIONS (IS AND IE, RESPECTIVELY).

C  NOTE THAT A BUG IS CORRECTED IN npageng16.f. PREVIOUSLY, THE VALUE
C  FOR IS WAS WRONG AFTER THE IMAXTIM = 1, SINCE THE YYPRED VALUES 
C  USED KEPT STARTING OVER WITH THE 1ST VALUE IN THE ARRAY, RATHER THAN
C  CONTINUE WITH THE NEXT SET OF YYPRED VALUES (WHICH ARE STACKED ONE
C  AFTER THE OTHER FOR ALL TTPRED VALUES FROM SUBROUTINE CALCTPRED).
C  I.E., IS ALWAYS STARTED WITH 1, REGARDLESS OF THE VALUE OF IMAXTIM.

C  NOW IS WILL BE ADJUSTED AHEAD ILAST VALUES, WHERE ILAST IS THE NO.
C  OF YYPRED VALUES ALREADY USED FOR THE PREVIOUS IMAXTIM VALUES.

	IS = ILAST + (IPERIOD-1)*NDELPER + 1
	IE = IS + NDELPER
      IELAST = IE


C  THE AREA UNDER THE CURVE WILL BE CALCULATED USING THE
C  TRAPEZOIDAL RULE. SINCE EACH OF THE CONCS. ARE IDELTA APART,
C  AUC = IDELTA*(YYPRED(IS,IEQ)/2 + SUM + YYPRED(IE,IEQ)/2), WHERE SUM
C  IS THE SUM OF YYPRED(.,IEQ), FOR INDICES BETWEEN IS+1 AND IE-1.

 
	SUM=0.D0
	DO I=IS+1, IE-1
	 SUM=SUM+YYYPRED(ICENTER,I,IEQ)
	END DO
 
	AUC = IDELTA*((YYYPRED(ICENTER,IS,IEQ) +
     1      YYYPRED(ICENTER,IE,IEQ))/2.D0 + SUM)/60.D0

 
C  NOTE THAT AUC HAS UNITS IN TERMS OF HOURS BECAUSE OF THE DIVISION BY
C  60 ABOVE (WHICH CHANGES IDELTA FROM MINUTES TO HOURS).
 
	AUCMIC = AUC/XMIC

	AUCRUN = AUCRUN+AUC
 
C  THIS PERIOD STARTS WITH HOUR, IHRST, AND ENDS WITH HOUR, IHREN.

C  NOTE THAT AS OF npageng18.f, IHRST GIVES THE "RELATIVE" INSTEAD OF
C  THE "REAL" TIME FOR THIS PERIOD (SINCE TBEGGSUB(.,.) IS NO LONGER
C  ADDED TO THE EQUATION BELOW.


C	IHRST = (IPERIOD-1)*AUCINT + TBEGGSUB(JSUB,IMAXTIM)
	IHRST = (IPERIOD-1)*AUCINT
	IHREN = IHRST + AUCINT

C  PRINT TO OUTPUT FILE AND THE SCREEN THE INFO FOR THIS PERIOD.
 

      XVERIFY(1) = AUC
      XVERIFY(2) = AUCMIC
      CALL VERIFYVAL(2,XVERIFY)

C     WRITE(*,2049) IPERIOD, IHRST, IHREN, AUC, AUCMIC
      WRITE(*,2049) IPERIOD, IHRST, IHREN, XVERIFY(1),XVERIFY(2)
C     WRITE(25,2049) IPERIOD, IHRST, IHREN, AUC, AUCMIC
      WRITE(25,2049) IPERIOD, IHRST, IHREN, XVERIFY(1),XVERIFY(2)


 2049 FORMAT(' ',I8,2X,I10,'    -',I10,5X,G12.6,3X,G12.6)
 
 2050 CONTINUE
 
C  NOW, PUT IN A LINE FOR THE LAST PARTIAL PERIOD, IF ANY.
 
	IF(NPAR .GT. 0) THEN
 
C  THE STARTING INDEX FOR THE PREDICTED CONCS. IS SIMPLY THE ENDING
C  INDEX FROM LOOP 2050 ABOVE. THE ENDING INDEX IS NPAR MORE THAN THE
C  STARTING INDEX. THEN PROCEED AS IN LOOP 2050 ABOVE.

 
	IS = IELAST
	IE = IS + NPAR
 
	SUM=0.D0
	DO I=IS+1, IE-1
	 SUM=SUM+YYYPRED(ICENTER,I,IEQ)
	END DO

 
	AUC = IDELTA*((YYYPRED(ICENTER,IS,IEQ) +
     1      YYYPRED(ICENTER,IE,IEQ))/2.D0 + SUM)/60.D0
	AUCMIC = AUC/XMIC
	AUCRUN = AUCRUN+AUC
 
C  ESTABLISH THE PERIOD NO., AND THE STARTING AND ENDING HOUR NOS.
 
	IPERIOD = NWHOLE + 1

C  NOTE THAT AS OF npageng18.f, IHRST GIVES THE "RELATIVE" INSTEAD OF
C  THE "REAL" TIME FOR THIS PERIOD (SINCE TBEGGSUB(.,.) IS NO LONGER
C  ADDED TO THE EQUATION BELOW.

C	IHRST = (IPERIOD-1)*AUCINT + TBEGGSUB(JSUB,IMAXTIM)

	IHRST = (IPERIOD-1)*AUCINT 
	IHREN = IHRST + NPAR*IDELTA/60

 
C  PRINT TO OUTPUT FILE AND THE SCREEN THE INFO FOR THIS PERIOD.
 

      XVERIFY(1) = AUC
      XVERIFY(2) = AUCMIC
      CALL VERIFYVAL(2,XVERIFY)



C     WRITE(*,2051) IPERIOD, IHRST, IHREN, AUC, AUCMIC
      WRITE(*,2051) IPERIOD, IHRST, IHREN, XVERIFY(1),XVERIFY(2)


C     WRITE(25,2051) IPERIOD, IHRST, IHREN, AUC, AUCMIC
      WRITE(25,2051) IPERIOD, IHRST, IHREN, XVERIFY(1),XVERIFY(2)



 2051   FORMAT(' ',I2,' (PARTIAL)',I8,'    -',I10,5X,G12.6,3X,G12.6)
 

	ENDIF
 
C  THE ABOVE ENDIF IS FOR THE  IF(NPAR .GT. 0)  CONDITION.
 
C  NOW WRITE THE LAST LINE, GIVING TOTAL VALUES FOR AUC AND AUC/MIC.
C  NOTE THAT TOTAL AUC IS NOW AUCRUN. NOTE THAT IHREN IS THE SAME AS
C  THE LAST VALUE CALCULATED ABOVE (I.E., IT'S THE ENDING HOUR).
 
	AUCMIC = AUCRUN/XMIC

C  AS OF npageng18.f, THE BEGINNING TIME FOR EACH AUC TABLE, SINCE THE
C  TIMES ARE "RELATIVE", INSTEAD OF "REAL", WILL ALWAYS BE 0.

      XVERIFY(1) = AUCRUN
      XVERIFY(2) = AUCMIC
      CALL VERIFYVAL(2,XVERIFY)



C     WRITE(*,2052) IHREN, AUCRUN, AUCMIC
      WRITE(*,2052) IHREN, XVERIFY(1),XVERIFY(2)
C     WRITE(25,2052) IHREN, AUCRUN, AUCMIC
      WRITE(25,2052) IHREN, XVERIFY(1),XVERIFY(2)


 2052   FORMAT(' ','----------------------------------------------------
     1---------------'/
     2'    TOTAL',2X,'         0    -',I10,5X,G12.6,3X,G12.6//)
 

       END DO
C  THE ABOVE END DO IS FOR THE  DO ICENTER = 1,3  LOOP.


 
	END DO 
C  THE ABOVE END DO IS FOR THE  DO IEQ = 1,NUMEQT  LOOP.

C  INCREASE ILAST TO BE THE NO. OF YYPRED VALUES ALREADY USED.
C  SIMILARLY FOR IELAST.

       ILAST = IE
       IELAST = IE

	END DO
C  THE ABOVE END DO IS FOR THE  DO IMAXTIM = 1,NOMAXTIM(JSUB)  LOOP.
 
 

 7000   CONTINUE

 
	
C  RESTORE THE CORRECT CORDEN AND NACTVE (THEY WERE CHANGED IN
C  THE CALLS TO SUBRES). THEY MUST BE RESTORED BEFORE BEING WRITTEN
C  TO THE DENSITY FILE.
 
	NACTVE=NNACTVE
	DO I=1,NACTVE
	DO J=1,NVAR+1
	 CORDEN(I,J) = CORHOLD(I,J)
	END DO
	END DO
 
 
C  STORE THIS CYCLE'S JOINT DENSITY (AND ASSOCIATED VALUES) INTO THE
C  FILE DENFIL.
 
      write(*,*)' About to create density file ...'

	OPEN(23,FILE=DENFIL)
 
	WRITE(23,7124)
 7124   FORMAT('DENSITY OCT_15 ... Made by npagranfix6')

	WRITE(23,*) NDIM
	WRITE(23,*) INDPTS
 
C  NEW CODE ABOVE FOR m2_11cal.f
 
	WRITE(23,*) NACTVE
 
	WRITE(23,*) NVAR
	WRITE(23,2227) (PAR(I),I=1,NVAR)
	WRITE(23,*) NOFIX
	WRITE(23,2227) (PARFIX(I),I=1,NOFIX)
      WRITE(23,*) NRANFIX
	WRITE(23,2227) (PARRANFIX(I),I=1,NRANFIX)

 
	DO I=1,NVAR
	 WRITE(23,*) (AB(I,J),J=1,2)
	END DO
 
	WRITE(23,*) (VALFIX(I),I=1,NOFIX)
	WRITE(23,*) (RANFIXEST(I),I=1,NRANFIX)

	
C  STARTING WITH MXEM2N36.FOR, NINT WILL ALWAYS BE 100. BUT, IN ORDER
C  NOT TO CHANGE THE STRUTURE OF PRIOR DENSITY FILES (SO THAT PRIOR
C  DENSITIES CAN STILL BE RUN WITH MXEM2N36.FOR), NINT WILL STILL
C  BE WRITTEN TO, AND READ FROM, THIS FILE.

 
	WRITE(23,*) NINT

c  As of npageng18.f, reduce ICYCLE BY 1 if IHESS = -1, because this 
c  means a Hessian Matrix was singular in a call to Subroutine emint,
c  which --> the current ICYCLE never had its values written to the
c  output file since control was transferred immediately to label 900
c  after returning from emint.

      IF(IHESS .EQ. -1) ICYCLE = ICYCLE - 1


	WRITE(23,*) ICYCLE
	WRITE(23,*) DORIG
 

	write(*,*)' Writing CORDEN ... '

	 DO I=1,NACTVE
	  WRITE(23,*) (CORDEN(I,J),J=1,NVAR+1)
	 END DO
 
	write(*,*)' Writing PYJGX ... '

	DO JSUB=1,NSUB

	 DO I=1,NACTVE
	  WRITE(23,*) PYJGX(JSUB,I)
	 END DO
	END DO
 

 
	REWIND(27)

	write(*,*)' Writing YPREDPOP ...'

	DO JSUB=1,NSUB
	 CALL FILRED(NOBSER,YO,C0,C1,C2,C3,NUMEQT)

	 DO IEQ=1,NUMEQT
	  DO J=1,NOBSER
	   WRITE(23,*) (YPREDPOP(JSUB,IEQ,J,ICENTER),ICENTER=1,3)
	  END DO
	 END DO
	END DO

	DO JSUB = 1,NSUB
	 WRITE(23,*) NUMT(JSUB)
	END DO


	write(*,*)' Writing YPREDOPT ... '

	DO JSUB=1,NSUB
	 DO IEQ=1,NUMEQT

	  DO J=1,NUMT(JSUB)
	   WRITE(23,*) (YPREDPOPT(JSUB,IEQ,J,ICENTER),ICENTER=1,3)
	  END DO
	 END DO
	END DO

	write(*,*)' Writing TTPREDREL ... '


	DO JSUB=1,NSUB
	 DO J=1,NUMT(JSUB)

C  AS OF npageng18.f, WRITE THE "RELATIVE" INSTEAD OF THE "REAL"
C  TIMES TO FILE 23.

C	  WRITE(23,*) TTPRED(JSUB,J)
	  WRITE(23,*) TTPREDREL(JSUB,J)

	 END DO
	END DO
 
	REWIND(27)

	write(*,*)' Writing YPREDBAY ... '

 
	DO JSUB=1,NSUB

	 CALL FILRED(NOBSER,YO,C0,C1,C2,C3,NUMEQT)

	 DO IEQ=1,NUMEQT
	  DO J=1,NOBSER
	   WRITE(23,*) (YPREDBAY(JSUB,IEQ,J,ICENTER),ICENTER=1,3)
	  END DO
	 END DO
	END DO

	write(*,*)' Writing EXX ... '

 
	DO JSUB=1,NSUB
	 DO ICENTER=1,3
	  WRITE(23,*) (EXX(JSUB,ICENTER,J),J=1,NVAR)
	 END DO
	END DO
 
      write(25,*) 'Optimal value of gamma=',gamma


C  CONSTRUCT THE COMBINED OUTPUT FILE, TO BE CALLED 'OUT'//NAME, WHERE
C  NAME WAS OBTAINED ABOVE, AND IS THE CHARACTER*4 EQUIVALENT TO INUM

C  AS OF npbig7aadapt.f, CREATE A COMBINED OUTPUT FILE.
C  NOTE THAT FILE 25 IS THE REGULAR OUTPUT FILE AND FILE 23 IS THE 
C  DENSITY FILE. ALSO SCRATCH FILE 27 HAS THE PATIENT DATA PART OF
C  npembig3.inp. SO ONLY NEED TO OPEN npagdriv.f, AND THEN OPEN
C  THE COMBINED OUTPUT FILE, OUTCOM, AND PUT ALL THE REQUIRED INFO
C  INTO OUTCOM, IN THE FORMAT REQUIRED BY SUBROUTINE PREVRUN OF THE
C  PC PREP/ANALYSIS PROGRAM (CURRENTLY, NPBIG10A.FOR).

	OPEN(29,FILE='npagdriv.f')
	REWIND(27)
	REWIND(25)
	REWIND(23)

	write(*,*)' About to create the combined output file ... '


	OUTCOM = 'OUT'//NAME
	OPEN(26,FILE=OUTCOM)

C  PUT THE REGULAR OUTPUT FILE INTO THE COMBINED OUTPUT FILE. 

 1110   READ(25,2717,IOSTAT=IEND) READLARG
 2717   FORMAT(A1000)
        IF(IEND .LT. 0) GO TO 1120

        CALL CONDENSE(READLARG)

C  USE SUBROUTINE CONDENSE TO WRITE THIS LINE WITH AS SMALL A FORMAT
C  AS POSSIBLE (WITHIN 25 CHARACTERS) TO FILE 26. SIMILARLY FOR THE
C  OTHER CALLS TO CONDENSE BELOW.

        GO TO 1110

 1120   WRITE(26,1121)
 1121   FORMAT(/'***************** END OF THE OUTPUT FILE **************
     1***'//
     2'***************** START OF THE DENSITY FILE *****************'/)


	write(*,*)' Writing density to combined output file ...'


C  PUT THE DENSITY FILE INTO THE COMBINED OUTPUT FILE. 

 1130   READ(23,2717,IOSTAT=IEND) READLARG
        IF(IEND .LT. 0) GO TO 1140
        CALL CONDENSE(READLARG)
        GO TO 1130



 1140   WRITE(26,1141)
 1141   FORMAT(/'***************** END OF THE DENSITY FILE *************
     1****'//
     2'***************** START OF THE PATIENT DATA INFO FILE ***********
     3******'/)


	write(*,*)' Writing patient data to combined output file ...'

C  PUT THE PATIENT DATA INFO INTO THE COMBINED OUTPUT FILE. 

 1150   READ(27,2717,IOSTAT=IEND) READLARG
        IF(IEND .LT. 0) GO TO 1160
        CALL CONDENSE(READLARG)

        GO TO 1150

 1160   WRITE(26,1161)
 1161   FORMAT(/'***************** END OF THE PATIENT DATA INFO FILE ***
     1**************'//
     2'***************** START OF THE npagdriv.f FILE *****************'
     3)



	write(*,*)' Writing model file to combined output file ...'

C  PUT npagdriv.f INTO THE COMBINED OUTPUT FILE. 

 1170   READ(29,2717,IOSTAT=IEND) READLARG
        IF(IEND .LT. 0) GO TO 1180
        CALL CONDENSE(READLARG)

        GO TO 1170

 1180   WRITE(26,1181)
 1181   FORMAT(/'***************** END OF THE npagdriv.f FILE **********
     1*******'/)
     


C  DON'T CLOSE FILES 25,23,27,29. THEY WILL BE REUSED
C  BY read__.f. Just rewind them.

      REWIND(23)
      REWIND(27)
      REWIND(25)
      REWIND(29)
      CLOSE(26)
      CLOSE(31)



C  FROM THE COMBINED OUTPUT FILE, OUTCOM, CALL READOUT TO FORM THE
C  SUMMARIZED OUTPUT FILE, NP_RFxxxx.TXT, WHICH IS COMPATIBLE WITH THE
C  R GRAPHICS PACKAGE.



        OUTFILER = 'NP_RF'//NAME//'.TXT'
        CALL READOUT(OUTFILER) 

 
c  For some reason, the unix system keeps file 27 in the directory.
c  To eliminate it, use the following command.

c  As of bigmlt1.f, the call system line below is commented out since
c  this program is usually run now on PCs. Also tbeg and tend are not
c  used now, so their write statements are commented out.
 
C	call system("rm -f fort.27")

C      tend = 0
C      write(91,*) 'total run time in seconds=',tend-tbeg
C       write(6,*) 'total run time in seconds=',tend-tbeg
 	  close(91)


C  NOW CLOSE THE FILES USED BY READOUT.

      CLOSE(23)
      CLOSE(27)
      CLOSE(25)
      CLOSE(29)
 
	STOP
	END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
	SUBROUTINE FILRED(NOBSER,YO,C0,C1,C2,C3,NUMEQT)

C  FILRED IS CALLED BY MAIN TO READ THE PORTION OF
C  SCRATCH FILE 27 WHICH APPLIES TO THE SUBJECT UNDER CONSIDERATION. THE
C  'POINTER' FOR FILE 27 IS IN THE PROPER POSITION TO BEGIN READING THE
C  INFO FOR THE DESIRED SUBJECT.
 
        IMPLICIT REAL*8(A-H,O-Z)
        PARAMETER(MAXNUMEQ=7)


        DIMENSION TIM(594),SIG(5000),RS(5000,34),YO(594,NUMEQT),
     1  BS(5000,7),C0(NUMEQT),C1(NUMEQT),C2(NUMEQT),C3(NUMEQT),
     2  YOO(594,MAXNUMEQ) 

C  AS OF npageng13.f, THE FORMAT FOR THE WORKING COPY FILES IS:


C     COL 1 = TIME
C     COL 2 = IV FOR DRUG 1; COL 3 = PO FOR DRUG 1;
C     COL 4 = IV FOR DRUG 2; COL 5 = PO FOR DRUG 2;
C     ... EACH SUCCEEDING DRUG HAS AN IV FOLLOWED BY A PO COLUMN.
C     NEXT NADD COLUMNS = ONE FOR EACH ADDITIONAL COVARIATE (ADDITIONAL
C      REFERS TO ANY EXTRA COVARIATES BEYOUND THE 4 PERMANENT ONES IN
C      COMMON DESCR (SEE BELOW).
 
        COMMON /OBSER/ TIM,SIG,RS,YOO,BS
        COMMON /CNST/ N,ND,NI,NUP,NUIC,NP
        COMMON /CNST2/ NPL,NUMEQTT,NDRUG,NADD
        COMMON /SUM2/ M,NPNL

        COMMON/DESCR/AGE,HEIGHT,ISEX,IETHFLG
        COMMON/ERR/ERRFIL 

        CHARACTER SEX*1,READLINE*300,ERRFIL*20
  
C  INPUT IS: SCRATCH FILE 27, WHICH IS POSITIONED AT THE BEGINNING OF
C  THE INFO FOR THE SUBJECT DESIRED.
 
C  OUTPUT ARE:

 
C  NOBSER = THE NO. OF OBSERVATIONS FOR THIS SUBJECT.
C  YO(I,J),I=1,M; J=1,NUMEQT = NO. OF OUTPUT EQS; I=1,M, WHERE M = NO.
C	OF OBSERVATION TIMES.
C  [C0(J),C1(J),C2(J),C3(J)] = ASSAY NOISE COEFFICIENTS FOR OUTPUT EQ.
C	J; J=1,NUMEQT.
C  THE 4 DESCRIPTOR VALUES FOR THIS SUBJECT (AGE, SEX, HEIGHT,
C    ETHNICITY FLAG) VIA COMMON/DESCR TO SUBROUTINES DIFFEQ/OUTPUT.
C  VARIABLES/ARRAYS IN ABOVE COMMON STATEMENTS.
 
 
C  AGE, SEX, HEIGHT, AND ETHNICITY FLAG ARE ON LINES 8-11.
 
	DO I=1,7
	 READ(27,*)
	END DO

	
	READ(27,*) AGE
	READ(27,2) SEX
    2   FORMAT(A1)
	ISEX=1
	IF(SEX .EQ. 'F') ISEX=2
	READ(27,*) HEIGHT
	READ(27,*) IETHFLG
 
C  READ THE NO. OF DRUGS FROM THE LINE WITH 'NO. OF DRUGS' AS ENTRIES
C  12:23. THEN READ NO. OF ADDITIONAL COVARIATES, AND THE NO. OF DOSE 
C  EVENTS, ETC.

    1   FORMAT(A300)
   10	READ(27,1) READLINE
	IF(READLINE(12:23) .NE. 'NO. OF DRUGS') GO TO 10
	BACKSPACE(27)

    3   FORMAT(T2,I5)
        READ(27,3) NDRUG

	IF(NDRUG .GT. 7) THEN
	 WRITE(*,124)
  124    FORMAT(' YOUR PATIENT DATA FILES CANNOT HAVE MORE THAN 7'/
     1' DRUGS. THE PROGRAM IS NOW STOPPING. '/)


C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,124) 
        CLOSE(42)

       CALL PAUSE
	 STOP
	ENDIF

        READ(27,3) NADD

C  NOTE THAT THE NO. OF "RATES" INCLUDES 2 FOR EACH DRUG (THE IV AND
C  THE PO COLUMNS) + NADD (1 COLUMN FOR EACH ADDITIONAL COVARIATE).

	NI = 2*NDRUG + NADD

	IF(NI .GT. 34) THEN
  	 WRITE(*,123)
  123    FORMAT(/' YOUR PATIENT DATA FILES HAVE TOO MANY COLUMNS IN '/
     1' THE DOSAGE REGIMEN BLOCK. THE NO. OF ADDITIONAL COVARIATES '/
     2' PLUS TWICE THE NO. OF DRUGS CANNOT EXCEED 34. THE PROGRAM IS'/
     3' NOW STOPPING. '/)

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,123) 
        CLOSE(42)

       CALL PAUSE
	 STOP
	ENDIF

        READ(27,3) ND

	IF(ND .GT. 5000) THEN
	 WRITE(*,125)
  125    FORMAT(' YOUR PATIENT DATA FILES CANNOT HAVE MORE THAN 5000'/
     1' DOSE EVENTS. THE PROGRAM IS NOW STOPPING. '/)

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,125) 
        CLOSE(42)

       CALL PAUSE
	 STOP
	ENDIF

	READ(27,*)

	READ(27,*)

        IF(ND.EQ.0) GO TO 40

	DO I = 1,ND
         READ(27,*) SIG(I),(RS(I,J),J=1,NI)

	END DO	 

C  ASSIGN THE VALUES IN EACH DRUG'S PO COLUMN TO THE CORRESPONDING
C  COLUMN IN ARRAY BS.

        DO I=1,ND
         DO J=1,NDRUG
          BS(I,J)=RS(I,2*J)
         END DO
        END DO

C  READ THE NO. OF OUTPUT EQUATIONS FROM THE LINE WITH 'NO. OF TOTAL'
C  AS ENTRIES 12:23. THEN READ NO. OF OBSERVED VALUE TIMES, ETC.

   40	READ(27,1) READLINE
	IF(READLINE(12:23) .NE. 'NO. OF TOTAL') GO TO 40
	BACKSPACE(27)

        READ(27,*) NUMEQTT

C  NOTE THAT NUMEQT IS PROVIDED TO THIS ROUTINE IN THE ARGUMENT LIST SO
C  THAT IT CAN BE USED TO VARIABLY DIMENSION SEVERAL ARRAYS. SO, INSTEAD
C  OF READING IN NUMEQT ABOVE, READ IN NUMEQTT. BUT NOW CHECK THAT
C  THESE TWO VALUES ARE EQUAL.

      IF(NUMEQTT .NE. NUMEQT) THEN

       WRITE(*,127) NUMEQT,NUMEQTT
  127  FORMAT(/' THERE IS A CONFLICT IN SUBROUTINE FILRED.'/
     1' NUMEQT = ',I2,', BUT NUMEQTT = ',I2/
     2' THESE TWO VALUES SHOULD BE THE SAME. SOMETHING IS AMISS WITH'/
     3' AT LEAST ONE OF YOUR PATIENT DATA FILES. THE PROGRAM IS NOW'/
     4' STOPPING. '/)

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,127) NUMEQT,NUMEQTT 
        CLOSE(42)

       CALL PAUSE
       STOP

      ENDIF


        READ(27,3) M

	MAXOBDIM = 150
	IF(M .GT. MAXOBDIM) THEN
  	 WRITE(*,126) MAXOBDIM
  126    FORMAT(/' AT LEAST ONE OF YOUR PATIENT DATA FILES HAS TOO'/
     1' MANY OBSERVED VALUE TIMES. THIS NO. CANNOT EXCEED ',I5,'.'/
     2' THE PROGRAM IS NOW STOPPING. '/)

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,126) MAXOBDIM
        CLOSE(42)

       CALL PAUSE
	 STOP
	ENDIF


         DO I=1,M
          READ(27,*) TIM(I),(YO(I,J),J=1,NUMEQT)
         END DO
 
C  PUT YO VALUES INTO YOO BECAUSE A DUMMY ARGUMENT CANNOT BE IN A
C  COMMON STATEMENT.
 
	DO I=1,M
	 DO J=1,NUMEQT
	  YOO(I,J) = YO(I,J)
	 END DO
	END DO
 
	NOBSER=M
 
C  AT THIS POINT, MUST SKIP THE COVARIATE INFO IN THE FILE, AND PROCEED
C  TO READ THE ASSAY NOISE COEFFICIENTS BELOW THAT.
 
C  READ THE NUMEQT SETS OF ASSAY COEFFICIENTS JUST BELOW THE LINE
C  WHICH HAS "ASSAY COEFFICIENTS FOLLOW" IN ENTRIES 1:25.

   50	READ(27,1) READLINE
	IF(READLINE(1:25) .NE. 'ASSAY COEFFICIENTS FOLLOW') GO TO 50

	DO IEQ = 1,NUMEQT
	 READ(27,*) C0(IEQ),C1(IEQ),C2(IEQ),C3(IEQ)
	END DO
 
	RETURN
	END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
	SUBROUTINE CALGRD(NVAR,NGRID,AB,X)
	IMPLICIT REAL*8(A-H,O-Z)
	DIMENSION X(30),AB(30,2),QUASI(30)
      CHARACTER ERRFIL*20
        save first
	logical flag(2),first
        data first/.TRUE./
      COMMON/ERR/ERRFIL 

 
C  THIS SUBROUTINE, CALLED BY MAIN, DETERMINES THE COORDINATES OF
C  THE IGTH GRID POINT, AND STORES THEM INTO X.
 
C  INPUT ARE:
 
C  NVAR = NO. OF COORDINATES (RANDOM VARIABLES).
C  NGRID = TOTAL NO. OF GRID POINTS
C  [AB(I,1),AB(I,2)] = GRID BOUNDARIES FOR COORDINATE (R.V.) I,
C                      I=1,NVAR.
 
C  OUTPUT IS:
 
C  X(I), I=1,NVAR = AS DESCRIBED ABOVE.
 
 
C  THE ICTH COORDINATE IS:
C       (AB(IC,2)-AB(IC,1))*QUASI(IC) + AB(IC,1),
C       WHERE QUASI(IC) is a quasi-random variable from the low discrepancy
C       FAURE sequence on the NVAR dimensional hyypercube defined by
C       ACM TOMS algorithm 647
C       (routines INFAUR and GOFAUR, available from www.netlib.org in
C       the TOMS directory are included below and are
C       properly set up for both SUNs, IBM workstations, and the CRAY
C       T3E.

 
c       first, we initialize the Faure sequence with a call to INFAUR
c       if this is the first time that we want a number.
 
        if(first) then
         CALL INFAUR(flag,nvar,ngrid)
         first = .FALSE.
        endif
 

c here nvar = dimensionality of grid, ngrid = number of grid
c points to be generated, and flag(1) and flag(2) = logical variables
c set to 'T" if call is successful.
 
        IF(.NOT. FLAG(1)) THEN
	 WRITE(*,11) NVAR
   11    FORMAT(/' THE NUMBER OF RANDOM VARIABLES, ',I3,', IS NOT '/
     1' ACCEPTABLE IN SUBROUTINE INFAUR.')

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.


        OPEN(42,FILE=ERRFIL)
         WRITE(42,11) NVAR
        CLOSE(42)

	 CALL PAUSE
	 STOP
        ENDIF
 
	IF(.NOT. FLAG(2)) THEN
	 WRITE(*,12) NGRID
   12    FORMAT(/' THE NUMBER OF REQUESTED GRID POINTS, ',I8,', IS NOT'/
     1' ACCEPTABLE IN SUBROUTINE INFAUR.')

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,12) NGRID
        CLOSE(42)

	 CALL PAUSE
         STOP
        ENDIF
 
c now we call gofaur to generate  the nvar coordinaters inside
c the unit hypercube that will later be scaled to the grid point.
 
        CALL GOFAUR(quasi)

 
c now we scale each of the i-coordinates to lie
c between AB(I,1) and AB(I,2).
 
	DO IC = 1,NVAR
        X(IC) = (AB(IC,2)-AB(IC,1))*quasi(IC) + AB(IC,1)
	END DO
 
	RETURN
	END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
	SUBROUTINE INFAUR(FLAG,DIMEN,ATMOST)
        implicit double precision (a-h,o-z)
        LOGICAL FLAG(2)
 
      INTEGER S,ATMOST,QS,COEF(0:19,0:19),NEXTN,
     +        TESTN,HISUM,I,J,PRIMES(40),DIMEN
 

      COMMON /FAURE/ S,QS,COEF,RQS,NEXTN,TESTN,HISUM
      SAVE /FAURE/
 
      DATA (PRIMES(I),I=1,40)/1,2,3,5,5,7,7,11,11,11,11,
     +                        13,13,17,17,17,17,19,19,
     +                        23,23,23,23,29,29,29,29,
     +                        29,29,31,31,37,37,37,37,
     +                        37,37,41,41,41/
 
 
C      ALGORITHM 659, COLLECTED ALGORITHMS FROM ACM.

C      THIS WORK PUBLISHED IN TRANSACTIONS ON MATHEMATICAL SOFTWARE,
C      VOL. 14, NO. 1, P.88.
 
C       THIS SUBROUTINE FIRST CHECKS WHETHER
C       THE USER-SUPPLIED DIMENSION "DIMEN" OF THE
C       QUASIRANDOM VECTORS IS ACCEPTABLE
C       (STRICTLY BETWEEN 1 AND 41) : IF SO,
C       FLAG(1)=.TRUE.
 
C       THEN IT CALCULATES AN UPPER SUMMATION
C       LIMIT "HISUM" BASED ON "DIMEN" AND THE
C       USER-SUPPLIED NUMBER "ATMOST" OF QUASIRANDOM
C       VECTORS REQUIRED. FLAG(2)=.TRUE. IF
C       ATMOST IS OK.
 
C       IF FLAG(1) AND FLAG(2) ARE TRUE,
C       "INFAUR" NEXT PRODUCES THE OTHER
C       OUTPUTS LISTED BELOW PASSED TO
C       SUBROUTINE GOFAUR VIA LABELLED
C       COMMON "FAURE". THESE OUTPUTS ARE
C       IRRELEVANT TO THE USER.
 
C       FIRST CALL INFAUR. IF FLAG(1) AND
C       FLAG(2) ARE TRUE, EACH (SUBSEQUENT)
C       CALL TO GOFAUR GENERATES A NEW
C       QUASIRANDOM VECTOR.
 
C       INPUTS : DIMEN, ATMOST
 
C       OUTPUTS
C          TO USERS CALLING PROGRAM:
C             FLAG
C             QSS   : SAME AS QS - SEE BELOW
 
C          TO GOFAUR:
C             S      :DIMENSION
C             QS     :SMALLEST PRIME >=S
C             COEF   :TABLE OF BINOMIAL
C                     COEFFICIENTS NEEDED
C                     BY GOFAUR.
C             NEXTN  :THE NUMBER OF THE
C                     NEXT QUASIRANDOM
C                     VECTOR,INITIALIZED
C                     TO TESTN-1 HERE.
C             TESTN  :INITIALIZED TO QS**4
C             HISUM  :AFTER BEING USED TO
C                     PRODUCE COEF, INITIALIZED
C                     TO 3 FOR GOFAUR.
C             RQS    :1.0/QS.
 
C       CHECK S
 
      S=DIMEN
      FLAG(1) = S.GT.1 .AND. S.LT.41
      IF (.NOT.FLAG(1)) RETURN
 

      QS=PRIMES(S)
      TESTN=QS**4
 
C         COMPUTE LOG(ATMOST+TESTN) IN BASE QS
C         USING A RATIO OF NATURAL LOGS TO GET
C         AN UPPER BOUND ON (THE NUMBER OF
C         DIGITS IN THE BASE QS REPRESENTATION
C         OF ATMOST+TESTN) MINUS ONE.
 
      HISUM=NINT(LOG(REAL(ATMOST+TESTN))/LOG(REAL(QS)))
      FLAG(2)=HISUM.LT.20
      IF(.NOT. FLAG(2)) RETURN
 
C        NOW FIND BINOMIAL COEFFICIENTS MOD QS
C        IN A LOWER-TRIANGULAR MATRIX "COEF"
C        USING RECURSION BINOM(I,J)=BINOM(I-1,J)
C        +BINOM(I-1,J-1) AND A=B+C IMPLIES MOD(A,D)=
C        MOD(MOD(B,D)+MOD(C,D),D)
 
      COEF(0,0)=1
      DO 50 J=1,HISUM
        COEF(J,0)=1
        COEF(J,J)=1
   50 CONTINUE
      DO 200 J=1,HISUM
        DO 100 I=J+1,HISUM
          COEF(I,J)=MOD(COEF(I-1,J)+COEF(I-1,J-1),QS)
  100   CONTINUE
  200 CONTINUE
 
C        CALCULATING THESE COEFFICIENTS
C        MOD QS AVOIDS POSSIBLE OVERFLOW
C        PROBLEMS WITH RAW BINOMIAL COEFFICIENTS
 
C        NOW COMPLETE INITIALIZATION
C        AS DESCRIBED IN SECTION 2.
C        NEXTN HAS 4 DIGITS IN BASE
C        QS, SO HISUM EQUALS 3.
 

      NEXTN=TESTN-1
      HISUM=3
      RQS=1.0/REAL(QS)
 
      RETURN
      END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
        SUBROUTINE GOFAUR(QUASI)

        implicit double precision (a-h,o-z)
        INTEGER S,QS,COEF(0:19,0:19),NEXTN,TESTN,
     +        HISUM,I,J,K,YTEMP(0:19),ZTEMP,
     +        KTEMP,LTEMP,MTEMP
 
C QUASI DIMENSION CHANGED FROM 40 TO 25 TO MATCH DIMENSION IN CALGRD.


      dimension QUASI(30)
      COMMON /FAURE/ S,QS,COEF,RQS,NEXTN,TESTN,HISUM
      SAVE /FAURE/
 
C       THIS SUBROUTINE GENERATES A NEW
C       QUASIRANDOM VECTOR WITH EACH CALL
 
C       IT IMPLEMENTS A METHOD OF H.FAURE,
C       "ACTA ARITHMETICA XLI(1982),337-351".

C       (SEE ESPECIALLY PAGE 342).
 
C       THE USER MUST CALL "INFAUR" BEFORE
C       CALLING "GOFAUR".
C       AFTER CALLING "INFAUR", TEST FLAG(1)
C       AND FLAG(2); IF EITHER IS FALSE, DO
C       NOT CALL GOFAUR. READ THE COMMENTS AT
C       THE BEGINNING OF INFAUR AND THEN
C       THOSE BELOW.
 
C       ALL INPUTS COME FROM "INFAUR" VIA
C       LABELLED COMMON "FAURE"; FOR THEIR
C       DEFINITIONS, SEE "INFAUR".
 

C       INPUTS:
C         S,QS,COEF,NEXTN,TESTN,HISUM,RQS
 
C       OUTPUTS:
C         TO USER'S CALLING PROGRAM:
C         QUASI - A NEW QUASIRANDOM VECTOR

 
 
C       FIND QUASI(1) USING FAURE (SECTION 3.3)

 
C       NEXTN HAS A REPRESENTATION IN BASE
C       QS OF THE FORM: SUM OVER J FROM ZERO
C       TO HISUM OF YTEMP(J)*(QS**J)
 
C       WE NOW COMPUTE THE YTEMP(J)'S.
 
      KTEMP=TESTN
      LTEMP=NEXTN
      DO 100 I=HISUM,0,-1
          KTEMP=KTEMP/QS
          MTEMP=MOD(LTEMP,KTEMP)
          YTEMP(I)=(LTEMP-MTEMP)/KTEMP
          LTEMP=MTEMP

  100   CONTINUE
 

C       QUASI(K) HAS THE FORM SUM OVER J
C       FROM ZERO TO HISUM OF
C       YTEMP(J)*(QS**(-(J+1)))
 
C       READY TO COMPUTE QUASI(1)
C       USING NESTED MULTIPLICATION
 
      R=YTEMP(HISUM)

      DO 200 I=HISUM-1,0,-1

          R=YTEMP(I)+RQS*R
  200   CONTINUE
      QUASI(1)=R*RQS
 
C       FIND THE OTHER S-1 COMPONENTS
C       OF QUASI USING "FAURE" (SECTIONS
C       3.2 AND 3.3)
 
      DO 500 K=2,S
          QUASI(K)=0.0
          R=RQS
          DO 400 J=0,HISUM
              ZTEMP=0
              DO 300 I=J,HISUM
                  ZTEMP=ZTEMP+COEF(I,J)*YTEMP(I)
 
C       NO APPARENT ALTERNATIVE
C       ONE-DIMENSIONAL COEFFICIENT ARRAY
C       EXCEPT VIA SUBSCRIPT ADDRESS
C       COMPUTATIONS AND EQUIVALENCING
 
  300           CONTINUE
 
C       NEW YTEMP(J) IS THE SUM
C       OVER I FROM J TO HISUM

C       OF (OLD YTEMP(I)*BINOM(I,J))
C       MOD QS
 
              YTEMP(J)=MOD(ZTEMP,QS)
              QUASI(K)=QUASI(K)+YTEMP(J)*R
              R=R*RQS
  400       CONTINUE

  500   CONTINUE
 
C       UPDATE NEXTN AND, IF NEEDED, TESTN AND
C       HISUM
 
      NEXTN=NEXTN+1
      IF(NEXTN.EQ.TESTN) THEN
        TESTN=TESTN*QS
        HISUM=HISUM+1
 
C       SINCE FLAG(2) IS TRUE,
C       HISUM STAYS UNDER 20
 
      ENDIF
 
      RETURN
      END

C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
	SUBROUTINE NOTINT(VOLSPA,NGRID,NACTVE,FUNC,MAXGRD,ESTINT)
	IMPLICIT REAL*8(A-H,O-Z)

	DIMENSION FUNC(MAXGRD)
C
C  THIS SUBROUTINE, CALLED BY MAIN, IS A MULTI-DIMENSIONAL INTEGRATOR.

C
C  INPUT ARE:


C
C  VOLSPA = 'VOLUME' OF THE INTEGRATION SPACE.
C  NGRID = NO. OF GRID POINTS OVER WHICH THE INTEGRATION IS DONE.
C  NACTVE = NO. OF CURRENTLY ACTIVE GRID POINTS.
C  FUNC(I), I=1,NACTVE = VALUE OF THE FUNCTION TO BE INTEGRATED AT

C                       THE ITH GRID POINT.
C  MAXGRD = DIMENSION OF FUNC -- SEE EXPLATION IN MAIN.
C
C  OUTPUT IS:
C
C  ESTINT = THE ESTIMATE OF THE NVAR-DIM INTEGRAL OF THE FUNCTION WHOSE
C           VALUES ARE GIVEN IN FUNC.
C
	SUM=0.D0
	DO 100 IG=1,NACTVE
  100   SUM=SUM+FUNC(IG)
	ESTINT=VOLSPA*SUM/NGRID
	RETURN
	END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
       SUBROUTINE STAZ(VOLSPA,NGRID,NACTVE,NVAR,IND,CORDEN,PROD,MAXGRD,
     1  NINT,X1,X2,XMODE,X025,X25,X50,X75,X975,SCALINFO,NSUB,MAXDIM)
	IMPLICIT REAL*8(A-H,O-Z)
	DIMENSION CORDEN(MAXGRD,MAXDIM+1),PROD(MAXGRD),X(1999),

     1  PROB(1998),CUMPRO(0:1998)
 
C  THIS SUBROUTINE, CALLED BY MAIN, CALCULATES THE MODE AND 5 %-TILE
C  VALUES OF THE APPROXIMATE MARGINAL DENSITY OF R.V. IND, WHOSE

C  BOUNDARIES [X1,X2] ARE INPUT. ALSO, THE
C  SCALED 'INFO' FOR THIS MARGINAL DENSITY IS CALCULATED.
 
 
C  INPUT ARE:
C
C  VOLSPA = 'VOLUME' OF THE INTEGRATION SPACE.
C  NGRID = THE NO. OF GRID POINTS.
C  NACTVE = THE NO. OF CURRENTLY ACTIVE GRID POINTS.
C  NVAR = NO. OF R.V.'S.
C  IND = INDEX OF THE R.V. WHOSE STATISTICS ARE BEING FOUND.
C  CORDEN(I,J) = JTH COORDINATE FOR THE ITH GRID POINT, J=1,NVAR;
C		 I=1,NACTVE;
C		 DENSITY FOR THE ITH GRID POINT, J=NVAR+1;I=1,NACTVE.
C  PROD(I), I=1,NACTVE = DUMMY ARRAY; IN ARGUMENT LIST SO IT CAN BE

C                       VARIABLY DIMENSIONED.
C  MAXGRD = DIMENSION OF CORDEN AND PROD -- SEE EXPLANATION IN MAIN.
C  NINT = THE NO. OF INTERVALS TO BE USED IN CALCULATING THE APPROXIMATE
C         MARGINAL DENSITY OF R.V. INDICATED ABOVE (CHANGED -SEE BELOW).
C  [X1,X2] = BOUNDS ON THE R.V. INDICATED ABOVE.
C  NSUB = NO. OF SUBJECTS.

C  MAXDIM = DIMENSION OF CORDEN.

 
C  OUTPUT IS:
C
C  XMODE = MODE OF THE APPROXIMATE DISTRIBUTION OF R.V. INDICATED ABOVE.
C  X025 =  2.5 %-TILE VALUE OF ABOVE APPROXIMATE DISTRIBUTION.
C  X25 =    25 %-TILE VALUE OF ABOVE APPROXIMATE DISTRIBUTION.

C  X50 =    50 %-TILE VALUE OF ABOVE APPROXIMATE DISTRIBUTION (MEDIAN).
C  X75 =    75 %-TILE VALUE OF ABOVE APPROXIMATE DISTRIBUTION.
C  X975 = 97.5 %-TILE VALUE OF ABOVE APPROXIMATE DISTRIBUTION.
C  SCALINFO = SCALED 'INFO' FOR THIS MARGINAL DENSITY.
 
C  AS OF npbig1.f, THE NO. OF INTERVALS USED IN THIS ROUTINE IS
C  NO LONGER HARDCODED TO BE NINT = 100. THE REASON IS THAT THE
C  SCALED INFO HAS A DENOMINATOR OF LOG(NINT/NSUB) WHICH = 0 IF
C  NSUB = NINT = 100 (--> DIVIDE BY 0 ERROR), AND IF NSUB > 100, THIS
C  PRODUCES A NEGATIVE SCALED INFO (WHICH IS SUPPOSED TO VARY FROM 0
C  TO 100). SO MAKE THE NO. OF INTERVALS = MAX(100,2*NSUB).
 
C  NOTE THAT NINT IS PASSED TO THIS ROUTINE AS ALWAYS 100; DON'T
C  CHANGE NINT; USE NEWINT BELOW.
 
	NEWINT = NINT
	IF(2*NSUB .GT. NEWINT) NEWINT = 2*NSUB
 
 
C  FIND THE NEWINT INTERVALS OF INTEGRATION -- EQUALLY SPACED -- BETWEEN
C  X1 AND X2.
C
	XINT=(X2-X1)/NEWINT
	X(1)=X1

	X(NEWINT+1) = X2 

	DO 5 I=1,NEWINT-1
    5   X(I+1)=X(I)+XINT

 
C  FIND THE APPROXIMATE PROBABILITY THAT THE R.V. IS IN EACH OF THE
C  NEWINT INTERVALS.
 
	DO 1000 INTR=1,NEWINT
 
C  FIND PROB{ R.V. IN [X(INTR),X(INTR+1)] } = PROB(INTR).
C

C  INTEGRATE (CORDEN(I,NVAR+1)*W(X(INTR),X(INTR+1))), WHERE W(A,B) = 1
C  IF R.V. IS IN [X(INTR),X(INTR+1)], AND = 0 IF NOT.
C
C  FIND W EVALUATED AT EACH GRID POINT AND MULTIPLY IT BY
C  CORDEN(I,NVAR+1)
 
	DO IG=1,NACTVE
	  W = 0.D0
	  XX = CORDEN(IG,IND)
	  IF(XX .GE. X(INTR) .AND. XX .LT. X(INTR+1)) W = 1.D0
	  IF(INTR .EQ. NEWINT .AND. XX .GE. X(INTR)) W = 1.D0
C    BUG FIX IN bignpaglap4.f IS THE LINE ABOVE, WHICH GUARANTEES THAT
C    ANY DENSITY VALUE AT THE UPPER BOUNDARY IS COUNTED.


          PROD(IG) = CORDEN(IG,NVAR+1)*W
	END DO
 
 1000  CALL NOTINT(VOLSPA,NGRID,NACTVE,PROD,MAXGRD,PROB(INTR))
 
 
C  WITH PROB(.), CALCULATE THE MODE.
 
	INTMAX=1
	DO INTR=2,NEWINT
	  IF(PROB(INTR) .GT. PROB(INTMAX)) INTMAX=INTR
	END DO
 

	XMODE=(X(INTMAX)+X(INTMAX+1))/2.D0
 
 
C  CALCULATE THE 'SCALED INFORMATION' FOR THIS CYCLE (STARTING WITH
C  PROGRAM m234calc.f, 11-6-94; BUT THE SCALED 'INFO' IS CHANGED
C  IN PROGRAM MXEM2N35.FOR/m235calc.f, 11-19-94):
 
C  INFO = SUM(PI*LOG(PI)), WHERE THE SUM IS OVER I=1,NEWINT, THE LOG
C    	  IS TO BASE 2, PI*LOG(PI) --> 0 IF PI = 0, AND
C	  PI = PROB(I).
 
C  THEN INFO IS SCALED: y = 100*ln(2)/ln(n/N)*(x + ln(n)/ln(2)), WHERE
C  y = SCALED INFO, x = ABOVE INFO, n = NEWINT, N = NO. OF SUBJECTS. SO
C  y = 0 (%) IF DENSITY IS UNIFORM, and y = 100 (%) if DENSITY IS
C  CONCENTRATED AT N EQUALLY LIKELY POINTS, ... I.E., SCALED INFO = 0 %
C  FOR NO INFO, AND SCALED INFO = 100 % FOR PERFECT INFO.
 
	SUM=0.D0
 
	DO I=1,NEWINT
 
	IF (PROB(I) .GT. 0.D0) THEN
	  PI=PROB(I)
	  SUM=SUM+PI*DLOG(PI)
	ENDIF
 
	END DO
 
	DL2=DLOG(2.D0)
	SUM = SUM/DL2
 
C  SUM IS NOW THE INFO FOR THIS MARGINAL DENSITY. SCALE IT AS SHOWN
C  ABOVE.
 
        DINT=NEWINT
	FACT=100.D0*DL2/DLOG(DINT/NSUB)
	SCALINFO = FACT*(SUM + DLOG(DINT)/DL2)
 
 
C  FIND THE 5 %-TILE VALUES.
 
C  X025 IS THE X-VALUE BELOW WHICH IS 2.5 % OF THE DISTRIBUTION.
C  X25  IS THE X-VALUE BELOW WHICH IS 25 % OF THE DISTRIBUTION.
C  X50  IS THE X-VALUE BELOW WHICH IS 50 % OF THE DISTRIBUTION.
C  X75  IS THE X-VALUE BELOW WHICH IS 75 % OF THE DISTRIBUTION.

C  X975 IS THE X-VALUE BELOW WHICH IS 97.5 % OF THE DISTRIBUTION.
 
 
C  ACTUALLY, X025 WILL BE THE WEIGHTED X-VALUE IN THE INTERVAL WHERE
C  THE CUMULATIVE PROBABILITY EXCEEDS 2.5%. SIMILARLY FOR THE OTHER
C  %-TILE VALUES.
 
C  FIND THE INTERVALS WHERE THE CUMULATIVE PROBABILITES EXCEED 2.5%,
C  25%, 50%, 75%, AND 97.5%.
C
C  CUMPRO(I) BELOW IS THE CUMULATIVE PROBABILITY OF THE DISTRIBUTION
C  THROUGH INTERVAL I.
 
	CUMPRO(0)=0.D0
	DO 1200 INTR=1,NEWINT
	CUMPRO(INTR)=CUMPRO(INTR-1)+PROB(INTR)
 
	IF(CUMPRO(INTR-1) .LT. .025D0 .AND. CUMPRO(INTR) .GE. .025D0)
     1  IND025=INTR
	IF(CUMPRO(INTR-1) .LT. .25D0 .AND. CUMPRO(INTR) .GE. .25D0)
     1  IND25=INTR
	IF(CUMPRO(INTR-1) .LT. .50D0 .AND. CUMPRO(INTR) .GE. .50D0)
     1  IND50=INTR

	IF(CUMPRO(INTR-1) .LT. .75D0 .AND. CUMPRO(INTR) .GE. .75D0)
     1  IND75=INTR
	IF(CUMPRO(INTR-1) .LT. .975D0 .AND. CUMPRO(INTR) .GE. .975D0)
     1  IND975=INTR
 
 1200 CONTINUE
C

C  NOW IND025 IS THE INTERVAL WHERE THE CUMULATIVE PROBABILITY EXCEEDS
C  .025 (SIMILARLY FOR THE OTHER IND'S).
C
	X025 = X(IND025)+(X(IND025+1)-X(IND025))*
     1  (.025D0-CUMPRO(IND025-1))/(CUMPRO(IND025)-CUMPRO(IND025-1))

 
	X25 = X(IND25)+(X(IND25+1)-X(IND25))*
     1  (.25D0-CUMPRO(IND25-1))/(CUMPRO(IND25)-CUMPRO(IND25-1))
 

	X50 = X(IND50)+(X(IND50+1)-X(IND50))*
     1  (.50D0-CUMPRO(IND50-1))/(CUMPRO(IND50)-CUMPRO(IND50-1))
 

	X75 = X(IND75)+(X(IND75+1)-X(IND75))*

     1  (.75D0-CUMPRO(IND75-1))/(CUMPRO(IND75)-CUMPRO(IND75-1))
 

	X975 = X(IND975)+(X(IND975+1)-X(IND975))*

     1  (.975D0-CUMPRO(IND975-1))/(CUMPRO(IND975)-CUMPRO(IND975-1))
 
 
	RETURN
	END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
	SUBROUTINE EQUIV(INUM,NAME)

 
	CHARACTER*1 A,B,C,D
	CHARACTER NAME*4
 
C  THIS SUBROUTINE, CALLED BY MAIN, INPUTS INTEGER INUM, AND RETURNS THE
C  4-CHARACTER EQUIVALENT IN NAME.
 
	I4 = INUM/1000
	ILEFT = INUM - I4*1000
	I3 = ILEFT/100
	ILEFT = ILEFT - I3*100
	I2 = ILEFT/10
 	ILEFT = ILEFT - I2*10
	I1 = ILEFT
 
C  CONVERT THIS TO THE CHARACTER EQUIVALENT.
 
	IF(I4 .EQ. 1) A='1'
	IF(I4 .EQ. 2) A='2'
	IF(I4 .EQ. 3) A='3'
	IF(I4 .EQ. 4) A='4'
	IF(I4 .EQ. 5) A='5'
	IF(I4 .EQ. 6) A='6'
	IF(I4 .EQ. 7) A='7'
	IF(I4 .EQ. 8) A='8'
	IF(I4 .EQ. 9) A='9'
	IF(I4 .EQ. 0) A='0'
 
	IF(I3 .EQ. 1) B='1'
	IF(I3 .EQ. 2) B='2'
	IF(I3 .EQ. 3) B='3'
	IF(I3 .EQ. 4) B='4'
	IF(I3 .EQ. 5) B='5'
	IF(I3 .EQ. 6) B='6'
	IF(I3 .EQ. 7) B='7'
	IF(I3 .EQ. 8) B='8'
	IF(I3 .EQ. 9) B='9'
	IF(I3 .EQ. 0) B='0'
 
	IF(I2 .EQ. 1) C='1'
	IF(I2 .EQ. 2) C='2'
	IF(I2 .EQ. 3) C='3'
	IF(I2 .EQ. 4) C='4'
	IF(I2 .EQ. 5) C='5'
	IF(I2 .EQ. 6) C='6'
	IF(I2 .EQ. 7) C='7'
	IF(I2 .EQ. 8) C='8'
	IF(I2 .EQ. 9) C='9'
	IF(I2 .EQ. 0) C='0'
 
	IF(I1 .EQ. 1) D='1'
	IF(I1 .EQ. 2) D='2'
	IF(I1 .EQ. 3) D='3'
	IF(I1 .EQ. 4) D='4'
	IF(I1 .EQ. 5) D='5'
	IF(I1 .EQ. 6) D='6'
	IF(I1 .EQ. 7) D='7'
	IF(I1 .EQ. 8) D='8'
	IF(I1 .EQ. 9) D='9'
	IF(I1 .EQ. 0) D='0'
 
	NAME = A//B//C//D
 
	RETURN
	END

C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
      SUBROUTINE MAKEVEC(NVAR,NOFIX,NRANFIX,IRAN,X,VALFIX,RANFIXEST,PX)

	IMPLICIT REAL*8(A-H,O-Z)
	DIMENSION IRAN(32),X(30),VALFIX(20),PX(32),RANFIXEST(20)

C  THIS ROUTINE, CALLED BY MAIN, INPUTS NVAR, NOFIX, NRANFIX, IRAN, X,
C  VALFIX, AND RANFIXEST, AND RETURNS PX(I) = A COMBINATION OF THE 
C  VALUES IN X, VALFIX, AND RANFIXEST, IN THE PROPER ORDER (AS 
C  DETERMINED BY IRAN).
 
      NNNVAR = 0
      NNNFIX = 0
      NNNRANFIX = 0
 
      DO I = 1,NVAR+NOFIX+NRANFIX
 
       IF(IRAN(I) .EQ. 1) THEN
        NNNVAR = NNNVAR+1
        PX(I) = X(NNNVAR)
       ENDIF
 
       IF(IRAN(I) .EQ. 0) THEN
        NNNFIX = NNNFIX+1
        PX(I) = VALFIX(NNNFIX)
       ENDIF

       IF(IRAN(I) .EQ. 2) THEN
        NNNRANFIX = NNNRANFIX+1
        PX(I) = RANFIXEST(NNNRANFIX)
       ENDIF
 
      END DO
 
      RETURN
      END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
	SUBROUTINE SUBRES(MAXSUB,MAXACT,JSUB,CORDEN,WORK,MAXGRD,MAXDIM,
     1  NVAR,NOFIX,VALFIX,SIGFAC,OFAC,AB,PAR,NACTVE,NGRID,VOLSPA,IRAN,
     2  CENTER,PYJGXX,NRANFIX,RANFIXEST)

      IMPLICIT REAL*8(A-H,O-Z)
      DIMENSION AB(30,2),EX(30),COV(30,30),E(30,30),STD(30),
     1   CORR(30,30),COFVR(30),WORK(MAXGRD),CORDEN(MAXGRD,MAXDIM+1),
     2   CENTER(3,30),IRAN(32),PX(32),X(30),VALFIX(20),
     3   PYJGXX(MAXACT),BAYPOS(100,1500,31),NACTSUB(100),XVERIFY(100),
     4   RANFIXEST(20)


C??? SEE COMMENTS BELOW WHERE BAYPOS (AND NACTSUB) ARE STORED. THE 
C  FIRST DIMENSION OF BAYPOS (AND THE ONLY DIMENSION OF NACTSUB) IS
C  SET = 100, RATHER THAN 800, BECAUSE THE PROGRAM IS TOO BIG 
C  OTHERWISE.


C  NOTE THAT BAYPOS STORES THE BAYESIAN POSTERIOR DENSITY FOR EACH
C  SUBJECT, AND NACTSUB STORES THE NO. OF GRID POINTS IN EACH 
C  SUBJECT'S BAYESIAN POSTERIOR.

      COMMON/BAY/NACTSUB,BAYPOS
      COMMON/ERR/ERRFIL 

	REAL*8 KU
	CHARACTER PAR(30)*11,ERRFIL*20

C  AS OF MXEM2N54, SUBRES IS CHANGED. RATHER THAN CALCULATE THE
C  'FINAL FITTED JOINT P.D.F.' FOR EACH SUBJECT, IT CALCULATES
C  THE BAYESIAN POSTERIOR DENSITY FOR EACH SUBJECT. IN PARTICULAR, FOR
C  A SUBJECT WITH OBSERVATIONS Y, THE  BAYESIAN POSTERIOR DENSITY IS
C  P(XI|Y) FOR EACH REMAINING GRID POINT (XI) IN THE POPULATION FINAL
C  CYCLE JOINT DENSITY, WHERE P(XI|Y) = PF(XI) * P(Y|XI) / P(Y),
C  P(Y) = INTEGRAL OF P(Y|XI)*PF(XI), AND PF(XI) IS THE POPULATION
C  FINAL CYCLE JOINT DENSITY VALUE AT XI.
 
C  THIS ROUTINE, CALLED BY MAIN,

C  INPUTS THE FINAL JOINT DENSITY (CORDEN)
C  FROM THE PROGRAM (FOR THE ENTIRE POPULATION) AS THE APRIORI DENSITY
C  FOR A SINGLE SUBJECT WHOSE CONCENTRATION LEVELS, ETC. HAVE ALREADY
C  BEEN READ INTO COMMON STATEMENTS FOR MODULE IDPC, AND CALCULATES THAT
C  SUBJECT'S BAYESIAN POSTERIOR JOINT DENSITY. IT OUTPUTS LOG-LIKS,
C  EXPECTED VALUES, ETC. FOR THIS DENSITY. THE ONLY VALUES RETURNED TO
C  MAIN ARE THE FINAL CYCLE EXPECTED VALUES, MEDIANS, AND MODES
C  (IN CENTER).

C  NOTE THAT PYJGXX(IG) = IS CALCULATED IN LOOP 800 AND RETURNED
C  TO MAIN.

C  NOTE: THE RESULTS ARE OUTPUT TO THE SCREEN AND FILE 25.
 
C  FOR DETAILED COMMENTS ON THE FOLLOWING CODE, SEE THE SIMILAR CODE
C  IN MAIN.
 
 
   	NSUB=1
	NINT=100
 
	WRITE(*,5432)
 5432   FORMAT('1')


	DENMAX=CORDEN(1,NVAR+1)
	DO I=1,NACTVE
	  D=CORDEN(I,NVAR+1)
	  IF(D .GT. DENMAX) DENMAX=D
	END DO
 
	SUMD=0.
	NEWIND=0

        DO I=1,NACTVE
         D=CORDEN(I,NVAR+1)
          IF(D .GT. 1.D-10*DENMAX) THEN
          SUMD=SUMD+D
          NEWIND=NEWIND+1
           DO J=1,NVAR
            CORDEN(NEWIND,J)=CORDEN(I,J)
           END DO
          CORDEN(NEWIND,NVAR+1)=D
         ENDIF
        END DO

        NACTVE=NEWIND
 
        FACT = NGRID/VOLSPA/SUMD
 
	DO I=1,NACTVE
	  CORDEN(I,NVAR+1)=CORDEN(I,NVAR+1)*FACT
	END DO

 
     	WRITE(*,1241) JSUB
	WRITE(25,1241) JSUB
 1241   FORMAT(//' THE BAYESIAN POSTERIOR DENSITY RESULTS FOLLOW FOR '/
     1' SUBJECT NO. ',I4/)
 
	DO 800 IG=1,NACTVE

C  SEE COMMENTS IN LOOP 800 IN MAIN.
 
	DO J=1,NVAR
	 X(J)=CORDEN(IG,J)
	END DO

      CALL MAKEVEC(NVAR,NOFIX,NRANFIX,IRAN,X,VALFIX,RANFIXEST,PX)
	CALL IDPC(PX,W)


	PYJGX=0.D0
 
	IF(W .LE. 22708.D0) PYJGX = DEXP(-.5D0*W)/SIGFAC/OFAC
        PYJGXX(IG) = PYJGX 

       WORK(IG)=PYJGX*CORDEN(IG,NVAR+1)

  800 CONTINUE



C  WORK(IG) = P(YJ,XIG), FOR IG=1,NACTVE.
C  PYJ = P(YJ) = INTEGRAL OF WORK.
 
      CALL NOTINT(VOLSPA,NGRID,NACTVE,WORK,MAXGRD,PYJ)


C  AS OF npagranfix6.f, VERIFY THAT PYJ IS NOT 0 (SIMILARLY TO THE 
C  CODE IN MAIN.

      CALL NOTINT(VOLSPA,NGRID,NACTVE,WORK,MAXGRD,PYJ)
 
C  IF PYJ RETURNS AS 0, IT IS BECAUSE P(X,YJ)=WORK IS 0 IN ALL ITS
C  NACTVE ENTRIES. THIS OCCURS WHEN EACH OF NACTVE VALUES OF W (WHICH
C  RETURNS FROM THE CALLS TO IDPC) IS LARGER THAN 1416 (SINCE P(YJ|X)
C  INVOLVES e RAISED TO THE POWER -.5*W, AND e RAISED TO A POWER
C  SMALLER THAN -708 IS SET TO 0 BY, FOR EXAMPLE, THE COMPAC COMPUTER).


C  IN CASE THIS HAPPENS, PRINT A MESSAGE TO THE USER AND STOP.

      IF (PYJ .EQ. 0.D0) THEN

       WRITE(*,26) JSUB
       WRITE(25,26) JSUB
   26  FORMAT(//' FOR SUBJECT, ',I6,' THE PROB. OF THE OBSERVED'/
     1' CONCENTRATIONS (FOR THE INDICATED DOSAGE REGIMEN), GIVEN EACH '/
     2' AND EVERY GRID POINT IN THE ESTABLISHED GRID, IS 0. THE '/
     3' PROGRAM STOPS. THE USER SHOULD CONSIDER INCREASING THE SIZES'/
     4' OF (C0,C1,C2,C3), THE ASSAY NOISE COEFFICIENTS, WHICH WILL'/
     5' HAVE THE EFFECT OF MAKING THE ABOVE CONDITIONAL PROBABILITES'/
     6' LARGER.')

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,26) JSUB 
        CLOSE(42)

        CALL PAUSE
        STOP

      ENDIF

 


C  THE BAYESIAN POSTERIOR DENSITY OF THIS SUBJECT IS, FOR GRID PT. IG,

C  P(XIG|YJ) = P(YJ,XIG)/P(YJ). PUT THESE VALUES INTO CORDEN(IG,NVAR+1).

	DO IG=1,NACTVE
	 CORDEN(IG,NVAR+1) = WORK(IG)/PYJ
	END DO

C  NEW CODE FOR bigmlt10.f - BELOW


C  CALCULATE HOW MANY OF THE NACTVE GRID POINTS FROM THE FINAL CYCLE
C  ARE "ACTIVE" (WITHIN 1.D-10 OF THE MAXIMUM DENSITY FOR THIS SUBJECT).
C  ... AND, AS OF npageng23.f, ELIMINATE NON-SIGNIFICANT GRID PTS. IN
C  CORDEN (PREVIOUSLY ALL THE POINT FROM THE FINAL CYCLE DENSITY
C  SHOWED UP IN CORDEN, EVEN THOSE WITH INSIGNIFICANT PROBABILITIES).
C  AND NOTE THAT THE BAYESIAN POSTERIOR DENSITY FOR THIS SUBJECT
C  WILL BE STORED INTO BAYPOS(JSUB,.,.), AND PASSED IN COMMON/BAY
C  TO SUBROUTINE READOUT. AND NACTSUB(JSUB) WILL CONTAIN THE NO. OF

C  ACTIVE GRID POINTS FOR THIS SUBJECT'S BAYESIAN POSTERIOR DENSITY.

C  AND NOTE THAT THE NOMINAL DIMENSIONS OF BAYPOS, (800,1500,31),
C  CANNOT BE EXCEEDED BECAUSE THESE ARE THE VALUES FOR MAXSUB, MAXGRD,
C  AND MAXDIM+1, AS SPECIFIED IN THE PARAMETER STATEMENT IN THE PC PREP
C  MAIN MODULE (CURRENTLY NPAG111.FOR). BUT NOTE THAT npageng23.f WILL
C  NOT EXECTUTE WITH THESE DIMENSIONS BECAUSE IT IS TOO BIG FOR A 
C  WIN32 APPLICATION (SEE NPAG111.EXP). SO, IN THIS ROUTINE, AND IN
C  SUBROUTINE READOUT (IN read19.f), THE FIRST DIMENSION HAS BEEN 
C  REDUCED TO 100 (AND SIMILARLY FOR THE DIMENSION OF NACTSUB). IF
C  JSUB > 100, THE BAYESIAN POSTERIOR VALUES BELOW WILL NOT BE STORED.

        DENMAX=CORDEN(1,NVAR+1)

        DO I=1,NACTVE
         D=CORDEN(I,NVAR+1)
         IF(D .GT. DENMAX) DENMAX=D
        END DO
 
        SUMD = 0.D0
        NEWIND = 0

        DO I=1,NACTVE
         D=CORDEN(I,NVAR+1)
          IF(D .GT. 1.D-10*DENMAX) THEN
          SUMD=SUMD+D
          NEWIND=NEWIND+1
           DO J=1,NVAR
            CORDEN(NEWIND,J) = CORDEN(I,J)
            IF(JSUB .LE. 100) BAYPOS(JSUB,NEWIND,J) = CORDEN(I,J)
           END DO
          CORDEN(NEWIND,NVAR+1)=D
         ENDIF
        END DO


C  STORE NACTVE INTO NACTVEFULL BECAUSE THIS VALUE, THE NO. OF ACTIVE
C  GRID POINTS FOR THE ENTIRE POPULATION, IS NEEDED BELOW IN 
C  FORMAT 3258. 


        NACTVEFULL = NACTVE

        NACTVE = NEWIND

C  STORE NACTVE INTO NACTSUB(.) SO IT CAN BE PASSED IN COMMON/BAY TO
C  SUBROUTINE READOUT, ALONG WITH ARRAY BAYPOS. BUT, SEE COMMENTS 
C  ABOVE, ONLY STORE NACTVE IF JSUB .LE. 100.

        IF(JSUB .LE. 100) NACTSUB(JSUB) = NACTVE
 
        FACT = NGRID/VOLSPA/SUMD
 
	DO I=1,NACTVE
	  CORDEN(I,NVAR+1) = CORDEN(I,NVAR+1)*FACT
        IF(JSUB .LE. 100) BAYPOS(JSUB,I,NVAR+1) = CORDEN(I,NVAR+1) 
	END DO


        SLPYJ=DLOG(PYJ)
 
 3010	WRITE(*,8)
    8   FORMAT(/' THE TRUE (NUMERICAL) LOG-LIKELIHOOD OF THE BAYESIAN'/
     1' POSTERIOR DENSITY FOR THIS SUBJECT, ASSUMING THE PRIOR DENSITY'/
     2' IS THE FINAL CYCLE DENSITY FROM THE POPULATION ANALYSIS, IS: ')
	WRITE(*,*) SLPYJ
 
      WRITE(*,3258) NACTVEFULL
3258  FORMAT(/' OF THE ',I7,' ACTIVE GRID POINTS IN THE FINAL CYCLE OF')
      IF(NEWIND .EQ. 1) WRITE(*,3259) NEWIND
3259  FORMAT(' THE RUN, ',I7,' IS ACTIVE FOR THIS SUBJECT.'/)
      IF(NEWIND .GT. 1) WRITE(*,3261) NEWIND 
3261  FORMAT(' THE RUN, ',I7,' ARE ACTIVE FOR THIS SUBJECT.'/)



	 WRITE(25,8)
	 WRITE(25,*) SLPYJ
	 WRITE(25,*)


      WRITE(25,3258) NACTVEFULL
      IF(NEWIND .EQ. 1) WRITE(25,3259) NEWIND
      IF(NEWIND .GT. 1) WRITE(25,3261) NEWIND 

C   NEW CODE FOR bigmlt10.f - ABOVE
 
	
	FACT=VOLSPA/NGRID
	SUM=0.D0
 
	DO I=1,NACTVE
 
	PI=CORDEN(I,NVAR+1)*FACT

	IF (PI .GT. 1.D-200) THEN
	  SUM=SUM+PI*DLOG(PI)
	ENDIF
 
	END DO
 
	DL2=DLOG(2.D0)
	SUM = SUM/DL2
	ENT = -SUM
 
        DGRID=NGRID
	FACT=100.D0*DL2/DLOG(DGRID/NSUB)
	SUM = FACT*(SUM + DLOG(DGRID)/DL2)
 

C  REPLACE WRITING OF SUM AND ENT WITH XVERIFY (SEE LOGIC IN SUBROUTINE
C  VERIFYVAL.

      XVERIFY(1) = SUM
      XVERIFY(2) = ENT
      CALL VERIFYVAL(2,XVERIFY)



C     WRITE(*,31) SUM
	WRITE(*,31) XVERIFY(1)


C	WRITE(*,131) ENT
	WRITE(*,131) XVERIFY(2)


C	WRITE(25,31) SUM
	WRITE(25,31) XVERIFY(1)


C	WRITE(25,131) ENT
	WRITE(25,131) XVERIFY(2)


   31 FORMAT(/' THE SCALED INFO FOR THIS DENSITY IS ',F10.2,' %'/)
  131 FORMAT(/' THE ENTROPY FOR THIS DENSITY IS ',G11.4/)



	DO 1100 I=1,NVAR
 
	DO IG=1,NACTVE
	  WORK(IG)=CORDEN(IG,I)*CORDEN(IG,NVAR+1)
	END DO
 
	II=I
        CALL NOTINT(VOLSPA,NGRID,NACTVE,WORK,MAXGRD,EX(II))
 
	DO 1100 J=1,I
 
	DO IG=1,NACTVE
	  WORK(IG)=CORDEN(IG,I)*CORDEN(IG,J)*CORDEN(IG,NVAR+1)
	END DO
 
	JJ=J
 1100   CALL NOTINT(VOLSPA,NGRID,NACTVE,WORK,MAXGRD,E(II,JJ))
 
 
      DO 190 I=1,NVAR
      DO 190 J=1,I
  190 COV(I,J)=E(I,J)-EX(I)*EX(J)

 
 3030	WRITE(*,*)' THE MEANS ARE: '
	WRITE(25,*)' THE MEANS ARE: '
	WRITE(*,5104) (PAR(I),I=1,NVAR)
        WRITE(25,5104) (PAR(I),I=1,NVAR)
 5104   FORMAT(5X,30(A11,2X))
 

      DO I = 1,NVAR
       XVERIFY(I) = EX(I)
      END DO

      CALL VERIFYVAL(NVAR,XVERIFY)      



C     WRITE(*,5103) (EX(I),I=1,NVAR)
      WRITE(*,5103) (XVERIFY(I),I=1,NVAR)
C     WRITE(25,5103) (EX(I),I=1,NVAR)
      WRITE(25,5103) (XVERIFY(I),I=1,NVAR)


 5103   FORMAT(1X,30(G12.6,1X))


C  SEE COMMENTS IN MAIN ABOUT ICOVL0.
 
      ICOVL0=0

      DO I=1,NVAR
       IF(COV(I,I) .LE. 0.D0) ICOVL0=1
      END DO

      IF(ICOVL0 .EQ. 1) THEN
       DO I = 1,NVAR
        DO J = 1,NVAR
         COV(I,J) = 0.D0
        END DO
       END DO
      ENDIF
 

      WRITE(*,13)
	WRITE(25,13)

   13 FORMAT(/' THE COV MATRIX IS, IN LOWER TRI FORM:')
 
	  WRITE(*,5104) (PAR(I),I=1,NVAR)
        WRITE(25,5104) (PAR(I),I=1,NVAR)
 

      DO 200 I = 1,NVAR

       DO J = 1,I
        XVERIFY(J) = COV(I,J)
       END DO
       CALL VERIFYVAL(I,XVERIFY)

C       WRITE(25,5103) (COV(I,J),J=1,I)
        WRITE(25,5103) (XVERIFY(J),J=1,I)

C 200   WRITE(*,5103) (COV(I,J),J=1,I)
  200   WRITE(*,5103) (XVERIFY(J),J=1,I)	


      DO I = 1,NVAR
       STD(I)=DSQRT(COV(I,I))
       COFVR(I)=STD(I)*1.D2/EX(I)
        DO J = 1,I
         IF(ICOVL0 .EQ. 0) CORR(I,J) = COV(I,J)/STD(I)/STD(J)
         IF(ICOVL0 .EQ. 1) CORR(I,J) = -99.D0
        END DO
      END DO

 
 3040	WRITE(*,6071)
	WRITE(25,6071)
 6071 FORMAT(/' THE STANDARD DEVIATIONS ARE, RESPECTIVELY: ')

 
      WRITE(*,5104) (PAR(I),I=1,NVAR)
      WRITE(25,5104) (PAR(I),I=1,NVAR)
 
      DO I = 1,NVAR
       XVERIFY(I) = STD(I)
      END DO
      CALL VERIFYVAL(NVAR,XVERIFY)      



C     WRITE(*,5103) (STD(I),I=1,NVAR)
      WRITE(*,5103) (XVERIFY(I),I=1,NVAR)
C     WRITE(25,5103) (STD(I),I=1,NVAR)
      WRITE(25,5103) (XVERIFY(I),I=1,NVAR)
 
 
	WRITE(*,6072)
	WRITE(25,6072)


 6072 FORMAT(/' THE PERCENT COEFFICIENTS OF VARIATION ARE, RESP.: ')
 
      WRITE(*,5104) (PAR(I),I=1,NVAR)
      WRITE(25,5104) (PAR(I),I=1,NVAR)
 
      DO I = 1,NVAR
       XVERIFY(I) = COFVR(I)
      END DO
      CALL VERIFYVAL(NVAR,XVERIFY)      



C     WRITE(*,5103) (COFVR(I),I=1,NVAR)
      WRITE(*,5103) (XVERIFY(I),I=1,NVAR)


C     WRITE(25,5103) (COFVR(I),I=1,NVAR)
      WRITE(25,5103) (XVERIFY(I),I=1,NVAR)
 
	WRITE(*,6073)
	WRITE(25,6073)
 6073   FORMAT(/' THE CORR. MATRIX IS, IN LOWER TRIANGULAR FORM: ')
 
      WRITE(*,5104) (PAR(I),I=1,NVAR)
      WRITE(25,5104) (PAR(I),I=1,NVAR)
 

      DO 6080 I=1,NVAR

       DO J = 1,I
        XVERIFY(J) = CORR(I,J)
       END DO
       CALL VERIFYVAL(I,XVERIFY)

C      WRITE(25,5103) (CORR(I,J),J=1,I)
       WRITE(25,5103) (XVERIFY(J),J=1,I)

C6080  WRITE(*,5103) (CORR(I,J),J=1,I)
 6080  WRITE(*,5103) (XVERIFY(J),J=1,I)


 
	WRITE(*,6091) NVAR
	WRITE(25,6091) NVAR
 6091   FORMAT(//' THE FOLLOWING ',I2,' SETS OF LINES GIVE ADDITIONAL'/
     1' STATISTICS FOR THE VARIABLES. FOR EACH SET:'//
     2' THE 1ST LINE GIVES THE MODE, THE SKEWNESS, THE KURTOSIS, AND '/
     3' THE 2.5 %-TILE VALUE OF THE DISTRIBUTION. '//
     4' THE 2ND LINE GIVES THE 25, 50, 75, AND 97.5 %-TILE VALUES OF '/
     5' THE DISTRIBUTION. '//
     6' THE 3RD LINE GIVES THREE ADDITIONAL AD-HOC ESTIMATES OF THE '/
     6' STANDARD DEVIATION FOR THAT MARGINAL DENSITY. THE 1ST S.D. '/
     7' ESTIMATE IS THE STANDARD DEVIATION OF A NORMAL DISTRIBUTION '/
     8' HAVING THE SAME [25, 75] %-TILE RANGE AS THAT VARIABLE. THE'/
     9' 2ND ESTIMATE IS THE STANDARD DEVIATION OF A NORMAL DIST.'/
     1' HAVING THE SAME [2.5, 97.5] %-TILE RANGE AS THAT VARIABLE. THE'/
     2' 3RD ESTIMATE IS THE AVERAGE OF THE FIRST TWO. THE 4TH VALUE'/
     3' IN THE LINE IS THE THE % SCALED INFO FOR THAT MARGINAL DENS.'//)
 
 

	DO 6090 I=1,NVAR



	IND=I
 
	CALL STAZ(VOLSPA,NGRID,NACTVE,NVAR,IND,CORDEN,WORK,MAXGRD,NINT,
     1  AB(IND,1),AB(IND,2),XMODE,X025,X25,X50,X75,X975,SCALINFO,NSUB,

     2  MAXDIM)
 
C  STORE THE MEDIANS AND MODES.
 
	CENTER(2,IND)=X50
	CENTER(3,IND)=XMODE
 
	SDEST1 = (X75-X25)/1.349
	SDEST2 = (X975-X025)/3.92
	SDEST3 = .5D0*(SDEST1+SDEST2)
 
	IF(ICOVL0 .EQ. 1) THEN
	  SK = -99999999
	  KU = -99999999
	ENDIF
 
	IF(ICOVL0 .EQ. 0) THEN
 
	DO IG=1,NACTVE
	  XX = CORDEN(IG,IND)
          WORK(IG) = CORDEN(IG,NVAR+1)*(XX-EX(IND))**3
	END DO
 
        CALL NOTINT(VOLSPA,NGRID,NACTVE,WORK,MAXGRD,SK)
	SK=SK/STD(I)**3
 

	DO IG=1,NACTVE
	  XX = CORDEN(IG,IND)
          WORK(IG) = CORDEN(IG,NVAR+1)*(XX-EX(IND))**4
	END DO
 
        CALL NOTINT(VOLSPA,NGRID,NACTVE,WORK,MAXGRD,KU)
	KU=KU/STD(I)**4
 
	ENDIF
 
 
	WRITE(*,6092) PAR(IND)
	WRITE(25,6092) PAR(IND)

 6092   FORMAT(/' ',A11,':')
 
       XVERIFY(1) = XMODE
       XVERIFY(2) = SK
       XVERIFY(3) = KU   
       XVERIFY(4) = X025
       CALL VERIFYVAL(4,XVERIFY)

C      WRITE(*,6093) XMODE,SK,KU,X025
       WRITE(*,6093) (XVERIFY(IXV),IXV=1,4) 


C      WRITE(25,6093) XMODE,SK,KU,X025
       WRITE(25,6093) (XVERIFY(IXV),IXV=1,4) 

       XVERIFY(1) = X25
       XVERIFY(2) = X50
       XVERIFY(3) = X75  
       XVERIFY(4) = X975
       CALL VERIFYVAL(4,XVERIFY)

C      WRITE(*,6093) X25,X50,X75,X975
       WRITE(*,6093) (XVERIFY(IXV),IXV=1,4) 

C      WRITE(25,6093) X25,X50,X75,X975
       WRITE(25,6093) (XVERIFY(IXV),IXV=1,4) 
 
       XVERIFY(1) = SDEST1
       XVERIFY(2) = SDEST2
       XVERIFY(3) = SDEST3
       XVERIFY(4) = SCALINFO
       CALL VERIFYVAL(4,XVERIFY)

C      WRITE(*,6093) SDEST1,SDEST2,SDEST3,SCALINFO
       WRITE(*,6093) (XVERIFY(IXV),IXV=1,4) 

C      WRITE(25,6093) SDEST1,SDEST2,SDEST3,SCALINFO
       WRITE(25,6093) (XVERIFY(IXV),IXV=1,4) 

 6093  FORMAT(1X,4(G15.8,2X))
 
 6090   CONTINUE



      WRITE(*,*)
      WRITE(25,*)
 
C  STORE THE MEANS INTO CENTER(1,.). CENTER(2,.) AND CENTER(3,.)
C  THE MEDIANS AND MODES WERE STORED JUST BELOW THE CALL TO STAT.
 

	 DO I=1,NVAR
	  CENTER(1,I)=EX(I)
	 END DO
 
	RETURN

	END

CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

C  VODTOT.FOR							5-2-96
 
C  VODTOT.FOR CONTAINS MODULES VODE.FOR AND VODEXT.FOR.
 
C----------------------------------------------------------------------
 
*DECK DVODE
      SUBROUTINE DVODE (F, NEQ, Y, T, TOUT, ITOL, RTOL, ATOL, ITASK,
     1            ISTATE, IOPT, RWORK, LRW, IWORK, LIW, JAC, MF,
     2            RPAR, IPAR)
      EXTERNAL F, JAC
      DOUBLE PRECISION Y, T, TOUT, RTOL, ATOL, RWORK, RPAR
      INTEGER NEQ, ITOL, ITASK, ISTATE, IOPT, LRW, IWORK, LIW,
     1        MF, IPAR
      DIMENSION Y(*), ATOL(*), RWORK(LRW), IWORK(LIW)

c-----------------------------------------------------------------------

c - SPECIAL CHANGE FOR bigmlt10.f

c  When Andreas' Intel compiler compiles the program, it objects to
c  RPAR and IPAR being dimensioned (as (*)) in Subroutine DVODE (and
c  routines called by DVODE) when they are not dimensioned in 
c  Subroutine USERANAL (in idm1x5.f). The comments in DVODE state that
c  if these values are not being used, they do not need to be 
c  dimensioned in routines that call DVODE. Nevertheless, to remove the
c  Intel objection, RPAR(*) and IPAR(*) are removed from the 5 routines
c  in this module which declare them arrays.

c  Similarly, RTOL supposedly does not need to be dimensioned in 

c  USERANAL since it is a scalar, but the Intel compiler objects to
c  having it dimensioned (*) in DVODE, etc. when it is a scalar in
c  USERANAL. So, all RTOL(*) occurrences are removed in this module,
c  and all references to RTOL(1), RTOL(I), etc. are changed to RTOL.

C-----------------------------------------------------------------------
C DVODE.. Variable-coefficient Ordinary Differential Equation solver,
C with fixed-leading coefficient implementation.
C This version is in double precision.
C
C DVODE solves the initial value problem for stiff or nonstiff
C systems of first order ODEs,
C     dy/dt = f(t,y) ,  or, in component form,
C     dy(i)/dt = f(i) = f(i,t,y(1),y(2),...,y(NEQ)) (i = 1,...,NEQ).
C DVODE is a package based on the EPISODE and EPISODEB packages, and
C on the ODEPACK user interface standard, with minor modifications.
C-----------------------------------------------------------------------
C Revision History (YYMMDD)
C   890615  Date Written
C   890922  Added interrupt/restart ability, minor changes throughout.
C   910228  Minor revisions in line format,  prologue, etc.
C   920227  Modifications by D. Pang:
C           (1) Applied subgennam to get generic intrinsic names.
C           (2) Changed intrinsic names to generic in comments.
C           (3) Added *DECK lines before each routine.
C   920721  Names of routines and labeled Common blocks changed, so as
C           to be unique in combined single/double precision code (ACH).

C   920722  Minor revisions to prologue (ACH).
C   920831  Conversion to double precision done (ACH).
C-----------------------------------------------------------------------
C References..

C
C 1. P. N. Brown, G. D. Byrne, and A. C. Hindmarsh, "VODE: A Variable
C    Coefficient ODE Solver," SIAM J. Sci. Stat. Comput., 10 (1989),
C    pp. 1038-1051.  Also, LLNL Report UCRL-98412, June 1988.
C 2. G. D. Byrne and A. C. Hindmarsh, "A Polyalgorithm for the
C    Numerical Solution of Ordinary Differential Equations,"
C    ACM Trans. Math. Software, 1 (1975), pp. 71-96.
C 3. A. C. Hindmarsh and G. D. Byrne, "EPISODE: An Effective Package
C    for the Integration of Systems of Ordinary Differential
C    Equations," LLNL Report UCID-30112, Rev. 1, April 1977.
C 4. G. D. Byrne and A. C. Hindmarsh, "EPISODEB: An Experimental
C    Package for the Integration of Systems of Ordinary Differential
C    Equations with Banded Jacobians," LLNL Report UCID-30132, April
C    1976.

C 5. A. C. Hindmarsh, "ODEPACK, a Systematized Collection of ODE
C    Solvers," in Scientific Computing, R. S. Stepleman et al., eds.,
C    North-Holland, Amsterdam, 1983, pp. 55-64.
C 6. K. R. Jackson and R. Sacks-Davis, "An Alternative Implementation

C    of Variable Step-Size Multistep Formulas for Stiff ODEs," ACM
C    Trans. Math. Software, 6 (1980), pp. 295-318.
C-----------------------------------------------------------------------
C Authors..
C
C               Peter N. Brown and Alan C. Hindmarsh
C               Computing and Mathematics Research Division, L-316
C               Lawrence Livermore National Laboratory
C               Livermore, CA 94550
C and
C               George D. Byrne
C               Exxon Research and Engineering Co.
C               Clinton Township
C               Route 22 East

C               Annandale, NJ 08801

C-----------------------------------------------------------------------
C Summary of usage.
C
C Communication between the user and the DVODE package, for normal
C situations, is summarized here.  This summary describes only a subset
C of the full set of options available.  See the full description for
C details, including optional communication, nonstandard options,
C and instructions for special situations.  See also the example
C problem (with program and output) following this summary.
C
C A. First provide a subroutine of the form..
C
C           SUBROUTINE F (NEQ, T, Y, YDOT, RPAR, IPAR)
C           DOUBLE PRECISION T, Y, YDOT, RPAR
C           DIMENSION Y(NEQ), YDOT(NEQ)
C
C which supplies the vector function f by loading YDOT(i) with f(i).
C
C B. Next determine (or guess) whether or not the problem is stiff.
C Stiffness occurs when the Jacobian matrix df/dy has an eigenvalue
C whose real part is negative and large in magnitude, compared to the
C reciprocal of the t span of interest.  If the problem is nonstiff,
C use a method flag MF = 10.  If it is stiff, there are four standard
C choices for MF (21, 22, 24, 25), and DVODE requires the Jacobian
C matrix in some form.  In these cases (MF .gt. 0), DVODE will use a
C saved copy of the Jacobian matrix.  If this is undesirable because of
C storage limitations, set MF to the corresponding negative value
C (-21, -22, -24, -25).  (See full description of MF below.)
C The Jacobian matrix is regarded either as full (MF = 21 or 22),
C or banded (MF = 24 or 25).  In the banded case, DVODE requires two
C half-bandwidth parameters ML and MU.  These are, respectively, the
C widths of the lower and upper parts of the band, excluding the main
C diagonal.  Thus the band consists of the locations (i,j) with
C i-ML .le. j .le. i+MU, and the full bandwidth is ML+MU+1.
C
C C. If the problem is stiff, you are encouraged to supply the Jacobian
C directly (MF = 21 or 24), but if this is not feasible, DVODE will

C compute it internally by difference quotients (MF = 22 or 25).
C If you are supplying the Jacobian, provide a subroutine of the form..
C
C           SUBROUTINE JAC (NEQ, T, Y, ML, MU, PD, NROWPD, RPAR, IPAR)
C           DOUBLE PRECISION T, Y, PD, RPAR
C           DIMENSION Y(NEQ), PD(NROWPD,NEQ)
C
C which supplies df/dy by loading PD as follows..
C     For a full Jacobian (MF = 21), load PD(i,j) with df(i)/dy(j),
C the partial derivative of f(i) with respect to y(j).  (Ignore the
C ML and MU arguments in this case.)
C     For a banded Jacobian (MF = 24), load PD(i-j+MU+1,j) with
C df(i)/dy(j), i.e. load the diagonal lines of df/dy into the rows of
C PD from the top down.
C     In either case, only nonzero elements need be loaded.
C
C D. Write a main program which calls subroutine DVODE once for
C each point at which answers are desired.  This should also provide
C for possible use of logical unit 6 for output of error messages
C by DVODE.  On the first call to DVODE, supply arguments as follows..

C F      = Name of subroutine for right-hand side vector f.
C          This name must be declared external in calling program.

C NEQ    = Number of first order ODE-s.
C Y      = Array of initial values, of length NEQ.
C T      = The initial value of the independent variable.
C TOUT   = First point where output is desired (.ne. T).
C ITOL   = 1 or 2 according as ATOL (below) is a scalar or array.
C RTOL   = Relative tolerance parameter (scalar).

C ATOL   = Absolute tolerance parameter (scalar or array).
C          The estimated local error in Y(i) will be controlled so as
C          to be roughly less (in magnitude) than

C             EWT(i) = RTOL*abs(Y(i)) + ATOL     if ITOL = 1, or
C             EWT(i) = RTOL*abs(Y(i)) + ATOL(i)  if ITOL = 2.
C          Thus the local error test passes if, in each component,
C          either the absolute error is less than ATOL (or ATOL(i)),
C          or the relative error is less than RTOL.
C          Use RTOL = 0.0 for pure absolute error control, and
C          use ATOL = 0.0 (or ATOL(i) = 0.0) for pure relative error
C          control.  Caution.. Actual (global) errors may exceed these
C          local tolerances, so choose them conservatively.
C ITASK  = 1 for normal computation of output values of Y at t = TOUT.

C ISTATE = Integer flag (input and output).  Set ISTATE = 1.
C IOPT   = 0 to indicate no optional input used.
C RWORK  = Real work array of length at least..
C             20 + 16*NEQ                      for MF = 10,

C             22 +  9*NEQ + 2*NEQ**2           for MF = 21 or 22,
C             22 + 11*NEQ + (3*ML + 2*MU)*NEQ  for MF = 24 or 25.
C LRW    = Declared length of RWORK (in user's DIMENSION statement).
C IWORK  = Integer work array of length at least..

C             30        for MF = 10,
C             30 + NEQ  for MF = 21, 22, 24, or 25.
C          If MF = 24 or 25, input in IWORK(1),IWORK(2) the lower
C          and upper half-bandwidths ML,MU.
C LIW    = Declared length of IWORK (in user's DIMENSION).
C JAC    = Name of subroutine for Jacobian matrix (MF = 21 or 24).
C          If used, this name must be declared external in calling
C          program.  If not used, pass a dummy name.

C MF     = Method flag.  Standard values are..
C          10 for nonstiff (Adams) method, no Jacobian used.
C          21 for stiff (BDF) method, user-supplied full Jacobian.
C          22 for stiff method, internally generated full Jacobian.
C          24 for stiff method, user-supplied banded Jacobian.
C          25 for stiff method, internally generated banded Jacobian.
C RPAR,IPAR = user-defined real and integer arrays passed to F and JAC.
C Note that the main program must declare arrays Y, RWORK, IWORK,
C and possibly ATOL, RPAR, and IPAR.
C
C E. The output from the first call (or any call) is..
C      Y = Array of computed values of y(t) vector.
C      T = Corresponding value of independent variable (normally TOUT).
C ISTATE = 2  if DVODE was successful, negative otherwise.
C          -1 means excess work done on this call. (Perhaps wrong MF.)
C          -2 means excess accuracy requested. (Tolerances too small.)
C          -3 means illegal input detected. (See printed message.)
C          -4 means repeated error test failures. (Check all input.)
C          -5 means repeated convergence failures. (Perhaps bad
C             Jacobian supplied or wrong choice of MF or tolerances.)
C          -6 means error weight became zero during problem. (Solution
C             component i vanished, and ATOL or ATOL(i) = 0.)
C
C F. To continue the integration after a successful return, simply
C reset TOUT and call DVODE again.  No other parameters need be reset.

C
C-----------------------------------------------------------------------
C EXAMPLE PROBLEM
C
C The following is a simple example problem, with the coding
C needed for its solution by DVODE.  The problem is from chemical
C kinetics, and consists of the following three rate equations..
C     dy1/dt = -.04*y1 + 1.e4*y2*y3
C     dy2/dt = .04*y1 - 1.e4*y2*y3 - 3.e7*y2**2

C     dy3/dt = 3.e7*y2**2

C on the interval from t = 0.0 to t = 4.e10, with initial conditions
C y1 = 1.0, y2 = y3 = 0.  The problem is stiff.

C

C The following coding solves this problem with DVODE, using MF = 21
C and printing results at t = .4, 4., ..., 4.e10.  It uses
C ITOL = 2 and ATOL much smaller for y2 than y1 or y3 because
C y2 has much smaller values.
C At the end of the run, statistical quantities of interest are
C printed. (See optional output in the full description below.)
C To generate Fortran source code, replace C in column 1 with a blank
C in the coding below.
C
C     EXTERNAL FEX, JEX
C     DOUBLE PRECISION ATOL, RPAR, RTOL, RWORK, T, TOUT, Y
C     DIMENSION Y(3), ATOL(3), RWORK(67), IWORK(33)
C     NEQ = 3
C     Y(1) = 1.0D0
C     Y(2) = 0.0D0
C     Y(3) = 0.0D0
C     T = 0.0D0
C     TOUT = 0.4D0
C     ITOL = 2

C     RTOL = 1.D-4
C     ATOL(1) = 1.D-8

C     ATOL(2) = 1.D-14
C     ATOL(3) = 1.D-6

C     ITASK = 1
C     ISTATE = 1

C     IOPT = 0
C     LRW = 67
C     LIW = 33
C     MF = 21
C     DO 40 IOUT = 1,12
C       CALL DVODE(FEX,NEQ,Y,T,TOUT,ITOL,RTOL,ATOL,ITASK,ISTATE,
C    1            IOPT,RWORK,LRW,IWORK,LIW,JEX,MF,RPAR,IPAR)

C       WRITE(6,20)T,Y(1),Y(2),Y(3)
C 20    FORMAT(' At t =',D12.4,'   y =',3D14.6)
C       IF (ISTATE .LT. 0) GO TO 80
C 40    TOUT = TOUT*10.
C     WRITE(6,60) IWORK(11),IWORK(12),IWORK(13),IWORK(19),
C    1            IWORK(20),IWORK(21),IWORK(22)
C 60  FORMAT(/' No. steps =',I4,'   No. f-s =',I4,
C    1       '   No. J-s =',I4,'   No. LU-s =',I4/
C    2       '  No. nonlinear iterations =',I4/
C    3       '  No. nonlinear convergence failures =',I4/

C    4       '  No. error test failures =',I4/)
C     STOP

C 80  WRITE(6,90)ISTATE
C 90  FORMAT(///' Error halt.. ISTATE =',I3)
C     STOP
C     END
C
C     SUBROUTINE FEX (NEQ, T, Y, YDOT, RPAR, IPAR)
C     DOUBLE PRECISION RPAR, T, Y, YDOT
C     DIMENSION Y(NEQ), YDOT(NEQ)
C     YDOT(1) = -.04D0*Y(1) + 1.D4*Y(2)*Y(3)

C     YDOT(3) = 3.D7*Y(2)*Y(2)
C     YDOT(2) = -YDOT(1) - YDOT(3)
C     RETURN
C     END
C
C     SUBROUTINE JEX (NEQ, T, Y, ML, MU, PD, NRPD, RPAR, IPAR)
C     DOUBLE PRECISION PD, RPAR, T, Y
C     DIMENSION Y(NEQ), PD(NRPD,NEQ)
C     PD(1,1) = -.04D0

C     PD(1,2) = 1.D4*Y(3)
C     PD(1,3) = 1.D4*Y(2)
C     PD(2,1) = .04D0
C     PD(2,3) = -PD(1,3)
C     PD(3,2) = 6.D7*Y(2)
C     PD(2,2) = -PD(1,2) - PD(3,2)
C     RETURN
C     END
C
C The following output was obtained from the above program on a
C Cray-1 computer with the CFT compiler.

C
C At t =  4.0000e-01   y =  9.851680e-01  3.386314e-05  1.479817e-02
C At t =  4.0000e+00   y =  9.055255e-01  2.240539e-05  9.445214e-02
C At t =  4.0000e+01   y =  7.158108e-01  9.184883e-06  2.841800e-01
C At t =  4.0000e+02   y =  4.505032e-01  3.222940e-06  5.494936e-01
C At t =  4.0000e+03   y =  1.832053e-01  8.942690e-07  8.167938e-01
C At t =  4.0000e+04   y =  3.898560e-02  1.621875e-07  9.610142e-01
C At t =  4.0000e+05   y =  4.935882e-03  1.984013e-08  9.950641e-01
C At t =  4.0000e+06   y =  5.166183e-04  2.067528e-09  9.994834e-01
C At t =  4.0000e+07   y =  5.201214e-05  2.080593e-10  9.999480e-01
C At t =  4.0000e+08   y =  5.213149e-06  2.085271e-11  9.999948e-01
C At t =  4.0000e+09   y =  5.183495e-07  2.073399e-12  9.999995e-01
C At t =  4.0000e+10   y =  5.450996e-08  2.180399e-13  9.999999e-01
C
C No. steps = 595   No. f-s = 832   No. J-s =  13   No. LU-s = 112
C  No. nonlinear iterations = 831
C  No. nonlinear convergence failures =   0
C  No. error test failures =  22
C-----------------------------------------------------------------------
C Full description of user interface to DVODE.
C
C The user interface to DVODE consists of the following parts.
C
C i.   The call sequence to subroutine DVODE, which is a driver
C      routine for the solver.  This includes descriptions of both
C      the call sequence arguments and of user-supplied routines.
C      Following these descriptions is
C        * a description of optional input available through the
C          call sequence,
C        * a description of optional output (in the work arrays), and
C        * instructions for interrupting and restarting a solution.
C
C ii.  Descriptions of other routines in the DVODE package that may be
C      (optionally) called by the user.  These provide the ability to
C      alter error message handling, save and restore the internal
C      COMMON, and obtain specified derivatives of the solution y(t).
C
C iii. Descriptions of COMMON blocks to be declared in overlay
C      or similar environments.
C
C iv.  Description of two routines in the DVODE package, either of
C      which the user may replace with his own version, if desired.
C      these relate to the measurement of errors.

C
C-----------------------------------------------------------------------
C Part i.  Call Sequence.
C
C The call sequence parameters used for input only are
C     F, NEQ, TOUT, ITOL, RTOL, ATOL, ITASK, IOPT, LRW, LIW, JAC, MF,
C and those used for both input and output are
C     Y, T, ISTATE.
C The work arrays RWORK and IWORK are also used for conditional and
C optional input and optional output.  (The term output here refers
C to the return from subroutine DVODE to the user's calling program.)

C
C The legality of input parameters will be thoroughly checked on the
C initial call for the problem, but not checked thereafter unless a
C change in input parameters is flagged by ISTATE = 3 in the input.

C

C The descriptions of the call arguments are as follows.
C
C F      = The name of the user-supplied subroutine defining the
C          ODE system.  The system must be put in the first-order
C          form dy/dt = f(t,y), where f is a vector-valued function
C          of the scalar t and the vector y.  Subroutine F is to
C          compute the function f.  It is to have the form

C               SUBROUTINE F (NEQ, T, Y, YDOT, RPAR, IPAR)
C               DOUBLE PRECISION T, Y, YDOT, RPAR

C               DIMENSION Y(NEQ), YDOT(NEQ)
C          where NEQ, T, and Y are input, and the array YDOT = f(t,y)
C          is output.  Y and YDOT are arrays of length NEQ.
C          (In the DIMENSION statement above, NEQ  can be replaced by
C          *  to make  Y  and  YDOT  assumed size arrays.)
C          Subroutine F should not alter Y(1),...,Y(NEQ).
C          F must be declared EXTERNAL in the calling program.

C
C          Subroutine F may access user-defined real and integer
C          work arrays RPAR and IPAR, which are to be dimensioned
C          in the main program.
C
C          If quantities computed in the F routine are needed
C          externally to DVODE, an extra call to F should be made

C          for this purpose, for consistent and accurate results.
C          If only the derivative dy/dt is needed, use DVINDY instead.
C
C NEQ    = The size of the ODE system (number of first order
C          ordinary differential equations).  Used only for input.
C          NEQ may not be increased during the problem, but
C          can be decreased (with ISTATE = 3 in the input).

C
C Y      = A real array for the vector of dependent variables, of

C          length NEQ or more.  Used for both input and output on the
C          first call (ISTATE = 1), and only for output on other calls.
C          On the first call, Y must contain the vector of initial
C          values.  In the output, Y contains the computed solution
C          evaluated at T.  If desired, the Y array may be used

C          for other purposes between calls to the solver.
C
C          This array is passed as the Y argument in all calls to
C          F and JAC.
C
C T      = The independent variable.  In the input, T is used only on
C          the first call, as the initial point of the integration.
C          In the output, after each call, T is the value at which a
C          computed solution Y is evaluated (usually the same as TOUT).
C          On an error return, T is the farthest point reached.

C
C TOUT   = The next value of t at which a computed solution is desired.
C          Used only for input.
C
C          When starting the problem (ISTATE = 1), TOUT may be equal
C          to T for one call, then should .ne. T for the next call.
C          For the initial T, an input value of TOUT .ne. T is used
C          in order to determine the direction of the integration
C          (i.e. the algebraic sign of the step sizes) and the rough
C          scale of the problem.  Integration in either direction
C          (forward or backward in t) is permitted.
C
C          If ITASK = 2 or 5 (one-step modes), TOUT is ignored after
C          the first call (i.e. the first call with TOUT .ne. T).
C          Otherwise, TOUT is required on every call.
C
C          If ITASK = 1, 3, or 4, the values of TOUT need not be

C          monotone, but a value of TOUT which backs up is limited
C          to the current internal t interval, whose endpoints are
C          TCUR - HU and TCUR.  (See optional output, below, for
C          TCUR and HU.)
C
C ITOL   = An indicator for the type of error control.  See
C          description below under ATOL.  Used only for input.
C
C RTOL   = A relative error tolerance parameter, either a scalar or
C          an array of length NEQ.  See description below under ATOL.
C          Input only.
C
C ATOL   = An absolute error tolerance parameter, either a scalar or
C          an array of length NEQ.  Input only.
C
C          The input parameters ITOL, RTOL, and ATOL determine
C          the error control performed by the solver.  The solver will
C          control the vector e = (e(i)) of estimated local errors
C          in Y, according to an inequality of the form

C                      rms-norm of ( e(i)/EWT(i) )   .le.   1,
C          where       EWT(i) = RTOL(i)*abs(Y(i)) + ATOL(i),
C          and the rms-norm (root-mean-square norm) here is
C          rms-norm(v) = sqrt(sum v(i)**2 / NEQ).  Here EWT = (EWT(i))
C          is a vector of weights which must always be positive, and
C          the values of RTOL and ATOL should all be non-negative.
C          The following table gives the types (scalar/array) of
C          RTOL and ATOL, and the corresponding form of EWT(i).
C
C             ITOL    RTOL       ATOL          EWT(i)
C              1     scalar     scalar     RTOL*ABS(Y(i)) + ATOL
C              2     scalar     array      RTOL*ABS(Y(i)) + ATOL(i)
C              3     array      scalar     RTOL(i)*ABS(Y(i)) + ATOL
C              4     array      array      RTOL(i)*ABS(Y(i)) + ATOL(i)
C
C          When either of these parameters is a scalar, it need not
C          be dimensioned in the user's calling program.
C
C          If none of the above choices (with ITOL, RTOL, and ATOL
C          fixed throughout the problem) is suitable, more general
C          error controls can be obtained by substituting
C          user-supplied routines for the setting of EWT and/or for
C          the norm calculation.  See Part iv below.
C
C          If global errors are to be estimated by making a repeated
C          run on the same problem with smaller tolerances, then all
C          components of RTOL and ATOL (i.e. of EWT) should be scaled
C          down uniformly.
C
C ITASK  = An index specifying the task to be performed.
C          Input only.  ITASK has the following values and meanings.
C          1  means normal computation of output values of y(t) at
C             t = TOUT (by overshooting and interpolating).
C          2  means take one step only and return.


C          3  means stop at the first internal mesh point at or

C             beyond t = TOUT and return.
C          4  means normal computation of output values of y(t) at
C             t = TOUT but without overshooting t = TCRIT.
C             TCRIT must be input as RWORK(1).  TCRIT may be equal to
C             or beyond TOUT, but not behind it in the direction of
C             integration.  This option is useful if the problem
C             has a singularity at or beyond t = TCRIT.
C          5  means take one step, without passing TCRIT, and return.
C             TCRIT must be input as RWORK(1).
C
C          Note..  If ITASK = 4 or 5 and the solver reaches TCRIT
C          (within roundoff), it will return T = TCRIT (exactly) to
C          indicate this (unless ITASK = 4 and TOUT comes before TCRIT,
C          in which case answers at T = TOUT are returned first).
C
C ISTATE = an index used for input and output to specify the
C          the state of the calculation.
C
C          In the input, the values of ISTATE are as follows.
C          1  means this is the first call for the problem
C             (initializations will be done).  See note below.
C          2  means this is not the first call, and the calculation
C             is to continue normally, with no change in any input
C             parameters except possibly TOUT and ITASK.
C             (If ITOL, RTOL, and/or ATOL are changed between calls
C             with ISTATE = 2, the new values will be used but not

C             tested for legality.)
C          3  means this is not the first call, and the
C             calculation is to continue normally, but with
C             a change in input parameters other than
C             TOUT and ITASK.  Changes are allowed in
C             NEQ, ITOL, RTOL, ATOL, IOPT, LRW, LIW, MF, ML, MU,

C             and any of the optional input except H0.
C             (See IWORK description for ML and MU.)

C          Note..  A preliminary call with TOUT = T is not counted
C          as a first call here, as no initialization or checking of
C          input is done.  (Such a call is sometimes useful to include
C          the initial conditions in the output.)
C          Thus the first call for which TOUT .ne. T requires
C          ISTATE = 1 in the input.
C

C          In the output, ISTATE has the following values and meanings.
C           1  means nothing was done, as TOUT was equal to T with
C              ISTATE = 1 in the input.
C           2  means the integration was performed successfully.
C          -1  means an excessive amount of work (more than MXSTEP
C              steps) was done on this call, before completing the
C              requested task, but the integration was otherwise
C              successful as far as T.  (MXSTEP is an optional input
C              and is normally 500.)  To continue, the user may
C              simply reset ISTATE to a value .gt. 1 and call again.
C              (The excess work step counter will be reset to 0.)
C              In addition, the user may increase MXSTEP to avoid
C              this error return.  (See optional input below.)
C          -2  means too much accuracy was requested for the precision
C              of the machine being used.  This was detected before
C              completing the requested task, but the integration
C              was successful as far as T.  To continue, the tolerance
C              parameters must be reset, and ISTATE must be set
C              to 3.  The optional output TOLSF may be used for this
C              purpose.  (Note.. If this condition is detected before
C              taking any steps, then an illegal input return
C              (ISTATE = -3) occurs instead.)
C          -3  means illegal input was detected, before taking any
C              integration steps.  See written message for details.
C              Note..  If the solver detects an infinite loop of calls
C              to the solver with illegal input, it will cause
C              the run to stop.

C          -4  means there were repeated error test failures on
C              one attempted step, before completing the requested
C              task, but the integration was successful as far as T.
C              The problem may have a singularity, or the input
C              may be inappropriate.
C          -5  means there were repeated convergence test failures on
C              one attempted step, before completing the requested

C              task, but the integration was successful as far as T.
C              This may be caused by an inaccurate Jacobian matrix,
C              if one is being used.
C          -6  means EWT(i) became zero for some i during the
C              integration.  Pure relative error control (ATOL(i)=0.0)
C              was requested on a variable which has now vanished.
C              The integration was successful as far as T.
C
C          Note..  Since the normal output value of ISTATE is 2,
C          it does not need to be reset for normal continuation.

C          Also, since a negative input value of ISTATE will be
C          regarded as illegal, a negative output value requires the
C          user to change it, and possibly other input, before
C          calling the solver again.
C
C IOPT   = An integer flag to specify whether or not any optional
C          input is being used on this call.  Input only.
C          The optional input is listed separately below.
C          IOPT = 0 means no optional input is being used.
C                   Default values will be used in all cases.
C          IOPT = 1 means optional input is being used.
C
C RWORK  = A real working array (double precision).
C          The length of RWORK must be at least
C             20 + NYH*(MAXORD + 1) + 3*NEQ + LWM    where

C          NYH    = the initial value of NEQ,
C          MAXORD = 12 (if METH = 1) or 5 (if METH = 2) (unless a
C                   smaller value is given as an optional input),
C          LWM = length of work space for matrix-related data..
C          LWM = 0             if MITER = 0,
C          LWM = 2*NEQ**2 + 2  if MITER = 1 or 2, and MF.gt.0,
C          LWM = NEQ**2 + 2    if MITER = 1 or 2, and MF.lt.0,
C          LWM = NEQ + 2       if MITER = 3,

C          LWM = (3*ML+2*MU+2)*NEQ + 2 if MITER = 4 or 5, and MF.gt.0,
C          LWM = (2*ML+MU+1)*NEQ + 2   if MITER = 4 or 5, and MF.lt.0.
C          (See the MF description for METH and MITER.)
C          Thus if MAXORD has its default value and NEQ is constant,
C          this length is..


C             20 + 16*NEQ                    for MF = 10,
C             22 + 16*NEQ + 2*NEQ**2         for MF = 11 or 12,
C             22 + 16*NEQ + NEQ**2           for MF = -11 or -12,
C             22 + 17*NEQ                    for MF = 13,
C             22 + 18*NEQ + (3*ML+2*MU)*NEQ  for MF = 14 or 15,
C             22 + 17*NEQ + (2*ML+MU)*NEQ    for MF = -14 or -15,
C             20 +  9*NEQ                    for MF = 20,
C             22 +  9*NEQ + 2*NEQ**2         for MF = 21 or 22,
C             22 +  9*NEQ + NEQ**2           for MF = -21 or -22,
C             22 + 10*NEQ                    for MF = 23,
C             22 + 11*NEQ + (3*ML+2*MU)*NEQ  for MF = 24 or 25.
C             22 + 10*NEQ + (2*ML+MU)*NEQ    for MF = -24 or -25.
C          The first 20 words of RWORK are reserved for conditional
C          and optional input and optional output.
C
C          The following word in RWORK is a conditional input..
C            RWORK(1) = TCRIT = critical value of t which the solver
C                       is not to overshoot.  Required if ITASK is
C                       4 or 5, and ignored otherwise.  (See ITASK.)
C
C LRW    = The length of the array RWORK, as declared by the user.


C          (This will be checked by the solver.)
C
C IWORK  = An integer work array.  The length of IWORK must be at least
C             30        if MITER = 0 or 3 (MF = 10, 13, 20, 23), or
C             30 + NEQ  otherwise (abs(MF) = 11,12,14,15,21,22,24,25).
C          The first 30 words of IWORK are reserved for conditional and
C          optional input and optional output.
C
C          The following 2 words in IWORK are conditional input..
C            IWORK(1) = ML     These are the lower and upper
C            IWORK(2) = MU     half-bandwidths, respectively, of the
C                       banded Jacobian, excluding the main diagonal.
C                       The band is defined by the matrix locations
C                       (i,j) with i-ML .le. j .le. i+MU.  ML and MU
C                       must satisfy  0 .le.  ML,MU  .le. NEQ-1.
C                       These are required if MITER is 4 or 5, and
C                       ignored otherwise.  ML and MU may in fact be
C                       the band parameters for a matrix to which
C                       df/dy is only approximately equal.
C
C LIW    = the length of the array IWORK, as declared by the user.
C          (This will be checked by the solver.)
C
C Note..  The work arrays must not be altered between calls to DVODE
C for the same problem, except possibly for the conditional and
C optional input, and except for the last 3*NEQ words of RWORK.
C The latter space is used for internal scratch space, and so is
C available for use by the user outside DVODE between calls, if
C desired (but not for use by F or JAC).
C
C JAC    = The name of the user-supplied routine (MITER = 1 or 4) to
C          compute the Jacobian matrix, df/dy, as a function of
C          the scalar t and the vector y.  It is to have the form
C               SUBROUTINE JAC (NEQ, T, Y, ML, MU, PD, NROWPD,
C                               RPAR, IPAR)
C               DOUBLE PRECISION T, Y, PD, RPAR
C               DIMENSION Y(NEQ), PD(NROWPD, NEQ)
C          where NEQ, T, Y, ML, MU, and NROWPD are input and the array
C          PD is to be loaded with partial derivatives (elements of the
C          Jacobian matrix) in the output.  PD must be given a first
C          dimension of NROWPD.  T and Y have the same meaning as in
C          Subroutine F.  (In the DIMENSION statement above, NEQ can
C          be replaced by  *  to make Y and PD assumed size arrays.)
C               In the full matrix case (MITER = 1), ML and MU are
C          ignored, and the Jacobian is to be loaded into PD in
C          columnwise manner, with df(i)/dy(j) loaded into PD(i,j).
C               In the band matrix case (MITER = 4), the elements
C          within the band are to be loaded into PD in columnwise
C          manner, with diagonal lines of df/dy loaded into the rows
C          of PD. Thus df(i)/dy(j) is to be loaded into PD(i-j+MU+1,j).

C          ML and MU are the half-bandwidth parameters. (See IWORK).
C          The locations in PD in the two triangular areas which
C          correspond to nonexistent matrix elements can be ignored
C          or loaded arbitrarily, as they are overwritten by DVODE.
C               JAC need not provide df/dy exactly.  A crude
C          approximation (possibly with a smaller bandwidth) will do.
C               In either case, PD is preset to zero by the solver,
C          so that only the nonzero elements need be loaded by JAC.
C          Each call to JAC is preceded by a call to F with the same
C          arguments NEQ, T, and Y.  Thus to gain some efficiency,
C          intermediate quantities shared by both calculations may be
C          saved in a user COMMON block by F and not recomputed by JAC,
C          if desired.  Also, JAC may alter the Y array, if desired.
C          JAC must be declared external in the calling program.
C               Subroutine JAC may access user-defined real and integer
C          work arrays, RPAR and IPAR, whose dimensions are set by the
C          user in the main program.

C
C MF     = The method flag.  Used only for input.  The legal values of
C          MF are 10, 11, 12, 13, 14, 15, 20, 21, 22, 23, 24, 25,
C          -11, -12, -14, -15, -21, -22, -24, -25.
C          MF is a signed two-digit integer, MF = JSV*(10*METH + MITER).
C          JSV = SIGN(MF) indicates the Jacobian-saving strategy..
C            JSV =  1 means a copy of the Jacobian is saved for reuse
C                     in the corrector iteration algorithm.
C            JSV = -1 means a copy of the Jacobian is not saved

C                     (valid only for MITER = 1, 2, 4, or 5).
C          METH indicates the basic linear multistep method..
C            METH = 1 means the implicit Adams method.
C            METH = 2 means the method based on backward
C                     differentiation formulas (BDF-s).
C          MITER indicates the corrector iteration method..
C            MITER = 0 means functional iteration (no Jacobian matrix
C                      is involved).
C            MITER = 1 means chord iteration with a user-supplied
C                      full (NEQ by NEQ) Jacobian.
C            MITER = 2 means chord iteration with an internally
C                      generated (difference quotient) full Jacobian
C                      (using NEQ extra calls to F per df/dy value).
C            MITER = 3 means chord iteration with an internally
C                      generated diagonal Jacobian approximation
C                      (using 1 extra call to F per df/dy evaluation).
C            MITER = 4 means chord iteration with a user-supplied
C                      banded Jacobian.
C            MITER = 5 means chord iteration with an internally
C                      generated banded Jacobian (using ML+MU+1 extra
C                      calls to F per df/dy evaluation).
C          If MITER = 1 or 4, the user must supply a subroutine JAC
C          (the name is arbitrary) as described above under JAC.
C          For other values of MITER, a dummy argument can be used.

C
C RPAR     User-specified array used to communicate real parameters
C          to user-supplied subroutines.  If RPAR is a vector, then
C          it must be dimensioned in the user's main program.  If it
C          is unused or it is a scalar, then it need not be
C          dimensioned.
C
C IPAR     User-specified array used to communicate integer parameter
C          to user-supplied subroutines.  The comments on dimensioning
C          RPAR apply to IPAR.
C-----------------------------------------------------------------------
C Optional Input.

C
C The following is a list of the optional input provided for in the
C call sequence.  (See also Part ii.)  For each such input variable,
C this table lists its name as used in this documentation, its
C location in the call sequence, its meaning, and the default value.
C The use of any of this input requires IOPT = 1, and in that
C case all of this input is examined.  A value of zero for any
C of these optional input variables will cause the default value to be
C used.  Thus to use a subset of the optional input, simply preload
C locations 5 to 10 in RWORK and IWORK to 0.0 and 0 respectively, and
C then set those of interest to nonzero values.
C
C NAME    LOCATION      MEANING AND DEFAULT VALUE
C

C H0      RWORK(5)  The step size to be attempted on the first step.

C                   The default value is determined by the solver.
C
C HMAX    RWORK(6)  The maximum absolute step size allowed.
C                   The default value is infinite.

C

C HMIN    RWORK(7)  The minimum absolute step size allowed.
C                   The default value is 0.  (This lower bound is not

C                   enforced on the final step before reaching TCRIT
C                   when ITASK = 4 or 5.)
C
C MAXORD  IWORK(5)  The maximum order to be allowed.  The default
C                   value is 12 if METH = 1, and 5 if METH = 2.
C                   If MAXORD exceeds the default value, it will
C                   be reduced to the default value.
C                   If MAXORD is changed during the problem, it may
C                   cause the current order to be reduced.
C
C MXSTEP  IWORK(6)  Maximum number of (internally defined) steps
C                   allowed during one call to the solver.
C                   The default value is 500.
C
C MXHNIL  IWORK(7)  Maximum number of messages printed (per problem)
C                   warning that T + H = T on a step (H = step size).
C                   This must be positive to result in a non-default
C                   value.  The default value is 10.
C
C-----------------------------------------------------------------------
C Optional Output.
C
C As optional additional output from DVODE, the variables listed
C below are quantities related to the performance of DVODE
C which are available to the user.  These are communicated by way of
C the work arrays, but also have internal mnemonic names as shown.
C Except where stated otherwise, all of this output is defined
C on any successful return from DVODE, and on any return with
C ISTATE = -1, -2, -4, -5, or -6.  On an illegal input return
C (ISTATE = -3), they will be unchanged from their existing values
C (if any), except possibly for TOLSF, LENRW, and LENIW.

C On any error return, output relevant to the error will be defined,
C as noted below.
C
C NAME    LOCATION      MEANING
C
C HU      RWORK(11) The step size in t last used (successfully).
C
C HCUR    RWORK(12) The step size to be attempted on the next step.
C
C TCUR    RWORK(13) The current value of the independent variable
C                   which the solver has actually reached, i.e. the
C                   current internal mesh point in t.  In the output,
C                   TCUR will always be at least as far from the

C                   initial value of t as the current argument T,
C                   but may be farther (if interpolation was done).
C
C TOLSF   RWORK(14) A tolerance scale factor, greater than 1.0,
C                   computed when a request for too much accuracy was
C                   detected (ISTATE = -3 if detected at the start of
C                   the problem, ISTATE = -2 otherwise).  If ITOL is

C                   left unaltered but RTOL and ATOL are uniformly
C                   scaled up by a factor of TOLSF for the next call,
C                   then the solver is deemed likely to succeed.
C                   (The user may also ignore TOLSF and alter the
C                   tolerance parameters in any other way appropriate.)
C
C NST     IWORK(11) The number of steps taken for the problem so far.
C
C NFE     IWORK(12) The number of f evaluations for the problem so far.
C
C NJE     IWORK(13) The number of Jacobian evaluations so far.
C


C NQU     IWORK(14) The method order last used (successfully).
C
C NQCUR   IWORK(15) The order to be attempted on the next step.
C
C IMXER   IWORK(16) The index of the component of largest magnitude in
C                   the weighted local error vector ( e(i)/EWT(i) ),
C                   on an error return with ISTATE = -4 or -5.

C
C LENRW   IWORK(17) The length of RWORK actually required.
C                   This is defined on normal returns and on an illegal
C                   input return for insufficient storage.
C
C LENIW   IWORK(18) The length of IWORK actually required.
C                   This is defined on normal returns and on an illegal
C                   input return for insufficient storage.
C
C NLU     IWORK(19) The number of matrix LU decompositions so far.
C
C NNI     IWORK(20) The number of nonlinear (Newton) iterations so far.
C
C NCFN    IWORK(21) The number of convergence failures of the nonlinear
C                   solver so far.
C
C NETF    IWORK(22) The number of error test failures of the integrator
C                   so far.
C
C The following two arrays are segments of the RWORK array which
C may also be of interest to the user as optional output.
C For each array, the table below gives its internal name,
C its base address in RWORK, and its description.
C
C NAME    BASE ADDRESS      DESCRIPTION
C
C YH      21             The Nordsieck history array, of size NYH by
C                        (NQCUR + 1), where NYH is the initial value
C                        of NEQ.  For j = 0,1,...,NQCUR, column j+1
C                        of YH contains HCUR**j/factorial(j) times

C                        the j-th derivative of the interpolating
C                        polynomial currently representing the
C                        solution, evaluated at t = TCUR.
C
C ACOR     LENRW-NEQ+1   Array of size NEQ used for the accumulated
C                        corrections on each step, scaled in the output
C                        to represent the estimated local error in Y
C                        on the last step.  This is the vector e in
C                        the description of the error control.  It is

C                        defined only on a successful return from DVODE.
C
C-----------------------------------------------------------------------
C Interrupting and Restarting
C
C If the integration of a given problem by DVODE is to be
C interrrupted and then later continued, such as when restarting
C an interrupted run or alternating between two or more ODE problems,
C the user should save, following the return from the last DVODE call
C prior to the interruption, the contents of the call sequence
C variables and internal COMMON blocks, and later restore these
C values before the next DVODE call for that problem.  To save
C and restore the COMMON blocks, use subroutine DVSRCO, as
C described below in part ii.
C
C In addition, if non-default values for either LUN or MFLAG are
C desired, an extra call to XSETUN and/or XSETF should be made just
C before continuing the integration.  See Part ii below for details.
C
C-----------------------------------------------------------------------
C Part ii.  Other Routines Callable.
C
C The following are optional calls which the user may make to
C gain additional capabilities in conjunction with DVODE.
C (The routines XSETUN and XSETF are designed to conform to the
C SLATEC error handling package.)
C
C     FORM OF CALL                  FUNCTION
C  CALL XSETUN(LUN)           Set the logical unit number, LUN, for
C                             output of messages from DVODE, if
C                             the default is not desired.
C                             The default value of LUN is 6.
C
C  CALL XSETF(MFLAG)          Set a flag to control the printing of
C                             messages by DVODE.
C                             MFLAG = 0 means do not print. (Danger..
C                             This risks losing valuable information.)
C                             MFLAG = 1 means print (the default).
C
C                             Either of the above calls may be made at
C                             any time and will take effect immediately.
C

C  CALL DVSRCO(RSAV,ISAV,JOB) Saves and restores the contents of
C                             the internal COMMON blocks used by

C                             DVODE. (See Part iii below.)

C                             RSAV must be a real array of length 49
C                             or more, and ISAV must be an integer
C                             array of length 40 or more.
C                             JOB=1 means save COMMON into RSAV/ISAV.
C                             JOB=2 means restore COMMON from RSAV/ISAV.
C                                DVSRCO is useful if one is
C                             interrupting a run and restarting
C                             later, or alternating between two or
C                             more problems solved with DVODE.
C
C  CALL DVINDY(,,,,,)         Provide derivatives of y, of various
C        (See below.)         orders, at a specified point T, if
C                             desired.  It may be called only after
C                             a successful return from DVODE.
C
C The detailed instructions for using DVINDY are as follows.
C The form of the call is..
C
C  CALL DVINDY (T, K, RWORK(21), NYH, DKY, IFLAG)
C
C The input parameters are..
C
C T         = Value of independent variable where answers are desired
C             (normally the same as the T last returned by DVODE).
C             For valid results, T must lie between TCUR - HU and TCUR.
C             (See optional output for TCUR and HU.)

C K         = Integer order of the derivative desired.  K must satisfy
C             0 .le. K .le. NQCUR, where NQCUR is the current order
C             (see optional output).  The capability corresponding
C             to K = 0, i.e. computing y(T), is already provided
C             by DVODE directly.  Since NQCUR .ge. 1, the first
C             derivative dy/dt is always available with DVINDY.
C RWORK(21) = The base address of the history array YH.
C NYH       = Column length of YH, equal to the initial value of NEQ.
C
C The output parameters are..
C
C DKY       = A real array of length NEQ containing the computed value
C             of the K-th derivative of y(t).
C IFLAG     = Integer flag, returned as 0 if K and T were legal,

C             -1 if K was illegal, and -2 if T was illegal.
C             On an error return, a message is also written.
C-----------------------------------------------------------------------
C Part iii.  COMMON Blocks.
C If DVODE is to be used in an overlay situation, the user
C must declare, in the primary overlay, the variables in..
C   (1) the call sequence to DVODE,
C   (2) the two internal COMMON blocks
C         /DVOD01/  of length  81  (48 double precision words
C                         followed by 33 integer words),
C         /DVOD02/  of length  9  (1 double precision word
C                         followed by 8 integer words),
C

C If DVODE is used on a system in which the contents of internal
C COMMON blocks are not preserved between calls, the user should
C declare the above two COMMON blocks in his main program to insure
C that their contents are preserved.
C
C-----------------------------------------------------------------------
C Part iv.  Optionally Replaceable Solver Routines.
C
C Below are descriptions of two routines in the DVODE package which
C relate to the measurement of errors.  Either routine can be
C replaced by a user-supplied version, if desired.  However, since such
C a replacement may have a major impact on performance, it should be
C done only when absolutely necessary, and only with great caution.
C (Note.. The means by which the package version of a routine is



C superseded by the user's version may be system-dependent.)
C

C (a) DEWSET.

C The following subroutine is called just before each internal
C integration step, and sets the array of error weights, EWT, as
C described under ITOL/RTOL/ATOL above..

C     SUBROUTINE DEWSET (NEQ, ITOL, RTOL, ATOL, YCUR, EWT)
C where NEQ, ITOL, RTOL, and ATOL are as in the DVODE call sequence,
C YCUR contains the current dependent variable vector, and
C EWT is the array of weights set by DEWSET.
C
C If the user supplies this subroutine, it must return in EWT(i)
C (i = 1,...,NEQ) a positive quantity suitable for comparison with
C errors in Y(i).  The EWT array returned by DEWSET is passed to the
C DVNORM routine (See below.), and also used by DVODE in the computation
C of the optional output IMXER, the diagonal Jacobian approximation,
C and the increments for difference quotient Jacobians.
C
C In the user-supplied version of DEWSET, it may be desirable to use
C the current values of derivatives of y.  Derivatives up to order NQ
C are available from the history array YH, described above under
C Optional Output.  In DEWSET, YH is identical to the YCUR array,
C extended to NQ + 1 columns with a column length of NYH and scale
C factors of h**j/factorial(j).  On the first call for the problem,
C given by NST = 0, NQ is 1 and H is temporarily set to 1.0.
C NYH is the initial value of NEQ.  The quantities NQ, H, and NST
C can be obtained by including in DEWSET the statements..
C     DOUBLE PRECISION RVOD, H, HU
C     COMMON /DVOD01/ RVOD(48), IVOD(33)
C     COMMON /DVOD02/ HU, NCFN, NETF, NFE, NJE, NLU, NNI, NQU, NST
C     NQ = IVOD(28)
C     H = RVOD(21)
C Thus, for example, the current value of dy/dt can be obtained as
C YCUR(NYH+i)/H  (i=1,...,NEQ)  (and the division by H is
C unnecessary when NST = 0).
C
C (b) DVNORM.
C The following is a real function routine which computes the weighted
C root-mean-square norm of a vector v..
C     D = DVNORM (N, V, W)
C where..

C   N = the length of the vector,
C   V = real array of length N containing the vector,
C   W = real array of length N containing weights,
C   D = sqrt( (1/N) * sum(V(i)*W(i))**2 ).
C DVNORM is called with N = NEQ and with W(i) = 1.0/EWT(i), where
C EWT is as set by subroutine DEWSET.

C

C If the user supplies this function, it should return a non-negative
C value of DVNORM suitable for use in the error control in DVODE.
C None of the arguments should be altered by DVNORM.
C For example, a user-supplied DVNORM routine might..
C   -substitute a max-norm of (V(i)*W(i)) for the rms-norm, or
C   -ignore some components of V in the norm, with the effect of
C    suppressing the error control on those components of Y.
C-----------------------------------------------------------------------
C Other Routines in the DVODE Package.
C
C In addition to subroutine DVODE, the DVODE package includes the
C following subroutines and function routines..
C  DVHIN     computes an approximate step size for the initial step.
C  DVINDY    computes an interpolated value of the y vector at t = TOUT.
C  DVSTEP    is the core integrator, which does one step of the
C            integration and the associated error control.
C  DVSET     sets all method coefficients and test constants.
C  DVNLSD    solves the underlying nonlinear system -- the corrector.
C  DVJAC     computes and preprocesses the Jacobian matrix J = df/dy
C            and the Newton iteration matrix P = I - (h/l1)*J.

C  DVSOL     manages solution of linear system in chord iteration.

C  DVJUST    adjusts the history array on a change of order.
C  DEWSET    sets the error weight vector EWT before each step.
C  DVNORM    computes the weighted r.m.s. norm of a vector.

C  DVSRCO    is a user-callable routines to save and restore
C            the contents of the internal COMMON blocks.
C  DACOPY    is a routine to copy one two-dimensional array to another.
C  DGEFA and DGESL   are routines from LINPACK for solving full
C            systems of linear algebraic equations.
C  DGBFA and DGBSL   are routines from LINPACK for solving banded
C            linear systems.
C  DAXPY, DSCAL, and DCOPY are basic linear algebra modules (BLAS).
C  D1MACH    sets the unit roundoff of the machine.
C  XERRWD, XSETUN, XSETF, LUNSAV, and MFLGSV handle the printing of all
C            error messages and warnings.  XERRWD is machine-dependent.
C Note..  DVNORM, D1MACH, LUNSAV, and MFLGSV are function routines.
C All the others are subroutines.
C
C The intrinsic and external routines used by the DVODE package are..
C ABS, MAX, MIN, REAL, SIGN, SQRT, and WRITE.
C
C-----------------------------------------------------------------------
C
C Type declarations for labeled COMMON block DVOD01 --------------------
C
      DOUBLE PRECISION ACNRM, CCMXJ, CONP, CRATE, DRC, EL,
     1     ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2     RC, RL1, TAU, TQ, TN, UROUND
      INTEGER ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,
     1        L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,
     2        LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,
     3        N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,
     4        NSLP, NYH
C
C Type declarations for labeled COMMON block DVOD02 --------------------
C
      DOUBLE PRECISION HU

      INTEGER NCFN, NETF, NFE, NJE, NLU, NNI, NQU, NST
C
C Type declarations for local variables --------------------------------
C
      EXTERNAL DVNLSD
      LOGICAL IHIT
      DOUBLE PRECISION ATOLI, BIG, EWTI, FOUR, H0, HMAX, HMX, HUN, ONE,
     1   PT2, RH, RTOLI, SIZE, TCRIT, TNEXT, TOLSF, TP, TWO, ZERO
      INTEGER I, IER, IFLAG, IMXER, JCO, KGO, LENIW, LENJ, LENP, LENRW,
     1   LENWM, LF0, MBAND, ML, MORD, MU, MXHNL0, MXSTP0, NITER, NSLAST
      CHARACTER*80 MSG

C
C Type declaration for function subroutines called ---------------------
C
      DOUBLE PRECISION D1MACH, DVNORM
C
      DIMENSION MORD(2)

C-----------------------------------------------------------------------

C The following Fortran-77 declaration is to cause the values of the
C listed (local) variables to be saved between calls to DVODE.
C-----------------------------------------------------------------------
      SAVE MORD, MXHNL0, MXSTP0

      SAVE ZERO, ONE, TWO, FOUR, PT2, HUN
C-----------------------------------------------------------------------
C The following internal COMMON blocks contain variables which are
C communicated between subroutines in the DVODE package, or which are


C to be saved between calls to DVODE.
C In each block, real variables precede integers.
C The block /DVOD01/ appears in subroutines DVODE, DVINDY, DVSTEP,
C DVSET, DVNLSD, DVJAC, DVSOL, DVJUST and DVSRCO.
C The block /DVOD02/ appears in subroutines DVODE, DVINDY, DVSTEP,
C DVNLSD, DVJAC, and DVSRCO.
C
C The variables stored in the internal COMMON blocks are as follows..
C

C ACNRM  = Weighted r.m.s. norm of accumulated correction vectors.
C CCMXJ  = Threshhold on DRC for updating the Jacobian. (See DRC.)
C CONP   = The saved value of TQ(5).
C CRATE  = Estimated corrector convergence rate constant.
C DRC    = Relative change in H*RL1 since last DVJAC call.
C EL     = Real array of integration coefficients.  See DVSET.
C ETA    = Saved tentative ratio of new to old H.

C ETAMAX = Saved maximum value of ETA to be allowed.
C H      = The step size.
C HMIN   = The minimum absolute value of the step size H to be used.
C HMXI   = Inverse of the maximum absolute value of H to be used.
C          HMXI = 0.0 is allowed and corresponds to an infinite HMAX.
C HNEW   = The step size to be attempted on the next step.
C HSCAL  = Stepsize in scaling of YH array.
C PRL1   = The saved value of RL1.
C RC     = Ratio of current H*RL1 to value on last DVJAC call.
C RL1    = The reciprocal of the coefficient EL(1).
C TAU    = Real vector of past NQ step sizes, length 13.
C TQ     = A real vector of length 5 in which DVSET stores constants
C          used for the convergence test, the error test, and the
C          selection of H at a new order.
C TN     = The independent variable, updated on each step taken.
C UROUND = The machine unit roundoff.  The smallest positive real number
C          such that  1.0 + UROUND .ne. 1.0
C ICF    = Integer flag for convergence failure in DVNLSD..
C            0 means no failures.
C            1 means convergence failure with out of date Jacobian
C                   (recoverable error).
C            2 means convergence failure with current Jacobian or
C                   singular matrix (unrecoverable error).
C INIT   = Saved integer flag indicating whether initialization of the
C          problem has been done (INIT = 1) or not.
C IPUP   = Saved flag to signal updating of Newton matrix.
C JCUR   = Output flag from DVJAC showing Jacobian status..
C            JCUR = 0 means J is not current.
C            JCUR = 1 means J is current.
C JSTART = Integer flag used as input to DVSTEP..
C            0  means perform the first step.
C            1  means take a new step continuing from the last.
C            -1 means take the next step with a new value of MAXORD,
C                  HMIN, HMXI, N, METH, MITER, and/or matrix parameters.
C          On return, DVSTEP sets JSTART = 1.
C JSV    = Integer flag for Jacobian saving, = sign(MF).
C KFLAG  = A completion code from DVSTEP with the following meanings..
C               0      the step was succesful.

C              -1      the requested error could not be achieved.
C              -2      corrector convergence could not be achieved.
C              -3, -4  fatal error in VNLS (can not occur here).
C KUTH   = Input flag to DVSTEP showing whether H was reduced by the
C          driver.  KUTH = 1 if H was reduced, = 0 otherwise.
C L      = Integer variable, NQ + 1, current order plus one.
C LMAX   = MAXORD + 1 (used for dimensioning).
C LOCJS  = A pointer to the saved Jacobian, whose storage starts at
C          WM(LOCJS), if JSV = 1.
C LYH, LEWT, LACOR, LSAVF, LWM, LIWM = Saved integer pointers
C          to segments of RWORK and IWORK.
C MAXORD = The maximum order of integration method to be allowed.
C METH/MITER = The method flags.  See MF.
C MSBJ   = The maximum number of steps between J evaluations, = 50.
C MXHNIL = Saved value of optional input MXHNIL.
C MXSTEP = Saved value of optional input MXSTEP.
C N      = The number of first-order ODEs, = NEQ.
C NEWH   = Saved integer to flag change of H.
C NEWQ   = The method order to be used on the next step.
C NHNIL  = Saved counter for occurrences of T + H = T.
C NQ     = Integer variable, the current integration method order.
C NQNYH  = Saved value of NQ*NYH.
C NQWAIT = A counter controlling the frequency of order changes.
C          An order change is about to be considered if NQWAIT = 1.
C NSLJ   = The number of steps taken as of the last Jacobian update.
C NSLP   = Saved value of NST as of last Newton matrix update.
C NYH    = Saved value of the initial value of NEQ.
C HU     = The step size in t last used.
C NCFN   = Number of nonlinear convergence failures so far.
C NETF   = The number of error test failures of the integrator so far.
C NFE    = The number of f evaluations for the problem so far.
C NJE    = The number of Jacobian evaluations so far.
C NLU    = The number of matrix LU decompositions so far.

C NNI    = Number of nonlinear iterations so far.
C NQU    = The method order last used.
C NST    = The number of steps taken for the problem so far.
C-----------------------------------------------------------------------
      COMMON /DVOD01/ ACNRM, CCMXJ, CONP, CRATE, DRC, EL(13),
     1                ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2                RC, RL1, TAU(13), TQ(5), TN, UROUND,
     3                ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,

     4                L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,
     5                LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,
     6                N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,
     7                NSLP, NYH
      COMMON /DVOD02/ HU, NCFN, NETF, NFE, NJE, NLU, NNI, NQU, NST

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$omp Threadprivate(/DVOD01/,/DVOD02/,MORD,MXHNL0,MXSTP0,ZERO,ONE,TWO,
!$omp&FOUR,PT2,HUN)

      DATA  MORD(1) /12/, MORD(2) /5/, MXSTP0 /500/, MXHNL0 /10/
      DATA ZERO /0.0D0/, ONE /1.0D0/, TWO /2.0D0/, FOUR /4.0D0/,
     1     PT2 /0.2D0/, HUN /100.0D0/
C-----------------------------------------------------------------------
C Block A.
C This code block is executed on every call.
C It tests ISTATE and ITASK for legality and branches appropriately.
C If ISTATE .gt. 1 but the flag INIT shows that initialization has
C not yet been done, an error return occurs.
C If ISTATE = 1 and TOUT = T, return immediately.
C-----------------------------------------------------------------------
      IF (ISTATE .LT. 1 .OR. ISTATE .GT. 3) GO TO 601
      IF (ITASK .LT. 1 .OR. ITASK .GT. 5) GO TO 602
      IF (ISTATE .EQ. 1) GO TO 10
      IF (INIT .NE. 1) GO TO 603
      IF (ISTATE .EQ. 2) GO TO 200
      GO TO 20
 10   INIT = 0
      IF (TOUT .EQ. T) RETURN
C-----------------------------------------------------------------------
C Block B.
C The next code block is executed for the initial call (ISTATE = 1),
C or for a continuation call with parameter changes (ISTATE = 3).
C It contains checking of all input and various initializations.
C
C First check legality of the non-optional input NEQ, ITOL, IOPT,
C MF, ML, and MU.

C-----------------------------------------------------------------------
 20   IF (NEQ .LE. 0) GO TO 604
      IF (ISTATE .EQ. 1) GO TO 25
      IF (NEQ .GT. N) GO TO 605
 25   N = NEQ

      IF (ITOL .LT. 1 .OR. ITOL .GT. 4) GO TO 606
      IF (IOPT .LT. 0 .OR. IOPT .GT. 1) GO TO 607
      JSV = SIGN(1,MF)
      MF = ABS(MF)
      METH = MF/10
      MITER = MF - 10*METH
      IF (METH .LT. 1 .OR. METH .GT. 2) GO TO 608
      IF (MITER .LT. 0 .OR. MITER .GT. 5) GO TO 608
      IF (MITER .LE. 3) GO TO 30
      ML = IWORK(1)
      MU = IWORK(2)
      IF (ML .LT. 0 .OR. ML .GE. N) GO TO 609
      IF (MU .LT. 0 .OR. MU .GE. N) GO TO 610
 30   CONTINUE
C Next process and check the optional input. ---------------------------
      IF (IOPT .EQ. 1) GO TO 40
      MAXORD = MORD(METH)
      MXSTEP = MXSTP0
      MXHNIL = MXHNL0
      IF (ISTATE .EQ. 1) H0 = ZERO
      HMXI = ZERO
      HMIN = ZERO
      GO TO 60
 40   MAXORD = IWORK(5)
      IF (MAXORD .LT. 0) GO TO 611
      IF (MAXORD .EQ. 0) MAXORD = 100
      MAXORD = MIN(MAXORD,MORD(METH))
      MXSTEP = IWORK(6)
      IF (MXSTEP .LT. 0) GO TO 612

      IF (MXSTEP .EQ. 0) MXSTEP = MXSTP0
      MXHNIL = IWORK(7)
      IF (MXHNIL .LT. 0) GO TO 613
      IF (MXHNIL .EQ. 0) MXHNIL = MXHNL0
      IF (ISTATE .NE. 1) GO TO 50
      H0 = RWORK(5)

      IF ((TOUT - T)*H0 .LT. ZERO) GO TO 614
 50   HMAX = RWORK(6)
      IF (HMAX .LT. ZERO) GO TO 615
      HMXI = ZERO
      IF (HMAX .GT. ZERO) HMXI = ONE/HMAX
      HMIN = RWORK(7)
      IF (HMIN .LT. ZERO) GO TO 616
C-----------------------------------------------------------------------
C Set work array pointers and check lengths LRW and LIW.
C Pointers to segments of RWORK and IWORK are named by prefixing L to
C the name of the segment.  E.g., the segment YH starts at RWORK(LYH).
C Segments of RWORK (in order) are denoted  YH, WM, EWT, SAVF, ACOR.
C Within WM, LOCJS is the location of the saved Jacobian (JSV .gt. 0).
C-----------------------------------------------------------------------
 60   LYH = 21
      IF (ISTATE .EQ. 1) NYH = N
      LWM = LYH + (MAXORD + 1)*NYH
      JCO = MAX(0,JSV)
      IF (MITER .EQ. 0) LENWM = 0
      IF (MITER .EQ. 1 .OR. MITER .EQ. 2) THEN
        LENWM = 2 + (1 + JCO)*N*N
        LOCJS = N*N + 3
      ENDIF
      IF (MITER .EQ. 3) LENWM = 2 + N

      IF (MITER .EQ. 4 .OR. MITER .EQ. 5) THEN
        MBAND = ML + MU + 1
        LENP = (MBAND + ML)*N
        LENJ = MBAND*N

        LENWM = 2 + LENP + JCO*LENJ
        LOCJS = LENP + 3
        ENDIF
      LEWT = LWM + LENWM
      LSAVF = LEWT + N
      LACOR = LSAVF + N
      LENRW = LACOR + N - 1
      IWORK(17) = LENRW
      LIWM = 1
      LENIW = 30 + N
      IF (MITER .EQ. 0 .OR. MITER .EQ. 3) LENIW = 30
      IWORK(18) = LENIW
      IF (LENRW .GT. LRW) GO TO 617
      IF (LENIW .GT. LIW) GO TO 618
C Check RTOL and ATOL for legality. ------------------------------------
      RTOLI = RTOL
      ATOLI = ATOL(1)
      DO 70 I = 1,N
        IF (ITOL .GE. 3) RTOLI = RTOL
        IF (ITOL .EQ. 2 .OR. ITOL .EQ. 4) ATOLI = ATOL(I)
        IF (RTOLI .LT. ZERO) GO TO 619
        IF (ATOLI .LT. ZERO) GO TO 620
 70     CONTINUE
      IF (ISTATE .EQ. 1) GO TO 100

C If ISTATE = 3, set flag to signal parameter changes to DVSTEP. -------
      JSTART = -1
      IF (NQ .LE. MAXORD) GO TO 90
C MAXORD was reduced below NQ.  Copy YH(*,MAXORD+2) into SAVF. ---------
      CALL DCOPY (N, RWORK(LWM), 1, RWORK(LSAVF), 1)
C Reload WM(1) = RWORK(LWM), since LWM may have changed. ---------------
 90   IF (MITER .GT. 0) RWORK(LWM) = SQRT(UROUND)
C-----------------------------------------------------------------------
C Block C.
C The next block is for the initial call only (ISTATE = 1).
C It contains all remaining initializations, the initial call to F,

C and the calculation of the initial step size.
C The error weights in EWT are inverted after being loaded.
C-----------------------------------------------------------------------
 100  UROUND = D1MACH(4)
      TN = T
      IF (ITASK .NE. 4 .AND. ITASK .NE. 5) GO TO 110
      TCRIT = RWORK(1)
      IF ((TCRIT - TOUT)*(TOUT - T) .LT. ZERO) GO TO 625
      IF (H0 .NE. ZERO .AND. (T + H0 - TCRIT)*H0 .GT. ZERO)
     1   H0 = TCRIT - T
 110  JSTART = 0

      IF (MITER .GT. 0) RWORK(LWM) = SQRT(UROUND)
      CCMXJ = PT2
      MSBJ = 50
      NHNIL = 0
      NST = 0
      NJE = 0
      NNI = 0
      NCFN = 0
      NETF = 0
      NLU = 0
      NSLJ = 0
      NSLAST = 0
      HU = ZERO
      NQU = 0
C Initial call to F.  (LF0 points to YH(*,2).) -------------------------
      LF0 = LYH + NYH

      CALL F (N, T, Y, RWORK(LF0), RPAR, IPAR)
      NFE = 1
C Load the initial value vector in YH. ---------------------------------
      CALL DCOPY (N, Y, 1, RWORK(LYH), 1)
C Load and invert the EWT array.  (H is temporarily set to 1.0.) -------
      NQ = 1
      H = ONE
      CALL DEWSET (N, ITOL, RTOL, ATOL, RWORK(LYH), RWORK(LEWT))
      DO 120 I = 1,N
        IF (RWORK(I+LEWT-1) .LE. ZERO) GO TO 621
 120    RWORK(I+LEWT-1) = ONE/RWORK(I+LEWT-1)
      IF (H0 .NE. ZERO) GO TO 180
C Call DVHIN to set initial step size H0 to be attempted. --------------
      CALL DVHIN (N, T, RWORK(LYH), RWORK(LF0), F, RPAR, IPAR, TOUT,
     1   UROUND, RWORK(LEWT), ITOL, ATOL, Y, RWORK(LACOR), H0,
     2   NITER, IER)
      NFE = NFE + NITER
      IF (IER .NE. 0) GO TO 622
C Adjust H0 if necessary to meet HMAX bound. ---------------------------
 180  RH = ABS(H0)*HMXI
      IF (RH .GT. ONE) H0 = H0/RH
C Load H with H0 and scale YH(*,2) by H0. ------------------------------
      H = H0
      CALL DSCAL (N, H0, RWORK(LF0), 1)

      GO TO 270
C-----------------------------------------------------------------------
C Block D.
C The next code block is for continuation calls only (ISTATE = 2 or 3)

C and is to check stop conditions before taking a step.
C-----------------------------------------------------------------------
 200  NSLAST = NST
      KUTH = 0
      GO TO (210, 250, 220, 230, 240), ITASK
 210  IF ((TN - TOUT)*H .LT. ZERO) GO TO 250
      CALL DVINDY (TOUT, 0, RWORK(LYH), NYH, Y, IFLAG)
      IF (IFLAG .NE. 0) GO TO 627
      T = TOUT
      GO TO 420
 220  TP = TN - HU*(ONE + HUN*UROUND)

      IF ((TP - TOUT)*H .GT. ZERO) GO TO 623
      IF ((TN - TOUT)*H .LT. ZERO) GO TO 250
      GO TO 400
 230  TCRIT = RWORK(1)
      IF ((TN - TCRIT)*H .GT. ZERO) GO TO 624
      IF ((TCRIT - TOUT)*H .LT. ZERO) GO TO 625

      IF ((TN - TOUT)*H .LT. ZERO) GO TO 245
      CALL DVINDY (TOUT, 0, RWORK(LYH), NYH, Y, IFLAG)
      IF (IFLAG .NE. 0) GO TO 627
      T = TOUT
      GO TO 420
 240  TCRIT = RWORK(1)
      IF ((TN - TCRIT)*H .GT. ZERO) GO TO 624
 245  HMX = ABS(TN) + ABS(H)
      IHIT = ABS(TN - TCRIT) .LE. HUN*UROUND*HMX
      IF (IHIT) GO TO 400
      TNEXT = TN + HNEW*(ONE + FOUR*UROUND)
      IF ((TNEXT - TCRIT)*H .LE. ZERO) GO TO 250
      H = (TCRIT - TN)*(ONE - FOUR*UROUND)
      KUTH = 1
C-----------------------------------------------------------------------
C Block E.
C The next block is normally executed for all calls and contains
C the call to the one-step core integrator DVSTEP.
C


C This is a looping point for the integration steps.

C
C First check for too many steps being taken, update EWT (if not at
C start of problem), check for too much accuracy being requested, and
C check for H below the roundoff level in T.
C-----------------------------------------------------------------------
 250  CONTINUE
      IF ((NST-NSLAST) .GE. MXSTEP) GO TO 500
      CALL DEWSET (N, ITOL, RTOL, ATOL, RWORK(LYH), RWORK(LEWT))
      DO 260 I = 1,N
        IF (RWORK(I+LEWT-1) .LE. ZERO) GO TO 510
 260    RWORK(I+LEWT-1) = ONE/RWORK(I+LEWT-1)
 270  TOLSF = UROUND*DVNORM (N, RWORK(LYH), RWORK(LEWT))
      IF (TOLSF .LE. ONE) GO TO 280
      TOLSF = TOLSF*TWO
      IF (NST .EQ. 0) GO TO 626
      GO TO 520
 280  IF ((TN + H) .NE. TN) GO TO 290
      NHNIL = NHNIL + 1
      IF (NHNIL .GT. MXHNIL) GO TO 290
      MSG = 'DVODE--  Warning..internal T (=R1) and H (=R2) are'
      CALL XERRWD (MSG, 50, 101, 1, 0, 0, 0, 0, ZERO, ZERO)
      MSG='      such that in the machine, T + H = T on the next step  '
      CALL XERRWD (MSG, 60, 101, 1, 0, 0, 0, 0, ZERO, ZERO)
      MSG = '      (H = step size). solver will continue anyway'
      CALL XERRWD (MSG, 50, 101, 1, 0, 0, 0, 2, TN, H)
      IF (NHNIL .LT. MXHNIL) GO TO 290
      MSG = 'DVODE--  Above warning has been issued I1 times.  '
      CALL XERRWD (MSG, 50, 102, 1, 0, 0, 0, 0, ZERO, ZERO)
      MSG = '      it will not be issued again for this problem'
      CALL XERRWD (MSG, 50, 102, 1, 1, MXHNIL, 0, 0, ZERO, ZERO)
 290  CONTINUE
C-----------------------------------------------------------------------
C CALL DVSTEP (Y, YH, NYH, YH, EWT, SAVF, VSAV, ACOR,
C              WM, IWM, F, JAC, F, DVNLSD, RPAR, IPAR)
C-----------------------------------------------------------------------
      CALL DVSTEP (Y, RWORK(LYH), NYH, RWORK(LYH), RWORK(LEWT),
     1   RWORK(LSAVF), Y, RWORK(LACOR), RWORK(LWM), IWORK(LIWM),

     2   F, JAC, F, DVNLSD, RPAR, IPAR)
      KGO = 1 - KFLAG
C Branch on KFLAG.  Note..In this version, KFLAG can not be set to -3.
C  KFLAG .eq. 0,   -1,  -2
      GO TO (300, 530, 540), KGO
C-----------------------------------------------------------------------
C Block F.
C The following block handles the case of a successful return from the
C core integrator (KFLAG = 0).  Test for stop conditions.

C-----------------------------------------------------------------------


 300  INIT = 1
      KUTH = 0
      GO TO (310, 400, 330, 340, 350), ITASK
C ITASK = 1.  If TOUT has been reached, interpolate. -------------------
 310  IF ((TN - TOUT)*H .LT. ZERO) GO TO 250
      CALL DVINDY (TOUT, 0, RWORK(LYH), NYH, Y, IFLAG)

      T = TOUT
      GO TO 420
C ITASK = 3.  Jump to exit if TOUT was reached. ------------------------
 330  IF ((TN - TOUT)*H .GE. ZERO) GO TO 400
      GO TO 250
C ITASK = 4.  See if TOUT or TCRIT was reached.  Adjust H if necessary.
 340  IF ((TN - TOUT)*H .LT. ZERO) GO TO 345
      CALL DVINDY (TOUT, 0, RWORK(LYH), NYH, Y, IFLAG)
      T = TOUT
      GO TO 420
 345  HMX = ABS(TN) + ABS(H)
      IHIT = ABS(TN - TCRIT) .LE. HUN*UROUND*HMX
      IF (IHIT) GO TO 400
      TNEXT = TN + HNEW*(ONE + FOUR*UROUND)
      IF ((TNEXT - TCRIT)*H .LE. ZERO) GO TO 250
      H = (TCRIT - TN)*(ONE - FOUR*UROUND)
      KUTH = 1
      GO TO 250
C ITASK = 5.  See if TCRIT was reached and jump to exit. ---------------

 350  HMX = ABS(TN) + ABS(H)
      IHIT = ABS(TN - TCRIT) .LE. HUN*UROUND*HMX
C-----------------------------------------------------------------------
C Block G.
C The following block handles all successful returns from DVODE.
C If ITASK .ne. 1, Y is loaded from YH and T is set accordingly.
C ISTATE is set to 2, and the optional output is loaded into the work
C arrays before returning.
C-----------------------------------------------------------------------
 400  CONTINUE
      CALL DCOPY (N, RWORK(LYH), 1, Y, 1)
      T = TN

      IF (ITASK .NE. 4 .AND. ITASK .NE. 5) GO TO 420
      IF (IHIT) T = TCRIT
 420  ISTATE = 2
      RWORK(11) = HU
      RWORK(12) = HNEW
      RWORK(13) = TN
      IWORK(11) = NST
      IWORK(12) = NFE
      IWORK(13) = NJE
      IWORK(14) = NQU
      IWORK(15) = NEWQ
      IWORK(19) = NLU
      IWORK(20) = NNI
      IWORK(21) = NCFN
      IWORK(22) = NETF
      RETURN
C-----------------------------------------------------------------------
C Block H.
C The following block handles all unsuccessful returns other than
C those for illegal input.  First the error message routine is called.
C if there was an error test or convergence test failure, IMXER is set.
C Then Y is loaded from YH, T is set to TN, and the illegal input
C The optional output is loaded into the work arrays before returning.

C-----------------------------------------------------------------------
C The maximum number of steps was taken before reaching TOUT. ----------
 500  MSG = 'DVODE--  At current T (=R1), MXSTEP (=I1) steps   '
      CALL XERRWD (MSG, 50, 201, 1, 0, 0, 0, 0, ZERO, ZERO)
      MSG = '      taken on this call before reaching TOUT     '
      CALL XERRWD (MSG, 50, 201, 1, 1, MXSTEP, 0, 1, TN, ZERO)
      ISTATE = -1
      GO TO 580
C EWT(i) .le. 0.0 for some i (not at start of problem). ----------------
 510  EWTI = RWORK(LEWT+I-1)
      MSG = 'DVODE--  At T (=R1), EWT(I1) has become R2 .le. 0.'
      CALL XERRWD (MSG, 50, 202, 1, 1, I, 0, 2, TN, EWTI)
      ISTATE = -6
      GO TO 580
C Too much accuracy requested for machine precision. -------------------
 520  MSG = 'DVODE--  At T (=R1), too much accuracy requested  '
      CALL XERRWD (MSG, 50, 203, 1, 0, 0, 0, 0, ZERO, ZERO)
      MSG = '      for precision of machine..  see TOLSF (=R2) '
      CALL XERRWD (MSG, 50, 203, 1, 0, 0, 0, 2, TN, TOLSF)
      RWORK(14) = TOLSF
      ISTATE = -2
      GO TO 580
C KFLAG = -1.  Error test failed repeatedly or with ABS(H) = HMIN. -----
 530  MSG = 'DVODE--  At T(=R1) and step size H(=R2), the error'
      CALL XERRWD (MSG, 50, 204, 1, 0, 0, 0, 0, ZERO, ZERO)
      MSG = '      test failed repeatedly or with abs(H) = HMIN'
      CALL XERRWD (MSG, 50, 204, 1, 0, 0, 0, 2, TN, H)
      ISTATE = -4
      GO TO 560
C KFLAG = -2.  Convergence failed repeatedly or with abs(H) = HMIN. ----
 540  MSG = 'DVODE--  At T (=R1) and step size H (=R2), the    '
      CALL XERRWD (MSG, 50, 205, 1, 0, 0, 0, 0, ZERO, ZERO)
      MSG = '      corrector convergence failed repeatedly     '
      CALL XERRWD (MSG, 50, 205, 1, 0, 0, 0, 0, ZERO, ZERO)

      MSG = '      or with abs(H) = HMIN   '
      CALL XERRWD (MSG, 30, 205, 1, 0, 0, 0, 2, TN, H)
      ISTATE = -5
C Compute IMXER if relevant. -------------------------------------------
 560  BIG = ZERO
      IMXER = 1
      DO 570 I = 1,N
        SIZE = ABS(RWORK(I+LACOR-1)*RWORK(I+LEWT-1))
        IF (BIG .GE. SIZE) GO TO 570
        BIG = SIZE
        IMXER = I
 570    CONTINUE
      IWORK(16) = IMXER
C Set Y vector, T, and optional output. --------------------------------
 580  CONTINUE
      CALL DCOPY (N, RWORK(LYH), 1, Y, 1)
      T = TN
      RWORK(11) = HU
      RWORK(12) = H
      RWORK(13) = TN

      IWORK(11) = NST
      IWORK(12) = NFE
      IWORK(13) = NJE
      IWORK(14) = NQU
      IWORK(15) = NQ
      IWORK(19) = NLU
      IWORK(20) = NNI
      IWORK(21) = NCFN
      IWORK(22) = NETF
      RETURN
C-----------------------------------------------------------------------
C Block I.

C The following block handles all error returns due to illegal input
C (ISTATE = -3), as detected before calling the core integrator.
C First the error message routine is called.   If the illegal input
C is a negative ISTATE, the run is aborted (apparent infinite loop).
C-----------------------------------------------------------------------
 601  MSG = 'DVODE--  ISTATE (=I1) illegal '
      CALL XERRWD (MSG, 30, 1, 1, 1, ISTATE, 0, 0, ZERO, ZERO)
      IF (ISTATE .LT. 0) GO TO 800
      GO TO 700


 602  MSG = 'DVODE--  ITASK (=I1) illegal  '
      CALL XERRWD (MSG, 30, 2, 1, 1, ITASK, 0, 0, ZERO, ZERO)

      GO TO 700
 603  MSG='DVODE--  ISTATE (=I1) .gt. 1 but DVODE not initialized      '
      CALL XERRWD (MSG, 60, 3, 1, 1, ISTATE, 0, 0, ZERO, ZERO)

      GO TO 700
 604  MSG = 'DVODE--  NEQ (=I1) .lt. 1     '
      CALL XERRWD (MSG, 30, 4, 1, 1, NEQ, 0, 0, ZERO, ZERO)
      GO TO 700

 605  MSG = 'DVODE--  ISTATE = 3 and NEQ increased (I1 to I2)  '
      CALL XERRWD (MSG, 50, 5, 1, 2, N, NEQ, 0, ZERO, ZERO)
      GO TO 700

 606  MSG = 'DVODE--  ITOL (=I1) illegal   '
      CALL XERRWD (MSG, 30, 6, 1, 1, ITOL, 0, 0, ZERO, ZERO)
      GO TO 700
 607  MSG = 'DVODE--  IOPT (=I1) illegal   '
      CALL XERRWD (MSG, 30, 7, 1, 1, IOPT, 0, 0, ZERO, ZERO)
      GO TO 700
 608  MSG = 'DVODE--  MF (=I1) illegal     '
      CALL XERRWD (MSG, 30, 8, 1, 1, MF, 0, 0, ZERO, ZERO)
      GO TO 700
 609  MSG = 'DVODE--  ML (=I1) illegal.. .lt.0 or .ge.NEQ (=I2)'
      CALL XERRWD (MSG, 50, 9, 1, 2, ML, NEQ, 0, ZERO, ZERO)

      GO TO 700
 610  MSG = 'DVODE--  MU (=I1) illegal.. .lt.0 or .ge.NEQ (=I2)'
      CALL XERRWD (MSG, 50, 10, 1, 2, MU, NEQ, 0, ZERO, ZERO)
      GO TO 700
 611  MSG = 'DVODE--  MAXORD (=I1) .lt. 0  '
      CALL XERRWD (MSG, 30, 11, 1, 1, MAXORD, 0, 0, ZERO, ZERO)
      GO TO 700
 612  MSG = 'DVODE--  MXSTEP (=I1) .lt. 0  '
      CALL XERRWD (MSG, 30, 12, 1, 1, MXSTEP, 0, 0, ZERO, ZERO)
      GO TO 700
 613  MSG = 'DVODE--  MXHNIL (=I1) .lt. 0  '
      CALL XERRWD (MSG, 30, 13, 1, 1, MXHNIL, 0, 0, ZERO, ZERO)
      GO TO 700
 614  MSG = 'DVODE--  TOUT (=R1) behind T (=R2)      '
      CALL XERRWD (MSG, 40, 14, 1, 0, 0, 0, 2, TOUT, T)
      MSG = '      integration direction is given by H0 (=R1)  '
      CALL XERRWD (MSG, 50, 14, 1, 0, 0, 0, 1, H0, ZERO)
      GO TO 700
 615  MSG = 'DVODE--  HMAX (=R1) .lt. 0.0  '
      CALL XERRWD (MSG, 30, 15, 1, 0, 0, 0, 1, HMAX, ZERO)
      GO TO 700
 616  MSG = 'DVODE--  HMIN (=R1) .lt. 0.0  '
      CALL XERRWD (MSG, 30, 16, 1, 0, 0, 0, 1, HMIN, ZERO)
      GO TO 700
 617  CONTINUE
      MSG='DVODE--  RWORK length needed, LENRW (=I1), exceeds LRW (=I2)'
      CALL XERRWD (MSG, 60, 17, 1, 2, LENRW, LRW, 0, ZERO, ZERO)
      GO TO 700
 618  CONTINUE
      MSG='DVODE--  IWORK length needed, LENIW (=I1), exceeds LIW (=I2)'
      CALL XERRWD (MSG, 60, 18, 1, 2, LENIW, LIW, 0, ZERO, ZERO)
      GO TO 700
 619  MSG = 'DVODE--  RTOL is R1 .lt. 0.0        '
      CALL XERRWD (MSG, 40, 19, 1, 1, I, 0, 1, RTOLI, ZERO)
      GO TO 700
 620  MSG = 'DVODE--  ATOL(I1) is R1 .lt. 0.0        '
      CALL XERRWD (MSG, 40, 20, 1, 1, I, 0, 1, ATOLI, ZERO)

      GO TO 700

 621  EWTI = RWORK(LEWT+I-1)
      MSG = 'DVODE--  EWT(I1) is R1 .le. 0.0         '
      CALL XERRWD (MSG, 40, 21, 1, 1, I, 0, 1, EWTI, ZERO)
      GO TO 700
 622  CONTINUE
      MSG='DVODE--  TOUT (=R1) too close to T(=R2) to start integration'
      CALL XERRWD (MSG, 60, 22, 1, 0, 0, 0, 2, TOUT, T)
      GO TO 700
 623  CONTINUE
      MSG='DVODE--  ITASK = I1 and TOUT (=R1) behind TCUR - HU (= R2)  '
      CALL XERRWD (MSG, 60, 23, 1, 1, ITASK, 0, 2, TOUT, TP)
      GO TO 700
 624  CONTINUE

      MSG='DVODE--  ITASK = 4 or 5 and TCRIT (=R1) behind TCUR (=R2)   '
      CALL XERRWD (MSG, 60, 24, 1, 0, 0, 0, 2, TCRIT, TN)
      GO TO 700
 625  CONTINUE
      MSG='DVODE--  ITASK = 4 or 5 and TCRIT (=R1) behind TOUT (=R2)   '
      CALL XERRWD (MSG, 60, 25, 1, 0, 0, 0, 2, TCRIT, TOUT)
      GO TO 700

 626  MSG = 'DVODE--  At start of problem, too much accuracy   '
      CALL XERRWD (MSG, 50, 26, 1, 0, 0, 0, 0, ZERO, ZERO)
      MSG='      requested for precision of machine..  see TOLSF (=R1) '
      CALL XERRWD (MSG, 60, 26, 1, 0, 0, 0, 1, TOLSF, ZERO)
      RWORK(14) = TOLSF
      GO TO 700
 627  MSG='DVODE--  Trouble from DVINDY.  ITASK = I1, TOUT = R1.       '
      CALL XERRWD (MSG, 60, 27, 1, 1, ITASK, 0, 1, TOUT, ZERO)
C
 700  CONTINUE
      ISTATE = -3
      RETURN
C
 800  MSG = 'DVODE--  Run aborted.. apparent infinite loop     '

      CALL XERRWD (MSG, 50, 303, 2, 0, 0, 0, 0, ZERO, ZERO)
      RETURN
C----------------------- End of Subroutine DVODE -----------------------
      END
*DECK DVHIN
      SUBROUTINE DVHIN (N, T0, Y0, YDOT, F, RPAR, IPAR, TOUT, UROUND,
     1   EWT, ITOL, ATOL, Y, TEMP, H0, NITER, IER)
      EXTERNAL F

      DOUBLE PRECISION T0, Y0, YDOT, RPAR, TOUT, UROUND, EWT, ATOL, Y,
     1   TEMP, H0
      INTEGER N, IPAR, ITOL, NITER, IER
      DIMENSION Y0(*), YDOT(*), EWT(*), ATOL(*), Y(*),
     1   TEMP(*)
C-----------------------------------------------------------------------
C Call sequence input -- N, T0, Y0, YDOT, F, RPAR, IPAR, TOUT, UROUND,
C                        EWT, ITOL, ATOL, Y, TEMP
C Call sequence output -- H0, NITER, IER

C COMMON block variables accessed -- None
C
C Subroutines called by DVHIN.. F
C Function routines called by DVHIN.. DVNORM
C-----------------------------------------------------------------------
C This routine computes the step size, H0, to be attempted on the
C first step, when the user has not supplied a value for this.
C
C First we check that TOUT - T0 differs significantly from zero.  Then
C an iteration is done to approximate the initial second derivative
C and this is used to define h from w.r.m.s.norm(h**2 * yddot / 2) = 1.
C A bias factor of 1/2 is applied to the resulting h.
C The sign of H0 is inferred from the initial values of TOUT and T0.
C
C Communication with DVHIN is done with the following variables..
C
C N      = Size of ODE system, input.
C T0     = Initial value of independent variable, input.
C Y0     = Vector of initial conditions, input.
C YDOT   = Vector of initial first derivatives, input.
C F      = Name of subroutine for right-hand side f(t,y), input.
C RPAR, IPAR = Dummy names for user's real and integer work arrays.
C TOUT   = First output value of independent variable
C UROUND = Machine unit roundoff
C EWT, ITOL, ATOL = Error weights and tolerance parameters
C                   as described in the driver routine, input.
C Y, TEMP = Work arrays of length N.
C H0     = Step size to be attempted, output.
C NITER  = Number of iterations (and of f evaluations) to compute H0,
C          output.
C IER    = The error flag, returned with the value
C          IER = 0  if no trouble occurred, or
C          IER = -1 if TOUT and T0 are considered too close to proceed.
C-----------------------------------------------------------------------
C
C Type declarations for local variables --------------------------------
C
      DOUBLE PRECISION AFI, ATOLI, DELYI, HALF, HG, HLB, HNEW, HRAT,
     1     HUB, HUN, PT1, T1, TDIST, TROUND, TWO, YDDNRM

      INTEGER I, ITER
C
C Type declaration for function subroutines called ---------------------
C
      DOUBLE PRECISION DVNORM
C-----------------------------------------------------------------------
C The following Fortran-77 declaration is to cause the values of the
C listed (local) variables to be saved between calls to this integrator.
C-----------------------------------------------------------------------
      SAVE HALF, HUN, PT1, TWO
      DATA HALF /0.5D0/, HUN /100.0D0/, PT1 /0.1D0/, TWO /2.0D0/

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$omp Threadprivate(HALF, HUN, PT1, TWO)

      NITER = 0
      TDIST = ABS(TOUT - T0)
      TROUND = UROUND*MAX(ABS(T0),ABS(TOUT))
      IF (TDIST .LT. TWO*TROUND) GO TO 100
C
C Set a lower bound on h based on the roundoff level in T0 and TOUT. ---
      HLB = HUN*TROUND
C Set an upper bound on h based on TOUT-T0 and the initial Y and YDOT. -
      HUB = PT1*TDIST

      ATOLI = ATOL(1)
      DO 10 I = 1, N
        IF (ITOL .EQ. 2 .OR. ITOL .EQ. 4) ATOLI = ATOL(I)
        DELYI = PT1*ABS(Y0(I)) + ATOLI
        AFI = ABS(YDOT(I))
        IF (AFI*HUB .GT. DELYI) HUB = DELYI/AFI
 10     CONTINUE
C
C Set initial guess for h as geometric mean of upper and lower bounds. -
      ITER = 0
      HG = SQRT(HLB*HUB)
C If the bounds have crossed, exit with the mean value. ----------------
      IF (HUB .LT. HLB) THEN
        H0 = HG
        GO TO 90
      ENDIF
C
C Looping point for iteration. -----------------------------------------
 50   CONTINUE
C Estimate the second derivative as a difference quotient in f. --------
      T1 = T0 + HG
      DO 60 I = 1, N
 60     Y(I) = Y0(I) + HG*YDOT(I)
      CALL F (N, T1, Y, TEMP, RPAR, IPAR)

      DO 70 I = 1, N
 70     TEMP(I) = (TEMP(I) - YDOT(I))/HG
      YDDNRM = DVNORM (N, TEMP, EWT)
C Get the corresponding new value of h. --------------------------------
      IF (YDDNRM*HUB*HUB .GT. TWO) THEN
        HNEW = SQRT(TWO/YDDNRM)
      ELSE
        HNEW = SQRT(HG*HUB)
      ENDIF
      ITER = ITER + 1
C-----------------------------------------------------------------------
C Test the stopping conditions.
C Stop if the new and previous h values differ by a factor of .lt. 2.

C Stop if four iterations have been done.  Also, stop with previous h
C if HNEW/HG .gt. 2 after first iteration, as this probably means that
C the second derivative value is bad because of cancellation error.
C-----------------------------------------------------------------------
      IF (ITER .GE. 4) GO TO 80
      HRAT = HNEW/HG
      IF ( (HRAT .GT. HALF) .AND. (HRAT .LT. TWO) ) GO TO 80
      IF ( (ITER .GE. 2) .AND. (HNEW .GT. TWO*HG) ) THEN
        HNEW = HG
        GO TO 80
      ENDIF
      HG = HNEW
      GO TO 50
C
C Iteration done.  Apply bounds, bias factor, and sign.  Then exit. ----
 80   H0 = HNEW*HALF
      IF (H0 .LT. HLB) H0 = HLB
      IF (H0 .GT. HUB) H0 = HUB
 90   H0 = SIGN(H0, TOUT - T0)
      NITER = ITER
      IER = 0
      RETURN
C Error return for TOUT - T0 too small. --------------------------------
 100  IER = -1
      RETURN
C----------------------- End of Subroutine DVHIN -----------------------
      END
*DECK DVINDY
      SUBROUTINE DVINDY (T, K, YH, LDYH, DKY, IFLAG)
      DOUBLE PRECISION T, YH, DKY
      INTEGER K, LDYH, IFLAG
      DIMENSION YH(LDYH,*), DKY(*)
C-----------------------------------------------------------------------
C Call sequence input -- T, K, YH, LDYH

C Call sequence output -- DKY, IFLAG
C COMMON block variables accessed..
C     /DVOD01/ --  H, TN, UROUND, L, N, NQ
C     /DVOD02/ --  HU
C
C Subroutines called by DVINDY.. DSCAL, XERRWD
C Function routines called by DVINDY.. None
C-----------------------------------------------------------------------
C DVINDY computes interpolated values of the K-th derivative of the
C dependent variable vector y, and stores it in DKY.  This routine
C is called within the package with K = 0 and T = TOUT, but may
C also be called by the user for any K up to the current order.
C (See detailed instructions in the usage documentation.)
C-----------------------------------------------------------------------
C The computed values in DKY are gotten by interpolation using the
C Nordsieck history array YH.  This array corresponds uniquely to a
C vector-valued polynomial of degree NQCUR or less, and DKY is set
C to the K-th derivative of this polynomial at T.
C The formula for DKY is..
C              q
C  DKY(i)  =  sum  c(j,K) * (T - TN)**(j-K) * H**(-j) * YH(i,j+1)
C             j=K
C where  c(j,K) = j*(j-1)*...*(j-K+1), q = NQCUR, TN = TCUR, H = HCUR.
C The quantities  NQ = NQCUR, L = NQ+1, N, TN, and H are
C communicated by COMMON.  The above sum is done in reverse order.
C IFLAG is returned negative if either K or T is out of bounds.
C
C Discussion above and comments in driver explain all variables.
C-----------------------------------------------------------------------
C
C Type declarations for labeled COMMON block DVOD01 --------------------
C

      DOUBLE PRECISION ACNRM, CCMXJ, CONP, CRATE, DRC, EL,
     1     ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2     RC, RL1, TAU, TQ, TN, UROUND
      INTEGER ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,

     1        L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,
     2        LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,
     3        N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,
     4        NSLP, NYH
C
C Type declarations for labeled COMMON block DVOD02 --------------------
C
      DOUBLE PRECISION HU
      INTEGER NCFN, NETF, NFE, NJE, NLU, NNI, NQU, NST
C
C Type declarations for local variables --------------------------------
C
      DOUBLE PRECISION C, HUN, R, S, TFUZZ, TN1, TP, ZERO
      INTEGER I, IC, J, JB, JB2, JJ, JJ1, JP1
      CHARACTER*80 MSG
C-----------------------------------------------------------------------
C The following Fortran-77 declaration is to cause the values of the
C listed (local) variables to be saved between calls to this integrator.
C-----------------------------------------------------------------------
      SAVE HUN, ZERO
C
      COMMON /DVOD01/ ACNRM, CCMXJ, CONP, CRATE, DRC, EL(13),
     1                ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2                RC, RL1, TAU(13), TQ(5), TN, UROUND,
     3                ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,
     4                L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,
     5                LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,
     6                N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,
     7                NSLP, NYH
      COMMON /DVOD02/ HU, NCFN, NETF, NFE, NJE, NLU, NNI, NQU, NST

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$omp Threadprivate(/DVOD01/,/DVOD02/,HUN,ZERO)


      DATA HUN /100.0D0/, ZERO /0.0D0/
C
      IFLAG = 0
      IF (K .LT. 0 .OR. K .GT. NQ) GO TO 80
      TFUZZ = HUN*UROUND*(TN + HU)
      TP = TN - HU - TFUZZ
      TN1 = TN + TFUZZ

      IF ((T-TP)*(T-TN1) .GT. ZERO) GO TO 90
C
      S = (T - TN)/H
      IC = 1
      IF (K .EQ. 0) GO TO 15

      JJ1 = L - K
      DO 10 JJ = JJ1, NQ
 10     IC = IC*JJ
 15   C = REAL(IC)
      DO 20 I = 1, N
 20     DKY(I) = C*YH(I,L)
      IF (K .EQ. NQ) GO TO 55

      JB2 = NQ - K
      DO 50 JB = 1, JB2
        J = NQ - JB
        JP1 = J + 1


        IC = 1
        IF (K .EQ. 0) GO TO 35
        JJ1 = JP1 - K
        DO 30 JJ = JJ1, J
 30       IC = IC*JJ

 35     C = REAL(IC)
        DO 40 I = 1, N
 40       DKY(I) = C*YH(I,JP1) + S*DKY(I)
 50     CONTINUE
      IF (K .EQ. 0) RETURN
 55   R = H**(-K)
      CALL DSCAL (N, R, DKY, 1)
      RETURN

C
 80   MSG = 'DVINDY-- K (=I1) illegal      '
      CALL XERRWD (MSG, 30, 51, 1, 1, K, 0, 0, ZERO, ZERO)
      IFLAG = -1
      RETURN
 90   MSG = 'DVINDY-- T (=R1) illegal      '
      CALL XERRWD (MSG, 30, 52, 1, 0, 0, 0, 1, T, ZERO)
      MSG='      T not in interval TCUR - HU (= R1) to TCUR (=R2)      '
      CALL XERRWD (MSG, 60, 52, 1, 0, 0, 0, 2, TP, TN)
      IFLAG = -2
      RETURN
C----------------------- End of Subroutine DVINDY ----------------------
      END
*DECK DVSTEP
      SUBROUTINE DVSTEP (Y, YH, LDYH, YH1, EWT, SAVF, VSAV, ACOR,
     1                  WM, IWM, F, JAC, PSOL, VNLS, RPAR, IPAR)
      EXTERNAL F, JAC, PSOL, VNLS
      DOUBLE PRECISION Y, YH, YH1, EWT, SAVF, VSAV, ACOR, WM, RPAR
      INTEGER LDYH, IWM, IPAR
      DIMENSION Y(*), YH(LDYH,*), YH1(*), EWT(*), SAVF(*), VSAV(*),
     1   ACOR(*), WM(*), IWM(*)
C-----------------------------------------------------------------------
C Call sequence input -- Y, YH, LDYH, YH1, EWT, SAVF, VSAV,
C                        ACOR, WM, IWM, F, JAC, PSOL, VNLS, RPAR, IPAR
C Call sequence output -- YH, ACOR, WM, IWM
C COMMON block variables accessed..
C     /DVOD01/  ACNRM, EL(13), H, HMIN, HMXI, HNEW, HSCAL, RC, TAU(13),
C               TQ(5), TN, JCUR, JSTART, KFLAG, KUTH,
C               L, LMAX, MAXORD, MITER, N, NEWQ, NQ, NQWAIT
C     /DVOD02/  HU, NCFN, NETF, NFE, NQU, NST
C
C Subroutines called by DVSTEP.. F, DAXPY, DCOPY, DSCAL,
C                               DVJUST, VNLS, DVSET
C Function routines called by DVSTEP.. DVNORM
C-----------------------------------------------------------------------
C DVSTEP performs one step of the integration of an initial value
C problem for a system of ordinary differential equations.
C DVSTEP calls subroutine VNLS for the solution of the nonlinear system
C arising in the time step.  Thus it is independent of the problem
C Jacobian structure and the type of nonlinear system solution method.
C DVSTEP returns a completion flag KFLAG (in COMMON).
C A return with KFLAG = -1 or -2 means either ABS(H) = HMIN or 10
C consecutive failures occurred.  On a return with KFLAG negative,
C the values of TN and the YH array are as of the beginning of the last

C step, and H is the last step size attempted.
C
C Communication with DVSTEP is done with the following variables..
C
C Y      = An array of length N used for the dependent variable vector.
C YH     = An LDYH by LMAX array containing the dependent variables
C          and their approximate scaled derivatives, where
C          LMAX = MAXORD + 1.  YH(i,j+1) contains the approximate
C          j-th derivative of y(i), scaled by H**j/factorial(j)
C          (j = 0,1,...,NQ).  On entry for the first step, the first
C          two columns of YH must be set from the initial values.
C LDYH   = A constant integer .ge. N, the first dimension of YH.
C          N is the number of ODEs in the system.
C YH1    = A one-dimensional array occupying the same space as YH.
C EWT    = An array of length N containing multiplicative weights
C          for local error measurements.  Local errors in y(i) are
C          compared to 1.0/EWT(i) in various error tests.
C SAVF   = An array of working storage, of length N.


C          also used for input of YH(*,MAXORD+2) when JSTART = -1
C          and MAXORD .lt. the current order NQ.
C VSAV   = A work array of length N passed to subroutine VNLS.
C ACOR   = A work array of length N, used for the accumulated
C          corrections.  On a successful return, ACOR(i) contains
C          the estimated one-step local error in y(i).
C WM,IWM = Real and integer work arrays associated with matrix
C          operations in VNLS.
C F      = Dummy name for the user supplied subroutine for f.
C JAC    = Dummy name for the user supplied Jacobian subroutine.
C PSOL   = Dummy name for the subroutine passed to VNLS, for
C          possible use there.
C VNLS   = Dummy name for the nonlinear system solving subroutine,

C          whose real name is dependent on the method used.
C RPAR, IPAR = Dummy names for user's real and integer work arrays.
C-----------------------------------------------------------------------
C
C Type declarations for labeled COMMON block DVOD01 --------------------
C
      DOUBLE PRECISION ACNRM, CCMXJ, CONP, CRATE, DRC, EL,
     1     ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2     RC, RL1, TAU, TQ, TN, UROUND
      INTEGER ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,

     1        L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,
     2        LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,
     3        N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,
     4        NSLP, NYH

C
C Type declarations for labeled COMMON block DVOD02 --------------------
C

      DOUBLE PRECISION HU
      INTEGER NCFN, NETF, NFE, NJE, NLU, NNI, NQU, NST
C
C Type declarations for local variables --------------------------------
C
      DOUBLE PRECISION ADDON, BIAS1,BIAS2,BIAS3, CNQUOT, DDN, DSM, DUP,

     1     ETACF, ETAMIN, ETAMX1, ETAMX2, ETAMX3, ETAMXF,
     2     ETAQ, ETAQM1, ETAQP1, FLOTL, ONE, ONEPSM,
     3     R, THRESH, TOLD, ZERO
      INTEGER I, I1, I2, IBACK, J, JB, KFC, KFH, MXNCF, NCF, NFLAG
C
C Type declaration for function subroutines called ---------------------
C
      DOUBLE PRECISION DVNORM
C-----------------------------------------------------------------------
C The following Fortran-77 declaration is to cause the values of the
C listed (local) variables to be saved between calls to this integrator.
C-----------------------------------------------------------------------

      SAVE ADDON, BIAS1, BIAS2, BIAS3,

     1     ETACF, ETAMIN, ETAMX1, ETAMX2, ETAMX3, ETAMXF,
     2     KFC, KFH, MXNCF, ONEPSM, THRESH, ONE, ZERO
C-----------------------------------------------------------------------
      COMMON /DVOD01/ ACNRM, CCMXJ, CONP, CRATE, DRC, EL(13),
     1                ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2                RC, RL1, TAU(13), TQ(5), TN, UROUND,

     3                ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,
     4                L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,
     5                LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,
     6                N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,
     7                NSLP, NYH
      COMMON /DVOD02/ HU, NCFN, NETF, NFE, NJE, NLU, NNI, NQU, NST

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$omp Threadprivate(/DVOD01/,/DVOD02/,ADDON,BIAS1,BIAS2,BIAS3,ETACF,
!$omp&ETAMIN,ETAMX1,ETAMX2,ETAMX3,ETAMXF,KFC,KFH,MXNCF,ONEPSM,THRESH,
!$omp&ONE,ZERO)


      DATA KFC/-3/, KFH/-7/, MXNCF/10/
      DATA ADDON  /1.0D-6/,    BIAS1  /6.0D0/,     BIAS2  /6.0D0/,
     1     BIAS3  /10.0D0/,    ETACF  /0.25D0/,    ETAMIN /0.1D0/,
     2     ETAMXF /0.2D0/,     ETAMX1 /1.0D4/,     ETAMX2 /10.0D0/,
     3     ETAMX3 /10.0D0/,    ONEPSM /1.00001D0/, THRESH /1.5D0/
      DATA ONE/1.0D0/, ZERO/0.0D0/
C
      KFLAG = 0
      TOLD = TN
      NCF = 0
      JCUR = 0
      NFLAG = 0

      IF (JSTART .GT. 0) GO TO 20
      IF (JSTART .EQ. -1) GO TO 100
C-----------------------------------------------------------------------
C On the first call, the order is set to 1, and other variables are
C initialized.  ETAMAX is the maximum ratio by which H can be increased
C in a single step.  It is normally 1.5, but is larger during the
C first 10 steps to compensate for the small initial H.  If a failure
C occurs (in corrector convergence or error test), ETAMAX is set to 1
C for the next increase.
C-----------------------------------------------------------------------
      LMAX = MAXORD + 1
      NQ = 1
      L = 2
      NQNYH = NQ*LDYH
      TAU(1) = H
      PRL1 = ONE
      RC = ZERO
      ETAMAX = ETAMX1
      NQWAIT = 2
      HSCAL = H
      GO TO 200
C-----------------------------------------------------------------------
C Take preliminary actions on a normal continuation step (JSTART.GT.0).

C If the driver changed H, then ETA must be reset and NEWH set to 1.
C If a change of order was dictated on the previous step, then
C it is done here and appropriate adjustments in the history are made.
C On an order decrease, the history array is adjusted by DVJUST.
C On an order increase, the history array is augmented by a column.
C On a change of step size H, the history array YH is rescaled.
C-----------------------------------------------------------------------
 20   CONTINUE

      IF (KUTH .EQ. 1) THEN
        ETA = MIN(ETA,H/HSCAL)
        NEWH = 1
        ENDIF
 50   IF (NEWH .EQ. 0) GO TO 200
      IF (NEWQ .EQ. NQ) GO TO 150
      IF (NEWQ .LT. NQ) THEN
        CALL DVJUST (YH, LDYH, -1)
        NQ = NEWQ
        L = NQ + 1
        NQWAIT = L
        GO TO 150
        ENDIF
      IF (NEWQ .GT. NQ) THEN
        CALL DVJUST (YH, LDYH, 1)
        NQ = NEWQ
        L = NQ + 1
        NQWAIT = L
        GO TO 150
      ENDIF
C-----------------------------------------------------------------------
C The following block handles preliminaries needed when JSTART = -1.
C If N was reduced, zero out part of YH to avoid undefined references.
C If MAXORD was reduced to a value less than the tentative order NEWQ,
C then NQ is set to MAXORD, and a new H ratio ETA is chosen.

C Otherwise, we take the same preliminary actions as for JSTART .gt. 0.
C In any case, NQWAIT is reset to L = NQ + 1 to prevent further
C changes in order for that many steps.
C The new H ratio ETA is limited by the input H if KUTH = 1,
C by HMIN if KUTH = 0, and by HMXI in any case.
C Finally, the history array YH is rescaled.
C-----------------------------------------------------------------------
 100  CONTINUE
      LMAX = MAXORD + 1
      IF (N .EQ. LDYH) GO TO 120
      I1 = 1 + (NEWQ + 1)*LDYH
      I2 = (MAXORD + 1)*LDYH
      IF (I1 .GT. I2) GO TO 120
      DO 110 I = I1, I2
 110    YH1(I) = ZERO
 120  IF (NEWQ .LE. MAXORD) GO TO 140
      FLOTL = REAL(LMAX)
      IF (MAXORD .LT. NQ-1) THEN
        DDN = DVNORM (N, SAVF, EWT)/TQ(1)
        ETA = ONE/((BIAS1*DDN)**(ONE/FLOTL) + ADDON)
        ENDIF
      IF (MAXORD .EQ. NQ .AND. NEWQ .EQ. NQ+1) ETA = ETAQ
      IF (MAXORD .EQ. NQ-1 .AND. NEWQ .EQ. NQ+1) THEN
        ETA = ETAQM1
        CALL DVJUST (YH, LDYH, -1)
        ENDIF
      IF (MAXORD .EQ. NQ-1 .AND. NEWQ .EQ. NQ) THEN
        DDN = DVNORM (N, SAVF, EWT)/TQ(1)
        ETA = ONE/((BIAS1*DDN)**(ONE/FLOTL) + ADDON)
        CALL DVJUST (YH, LDYH, -1)
        ENDIF
      ETA = MIN(ETA,ONE)
      NQ = MAXORD
      L = LMAX
 140  IF (KUTH .EQ. 1) ETA = MIN(ETA,ABS(H/HSCAL))
      IF (KUTH .EQ. 0) ETA = MAX(ETA,HMIN/ABS(HSCAL))
      ETA = ETA/MAX(ONE,ABS(HSCAL)*HMXI*ETA)
      NEWH = 1

      NQWAIT = L
      IF (NEWQ .LE. MAXORD) GO TO 50
C Rescale the history array for a change in H by a factor of ETA. ------
 150  R = ONE
      DO 180 J = 2, L
        R = R*ETA
        CALL DSCAL (N, R, YH(1,J), 1 )
 180    CONTINUE
      H = HSCAL*ETA
      HSCAL = H
      RC = RC*ETA
      NQNYH = NQ*LDYH
C-----------------------------------------------------------------------
C This section computes the predicted values by effectively
C multiplying the YH array by the Pascal triangle matrix.
C DVSET is called to calculate all integration coefficients.
C RC is the ratio of new to old values of the coefficient H/EL(2)=h/l1.
C-----------------------------------------------------------------------
 200  TN = TN + H
      I1 = NQNYH + 1
      DO 220 JB = 1, NQ
        I1 = I1 - LDYH
        DO 210 I = I1, NQNYH
 210      YH1(I) = YH1(I) + YH1(I+LDYH)
 220  CONTINUE
      CALL DVSET

      RL1 = ONE/EL(2)
      RC = RC*(RL1/PRL1)
      PRL1 = RL1
C
C Call the nonlinear system solver. ------------------------------------
C
      CALL VNLS (Y, YH, LDYH, VSAV, SAVF, EWT, ACOR, IWM, WM,
     1           F, JAC, PSOL, NFLAG, RPAR, IPAR)
C
      IF (NFLAG .EQ. 0) GO TO 450

C-----------------------------------------------------------------------
C The VNLS routine failed to achieve convergence (NFLAG .NE. 0).
C The YH array is retracted to its values before prediction.
C The step size H is reduced and the step is retried, if possible.
C Otherwise, an error exit is taken.
C-----------------------------------------------------------------------
        NCF = NCF + 1
        NCFN = NCFN + 1
        ETAMAX = ONE
        TN = TOLD
        I1 = NQNYH + 1
        DO 430 JB = 1, NQ
          I1 = I1 - LDYH
          DO 420 I = I1, NQNYH
 420        YH1(I) = YH1(I) - YH1(I+LDYH)
 430      CONTINUE

        IF (NFLAG .LT. -1) GO TO 680
        IF (ABS(H) .LE. HMIN*ONEPSM) GO TO 670
        IF (NCF .EQ. MXNCF) GO TO 670

        ETA = ETACF
        ETA = MAX(ETA,HMIN/ABS(H))
        NFLAG = -1
        GO TO 150
C-----------------------------------------------------------------------
C The corrector has converged (NFLAG = 0).  The local error test is
C made and control passes to statement 500 if it fails.
C-----------------------------------------------------------------------
 450  CONTINUE
      DSM = ACNRM/TQ(2)
      IF (DSM .GT. ONE) GO TO 500
C-----------------------------------------------------------------------
C After a successful step, update the YH and TAU arrays and decrement
C NQWAIT.  If NQWAIT is then 1 and NQ .lt. MAXORD, then ACOR is saved
C for use in a possible order increase on the next step.
C If ETAMAX = 1 (a failure occurred this step), keep NQWAIT .ge. 2.
C-----------------------------------------------------------------------
      KFLAG = 0
      NST = NST + 1
      HU = H
      NQU = NQ
      DO 470 IBACK = 1, NQ
        I = L - IBACK
 470    TAU(I+1) = TAU(I)
      TAU(1) = H
      DO 480 J = 1, L
        CALL DAXPY (N, EL(J), ACOR, 1, YH(1,J), 1 )
 480    CONTINUE
      NQWAIT = NQWAIT - 1
      IF ((L .EQ. LMAX) .OR. (NQWAIT .NE. 1)) GO TO 490
      CALL DCOPY (N, ACOR, 1, YH(1,LMAX), 1 )
      CONP = TQ(5)
 490  IF (ETAMAX .NE. ONE) GO TO 560
      IF (NQWAIT .LT. 2) NQWAIT = 2
      NEWQ = NQ
      NEWH = 0
      ETA = ONE
      HNEW = H
      GO TO 690
C-----------------------------------------------------------------------
C The error test failed.  KFLAG keeps track of multiple failures.
C Restore TN and the YH array to their previous values, and prepare
C to try the step again.  Compute the optimum step size for the
C same order.  After repeated failures, H is forced to decrease
C more rapidly.
C-----------------------------------------------------------------------
 500  KFLAG = KFLAG - 1
      NETF = NETF + 1
      NFLAG = -2
      TN = TOLD
      I1 = NQNYH + 1
      DO 520 JB = 1, NQ
        I1 = I1 - LDYH
        DO 510 I = I1, NQNYH
 510      YH1(I) = YH1(I) - YH1(I+LDYH)
 520  CONTINUE
      IF (ABS(H) .LE. HMIN*ONEPSM) GO TO 660
      ETAMAX = ONE
      IF (KFLAG .LE. KFC) GO TO 530
C Compute ratio of new H to current H at the current order. ------------
      FLOTL = REAL(L)
      ETA = ONE/((BIAS2*DSM)**(ONE/FLOTL) + ADDON)
      ETA = MAX(ETA,HMIN/ABS(H),ETAMIN)
      IF ((KFLAG .LE. -2) .AND. (ETA .GT. ETAMXF)) ETA = ETAMXF
      GO TO 150
C-----------------------------------------------------------------------

C Control reaches this section if 3 or more consecutive failures
C have occurred.  It is assumed that the elements of the YH array
C have accumulated errors of the wrong order.  The order is reduced
C by one, if possible.  Then H is reduced by a factor of 0.1 and
C the step is retried.  After a total of 7 consecutive failures,

C an exit is taken with KFLAG = -1.
C-----------------------------------------------------------------------
 530  IF (KFLAG .EQ. KFH) GO TO 660
      IF (NQ .EQ. 1) GO TO 540
      ETA = MAX(ETAMIN,HMIN/ABS(H))
      CALL DVJUST (YH, LDYH, -1)
      L = NQ
      NQ = NQ - 1
      NQWAIT = L
      GO TO 150
 540  ETA = MAX(ETAMIN,HMIN/ABS(H))
      H = H*ETA
      HSCAL = H
      TAU(1) = H
      CALL F (N, TN, Y, SAVF, RPAR, IPAR)
      NFE = NFE + 1
      DO 550 I = 1, N
 550    YH(I,2) = H*SAVF(I)
      NQWAIT = 10
      GO TO 200
C-----------------------------------------------------------------------
C If NQWAIT = 0, an increase or decrease in order by one is considered.
C Factors ETAQ, ETAQM1, ETAQP1 are computed by which H could
C be multiplied at order q, q-1, or q+1, respectively.
C The largest of these is determined, and the new order and
C step size set accordingly.
C A change of H or NQ is made only if H increases by at least a
C factor of THRESH.  If an order change is considered and rejected,

C then NQWAIT is set to 2 (reconsider it after 2 steps).
C-----------------------------------------------------------------------
C Compute ratio of new H to current H at the current order. ------------
 560  FLOTL = REAL(L)
      ETAQ = ONE/((BIAS2*DSM)**(ONE/FLOTL) + ADDON)
      IF (NQWAIT .NE. 0) GO TO 600
      NQWAIT = 2
      ETAQM1 = ZERO
      IF (NQ .EQ. 1) GO TO 570
C Compute ratio of new H to current H at the current order less one. ---

      DDN = DVNORM (N, YH(1,L), EWT)/TQ(1)
      ETAQM1 = ONE/((BIAS1*DDN)**(ONE/(FLOTL - ONE)) + ADDON)
 570  ETAQP1 = ZERO
      IF (L .EQ. LMAX) GO TO 580
C Compute ratio of new H to current H at current order plus one. -------

      CNQUOT = (TQ(5)/CONP)*(H/TAU(2))**L

      DO 575 I = 1, N
 575    SAVF(I) = ACOR(I) - CNQUOT*YH(I,LMAX)
      DUP = DVNORM (N, SAVF, EWT)/TQ(3)
      ETAQP1 = ONE/((BIAS3*DUP)**(ONE/(FLOTL + ONE)) + ADDON)
 580  IF (ETAQ .GE. ETAQP1) GO TO 590
      IF (ETAQP1 .GT. ETAQM1) GO TO 620
      GO TO 610
 590  IF (ETAQ .LT. ETAQM1) GO TO 610
 600  ETA = ETAQ
      NEWQ = NQ
      GO TO 630
 610  ETA = ETAQM1
      NEWQ = NQ - 1
      GO TO 630
 620  ETA = ETAQP1
      NEWQ = NQ + 1
      CALL DCOPY (N, ACOR, 1, YH(1,LMAX), 1)
C Test tentative new H against THRESH, ETAMAX, and HMXI, then exit. ----
 630  IF (ETA .LT. THRESH .OR. ETAMAX .EQ. ONE) GO TO 640
      ETA = MIN(ETA,ETAMAX)
      ETA = ETA/MAX(ONE,ABS(H)*HMXI*ETA)
      NEWH = 1
      HNEW = H*ETA
      GO TO 690
 640  NEWQ = NQ
      NEWH = 0
      ETA = ONE
      HNEW = H
      GO TO 690
C-----------------------------------------------------------------------
C All returns are made through this section.
C On a successful return, ETAMAX is reset and ACOR is scaled.


C-----------------------------------------------------------------------
 660  KFLAG = -1
      GO TO 720
 670  KFLAG = -2
      GO TO 720
 680  IF (NFLAG .EQ. -2) KFLAG = -3
      IF (NFLAG .EQ. -3) KFLAG = -4
      GO TO 720
 690  ETAMAX = ETAMX3
      IF (NST .LE. 10) ETAMAX = ETAMX2
 700  R = ONE/TQ(2)
      CALL DSCAL (N, R, ACOR, 1)
 720  JSTART = 1
      RETURN
C----------------------- End of Subroutine DVSTEP ----------------------

      END
*DECK DVSET

      SUBROUTINE DVSET
C-----------------------------------------------------------------------
C Call sequence communication.. None
C COMMON block variables accessed..
C     /DVOD01/ -- EL(13), H, TAU(13), TQ(5), L(= NQ + 1),

C                 METH, NQ, NQWAIT
C
C Subroutines called by DVSET.. None
C Function routines called by DVSET.. None
C-----------------------------------------------------------------------
C DVSET is called by DVSTEP and sets coefficients for use there.
C
C For each order NQ, the coefficients in EL are calculated by use of
C  the generating polynomial lambda(x), with coefficients EL(i).
C      lambda(x) = EL(1) + EL(2)*x + ... + EL(NQ+1)*(x**NQ).
C For the backward differentiation formulas,
C                                     NQ-1
C      lambda(x) = (1 + x/xi*(NQ)) * product (1 + x/xi(i) ) .
C                                     i = 1
C For the Adams formulas,
C                              NQ-1

C      (d/dx) lambda(x) = c * product (1 + x/xi(i) ) ,

C                              i = 1
C      lambda(-1) = 0,    lambda(0) = 1,
C where c is a normalization constant.
C In both cases, xi(i) is defined by
C      H*xi(i) = t sub n  -  t sub (n-i)

C              = H + TAU(1) + TAU(2) + ... TAU(i-1).

C

C
C In addition to variables described previously, communication
C with DVSET uses the following..
C   TAU    = A vector of length 13 containing the past NQ values
C            of H.
C   EL     = A vector of length 13 in which vset stores the
C            coefficients for the corrector formula.
C   TQ     = A vector of length 5 in which vset stores constants
C            used for the convergence test, the error test, and the
C            selection of H at a new order.
C   METH   = The basic method indicator.
C   NQ     = The current order.
C   L      = NQ + 1, the length of the vector stored in EL, and
C            the number of columns of the YH array being used.
C   NQWAIT = A counter controlling the frequency of order changes.
C            An order change is about to be considered if NQWAIT = 1.
C-----------------------------------------------------------------------
C
C Type declarations for labeled COMMON block DVOD01 --------------------
C

      DOUBLE PRECISION ACNRM, CCMXJ, CONP, CRATE, DRC, EL,
     1     ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2     RC, RL1, TAU, TQ, TN, UROUND
      INTEGER ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,
     1        L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,
     2        LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,

     3        N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,
     4        NSLP, NYH
C
C Type declarations for local variables --------------------------------
C
      DOUBLE PRECISION AHATN0, ALPH0, CNQM1, CORTES, CSUM, ELP, EM,
     1     EM0, FLOTI, FLOTL, FLOTNQ, HSUM, ONE, RXI, RXIS, S, SIX,
     2     T1, T2, T3, T4, T5, T6, TWO, XI, ZERO
      INTEGER I, IBACK, J, JP1, NQM1, NQM2
C
      DIMENSION EM(13)
C-----------------------------------------------------------------------
C The following Fortran-77 declaration is to cause the values of the
C listed (local) variables to be saved between calls to this integrator.
C-----------------------------------------------------------------------
      SAVE CORTES, ONE, SIX, TWO, ZERO
C
      COMMON /DVOD01/ ACNRM, CCMXJ, CONP, CRATE, DRC, EL(13),
     1                ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2                RC, RL1, TAU(13), TQ(5), TN, UROUND,
     3                ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,
     4                L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,
     5                LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,
     6                N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,
     7                NSLP, NYH
C
      DATA CORTES /0.1D0/
      DATA ONE  /1.0D0/, SIX /6.0D0/, TWO /2.0D0/, ZERO /0.0D0/

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$omp Threadprivate(/DVOD01/,CORTES, ONE, SIX, TWO, ZERO)


      FLOTL = REAL(L)
      NQM1 = NQ - 1
      NQM2 = NQ - 2
      GO TO (100, 200), METH
C
C Set coefficients for Adams methods. ----------------------------------
 100  IF (NQ .NE. 1) GO TO 110
      EL(1) = ONE
      EL(2) = ONE
      TQ(1) = ONE
      TQ(2) = TWO
      TQ(3) = SIX*TQ(2)
      TQ(5) = ONE
      GO TO 300
 110  HSUM = H
      EM(1) = ONE
      FLOTNQ = FLOTL - ONE
      DO 115 I = 2, L
 115    EM(I) = ZERO
      DO 150 J = 1, NQM1
        IF ((J .NE. NQM1) .OR. (NQWAIT .NE. 1)) GO TO 130
        S = ONE
        CSUM = ZERO

        DO 120 I = 1, NQM1
          CSUM = CSUM + S*EM(I)/REAL(I+1)
 120      S = -S
        TQ(1) = EM(NQM1)/(FLOTNQ*CSUM)
 130    RXI = H/HSUM
        DO 140 IBACK = 1, J
          I = (J + 2) - IBACK
 140      EM(I) = EM(I) + EM(I-1)*RXI
        HSUM = HSUM + TAU(J)
 150    CONTINUE
C Compute integral from -1 to 0 of polynomial and of x times it. -------

      S = ONE
      EM0 = ZERO
      CSUM = ZERO
      DO 160 I = 1, NQ
        FLOTI = REAL(I)
        EM0 = EM0 + S*EM(I)/FLOTI
        CSUM = CSUM + S*EM(I)/(FLOTI+ONE)
 160    S = -S

C In EL, form coefficients of normalized integrated polynomial. --------
      S = ONE/EM0
      EL(1) = ONE
      DO 170 I = 1, NQ
 170    EL(I+1) = S*EM(I)/REAL(I)
      XI = HSUM/H
      TQ(2) = XI*EM0/CSUM
      TQ(5) = XI/EL(L)
      IF (NQWAIT .NE. 1) GO TO 300
C For higher order control constant, multiply polynomial by 1+x/xi(q). -
      RXI = ONE/XI
      DO 180 IBACK = 1, NQ
        I = (L + 1) - IBACK
 180    EM(I) = EM(I) + EM(I-1)*RXI
C Compute integral of polynomial. --------------------------------------
      S = ONE

      CSUM = ZERO
      DO 190 I = 1, L
        CSUM = CSUM + S*EM(I)/REAL(I+1)
 190    S = -S
      TQ(3) = FLOTL*EM0/CSUM
      GO TO 300
C
C Set coefficients for BDF methods. ------------------------------------
 200  DO 210 I = 3, L
 210    EL(I) = ZERO
      EL(1) = ONE
      EL(2) = ONE
      ALPH0 = -ONE
      AHATN0 = -ONE
      HSUM = H
      RXI = ONE

      RXIS = ONE
      IF (NQ .EQ. 1) GO TO 240

      DO 230 J = 1, NQM2
C In EL, construct coefficients of (1+x/xi(1))*...*(1+x/xi(j+1)). ------
        HSUM = HSUM + TAU(J)
        RXI = H/HSUM
        JP1 = J + 1
        ALPH0 = ALPH0 - ONE/REAL(JP1)
        DO 220 IBACK = 1, JP1
          I = (J + 3) - IBACK
 220      EL(I) = EL(I) + EL(I-1)*RXI
 230    CONTINUE
      ALPH0 = ALPH0 - ONE/REAL(NQ)
      RXIS = -EL(2) - ALPH0
      HSUM = HSUM + TAU(NQM1)
      RXI = H/HSUM
      AHATN0 = -EL(2) - RXI
      DO 235 IBACK = 1, NQ
        I = (NQ + 2) - IBACK
 235    EL(I) = EL(I) + EL(I-1)*RXIS
 240  T1 = ONE - AHATN0 + ALPH0
      T2 = ONE + REAL(NQ)*T1
      TQ(2) = ABS(ALPH0*T2/T1)
      TQ(5) = ABS(T2/(EL(L)*RXI/RXIS))
      IF (NQWAIT .NE. 1) GO TO 300
      CNQM1 = RXIS/EL(L)
      T3 = ALPH0 + ONE/REAL(NQ)


      T4 = AHATN0 + RXI
      ELP = T3/(ONE - T4 + T3)
      TQ(1) = ABS(ELP/CNQM1)
      HSUM = HSUM + TAU(NQ)
      RXI = H/HSUM
      T5 = ALPH0 - ONE/REAL(NQ+1)
      T6 = AHATN0 - RXI
      ELP = T2/(ONE - T6 + T5)
      TQ(3) = ABS(ELP*RXI*(FLOTL + ONE)*T5)
 300  TQ(4) = CORTES*TQ(2)
      RETURN
C----------------------- End of Subroutine DVSET -----------------------
      END
*DECK DVJUST
      SUBROUTINE DVJUST (YH, LDYH, IORD)
      DOUBLE PRECISION YH
      INTEGER LDYH, IORD


      DIMENSION YH(LDYH,*)
C-----------------------------------------------------------------------
C Call sequence input -- YH, LDYH, IORD
C Call sequence output -- YH
C COMMON block input -- NQ, METH, LMAX, HSCAL, TAU(13), N
C COMMON block variables accessed..
C     /DVOD01/ -- HSCAL, TAU(13), LMAX, METH, N, NQ,
C
C Subroutines called by DVJUST.. DAXPY
C Function routines called by DVJUST.. None
C-----------------------------------------------------------------------
C This subroutine adjusts the YH array on reduction of order,
C and also when the order is increased for the stiff option (METH = 2).
C Communication with DVJUST uses the following..
C IORD  = An integer flag used when METH = 2 to indicate an order
C         increase (IORD = +1) or an order decrease (IORD = -1).
C HSCAL = Step size H used in scaling of Nordsieck array YH.
C         (If IORD = +1, DVJUST assumes that HSCAL = TAU(1).)
C See References 1 and 2 for details.
C-----------------------------------------------------------------------
C
C Type declarations for labeled COMMON block DVOD01 --------------------
C
      DOUBLE PRECISION ACNRM, CCMXJ, CONP, CRATE, DRC, EL,
     1     ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2     RC, RL1, TAU, TQ, TN, UROUND
      INTEGER ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,
     1        L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,

     2        LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,

     3        N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,

     4        NSLP, NYH
C
C Type declarations for local variables --------------------------------
C
      DOUBLE PRECISION ALPH0, ALPH1, HSUM, ONE, PROD, T1, XI,XIOLD, ZERO
      INTEGER I, IBACK, J, JP1, LP1, NQM1, NQM2, NQP1
C-----------------------------------------------------------------------
C The following Fortran-77 declaration is to cause the values of the
C listed (local) variables to be saved between calls to this integrator.
C-----------------------------------------------------------------------
      SAVE ONE, ZERO
C
      COMMON /DVOD01/ ACNRM, CCMXJ, CONP, CRATE, DRC, EL(13),
     1                ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2                RC, RL1, TAU(13), TQ(5), TN, UROUND,
     3                ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,

     4                L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,
     5                LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,
     6                N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,
     7                NSLP, NYH

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$omp Threadprivate(/DVOD01/,One,Zero)

      DATA ONE /1.0D0/, ZERO /0.0D0/
C
      IF ((NQ .EQ. 2) .AND. (IORD .NE. 1)) RETURN
      NQM1 = NQ - 1
      NQM2 = NQ - 2
      GO TO (100, 200), METH

C-----------------------------------------------------------------------
C Nonstiff option...
C Check to see if the order is being increased or decreased.
C-----------------------------------------------------------------------
 100  CONTINUE
      IF (IORD .EQ. 1) GO TO 180

C Order decrease. ------------------------------------------------------
      DO 110 J = 1, LMAX
 110    EL(J) = ZERO
      EL(2) = ONE
      HSUM = ZERO
      DO 130 J = 1, NQM2
C Construct coefficients of x*(x+xi(1))*...*(x+xi(j)). -----------------
        HSUM = HSUM + TAU(J)
        XI = HSUM/HSCAL
        JP1 = J + 1
        DO 120 IBACK = 1, JP1
          I = (J + 3) - IBACK
 120      EL(I) = EL(I)*XI + EL(I-1)
 130    CONTINUE
C Construct coefficients of integrated polynomial. ---------------------

      DO 140 J = 2, NQM1
 140    EL(J+1) = REAL(NQ)*EL(J)/REAL(J)
C Subtract correction terms from YH array. -----------------------------
      DO 170 J = 3, NQ

        DO 160 I = 1, N
 160      YH(I,J) = YH(I,J) - YH(I,L)*EL(J)
 170    CONTINUE
      RETURN
C Order increase. ------------------------------------------------------
C Zero out next column in YH array. ------------------------------------
 180  CONTINUE
      LP1 = L + 1
      DO 190 I = 1, N
 190    YH(I,LP1) = ZERO
      RETURN
C-----------------------------------------------------------------------
C Stiff option...
C Check to see if the order is being increased or decreased.
C-----------------------------------------------------------------------
 200  CONTINUE
      IF (IORD .EQ. 1) GO TO 300
C Order decrease. ------------------------------------------------------
      DO 210 J = 1, LMAX
 210    EL(J) = ZERO
      EL(3) = ONE

      HSUM = ZERO
      DO 230 J = 1,NQM2
C Construct coefficients of x*x*(x+xi(1))*...*(x+xi(j)). ---------------
        HSUM = HSUM + TAU(J)
        XI = HSUM/HSCAL

        JP1 = J + 1
        DO 220 IBACK = 1, JP1
          I = (J + 4) - IBACK
 220      EL(I) = EL(I)*XI + EL(I-1)
 230    CONTINUE
C Subtract correction terms from YH array. -----------------------------
      DO 250 J = 3,NQ
        DO 240 I = 1, N
 240      YH(I,J) = YH(I,J) - YH(I,L)*EL(J)
 250    CONTINUE
      RETURN
C Order increase. ------------------------------------------------------
 300  DO 310 J = 1, LMAX
 310    EL(J) = ZERO
      EL(3) = ONE
      ALPH0 = -ONE
      ALPH1 = ONE
      PROD = ONE
      XIOLD = ONE
      HSUM = HSCAL
      IF (NQ .EQ. 1) GO TO 340
      DO 330 J = 1, NQM1
C Construct coefficients of x*x*(x+xi(1))*...*(x+xi(j)). ---------------
        JP1 = J + 1
        HSUM = HSUM + TAU(JP1)
        XI = HSUM/HSCAL
        PROD = PROD*XI
        ALPH0 = ALPH0 - ONE/REAL(JP1)
        ALPH1 = ALPH1 + ONE/XI
        DO 320 IBACK = 1, JP1
          I = (J + 4) - IBACK
 320      EL(I) = EL(I)*XIOLD + EL(I-1)
        XIOLD = XI
 330    CONTINUE
 340  CONTINUE
      T1 = (-ALPH0 - ALPH1)/PROD
C Load column L + 1 in YH array. ---------------------------------------
      LP1 = L + 1
      DO 350 I = 1, N

 350    YH(I,LP1) = T1*YH(I,LMAX)
C Add correction terms to YH array. ------------------------------------
      NQP1 = NQ + 1
      DO 370 J = 3, NQP1
        CALL DAXPY (N, EL(J), YH(1,LP1), 1, YH(1,J), 1 )
 370  CONTINUE
      RETURN
C----------------------- End of Subroutine DVJUST ----------------------
      END
*DECK DVNLSD
      SUBROUTINE DVNLSD (Y, YH, LDYH, VSAV, SAVF, EWT, ACOR, IWM, WM,
     1                 F, JAC, PDUM, NFLAG, RPAR, IPAR)

      EXTERNAL F, JAC, PDUM
      DOUBLE PRECISION Y, YH, VSAV, SAVF, EWT, ACOR, WM, RPAR
      INTEGER LDYH, IWM, NFLAG, IPAR
      DIMENSION Y(*), YH(LDYH,*), VSAV(*), SAVF(*), EWT(*), ACOR(*),
     1          IWM(*), WM(*)
C-----------------------------------------------------------------------

C Call sequence input -- Y, YH, LDYH, SAVF, EWT, ACOR, IWM, WM,
C                        F, JAC, NFLAG, RPAR, IPAR
C Call sequence output -- YH, ACOR, WM, IWM, NFLAG
C COMMON block variables accessed..
C     /DVOD01/ ACNRM, CRATE, DRC, H, RC, RL1, TQ(5), TN, ICF,

C                JCUR, METH, MITER, N, NSLP
C     /DVOD02/ HU, NCFN, NETF, NFE, NJE, NLU, NNI, NQU, NST
C
C Subroutines called by DVNLSD.. F, DAXPY, DCOPY, DSCAL, DVJAC, DVSOL
C Function routines called by DVNLSD.. DVNORM

C-----------------------------------------------------------------------
C Subroutine DVNLSD is a nonlinear system solver, which uses functional
C iteration or a chord (modified Newton) method.  For the chord method
C direct linear algebraic system solvers are used.  Subroutine DVNLSD
C then handles the corrector phase of this integration package.
C
C Communication with DVNLSD is done with the following variables. (For
C more details, please see the comments in the driver subroutine.)
C
C Y          = The dependent variable, a vector of length N, input.
C YH         = The Nordsieck (Taylor) array, LDYH by LMAX, input
C              and output.  On input, it contains predicted values.
C LDYH       = A constant .ge. N, the first dimension of YH, input.

C VSAV       = Unused work array.
C SAVF       = A work array of length N.
C EWT        = An error weight vector of length N, input.
C ACOR       = A work array of length N, used for the accumulated
C              corrections to the predicted y vector.
C WM,IWM     = Real and integer work arrays associated with matrix
C              operations in chord iteration (MITER .ne. 0).
C F          = Dummy name for user supplied routine for f.
C JAC        = Dummy name for user supplied Jacobian routine.
C PDUM       = Unused dummy subroutine name.  Included for uniformity
C              over collection of integrators.
C NFLAG      = Input/output flag, with values and meanings as follows..
C              INPUT
C                  0 first call for this time step.
C                 -1 convergence failure in previous call to DVNLSD.
C                 -2 error test failure in DVSTEP.
C              OUTPUT
C                  0 successful completion of nonlinear solver.
C                 -1 convergence failure or singular matrix.
C                 -2 unrecoverable error in matrix preprocessing

C                    (cannot occur here).
C                 -3 unrecoverable error in solution (cannot occur
C                    here).
C RPAR, IPAR = Dummy names for user's real and integer work arrays.
C
C IPUP       = Own variable flag with values and meanings as follows..
C              0,            do not update the Newton matrix.
C              MITER .ne. 0, update Newton matrix, because it is the
C                            initial step, order was changed, the error
C                            test failed, or an update is indicated by
C                            the scalar RC or step counter NST.
C
C For more details, see comments in driver subroutine.
C-----------------------------------------------------------------------
C Type declarations for labeled COMMON block DVOD01 --------------------
C
      DOUBLE PRECISION ACNRM, CCMXJ, CONP, CRATE, DRC, EL,
     1     ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2     RC, RL1, TAU, TQ, TN, UROUND

      INTEGER ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,
     1        L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,
     2        LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,
     3        N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,

     4        NSLP, NYH
C

C Type declarations for labeled COMMON block DVOD02 --------------------
C
      DOUBLE PRECISION HU
      INTEGER NCFN, NETF, NFE, NJE, NLU, NNI, NQU, NST

C
C Type declarations for local variables --------------------------------

C
      DOUBLE PRECISION CCMAX, CRDOWN, CSCALE, DCON, DEL, DELP, ONE,
     1     RDIV, TWO, ZERO
      INTEGER I, IERPJ, IERSL, M, MAXCOR, MSBP

C
C Type declaration for function subroutines called ---------------------
C
      DOUBLE PRECISION DVNORM
C-----------------------------------------------------------------------
C The following Fortran-77 declaration is to cause the values of the
C listed (local) variables to be saved between calls to this integrator.
C-----------------------------------------------------------------------
      SAVE CCMAX, CRDOWN, MAXCOR, MSBP, RDIV, ONE, TWO, ZERO
C
      COMMON /DVOD01/ ACNRM, CCMXJ, CONP, CRATE, DRC, EL(13),
     1                ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2                RC, RL1, TAU(13), TQ(5), TN, UROUND,
     3                ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,
     4                L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,
     5                LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,

     6                N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,
     7                NSLP, NYH
      COMMON /DVOD02/ HU, NCFN, NETF, NFE, NJE, NLU, NNI, NQU, NST

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$omp Threadprivate(/DVOD01/,/DVOD02/,CCMAX,CRDOWN,MAXCOR,MSBP,RDIV,
!$omp&ONE,TWO,ZERO)


      DATA CCMAX /0.3D0/, CRDOWN /0.3D0/, MAXCOR /3/, MSBP /20/,
     1     RDIV  /2.0D0/

      DATA ONE /1.0D0/, TWO /2.0D0/, ZERO /0.0D0/
C-----------------------------------------------------------------------
C On the first step, on a change of method order, or after a
C nonlinear convergence failure with NFLAG = -2, set IPUP = MITER
C to force a Jacobian update when MITER .ne. 0.
C-----------------------------------------------------------------------
      IF (JSTART .EQ. 0) NSLP = 0
      IF (NFLAG .EQ. 0) ICF = 0
      IF (NFLAG .EQ. -2) IPUP = MITER
      IF ( (JSTART .EQ. 0) .OR. (JSTART .EQ. -1) ) IPUP = MITER
C If this is functional iteration, set CRATE .eq. 1 and drop to 220
      IF (MITER .EQ. 0) THEN
        CRATE = ONE
        GO TO 220
      ENDIF
C-----------------------------------------------------------------------
C RC is the ratio of new to old values of the coefficient H/EL(2)=h/l1.
C When RC differs from 1 by more than CCMAX, IPUP is set to MITER
C to force DVJAC to be called, if a Jacobian is involved.
C In any case, DVJAC is called at least every MSBP steps.
C-----------------------------------------------------------------------
      DRC = ABS(RC-ONE)
      IF (DRC .GT. CCMAX .OR. NST .GE. NSLP+MSBP) IPUP = MITER

C-----------------------------------------------------------------------

C Up to MAXCOR corrector iterations are taken.  A convergence test is
C made on the r.m.s. norm of each correction, weighted by the error
C weight vector EWT.  The sum of the corrections is accumulated in the
C vector ACOR(i).  The YH array is not altered in the corrector loop.
C-----------------------------------------------------------------------
 220  M = 0
      DELP = ZERO
      CALL DCOPY (N, YH(1,1), 1, Y, 1 )
      CALL F (N, TN, Y, SAVF, RPAR, IPAR)
      NFE = NFE + 1
      IF (IPUP .LE. 0) GO TO 250
C-----------------------------------------------------------------------
C If indicated, the matrix P = I - h*rl1*J is reevaluated and
C preprocessed before starting the corrector iteration.  IPUP is set
C to 0 as an indicator that this has been done.
C-----------------------------------------------------------------------
      CALL DVJAC (Y, YH, LDYH, EWT, ACOR, SAVF, WM, IWM, F, JAC, IERPJ,
     1           RPAR, IPAR)
      IPUP = 0
      RC = ONE
      DRC = ZERO
      CRATE = ONE
      NSLP = NST
C If matrix is singular, take error return to force cut in step size. --
      IF (IERPJ .NE. 0) GO TO 430
 250  DO 260 I = 1,N
 260    ACOR(I) = ZERO

C This is a looping point for the corrector iteration. -----------------
 270  IF (MITER .NE. 0) GO TO 350
C-----------------------------------------------------------------------
C In the case of functional iteration, update Y directly from

C the result of the last function evaluation.
C-----------------------------------------------------------------------
      DO 280 I = 1,N
 280    SAVF(I) = RL1*(H*SAVF(I) - YH(I,2))

      DO 290 I = 1,N
 290    Y(I) = SAVF(I) - ACOR(I)
      DEL = DVNORM (N, Y, EWT)
      DO 300 I = 1,N
 300    Y(I) = YH(I,1) + SAVF(I)
      CALL DCOPY (N, SAVF, 1, ACOR, 1)
      GO TO 400
C-----------------------------------------------------------------------
C In the case of the chord method, compute the corrector error,


C and solve the linear system with that as right-hand side and
C P as coefficient matrix.  The correction is scaled by the factor
C 2/(1+RC) to account for changes in h*rl1 since the last DVJAC call.
C-----------------------------------------------------------------------
 350  DO 360 I = 1,N
 360    Y(I) = (RL1*H)*SAVF(I) - (RL1*YH(I,2) + ACOR(I))
      CALL DVSOL (WM, IWM, Y, IERSL)
      NNI = NNI + 1
      IF (IERSL .GT. 0) GO TO 410
      IF (METH .EQ. 2 .AND. RC .NE. ONE) THEN
        CSCALE = TWO/(ONE + RC)
        CALL DSCAL (N, CSCALE, Y, 1)

      ENDIF
      DEL = DVNORM (N, Y, EWT)
      CALL DAXPY (N, ONE, Y, 1, ACOR, 1)
      DO 380 I = 1,N
 380    Y(I) = YH(I,1) + ACOR(I)
C-----------------------------------------------------------------------
C Test for convergence.  If M .gt. 0, an estimate of the convergence
C rate constant is stored in CRATE, and this is used in the test.
C-----------------------------------------------------------------------
 400  IF (M .NE. 0) CRATE = MAX(CRDOWN*CRATE,DEL/DELP)
      DCON = DEL*MIN(ONE,CRATE)/TQ(4)
      IF (DCON .LE. ONE) GO TO 450
      M = M + 1
      IF (M .EQ. MAXCOR) GO TO 410
      IF (M .GE. 2 .AND. DEL .GT. RDIV*DELP) GO TO 410
      DELP = DEL
      CALL F (N, TN, Y, SAVF, RPAR, IPAR)
      NFE = NFE + 1
      GO TO 270

C



 410  IF (MITER .EQ. 0 .OR. JCUR .EQ. 1) GO TO 430
      ICF = 1
      IPUP = MITER

      GO TO 220
C
 430  CONTINUE
      NFLAG = -1
      ICF = 2
      IPUP = MITER
      RETURN

C
C Return for successful step. ------------------------------------------
 450  NFLAG = 0
      JCUR = 0
      ICF = 0
      IF (M .EQ. 0) ACNRM = DEL
      IF (M .GT. 0) ACNRM = DVNORM (N, ACOR, EWT)
      RETURN
C----------------------- End of Subroutine DVNLSD ----------------------
      END
*DECK DVJAC
      SUBROUTINE DVJAC (Y, YH, LDYH, EWT, FTEM, SAVF, WM, IWM, F, JAC,
     1                 IERPJ, RPAR, IPAR)
      EXTERNAL F, JAC
      DOUBLE PRECISION Y, YH, EWT, FTEM, SAVF, WM, RPAR
      INTEGER LDYH, IWM, IERPJ, IPAR
      DIMENSION Y(*), YH(LDYH,*), EWT(*), FTEM(*), SAVF(*),
     1   WM(*), IWM(*)
C-----------------------------------------------------------------------
C Call sequence input -- Y, YH, LDYH, EWT, FTEM, SAVF, WM, IWM,
C                        F, JAC, RPAR, IPAR
C Call sequence output -- WM, IWM, IERPJ
C COMMON block variables accessed..
C     /DVOD01/  CCMXJ, DRC, H, RL1, TN, UROUND, ICF, JCUR, LOCJS,
C               MSBJ, NSLJ
C     /DVOD02/  NFE, NST, NJE, NLU

C
C Subroutines called by DVJAC.. F, JAC, DACOPY, DCOPY, DGBFA, DGEFA,

C                              DSCAL
C Function routines called by DVJAC.. DVNORM
C-----------------------------------------------------------------------

C DVJAC is called by DVSTEP to compute and process the matrix
C P = I - h*rl1*J , where J is an approximation to the Jacobian.
C Here J is computed by the user-supplied routine JAC if
C MITER = 1 or 4, or by finite differencing if MITER = 2, 3, or 5.
C If MITER = 3, a diagonal approximation to J is used.
C If JSV = -1, J is computed from scratch in all cases.
C If JSV = 1 and MITER = 1, 2, 4, or 5, and if the saved value of J is
C considered acceptable, then P is constructed from the saved J.
C J is stored in wm and replaced by P.  If MITER .ne. 3, P is then
C subjected to LU decomposition in preparation for later solution
C of linear systems with P as coefficient matrix. This is done
C by DGEFA if MITER = 1 or 2, and by DGBFA if MITER = 4 or 5.

C
C Communication with DVJAC is done with the following variables.  (For
C more details, please see the comments in the driver subroutine.)
C Y          = Vector containing predicted values on entry.
C YH         = The Nordsieck array, an LDYH by LMAX array, input.
C LDYH       = A constant .ge. N, the first dimension of YH, input.
C EWT        = An error weight vector of length N.
C SAVF       = Array containing f evaluated at predicted y, input.
C WM         = Real work space for matrices.  In the output, it containS
C              the inverse diagonal matrix if MITER = 3 and the LU
C              decomposition of P if MITER is 1, 2 , 4, or 5.
C              Storage of matrix elements starts at WM(3).
C              Storage of the saved Jacobian starts at WM(LOCJS).
C              WM also contains the following matrix-related data..
C              WM(1) = SQRT(UROUND), used in numerical Jacobian step.
C              WM(2) = H*RL1, saved for later use if MITER = 3.
C IWM        = Integer work space containing pivot information,
C              starting at IWM(31), if MITER is 1, 2, 4, or 5.

C              IWM also contains band parameters ML = IWM(1) and
C              MU = IWM(2) if MITER is 4 or 5.
C F          = Dummy name for the user supplied subroutine for f.
C JAC        = Dummy name for the user supplied Jacobian subroutine.
C RPAR, IPAR = Dummy names for user's real and integer work arrays.
C RL1        = 1/EL(2) (input).
C IERPJ      = Output error flag,  = 0 if no trouble, 1 if the P
C              matrix is found to be singular.
C JCUR       = Output flag to indicate whether the Jacobian matrix
C              (or approximation) is now current.
C              JCUR = 0 means J is not current.

C              JCUR = 1 means J is current.
C-----------------------------------------------------------------------

C
C Type declarations for labeled COMMON block DVOD01 --------------------

C
      DOUBLE PRECISION ACNRM, CCMXJ, CONP, CRATE, DRC, EL,
     1     ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2     RC, RL1, TAU, TQ, TN, UROUND
      INTEGER ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,
     1        L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,
     2        LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,
     3        N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,
     4        NSLP, NYH
C
C Type declarations for labeled COMMON block DVOD02 --------------------
C
      DOUBLE PRECISION HU
      INTEGER NCFN, NETF, NFE, NJE, NLU, NNI, NQU, NST

C
C Type declarations for local variables --------------------------------
C
      DOUBLE PRECISION CON, DI, FAC, HRL1, ONE, PT1, R, R0, SRUR, THOU,
     1     YI, YJ, YJJ, ZERO
      INTEGER I, I1, I2, IER, II, J, J1, JJ, JOK, LENP, MBA, MBAND,
     1        MEB1, MEBAND, ML, ML3, MU, NP1
C
C Type declaration for function subroutines called ---------------------
C
      DOUBLE PRECISION DVNORM
C-----------------------------------------------------------------------
C The following Fortran-77 declaration is to cause the values of the

C listed (local) variables to be saved between calls to this subroutine.
C-----------------------------------------------------------------------
      SAVE ONE, PT1, THOU, ZERO

C-----------------------------------------------------------------------
      COMMON /DVOD01/ ACNRM, CCMXJ, CONP, CRATE, DRC, EL(13),
     1                ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2                RC, RL1, TAU(13), TQ(5), TN, UROUND,
     3                ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,
     4                L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,
     5                LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,
     6                N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,
     7                NSLP, NYH
      COMMON /DVOD02/ HU, NCFN, NETF, NFE, NJE, NLU, NNI, NQU, NST
C
      DATA ONE /1.0D0/, THOU /1000.0D0/, ZERO /0.0D0/, PT1 /0.1D0/

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$omp Threadprivate(/DVOD01/,/DVOD02/,One,PT1,THOU,Zero)

      IERPJ = 0
      HRL1 = H*RL1
C See whether J should be evaluated (JOK = -1) or not (JOK = 1). -------
      JOK = JSV
      IF (JSV .EQ. 1) THEN
        IF (NST .EQ. 0 .OR. NST .GT. NSLJ+MSBJ) JOK = -1

        IF (ICF .EQ. 1 .AND. DRC .LT. CCMXJ) JOK = -1
        IF (ICF .EQ. 2) JOK = -1
      ENDIF
C End of setting JOK. --------------------------------------------------
C
      IF (JOK .EQ. -1 .AND. MITER .EQ. 1) THEN
C If JOK = -1 and MITER = 1, call JAC to evaluate Jacobian. ------------
      NJE = NJE + 1
      NSLJ = NST
      JCUR = 1
      LENP = N*N
      DO 110 I = 1,LENP
 110    WM(I+2) = ZERO
      CALL JAC (N, TN, Y, 0, 0, WM(3), N, RPAR, IPAR)
      IF (JSV .EQ. 1) CALL DCOPY (LENP, WM(3), 1, WM(LOCJS), 1)

      ENDIF
C
      IF (JOK .EQ. -1 .AND. MITER .EQ. 2) THEN
C If MITER = 2, make N calls to F to approximate the Jacobian. ---------
      NJE = NJE + 1
      NSLJ = NST
      JCUR = 1
      FAC = DVNORM (N, SAVF, EWT)
      R0 = THOU*ABS(H)*UROUND*REAL(N)*FAC
      IF (R0 .EQ. ZERO) R0 = ONE
      SRUR = WM(1)
      J1 = 2
      DO 230 J = 1,N

        YJ = Y(J)
        R = MAX(SRUR*ABS(YJ),R0/EWT(J))
        Y(J) = Y(J) + R
        FAC = ONE/R
        CALL F (N, TN, Y, FTEM, RPAR, IPAR)
        DO 220 I = 1,N
 220      WM(I+J1) = (FTEM(I) - SAVF(I))*FAC
        Y(J) = YJ
        J1 = J1 + N

 230    CONTINUE
      NFE = NFE + N

      LENP = N*N
      IF (JSV .EQ. 1) CALL DCOPY (LENP, WM(3), 1, WM(LOCJS), 1)
      ENDIF
C
      IF (JOK .EQ. 1 .AND. (MITER .EQ. 1 .OR. MITER .EQ. 2)) THEN
      JCUR = 0
      LENP = N*N
      CALL DCOPY (LENP, WM(LOCJS), 1, WM(3), 1)
      ENDIF
C
      IF (MITER .EQ. 1 .OR. MITER .EQ. 2) THEN
C Multiply Jacobian by scalar, add identity, and do LU decomposition. --
      CON = -HRL1
      CALL DSCAL (LENP, CON, WM(3), 1)
      J = 3
      NP1 = N + 1
      DO 250 I = 1,N
        WM(J) = WM(J) + ONE
 250    J = J + NP1
      NLU = NLU + 1
      CALL DGEFA (WM(3), N, N, IWM(31), IER)

      IF (IER .NE. 0) IERPJ = 1
      RETURN
      ENDIF
C End of code block for MITER = 1 or 2. --------------------------------
C
      IF (MITER .EQ. 3) THEN
C If MITER = 3, construct a diagonal approximation to J and P. ---------
      NJE = NJE + 1
      JCUR = 1
      WM(2) = HRL1
      R = RL1*PT1
      DO 310 I = 1,N
 310    Y(I) = Y(I) + R*(H*SAVF(I) - YH(I,2))
      CALL F (N, TN, Y, WM(3), RPAR, IPAR)
      NFE = NFE + 1
      DO 320 I = 1,N

        R0 = H*SAVF(I) - YH(I,2)
        DI = PT1*R0 - H*(WM(I+2) - SAVF(I))
        WM(I+2) = ONE
        IF (ABS(R0) .LT. UROUND/EWT(I)) GO TO 320
        IF (ABS(DI) .EQ. ZERO) GO TO 330
        WM(I+2) = PT1*R0/DI
 320    CONTINUE
      RETURN

 330  IERPJ = 1
      RETURN
      ENDIF
C End of code block for MITER = 3. -------------------------------------

C
C Set constants for MITER = 4 or 5. ------------------------------------
      ML = IWM(1)
      MU = IWM(2)
      ML3 = ML + 3
      MBAND = ML + MU + 1
      MEBAND = MBAND + ML
      LENP = MEBAND*N
C
      IF (JOK .EQ. -1 .AND. MITER .EQ. 4) THEN
C If JOK = -1 and MITER = 4, call JAC to evaluate Jacobian. ------------
      NJE = NJE + 1
      NSLJ = NST
      JCUR = 1

      DO 410 I = 1,LENP
 410    WM(I+2) = ZERO
      CALL JAC (N, TN, Y, ML, MU, WM(ML3), MEBAND, RPAR, IPAR)
      IF (JSV .EQ. 1)
     1   CALL DACOPY (MBAND, N, WM(ML3), MEBAND, WM(LOCJS), MBAND)
      ENDIF
C

      IF (JOK .EQ. -1 .AND. MITER .EQ. 5) THEN
C If MITER = 5, make N calls to F to approximate the Jacobian. ---------
      NJE = NJE + 1
      NSLJ = NST
      JCUR = 1
      MBA = MIN(MBAND,N)
      MEB1 = MEBAND - 1
      SRUR = WM(1)
      FAC = DVNORM (N, SAVF, EWT)
      R0 = THOU*ABS(H)*UROUND*REAL(N)*FAC
      IF (R0 .EQ. ZERO) R0 = ONE
      DO 560 J = 1,MBA
        DO 530 I = J,N,MBAND
          YI = Y(I)
          R = MAX(SRUR*ABS(YI),R0/EWT(I))

 530      Y(I) = Y(I) + R
        CALL F (N, TN, Y, FTEM, RPAR, IPAR)
        DO 550 JJ = J,N,MBAND
          Y(JJ) = YH(JJ,1)
          YJJ = Y(JJ)
          R = MAX(SRUR*ABS(YJJ),R0/EWT(JJ))
          FAC = ONE/R
          I1 = MAX(JJ-MU,1)
          I2 = MIN(JJ+ML,N)
          II = JJ*MEB1 - ML + 2
          DO 540 I = I1,I2
 540        WM(II+I) = (FTEM(I) - SAVF(I))*FAC
 550      CONTINUE
 560    CONTINUE
      NFE = NFE + MBA
      IF (JSV .EQ. 1)
     1   CALL DACOPY (MBAND, N, WM(ML3), MEBAND, WM(LOCJS), MBAND)
      ENDIF
C
      IF (JOK .EQ. 1) THEN
      JCUR = 0
      CALL DACOPY (MBAND, N, WM(LOCJS), MBAND, WM(ML3), MEBAND)
      ENDIF
C
C Multiply Jacobian by scalar, add identity, and do LU decomposition.
      CON = -HRL1

      CALL DSCAL (LENP, CON, WM(3), 1 )
      II = MBAND + 2
      DO 580 I = 1,N
        WM(II) = WM(II) + ONE
 580    II = II + MEBAND
      NLU = NLU + 1
      CALL DGBFA (WM(3), MEBAND, N, ML, MU, IWM(31), IER)
      IF (IER .NE. 0) IERPJ = 1
      RETURN
C End of code block for MITER = 4 or 5. --------------------------------
C
C----------------------- End of Subroutine DVJAC -----------------------
      END


*DECK DACOPY
      SUBROUTINE DACOPY (NROW, NCOL, A, NROWA, B, NROWB)
      DOUBLE PRECISION A, B
      INTEGER NROW, NCOL, NROWA, NROWB
      DIMENSION A(NROWA,NCOL), B(NROWB,NCOL)
C-----------------------------------------------------------------------
C Call sequence input -- NROW, NCOL, A, NROWA, NROWB
C Call sequence output -- B
C COMMON block variables accessed -- None
C
C Subroutines called by DACOPY.. DCOPY
C Function routines called by DACOPY.. None
C-----------------------------------------------------------------------

C This routine copies one rectangular array, A, to another, B,
C where A and B may have different row dimensions, NROWA and NROWB.
C The data copied consists of NROW rows and NCOL columns.
C-----------------------------------------------------------------------
      INTEGER IC
C

      DO 20 IC = 1,NCOL
        CALL DCOPY (NROW, A(1,IC), 1, B(1,IC), 1)
 20     CONTINUE
C
      RETURN
C----------------------- End of Subroutine DACOPY ----------------------
      END
*DECK DVSOL
      SUBROUTINE DVSOL (WM, IWM, X, IERSL)
      DOUBLE PRECISION WM, X
      INTEGER IWM, IERSL
      DIMENSION WM(*), IWM(*), X(*)
C-----------------------------------------------------------------------
C Call sequence input -- WM, IWM, X
C Call sequence output -- X, IERSL
C COMMON block variables accessed..
C     /DVOD01/ -- H, RL1, MITER, N
C
C Subroutines called by DVSOL.. DGESL, DGBSL
C Function routines called by DVSOL.. None
C-----------------------------------------------------------------------
C This routine manages the solution of the linear system arising from
C a chord iteration.  It is called if MITER .ne. 0.
C If MITER is 1 or 2, it calls DGESL to accomplish this.
C If MITER = 3 it updates the coefficient H*RL1 in the diagonal
C matrix, and then computes the solution.
C If MITER is 4 or 5, it calls DGBSL.
C Communication with DVSOL uses the following variables..
C WM    = Real work space containing the inverse diagonal matrix if
C         MITER = 3 and the LU decomposition of the matrix otherwise.
C         Storage of matrix elements starts at WM(3).
C         WM also contains the following matrix-related data..
C         WM(1) = SQRT(UROUND) (not used here),
C         WM(2) = HRL1, the previous value of H*RL1, used if MITER = 3.

C IWM   = Integer work space containing pivot information, starting at
C         IWM(31), if MITER is 1, 2, 4, or 5.  IWM also contains band
C         parameters ML = IWM(1) and MU = IWM(2) if MITER is 4 or 5.
C X     = The right-hand side vector on input, and the solution vector
C         on output, of length N.
C IERSL = Output flag.  IERSL = 0 if no trouble occurred.
C         IERSL = 1 if a singular matrix arose with MITER = 3.
C-----------------------------------------------------------------------
C
C Type declarations for labeled COMMON block DVOD01 --------------------
C
      DOUBLE PRECISION ACNRM, CCMXJ, CONP, CRATE, DRC, EL,
     1     ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2     RC, RL1, TAU, TQ, TN, UROUND
      INTEGER ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,
     1        L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,
     2        LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,
     3        N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,
     4        NSLP, NYH
C
C Type declarations for local variables --------------------------------
C
      INTEGER I, MEBAND, ML, MU
      DOUBLE PRECISION DI, HRL1, ONE, PHRL1, R, ZERO
C-----------------------------------------------------------------------
C The following Fortran-77 declaration is to cause the values of the
C listed (local) variables to be saved between calls to this integrator.
C-----------------------------------------------------------------------
      SAVE ONE, ZERO
C
      COMMON /DVOD01/ ACNRM, CCMXJ, CONP, CRATE, DRC, EL(13),
     1                ETA, ETAMAX, H, HMIN, HMXI, HNEW, HSCAL, PRL1,
     2                RC, RL1, TAU(13), TQ(5), TN, UROUND,
     3                ICF, INIT, IPUP, JCUR, JSTART, JSV, KFLAG, KUTH,
     4                L, LMAX, LYH, LEWT, LACOR, LSAVF, LWM, LIWM,
     5                LOCJS, MAXORD, METH, MITER, MSBJ, MXHNIL, MXSTEP,
     6                N, NEWH, NEWQ, NHNIL, NQ, NQNYH, NQWAIT, NSLJ,
     7                NSLP, NYH

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$omp Threadprivate(/DVOD01/,One,Zero)

      DATA ONE /1.0D0/, ZERO /0.0D0/
C

      IERSL = 0

      GO TO (100, 100, 300, 400, 400), MITER
 100  CALL DGESL (WM(3), N, N, IWM(31), X, 0)
      RETURN
C
 300  PHRL1 = WM(2)
      HRL1 = H*RL1

      WM(2) = HRL1
      IF (HRL1 .EQ. PHRL1) GO TO 330
      R = HRL1/PHRL1
      DO 320 I = 1,N
        DI = ONE - R*(ONE - ONE/WM(I+2))
        IF (ABS(DI) .EQ. ZERO) GO TO 390
 320    WM(I+2) = ONE/DI
C
 330  DO 340 I = 1,N
 340    X(I) = WM(I+2)*X(I)
      RETURN

 390  IERSL = 1
      RETURN
C
 400  ML = IWM(1)
      MU = IWM(2)
      MEBAND = 2*ML + MU + 1
      CALL DGBSL (WM(3), MEBAND, N, ML, MU, IWM(31), X, 0)
      RETURN
C----------------------- End of Subroutine DVSOL -----------------------
      END
*DECK DVSRCO

      SUBROUTINE DVSRCO (RSAV, ISAV, JOB)
      DOUBLE PRECISION RSAV
      INTEGER ISAV, JOB
      DIMENSION RSAV(*), ISAV(*)
C-----------------------------------------------------------------------
C Call sequence input -- RSAV, ISAV, JOB
C Call sequence output -- RSAV, ISAV
C COMMON block variables accessed -- All of /DVOD01/ and /DVOD02/
C
C Subroutines/functions called by DVSRCO.. None
C-----------------------------------------------------------------------
C This routine saves or restores (depending on JOB) the contents of the
C COMMON blocks DVOD01 and DVOD02, which are used internally by DVODE.
C
C RSAV = real array of length 49 or more.
C ISAV = integer array of length 41 or more.

C JOB  = flag indicating to save or restore the COMMON blocks..
C        JOB  = 1 if COMMON is to be saved (written to RSAV/ISAV).
C        JOB  = 2 if COMMON is to be restored (read from RSAV/ISAV).
C        A call with JOB = 2 presumes a prior call with JOB = 1.
C-----------------------------------------------------------------------
      DOUBLE PRECISION RVOD1, RVOD2
      INTEGER IVOD1, IVOD2
      INTEGER I, LENIV1, LENIV2, LENRV1, LENRV2
C-----------------------------------------------------------------------
C The following Fortran-77 declaration is to cause the values of the
C listed (local) variables to be saved between calls to this integrator.
C-----------------------------------------------------------------------
      SAVE LENRV1, LENIV1, LENRV2, LENIV2
C
      COMMON /DVOD01/ RVOD1(48), IVOD1(33)
      COMMON /DVOD02/ RVOD2(1), IVOD2(8)

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$omp THreadprivate(/DVOD01/,/DVOD02/,LENRV1,LENIV1,LENRV2,LENIV2)

      DATA LENRV1/48/, LENIV1/33/, LENRV2/1/, LENIV2/8/
C
      IF (JOB .EQ. 2) GO TO 100
      DO 10 I = 1,LENRV1
 10     RSAV(I) = RVOD1(I)
      DO 15 I = 1,LENRV2

 15     RSAV(LENRV1+I) = RVOD2(I)
C
      DO 20 I = 1,LENIV1
 20     ISAV(I) = IVOD1(I)
      DO 25 I = 1,LENIV2
 25     ISAV(LENIV1+I) = IVOD2(I)
C
      RETURN
C
 100  CONTINUE
      DO 110 I = 1,LENRV1
 110     RVOD1(I) = RSAV(I)
      DO 115 I = 1,LENRV2
 115     RVOD2(I) = RSAV(LENRV1+I)
C
      DO 120 I = 1,LENIV1
 120     IVOD1(I) = ISAV(I)
      DO 125 I = 1,LENIV2
 125     IVOD2(I) = ISAV(LENIV1+I)
C
      RETURN
C----------------------- End of Subroutine DVSRCO ----------------------
      END
*DECK DEWSET
      SUBROUTINE DEWSET (N, ITOL, RTOL, ATOL, YCUR, EWT)
      DOUBLE PRECISION RTOL, ATOL, YCUR, EWT
      INTEGER N, ITOL
      DIMENSION ATOL(*), YCUR(N), EWT(N)
C-----------------------------------------------------------------------
C Call sequence input -- N, ITOL, RTOL, ATOL, YCUR
C Call sequence output -- EWT
C COMMON block variables accessed -- None
C
C Subroutines/functions called by DEWSET.. None
C-----------------------------------------------------------------------
C This subroutine sets the error weight vector EWT according to
C     EWT(i) = RTOL(i)*abs(YCUR(i)) + ATOL(i),  i = 1,...,N,
C with the subscript on RTOL and/or ATOL possibly replaced by 1 above,
C depending on the value of ITOL.

C-----------------------------------------------------------------------
      INTEGER I
C
      GO TO (10, 20, 30, 40), ITOL
 10   CONTINUE
      DO 15 I = 1, N
 15     EWT(I) = RTOL*ABS(YCUR(I)) + ATOL(1)
      RETURN
 20   CONTINUE
      DO 25 I = 1, N
 25     EWT(I) = RTOL*ABS(YCUR(I)) + ATOL(I)
      RETURN
 30   CONTINUE

      DO 35 I = 1, N

 35     EWT(I) = RTOL*ABS(YCUR(I)) + ATOL(1)
      RETURN
 40   CONTINUE
      DO 45 I = 1, N
 45     EWT(I) = RTOL*ABS(YCUR(I)) + ATOL(I)

      RETURN
C----------------------- End of Subroutine DEWSET ----------------------

      END
*DECK DVNORM
      DOUBLE PRECISION FUNCTION DVNORM (N, V, W)
      DOUBLE PRECISION V, W
      INTEGER N
      DIMENSION V(N), W(N)
C-----------------------------------------------------------------------

C Call sequence input -- N, V, W
C Call sequence output -- None
C COMMON block variables accessed -- None
C
C Subroutines/functions called by DVNORM.. None
C-----------------------------------------------------------------------
C This function routine computes the weighted root-mean-square norm
C of the vector of length N contained in the array V, with weights
C contained in the array W of length N..
C   DVNORM = sqrt( (1/N) * sum( V(i)*W(i) )**2 )
C-----------------------------------------------------------------------
      DOUBLE PRECISION SUM
      INTEGER I
C
      SUM = 0.0D0
      DO 10 I = 1, N
 10     SUM = SUM + (V(I)*W(I))**2
      DVNORM = SQRT(SUM/REAL(N))
      RETURN
C----------------------- End of Function DVNORM ------------------------
      END
*DECK D1MACH
      DOUBLE PRECISION FUNCTION D1MACH (IDUM)
      INTEGER IDUM
C-----------------------------------------------------------------------

C This routine computes the unit roundoff of the machine.
C This is defined as the smallest positive machine number
C u such that  1.0 + u .ne. 1.0
C
C Subroutines/functions called by D1MACH.. None
C-----------------------------------------------------------------------
      DOUBLE PRECISION U, COMP
      U = 1.0D0
 10   U = U*0.5D0
      COMP = 1.0D0 + U
      IF (COMP .NE. 1.0D0) GO TO 10
      D1MACH = U*2.0D0
      RETURN
C----------------------- End of Function D1MACH ------------------------
      END
*DECK XERRWD
      SUBROUTINE XERRWD (MSG, NMES, NERR, LEVEL, NI, I1, I2, NR, R1, R2)
      DOUBLE PRECISION R1, R2
      INTEGER NMES, NERR, LEVEL, NI, I1, I2, NR
      CHARACTER*1 MSG(NMES),ERRFIL*20
      COMMON/ERR/ERRFIL 

	COMMON/NXER/NXE
C  NXE (NO. OF CALLS TO THIS ROUTINE) IS PASSED BACK TO MAIN FOR
C  WRITING TO THE SCREEN.

C-----------------------------------------------------------------------
C Subroutines XERRWD, XSETF, XSETUN, and the two function routines
C MFLGSV and LUNSAV, as given here, constitute a simplified version of
C the SLATEC error handling package.

C Written by A. C. Hindmarsh and P. N. Brown at LLNL.

C Version of 13 April, 1989.
C This version is in double precision.
C

C All arguments are input arguments.
C
C MSG    = The message (character array).
C NMES   = The length of MSG (number of characters).
C NERR   = The error number (not used).
C LEVEL  = The error level..
C          0 or 1 means recoverable (control returns to caller).

C          2 means fatal (run is aborted--see note below).
C NI     = Number of integers (0, 1, or 2) to be printed with message.
C I1,I2  = Integers to be printed, depending on NI.
C NR     = Number of reals (0, 1, or 2) to be printed with message.
C R1,R2  = Reals to be printed, depending on NR.
C

C Note..  this routine is machine-dependent and specialized for use

C in limited context, in the following ways..
C 1. The argument MSG is assumed to be of type CHARACTER, and
C    the message is printed with a format of (1X,80A1).
C 2. The message is assumed to take only one line.
C    Multi-line messages are generated by repeated calls.
C 3. If LEVEL = 2, control passes to the statement   STOP
C    to abort the run.  This statement may be machine-dependent.
C 4. R1 and R2 are assumed to be in double precision and are printed
C    in D21.13 format.
C
C For a different default logical unit number, change the data

C statement in function routine LUNSAV.
C For a different run-abort command, change the statement following
C statement 100 at the end.
C-----------------------------------------------------------------------
C Subroutines called by XERRWD.. None
C Function routines called by XERRWD.. MFLGSV, LUNSAV
C-----------------------------------------------------------------------
C
      INTEGER I, LUNIT, LUNSAV, MESFLG, MFLGSV

C  SKIP ALL ERROR MESSAGES, SIMPLY GO TO LABEL 100. BUT KEEP A RUNNING
C  TOTAL OF CALLS TO THIS ROUTINE, NXE, AND RETURN IT TO MAIN FOR
C  OUTPUT.

	NXE = NXE + 1
	GO TO 100


C Get message print flag and logical unit number. ----------------------

      MESFLG = MFLGSV (0,.FALSE.)
      LUNIT = LUNSAV (0,.FALSE.)

      IF (MESFLG .EQ. 0) GO TO 100
C Write the message. ---------------------------------------------------
      WRITE (LUNIT,10) (MSG(I),I=1,NMES)
 10   FORMAT(1X,80A1)
      IF (NI .EQ. 1) WRITE (LUNIT, 20) I1
 20   FORMAT(6X,'In above message,  I1 =',I10)
      IF (NI .EQ. 2) WRITE (LUNIT, 30) I1,I2
 30   FORMAT(6X,'In above message,  I1 =',I10,3X,'I2 =',I10)
      IF (NR .EQ. 1) WRITE (LUNIT, 40) R1
 40   FORMAT(6X,'In above message,  R1 =',D21.13)
      IF (NR .EQ. 2) WRITE (LUNIT, 50) R1,R2
 50   FORMAT(6X,'In above,  R1 =',D21.13,3X,'R2 =',D21.13)
C Abort the run if LEVEL = 2. ------------------------------------------
 100  IF (LEVEL .NE. 2) RETURN

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,51)
   51    FORMAT(/' LEVEL 2 (FATAL) IN SUBROUTINE XERRWD. '/)
        CLOSE(42)

      CALL PAUSE
      STOP
C----------------------- End of Subroutine XERRWD ----------------------
      END
*DECK XSETF
      SUBROUTINE XSETF (MFLAG)
C-----------------------------------------------------------------------
C This routine resets the print control flag MFLAG.
C
C Subroutines called by XSETF.. None
C Function routines called by XSETF.. MFLGSV
C-----------------------------------------------------------------------
      INTEGER MFLAG, JUNK, MFLGSV
C
      IF (MFLAG .EQ. 0 .OR. MFLAG .EQ. 1) JUNK = MFLGSV (MFLAG,.TRUE.)
      RETURN

C----------------------- End of Subroutine XSETF -----------------------
      END
*DECK XSETUN
      SUBROUTINE XSETUN (LUN)
C-----------------------------------------------------------------------


C This routine resets the logical unit number for messages.
C
C Subroutines called by XSETUN.. None
C Function routines called by XSETUN.. LUNSAV
C-----------------------------------------------------------------------
      INTEGER LUN, JUNK, LUNSAV
C

      IF (LUN .GT. 0) JUNK = LUNSAV (LUN,.TRUE.)
      RETURN
C----------------------- End of Subroutine XSETUN ----------------------
      END
*DECK MFLGSV
      INTEGER FUNCTION MFLGSV (IVALUE, ISET)
      LOGICAL ISET
      INTEGER IVALUE
C-----------------------------------------------------------------------
C MFLGSV saves and recalls the parameter MESFLG which controls the
C printing of the error messages.
C
C Saved local variable..

C
C   MESFLG = Print control flag..
C            1 means print all messages (the default).
C            0 means no printing.
C
C On input..
C
C   IVALUE = The value to be set for the MESFLG parameter,
C            if ISET is .TRUE. .
C
C   ISET   = Logical flag to indicate whether to read or write.

C            If ISET=.TRUE., the MESFLG parameter will be given
C            the value IVALUE.  If ISET=.FALSE., the MESFLG
C            parameter will be unchanged, and IVALUE is a dummy
C            parameter.
C
C On return..
C
C   The (old) value of the MESFLG parameter will be returned
C   in the function value, MFLGSV.
C
C This is a modification of the SLATEC library routine J4SAVE.

C
C Subroutines/functions called by MFLGSV.. None
C-----------------------------------------------------------------------

      INTEGER MESFLG
C-----------------------------------------------------------------------
C The following Fortran-77 declaration is to cause the values of the
C listed (local) variables to be saved between calls to this integrator.

C-----------------------------------------------------------------------
      SAVE MESFLG

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$omp Threadprivate(Mesflg)

      DATA MESFLG/1/
C
      MFLGSV = MESFLG
      IF (ISET) MESFLG = IVALUE
      RETURN
C----------------------- End of Function MFLGSV ------------------------
      END
*DECK LUNSAV
      INTEGER FUNCTION LUNSAV (IVALUE, ISET)
      LOGICAL ISET
      INTEGER IVALUE
C-----------------------------------------------------------------------
C LUNSAV saves and recalls the parameter LUNIT which is the logical
C unit number to which error messages are printed.
C
C Saved local variable..
C
C  LUNIT   = Logical unit number for messages.
C            The default is 6 (machine-dependent).
C
C On input..
C
C   IVALUE = The value to be set for the LUNIT parameter,
C            if ISET is .TRUE. .
C
C   ISET   = Logical flag to indicate whether to read or write.
C            If ISET=.TRUE., the LUNIT parameter will be given
C            the value IVALUE.  If ISET=.FALSE., the LUNIT
C            parameter will be unchanged, and IVALUE is a dummy
C            parameter.
C

C On return..
C
C   The (old) value of the LUNIT parameter will be returned
C   in the function value, LUNSAV.
C
C This is a modification of the SLATEC library routine J4SAVE.
C
C Subroutines/functions called by LUNSAV.. None
C-----------------------------------------------------------------------
      INTEGER LUNIT
C-----------------------------------------------------------------------
C The following Fortran-77 declaration is to cause the values of the
C listed (local) variables to be saved between calls to this integrator.
C-----------------------------------------------------------------------
      SAVE LUNIT

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$omp THreadprivate(LUNIT)

      DATA LUNIT/6/
C
      LUNSAV = LUNIT
      IF (ISET) LUNIT = IVALUE
      RETURN
C----------------------- End of Function LUNSAV ------------------------
      END
 
C***********************************************************************
C***********************************************************************
 
C  VODEXT.FOR IS SIMPLY A CONCATENATION OF 9 MODULES NEEDED BY
C  VODE.FOR. THEY ARE FOUND IN  ftp.netlib.org  on the web.
 
C  In \BLAS
c	DCOPY.F  DSCAL.F  DAXPY.F  DDOT.F  IDAMAX.F
 
C  In \LINPACK
c  	DGEFA.F  DGESL.F  DGBFA.F  DGBSL.F
 
C  ALL ABOVE MODULES HAVE BEEN COPIED INTO FILES WITH EXTENSION .FOR.
 
 
C-----------------------------------------------------------------------
 
      subroutine dgefa(a,lda,n,ipvt,info)
      integer lda,n,ipvt(1),info

      double precision a(lda,1)

c
c     dgefa factors a double precision matrix by gaussian elimination.
c
c     dgefa is usually called by dgeco, but it can be called
c     directly with a saving in time if  rcond  is not needed.
c     (time for dgeco) = (1 + 9/n)*(time for dgefa) .
c
c     on entry
c
c        a       double precision(lda, n)
c                the matrix to be factored.
c
c        lda     integer
c                the leading dimension of the array  a .
c
c        n       integer
c                the order of the matrix  a .
c
c     on return

c
c        a       an upper triangular matrix and the multipliers
c                which were used to obtain it.
c                the factorization can be written  a = l*u  where
c                l  is a product of permutation and unit lower
c                triangular matrices and  u  is upper triangular.
c
c        ipvt    integer(n)
c                an integer vector of pivot indices.
c
c        info    integer
c                = 0  normal value.

c                = k  if  u(k,k) .eq. 0.0 .  this is not an error
c                     condition for this subroutine, but it does
c                     indicate that dgesl or dgedi will divide by zero
c                     if called.  use  rcond  in dgeco for a reliable
c                     indication of singularity.
c
c     linpack. this version dated 08/14/78 .
c     cleve moler, university of new mexico, argonne national lab.
c
c     subroutines and functions

c
c     blas daxpy,dscal,idamax
c


c     internal variables
c
      double precision t
      integer idamax,j,k,kp1,l,nm1
c
c
c     gaussian elimination with partial pivoting
c
      info = 0
      nm1 = n - 1
      if (nm1 .lt. 1) go to 70
      do 60 k = 1, nm1
         kp1 = k + 1
c
c        find l = pivot index
c
         l = idamax(n-k+1,a(k,k),1) + k - 1
         ipvt(k) = l
c
c        zero pivot implies this column already triangularized
c
         if (a(l,k) .eq. 0.0d0) go to 40
c
c           interchange if necessary
c
            if (l .eq. k) go to 10
               t = a(l,k)
               a(l,k) = a(k,k)

               a(k,k) = t
   10       continue
c
c           compute multipliers
c
            t = -1.0d0/a(k,k)
            call dscal(n-k,t,a(k+1,k),1)
c
c           row elimination with column indexing
c
            do 30 j = kp1, n
               t = a(l,j)
               if (l .eq. k) go to 20

                  a(l,j) = a(k,j)
                  a(k,j) = t

   20          continue
               call daxpy(n-k,t,a(k+1,k),1,a(k+1,j),1)
   30       continue
         go to 50
   40    continue
            info = k
   50    continue
   60 continue
   70 continue
      ipvt(n) = n
      if (a(n,n) .eq. 0.0d0) info = n
      return
      end
 
C-----------------------------------------------------------------------
 
      subroutine dgesl(a,lda,n,ipvt,b,job)

      integer lda,n,ipvt(1),job
      double precision a(lda,1),b(1)
c

c     dgesl solves the double precision system
c     a * x = b  or  trans(a) * x = b
c     using the factors computed by dgeco or dgefa.
c
c     on entry
c
c        a       double precision(lda, n)
c                the output from dgeco or dgefa.
c
c        lda     integer
c                the leading dimension of the array  a .
c
c        n       integer
c                the order of the matrix  a .
c
c        ipvt    integer(n)
c                the pivot vector from dgeco or dgefa.
c
c        b       double precision(n)
c                the right hand side vector.

c
c        job     integer
c                = 0         to solve  a*x = b ,
c                = nonzero   to solve  trans(a)*x = b  where
c                            trans(a)  is the transpose.
c
c     on return
c
c        b       the solution vector  x .
c
c     error condition
c
c        a division by zero will occur if the input factor contains a
c        zero on the diagonal.  technically this indicates singularity
c        but it is often caused by improper arguments or improper
c        setting of lda .  it will not occur if the subroutines are
c        called correctly and if dgeco has set rcond .gt. 0.0
c        or dgefa has set info .eq. 0 .
c
c     to compute  inverse(a) * c  where  c  is a matrix
c     with  p  columns
c           call dgeco(a,lda,n,ipvt,rcond,z)
c           if (rcond is too small) go to ...
c           do 10 j = 1, p
c              call dgesl(a,lda,n,ipvt,c(1,j),0)
c        10 continue

c
c     linpack. this version dated 08/14/78 .
c     cleve moler, university of new mexico, argonne national lab.
c
c     subroutines and functions
c
c     blas daxpy,ddot
c
c     internal variables
c
      double precision ddot,t
      integer k,kb,l,nm1


c
      nm1 = n - 1
      if (job .ne. 0) go to 50
c
c        job = 0 , solve  a * x = b
c        first solve  l*y = b
c
         if (nm1 .lt. 1) go to 30
         do 20 k = 1, nm1
            l = ipvt(k)
            t = b(l)
            if (l .eq. k) go to 10
               b(l) = b(k)
               b(k) = t
   10       continue
            call daxpy(n-k,t,a(k+1,k),1,b(k+1),1)
   20    continue
   30    continue
c
c        now solve  u*x = y
c


         do 40 kb = 1, n
            k = n + 1 - kb

            b(k) = b(k)/a(k,k)
            t = -b(k)
            call daxpy(k-1,t,a(1,k),1,b(1),1)
   40    continue

      go to 100
   50 continue
c
c        job = nonzero, solve  trans(a) * x = b
c        first solve  trans(u)*y = b
c
         do 60 k = 1, n

            t = ddot(k-1,a(1,k),1,b(1),1)
            b(k) = (b(k) - t)/a(k,k)
   60    continue
c

c        now solve trans(l)*x = y
c
         if (nm1 .lt. 1) go to 90

         do 80 kb = 1, nm1
            k = n - kb
            b(k) = b(k) + ddot(n-k,a(k+1,k),1,b(k+1),1)
            l = ipvt(k)
            if (l .eq. k) go to 70
               t = b(l)

               b(l) = b(k)

               b(k) = t
   70       continue
   80    continue
   90    continue
  100 continue

      return
      end
 
C-----------------------------------------------------------------------
 
      subroutine dgbfa(abd,lda,n,ml,mu,ipvt,info)
      integer lda,n,ml,mu,ipvt(1),info
      double precision abd(lda,1)
c
c     dgbfa factors a double precision band matrix by elimination.

c
c     dgbfa is usually called by dgbco, but it can be called
c     directly with a saving in time if  rcond  is not needed.
c
c     on entry
c
c        abd     double precision(lda, n)
c                contains the matrix in band storage.  the columns
c                of the matrix are stored in the columns of  abd  and
c                the diagonals of the matrix are stored in rows

c                ml+1 through 2*ml+mu+1 of  abd .
c                see the comments below for details.
c
c        lda     integer
c                the leading dimension of the array  abd .
c                lda must be .ge. 2*ml + mu + 1 .
c

c        n       integer
c                the order of the original matrix.
c
c        ml      integer
c                number of diagonals below the main diagonal.
c                0 .le. ml .lt. n .

c
c        mu      integer
c                number of diagonals above the main diagonal.
c                0 .le. mu .lt. n .
c                more efficient if  ml .le. mu .
c     on return
c
c        abd     an upper triangular matrix in band storage and

c                the multipliers which were used to obtain it.
c                the factorization can be written  a = l*u  where
c                l  is a product of permutation and unit lower
c                triangular matrices and  u  is upper triangular.
c
c        ipvt    integer(n)
c                an integer vector of pivot indices.
c
c        info    integer
c                = 0  normal value.
c                = k  if  u(k,k) .eq. 0.0 .  this is not an error
c                     condition for this subroutine, but it does
c                     indicate that dgbsl will divide by zero if
c                     called.  use  rcond  in dgbco for a reliable
c                     indication of singularity.
c
c     band storage
c
c           if  a  is a band matrix, the following program segment
c           will set up the input.
c
c                   ml = (band width below the diagonal)
c                   mu = (band width above the diagonal)
c                   m = ml + mu + 1
c                   do 20 j = 1, n
c                      i1 = max0(1, j-mu)
c                      i2 = min0(n, j+ml)


c                      do 10 i = i1, i2
c                         k = i - j + m
c                         abd(k,j) = a(i,j)

c                10    continue
c                20 continue

c
c           this uses rows  ml+1  through  2*ml+mu+1  of  abd .
c           in addition, the first  ml  rows in  abd  are used for
c           elements generated during the triangularization.
c           the total number of rows needed in  abd  is  2*ml+mu+1 .
c           the  ml+mu by ml+mu  upper left triangle and the
c           ml by ml  lower right triangle are not referenced.
c
c     linpack. this version dated 08/14/78 .
c     cleve moler, university of new mexico, argonne national lab.
c
c     subroutines and functions
c
c     blas daxpy,dscal,idamax
c     fortran max0,min0

c
c     internal variables
c
      double precision t
      integer i,idamax,i0,j,ju,jz,j0,j1,k,kp1,l,lm,m,mm,nm1
c
c
      m = ml + mu + 1
      info = 0
c
c     zero initial fill-in columns
c
      j0 = mu + 2
      j1 = min0(n,m) - 1
      if (j1 .lt. j0) go to 30
      do 20 jz = j0, j1
         i0 = m + 1 - jz
         do 10 i = i0, ml
            abd(i,jz) = 0.0d0
   10    continue
   20 continue
   30 continue
      jz = j1
      ju = 0
c
c     gaussian elimination with partial pivoting
c
      nm1 = n - 1
      if (nm1 .lt. 1) go to 130
      do 120 k = 1, nm1
         kp1 = k + 1
c
c        zero next fill-in column
c
         jz = jz + 1
         if (jz .gt. n) go to 50


         if (ml .lt. 1) go to 50
            do 40 i = 1, ml
               abd(i,jz) = 0.0d0
   40       continue
   50    continue
c
c        find l = pivot index
c
         lm = min0(ml,n-k)
         l = idamax(lm+1,abd(m,k),1) + m - 1
         ipvt(k) = l + k - m
c
c        zero pivot implies this column already triangularized
c
         if (abd(l,k) .eq. 0.0d0) go to 100
c
c           interchange if necessary
c

            if (l .eq. m) go to 60
               t = abd(l,k)
               abd(l,k) = abd(m,k)
               abd(m,k) = t

   60       continue
c
c           compute multipliers
c
            t = -1.0d0/abd(m,k)
            call dscal(lm,t,abd(m+1,k),1)
c

c           row elimination with column indexing
c
            ju = min0(max0(ju,mu+ipvt(k)),n)
            mm = m
            if (ju .lt. kp1) go to 90
            do 80 j = kp1, ju
               l = l - 1
               mm = mm - 1
               t = abd(l,j)
               if (l .eq. mm) go to 70

                  abd(l,j) = abd(mm,j)
                  abd(mm,j) = t
   70          continue
               call daxpy(lm,t,abd(m+1,k),1,abd(mm+1,j),1)
   80       continue
   90       continue
         go to 110
  100    continue
            info = k

  110    continue
  120 continue

  130 continue

      ipvt(n) = n
      if (abd(m,n) .eq. 0.0d0) info = n
      return
      end
 
C-----------------------------------------------------------------------
 
      subroutine dgbsl(abd,lda,n,ml,mu,ipvt,b,job)
      integer lda,n,ml,mu,ipvt(1),job

      double precision abd(lda,1),b(1)
c

c     dgbsl solves the double precision band system
c     a * x = b  or  trans(a) * x = b

c     using the factors computed by dgbco or dgbfa.
c
c     on entry
c
c        abd     double precision(lda, n)
c                the output from dgbco or dgbfa.
c
c        lda     integer
c                the leading dimension of the array  abd .
c
c        n       integer
c                the order of the original matrix.
c
c        ml      integer
c                number of diagonals below the main diagonal.
c
c        mu      integer
c                number of diagonals above the main diagonal.
c
c        ipvt    integer(n)
c                the pivot vector from dgbco or dgbfa.
c

c        b       double precision(n)
c                the right hand side vector.
c
c        job     integer
c                = 0         to solve  a*x = b ,
c                = nonzero   to solve  trans(a)*x = b , where
c                            trans(a)  is the transpose.
c
c     on return
c
c        b       the solution vector  x .
c
c     error condition
c
c        a division by zero will occur if the input factor contains a
c        zero on the diagonal.  technically this indicates singularity
c        but it is often caused by improper arguments or improper

c        setting of lda .  it will not occur if the subroutines are
c        called correctly and if dgbco has set rcond .gt. 0.0
c        or dgbfa has set info .eq. 0 .
c
c     to compute  inverse(a) * c  where  c  is a matrix
c     with  p  columns
c           call dgbco(abd,lda,n,ml,mu,ipvt,rcond,z)
c           if (rcond is too small) go to ...
c           do 10 j = 1, p
c              call dgbsl(abd,lda,n,ml,mu,ipvt,c(1,j),0)
c        10 continue
c
c     linpack. this version dated 08/14/78 .
c     cleve moler, university of new mexico, argonne national lab.
c
c     subroutines and functions
c
c     blas daxpy,ddot
c     fortran min0
c
c     internal variables
c
      double precision ddot,t
      integer k,kb,l,la,lb,lm,m,nm1
c

      m = mu + ml + 1
      nm1 = n - 1

      if (job .ne. 0) go to 50

c
c        job = 0 , solve  a * x = b
c        first solve l*y = b
c
         if (ml .eq. 0) go to 30
         if (nm1 .lt. 1) go to 30
            do 20 k = 1, nm1
               lm = min0(ml,n-k)
               l = ipvt(k)
               t = b(l)
               if (l .eq. k) go to 10
                  b(l) = b(k)
                  b(k) = t


   10          continue
               call daxpy(lm,t,abd(m+1,k),1,b(k+1),1)
   20       continue
   30    continue
c
c        now solve  u*x = y
c
         do 40 kb = 1, n
            k = n + 1 - kb
            b(k) = b(k)/abd(m,k)
            lm = min0(k,m) - 1
            la = m - lm
            lb = k - lm
            t = -b(k)
            call daxpy(lm,t,abd(la,k),1,b(lb),1)
   40    continue
      go to 100
   50 continue
c
c        job = nonzero, solve  trans(a) * x = b
c        first solve  trans(u)*y = b
c
         do 60 k = 1, n
            lm = min0(k,m) - 1
            la = m - lm
            lb = k - lm
            t = ddot(lm,abd(la,k),1,b(lb),1)
            b(k) = (b(k) - t)/abd(m,k)
   60    continue
c
c        now solve trans(l)*x = y
c
         if (ml .eq. 0) go to 90
         if (nm1 .lt. 1) go to 90
            do 80 kb = 1, nm1
               k = n - kb
               lm = min0(ml,n-k)
               b(k) = b(k) + ddot(lm,abd(m+1,k),1,b(k+1),1)
               l = ipvt(k)
               if (l .eq. k) go to 70
                  t = b(l)
                  b(l) = b(k)
                  b(k) = t
   70          continue
   80       continue
   90    continue
  100 continue
      return
      end


      subroutine checkd(corden,new,nactveold,ab,maxgrd,nvar,iclose)

      implicit real*8 (a-h,o-z)
      real*8 ab(30,2), corden(maxgrd,1)
      iclose=0
      do ibas=1,nactveold
       sum=0.
       do i=1,nvar
       sum=sum+abs(corden(new,i)-corden(ibas,i))/(ab(i,2)-ab(i,1))
       enddo

      if(sum.le.1.d-4) then
      iclose=1
      return
      endif
      enddo

      return
      end


      subroutine emint(psi,ldpsi,theta,ldtheta,npoint,nsub,ijob,
     &                 x,dx,y,dy,fobj,gap,nvar,keep,IHESS)

      implicit real*8 (a-h,o-z)
      real*8 mu
      dimension psi(ldpsi,*),theta(ldtheta,*),x(*),dx(*),y(*),dy(*)
      CHARACTER ERRFIL*20

	COMMON/SUPRES/ISUPRES
C  COMMON/SUPRES IS SUPPLIED FROM SUBROUTINE BIGNPAG.

      COMMON/ERR/ERRFIL 


c This subroutine solves the 'EM' problem of maximizing the function
 
c   fobj(x) = sum_i (log[sum_j ( psi(i,j) * x(j)) ]  ),
c             j=1,..,npoint and i=1,...,nsub
c   subject to: x(j) >= 0, sum_j x(j) = 1 (i.e. x is a probability
c             vector of length npoint)
c   where psi(i,j) is a fixed non-negative data array representing the
c   likelihood of point j for subject i
 
c inputs: psi,ldpsi,npoint,nsub,nvar
c psi contains the likelihood vectors for each subject - the i-th
c row of psi is likelikhood vector for subject i.  Thus psi(i,j) is
c likelihood of the j-th point for c the i-th subject.  The input value
c ldpsi is the 'leading dimension of psi' - i.e. the first dimension of the
c array psi as dimensioned in the calling program.
c
c input work arrays: dx(*), y(*), dy(*) - should be at least large enough to
c contain npoint points, as should the probabiltiy array x(*)

c
c outputs: x(*), fobj
c x(i) is  final probability for point i
c fobj - optimal value of the objective function
 
c note - usually npoint is much larger than nsub; here we dimension

c some internal work arrays with the maximum expected number of subjects
c MAXSUBem and the maximum number of points MAXACTem
c are be set in the parameter statement


      parameter (MAXSUBem=999,MAXACTem=10000000)
      dimension w(MAXSUBem),dw(MAXSUBem),Ptx(MAXSUBem),
     &          hess(MAXSUBem,2*MAXSUBem)
      dimension psisum(MAXSUBem),XVERIFY(100)


      integer kpvt(MAXSUBem), ipivot(MAXACTem), list(MAXACTem)

C       DATA ILOOP/0/
C  ILOOP IS USED BELOW TO KNOW WHEN TO WRITE MESSAGE TO USER IN CASE

C  THE OPTIMIZATION TAKES A 'LONG' TIME.


c here w(*) is a vector if `dual variables'
c dw(*) is a calculated change (as a Newton step) in w(*)
c Ptx(*) (Psi times x) is the vector Ptx(j) = sum_i Psi(j,i)*x(i)
c first , perform some dimension checks to make sure no internal dimensions
c are exceeded
      keep = nactve

      if(nsub.gt.MAXSUBem) then

      write(6,*) 'nsub =',nsub, ' is greater than MAXSUBem=',MAXSUBem
      write(6,*) 'MAXSUBem needs to be reset as large as nsub'
      write(6,*) 'in PARAMETER statement in subroutine emint'

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
      write(42,*) 'nsub =',nsub, ' is greater than MAXSUBem=',MAXSUBem
      write(42,*) 'MAXSUBem needs to be reset as large as nsub'
      write(42,*) 'in PARAMETER statement in subroutine emint'
        CLOSE(42)

      CALL PAUSE
      stop

      endif


      if(npoint.gt.MAXACTem) then

      write(6,*) 'npoint=',npoint,' is larger than MAXACTem=',MAXACTem
      write(6,*) 'MAXACTem needs to be reset as large as npoint'
      write(6,*) 'in PARAMETER statement in subroutine emint'

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
      write(42,*) 'npoint=',npoint,' is larger than MAXACTem=',MAXACTem
      write(42,*) 'MAXACTem needs to be reset as large as npoint'
      write(42,*) 'in PARAMETER statement in subroutine emint'
        CLOSE(42)

      CALL PAUSE
      stop

      endif


c     Second, check that psi is non-negative
      psimin=0.
      do j=1,nsub
      do i=1,npoint
      if(psi(j,i).le.psimin) psimin=psi(j,i)
      enddo
      enddo

      if(psimin.lt.0) then

	  write(6,*) 'Psi matrix not non-negative -stop'

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
	   write(42,*) 'Psi matrix not non-negative -stop'
        CLOSE(42)

	  CALL PAUSE
	  stop

      endif

c     Third,check that the row sums of psi are positive - no zero rows
c     also initialize x and w
      colsummin=1.e10
      do j=1,nsub
        s=0.
        do i=1,npoint
           x(i)=1.d0
           s=s+psi(j,i)
        enddo
      psisum(j) = s
        Ptx(j)=s
        if(s.le.colsummin) colsummin=s

        if(s.le.0) then

           write(6,*) 'psi has a zero row -stop'

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)

	   write(42,*) 'psi has a zero row -stop'
        CLOSE(42)

	   CALL PAUSE
           stop

        endif

        w(j)=1./s
      enddo
c     calc ptw = w'*psi
      shrink=0.
      do i=1,npoint
        sum=0.d0
        do j=1,nsub
           sum=sum+psi(j,i)*w(j)
        enddo
        y(i)=sum
        if(sum.gt.shrink) shrink=sum
      enddo
      shrink=2.d0*shrink

      if(s.le.0) then

	  write(6,*) 'Psi has a zero column -stop'

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
	   write(42,*) 'Psi has a zero column -stop'
        CLOSE(42)

	  CALL PAUSE
	  stop

      endif

c     stopping tolerance
      eps=1.d-10
      sig=0.d0
      mu=0.d0
      do i=1,npoint
c       x = x*shrink;
        x(i)=1.d0*shrink
c       Ptw  = Ptw/shrink;
        y(i)=y(i)/shrink
c       y  = ecol-Ptw;
        y(i)=1.d0-y(i)
c       mu  =  (x'*y)/npoint;
        mu=mu+x(i)*y(i)
      enddo
      mu=mu/npoint
      rmax = -1.e38
      do j=1,nsub
c       w                       =  w/shrink;
        w(j)=w(j)/shrink
c       Plam            =  Plam*shrink;


        Ptx(j)=Ptx(j)*shrink
c
c       R =  erow-w.*Plam;
        if(dabs(1.d0-w(j)*Ptx(j)).ge.rmax) rmax =
     &  dabs(1.d0-w(j)*Ptx(j))

      enddo
      gap=1.d0
c start of iterations
      iter=0
100   continue
c     following is iteration termination condition


	conval = mu
      if(conval .lt. rmax) conval = rmax

      if(conval .lt. gap) conval = gap
      convcrit = eps/conval 

      XVERIFY(1) = convcrit
      CALL VERIFYVAL(1,XVERIFY)
    
C      IF(ILOOP .GT. 0) WRITE(*,123) iter,convcrit
       IF(ILOOP .GT. 0) WRITE(*,123) iter,XVERIFY(1)

  123 FORMAT(' Iteration ',I9,' CONV. CRIT = ',G15.2,' (1 OR HIGHER FOR 
     1CONVERGENCE)')
	
C  ABOVE WRITE STATEMENT ADDED IN bigmlt12.f SO THE USER WILL KNOW
C  THE PROGRAM HAS NOT 'HUNG' IF THE OPTIMIZATION TAKES A 'LONG' TIME.


      if(mu.le.eps.and.rmax.le.eps.and.gap.le.eps) go to 9000
      iter=iter+1

        ILOOP = ILOOP + 1

      tbuilda=0
      smu=sig*mu
c     zero out hessian
      do j=1,nsub
        do k=1,nsub
           hess(j,k)=0.
        enddo
      enddo
c do outer product portion of Hessian
      do i=1,npoint
        scale=x(i)/y(i)
       do j=1,nsub
         fact=scale*psi(j,i)
         do k=j,nsub
           hess(k,j)=hess(k,j)+fact*psi(k,i)
         enddo
       enddo
      enddo
      do j=1,nsub-1
      do k=j+1,nsub

      hess(j,k)=hess(k,j)
      enddo
      enddo
c do diagonal portion of hessian
      do j=1,nsub
        hess(j,j)=hess(j,j)+Ptx(j)/w(j)
      enddo
      tbuildb=0
      tbuild=tbuildb-tbuilda

      IF(ISUPRES .EQ. 0) write(6,*) 'tbuild=',tbuild

c now do cholesky decomposition-for time bing, use simple dpofa
c from LINPACK
c     call dpofa(hess,MAXSUBem,nsub,info)

c     call dsifa(hess,MAXSUBem,nsub,kpvt,info)
c note dpofa is cholesky factorization routine from LINPACK
c      dsifa is symmetric indefintie factorization routine from LINAPCK
c      DPOTRF is Cholesky factorization routine from LAPACK
c DPOTRF is fastest of the three, but DSIFA may be more reliable for
c nearly singular cases
c Regardless of which of the three routines is used, it must be matched
c with the proper solve routine (dposl for dpofa, dsisl for dsifa, 
c DPOTRS for DPOTRF below


      CALL DPOTRF( 'L', nsub, hess, MAXSUBem, INFO )
      tbuildc=0
      tfactor=tbuildc-tbuildb

      IF(ISUPRES .EQ. 0) write(6,*) 'tfactor=',tfactor

cdebugwrite(6,*) 'gap,info=',gap,info


c  As of npageng18.f, set IHESS = 0. If info .ne. 0, reset it = -1 and,
c  after writing the indicated message to the screen (and also now to 
c  the output file), return to MAIN, where IHESS = -1 tells the program
c  to create the output files before stopping (previously, if 
c  info .ne. 0, the program would simply stop after writing the 
c  indicated message to the screen).

      IHESS = 0


      if(info .ne. 0) then

       IHESS = -1


       WRITE(25,163)
       WRITE(*,163)
  163  FORMAT(//' Hessian matrix in interior point EM algorithm'/
     1' is singular.  Possibly number of grid points is too small,'/
     2' or assay coefficients are too large. '//
     3' Try again with a new assay polynomial or larger grid.'//
     4' Suggested quick fix: rerun and select error model 2)'/
     5' in response to the initial question; then enter a'/
     6' initial value gamma = 10.0 in response to the prompt for'/
     7' that value.'//
     8' THE PROGRAM WILL CREATE OUTPUT FILES BEFORE STOPPING. '//)

      WRITE(25,164) info
      WRITE(*,164) info
  164 FORMAT(//' NOTE THAT IN SUBROUTINE emint, THE VALUE OF INFO'/
     1' IS ',i6,//
     2' IF THIS VALUE IS POSTIVE, IT IS LIKELY THE NO. OF THE SUBJECT'/
     3' (OR AT LEAST THE FIRST SUBJECT) WHICH CAUSED THE HESSIAN '/
     4' ERROR. SO IN THIS CASE, YOU MIGHT ALSO WANT TO EXAMINE THE'/
     5' DATA IN THIS SUBJECT TO VERIFY THEY ARE CORRECT.'//)
      
c  As of npageng22.f, the following PAUSE is commented out ... since
c  it --> the program will not complete properly if it is run under
c  Pmetrics (which cannot supply a keyboard response during a run).
c     CALL PAUSE

c  As of npageng18.f, the program does not stop here; it returns to 
c  MAIN to write out the output files and then stops.

C  AS of npageng23.f, SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE
C  THE ERROR MESSAGE TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,163) 
         WRITE(42,164) info
        CLOSE(42)


      return

      endif



c construct rhs for linear equation system
      do j=1,nsub
        sum=0.d0
        do i=1,npoint

          sum=sum+psi(j,i)*smu/y(i)
        enddo
        dw(j)=1.d0/w(j)-sum
      enddo
c now solve linear system with LINPACK routine dposl
c and put answer in dw
c note - these routines match the factor routines dpofa, dsifa, and DPOTRF, respectively
c see note about 15 lines back where the factor routine is called
c     call dposl(hess,MAXSUBem,nsub,dw)

c     call dsisl(hess,MAXSUBem,nsub,kpvt,dw)
      call DPOTRS( 'L', nsub, 1, hess, MAXSUBem, dw, nsub, INFO )
c now compute dy and dx from dw

      do i=1,npoint
        sum=0.
        do j=1,nsub
          sum=sum+psi(j,i)*dw(j)
        enddo
        dy(i)=-sum
        dx(i)=smu/y(i)-x(i)-dy(i)*x(i)/y(i)
      enddo
c damp the Newton step
      alfpri=-.5
      do i=1,npoint
        if(dx(i)/x(i).le.alfpri) alfpri=dx(i)/x(i)
      enddo
      alfpri=-1.d0/alfpri
      alfpri=min(1.d0,0.99995*alfpri)
      alfdual=-0.5d0
      do i=1,npoint
        if(dy(i)/y(i).le.alfdual) alfdual=dy(i)/y(i)
      enddo
      alfdual=-1.d0/alfdual

      alfdual=min(1.d0,0.99995*alfdual)
      mu=0.d0
      do i=1,npoint
        x(i)=x(i)+alfpri*dx(i)
        y(i)=y(i)+alfdual*dy(i)
        mu=mu+x(i)*y(i)
      enddo
      mu=mu/npoint
      do j=1,nsub
        sum=0.d0
        do i=1,npoint
          sum=sum+psi(j,i)*x(i)
        enddo


        Ptx(j)=sum
      enddo
      do j=1,nsub
        w(j)=w(j)+alfdual*dw(j)

      enddo
c compute rmax (norm(r,inf)-note we don't really need to compute r
      rmax=0.
      do j=1,nsub
        rtest=1.d0-w(j)*Ptx(j)
        if(dabs(rtest).gt.rmax) rmax=dabs(rtest)
      enddo
      sumlogw=0.d0
      sumlgPtx=0.d0
      do j=1,nsub
        sumlogw=sumlogw+dlog(w(j))
        sumlgPtx=sumlgPtx+dlog(Ptx(j))
      enddo
      gap = dabs(sumlogw+sumlgPtx)/(1.d0+dabs(sumlgPtx))
      if(mu.lt.eps.and.rmax.gt.eps) then
        sig=1.d0
      else
        c2=1.d2
        term1=(1.d0-alfpri)**2
        term2=(1.d0-alfdual)**2
        term3=(rmax-mu)/(rmax+c2*mu)
        term=max(term1,term2)
        term=max(term,term3)
        sig=min(0.3d0,term)
      endif
      sumx=0.d0
      do i=1,npoint
        sumx=sumx+x(i)
      enddo
      fobj=0.
      do j=1,nsub
        fobj=fobj+dlog(Ptx(j)/sumx)
      enddo
      go to 100
c following is exit point
9000  continue
c finish by normalizing x to sum to 1.
c fobj has already been computed
      sumx=0.
      do i=1,npoint
      sumx=sumx+x(i)
      enddo
      do i=1,npoint
      x(i)=x(i)/sumx
      enddo
c finished if ijob=0
      if(ijob.eq.0) return
      isum=0
      xlim=0.
      do i=1,npoint
      if(x(i).gt.xlim) xlim=x(i)
      enddo
      xlim=xlim*1.d-3
      isum = 0
      do i=1,npoint
      if(x(i).gt.xlim) then
        isum = isum + 1
        list(isum) = i
        do j=1,nsub
        psi(j,isum) = psi(j,i)
        enddo
cpull
c now condense the original density grid
      do j=1,nvar
      theta(isum,j)=theta(i,j)
      enddo
      x(isum)=x(i)
      endif
      enddo
      job=1
      do k=1,npoint
      ipivot(k)=0
      enddo
c save a copy of psi after current end of psi
      do i=1,isum

      do j=1,nsub
      psi(j,i+isum)=psi(j,i)
      enddo
      enddo
      do i=1,isum
      do j=1,nsub
      psi(j,i) = psi(j,i)/psisum(j)
      enddo
      enddo
      call dqrdc(psi,ldpsi,nsub,isum,y,ipivot,dy,job)

      keep = 0
      limloop = nsub
      if(isum.lt.nsub) limloop = isum
      do i=1,limloop
      test=dnrm2(i,psi(1,i),1)
cdebugwrite(6,*) i,psi(i,i),test,psi(i,i)/test

      if(dabs(psi(i,i)/test).ge.1.d-8) keep=keep+1
      enddo
c sort ipivot to avoid collisions during condensing

      if(isum.gt.1) then
      do i=1,keep-1
      do j=i,keep
      if(ipivot(i)*ipivot(j).ne.0.and.ipivot(i).gt.ipivot(j)) then
         itemp=ipivot(i)
         ipivot(i)=ipivot(j)

         ipivot(j)=itemp
      endif
      enddo
      enddo
      endif
      do i=1,isum
      do j=1,nsub
      psi(j,i)=psi(j,i+isum)
      enddo
      enddo
c restore psi
 
 

 
C      CALL PAUSE
      do k=1,npoint
      dx(k)=0
      enddo
      sumkeep = 0.
      do k=1,keep
      j=ipivot(k)

      if(j.ne.0) then
         do jj=1,nsub
         psi(jj,k)=psi(jj,j)
         enddo
      do jvar=1,nvar
      theta(k,jvar) = theta(j,jvar)
      enddo
      endif
      if(j.gt.0) dx(list(j))=1.
      if(j.gt.0) sumkeep = sumkeep + x(list(j))
      if(j.gt.0) w(k)=x(list(j))
      enddo
      return
      end
      subroutine dpoco(a,lda,n,rcond,z,info)
      integer lda,n,info
      double precision a(lda,1),z(1)
      double precision rcond
c
c     dpoco factors a double precision symmetric positive definite
c     matrix and estimates the condition of the matrix.
c
c     if  rcond  is not needed, dpofa is slightly faster.
c     to solve  a*x = b , follow dpoco by dposl.
c     to compute  inverse(a)*c , follow dpoco by dposl.

c     to compute  determinant(a) , follow dpoco by dpodi.
c     to compute  inverse(a) , follow dpoco by dpodi.
c

c     on entry
c
c        a       double precision(lda, n)
c                the symmetric matrix to be factored.  only the
c                diagonal and upper triangle are used.
c

c        lda     integer
c                the leading dimension of the array  a .
c
c        n       integer
c                the order of the matrix  a .
c
c     on return
c
c        a       an upper triangular matrix  r  so that  a = trans(r)*r

c                where  trans(r)  is the transpose.
c                the strict lower triangle is unaltered.
c                if  info .ne. 0 , the factorization is not complete.
c
c        rcond   double precision
c                an estimate of the reciprocal condition of  a .
c                for the system  a*x = b , relative perturbations
c                in  a  and  b  of size  epsilon  may cause
c                relative perturbations in  x  of size  epsilon/rcond .
c                if  rcond  is so small that the logical expression
c                           1.0 + rcond .eq. 1.0
c                is true, then  a  may be singular to working
c                precision.  in particular,  rcond  is zero  if
c                exact singularity is detected or the estimate
c                underflows.  if info .ne. 0 , rcond is unchanged.
c
c        z       double precision(n)
c                a work vector whose contents are usually unimportant.
c                if  a  is close to a singular matrix, then  z  is
c                an approximate null vector in the sense that
c                norm(a*z) = rcond*norm(a)*norm(z) .
c                if  info .ne. 0 , z  is unchanged.
c
c        info    integer
c                = 0  for normal return.
c                = k  signals an error condition.  the leading minor
c                     of order  k  is not positive definite.
c
c     linpack.  this version dated 08/14/78 .
c     cleve moler, university of new mexico, argonne national lab.
c
c     subroutines and functions
c
c     linpack dpofa


c     blas daxpy,ddot,dscal,dasum
c     fortran dabs,dmax1,dreal,dsign
c
c     internal variables
c
      double precision ddot,ek,t,wk,wkm
      double precision anorm,s,dasum,sm,ynorm
      integer i,j,jm1,k,kb,kp1
c
c
c     find norm of a using only upper half
c

      do 30 j = 1, n
         z(j) = dasum(j,a(1,j),1)
         jm1 = j - 1
         if (jm1 .lt. 1) go to 20
         do 10 i = 1, jm1
            z(i) = z(i) + dabs(a(i,j))
   10    continue

   20    continue
   30 continue
      anorm = 0.0d0
      do 40 j = 1, n
         anorm = dmax1(anorm,z(j))
   40 continue
c
c     factor
c
      call dpofa(a,lda,n,info)
      if (info .ne. 0) go to 180
c
c        rcond = 1/(norm(a)*(estimate of norm(inverse(a)))) .
c        estimate = norm(z)/norm(y) where  a*z = y  and  a*y = e .
c        the components of  e  are chosen to cause maximum local
c        growth in the elements of w  where  trans(r)*w = e .
c        the vectors are frequently rescaled to avoid overflow.

c
c        solve trans(r)*w = e
c
         ek = 1.0d0
         do 50 j = 1, n
            z(j) = 0.0d0
   50    continue
         do 110 k = 1, n
            if (z(k) .ne. 0.0d0) ek = dsign(ek,-z(k))
            if (dabs(ek-z(k)) .le. a(k,k)) go to 60
               s = a(k,k)/dabs(ek-z(k))
               call dscal(n,s,z,1)
               ek = s*ek
   60       continue
            wk = ek - z(k)
            wkm = -ek - z(k)
            s = dabs(wk)
            sm = dabs(wkm)
            wk = wk/a(k,k)
            wkm = wkm/a(k,k)
            kp1 = k + 1
            if (kp1 .gt. n) go to 100
               do 70 j = kp1, n
                  sm = sm + dabs(z(j)+wkm*a(k,j))
                  z(j) = z(j) + wk*a(k,j)
                  s = s + dabs(z(j))
   70          continue
               if (s .ge. sm) go to 90
                  t = wkm - wk
                  wk = wkm
                  do 80 j = kp1, n
                     z(j) = z(j) + t*a(k,j)
   80             continue
   90          continue
  100       continue
            z(k) = wk
  110    continue
         s = 1.0d0/dasum(n,z,1)
         call dscal(n,s,z,1)
c
c        solve r*y = w
c
         do 130 kb = 1, n

            k = n + 1 - kb
            if (dabs(z(k)) .le. a(k,k)) go to 120

               s = a(k,k)/dabs(z(k))
               call dscal(n,s,z,1)
  120       continue
            z(k) = z(k)/a(k,k)
            t = -z(k)
            call daxpy(k-1,t,a(1,k),1,z(1),1)
  130    continue
         s = 1.0d0/dasum(n,z,1)
         call dscal(n,s,z,1)
c
         ynorm = 1.0d0
c
c        solve trans(r)*v = y
c
         do 150 k = 1, n
            z(k) = z(k) - ddot(k-1,a(1,k),1,z(1),1)
            if (dabs(z(k)) .le. a(k,k)) go to 140
               s = a(k,k)/dabs(z(k))

               call dscal(n,s,z,1)
               ynorm = s*ynorm
  140       continue
            z(k) = z(k)/a(k,k)
  150    continue
         s = 1.0d0/dasum(n,z,1)
         call dscal(n,s,z,1)
         ynorm = s*ynorm


c
c        solve r*z = v
c
         do 170 kb = 1, n
            k = n + 1 - kb
            if (dabs(z(k)) .le. a(k,k)) go to 160
               s = a(k,k)/dabs(z(k))
               call dscal(n,s,z,1)
               ynorm = s*ynorm
  160       continue
            z(k) = z(k)/a(k,k)
            t = -z(k)
            call daxpy(k-1,t,a(1,k),1,z(1),1)
  170    continue
c        make znorm = 1.0

         s = 1.0d0/dasum(n,z,1)
         call dscal(n,s,z,1)
         ynorm = s*ynorm
c
         if (anorm .ne. 0.0d0) rcond = ynorm/anorm
         if (anorm .eq. 0.0d0) rcond = 0.0d0
  180 continue
      return
      end
      subroutine dpofa(a,lda,n,info)
      integer lda,n,info
      double precision a(lda,1)
c
c     dpofa factors a double precision symmetric positive definite
c     matrix.
c

c     dpofa is usually called by dpoco, but it can be called
c     directly with a saving in time if  rcond  is not needed.
c     (time for dpoco) = (1 + 18/n)*(time for dpofa) .
c
c     on entry
c
c        a       double precision(lda, n)
c                the symmetric matrix to be factored.  only the
c                diagonal and upper triangle are used.
c
c        lda     integer
c                the leading dimension of the array  a .

c
c        n       integer
c                the order of the matrix  a .
c
c     on return
c
c        a       an upper triangular matrix  r  so that  a = trans(r)*r
c                where  trans(r)  is the transpose.
c                the strict lower triangle is unaltered.

c                if  info .ne. 0 , the factorization is not complete.
c
c        info    integer
c                = 0  for normal return.
c                = k  signals an error condition.  the leading minor
c                     of order  k  is not positive definite.
c
c     linpack.  this version dated 08/14/78 .
c     cleve moler, university of new mexico, argonne national lab.
c
c     subroutines and functions
c
c     blas ddot
c     fortran dsqrt
c
c     internal variables
c

      double precision ddot,t
      double precision s
      integer j,jm1,k
c     begin block with ...exits to 40

c
c
         do 30 j = 1, n
            info = j
            s = 0.0d0
            jm1 = j - 1
            if (jm1 .lt. 1) go to 20
            do 10 k = 1, jm1
               t = a(k,j) - ddot(k-1,a(1,k),1,a(1,j),1)
               t = t/a(k,k)
               a(k,j) = t
               s = s + t*t
   10       continue
   20       continue
            s = a(j,j) - s
c     ......exit

            if (s .le. 0.0d0) go to 40
            a(j,j) = dsqrt(s)
   30    continue
         info = 0
   40 continue
      return
      end
      subroutine dposl(a,lda,n,b)

      integer lda,n
      double precision a(lda,1),b(1)
c

c     dposl solves the double precision symmetric positive definite

c     system a * x = b
c     using the factors computed by dpoco or dpofa.
c
c     on entry
c
c        a       double precision(lda, n)
c                the output from dpoco or dpofa.
c
c        lda     integer
c                the leading dimension of the array  a .
c
c        n       integer

c                the order of the matrix  a .
c
c        b       double precision(n)
c                the right hand side vector.
c

c     on return
c
c        b       the solution vector  x .

c
c     error condition
c
c        a division by zero will occur if the input factor contains
c        a zero on the diagonal.  technically this indicates
c        singularity but it is usually caused by improper subroutine
c        arguments.  it will not occur if the subroutines are called
c        correctly and  info .eq. 0 .
c
c     to compute  inverse(a) * c  where  c  is a matrix

c     with  p  columns
c           call dpoco(a,lda,n,rcond,z,info)
c           if (rcond is too small .or. info .ne. 0) go to ...
c           do 10 j = 1, p
c              call dposl(a,lda,n,c(1,j))
c        10 continue
c
c     linpack.  this version dated 08/14/78 .
c     cleve moler, university of new mexico, argonne national lab.
c

c     subroutines and functions
c
c     blas daxpy,ddot
c
c     internal variables
c
      double precision ddot,t
      integer k,kb
c
c     solve trans(r)*y = b
c
      do 10 k = 1, n

         t = ddot(k-1,a(1,k),1,b(1),1)
         b(k) = (b(k) - t)/a(k,k)
   10 continue
c
c     solve r*x = y
c
      do 20 kb = 1, n
         k = n + 1 - kb
         b(k) = b(k)/a(k,k)
         t = -b(k)
         call daxpy(k-1,t,a(1,k),1,b(1),1)
   20 continue
      return
      end
      subroutine dsifa(a,lda,n,kpvt,info)
      integer lda,n,kpvt(1),info
      double precision a(lda,1)
c
c     dsifa factors a double precision symmetric matrix by elimination
c     with symmetric pivoting.

c
c     to solve  a*x = b , follow dsifa by dsisl.
c     to compute  inverse(a)*c , follow dsifa by dsisl.
c     to compute  determinant(a) , follow dsifa by dsidi.
c     to compute  inertia(a) , follow dsifa by dsidi.
c     to compute  inverse(a) , follow dsifa by dsidi.
c
c     on entry
c
c        a       double precision(lda,n)
c                the symmetric matrix to be factored.
c                only the diagonal and upper triangle are used.
c
c        lda     integer
c                the leading dimension of the array  a .
c
c        n       integer
c                the order of the matrix  a .
c
c     on return
c
c        a       a block diagonal matrix and the multipliers which
c                were used to obtain it.

c                the factorization can be written  a = u*d*trans(u)
c                where  u  is a product of permutation and unit
c                upper triangular matrices , trans(u) is the
c                transpose of  u , and  d  is block diagonal

c                with 1 by 1 and 2 by 2 blocks.
c
c        kpvt    integer(n)
c                an integer vector of pivot indices.
c
c        info    integer
c                = 0  normal value.
c                = k  if the k-th pivot block is singular. this is
c                     not an error condition for this subroutine,
c                     but it does indicate that dsisl or dsidi may
c                     divide by zero if called.
c

c     linpack. this version dated 08/14/78 .
c     james bunch, univ. calif. san diego, argonne nat. lab.

c
c     subroutines and functions
c
c     blas daxpy,dswap,idamax
c     fortran dabs,dmax1,dsqrt
c
c     internal variables
c
      double precision ak,akm1,bk,bkm1,denom,mulk,mulkm1,t
      double precision absakk,alpha,colmax,rowmax
      integer imax,imaxp1,j,jj,jmax,k,km1,km2,kstep,idamax
      logical swap
c
c
c     initialize
c
c     alpha is used in choosing pivot block size.
      alpha = (1.0d0 + dsqrt(17.0d0))/8.0d0
c
      info = 0
c
c     main loop on k, which goes from n to 1.
c
      k = n
   10 continue
c
c        leave the loop if k=0 or k=1.
c
c     ...exit
         if (k .eq. 0) go to 200
         if (k .gt. 1) go to 20
            kpvt(1) = 1
            if (a(1,1) .eq. 0.0d0) info = 1
c     ......exit
            go to 200
   20    continue
c
c        this section of code determines the kind of
c        elimination to be performed.  when it is completed,
c        kstep will be set to the size of the pivot block, and
c        swap will be set to .true. if an interchange is
c        required.
c
         km1 = k - 1
         absakk = dabs(a(k,k))
c
c        determine the largest off-diagonal element in
c        column k.

c

         imax = idamax(k-1,a(1,k),1)
         colmax = dabs(a(imax,k))
         if (absakk .lt. alpha*colmax) go to 30
            kstep = 1
            swap = .false.
         go to 90
   30    continue
c
c           determine the largest off-diagonal element in
c           row imax.
c
            rowmax = 0.0d0

            imaxp1 = imax + 1
            do 40 j = imaxp1, k

               rowmax = dmax1(rowmax,dabs(a(imax,j)))
   40       continue
            if (imax .eq. 1) go to 50
               jmax = idamax(imax-1,a(1,imax),1)
               rowmax = dmax1(rowmax,dabs(a(jmax,imax)))
   50       continue
            if (dabs(a(imax,imax)) .lt. alpha*rowmax) go to 60
               kstep = 1
               swap = .true.
            go to 80
   60       continue
            if (absakk .lt. alpha*colmax*(colmax/rowmax)) go to 70
               kstep = 1
               swap = .false.
            go to 80

   70       continue
               kstep = 2
               swap = imax .ne. km1
   80       continue
   90    continue
         if (dmax1(absakk,colmax) .ne. 0.0d0) go to 100
c
c           column k is zero.  set info and iterate the loop.
c
            kpvt(k) = k
            info = k
         go to 190

  100    continue


         if (kstep .eq. 2) go to 140
c
c           1 x 1 pivot block.
c
            if (.not.swap) go to 120
c
c              perform an interchange.
c
               call dswap(imax,a(1,imax),1,a(1,k),1)
               do 110 jj = imax, k
                  j = k + imax - jj
                  t = a(j,k)

                  a(j,k) = a(imax,j)
                  a(imax,j) = t
  110          continue
  120       continue
c
c           perform the elimination.
c
            do 130 jj = 1, km1
               j = k - jj
               mulk = -a(j,k)/a(k,k)
               t = mulk
               call daxpy(j,t,a(1,k),1,a(1,j),1)
               a(j,k) = mulk
  130       continue
c
c           set the pivot array.
c
            kpvt(k) = k

            if (swap) kpvt(k) = imax
         go to 190
  140    continue
c
c           2 x 2 pivot block.
c
            if (.not.swap) go to 160
c
c              perform an interchange.
c
               call dswap(imax,a(1,imax),1,a(1,k-1),1)
               do 150 jj = imax, km1
                  j = km1 + imax - jj
                  t = a(j,k-1)
                  a(j,k-1) = a(imax,j)
                  a(imax,j) = t
  150          continue
               t = a(k-1,k)
               a(k-1,k) = a(imax,k)
               a(imax,k) = t

  160       continue

c
c           perform the elimination.
c
            km2 = k - 2
            if (km2 .eq. 0) go to 180
               ak = a(k,k)/a(k-1,k)
               akm1 = a(k-1,k-1)/a(k-1,k)

               denom = 1.0d0 - ak*akm1
               do 170 jj = 1, km2
                  j = km1 - jj
                  bk = a(j,k)/a(k-1,k)
                  bkm1 = a(j,k-1)/a(k-1,k)
                  mulk = (akm1*bk - bkm1)/denom

                  mulkm1 = (ak*bkm1 - bk)/denom
                  t = mulk
                  call daxpy(j,t,a(1,k),1,a(1,j),1)
                  t = mulkm1
                  call daxpy(j,t,a(1,k-1),1,a(1,j),1)
                  a(j,k) = mulk
                  a(j,k-1) = mulkm1



  170          continue

  180       continue
c
c           set the pivot array.
c
            kpvt(k) = 1 - k
            if (swap) kpvt(k) = -imax
            kpvt(k-1) = kpvt(k)

  190    continue
         k = k - kstep
      go to 10
  200 continue
      return
      end
      subroutine dsisl(a,lda,n,kpvt,b)
      integer lda,n,kpvt(1)
      double precision a(lda,1),b(1)
c
c     dsisl solves the double precision symmetric system
c     a * x = b

c     using the factors computed by dsifa.
c
c     on entry
c
c        a       double precision(lda,n)
c                the output from dsifa.
c
c        lda     integer
c                the leading dimension of the array  a .
c

c        n       integer
c                the order of the matrix  a .
c
c        kpvt    integer(n)
c                the pivot vector from dsifa.
c
c        b       double precision(n)
c                the right hand side vector.
c
c     on return
c
c        b       the solution vector  x .
c
c     error condition
c
c        a division by zero may occur if  dsico  has set rcond .eq. 0.0
c        or  dsifa  has set info .ne. 0  .
c
c     to compute  inverse(a) * c  where  c  is a matrix
c     with  p  columns
c           call dsifa(a,lda,n,kpvt,info)
c           if (info .ne. 0) go to ...
c           do 10 j = 1, p
c              call dsisl(a,lda,n,kpvt,c(1,j))
c        10 continue
c
c     linpack. this version dated 08/14/78 .
c     james bunch, univ. calif. san diego, argonne nat. lab.
c
c     subroutines and functions

c
c     blas daxpy,ddot
c     fortran iabs
c
c     internal variables.
c
      double precision ak,akm1,bk,bkm1,ddot,denom,temp
      integer k,kp

c
c     loop backward applying the transformations and
c     d inverse to b.
c
      k = n
   10 if (k .eq. 0) go to 80
         if (kpvt(k) .lt. 0) go to 40
c
c           1 x 1 pivot block.
c
            if (k .eq. 1) go to 30
               kp = kpvt(k)
               if (kp .eq. k) go to 20
c
c                 interchange.
c

                  temp = b(k)
                  b(k) = b(kp)
                  b(kp) = temp

   20          continue
c
c              apply the transformation.
c
               call daxpy(k-1,b(k),a(1,k),1,b(1),1)
   30       continue
c
c           apply d inverse.
c
            b(k) = b(k)/a(k,k)
            k = k - 1
         go to 70

   40    continue

c
c           2 x 2 pivot block.
c
            if (k .eq. 2) go to 60
               kp = iabs(kpvt(k))
               if (kp .eq. k - 1) go to 50
c
c                 interchange.
c
                  temp = b(k-1)
                  b(k-1) = b(kp)
                  b(kp) = temp
   50          continue
c
c              apply the transformation.
c
               call daxpy(k-2,b(k),a(1,k),1,b(1),1)
               call daxpy(k-2,b(k-1),a(1,k-1),1,b(1),1)
   60       continue
c
c           apply d inverse.
c
            ak = a(k,k)/a(k-1,k)
            akm1 = a(k-1,k-1)/a(k-1,k)
            bk = b(k)/a(k-1,k)
            bkm1 = b(k-1)/a(k-1,k)
            denom = ak*akm1 - 1.0d0
            b(k) = (akm1*bk - bkm1)/denom
            b(k-1) = (ak*bkm1 - bk)/denom
            k = k - 2
   70    continue
      go to 10
   80 continue
c
c     loop forward applying the transformations.
c
      k = 1
   90 if (k .gt. n) go to 160
         if (kpvt(k) .lt. 0) go to 120
c
c           1 x 1 pivot block.
c
            if (k .eq. 1) go to 110

c
c              apply the transformation.
c
               b(k) = b(k) + ddot(k-1,a(1,k),1,b(1),1)
               kp = kpvt(k)
               if (kp .eq. k) go to 100


c
c                 interchange.
c
                  temp = b(k)
                  b(k) = b(kp)
                  b(kp) = temp


  100          continue

  110       continue
            k = k + 1
         go to 150
  120    continue
c
c           2 x 2 pivot block.
c
            if (k .eq. 1) go to 140
c
c              apply the transformation.
c
               b(k) = b(k) + ddot(k-1,a(1,k),1,b(1),1)
               b(k+1) = b(k+1) + ddot(k-1,a(1,k+1),1,b(1),1)
               kp = iabs(kpvt(k))
               if (kp .eq. k) go to 130
c
c                 interchange.


c
                  temp = b(k)
                  b(k) = b(kp)
                  b(kp) = temp
  130          continue
  140       continue
            k = k + 2

  150    continue

      go to 90
  160 continue
      return
      end
      subroutine dqrdc(x,ldx,n,p,qraux,jpvt,work,job)
      integer ldx,n,p,job

      integer jpvt(1)
      double precision x(ldx,1),qraux(1),work(1)
c
c     dqrdc uses householder transformations to compute the qr
c     factorization of an n by p matrix x.  column pivoting
c     based on the 2-norms of the reduced columns may be
c     performed at the users option.
c
c     on entry
c
c        x       double precision(ldx,p), where ldx .ge. n.
c                x contains the matrix whose decomposition is to be

c                computed.
c
c        ldx     integer.
c                ldx is the leading dimension of the array x.
c
c        n       integer.
c                n is the number of rows of the matrix x.
c
c        p       integer.
c                p is the number of columns of the matrix x.
c
c        jpvt    integer(p).
c                jpvt contains integers that control the selection
c                of the pivot columns.  the k-th column x(k) of x

c                is placed in one of three classes according to the
c                value of jpvt(k).
c
c                   if jpvt(k) .gt. 0, then x(k) is an initial
c                                      column.

c
c                   if jpvt(k) .eq. 0, then x(k) is a free column.

c
c                   if jpvt(k) .lt. 0, then x(k) is a final column.
c
c                before the decomposition is computed, initial columns
c                are moved to the beginning of the array x and final

c                columns to the end.  both initial and final columns
c                are frozen in place during the computation and only
c                free columns are moved.  at the k-th stage of the
c                reduction, if x(k) is occupied by a free column
c                it is interchanged with the free column of largest
c                reduced norm.  jpvt is not referenced if
c                job .eq. 0.
c
c        work    double precision(p).
c                work is a work array.  work is not referenced if
c                job .eq. 0.
c
c        job     integer.
c                job is an integer that initiates column pivoting.
c                if job .eq. 0, no pivoting is done.
c                if job .ne. 0, pivoting is done.
c

c     on return
c
c        x       x contains in its upper triangle the upper

c                triangular matrix r of the qr factorization.
c                below its diagonal x contains information from
c                which the orthogonal part of the decomposition
c                can be recovered.  note that if pivoting has

c                been requested, the decomposition is not that
c                of the original matrix x but that of x
c                with its columns permuted as described by jpvt.
c
c        qraux   double precision(p).
c                qraux contains further information required to recover
c                the orthogonal part of the decomposition.
c
c        jpvt    jpvt(k) contains the index of the column of the
c                original matrix that has been interchanged into
c                the k-th column, if pivoting was requested.
c
c     linpack. this version dated 08/14/78 .
c     g.w. stewart, university of maryland, argonne national lab.
c

c     dqrdc uses the following functions and subprograms.
c
c     blas daxpy,ddot,dscal,dswap,dnrm2
c     fortran dabs,dmax1,min0,dsqrt
c
c     internal variables
c
      integer j,jp,l,lp1,lup,maxj,pl,pu
      double precision maxnrm,dnrm2,tt
      double precision ddot,nrmxl,t
      logical negj,swapj
c
c
      pl = 1
      pu = 0
      if (job .eq. 0) go to 60
c
c        pivoting has been requested.  rearrange the columns
c        according to jpvt.
c
         do 20 j = 1, p


            swapj = jpvt(j) .gt. 0
            negj = jpvt(j) .lt. 0
            jpvt(j) = j
            if (negj) jpvt(j) = -j
            if (.not.swapj) go to 10
               if (j .ne. pl) call dswap(n,x(1,pl),1,x(1,j),1)
               jpvt(j) = jpvt(pl)
               jpvt(pl) = j
               pl = pl + 1
   10       continue

   20    continue
         pu = p
         do 50 jj = 1, p
            j = p - jj + 1
            if (jpvt(j) .ge. 0) go to 40

               jpvt(j) = -jpvt(j)

               if (j .eq. pu) go to 30
                  call dswap(n,x(1,pu),1,x(1,j),1)
                  jp = jpvt(pu)
                  jpvt(pu) = jpvt(j)
                  jpvt(j) = jp
   30          continue
               pu = pu - 1
   40       continue
   50    continue
   60 continue

c
c     compute the norms of the free columns.
c
      if (pu .lt. pl) go to 80
      do 70 j = pl, pu
         qraux(j) = dnrm2(n,x(1,j),1)
         work(j) = qraux(j)
   70 continue
   80 continue
c
c     perform the householder reduction of x.
c
      lup = min0(n,p)
      do 200 l = 1, lup
         if (l .lt. pl .or. l .ge. pu) go to 120
c
c           locate the column of largest norm and bring it
c           into the pivot position.
c
            maxnrm = 0.0d0

            maxj = l
            do 100 j = l, pu
               if (qraux(j) .le. maxnrm) go to 90
                  maxnrm = qraux(j)
                  maxj = j
   90          continue

  100       continue


            if (maxj .eq. l) go to 110
               call dswap(n,x(1,l),1,x(1,maxj),1)
               qraux(maxj) = qraux(l)
               work(maxj) = work(l)
               jp = jpvt(maxj)
               jpvt(maxj) = jpvt(l)
               jpvt(l) = jp
  110       continue
  120    continue
         qraux(l) = 0.0d0
         if (l .eq. n) go to 190
c
c           compute the householder transformation for column l.
c
            nrmxl = dnrm2(n-l+1,x(l,l),1)
            if (nrmxl .eq. 0.0d0) go to 180
               if (x(l,l) .ne. 0.0d0) nrmxl = dsign(nrmxl,x(l,l))
               call dscal(n-l+1,1.0d0/nrmxl,x(l,l),1)
               x(l,l) = 1.0d0 + x(l,l)
c
c              apply the transformation to the remaining columns,
c              updating the norms.
c
               lp1 = l + 1

               if (p .lt. lp1) go to 170
               do 160 j = lp1, p

                  t = -ddot(n-l+1,x(l,l),1,x(l,j),1)/x(l,l)
                  call daxpy(n-l+1,t,x(l,l),1,x(l,j),1)
                  if (j .lt. pl .or. j .gt. pu) go to 150
                  if (qraux(j) .eq. 0.0d0) go to 150
                     tt = 1.0d0 - (dabs(x(l,j))/qraux(j))**2
                     tt = dmax1(tt,0.0d0)
                     t = tt
                     tt = 1.0d0 + 0.05d0*tt*(qraux(j)/work(j))**2
                     if (tt .eq. 1.0d0) go to 130
                        qraux(j) = qraux(j)*dsqrt(t)
                     go to 140

  130                continue
                        qraux(j) = dnrm2(n-l,x(l+1,j),1)
                        work(j) = qraux(j)
  140                continue
  150             continue
  160          continue
  170          continue
c
c              save the transformation.

c
               qraux(l) = x(l,l)
               x(l,l) = -nrmxl
  180       continue

  190    continue
  200 continue
      return
      end
C LAPACK routines follow
C note that thte call to the LAPACK auxialliary routine
C that defines NB has been rpelaced by a hardwired
C NB=16 in dpotrf.f
C This is probably OK for PCs, but workstations may be a bit faster with
C NB = 32
      SUBROUTINE DPOTRF( UPLO, N, A, LDA, INFO )
*
*  -- LAPACK routine (version 3.0) --
*     Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
*     Courant Institute, Argonne National Lab, and Rice University
*     March 31, 1993

*

*     .. Scalar Arguments ..
      CHARACTER          UPLO
      INTEGER            INFO, LDA, N
*     ..
*     .. Array Arguments ..
      DOUBLE PRECISION   A( LDA, * )

*     ..
*
*  Purpose
*  =======
*
*  DPOTRF computes the Cholesky factorization of a real symmetric
*  positive definite matrix A.
*
*  The factorization has the form
*     A = U**T * U,  if UPLO = 'U', or
*     A = L  * L**T,  if UPLO = 'L',
*  where U is an upper triangular matrix and L is lower triangular.

*
*  This is the block version of the algorithm, calling Level 3 BLAS.
*
*  Arguments
*  =========
*
*  UPLO    (input) CHARACTER*1
*          = 'U':  Upper triangle of A is stored;
*          = 'L':  Lower triangle of A is stored.
*
*  N       (input) INTEGER

*          The order of the matrix A.  N >= 0.
*
*  A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
*          On entry, the symmetric matrix A.  If UPLO = 'U', the leading
*          N-by-N upper triangular part of A contains the upper
*          triangular part of the matrix A, and the strictly lower
*          triangular part of A is not referenced.  If UPLO = 'L', the
*          leading N-by-N lower triangular part of A contains the lower
*          triangular part of the matrix A, and the strictly upper
*          triangular part of A is not referenced.
*
*          On exit, if INFO = 0, the factor U or L from the Cholesky
*          factorization A = U**T*U or A = L*L**T.
*
*  LDA     (input) INTEGER
*          The leading dimension of the array A.  LDA >= max(1,N).
*
*  INFO    (output) INTEGER
*          = 0:  successful exit
*          < 0:  if INFO = -i, the i-th argument had an illegal value

*          > 0:  if INFO = i, the leading minor of order i is not
*                positive definite, and the factorization could not be
*                completed.
*
*  =====================================================================
*
*     .. Parameters ..

      DOUBLE PRECISION   ONE
      PARAMETER          ( ONE = 1.0D+0 )
*     ..
*     .. Local Scalars ..
      LOGICAL            UPPER
      INTEGER            J, JB, NB
*     ..

*     .. External Functions ..
      LOGICAL            LSAME
      EXTERNAL           LSAME
*     ..
*     .. External Subroutines ..
      EXTERNAL           DGEMM, DPOTF2, DSYRK, DTRSM, XERBLA
*     ..
*     .. Intrinsic Functions ..

      INTRINSIC          MAX, MIN
*     ..
*     .. Executable Statements ..

*
*     Test the input parameters.
*
      INFO = 0
      UPPER = LSAME( UPLO, 'U' )
      IF( .NOT.UPPER .AND. .NOT.LSAME( UPLO, 'L' ) ) THEN
         INFO = -1
      ELSE IF( N.LT.0 ) THEN
         INFO = -2
      ELSE IF( LDA.LT.MAX( 1, N ) ) THEN
         INFO = -4
      END IF

      IF( INFO.NE.0 ) THEN
         CALL XERBLA( 'DPOTRF', -INFO )
         RETURN
      END IF
*
*     Quick return if possible


*

      IF( N.EQ.0 )
     $   RETURN
*
*     Determine the block size for this environment.
*
      nb = 16
      IF( NB.LE.1 .OR. NB.GE.N ) THEN
*
*        Use unblocked code.

*
         CALL DPOTF2( UPLO, N, A, LDA, INFO )
      ELSE
*
*        Use blocked code.
*
         IF( UPPER ) THEN
*
*           Compute the Cholesky factorization A = U'*U.
*
            DO 10 J = 1, N, NB
*
*              Update and factorize the current diagonal block and test
*              for non-positive-definiteness.
*
               JB = MIN( NB, N-J+1 )
               CALL DSYRK( 'Upper', 'Transpose', JB, J-1, -ONE,
     $                     A( 1, J ), LDA, ONE, A( J, J ), LDA )
               CALL DPOTF2( 'Upper', JB, A( J, J ), LDA, INFO )
               IF( INFO.NE.0 )
     $            GO TO 30
               IF( J+JB.LE.N ) THEN
*
*                 Compute the current block row.
*
                  CALL DGEMM( 'Transpose', 'No transpose', JB, N-J-JB+1,
     $                        J-1, -ONE, A( 1, J ), LDA, A( 1, J+JB ),
     $                        LDA, ONE, A( J, J+JB ), LDA )
                  CALL DTRSM( 'Left', 'Upper', 'Transpose', 'Non-unit',
     $                        JB, N-J-JB+1, ONE, A( J, J ), LDA,
     $                        A( J, J+JB ), LDA )
               END IF
   10       CONTINUE

*
         ELSE
*
*           Compute the Cholesky factorization A = L*L'.
*
            DO 20 J = 1, N, NB
*
*              Update and factorize the current diagonal block and test
*              for non-positive-definiteness.
*
               JB = MIN( NB, N-J+1 )
               CALL DSYRK( 'Lower', 'No transpose', JB, J-1, -ONE,
     $                     A( J, 1 ), LDA, ONE, A( J, J ), LDA )
               CALL DPOTF2( 'Lower', JB, A( J, J ), LDA, INFO )
               IF( INFO.NE.0 )
     $            GO TO 30
               IF( J+JB.LE.N ) THEN
*
*                 Compute the current block column.
*
                  CALL DGEMM( 'No transpose', 'Transpose', N-J-JB+1, JB,
     $                        J-1, -ONE, A( J+JB, 1 ), LDA, A( J, 1 ),
     $                        LDA, ONE, A( J+JB, J ), LDA )
                  CALL DTRSM( 'Right', 'Lower', 'Transpose', 'Non-unit',
     $                        N-J-JB+1, JB, ONE, A( J, J ), LDA,
     $                        A( J+JB, J ), LDA )
               END IF

   20       CONTINUE
         END IF
      END IF
      GO TO 40
*

   30 CONTINUE
      INFO = INFO + J - 1
*
   40 CONTINUE
      RETURN
*
*     End of DPOTRF
*
      END
      SUBROUTINE DPOTRS( UPLO, N, NRHS, A, LDA, B, LDB, INFO )
*

*  -- LAPACK routine (version 3.0) --
*     Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
*     Courant Institute, Argonne National Lab, and Rice University
*     March 31, 1993
*
*     .. Scalar Arguments ..

      CHARACTER          UPLO

      INTEGER            INFO, LDA, LDB, N, NRHS
*     ..
*     .. Array Arguments ..
      DOUBLE PRECISION   A( LDA, * ), B( LDB, * )
*     ..
*
*  Purpose
*  =======
*
*  DPOTRS solves a system of linear equations A*X = B with a symmetric
*  positive definite matrix A using the Cholesky factorization
*  A = U**T*U or A = L*L**T computed by DPOTRF.
*
*  Arguments
*  =========
*
*  UPLO    (input) CHARACTER*1
*          = 'U':  Upper triangle of A is stored;
*          = 'L':  Lower triangle of A is stored.
*

*  N       (input) INTEGER
*          The order of the matrix A.  N >= 0.
*
*  NRHS    (input) INTEGER

*          The number of right hand sides, i.e., the number of columns
*          of the matrix B.  NRHS >= 0.
*

*  A       (input) DOUBLE PRECISION array, dimension (LDA,N)
*          The triangular factor U or L from the Cholesky factorization
*          A = U**T*U or A = L*L**T, as computed by DPOTRF.
*
*  LDA     (input) INTEGER

*          The leading dimension of the array A.  LDA >= max(1,N).

*
*  B       (input/output) DOUBLE PRECISION array, dimension (LDB,NRHS)
*          On entry, the right hand side matrix B.
*          On exit, the solution matrix X.
*

*  LDB     (input) INTEGER
*          The leading dimension of the array B.  LDB >= max(1,N).
*
*  INFO    (output) INTEGER
*          = 0:  successful exit
*          < 0:  if INFO = -i, the i-th argument had an illegal value
*
*  =====================================================================
*
*     .. Parameters ..
      DOUBLE PRECISION   ONE
      PARAMETER          ( ONE = 1.0D+0 )
*     ..
*     .. Local Scalars ..
      LOGICAL            UPPER
*     ..
*     .. External Functions ..
      LOGICAL            LSAME
      EXTERNAL           LSAME
*     ..
*     .. External Subroutines ..
      EXTERNAL           DTRSM, XERBLA
*     ..
*     .. Intrinsic Functions ..
      INTRINSIC          MAX
*     ..

*     .. Executable Statements ..
*
*     Test the input parameters.
*
      INFO = 0
      UPPER = LSAME( UPLO, 'U' )
      IF( .NOT.UPPER .AND. .NOT.LSAME( UPLO, 'L' ) ) THEN
         INFO = -1
      ELSE IF( N.LT.0 ) THEN
         INFO = -2
      ELSE IF( NRHS.LT.0 ) THEN
         INFO = -3

      ELSE IF( LDA.LT.MAX( 1, N ) ) THEN
         INFO = -5
      ELSE IF( LDB.LT.MAX( 1, N ) ) THEN
         INFO = -7
      END IF
      IF( INFO.NE.0 ) THEN
         CALL XERBLA( 'DPOTRS', -INFO )
         RETURN
      END IF

*
*     Quick return if possible
*
      IF( N.EQ.0 .OR. NRHS.EQ.0 )
     $   RETURN
*
      IF( UPPER ) THEN
*
*        Solve A*X = B where A = U'*U.
*

*        Solve U'*X = B, overwriting B with X.
*
         CALL DTRSM( 'Left', 'Upper', 'Transpose', 'Non-unit', N, NRHS,
     $               ONE, A, LDA, B, LDB )
*
*        Solve U*X = B, overwriting B with X.
*
         CALL DTRSM( 'Left', 'Upper', 'No transpose', 'Non-unit', N,
     $               NRHS, ONE, A, LDA, B, LDB )
      ELSE
*
*        Solve A*X = B where A = L*L'.
*
*        Solve L*X = B, overwriting B with X.
*
         CALL DTRSM( 'Left', 'Lower', 'No transpose', 'Non-unit', N,
     $               NRHS, ONE, A, LDA, B, LDB )
*
*        Solve L'*X = B, overwriting B with X.
*
         CALL DTRSM( 'Left', 'Lower', 'Transpose', 'Non-unit', N, NRHS,
     $               ONE, A, LDA, B, LDB )
      END IF
*
      RETURN
*
*     End of DPOTRS
*
      END
      SUBROUTINE DPOTF2( UPLO, N, A, LDA, INFO )
*
*  -- LAPACK routine (version 3.0) --
*     Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
*     Courant Institute, Argonne National Lab, and Rice University
*     February 29, 1992
*
*     .. Scalar Arguments ..

      CHARACTER          UPLO
      INTEGER            INFO, LDA, N
*     ..

*     .. Array Arguments ..
      DOUBLE PRECISION   A( LDA, * )
*     ..
*
*  Purpose
*  =======

*
*  DPOTF2 computes the Cholesky factorization of a real symmetric
*  positive definite matrix A.

*
*  The factorization has the form
*     A = U' * U ,  if UPLO = 'U', or
*     A = L  * L',  if UPLO = 'L',
*  where U is an upper triangular matrix and L is lower triangular.
*
*  This is the unblocked version of the algorithm, calling Level 2 BLAS.
*
*  Arguments


*  =========
*
*  UPLO    (input) CHARACTER*1
*          Specifies whether the upper or lower triangular part of the
*          symmetric matrix A is stored.
*          = 'U':  Upper triangular

*          = 'L':  Lower triangular
*
*  N       (input) INTEGER
*          The order of the matrix A.  N >= 0.
*
*  A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)


*          On entry, the symmetric matrix A.  If UPLO = 'U', the leading
*          n by n upper triangular part of A contains the upper
*          triangular part of the matrix A, and the strictly lower
*          triangular part of A is not referenced.  If UPLO = 'L', the
*          leading n by n lower triangular part of A contains the lower
*          triangular part of the matrix A, and the strictly upper
*          triangular part of A is not referenced.
*
*          On exit, if INFO = 0, the factor U or L from the Cholesky
*          factorization A = U'*U  or A = L*L'.
*
*  LDA     (input) INTEGER

*          The leading dimension of the array A.  LDA >= max(1,N).
*
*  INFO    (output) INTEGER
*          = 0: successful exit
*          < 0: if INFO = -k, the k-th argument had an illegal value
*          > 0: if INFO = k, the leading minor of order k is not
*               positive definite, and the factorization could not be
*               completed.
*

*  =====================================================================

*
*     .. Parameters ..
      DOUBLE PRECISION   ONE, ZERO
      PARAMETER          ( ONE = 1.0D+0, ZERO = 0.0D+0 )
*     ..
*     .. Local Scalars ..
      LOGICAL            UPPER
      INTEGER            J
      DOUBLE PRECISION   AJJ
*     ..
*     .. External Functions ..
      LOGICAL            LSAME

      DOUBLE PRECISION   DDOT
      EXTERNAL           LSAME, DDOT
*     ..
*     .. External Subroutines ..
      EXTERNAL           DGEMV, DSCAL, XERBLA
*     ..
*     .. Intrinsic Functions ..
      INTRINSIC          MAX, SQRT

*     ..
*     .. Executable Statements ..
*
*     Test the input parameters.
*
      INFO = 0
      UPPER = LSAME( UPLO, 'U' )

      IF( .NOT.UPPER .AND. .NOT.LSAME( UPLO, 'L' ) ) THEN
         INFO = -1
      ELSE IF( N.LT.0 ) THEN
         INFO = -2
      ELSE IF( LDA.LT.MAX( 1, N ) ) THEN
         INFO = -4
      END IF
      IF( INFO.NE.0 ) THEN
         CALL XERBLA( 'DPOTF2', -INFO )
         RETURN
      END IF
*
*     Quick return if possible
*
      IF( N.EQ.0 )
     $   RETURN
*
      IF( UPPER ) THEN
*
*        Compute the Cholesky factorization A = U'*U.
*
         DO 10 J = 1, N
*
*           Compute U(J,J) and test for non-positive-definiteness.
*
            AJJ = A( J, J ) - DDOT( J-1, A( 1, J ), 1, A( 1, J ), 1 )
            IF( AJJ.LE.ZERO ) THEN
               A( J, J ) = AJJ
               GO TO 30
            END IF
            AJJ = SQRT( AJJ )
            A( J, J ) = AJJ
*
*           Compute elements J+1:N of row J.
*
            IF( J.LT.N ) THEN
               CALL DGEMV( 'Transpose', J-1, N-J, -ONE, A( 1, J+1 ),
     $                     LDA, A( 1, J ), 1, ONE, A( J, J+1 ), LDA )
               CALL DSCAL( N-J, ONE / AJJ, A( J, J+1 ), LDA )
            END IF
   10    CONTINUE
      ELSE
*
*        Compute the Cholesky factorization A = L*L'.
*
         DO 20 J = 1, N
*
*           Compute L(J,J) and test for non-positive-definiteness.
*
            AJJ = A( J, J ) - DDOT( J-1, A( J, 1 ), LDA, A( J, 1 ),
     $            LDA )
            IF( AJJ.LE.ZERO ) THEN
               A( J, J ) = AJJ
               GO TO 30
            END IF
            AJJ = SQRT( AJJ )
            A( J, J ) = AJJ
*
*           Compute elements J+1:N of column J.
*
            IF( J.LT.N ) THEN
               CALL DGEMV( 'No transpose', N-J, J-1, -ONE, A( J+1, 1 ),
     $                     LDA, A( J, 1 ), LDA, ONE, A( J+1, J ), 1 )
               CALL DSCAL( N-J, ONE / AJJ, A( J+1, J ), 1 )
            END IF
   20    CONTINUE
      END IF
      GO TO 40
*
   30 CONTINUE
      INFO = J
*
   40 CONTINUE
      RETURN
*
*     End of DPOTF2
*
      END
      LOGICAL          FUNCTION LSAME( CA, CB )
*
*  -- LAPACK auxiliary routine (version 3.0) --
*     Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
*     Courant Institute, Argonne National Lab, and Rice University
*     September 30, 1994

*
*     .. Scalar Arguments ..
      CHARACTER          CA, CB
*     ..
*
*  Purpose
*  =======
*
*  LSAME returns .TRUE. if CA is the same letter as CB regardless of
*  case.
*
*  Arguments
*  =========
*
*  CA      (input) CHARACTER*1
*  CB      (input) CHARACTER*1
*          CA and CB specify the single characters to be compared.
*
* =====================================================================
*
*     .. Intrinsic Functions ..
      INTRINSIC          ICHAR
*     ..
*     .. Local Scalars ..
      INTEGER            INTA, INTB, ZCODE
*     ..
*     .. Executable Statements ..

*

*     Test if the characters are equal

*
      LSAME = CA.EQ.CB

      IF( LSAME )
     $   RETURN
*
*     Now test for equivalence if both characters are alphabetic.
*

      ZCODE = ICHAR( 'Z' )

*
*     Use 'Z' rather than 'A' so that ASCII can be detected on Prime
*     machines, on which ICHAR returns a value with bit 8 set.
*     ICHAR('A') on Prime machines returns 193 which is the same as
*     ICHAR('A') on an EBCDIC machine.
*
      INTA = ICHAR( CA )
      INTB = ICHAR( CB )
*
      IF( ZCODE.EQ.90 .OR. ZCODE.EQ.122 ) THEN
*
*        ASCII is assumed - ZCODE is the ASCII code of either lower or

*        upper case 'Z'.
*
         IF( INTA.GE.97 .AND. INTA.LE.122 ) INTA = INTA - 32
         IF( INTB.GE.97 .AND. INTB.LE.122 ) INTB = INTB - 32
*
      ELSE IF( ZCODE.EQ.233 .OR. ZCODE.EQ.169 ) THEN
*
*        EBCDIC is assumed - ZCODE is the EBCDIC code of either lower or
*        upper case 'Z'.

*
         IF( INTA.GE.129 .AND. INTA.LE.137 .OR.
     $       INTA.GE.145 .AND. INTA.LE.153 .OR.
     $       INTA.GE.162 .AND. INTA.LE.169 ) INTA = INTA + 64
         IF( INTB.GE.129 .AND. INTB.LE.137 .OR.
     $       INTB.GE.145 .AND. INTB.LE.153 .OR.
     $       INTB.GE.162 .AND. INTB.LE.169 ) INTB = INTB + 64

*
      ELSE IF( ZCODE.EQ.218 .OR. ZCODE.EQ.250 ) THEN
*
*        ASCII is assumed, on Prime machines - ZCODE is the ASCII code
*        plus 128 of either lower or upper case 'Z'.
*
         IF( INTA.GE.225 .AND. INTA.LE.250 ) INTA = INTA - 32
         IF( INTB.GE.225 .AND. INTB.LE.250 ) INTB = INTB - 32
      END IF
      LSAME = INTA.EQ.INTB
*
*     RETURN
*

*     End of LSAME
*
      END
      SUBROUTINE XERBLA( SRNAME, INFO )
*
*  -- LAPACK auxiliary routine (preliminary version) --


*     Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd.,
*     Courant Institute, Argonne National Lab, and Rice University
*     February 29, 1992
*
*     .. Scalar Arguments ..
      CHARACTER*6        SRNAME,ERRFIL*20
      INTEGER            INFO
      COMMON/ERR/ERRFIL 

*     ..


*
*  Purpose
*  =======
*
*  XERBLA  is an error handler for the LAPACK routines.
*  It is called by an LAPACK routine if an input parameter has an
*  invalid value.  A message is printed and execution stops.
*
*  Installers may consider modifying the STOP statement in order to
*  call system-specific exception-handling facilities.
*
*  Arguments
*  =========
*
*  SRNAME  (input) CHARACTER*6
*          The name of the routine which called XERBLA.

*
*  INFO    (input) INTEGER
*          The position of the invalid parameter in the parameter list
*          of the calling routine.
*
*
      WRITE( *, FMT = 9999 )SRNAME, INFO

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
      WRITE( 42, FMT = 9999 )SRNAME, INFO
        CLOSE(42)

      CALL PAUSE
      STOP

 9999 FORMAT( ' ** On entry to ', A6, ' parameter number ', I2, ' had ',
     $      'an illegal value' )
*
*     End of XERBLA
*
      END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
	SUBROUTINE GETIPATF(IFILE,NSUBTOT,NSUB,IPATVEC,IERRR,ERRFIL)

	DIMENSION IPATVEC(9999)
	CHARACTER READLINE*300,ERRFIL*20

C  SUBROUTINE GETIPATF IS CALLED BY MAIN TO OBTAIN THE INDICES OF
C  THE "ACTIVE" SUBJECTS, IPATVEC(I),I=1,NSUB, FOR THIS RUN. THESE
C  INDICES ARE OBTAINED FROM FILE IFILE.

    3   FORMAT(A300)

	NSUBB = 0
	NUMCUR = 0


C  NSUBB WILL BE THE NO. OF SUBJECTS SELECTED BY THE USER. IT IS 
C  INITIALIZED AS 0, AND WILL GROW AS EACH LINE OF THE FILE IS READ.

C  NUMCUR IS THE INDEX OF THE HIGHEST PATIENT NO. ENTERED SO FAR.

C  NOTE THAT EACH LINE CONTAINS EITHER A SUBJECT NO. OR A RANGE OF 
C  SUBJECT NOS. TO BE INCLUDED IN THE ANALYSIS. MULTIPLE SUBJECTS
C  CAN BE ENTERED USING COMMAS, SPACES AND/OR HYPHENS. FOR EXAMPLE,
C  2, 17 - 28 INDICATES SUBJECTS 2 AND 17 THROUGH 28; 
C  17,28 INDICATES SUBJECTS 17 AND 28;
C  17 28 INDICATES SUBJECTS 17 AND 28. 


C  RESTRICTIONS: 1. ON EACH LINE, USE NO MORE THAN 70 CHARACTERS;
C                2. PATIENT NOS., OR RANGES OF PATIENT NOS.

C                   MUST BE LISTED IN ASCENDING ORDER.

C  A LINE WITH JUST A 0 --> END OF THE LIST OF SUBJECT NOS.


 4210	IF(IFILE .EQ. 23) READ(23,3,ERR=4200) READLINE
	IF(IFILE .EQ. 25) READ(25,3,ERR=4200) READLINE

C  CALL SUBROUTINE GETNUMSF TO UPDATE NSUBB AND IPATVEC, WHERE IPATVEC
C  IS THE VECTOR WHICH CONTAINS THE PATIENT NOS. TO BE INCLUDED IN THE 
C  ANALYSIS.

C  NOTE THAT ISTOP RETURNS AS 0 TO INDICATE THE END OF THE LIST OF
C  PATIENT NOS; IT RETURNS AS -1 IF THERE IS A CONFLICT IN THE LIST
C  (SEE RESTRICTION ABOVE) OR A PATIENT NO. LARGER THAN NSUBTOT 
C  (THE MAXIMUM ALLOWABLE NO. OF SUBJECTS) HAS BEEN READ IN; AND IT 

C  RETURNS AS 1 IF THERE ARE MORE LINES TO BE READ IN.

	CALL GETNUMSF(1,READLINE,NSUBB,NSUBTOT,NUMCUR,ISTOP,IPATVEC)
	IF(ISTOP .EQ. -1) GO TO 4200
	IF(ISTOP .EQ. 1) GO TO 4210

C  TO GET TO THIS POINT, ISTOP = 0 --> USER HAS STOPPED ENTERING
C  PATIENT NOS.

C  CHECK THAT NSUB, AS INPUT TO THIS ROUTINE (FROM MAIN) IS THE SAME
C  AS NSUBB, AS OBTAINED FROM THE LIST OF SUBJECTS TO BE INCLUDED IN
C  THE ANALYSIS. IF NOT, TELL USER AND RETURN IERRR = -1 SO THE USER
C  CAN MAKE A CORRECTION.

	IF(NSUB .EQ. NSUBB) THEN
	 IERRR = 0
	 RETURN
	ENDIF

	IF(NSUB .NE. NSUBB) THEN

         WRITE(*,2)

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,2) 
        CLOSE(42)

    2   FORMAT(//' THERE WAS AN ERROR IN THE READING OF PATIENT NOS.'/
     1' TO BE USED FOR THIS ANALYSIS. IN PARTICULAR, THE NO. OF '/
     2' SUBJECTS TO BE INCLUDED IN THE ANALYSIS, AS ENTERED IN THE'/
     3' INSTRUCTION FILE, DOES NOT MATCH THE LIST OF SUBJECT NOS.'/
     4' WHICH FOLLOW THAT NUMBER. PLEASE RERUN THE PC PREP PROGRAM'/
     2' TO MAKE SURE THESE PATIENT NOS. ARE WRITTEN CORRECTLY INTO'/
     3' THE INSTRUCTION FILE. ')
	IERRR = -1
	 RETURN
	ENDIF

 4200   WRITE(*,1)

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,1)
        CLOSE(42)

    1   FORMAT(//' THERE WAS AN ERROR IN THE READING OF PATIENT NOS.'/
     1' TO BE USED FOR THIS ANALYSIS. PLEASE RERUN THE PC PREP PROGRAM'/
     2' TO MAKE SURE THESE PATIENT NOS. ARE WRITTEN CORRECTLY INTO'/
     3' THE INSTRUCTION FILE. ')
	IERRR = -1


	RETURN
	END
C

CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

C
	SUBROUTINE GETNUMSF(IINCLUDE,READLINE,NSUBB,NSUBTOT,NUMCUR,
     1    ISTOP,IPATVECC)

	DIMENSION IPATVECC(9999)
	CHARACTER READLINE*300

C  SUBROUTINE GETNUMSF IS CALLED BY GETIPATF (OVER AND OVER) 
C  TO ESTABLISH NSUBB AND IPATVECC, WHERE NSUBB IS THE NO. OF SUBJECTS 
C  TO BE INCLUDED (IF IINCLUDE = 1) OR EXCLUDED (IF IINCLUDE = 2) IN THE 

C  ANALYSIS, AND IPATVECC IS THE VECTOR WHICH CONTAINS THE CORRESPONDING 
C  PATIENT NOS. EACH CALL TO GETNUMSF EITHER ADDS TO THE VALUES IN 
C  IPATVECC (AND INCREASES NSUBB) OR STOPS THE PROCESS.

C  NOTE THAT GETNUMSF IS THE SAME AS GETNUMS EXCEPT THAT THE COMMENTS
C  TO THE USER ARE DIFFERENT SINCE THIS ROUTINE IS CALLED BY GETIPATF
C  WHICH IS READING A FILE, RATHER THAN KEYBOARD ENTRIES.

C  NOTE THAT ISTOP RETURNS AS 0 IF THE USER IS FINISHED ENTERING 
C  PATIENT NOS; IT RETURNS AS -1 IF THE USER HAS ENTERED A CONFLICTING 
C  SET OF PATIENT NOS. (EACH PATIENT NO. OR RANGE OF NUMBERS MUST BE
C  GREATER THAN ANY PATIENT NO. ALREADY ENTERED ... THE LARGEST PATIENT 
C  NO. ENTERED SO FAR IS NUMCUR) OR A PATIENT NO. LARGER THAN NSUBTOT 
C  (THE MAXIMUM ALLOWABLE NO. OF SUBJECTS); AND IT RETURNS AS 1 IF THE 
C  USER HAS CORRECTLY ENTERED PATIENT DATA AND WANTS TO CONTINUE 
C  ENTERING OTHER NOS.

	ISTOP = 1

C  CHECK TO SEE IF THIS IS A BLANK LINE. IF SO, RETURN ISTOP = -1 
C  WITH A MESSAGE TO THE USER.

	DO J = 1,70
	 IF(READLINE(J:J) .NE. ' ') GO TO 10
	END DO

C  TO GET HERE --> READLINE IS COMPLETELY BLANK.

	IF(NSUBB .EQ. 0) WRITE(*,1)
    1   FORMAT(/' THE INSTRUCTION FILE HAS AN IMPROPER BLANK LINE IN '/


     1' THE PATIENT NUMBER SECTION. ')

	ISTOP = -1
	RETURN
	  


   10   CONTINUE

C  CHECK TO SEE IF THIS LINE HAS JUST A 0 ON IT. IF SO, RETURN ISTOP
C  = 0, UNLESS NSUBB = 0 AND IINCLUDE = 1, IN WHICH CASE THIS IS AN 
C  ERROR. SIMPLY CHECK THE FIRST NON-BLANK CHARACTER (THERE MUST BE ONE 
C  SINCE IF THE LINE IS COMPLETELY BLANK, THE CODE ABOVE ABOVE WOULD 
C  HAVE DETECTED IT AND RETURNED CONTROL TO THE CALLING ROUTINE) AND 
C  SEE IF a. IT IS A 0, AND b. EVERY OTHER CHARACTER IS A BLANK. IF
C  a. AND b. ARE TRUE, THE LINE JUST HAS A 0 IN IT. OTHERWISE NOT.

	DO J = 1,70
	 IF(READLINE(J:J) .NE. ' ') GO TO 20
	END DO

   20   ISTART = J
	IF(READLINE(ISTART:ISTART) .NE. '0') GO TO 30

	DO I = ISTART+1,70
	 IF(READLINE(I:I) .NE. ' ') GO TO 30
	END DO
	
C  TO GET HERE --> READLINE HAS JUST A 0 ON IT AND NOTHING ELSE.

C  IF THE USER HAS ENTERED A 0 WITH NSUBB = 0 (I.E., HE HAS NOT 
C  ENTERED PREVIOUS SUBJECT NOS.), THIS IS OK IF IINCLUDE = 2 (SINCE
C  IT IS OK TO EXCLUDE 0 PATIENTS), BUT IT IS NOT OK IF IINCLUDE = 1
C  (SINCE THIS WOULD MEAN THE ANALYSIS WOULD BE ON 0 SUBJECTS).

	IF(IINCLUDE .EQ. 1 .AND. NSUBB .EQ. 0) THEN
	 WRITE(*,3)
    3    FORMAT(/' THE INSTRUCTION FILE HAS AN IMPROPER LINE - WITH'/
     1' JUST A "0" ON IT - IN THE PATIENT NUMBER SECTION.')
	 ISTOP = -1
	 RETURN
	ENDIF


	IF(IINCLUDE .EQ. 2 .OR. NSUBB .GT. 0) THEN
	 ISTOP = 0
	 RETURN
	ENDIF


   30   CONTINUE


C  TO GET TO THIS POINT MEANS READLINE HAS A POTENTIAL NO. BEGINNING
C  AT ENTRY ISTART. IF THIS IS A LEGITIMATE NO., IT ENDS THE ENTRY
C  BEFORE THE NEXT SPACE, COMMA, DASH, WHICHEVER COMES FIRST.

     	DO I = ISTART+1,70
	 IF(READLINE(I:I) .EQ. ' ' .OR. READLINE(I:I) .EQ. ',' .OR.
     1      READLINE(I:I) .EQ. '-') GO TO 40
	END DO


   40   IEND = I-1

C  CALL ROUTINE GETSUB WHICH OBTAINS THE SUBJECT NO. FROM THE 
C  CHARACTERS IN READLINE(ISTART:IEND).

	CALL GETSUB(READLINE,ISTART,IEND,ISUB,IERROR)

C  IF IERROR RETURNS AS -1, IT MEANS THE USER HAS ENTERED A NON-NUMERIC
C  CHARACTER. IN THIS CASE, PRINT AN ERROR MESSAGE AND RETURN.


	IF(IERROR .EQ. -1) THEN
	 WRITE(*,7) 
    7    FORMAT(/' THE INSTRUCTION FILE HAS AN IMPROPER LINE - WITH'/

     1' AN INVALID CHARACTER ON IT - IN THE PATIENT NUMBER SECTION.')
	 ISTOP = -1
	 RETURN
	ENDIF

C  IF ISUB IS .LE. NUMCUR, THE LAST (AND HIGHEST PATIENT NO. ENTERED
C  PREVIOUSLY), WRITE AN ERROR MESSAGE TO THE USER AND RETURN. 
C  SIMILARLY, IF ISUB .GE. NSUBTOT.
    
	IF(ISUB .LE. NUMCUR) THEN
	 WRITE(*,4) ISUB,NUMCUR
    4    FORMAT(/' THE INSTRUCTION FILE HAS AN IMPROPER LINE IN IT'/
     1' IN THE PATIENT NUMBER SECTION.'//
     2' IT HAS A SUBJECT NO. (',I4,' ) WHICH IS LESS THAN OR EQUAL TO '/
     3' A PREVIOUSLY ENTERED SUBJECT NO. (',I4,').')
	 ISTOP = -1

	 RETURN
	ENDIF

	IF(ISUB .GT. NSUBTOT) THEN
	 WRITE(*,6) ISUB,NSUBTOT
    6    FORMAT(/' THE INSTRUCTION FILE HAS AN IMPROPER LINE IN IT'/
     1' IN THE PATIENT NUMBER SECTION.'//
     2' IT HAS A SUBJECT NO. (',I4,' ) WHICH IS GREATER THAN THE NO.'/
     3' OF SUBJECTS IN YOUR DATA FILE (',I4,').')
	 ISTOP = -1
	 RETURN
	ENDIF

C  TO GET TO THIS POINT, THE PATIENT NO., ISUB, IS LEGITIMATE. I.E.,
C  IT IS .GT. NUMCUR AND .LE. NSUBTOT. THERE ARE 4 POSSIBILITIES:

C  1. IF THERE ARE NO OTHER ENTRIES IN READLINE PAST THIS POINT,
C  ISUB IS A SINGLE PATIENT NO.
C  2. IF THE NEXT NON-BLANK ENTRY IN READLINE IS A COMMA OR ANOTHER
C  NUMBER, ISUB IS A SINGLE PATIENT NO.
C  3. IF THE NEXT NON-BLANK ENTRY IN READLINE IS A DASH, ISUB IS THE
C  START OF A PATIENT RANGE.
C  4. IF THE NEXT NON-BLANK ENTRY IN READLINE IS ANOTHER CHARACTER
C  (I.E., NOT A NUMBER, DASH, OR COMMA), THE LINE HAS BEEN ENTERED
C  INCORRECTLY BY THE USER.



C  CHECK FOR NO. 1. ABOVE ...

	DO I = IEND+1,70

	 IF(READLINE(I:I) .NE. ' ') GO TO 50
	END DO

C  TO GET TO THIS POINT, ISUB IS AN INDIVIDUAL SUBJECT NO., AND THE
C  LAST NO. ON THE LINE. INCREASE NSUBB, NUMCUR, AND PUT THIS SUBJECT
C  NO. INTO IPATVECC BEFORE RETURNING.

	NUMCUR = ISUB
	NSUBB = NSUBB + 1
	IPATVECC(NSUBB) = ISUB
	RETURN


   50   CONTINUE

C  CHECK FOR NOS. 2,3, OR 4 (SEE ABOVE).

C  TO GET TO THIS POINT, THERE IS AT LEAST ONE CHARACTER ENTRY AFTER 

C  ISUB, AND THE FIRST OCCURS AT LOCATION I. IF THIS CHARACTER IS A

C  COMMA THEN ISUB IS AN INDIVIDUAL SUBJECT NO. 

	IF(READLINE(I:I) .EQ. ',') THEN

	 NUMCUR = ISUB
 	 NSUBB = NSUBB + 1

	 IPATVECC(NSUBB) = ISUB

C  CHECK TO SEE IF THERE IS ANOTHER ENTRY ON THIS LINE. IF SO,
C  RETURN CONTROL TO LABEL 30 AND CONTINUE CHECKING FOR OTHER NOS. IF 
C  NOT, IT MEANS THE USER HAS ENDED THE LINE WITH A COMMA ... WHICH 
C  IS ASSUMED TO BE SUPERFLOUS.

	 DO J = I+1,70
	  IF(READLINE(J:J) .NE. ' ') GO TO 60
	 END DO



	 RETURN

   60    ISTART = J
	 GO TO 30	

	ENDIF



C  TO GET TO THIS POINT, THERE IS AT LEAST ONE CHARACTER ENTRY AFTER 
C  ISUB, AND THE FIRST OCCURS AT LOCATION I ... AND THIS ENTRY IS NOT
C  A COMMA. CHECK TO SEE IF IT IS ANOTHER NUMBER. IN THIS CASE, ISUB
C  IS AN INDIVIDUAL SUBJECT NO. 

	INUM = 0
	IF(READLINE(I:I) .EQ. '0') INUM = 1
	IF(READLINE(I:I) .EQ. '1') INUM = 1
	IF(READLINE(I:I) .EQ. '2') INUM = 1
	IF(READLINE(I:I) .EQ. '3') INUM = 1
	IF(READLINE(I:I) .EQ. '4') INUM = 1
	IF(READLINE(I:I) .EQ. '5') INUM = 1
	IF(READLINE(I:I) .EQ. '6') INUM = 1
	IF(READLINE(I:I) .EQ. '7') INUM = 1
	IF(READLINE(I:I) .EQ. '8') INUM = 1
	IF(READLINE(I:I) .EQ. '9') INUM = 1

	IF(INUM .EQ. 1) THEN
	 NUMCUR = ISUB
 	 NSUBB = NSUBB + 1
	 IPATVECC(NSUBB) = ISUB

C  RETURN CONTROL TO LABEL 30 AND CONTINUE CHECKING FOR OTHER NOS.
C  STARTING WITH LOCATION I.

         ISTART = I
	 GO TO 30	

	ENDIF


C  TO GET TO THIS POINT, THERE IS AT LEAST ONE CHARACTER ENTRY AFTER 
C  ISUB, AND THE FIRST OCCURS AT LOCATION I ... AND THIS ENTRY IS NOT
C  A COMMA OR A NUMBER. CHECK TO SEE IF IT IS A DASH. IN THIS CASE,
C  ISUB IS THE FIRST NO. IN A RANGE OF PATIENT NUMBERS.


	IF(READLINE(I:I) .EQ. '-') THEN

C  STORE ISUB INTO NUMCUR1, BUT NOT NUMCUR. IN CASE THE USER

C  HAS NOT ENTERED A LEGITIMATE NO. AFTER THE DASH, KEEP THE PREVIOUS
C  VALUE OF NUMCUR (THE LAST PATIENT INDEX PUT INTO IPATVECC) INTACT.

	 NUMCUR1 = ISUB

C  READ UNTIL THE NEXT NON-BLANK CHARACTER, WHICH SHOULD BE THE 
C  BEGINNING OF THE NUMBER WHICH ENDS THE RANGE.


	 DO J = I+1,70
	  IF(READLINE(J:J) .NE. ' ') GO TO 70

	 END DO


C  TO GET TO THIS POINT MEANS THE USER ENDED A LINE WITH A DASH, WHICH
C  IS NOT ALLOWED. WRITE AN ERROR MESSAGE AND RETURN.

	 WRITE(*,8) 

    8    FORMAT(/' THE INSTRUCTION FILE HAS AN IMPROPER LINE IN IT'/
     1' IN THE PATIENT NUMBER SECTION.'//
     2' A LINE HAS BEEN ENDED WITH A DASH.')
	 ISTOP = -1
	 RETURN

   70   ISTART = J

C  TO GET TO THIS POINT, THERE IS AN ENTRY IN LOCATION ISTART, WHICH
C  SHOULD BE THE BEGINNING OF THE ENDING PATIENT NO. OF A RANGE OF
C  PATIENT NOS. THIS NUMBER ENDS THE ENTRY BEFORE A SPACE OR A 
C  COMMA.


     	DO K = ISTART+1,70
	 IF(READLINE(K:K) .EQ. ' ' .OR. READLINE(K:K) .EQ. ',') 
     1    GO TO 80
	END DO

   80   IEND = K-1

C  CALL ROUTINE GETSUB WHICH OBTAINS THE SUBJECT NO. FROM THE 
C  CHARACTERS IN READLINE(ISTART:IEND).


	CALL GETSUB(READLINE,ISTART,IEND,ISUB,IERROR)



C  IF IERROR RETURNS AS -1, IT MEANS THE USER HAS ENTERED A NON-NUMERIC

C  CHARACTER. IN THIS CASE, PRINT AN ERROR MESSAGE AND RETURN.

	IF(IERROR .EQ. -1) THEN
	 WRITE(*,7) 
	 ISTOP = -1
	 RETURN
	ENDIF

C  IF ISUB IS .LE. NUMCUR1 (THE BEGINNING NO. IN THIS RANGE), WRITE AN 
C  ERROR MESSAGE TO THE USER AND RETURN. SIMILARLY, IF ISUB .GE. 
C  NSUBTOT
    
	IF(ISUB .LE. NUMCUR1) THEN
	 WRITE(*,9)
    9    FORMAT(/' THE INSTRUCTION FILE HAS AN IMPROPER LINE IN IT'/
     1' IN THE PATIENT NUMBER SECTION.'//
     2' IT HAS A RANGE OF SUBJECT NOS. WITH THE ENDING NO. LESS THAN '/
     3' OR EQUAL TO THE BEGINNING NO.')
	 ISTOP = -1
	 RETURN
	ENDIF


	IF(ISUB .GT. NSUBTOT) THEN
	 WRITE(*,6) ISUB,NSUBTOT
	 ISTOP = -1

	 RETURN
	ENDIF



C  TO GET TO THIS POINT MEANS THE USER HAS CORRECTLY ENTERED A RANGE
C  OF PATIENT NOS. FROM NUMCUR1 TO ISUB. UPDATE NSUBB, NUMCUR, AND
C  IPATVECC.

	 NUMCUR = ISUB
	 NN = NSUBB
 	 NSUBB = NSUBB + (NUMCUR - NUMCUR1) + 1

	 NONEW = 0
	 DO K = NN+1,NSUBB
	  NONEW = NONEW + 1
	  IPATVECC(K) = NUMCUR1 - 1 + NONEW
	 END DO

C  CHECK TO SEE IF THERE IS ANOTHER CHARACTER ON THE LINE AFTER
C  LOCATION IEND (IGNORE A COMMA AT THIS POINT, SINCE IT IS POSSIBLE
C  THAT THE USER HAS PUT IN A COMMA AT THE END OF HIS SUBJECT RANGE). 
C  IF SO, RETURN CONTROL TO LABEL 30 AND CONTINUE CHECKING FOR OTHER 
C  NOS. IF NOT, RETURN.

	 DO J = IEND+1,70
	  IF(READLINE(J:J) .NE. ' ' .AND. READLINE(J:J) .NE. ',' ) 
     1    GO TO 90
	 END DO

	 RETURN

   90    ISTART = J
	 GO TO 30	

	ENDIF

C  THE ABOVE ENDIF IS FOR THE  IF(READLINE(I:I) .EQ. '-')  CONDITION.


C  TO GET TO THIS POINT, THERE IS AT LEAST ONE CHARACTER ENTRY AFTER 
C  ISUB, AND THE FIRST OCCURS AT LOCATION I ... AND THIS ENTRY IS NOT
C  A COMMA, A NUMBER, OR A DASH, WHICH MEANS IT IS AN ERRONEOUS ENTRY.
C  WRITE AN ERROR MESSAGE TO THE USER AND RETURN.

	WRITE(*,7) 
	ISTOP = -1



	RETURN
	END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
	SUBROUTINE WRITEPT2(IFILE,NSUB,IPATVEC)
	DIMENSION IPATVEC(9999)

C  THIS ROUTINE WRITES THE PATIENT NOS. TO FILE IFILE.

C  INSTEAD OF WRITING OUT THE PATIENT NOS. ONE TO A LINE, WRITE OUT
C  CONTINUOUS SETS ON EACH LINE. E.G., IF SUBJECTS 1,4,5,6,9,10,12 ARE
C  TO BE WRITTEN OUT, WRITE 1 ON THE 1ST LINE, 4 - 6 ON THE 2ND LINE,

C  9 - 10 OR THE 3RD LINE, AND 12 ON THE 4TH.

C  NEXTIND IS THE INDEX OF THE NEXT SUBJECT NO. TO BE WRITTEN.

	NEXTIND = 0

   50   NEXTIND = NEXTIND + 1

C  IF NEXTIND .GT. NSUB, THE NOS. HAVE ALL BEEN WRITTEN OUT, SO STOP 
C  THE WRITING.

	IF(NEXTIND .GT. NSUB) GO TO 100

C  ESTABLISH THE NOS. TO BE WRITTEN ON THE NEXT LINE. THE FIRST NO.
C  WILL BE IPATVEC(NEXTIND)

	IFIRST = IPATVEC(NEXTIND)

C  IF NEXTIND = NSUB, THIS IS THE LAST PATIENT NO. TO BE WRITTEN OUT.

	IF(NEXTIND .EQ. NSUB) THEN
	 IF(IFILE .EQ. 25) WRITE(25,222) IFIRST
	 IF(IFILE .EQ. 29) WRITE(29,222) IFIRST

  222    FORMAT(1X,I5)
	 GO TO 100	
	ENDIF


C  IF THE NEXT PATIENT NO. IN IPATVEC = IFIRST + 1, THEN IFIRST IS THE
C  FIRST OF A STRING OF CONSECUTIVE NUMBERS (FIND THE LAST NO. IN THIS 
C  STRING AND WRITE THE STRING OUT). OTHERWISE, IFIRST WILL BE WRITTEN 
C  OUT BY ITSELF.

	IF(IPATVEC(NEXTIND+1) .NE. IFIRST + 1) THEN
	 IF(IFILE .EQ. 25) WRITE(25,222) IFIRST
	 IF(IFILE .EQ. 29) WRITE(29,222) IFIRST
	 GO TO 50
	ENDIF

C  SET ILAST = THE LAST NO. IN THE STRING USING THE FOLLOWING DO LOOP.

	ILAST = IPATVEC(NEXTIND+1)
	NEXT = NEXTIND+1


	DO I = NEXTIND+2,NSUB
	 IF(IPATVEC(I) .NE. ILAST + 1) GO TO 80
	 ILAST = IPATVEC(I)
	 NEXT = I
	END DO



   80	IF(IFILE .EQ. 25) WRITE(25,221) IFIRST,ILAST
   	IF(IFILE .EQ. 29) WRITE(29,221) IFIRST,ILAST
  221   FORMAT(1X,I5,'   - ',I5)


C  THE INDEX OF THE LAST NO. WRITTEN OUT IS NEXT.
	

	NEXTIND = NEXT

	GO TO 50

  100   RETURN
	END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
	SUBROUTINE GETSUB(READLINE,ISTART,IEND,ISUB,IERROR)

	CHARACTER READLINE*300

C  THIS ROUTINE, CALLED BY GETNUMSF, OBTAINS THE SUBJECT NO., ISUB, 
C  FROM THE CHARACTERS IN READLINE(ISTART:IEND).

    3   FORMAT(A300)

	IERROR = 0
  	ISIZE = IEND-ISTART

	ISUB = 0
	 DO K=ISTART,IEND
	  IVAL = -9

	  IF(READLINE(K:K) .EQ. '0') IVAL = 0
	  IF(READLINE(K:K) .EQ. '1') IVAL = 1
	  IF(READLINE(K:K) .EQ. '2') IVAL = 2
	  IF(READLINE(K:K) .EQ. '3') IVAL = 3
	  IF(READLINE(K:K) .EQ. '4') IVAL = 4
	  IF(READLINE(K:K) .EQ. '5') IVAL = 5
	  IF(READLINE(K:K) .EQ. '6') IVAL = 6
	  IF(READLINE(K:K) .EQ. '7') IVAL = 7
	  IF(READLINE(K:K) .EQ. '8') IVAL = 8
	  IF(READLINE(K:K) .EQ. '9') IVAL = 9

	  IF(IVAL .EQ. -9) THEN
	   IERROR = -1
	   RETURN
	  ENDIF

	  ISUB = ISUB + IVAL*10**ISIZE
	  ISIZE = ISIZE-1

	 END DO

	RETURN
	END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
      SUBROUTINE CALCTPRED(JSUB,IDELTA,NOBSER,NUMTSUB,TPRED,TPREDREL,
     1   NOMAXTIMS,TEND,TBEGG)

	IMPLICIT REAL*8(A-H,O-Z)

      PARAMETER(MAXNUMEQ=7)
C  NOTE THAT AS OF CALCTPRED, MAXNUMEQ IS SET IN A PARAMETER STMT.
C  HERE SO THAT YOO CAN BE VARIABLY DIMENSIONED BELOW.

      DIMENSION TPRED(71281),TEND(99),TIM(594),SIG(5000),RS(5000,34),
     1  BS(5000,7),YOO(594,MAXNUMEQ),TBEGG(99),TPREDREL(71281)

        COMMON/OBSER/ TIM,SIG,RS,YOO,BS
        COMMON/CNST/ N,ND,NI,NUP,NUIC,NP

C  AS OF npageng16.f, COMMON/OBSER AND COMMON/CNST ARE INCLUDED IN
C  THIS ROUTINE SINCE ND AND SIG ARE NEEDED. NOTE THAT TIM IS NOW
C  ALSO PROVIDED VIA COMMON/OBSER, RATHER THAN AS THE ARGUMENT,
C  TIMOBB.


C  THIS ROUTINE IS CALLED BY MAIN TO CALCULATE THE NUMTSUB TIMES TO BE 
C  PUT INTO TPRED, FROM THE NOBSER TIMES IN TIM. THESE NOBSER TIMES
C  IN TIM ARE THE OBSERVED VALUE TIMES FROM A SUBJECT. THE TIMES
C  IN TPRED ARE TO START AT 0, AND CONTINUE UNTIL 24 HOURS AFTER THE
C  LAST TIME BEFORE EACH TIME RESET (EACH TIME OF 0 AFTER THE FIRST 
C  TIME IS A TIME RESET).

C  AS OF npageng16.f, FOR EACH STEADY STATE DOSE SET, TIMES IN TPRED
C  WILL START AT THE END OF IT, RATHER THAN AT 0 ... EXCEPT IF THE
C  STEADY STATE DOSE OCCURS AFTER THE BEGINNING OF THE SUBJECT FILE,
C  ONE TPRED TIME WILL BE SET = 0 SO THE PROGRAM WILL RECOGNIZE THAT
C  THIS IS ALSO THE BEGINNING OF A TIME RESET.

C  FOR EXAMPLE, IF THERE IS A STEADY STATE DOSE SET WITH INTERDOSE
C  INTERVAL = DOSEINT, THEN THE TIMES WILL START AT 100*DOSEINT
C  (SINCE EACH STEADY STATE DOSE SET IS ASSUMED TO HAVE 100 DOSES PLUS
C  ONE ADDITIONAL STARTING DOSE).
C  AS A SPECIFIC EXAMPLE, IF A STEADY STATE DOSE SET WITH INTERDOSE
C  INTERVAL OF 2 HOURS STARTS AT TIME 0 AND THE 1ST OBS. TIME IS AT
C  205, IT REALLY MEANS THAT THE OBSERVATIONS START 5 HOURS AFTER THE
C  END OF THE STEADY STATE DOSE SET. IN THIS CASE, THE TIMES IN TPRED
C  STILL START AT 200. 

C  BUT, AS OF npageng18.f, ALSO ESTABLISH TPREDREL(.) WHICH IS SIMILAR
C  TO TPRED, BUT HAS "RELATIVE" INSTEAD OF "REAL" TIMES AFTER STEADY
C  STATE DOSES. IN THE EXAMPLE ABOVE WITH AN INTERDOSE INTERVAL OF 2 
C  HOURS, THE TPRED(.) VALUES START AT 200 AND THE TPREDREL(.) VALUES
C  START AT 0. AND EACH TPREDREL(I) = TPRED(I) - 200.


C  SET IDOSE = 1; IT WILL BE THE RUNNING DOSE NUMBER. IT MUST BE
C  CHECKED TO SEE WHERE, IF AT ALL, THERE ARE STEADY STATE DOSE SETS.

      IDOSE = 1


C  NOTE THAT THE TIMES ARE TO BE IDELTA MINUTES APART, SUBJECT TO
C  THE CONSTRAINT THAT THE MAXIMUM NO. OF TIMES BE 7200.
C  BUT NOTE BELOW THAT THE TIMES IN TPRED ARE IN HOURS, NOT MINUTES.

C  NOMAXTIMS = NO. OF MAXIMUM TIMES FOR THIS SUBJECT (WHICH EQUALS 
C  1 MORE THAN THE NO. OF TIME RESETS).
C  NUMTSUB WILL BE THE RUNNING NO. OF TIMES ALREADY PUT INTO TPRED.
C  INDEX IS THE RUNNING INDEX OF TIMES ALREADY CONSIDERED IN TIM.
C  TIMMAX IS THE CURRENT MAXIMUM TIME THROUGH TIM(INDEX) SINCE
C  THE LAST TIME RESET VALUE OF 0.

	NOMAXTIMS = 0
	NUMTSUB = 0
	INDEX = 0	

   50	TIMMAX = -1.D30

   10 INDEX = INDEX + 1

	IF(TIM(INDEX) .GT. TIMMAX) TIMMAX = TIM(INDEX)
	IF(TIM(INDEX) .LE. 0.D0 .AND. INDEX .GT. 1) GO TO 20

C  ADDED ADDITIONAL REQUIREMENT ABOVE, 'INDEX .GT. 1' IN bigmlt8.f.
C  REASON IS THAT, OTHERWISE, AN INITIAL OBS. TIME OF 0 WILL LOOK
C  LIKE A TIME RESET TO THE PROGRAM AND CAUSE AN EXTRA AUC TABLE IN
C  THE OUTPUT FILE.


	IF(INDEX .EQ. NOBSER) GO TO 20

	GO TO 10

   20   CONTINUE 

C  TO GET HERE MEANS TIMMAX IS THE MAXIMUM OBSERVATION TIME BEFORE A
C  TIME RESET, OR IT IS SIMPLY THE MAXIMUM OBSERVATION TIME IF THERE
C  ARE NO TIME RESETS. ESTABLISH THE APPROPRIATE TIMES IN TPRED FROM 0 
C  TO T_END = TIMMAX + 24. SIMILARLY ESTABLISH THE TIMES IN TPREDREL.


C  !!! AS OF npageng16.f, TPRED VALUES WILL START AT 0 UNLESS THE
C  CORRESPONDING DOSES FOR THIS TIME BLOCK START WITH A STEADY STATE
C  SET. IN THAT CASE, THE TPRED VALUES WILL START FROM THE END OF THE
C  STEADY STATE SET. THE STARTING DOSE TIME IS IN SIG(IDOSE). IF

C  THIS VALUE IS < 0, IT REPRESENTS THE START OF A STEADY STATE DOSE
C  SET, WITH INTERDOSE INTERVAL = -SIG(IDOSE). IF THIS VALUE IS .GE. 0,
C  IT DOES NOT REPRESENT THE BEGINNING OF A STEADY STATE DOSE SET.

C  NOTE THAT, AS INDICATED ABOVE, THE TPREDREL VALUES WILL ALWAYS START
C  AT 0.
  
      TBEG = 0.D0
      IF(SIG(IDOSE) .LT. 0.D0) TBEG = 100.D0*(-SIG(IDOSE))


C  NOTE THAT NUMTSUB TIMES HAVE ALREADY BEEN STORED IN TPRED. PUT IN
C  THE NEXT SET.


	T_END = TIMMAX + 24.D0

	NUMT2 = (T_END - TBEG)*60/IDELTA

	NUMTSUB = NUMTSUB + 1

C  IF TBEG > 0, IT MEANS THERE IS A STEADY STATE DOSE SET OCCURRING.
C  IF THIS IS NOT AT THE BEGINNING OF THE SUBJECT FILE (I.E., IF 
C  NUMTSUB > 1), THEN ONE PREDICTED VALUE MUST BE SET = 0 (SO
C  SUBROUTINE FUNC3 IN idm3x_.7 WILL KNOW THIS IS ALSO THE BEGINNING OF
C  A TIME RESET), BUT THE REST WILL START AT TBEG.

      IF(TBEG .GT. 0.D0 .AND. NUMTSUB .GT. 1) THEN
       TPRED(NUMTSUB) = 0.D0
       TPREDREL(NUMTSUB) = 0.D0

       NUMTSUB = NUMTSUB + 1
      ENDIF

	TPRED(NUMTSUB) = TBEG
      TPREDREL(NUMTSUB) = 0.D0

c  As of npageng18.f, the new code with TPREDREL --> if there is a 
c  steady state dose set, which is not at the beginning of the patient
c  file, TPREDREL(.) will have two consecutive values set to 0.0 in
c  the above code. This is required since otherwise, the correspondence
c  between TPREDREL(.) and NUMTSUB would be lost.


	DO I=1,NUMT2
	 NUMTSUB = NUMTSUB + 1
	 IF(NUMTSUB .GT. 7200) GO TO 40
	 TPRED(NUMTSUB) = TPRED(NUMTSUB-1) + IDELTA/60.D0
       TPREDREL(NUMTSUB) = TPRED(NUMTSUB) - TBEG
	END DO

C  SAVE THIS MAXIMUM TIME + 24 HOURS INTO TEND. IT WILL BE NEEDED

C  IN MAIN WHERE SUBJECT AUCs ARE CALCULATED. ALSO, AS OF npageng16.f,
C  SAVE THE BEGINNING TIME INTO TBEGG.

	NOMAXTIMS = NOMAXTIMS + 1

C  NOTE THAT TEND IS DIMENSIONED 99 ABOVE, BUT IT IS NOT NECESSARY
C  TO TEST THAT NOMAXTIMS .LE. 99 SINCE IF IT WAS EVEN CLOSE TO THIS
C  VALUE, THE NUMTSUB > 7200 TEST BELOW WOULD BE TRUE AND THIS 
C  SUBROUTINE WOULD BE EXITED.

	TEND(NOMAXTIMS) = T_END
      TBEGG(NOMAXTIMS) = TBEG

C  ESTABLISH THE NEXT DOSE TIME THAT STARTS A TIME RESET (WHICH MAY OR

C  MAY NOT BE THE BEGINNING OF A STEADY STATE DOSE SET).

      IF(IDOSE .LT. ND) THEN
       DO ID = IDOSE + 1,ND
        IF(SIG(ID) .LE. 0.D0) THEN
         IDOSE = ID
         GO TO 35
        ENDIF
       END DO
      ENDIF

   35 CONTINUE


	IF(INDEX .EQ. NOBSER) RETURN

C  THE ABOVE RETURN IS THE NORMAL EXIT FROM THIS ROUTINE. THE ONLY
C  OTHER WAY OUT IS THROUGH LABEL 40 BELOW, WHICH WILL ONLY HAPPEN IF
C  NUMTSUB EXCEEDS THE MAX. NO. OF ALLOWABLE TIMES TO BE IN TPRED.

	GO TO 50


   40   CONTINUE


C   TO GET HERE --> NUMTSUB > 7200. 


	WRITE(*,2031) JSUB,IDELTA
	WRITE(25,2031) JSUB,IDELTA
 2031    FORMAT(///' FOR SUBJECT NO. ',I4,' THE MAXIMUM NO. OF '/
     1' PREDICTED VALUES (7200) HAS BEEN REACHED. THIS MEANS THAT IN'/
     2' THE DENSITY PART OF THE OUTPUT FILE, AND IN THE PRTB FILE'/
     3' (WHERE THE PREDICTED VALUES ARE WRITTEN ',I3,' MINUTES APART),'/

     4' THIS SUBJECT WILL NOT HAVE A COMPLETE SET OF PREDICTED VALUES.')

	NUMTSUB = 7200	

C	CALL PAUSE

C  NOTE THAT THE REASON NUMTSUB IS LIMITED TO 7200 IS THAT THE 

C  PREDICTED VALUES FOR THESE TIMES MUST BE STORED INTO
C  YPREDPOPT(MAXSUB,NUMEQT,7201,3), AND IF MAXSUB = 999, AND 
C  NUMEQT = 6, THIS WOULD RESULT IN ALMOST 130 MILLION VALUES IN
C  THIS MATRIX. THIS IS PROBABLY TOO MUCH, BUT FOR NOW (WITH MOST
C  MAXSUB VALUES << 999, AND NUMEQT USUALLY .LE. 3), IT IS PROBABLY
C  OK. BUT MAY HAVE TO ADJUST THIS 7200 DOWN FOR RUNS WITH A LARGE
C  NO. OF PATIENT FILES.



	RETURN
	END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
        SUBROUTINE CONDENSE(READLINE)
        CHARACTER READLINE*1000        

C  SUBROUTINE CONDENSE IS CALLED BY MAIN TO WRITE READLINE WITH AS 
C  SMALL A FORMAT AS POSSIBLE (WITHIN 25 CHARACTERS) TO FILE 26

C  FOR THIS LINE, READLINE, FIND IEND, THE LAST CHARACTER WHICH IS NOT
C  BLANK. THEN ONLY CHARACTERS 1:IEND WILL BE WRITTEN TO FILE 26.


	DO IEND = 1000,1,-1
	 IF(READLINE(IEND:IEND) .NE. ' ') GO TO 20
	END DO

   20   CONTINUE

C  CANNOT USE WRITE(26,_) READLINE(1:IEND) SINCE, FOR SOME REASON,
C  WRITING LIKE THIS "RIGHT JUSTIFIES" THE CHARACTERS AT THE END
C  OF THE A1000 FORMAT. INSTEAD MUST WRITE (26,__) READLINE, WHERE
C  THE FORMAT IS DETERMINED BY THE LAST NON-BLANK CHARACTER (IEND)
C  IN READLINE.


	IF(IEND .LE. 26) THEN
	 WRITE(26,26) READLINE
   26    FORMAT(A26)
	 RETURN

	ENDIF

	IF(IEND .LE. 51) THEN
	 WRITE(26,51) READLINE
   51    FORMAT(A51)
	 RETURN
	ENDIF

	IF(IEND .LE. 76) THEN
	 WRITE(26,76) READLINE
   76    FORMAT(A76)
	 RETURN
	ENDIF


	IF(IEND .LE. 101) THEN



	 WRITE(26,101) READLINE

  101    FORMAT(A101)
	 RETURN
	ENDIF

	IF(IEND .LE. 126) THEN
	 WRITE(26,126) READLINE
  126    FORMAT(A126)
	 RETURN
	ENDIF

	IF(IEND .LE. 151) THEN
	 WRITE(26,151) READLINE
  151    FORMAT(A151)
	 RETURN
	ENDIF

	IF(IEND .LE. 176) THEN

	 WRITE(26,176) READLINE
  176    FORMAT(A176)
	 RETURN
	ENDIF

	IF(IEND .LE. 201) THEN
	 WRITE(26,201) READLINE
  201    FORMAT(A201)
	 RETURN
	ENDIF

	IF(IEND .LE. 226) THEN
	 WRITE(26,226) READLINE

  226    FORMAT(A226)
	 RETURN
	ENDIF


	IF(IEND .LE. 251) THEN
	 WRITE(26,251) READLINE
  251    FORMAT(A251)

	 RETURN
	ENDIF

	IF(IEND .LE. 276) THEN
	 WRITE(26,276) READLINE
  276    FORMAT(A276)
	 RETURN
	ENDIF

	IF(IEND .LE. 301) THEN
	 WRITE(26,301) READLINE
  301    FORMAT(A301)
	 RETURN
	ENDIF

	IF(IEND .LE. 326) THEN
	 WRITE(26,326) READLINE
  326    FORMAT(A326)
	 RETURN
	ENDIF

	IF(IEND .LE. 351) THEN
	 WRITE(26,351) READLINE
  351    FORMAT(A351)
	 RETURN
	ENDIF

	IF(IEND .LE. 376) THEN
	 WRITE(26,376) READLINE
  376    FORMAT(A376)
	 RETURN
	ENDIF

	IF(IEND .LE. 401) THEN
	 WRITE(26,401) READLINE

  401    FORMAT(A401)
	 RETURN
	ENDIF

	IF(IEND .LE. 426) THEN
	 WRITE(26,426) READLINE
  426    FORMAT(A426)
	 RETURN
	ENDIF

	IF(IEND .LE. 451) THEN
	 WRITE(26,451) READLINE
  451    FORMAT(A451)
	 RETURN
	ENDIF

	IF(IEND .LE. 476) THEN

	 WRITE(26,476) READLINE
  476    FORMAT(A476)
	 RETURN
	ENDIF

	IF(IEND .LE. 501) THEN
	 WRITE(26,501) READLINE
  501    FORMAT(A501)
	 RETURN
	ENDIF

	IF(IEND .LE. 526) THEN
	 WRITE(26,526) READLINE
  526    FORMAT(A526)
	 RETURN
	ENDIF

	IF(IEND .LE. 551) THEN
	 WRITE(26,551) READLINE
  551    FORMAT(A551)
	 RETURN
	ENDIF

	IF(IEND .LE. 576) THEN
	 WRITE(26,576) READLINE
  576    FORMAT(A576)
	 RETURN
	ENDIF


	IF(IEND .LE. 601) THEN
	 WRITE(26,601) READLINE
  601    FORMAT(A601)
	 RETURN
	ENDIF

	IF(IEND .LE. 626) THEN
	 WRITE(26,626) READLINE
  626    FORMAT(A626)
	 RETURN
	ENDIF

	IF(IEND .LE. 651) THEN
	 WRITE(26,651) READLINE
  651    FORMAT(A651)
	 RETURN
	ENDIF

	IF(IEND .LE. 676) THEN
	 WRITE(26,676) READLINE
  676    FORMAT(A676)
	 RETURN
	ENDIF


	IF(IEND .LE. 701) THEN
	 WRITE(26,701) READLINE
  701    FORMAT(A701)
	 RETURN
	ENDIF


	IF(IEND .LE. 726) THEN
	 WRITE(26,726) READLINE
  726    FORMAT(A726)
	 RETURN
	ENDIF

	IF(IEND .LE. 751) THEN
	 WRITE(26,751) READLINE

  751    FORMAT(A751)
	 RETURN
	ENDIF


	IF(IEND .LE. 776) THEN

	 WRITE(26,776) READLINE
  776    FORMAT(A776)
	 RETURN
	ENDIF

	IF(IEND .LE. 801) THEN
	 WRITE(26,801) READLINE
  801    FORMAT(A801)
	 RETURN
	ENDIF

	IF(IEND .LE. 826) THEN

	 WRITE(26,826) READLINE
  826    FORMAT(A826)
	 RETURN
	ENDIF


	IF(IEND .LE. 851) THEN
	 WRITE(26,851) READLINE
  851    FORMAT(A851)
	 RETURN
	ENDIF

	IF(IEND .LE. 876) THEN
	 WRITE(26,876) READLINE
  876    FORMAT(A876)
	 RETURN
	ENDIF

	IF(IEND .LE. 901) THEN
	 WRITE(26,901) READLINE
  901    FORMAT(A901)
	 RETURN
	ENDIF

	IF(IEND .LE. 926) THEN
	 WRITE(26,926) READLINE
  926    FORMAT(A926)
	 RETURN
	ENDIF

	IF(IEND .LE. 951) THEN
	 WRITE(26,951) READLINE
  951    FORMAT(A951)
	 RETURN
	ENDIF

	IF(IEND .LE. 976) THEN
	 WRITE(26,976) READLINE
  976    FORMAT(A976)
	 RETURN
	ENDIF

	WRITE(26,4) READLINE
    4    FORMAT(A1000)
        RETURN

        END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
        SUBROUTINE PAUSE

C  THIS ROUTINE IS USED TO REPLACE A PAUSE STATEMENT, WHICH CAUSES 
C  WARNINGS WHEN THIS PROGRAM IS COMPILED AND LINKED USING gfortran
C  (AND FORCES THE USER TO TYPE "go" INSTEAD OF SIMPLY HITTING THE
C  ENTER KEY).

        WRITE(*,1)
    1   FORMAT(' HIT ANY KEY TO CONTINUE: ')
        READ(*,*,ERR=10) IKEY
        IF(IKEY .EQ. 1) RETURN
   10   RETURN
        END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
      SUBROUTINE NEWWORK1(MAXSUB,JSUB,TIMOBREL) 

      IMPLICIT REAL*8(A-H,O-Z)
      PARAMETER(MAXNUMEQ=7)
      DIMENSION SIG(5000),RS(5000,34),DELTAIV(7),ORDELT(7),
     1 RSS(5000,34),SIGG(5000),TIM(594),TIMM(594),YO(594,MAXNUMEQ),
     2 TIMDELAY(99),TIMOBREL(MAXSUB,594),OBSBLOCK(800,150,MAXNUMEQ+1),
     3 DOSEBLOCK(800,1000,35),NDORIG(800),XVERIFY(100)

      CHARACTER READLINE*300,ERRFIL*20

   	COMMON/DOSEOBS/DOSEBLOCK,OBSBLOCK,NDORIG
      COMMON/ERR/ERRFIL 


C  SUBROUTINE NEWWORK1 (BASED ON THE STAND-A-LONE VERSION OF THE SAME
C  NAME) READS IN A WORKING COPY PATIENT DATA FILE, AND OUTPUTS ANOTHER
C  FILE WHICH IS:

C  a. EXACTLY THE SAME IF THE ORIGINAL FILE HAS NO STEADY STATE DOSE
C     INDICATORS;

C  OR

C  b. ALTERED TO HAVE THE SAME INFO AS IN THE ORIGINAL FILE, BUT ALSO
C     CONTAINING AN EXTRA 101 DOSES FOR EACH STEADY STATE DOSE 
C     INDICATOR.

C  NOTES:

C  1. A STEADY STATE DOSE INDICATOR IS A NEGATIVE VALUE IN THE TIME
C  ENTRY FOR A DOSE. THIS IS ACCOMPANIED BY INFORMATION ON THE SET OF
C  DOSES IN THE IV AND BOLUS ENTRIES, AS THE FOLLOWING EXAMPLE SHOWS:

C   Time    IV     Bolus
C   -2.0   100.0   150.0 ...

C  THE ABOVE LINE WOULD TELL THE PROGRAM:

C  a. THAT THIS WAS INFO ON 101 STEADY STATE DOSES BECAUSE OF THE 
C     NEGATIVE TIME VALUE;
C  b. THE TIME BETWEEN CONSECUTIVE IV START TIMES = 2 HOURS, BECAUSE 
C     THIS IS THE ABS. VALUE OF THE TIME;
C  C. THE IV RATE = 100MG/HOUR;
C  D. THE TOTAL DRUG AMT. FOR EACH IV DOSE IS 150MG.

C  SO THE PROGRAM WOULD THEN ADD 101 DOSES TO THE PATIENT DATA FILE,
C  STARTING AT T = 0, EACH WITH AN IV RATE = 100, AND CONTINUING FOR
C  1.5 HOURS.

C  2. IT WILL BE ASSUMED THAT EACH STEADY STATE DOSE INDICATOR ALWAYS
C  WILL BE REPLACED BY 101 IV DOSES (NOT BOLUS DOSES).
C  AS OF npageng17.f, STEADY STATE DOSES MAY BE BOLUS DOSES. IN THIS
C  CASE, THE IV RATE WILL BE 0.0 OF COURSE.

C  3. ALL OTHER TIMES IN THE PATIENT DATA FILE (UP TO THE NEXT TIME 
C  RESET IF THERE IS ONE) WILL BE ASSUMED TO BE TIMES FROM THE END OF 
C  THE 100TH DOSE INTERVAL (NOT THE 101ST). IN THE ABOVE EXAMPLE, THE
C  100TH DOSE INTERVAL WOULD END AT T = 200 (THE 101ST IV ITSELF WOULD
C  END AT T = 201.5, BUT THE 100TH DOSE INTERVAL WOULD END AT T = 200).
C  SO ALL OTHER TIMES IN THE DOSAGE AND OBSERVATION BLOCKS WOULD HAVE
C  200 ADDED TO THEIR VALUES.

C  4. THE ABOVE EXAMPLE IS FOR ONE DRUG ONLY, BUT ANY OR ALL OF THE
C  NDRUGS IN A PATIENT'S FILE CAN HAVE STEADY STATE DOSES. ANY DRUG
C  WHICH HAS A NON-0 VALUE IN THE BOLUS COLUMN OF A STEADY STATE DOSE
C  LINE (I.E., ONE WITH TIME < 0) WILL PARTICIPATE IN A STEADY STATE
C  DOSE SET, GETTING THAT AMOUNT OF DRUG IN EACH OF THE 101 DOSES. IF
C  THE IV COLUMN IS > 0, THEN THE DRUG WILL BE GIVEN AT THE RATE 
C  SHOWN IN THE IV COLUMN. IF THE IV COLUMN IS 0, THEN THE DRUG WILL
C  BE GIVEN AS A BOLUS.

C  5. THE 101 STEADY STATE DOSES CAN BE GIVEN AS THE FIRST SET OF DOSES
C  IN A PATIENT'S FILE, AS INDICATED ABOVE, OR AT ANY TIME RESET. IF
C  THEY ARE AT A TIME RESET, ALL THE SUBSEQUENT TIMES AFTER THAT TIME
C  RESET (UP TO THE NEXT TIME RESET IF THERE IS ONE) ARE ADJUSTED AS 
C  INDICATED ABOVE TO BE TIMES AFTER THE END OF THE 100TH DOSE SET.

C-----------------------------------------------------------------------


C  FILE 23 WAS OPENED IN MAIN AND THE POINTER IS AT THE TOP OF A PATIENT
C  WHOSE INFO IS TO BE PUT ONTO FILE 27. BUT IT WILL NOT BE PUT ON TO
C  FILE 27 UNTIL THE DOSE BLOCK OF FILE 23 HAS BEEN READ ... AND 
C  EXAMINED TO SEE IF IT HAS A STEADY STATE DOSE INDICATOR. IF IT DOES,
C  IT MEANS THAT THIS PART OF FILE 27 WILL HAVE AN EXTRA SET OF 101
C  DOSES FOR EACH DRUG.

C  NOTE ALSO THAT, AS OF npagen18.f, TIMOBREL(JSUB,J), J=1,M, WILL BE
C  STORED AND RETURNED TO MAIN.

 1717 FORMAT(A300)

   10 READ(23,1717) READLINE
      IF(READLINE(12:23) .NE. 'NO. OF DRUGS') GO TO 10

C  READLINE NOW CONTAINS THE NO. OF DRUGS, NDRUG. BACKSPACE AND READ
C  NDRUG; THEN READ THE NO. OF ADDITIONAL COVARIATES, AND THE NO. OF

C  DOSE EVENTS. 

    3 FORMAT(T2,I5)

      BACKSPACE(23)
      READ(23,3) NDRUG
      READ(23,3) NADD
      READ(23,3) ND
	NI = 2*NDRUG + NADD

C  IF THERE ARE NO DOSE EVENTS (ND = 0), THE INFO ON FILE 27 WILL BE THE
C  SAME AS ON FILE 23 (SINCE THERE CAN BE NO STEADY STATE DOSE EVENTS IF
C  THERE ARE NO DOSES). IN THIS CASE, SET ICOPY = 1 (SEE BELOW).

      IF(ND .EQ. 0) ICOPY = 1

C  IF ANY SIG(.) IS NEGATIVE, SET ICOPY = 0 SINCE A SIG(.) < 0 IS THE
C  INDICATOR FOR A STEADY STATE SET OF DOSES.


      IF(ND .GE. 1) THEN

       READ(23,*)
       READ(23,*)

       ICOPY = 1

C  As of npageng18.f, STORE ND INTO NDORIG(JSUB); IT WILL BE PASSED
C  TO SUBROUTINE READOUT VIA COMMON/DOSEOBS.

       NDORIG(JSUB) = ND


       DO I = 1,ND

        READ(23,*) SIG(I),(RS(I,J),J=1,NI)

C  AS OF npageng18.f, STORE THE VALUES IN THE DOSE BLOCK FOR PASSAGE
C  TO SUBROUTINE READOUT VIA COMMON/DOSEOBS.

C  AS OF npageng19.f, RATHER THAN USING BACKSPACE(23), ESTABLISH
C  DOSEBLOCK BY STRAIGHTFORWARD ASSIGNMENTS. THE REASON IS THAT,
C  DEPENDING ON WHICH COMPILER IS USED TO MAKE THE PR PREP PROGRAM
C  (CURRENT ONE IS NPAG108.FOR), IT IS POSSIBLE FOR A DOSE EVENT
C  TO LOOK LIKE SEVERAL LINES RATHER THAN ONE LONG WORD-WRAPPED LINE.
C  IN THE FORMER CASE, BACKSPACING ONE LINE WILL NOT BACKSPACE TO THE
C  BEGINNING OF THE DOSE EVENT AS SHOULD BE DONE. SO TO BE SAFE, THE
C  LOGIC TO USE BACKSPACE(23) WILL BE COMMENTED OUT, AND 
C  DOSEBLOCK(.,.,.) WILL BE ESTABLISHED DIRECTLY.

        DOSEBLOCK(JSUB,I,1) = SIG(I)
        DO J = 2,1+NI
         DOSEBLOCK(JSUB,I,J) = RS(I,J-1)
        END DO
        
C        BACKSPACE(23)
C        READ(23,*) (DOSEBLOCK(JSUB,I,J),J=1,1+NI)

        IF(SIG(I) .LT. 0.D0) ICOPY = 0

       END DO

      ENDIF

C  THE ABOVE ENDIF IS FOR THE  IF(ND .GE. 1)  CONDITION.




C  AS OF npageng18.f, STORE IN THE VALUES IN THE OBSERVATION BLOCK FOR
C  PASSAGE TO SUBROUTINE READOUT VIA COMMON DOSEOBS.

  140	 READ(23,1717) READLINE

       IF(READLINE(12:23) .NE. 'NO. OF TOTAL') GO TO 140

       BACKSPACE(23)

       READ(23,*) NUMEQT
       READ(23,3) M

       DO I = 1,M
        READ(23,*) (OBSBLOCK(JSUB,I,J),J=1,1+NUMEQT)
       END DO

  
C  IF ICOPY = 1, IT MEANS THAT THIS PATIENT DATA FILE DOES NOT HAVE
C  A STEADY STATE DOSE SET, WHICH MEANS THAT THIS PART OF FILE 23 WILL 
C  BE COPIED LINE FOR LINE TO FILE 27 BELOW.

      IF(ICOPY .EQ. 1) THEN


C  COPY FILE 23 TO FILE 27,LINE FOR LINE.

C  BACKSPACE FILE 23 TO THE FIRST LINE FOR THIS PATIENT.


 1720  BACKSPACE(23)
       BACKSPACE(23)
       READ(23,1717,IOSTAT=IEND) READLINE

	 IF(IEND .LT. 0) THEN

C  NOTE THAT IEND .LT. 0 --> END OF FILE REACHED, BUT IF IT'S REACHED
C  AT THIS POINT, NOT ALL "ACTIVE" NSUB SUBJECT DATA SETS WERE READ
C  AND WRITTEN CORRECTLY TO FILE 27. IN THIS CASE, WRITE A MESSAGE TO
C  THE USER AND STOP.

        WRITE(*,1721)
 1721   FORMAT(/' PATIENT DATA INFORMATION WAS NOT READ CORRECTLY'/
     1' FROM THE INSTRUCTION FILE, npag103.inp. IF YOU EDITED THIS'/
     2' FILE MANUALLY, PLEASE RERUN THE PC PREP PROGRAM TO HAVE IT'/
     3' PREPARE npag103.inp AGAIN AND THEN RERUN THIS PROGRAM.'//
     4' IF YOU DID NOT MANUALLY EDIT npag103.inp, PLEASE SEND THE'/
     5' DETAILS OF THIS RUN (STARTING WITH THE PC PREP EXECUTION) TO'/
     5' THE LAPK. '//
     6' THANK YOU.'/)

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,1721)
        CLOSE(42)

	  CALL PAUSE
	  STOP

	 ENDIF

       IF(READLINE(3:16) .NE. 'LAST AND FIRST') GO TO 1720


       WRITE(27,1717) READLINE
     
   30  READ(23,1717) READLINE
       WRITE(27,1717) READLINE
   
       IF(READLINE(12:23) .NE. 'NO. OF DOSE ') GO TO 30

C  THE LINE JUST WRITTEN TO FILE 27 IS THE NO. OF DOSE EVENTS LINE.
C  WRITE THE NEXT TWO LINES ALSO.

       DO I = 1,2
        READ(23,1717) READLINE
        WRITE(27,1717) READLINE
       END DO


C  IF ND = 0, SKIP TO THE OUTPUT SECTION. OTHERWISE, WRITE THE DOSAGE
C  REGIMEN TO FILE 27.

       IF(ND.EQ.0) GO TO 40

       DO I = 1,ND
        READ(23,*) SIG(I),(RS(I,J),J=1,NI)
        WRITE(27,*) SIG(I),(RS(I,J),J=1,NI)
       END DO

C  READ THE NO. OF OUTPUT EQUATIONS FROM THE LINE WITH 'NO. OF TOTAL'
C  AS ENTRIES 12:23. THEN READ NO. OF OBSERVED VALUE TIMES, ETC., AND

C  WRITE THE REST OF THE FILE 23 TO FILE 27.

   40	 READ(23,1717) READLINE
       WRITE(27,1717) READLINE
       IF(READLINE(12:23) .NE. 'NO. OF TOTAL') GO TO 40

       BACKSPACE(23)

C  SINCE NUMEQT IS PROVIDED TO THIS ROUTINE IN THE ARGUMENT LIST,
C  JUST READ(23,*) ON NEXT LINE.

       READ(23,*)
       READ(23,3) M

C  BACKSPACE JUST ONCE TO THE LINE WITH M ON IT, SINCE THE LINE WITH

C  NUMEQT ON IT WAS ALREADY PUT INTO FILE 27. 

       BACKSPACE(23)
       READ(23,1717) READLINE
       WRITE(27,1717) READLINE

       DO I = 1,M
        READ(23,*) TIM(I),(YO(I,J),J=1,NUMEQT)
        WRITE(27,*) TIM(I),(YO(I,J),J=1,NUMEQT)
        TIMOBREL(JSUB,I) = TIM(I)
       END DO

C  NOW COPY LINE FOR LINE THE REST OF THIS PATIENT'S INFO TO FILE 27.
C  THIS PATIENT'S INFO WILL END WHEN THE END OF THE FILE IS REACHED
C  (IF THIS IS THE LAST PATIENT), OR WHEN THE START OF THE NEXT

C  PATIENT OCCURS.


   50	 READ(23,1717,IOSTAT=IEND) READLINE
       IF(IEND .LT. 0) GO TO 100

   	 IF(READLINE(3:16) .EQ. 'LAST AND FIRST') GO TO 100

       WRITE(27,1717) READLINE
       GO TO 50


  100	 BACKSPACE(23)

C  FILE 23 WAS BACKSPACED ONE LINE SO THE NEXT LINE TO BE READ IN IN
C  MAIN WILL BE THE FIRST LINE OF THE NEXT SUBJECT (UNLESS THIS SUBJECT
C  IS THE LAST SUBJECT, IN WHICH CASE THE BACKSPACE WON'T MATTER).

      ENDIF

C  THE ABOVE ENDIF IS FOR THE  IF(ICOPY .EQ. 1)  CONDITION.


      IF(ICOPY .EQ. 0) THEN


C  SINCE ICOPY = 0, IT MEANS THAT THERE IS AT LEAST ONE SET OF STEADY
C  STATE DOSES IN THE DOSAGE BLOCK. THE LOGIC FOR TRANSLATING THESE
C  STEADY STATE DOSES TO A REGULAR DOSAGE BLOCK (EXCEPT FOR THE NEGATIVE
C  DOSE TIME AT THE START OF EACH STEADY STATE DOSE SET) IS AS FOLLOWS:

C  EACH DOSAGE LINE WILL BE COPIED UNALTERED UNLESS IT IS PART OF A
C  STEADY STATE SET.

C  EACH STEADY STATE SET STARTS WITH A SIG(I) < 0. IN THIS CASE, 101
C  DOSES WILL BE APPLIED AT THIS POINT WITH THE STEADY STATE DOSE FOR
C  DRUG IDRUG = RS(I,2*IDRUG), WHICH WILL BE APPLIED AS A BOLUS IF
C  RS(I,2*IDRUG-1) = 0, AND AS AN IV WITH DURATION
C  RS(I,2*IDRUG)/RS(I,2*IDRUG-1) IF RS(I,2*IDRUG-1) > 0.
C  THE REST OF THE DOSE TIMES IN THIS BLOCK OF DOSES (I.E., UNTIL THE
C  NEXT TIME RESET OR STEADY STATE DOSE INDICATOR) WILL BE INCREASED
C  BY 100*DELDOSE, WHERE DELDOSE = -SIG(I) = INTERDOSE INTERVAL FOR
C  THIS SET.


C  ILINE WILL BE THE RUNNING INDEX OF THE NEXT DOSAGE LINE TO BE PUT

C  INTO THE ALTERED DOSAGE REGIMEN. SIGG(ILINE) AND RSS(ILINE,.) ARE
C  THE VALUES THAT GO INTO THIS LINE. DELDOSE IS THE CURRENT INTERDOSE
C  TIME INTERVAL FOR THE LAST STEADY STATE SET OF DOSES ALREADY PUT
C  INTO THE ALTERED DOSAGE REGIMEN (IT IS INITIALIZED TO BE 0 OF 
C  COURSE). 

C  AND NSECTION IS INITIALIZED TO BE 0. IT WILL BE THE RUNNING NO. OF
C  DOSAGE SECTIONS. EACH SECTION BEGINS WITH EITHER A 0.0 (BEGINNING
C  LINE OR TIME RESET) OR A NEGATIVE NO. (STEADY STATE DOSE SET 
C  INDICATOR). THE TIME DELAY ASSOCIATED WITH EACH DOSE SECTION (WHICH
C  WILL BE 0 IF THAT SECTION IS NOT A STEADY STATE DOSE SET), MUST BE 
C  STORED TO BE APPLIED TO THE CORRESPONDING SET OF OBSERVED VALUES
C  BELOW.


      ILINE = 0
      DELDOSE = 0.D0
      NSECTION = 0

      DO ID = 1,ND


       IF(SIG(ID) .GE. 0.D0) THEN

        CALL THESAME(SIG(ID),0.D0,ISAME)

        IF(ISAME .EQ. 1) THEN
         DELDOSE = 0.D0
         NSECTION = NSECTION + 1

         TIMDELAY(NSECTION) = 0.0
        ENDIF   

C  NOTE THAT IF SIG(ID) = 0, THIS LINE IS A TIME RESET LINE, OR THE
C  FIRST LINE IN THE DOSAGE REGIMEN. IF IT'S THE FIRST LINE IN THE
C  DOSAGE REGIMEN, THERE ARE OBVIOUSLY NO PREVIOUS STEADY STATE DOSE
C  SETS. IF ITS A TIME RESET LINE, A PREVIOUS SET OF 101 STEADY STATE
C  DOSES HAS NO EFFECT ON IT. THAT'S WHY DELDOSE IS SET = 0, WHICH 
C  MEANS, BELOW, THAT SIGG(ILINE) WILL = SIG(ID) = 0. ALSO, THE TIME
C  DELAY STORED IN TIMDELAY ABOVE IS 0 SINCE SIG(ID) .GE. 0 --> THIS
C  IS NOT A STEADY STATE DOSE SET.
        
        ILINE = ILINE + 1
        SIGG(ILINE) = SIG(ID) + 100.D0*DELDOSE

        DO J = 1,NI
         RSS(ILINE,J) = RS(ID,J)
        END DO
       
       ENDIF


       IF(SIG(ID) .LT. 0.D0) THEN

C  THIS LINE GIVES INFO ON A STEADY STATE SET OF 101 DOSES WHICH IS
C  TO APPLIED AT THIS POINT.

        DO IDRUG = 1,NDRUG

C  FOR DRUG, IDRUG, THE AMOUNT OF DRUG FOR DRUG NO. IDRUG IN EACH OF THE
C  101 DOSES WILL BE RS(ID,2*IDRUG). IF RS(ID,2*IDRUG) > 0, DRUG, IDRUG,
C  PARTICIPATES IN THE STEADY STATE DOSING. IF THIS VALUE = 0, DRUG,
C  IDRUG, DOES NOT PARTICIPATE. NOTE THAT IF A DRUG PARTICIPATES, THE
C  ROUTE WILL BE AS AN IV, WITH RATE RS(ID,2*IDRUG-1), IF 
C  RS(ID,2*IDRUG-1) > 0. BUT IF THIS VALUE IS 0, THE DRUG WILL BE GIVEN
C  AS A BOLUS. NOTE THAT THE INTERVAL BETWEEN DOSES IS -SIG(ID).

C  IF DRUG, IDRUG, PARTICIPATES IN THE 101 STEADY STATE DOSE SET, PUT 
C  THE DURATION OF IV INTO DELTAIV(IDRUG) IF RS(ID,2*IDRUG-1) > 0;
C  OTHERWISE PUT 0 INTO DELTAIV(IDRUG) SINCE IN THIS CASE, THE DRUG IS
C  GIVEN AS A BOLUS.

         DELTAIV(IDRUG) = 0.D0 
         IF(RS(ID,2*IDRUG) .GT. 0.D0 .AND. RS(ID,2*IDRUG-1) .GT. 0.D0) 
     1    DELTAIV(IDRUG) = RS(ID,2*IDRUG)/RS(ID,2*IDRUG-1) 

C  IT SHOULD NOT BE POSSIBLE FOR THE IV OF THIS DRUG TO BE > 0 AT THE
C  SAME TIME THAT THE BOLUS ENTRY = 0. THIS WOULD MEAN THAT AN IV
C  WAS TO BE GIVEN AT A SPECIFIED RATE, BUT WITH A TOTAL DOSE OF 0,
C  AND THIS MAKES NO SENSE. IF, SOMEHOW, THIS HAS OCCURRED, REPORT IT
C  TO THE USER AS AN ERROR, AND STOP.

       XVERIFY(1) = SIG(ID)
       XVERIFY(2) = RS(ID,2*IDRUG-1) 
       XVERIFY(3) = RS(ID,2*IDRUG)
       CALL VERIFYVAL(3,XVERIFY)  
      


      IF(RS(ID,2*IDRUG) .LE. 0.D0 .AND. RS(ID,2*IDRUG-1) .GT. 0) THEN
C      WRITE(*,101) ID,SIG(ID),IDRUG,RS(ID,2*IDRUG-1),RS(ID,2*IDRUG)
       WRITE(*,101) ID,XVERIFY(1),IDRUG,XVERIFY(2),XVERIFY(3)

  101     FORMAT(//' THERE IS AN ERROR IN YOUR INSTRUCTION FILE, AS'/
     1' DETERMINED BY SUBROUTINE NEWWORK1.'//
     2' ONE OF THE SUBJECTS HAS A STEADY STATE DOSE SET WITH A '/
     3' POSITIVE IV RATE, BUT WITH A TOTAL DOSE AMOUNT .LE. 0.'//
     4' IN PARTICULAR, FOR DOSE EVENT ',I4,' AND TIME ',G19.9,/
     5' FOR DRUG ',I2,', THE IV VALUE IS ',G19.9,' WHILE THE TOTAL'/
     6' DOSE AMOUNT IS ',G19.9//
     7' THE PROGRAM STOPS. PLEASE CORRECT THE ERROR BEFORE RERUNNING.'/)

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,101) ID,SIG(ID),IDRUG,RS(ID,2*IDRUG-1),RS(ID,2*IDRUG)
        CLOSE(42)

          CALL PAUSE
          STOP
         ENDIF

 
        END DO

        
C  CALL SUBROUTINE ORDERDELTA TO OBTAIN NDELTA, THE NO. OF UNIQUE
C  NON-0 VALUES IN THE DELTAIV(.) ARRAY JUST ESTABLISHED ABOVE, AND TO
C  PUT THE ORDERED SET OF THESE NDELTA VALUES INTO ORDELT(.).

C  NOTE THAT IF DELTAIV(IDRUG) = 0, IT MEANS THAT DRUG, IDRUG, DOES NOT
C  PARTICIPATE IN THE STEADY STATE DOSE SET, OR IF IT DOES, IT IS GIVEN
C  AS A BOLUS RATHER THAN AN IV.

        CALL ORDERDELTA(NDRUG,DELTAIV,NDELTA,ORDELT)

C  NOW ESTABLISH THE LINES WITH SIGG(.) AND RSS(.,.) AS FOLLOWS:

C  1. THE NEXT 101*(NDELTA + 1) ROWS WILL BE FOR THE STEADY STATE
C  DOSE SET (I.E., EACH OF THE 101 REPEATED DOSES HAS A START TIME,
C  AND THEN NDELTA ENDING TIMES AMONG ALL NDRUG DRUGS). NOTE THAT
C  NDELTA WILL BE 0 IF ALL THE PARTICIPATING DRUGS ARE BOLUSES SINCE
C  THEY WOULDN'T NEED AN ENDING TIME THEN.

C  2. EVERY ROW OF THE ORIGINAL DOSAGE REGIMEN AFTER LINE ID
C  WILL HAVE THE SAME VALUES IN RSS(.,.) AS IN RS(.,.), BUT THE

C  TIMES IN SIGG(.) WILL ALL BE INCREASED BY 100*DELDOSE OVER THOSE
C  IN SIG(.) ... UP TO BUT NOT INCLUDING THE NEXT TIME RESET EVENT
C  OR NEXT STEADY STATE DOSE INDICATOR LINE, WHERE DELDOSE IS THE TIME
C  INCREMENT BETWEEN CONSECUTIVE DOSES IN THE 101 STEADY STATE DOSE SET.
C  NOTE THAT DELDOSE IS THE NEGATIVE OF SIG(ID).

        DELDOSE = -SIG(ID)        
        NSECTION = NSECTION + 1
        TIMDELAY(NSECTION) = 100.D0*DELDOSE

C  NOTE THAT THE TIME DELAY ASSOCIATED WITH THIS STEADY STATE SET IS
C  STORED INTO TIMDELAY ABOVE SO THAT IT CAN BE APPLIED TO THE 
C  CORRESPONDING SET OF OBSERVED VALUES BELOW.


        DO ISET = 1,101


C  FOR EACH SET, ESTABLISH NDELTA + 1 ROWS (DOSE EVENT LINES).

C  THE FIRST ROW IN THIS SET HAS EACH DRUG IV SET = RS(ID,2*IDRUG-1),
C  AND, FOR EACH DRUG IV WHICH IS 0, THE BOLUS VALUE WILL BE SET =
C  RS(ID,2*IDRUG). NOTE THAT IF A DRUG IV > 0, THE BOLUS VALUE WILL BE
C  SET = 0 SINCE IN THIS CASE, THE VALUE IN THE BOLUS COLUMN IS THE
C  TOTAL AMOUNT OF IV (NOT A BOLUS AMOUNT).

         ILINE = ILINE + 1

         DO IDRUG = 1,NDRUG
          RSS(ILINE,2*IDRUG-1) = RS(ID,2*IDRUG-1)
          RSS(ILINE,2*IDRUG) = RS(ID,2*IDRUG)
          IF(RS(ID,2*IDRUG-1) .GT. 0.D0) RSS(ILINE,2*IDRUG) = 0.D0
         END DO

C  SET ALL THE COVARIATE VALUES = TO THOSE IN LINE ID OF RS OF COURSE.

         DO IADD = 1,NADD
          RSS(ILINE,2*NDRUG+IADD) = RS(ID,2*NDRUG+IADD)
         END DO

C  THE TIME FOR THIS ROW IS (ISET-1)*DELDOSE, EXCEPT FOR THE FIRST
C  LINE, WHICH MUST HAVE THE SAME NEGATIVE VALUE AS IN SIG, SINCE
C  THE ID ROUTINES MUST READ THE NEGATIVE SIG VALUE TO KNOW THAT A
C  STEADY STATE DOSE SET IS STARTING.

         IF(ISET .EQ. 1) THEN
          SIGG(ILINE) = SIG(ID)
          DOSESTART = 0.D0
         ENDIF

         IF(ISET .GT. 1) THEN
          SIGG(ILINE) = (ISET-1)*DELDOSE
          DOSESTART = SIGG(ILINE)

         ENDIF

C  THE NEXT NDELTA ROWS ARE THE IV TURN OFF ROWS FOR THE VARIOUS DRUGS,
C  IF NDELTA > 0. NOTE THAT NDELTA COULD = 0 IF ALL PARTICIPATING DRUGS
C  ARE GIVEN VIA A BOLUS, SINCE THEN NONE WOULD NEED A TURN OFF ROW.

        IF(NDELTA .GT. 0) THEN

         DO INDEL = 1,NDELTA

          ILINE = ILINE + 1

C  THE NEXT TURN OFF TIME IS DOSESTART + ORDELT(INDEL). EACH IV WILL BE
C  OFF UNLESS ITS DELTAIV(.) IS .GT ORDELT(INDEL). AND EACH BOLUS VALUE
C  WILL BE 0 OF COURSE (I.E., EACH BOLUS IS GIVEN JUST ONE TIME AT THE
C  START OF EACH SET).

          DO IDRUG = 1,NDRUG
           RSS(ILINE,2*IDRUG-1) = 0.D0
           IF(DELTAIV(IDRUG) .GT. ORDELT(INDEL))
     1      RSS(ILINE,2*IDRUG-1) = RS(ID,2*IDRUG-1)        
           RSS(ILINE,2*IDRUG) = 0.D0
          END DO

C  SET ALL THE COVARIATE VALUES = TO THOSE IN LINE ID OF RS AGAIN.

          DO IADD = 1,NADD
           RSS(ILINE,2*NDRUG+IADD) = RS(ID,2*NDRUG+IADD)
          END DO


C  THE TIME FOR THIS ROW IS DOSESTART + ORDELT(INDEL)

          SIGG(ILINE) = DOSESTART + ORDELT(INDEL)

         END DO   

C  THE ABOVE END DO IS FOR THE  DO INDEL = 1,NDELTA  LOOP.  

        ENDIF

C  THE ABOVE ENDIF IS FOR THE  IF(NDELTA .GT. 0)  CONDITION.


 
        END DO

C  THE ABOVE END DO IS FOR  DO ISET = 1,101  LOOP.


       ENDIF

C  THE ABOVE ENDIF IS FOR THE  IF(SIG(ID) .LT. 0.D0)  CONDITION.


      END DO

C  THE ABOVE END DO IS FOR THE  DO ID = 1,ND  LOOP.


C  THIS COMPLETES THE ESTABLISHMENT OF RSS(.,.) AND SIGG(.) ABOVE.


C  NOW ALTER THE OBSERVED VALUE TIMES BY ADDING THE APPROPRIATE VALUE
C  IN TIMDELAY(.) TO EACH OBSERVED VALUE TIME BELOW. NOTE THAT
C  TIMDELAY(1) APPLIES TO ALL TIMES BEFORE THE FIRST TIME RESET,
C  TIMDELAY(2) APPLIES TO THE NEXT SET OF TIMES AFTER THE FIRST 
C  TIME RESET BUT BEFORE THE 2ND, ETC. IF THERE ARE NO TIME RESETS,
C  ALL TIMES WILL HAVE TIMDELAY(1) ADDED TO THEM, AND THIS VALUE WILL
C  BE 0.0 (SEE DOSAGE BLOCK CODE ABOVE - IF THERE ARE NO TIME RESETS
C  OR STEADY STATE DOSE SETS, TIMDELAY(1) IS SET = 0).

C  SINCE THE OBSERVATION BLOCK WAS READ THROUGH ABOVE, BACKSPACE TO
C  THE BEGINNING OF THE OBS. BLOCK, SO THIS PART OF THE PATIENT'S
C  DATA CAN BE ACCESSED AGAIN.

1920   BACKSPACE(23)
       BACKSPACE(23)
       READ(23,1717,IOSTAT=IEND) READLINE

	 IF(IEND .LT. 0) THEN

C  NOTE THAT IEND .LT. 0 --> END OF FILE REACHED, BUT IF IT'S REACHED
C  AT THIS POINT, NOT ALL "ACTIVE" NSUB SUBJECT DATA SETS WERE READ
C  AND WRITTEN CORRECTLY TO FILE 27. IN THIS CASE, WRITE A MESSAGE TO
C  THE USER AND STOP.

        WRITE(*,1721)

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,1721) 
        CLOSE(42)

	  CALL PAUSE
	  STOP

	 ENDIF

       IF(READLINE(12:23) .NE. 'NO. OF TOTAL') GO TO 1920

       BACKSPACE(23)

C  SINCE NUMEQT IS PROVIDED TO THIS ROUTINE IN THE ARGUMENT LIST,
C  JUST READ(23,*) ON NEXT LINE.

       READ(23,*)

       READ(23,3) M

       NSECTION = 1

       DO I = 1,M
        READ(23,*) TIM(I),(YO(I,J),J=1,NUMEQT)
        TIMOBREL(JSUB,I) = TIM(I)
        CALL THESAME(TIM(I),0.D0,ISAME)
        IF(ISAME .EQ. 1 .AND. I .GT. 1) NSECTION = NSECTION + 1
        IF(ISAME .EQ. 1) TIMM(I) = 0.D0   
        IF(ISAME .EQ. 0) TIMM(I) = TIM(I) + TIMDELAY(NSECTION)
       END DO



C  NOW COPY THIS PART OF FILE 23 TO FILE 27 WITH THE FOLLOWING
C  EXCEPTIONS:
C   1. ND WILL BE REPLACED BY ILINE (THE TOTAL NO. OF DOSAGE LINES IN
C      THE ALTERED DOSAGE REGIMEN).
C   2. SIG(.) WILL BE REPLACED BY SIGG(.).
C   3. RS(.,.) WILL BE REPLACED BY RSS(.,.)
C   4. TIM(.) WILL BE REPLACED BY TIMM(.)
C   NOTE THAT YO(.,.) WILL BE UNCHANGED.

C  BACKSPACE FILE 23 TO THE FIRST LINE FOR THIS PATIENT.


 1820  BACKSPACE(23)

       BACKSPACE(23)
       READ(23,1717,IOSTAT=IEND) READLINE

	 IF(IEND .LT. 0) THEN

C  NOTE THAT IEND .LT. 0 --> END OF FILE REACHED, BUT IF IT'S REACHED
C  AT THIS POINT, NOT ALL "ACTIVE" NSUB SUBJECT DATA SETS WERE READ
C  AND WRITTEN CORRECTLY TO FILE 27. IN THIS CASE, WRITE A MESSAGE TO
C  THE USER AND STOP.

        WRITE(*,1721)

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,1721)
        CLOSE(42)

	  CALL PAUSE
	  STOP

	 ENDIF

       IF(READLINE(3:16) .NE. 'LAST AND FIRST') GO TO 1820

       WRITE(27,1717) READLINE

   60  READ(23,1717) READLINE
       WRITE(27,1717) READLINE
   
       IF(READLINE(12:23) .NE. 'NO. OF ADDIT') GO TO 60

C  THE LINE JUST WRITTEN TO FILE 27 IS THE NO. OF ADDITIONAL COVARIATES
C  LINE. WRITE THE NEXT LINE BUT CHANGE FROM ND TO ILINE AS THE NO.
C  OF DOSE EVENTS.

       READ(23,1717) READLINE
       WRITE(27,133) ILINE
  133  FORMAT(I6,' ... NO. OF DOSE EVENTS')

C  WRITE THE NEXT TWO LINES TO FILE 27 (INCLUDING THE HEADER LINE FOR
C  THE DOSAGE BLOCK).

       DO I = 1,2
        READ(23,1717) READLINE
        WRITE(27,1717) READLINE
       END DO

C  WRITE THE NEW DOSAGE BLOCK.

       SIGLAST = -999999.D0

       DO I = 1,ILINE

        WRITE(27,*) SIGG(I),(RSS(I,J),J=1,NI)


C  AS OF npageng27.f, MAKE SURE THAT NO TWO TIMES ARE THE SAME SINCE
C  IF THEY ARE, IT CAN CONFUSE SUBROUTINE SHIFT (CAUSING IT TO GO INTO
C  AN INFINITE LOOP - SEE NPAG115.EXP, TESTCASE 5).

        CALL THESAME(SIGLAST,SIGG(I),ISAME)

        IF(ISAME .EQ. 1) THEN

         XVERIFY(1) = SIGLAST
         CALL VERIFYVAL(1,XVERIFY)



C        WRITE(*,4031) SIGLAST


         WRITE(*,4031) XVERIFY(1)
 4031    FORMAT(/' IN SUBROUTINE NEWWORK1, TWO CONSECUTIVE DOSE TIMES'/
     1' HAVE THE SAME VALUE IN WORKING COPY FORMAT, ',F20.8//
     2' THIS COULD CAUSE UNEXPECTED RESULTS IF THE PROGRAM WERE TO '/
     3' CONTINUE. SO THE PROGRAM NOW STOPS. PLEASE CHECK YOUR PATIENT '/
     4' INFORMATION AND CORRECT (NOTE THAT THIS CAN HAPPEN IF THE '/
     5' FIRST DOSE FOLLOWING A STEADY STATE DOSE SET HAS THE SAME'/
     6' STARTING TIME AS THE ENDING TIME OF THE LAST STEADY STATE '/
     7' DOSE SET.)'//)

C  SINCE THE PROGRAM IS TERMINATING ABNORMALLY, WRITE THE ERROR MESSAGE
C  TO ERRFIL ALSO.

        OPEN(42,FILE=ERRFIL)
         WRITE(42,4031) SIGLAST
        CLOSE(42)

	  CALL PAUSE
	  STOP

	 ENDIF

       SIGLAST = SIGG(I)


       END DO


C  READ THROUGH FILE 23 DOWN TO THE END OF THE DOSAGE BLOCK

       DO I = 1,ND
        READ(23,*) SIG(I),(RS(I,J),J=1,NI)
       END DO
 
C  PUT THE BLANK LINE BETWEEN THE DOSAGE BLOCK AND THE OBSERVATION
C  BLOCK TO FILE 27, ALONG WITH THE TWO LINES WHICH GIVE THE NO. OF
C  OUTPUT EQS. AND THE NO. OF OBSERVED VALUE TIMES.

       DO I = 1,3
        READ(23,1717) READLINE
        WRITE(27,1717) READLINE
       END DO

C  WRITE THE OBSERVED BLOCK TO FILE 27, AND READ THROUGH IT IN FILE 23.

      DO I = 1,M
       WRITE(27,*) TIMM(I),(YO(I,J),J=1,NUMEQT)
       READ(23,*) TIM(I),(YO(I,J),J=1,NUMEQT)
      END DO
 
C  NOW COPY LINE FOR LINE THE REST OF THIS SUBJECT'S INFO TO FILE 27.
C  THIS PATIENT'S INFO WILL END WHEN THE END OF THE FILE IS REACHED
C  (IF THIS IS THE LAST PATIENT), OR WHEN THE START OF THE NEXT
C  PATIENT OCCURS.

   70	 READ(23,1717,IOSTAT=IEND) READLINE
       IF(IEND .LT. 0) GO TO 200
   	 IF(READLINE(3:16) .EQ. 'LAST AND FIRST') GO TO 200
       WRITE(27,1717) READLINE
       GO TO 70
  200	 BACKSPACE(23)

C  FILE 23 WAS BACKSPACED ONE LINE SO THE NEXT LINE TO BE READ IN IN
C  MAIN WILL BE THE FIRST LINE OF THE NEXT SUBJECT (UNLESS THIS SUBJECT

C  IS THE SUBJECT, IN WHICH CASE THE BACKSPACE WON'T MATTER).

      ENDIF

C  THE ABOVE ENDIF IS FOR THE  IF(ICOPY .EQ. 0)  CONDITION.


      RETURN
      END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
      SUBROUTINE ORDERDELTA(NDRUG,DELTAIV,NDELTA,ORDELT)
      IMPLICIT REAL*8(A-H,O-Z)
      DIMENSION DELTAIV(7),ORDELT(7),X(7)

C  SUBROUTINE ORDERDELTA IS CALLED BY NEWWORK1 TO OBTAIN NDELTA, THE NO.
C  OF UNIQUE NON-0 VALUES IN THE DELTAIV(.) ARRAY. THEN THE ORDERED SET
C  OF THESE NDELTA VALUES IS PUT INTO ORDELT(.). NOTE THAT
C  NDELTA WILL BE 0 IF ALL THE PARTICIPATING DRUGS ARE BOLUSES SINCE
C  THEY WOULDN'T NEED AN ENDING TIME THEN.



C  FIRST STORE ALL THE VALUES IN DELTAIV INTO X SO THAT DELTAIV WILL
C  NOT BE CHANGED.

      DO IDRUG = 1,NDRUG
       X(IDRUG) = DELTAIV(IDRUG)
      END DO


C  THE LOGIC OF THIS ROUTINE IS BASED ON \PERSONAL\FINANCE\ORDER.FOR.
C  TO DO THIS, EACH VALUE IN X(.) WILL BE COMPARED TO THE
C  PREVIOUS ONE. IF IT IS < THE PREVIOUS ONE, THE VALUE WILL EXCHANGE
C  PLACES WITH THE PREVIOUS ONE, AND THE TESTING WILL CONTINUE. THE
C  TESTING WILL STOP FOR A VALUE WHEN IT IS COMPARED TO A PREVIOUS
C  VALUE WHICH IS .LE. ITS VALUE.

      DO IDRUG = 2, NDRUG


C  COMPARE VALUE FOR IDRUG WITH EACH PREVIOUS VALUE, AND HAVE IT 
C  EXCHANGE PLACES WITH THAT VALUE, UNTIL IT REACHES ONE WHICH HAS A 
C  SMALLER VALUE. FIRST SET IDRUGNEW = IDRUG; AFTER THE FOLLOWING
C  CODE, IDRUGNEW WILL BE THE INDEX NO. FOR VALUE AT THE OLD IDRUG
C  POSITION.

       IDRUGNEW = IDRUG

       ICOMP = IDRUG 

  110  ICOMP = ICOMP - 1

C  NOW COMPARE VALUE IN LOCATION ICOMP WITH THE VALUE IN LOCATION
C  IDRUGNEW. IF THE LATTER IS .LT. THE FORMER, INTERCHANGE THE RECORDS.

       IF(X(IDRUGNEW) .LT. X(ICOMP)) THEN

        VALUE = X(IDRUGNEW)
        X(IDRUGNEW) = X(ICOMP)         
        X(ICOMP) = VALUE
        IDRUGNEW = ICOMP


C  IF IDRUGNEW = 1, IT HAS BEEN CHECKED AGAINST ALL RECORDS (AND IS
C  THE SMALLEST VALUE); IF IS IS > 1, CONTINUE THE PROCESS.

        IF(IDRUGNEW .EQ. 1) GO TO 150
        IF(IDRUGNEW .GT. 1) GO TO 110



       ENDIF

C  THE ABOVE ENDIF IS FOR THE 
C   IF(X(IDRUGNEW) .LT. X(ICOMP))  CONDITION.


  150 END DO

C  THE ABOVE END DO IS FOR THE  DO IDRUG = 2, NDRUG LOOP.


C  NOW THE NDRUG VALUES ARE ORDERED, FROM SMALL TO LARGE IN X.
C  REWRITE THEM INTO ORDELT, BUT PUT ONLY THE NON-0 AND
C  UNIQUE VALUES INTO ORDELT, AND KEEP TRACK OF NOW MANY OF THESE
C  UNIQUE NON O VALUES THERE ARE - IT WILL BE NDELTA AT THE END OF
C  THE FOLLOWING LOOP.

      NDELTA = 0 

      DO IDRUG = 1,NDRUG

C  FOR THIS VALUE TO BE COUNTED, IT CANNOT = THE PREVIOUS VALUE, AND
C  IT CANNOT = 0.



       IF(IDRUG .EQ. 1 .AND. X(IDRUG) .GT. 0) THEN
        NDELTA = NDELTA + 1
        ORDELT(NDELTA) = X(IDRUG)
       ENDIF



       IF(IDRUG .GE. 2) THEN

        CALL THESAME(X(IDRUG),X(IDRUG-1),ISAME)

        IF(ISAME .EQ. 0) THEN
         NDELTA = NDELTA + 1
         ORDELT(NDELTA) = X(IDRUG)
        ENDIF

       ENDIF

      END DO 

C  THE ABOVE END DO IS FOR THE  DO IDRUG = 1,NDRUG  LOOP.


      RETURN
      END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
	SUBROUTINE THESAME(X1,X2,ISAME)
	IMPLICIT REAL*8(A-H,O-Z)

C  THIS ROUTINE CHECKS TO SEE IF X1 AND X2 ARE VIRTUALLY THE SAME
C  VALUES (I.E., IF THEY ARE WITHIN 1.D-10 OF EACH OTHER). IF SO,
C  ISAME RETURNS AS 1; IF NOT ISAME RETURNS AS 0.

	ISAME = 0
	XDEL = DABS(X1-X2)
	IF(XDEL .LE. 1.D-10) ISAME = 1

	RETURN
	END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
      SUBROUTINE VERIFYVAL(N,X)
      IMPLICIT REAL*8(A-H,O-Z)
      DIMENSION X(100)

C  THIS ROUTINE INPUTS X(I),I=1,N.

C  ON OUTPUT, EACH X(.) WHICH IS INSIDE [-1.D-99, 1.D-99] IS REPLACED
C  BY 0. THIS PREVENTS THIS VALUE FROM BEING WRITTEN OUT IMPROPERLY,
C  E.G., AS .934-106, RATHER THAN .934E-106.
C  ANY X(.) VALUE NOT INSIDE THE ABOVE RANGE WILL BE UNCHANGED ON
C  OUTPUT.

      DO I = 1,N
       IF(X(I) .GE. -1.D-99 .AND. X(I) .LE. 1.D-99) X(I) = 0.D0
      END DO

      RETURN
      END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
	SUBROUTINE CALCRF(NTOTPAR,VEC,FNTVAL,NUMEQT,YO,C0,C1,C2,C3)
	IMPLICIT REAL*8(A-H,O-Z)

C  THIS SUBROUTINE IS CALLED BY ELDERY TO FIND THE FUNCTIONAL VALUE,
C  FNTVAL, FOR THE SUPPLIED CANDIDATE VECTOR, VEC. ELDERY CALLS THIS
C  SUBROUTINE OVER AND OVER UNTIL IT FINDS THE VECTOR, VEC, WHICH
C  MINIMIZES FNTVAL.

C  FNTVAL IS THE NORMALIZED SUM OF SQ. DIFFERENCES BETWEEN ALL OBSERVED
C  AND PREDICTED VALUES OVER ALL NSUB SUBJECTS, GIVEN THE NTOTPAR 
C  VALUES SUPPLIED IN THE CANDIDATE VECTOR VEC. NOTE THAT THESE VALUES
C  WILL BE ASSIGNED TO THE PARAMETER ENTRIES IN PX(.) WHICH HAVE 
C  IRAN(.) = 2, AND THEN IRAN(.) = 1. THE OTHER PARAMETER VALUES (I.E.,
C  THOSE WHICH HAVE IRAN(.) = 0) WERE ALREADY ASSIGNED TO THE 
C  APPROPRIATE ENTRIES IN PX BEFORE ELDERY WAS CALLED IN MAIN.

      PARAMETER(MAXNUMEQ=7)

	DIMENSION VEC(NTOTPAR),IRAN(32),PX(32),SIG(594,MAXNUMEQ),
     1 YO(594,NUMEQT),C0(NUMEQT),C1(NUMEQT),C2(NUMEQT),C3(NUMEQT),
     2 AB(30,2)


      COMMON SIG
	COMMON/TOCALC/IRAN,PX,NOFIX,NSUB,gamma,flat,AB


C  COMMON SIG IS USED TO PASS THE VALUES ESTABLISHED IN SIG(.,.)
C  BELOW TO SUBROUTINE FUNC.

C  COMMON/TOCALC VALUES ARE PASSED TO THIS ROUTINE FROM MAIN.


C  AS INDICATED ABOVE, PX(.) HAS THE CORRECT VALUES ALREADY IN PLACE
C  FOR THE PARAMETERS WITH IRAN(.) = 0. NOW INSERT THE CANDIDATE
C  VALUES IN VEC(.) INTO THE ENTRIES IN PX(.) WITH IRAN(.) = 2 AND 1.
C  AND, AS OF npagranfix3.f, ENSURE THE CANDIDATE VALUES FOR THE
C  RANDOM VARIABLES (I.E., THOSE WITH IRAN(.) = 1) ARE INSIDE THEIR
C  RESPECTIVE BOUNDARIES.

      NVEC = 0
 
      DO I = 1,NTOTPAR+NOFIX
       IF(IRAN(I) .EQ. 2) THEN
        NVEC = NVEC + 1
        PX(I) = VEC(NVEC)
       ENDIF
      END DO

      IRANO = 0
      DO I = 1,NTOTPAR+NOFIX
       IF(IRAN(I) .EQ. 1) THEN
        NVEC = NVEC + 1
        IRANO = IRANO + 1
C  THIS IS RANDOM VARIABLE NO. IRANO. VERIFY THAT ITS CANDIDATE
C  VALUE IS INSIDE ITS BOUNDARIES, [AB(IRANO,1), AB(IRANO,2)]. IF NOT,
C  RETURN A LARGE POSITIVE VALUE, WHICH IS UNATTRACTIVE, FOR FNTVAL.
        VN = VEC(NVEC)
        IF(VN .GT. AB(IRANO,2) .OR. VN .LT. AB(IRANO,1)) THEN
         FNTVAL = 1.D30
         RETURN
        ENDIF
C  TO GET HERE --> THE CANDIDATE VECTOR IS WITHIN THE REQUIRED RANGE.        
        PX(I) = VEC(NVEC)
       ENDIF
      END DO



C  INITIALIZE SUMTOT = 0.D0. IT WILL BE THE RUNNING SUM OVER ALL NSUB
C  SUBJECTS OF THE NORMALIZED SUM OF SQ. DIFFERENCES BETWEEN ALL
C  OBSERVED AND PREDICTED VALUES.

      SUMTOT = 0.D0

      REWIND(27)

      DO JSUB = 1,NSUB

C  ADD TO SUMTOT THIS SUBJECT'S NORMALIZED SUM OF SQUARED DIFFERENCES
C  BETWEEN ITS OBSERVED AND PREDICTED VALUES (THESE PREDICTED VALUES
C  ARE BASED ON THE VALUES ESTABLISHED IN PX(.) (SEE ABOVE).

C  CALL SUBROUTINE FILRED TO STORE THE DATA FOR THIS SUBJECT INTO
C  COMMONS USED BY SUBROUTINE IDPC AND ITS SUBROUTINES. ALSO, THE
C  VALUES IN SIG(.) HAVE TO BE ESTABLISHED SINCE THESE VALUES ARE
C  PASSED IN THE BLANK COMMON TO SUBROUTINE FUNC. 

       CALL FILRED(NOBSER,YO,C0,C1,C2,C3,NUMEQT)

C  SEE COMMENTS IN THE 140 LOOP IN MAIN.

       DO 140 I=1,NOBSER
        DO 140 J=1,NUMEQT

         Y = YO(I,J)

C  IF YO(I,J) = -99, IT MEANS THAT OUTPUT EQ. J HAD NO VALUE AT 
C  OBSERVATION TIME I. IN THIS CASE, SIG(I,J) WILL NOT BE SET, AND IT
C  OF COURSE WILL NOT BE NEEDED IN SUBROUTINE FUNC.
 
         IF(Y .EQ. -99) GO TO 140
         SIG(I,J) = C0(J)+C1(J)*Y+C2(J)*Y*Y+C3(J)*Y**3
         if(ierrmod.eq.2) sig(i,j) = sig(i,j)*gamma
         if(ierrmod.eq.3) sig(i,j)=dsqrt(sig(i,j)**2 + gamma**2)
         if(ierrmod.eq.4) sig(i,j) = gamma*flat

  140    CONTINUE


C  CALL IDPC, A SUBROUTINIZED VERSION OF THE ADAPT PROGRAM ID3, TO
C  CALCULATE THE SUM OF SQUARES OF DIFFERENCES BETWEEN THE OBSERVED 
C  VALUES AND THE PREDICTED (BY THE MODEL) VALUES, FOR EACH OUTPUT
C  EQUATION, FOR THIS VARIABLE VECTOR, VEC. THESE SUM OF SQUARES ARE
C  EACH NORMALIZED BY THE ASSAY VARIANCE OF EACH OBSERVATION.

       CALL IDPC(PX,W)

C  W RETURNS AS THE SUM OF:
C  ((YO(I,J)-H(I,J))/SIG(I,J))**2, WHERE H(I,J) = PREDICTED VALUE OF THE
C  JTH OUTPUT EQ AT THE ITH OBSERVATION TIME, ASSUMING THE IGTH GRID
C  POINT, X, ... OVER THE NOBSER x NUMEQT QUANTITIES ABOVE WHICH DON'T
C  HAVE YO(I,J) = -99 (WHICH MEANS THAT OUTPUT EQ. J HAS NO OBSERVED
C  LEVEL FOR TIME I).

C  ADD THIS W TO SUMTOT.

       SUMTOT = SUMTOT + W


      END DO
C  THE ABOVE END DO IS FOR THE  DO JSUB = 1,NSUB  LOOP.

      FNTVAL = SUMTOT


	RETURN
	END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
        SUBROUTINE ELDERY(N,START,XMIN,YNEWLO,REQMIN,STEP,
     X  ITMAX,FUNC,IPRINT,ICONV,NITER,ICOUNT,NUMEQT,YO,C0,C1,C2,C3)

C  ELDERY DIFFERS FROM ELDERX ONLY IN THE DIMENSION STATEMENT. ALL 5'S
C  ARE CHANGED TO 25'S, AND ALL 6'S ARE CHANGED TO 26'S. THIS ALLOWS 25
C  PARAMETERS INSTEAD OF JUST 5. As of itbig9x.f, we allow as many as
C  30 parameters.

C  ELDERX DIFFERS FROM ELDER (DESCRIBED BELOW) ONLY IN THAT N, THE
C  DIMENSION OF START (THE NO. OF UNKNOWN PARAMETERS OVER WHICH THE
C  MINIMIZATION IS DONE) IS PASSED TO THE SUBROUTINE FUNC IN THE CALLING
C  STATEMENTS.
C
C  ELDER IS A PROGRAM TO MINIMIZE A FUNCTION USING THE NELDER-MEED
C  ALGORITM.
C    THE CODE WAS ADAPTED FROM A PROG. IN J. OF QUALITY TECHNOLOGY VOL. 
C    JAN. 1974. BY D.M. OLSSON.
C  CALLING ARGUMENTS:
C    N     -NUMBER OF UNKNOWN PARAMS. UP TO 99.
C    START -A VECTOR WITH THE INITIAL QUESSES OF THE SOLUTION PARAMS.
C    ITMAX -THE MAXIMUM NUMBER OF ITERATIONS.
C             (KCOUNT IS THE MAX NUM OF FUNC CALLS.SET AT 1000000)
C    STEP  -THE STEP SIZE VECTOR FOR DEFINING THE N ADDITIONAL 
C             VERTICIES.
C    REQMIN-THE STOP TOLERANCE.

C    XMIN   -THE SOLUTION VECTOR.
C    YNEWLO-THE FUCTION VALUE AT XMIN.
C    IPRINT-SWITCH WHICH DETERMINES IF INTERMEDIATE ITERATIONS
C              ARE TO BE PRINTED. (0=NO,1=YES).
C    ICONV -FLAG INDICATING WHETHER OR NOT CONVERGENCE HAS BEEN
C             ACHEIVED. (0=NO,1=YES).
C    NITER -THE NUMBER OF ITERATIONS PERFORMED.
C    ICOUNT-THE NUMBER OF FUNCTION EVALUATIONS.
C    FUNC  -THE NAME OF THE SUBROUTINE DEFINING THE FUNCTION.
C             THIS SUBROUTINE MUST EVALUATE THE FUNCTION GIVEN A
C             VALUE FOR THE PARAMETER VECTOR. THE ROUTINE IS OF
C             THE FOLLOWING FORM:
C               FUNC(P,FV), WHERE P IS THE PARAMETER VECTOR,
C                             AND FV IS THE FUNCTION VALUE.
C  A SUBROUTINE TO PRINT THE RESULTS OF ITERMEDIATE ITERATIONS
C    MUST ALSO BE SUPPLIED. ITS NAME AND CALLING SEQUENCE ARE 
C    DEFINED AS FOLLOWS:
C      PRNOUT(P,N,NITER,NFCALL,FV).
C  OTHER PROGRAM VARIABLES OF INTEREST ARE;
C    XSEC  -THE COORDINATES OF THE VETEX WITH THE 2ND SMALLEST FUNCTION
C             VALUE.
C    YSEC  - THE FUNCTION VALUE AT XSEC.
C
      IMPLICIT REAL*8(A-H,O-Z)
        DIMENSION START(N),STEP(N),XMIN(N),XSEC(30),
     X  P(30,31),PSTAR(30),P2STAR(30),PBAR(30),Y(31),YO(594,NUMEQT),
     1  C0(NUMEQT),C1(NUMEQT),C2(NUMEQT),C3(NUMEQT)

        EXTERNAL FUNC
        DATA RCOEFF/1.0D0/,ECOEFF/2.0D0/,CCOEFF/.5D0/

        KCOUNT=1000000
        ICOUNT=0
        NITER=0
        ICONV=0
C
C  CHECK INPUT DATA AND RETURN IF AN ERROR IS FOUND.
C
        IF(REQMIN.LE.0.0D0) ICOUNT=ICOUNT-1
        IF(N.LE.0) ICOUNT=ICOUNT-10
        IF(N.GT.99) ICOUNT=ICOUNT-10

       

        IF(ICOUNT.LT.0) RETURN
C
C  SET INITIAL CONSTANTS
C
        DABIT=2.04607D-35
        BIGNUM=1.0D+38
        KONVGE=5
        XN=FLOAT(N)
        DN=FLOAT(N)
        NN=N+1
C
C  CONSTRUCTION OF INITIAL SIMPLEX.
C
1001    DO 1 I=1,N
1       P(I,NN)=START(I)
        CALL FUNC(N,START,FN,NUMEQT,YO,C0,C1,C2,C3)
        Y(NN)=FN
        ICOUNT=ICOUNT+1
C       CALL PRNOUT(START,N,NITER,ICOUNT,FN)
        IF(ITMAX.NE.0) GO TO 40
        DO 45 I=1,N
45      XMIN(I)=START(I)
        YNEWLO=FN
        RETURN
40      DO 2 J=1,N
        DCHK=START(J)
        START(J)=DCHK+STEP(J)
        DO 3 I=1,N
3       P(I,J)=START(I)
        CALL FUNC(N,START,FN,NUMEQT,YO,C0,C1,C2,C3)
        Y(J)=FN
        ICOUNT=ICOUNT+1
2       START(J)=DCHK
C
C  SIMPLEX CONSTRUCTION COMPLETE.


C
C    FIND THE HIGHEST AND LOWEST VALUES. YNEWLO (Y(IHI)) INDICATES THE
C     VERTEX OF THE SIMPLEX TO BE REPLACED.
C
1000    YLO=Y(1)
        YNEWLO=YLO
        ILO=1
        IHI=1
        DO 5 I=2,NN
        IF(Y(I).GE.YLO) GO TO 4
        YLO=Y(I)
        ILO=I
4       IF(Y(I).LE.YNEWLO) GO TO 5
        YNEWLO=Y(I)
        IHI=I
5       CONTINUE
C
        IF(ICOUNT.LE.NN) YOLDLO=YLO
        IF(ICOUNT.LE.NN) GO TO 2002
        IF(YLO.GE.YOLDLO) GO TO 2002
        YOLDLO=YLO
        NITER=NITER+1
        IF(NITER.GE.ITMAX) GO TO 900
        IF(IPRINT.EQ.0) GO TO 2002
C       CALL PRNOUT(P(1,ILO),N,NITER,ICOUNT,YLO)
C
C  PERFORM CONVERGENCE CHECKS ON FUNCTIONS.
C
2002    DCHK=(YNEWLO+DABIT)/(YLO+DABIT)-1.0D0
        IF(DABS(DCHK).GT. REQMIN) GO TO 2001
        ICONV=1
        GO TO 900
C
2001    KONVGE=KONVGE-1
        IF(KONVGE.NE.0) GO TO 2020
        KONVGE=5
C
C  CHECK CONVERGENCE OF COORDINATES ONLY EVERY 5 SIMPLEXES.
C
        DO 2015 I=1,N
        COORD1=P(I,1)
        COORD2=COORD1
        DO 2010 J=2,NN
        IF(P(I,J).GE.COORD1) GO TO 2005
        COORD1=P(I,J)
2005    IF(P(I,J).LE.COORD2) GO TO 2010
        COORD2=P(I,J)
2010    CONTINUE
        DCHK=(COORD2+DABIT)/(COORD1+DABIT)-1.0D0
        IF(DABS(DCHK).GT.REQMIN) GO TO 2020
2015    CONTINUE
        ICONV=1
        GO TO 900
2020    IF(ICOUNT.GE.KCOUNT) GO TO 900
C
C  CALCULATE PBAR, THE CENTRIOD OF THE SIMPLEX VERTICES EXCEPTING THAT
C   WITH Y VALUE YNEWLO.
C

        DO 7 I=1,N
        Z=0.0D0
        DO 6 J=1,NN
6       Z=Z+P(I,J)
        Z=Z-P(I,IHI)
7       PBAR(I)=Z/DN
C
C  REFLECTION THROUGH THE CENTROID.
C
        DO 8 I=1,N
8       PSTAR(I)=(1.0D0+RCOEFF)*PBAR(I)-RCOEFF*P(I,IHI)
        CALL FUNC(N,PSTAR,FN,NUMEQT,YO,C0,C1,C2,C3)
        YSTAR=FN
        ICOUNT=ICOUNT+1
        IF(YSTAR.GE.YLO) GO TO 12
        IF(ICOUNT.GE.KCOUNT) GO TO 19
C
C  SUCESSFUL REFLECTION SO EXTENSION.
C
        DO 9 I=1,N
9       P2STAR(I)=ECOEFF*PSTAR(I)+(1.0D0-ECOEFF)*PBAR(I)
        CALL FUNC(N,P2STAR,FN,NUMEQT,YO,C0,C1,C2,C3)
        Y2STAR=FN
        ICOUNT=ICOUNT+1
C
C  RETAIN EXTENSION OR CONTRACTION.
C
        IF(Y2STAR.GE.YSTAR) GO TO 19
10      DO 11 I=1,N
11      P(I,IHI)=P2STAR(I)
        Y(IHI)=Y2STAR
        GO TO 1000
C
C  NO EXTENSION.
C
12      L=0
        DO 13 I=1,NN

        IF(Y(I).GT.YSTAR) L=L+1
13      CONTINUE
        IF(L.GT.1) GO TO 19
        IF(L.EQ.0) GO TO 15
C
C  CONTRACTION ON REFLECTION SIDE OF CENTROID.
C
        DO 14 I=1,N
14      P(I,IHI)=PSTAR(I)
        Y(IHI)=YSTAR
C
C  CONTRACTION ON THE Y(IHI) SIDE OF THE CENTROID.
C
15      IF(ICOUNT.GE.KCOUNT) GO TO 900
        DO 16 I=1,N
16      P2STAR(I)=CCOEFF*P(I,IHI)+(1.0D0-CCOEFF)*PBAR(I)
        CALL FUNC(N,P2STAR,FN,NUMEQT,YO,C0,C1,C2,C3)
        Y2STAR=FN
        ICOUNT=ICOUNT+1
        IF(Y2STAR.LT.Y(IHI)) GO TO 10
C
C  CONTRACT THE WHOLE SIMPLEX
C
        DO 18 J=1,NN
        DO 17 I=1,N
        P(I,J)=(P(I,J)+P(I,ILO))*0.5D0
17      XMIN(I)=P(I,J)
        CALL FUNC(N,XMIN,FN,NUMEQT,YO,C0,C1,C2,C3)
        Y(J)=FN
18      CONTINUE
        ICOUNT=ICOUNT+NN
        IF(ICOUNT.LT.KCOUNT) GO TO 1000
        GO TO 900
C
C  RETAIN REFLECTION.

C
19      CONTINUE
        DO 20 I=1,N
20      P(I,IHI)=PSTAR(I)
        Y(IHI)=YSTAR
        GO TO 1000
C
C  SELECT THE TWO BEST FUNCTION VALUES (YNEWLO AND YSEC) AND THEIR
C    COORDINATES (XMIN AND XSEC)>
C
900     DO 23 J=1,NN
        DO 22 I=1,N
22      XMIN(I)=P(I,J)
        CALL FUNC(N,XMIN,FN,NUMEQT,YO,C0,C1,C2,C3)
        Y(J)=FN
23      CONTINUE
        ICOUNT=ICOUNT+NN
        YNEWLO=BIGNUM
        DO 24 J=1,NN
        IF(Y(J).GE.YNEWLO) GO TO 24
        YNEWLO=Y(J)
        IBEST=J
24      CONTINUE
        Y(IBEST)=BIGNUM
        YSEC=BIGNUM
        DO 25 J=1,NN

        IF(Y(J).GE.YSEC) GO TO 25
        YSEC=Y(J)
        ISEC=J
25      CONTINUE
        DO 26 I=1,N
        XMIN(I)=P(I,IBEST)
        XSEC(I)=P(I,ISEC)
26      CONTINUE

        RETURN
        END












