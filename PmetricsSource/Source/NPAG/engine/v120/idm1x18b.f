c  idm1x18.f                                               3/11/15

c  idm1x18 has the following change from idm1x17:

c  All numbers written out in F or G format are now tested to see if
c  they are inside [-1.D-99, 1.D-99]. If so, they are changed to be
c  0. The reason is that otherwise they will be printed out without 
c  the accompanying D or E (e.g., as .934-106, rather than .934E-106).

c  Note that this module is linked with npageng30.f initially.

c-----------------------------------------------------------------------

c  idm1x17.f                                               12/05/14

c  idm1x17 has the following changes from idm1x16:

c  It has the Threadprivate and Save statements to make it compatible
c  with the new npageng28.f program. These statements allow the 
c  program to be run in parallel. There are some other changes also
c  (see !).

c  In the call to SHIFT in Subroutine FUNC, the arguments ND,SIG,RS,
c  are changed to NDO,SIGO,RSO. This means that ND,SIG,RS, don't have
c  to be reset back to their original values at the end of FUNC. 
c  Similarly, BSO is used instead of BS.

c-----------------------------------------------------------------------

c  idm1x16.f                                               7/21/14

c  idm1x16 has the following changes from idm1x15:

c  1. In subroutine USERANAL, the dimensions of RWORK and IWORK are
c  now made consistent with the maximum allowable no. of compartments
c  (i.e., differential equations). In Subroutine DVODE, comments
c  indicate that RWORK must be dimensioned (for MF = 21 OR 22, which
c  is the case in our programs) at least 22 +  9*NEQ + 2*NEQ**2,
c  where NEQ = the no. of differential eqs.). Since NEQ = NDIM can be 
c  as high as 20, RWORK is now dimensioned 1002. And correspondingly,
c  LRW must be also set = 1002.

c  Similarly, the dimension of IWORK, and the value of LIW must be
c  30 + NEQ = 50.

c  2. If the program stops unexpectedly with the writing of format 111
c  in Subroutine FUNC, this same comment will now be written to
c  the file, ERRFIL, which is passed to FUNC in COMMON/ERR.

c-----------------------------------------------------------------------

c  idm1x15.f                                               3/6/14

c  idm1x15 has the following changes from idm1x14:

c  1. In Subroutine FUNC, the dimensions related to the no. of output
c  equations have been changed from 6 to NUMEQT OR MAXNUMEQ (see 
c  comments in that routine).

c  2. In Subroutines FUNC and PREDLAST3, the dimensions of 6 in XSTORE,
c  XPRED, and COMP have been changed to 20, as they should have been 
c  all along (i.e., this represents the maximum no. of compartments
c  allowed).

c-----------------------------------------------------------------------

c  idm1x14.f                                               10/11/12

c  idm1x14 has one correction from idm1x13:

c  THE R(.) ARE SET = RS(.,.) BEFORE GETIX IS CALLED IN THE TIME RESET
c  SECTION OF SUBROUTINE FUNC. NOT DOING THIS WOULD MEAN THAT IF THE 
C  INITIAL CONDITIONS FOR THE X(.) ARE FUNCTIONS OF THE COVARIATES
C  (ESTABLISHED IN GETIX FROM THE R(.) VALUES), THEY WOULD BE ASSIGNED
C  VALUES BASED ON COVARIATES FROM A PREVIOUS DOSAGE LINE IN THE
C  PATIENT'S DATA FILE, RATHER THAN THE LINE WHICH IS THE DOSE RESET
C  LINE.

c-----------------------------------------------------------------------

c  idm1x13.f                                               9/27/12

c  idm1x13 has the following bug correction to idm1x12:

C  IN SUBROUTINE FUNC, BEFORE
C  THE FIRST CALL TO GETFA, THE R(.) ARE SET = RS(.,.) IN CASE ANY OF
C  THE FA(.) ARE FUNCTIONS OF THE COVARIATES WHICH ARE ESTABLISHED FROM
C  THE R(.) VALUES IN  GETFA. IN ADDITION, PRIOR TO THE 2 SECTIONS WHERE
C  THE FA(.) ARE USED, GETFA IS CALLED SO THAT THE FA(.) ARE UPDATED TO
C  CURRENT VALUES, BASED ON THE MOST RECENT COVARIATE VALUES IN THE
C  PATIENT'S DATA FILE. IN PREVIOUS PROGRAMS, IT WAS SIMPLY ASSUMED
C  THAT THE FA(.) WERE FUNCTIONS OF THE PARAMETERS, BUT NOT THE
C  COVARIATES, AND SO THIS WASN'T NECESSARY. BUT THE CODE IN 
C  TSTMULTI.FOR IMPLIES THAT THE FA(.) COULD BE FUNCTIONS OF THE
C  COVARIATES, AND SO THIS CHANGE IS NECESSARY.

C  NOTE THAT SETTING THE R(.) TO RS(.,.) BEFORE THE FIRST CALL TO
C  GETFA ALSO MEANS THE R(.) WILL BE SET BEFORE GETIX AND GETTLAG ARE
C  FIRST CALLED, WHICH AGAIN IS REQUIRED IN CASE THEY ESTABLISH VALUES
C  AS FUNCTIONS OF THE COVARIATES IN THE PATIENT DATA FILE.

c-----------------------------------------------------------------------

c  idm1x12.f                                               7/25/12

c  idm1x12 has the following change to idm1x11:

c  In SUBROUTINE FUNC, the code to save ND0, SIGO, RSO, is moved to
c  before the IF(N .EQ. 0) GO TO 75  statement. The reason is that 
c  before this  routine returns, ND, SIG, and RS are reset back to these
c  values, even if N = 0, and so they must be established at this time.

c-----------------------------------------------------------------------

c  idm1x11.f                                               5/25/12

c  idm1x11 has the following changes from idm1x10:

C  IT HAS CODE CHANGES IN SUBROUTINE PREDLAST3 TO HANDLE THE CASE WHERE
C  PRED1 + PRED3 - 2*PRED2 = 0 --> PREDNEG SHOULD NOT BE CALCULATED. 
C  USUALLY THIS WILL HAPPEN WHEN THE MODEL/DOSAGE REGIMEN IS SO "EASY"
C  TO PREDICT THAT THE 3 PREDICTED VALUES ARE VERY CLOSE TO EACH OTHER,
C  AND BY "BAD LUCK" COULD BE IN A LINEAR PROGRESSION. I.E., IF
C  PRED1 + DEL = PRED2, AND PRED2 + DEL = PRED3, THEN 
C  PRED1 + PRED3 - 2*PRED2 = 0.

C  IN THIS CASE, OF COURSE, PREDNEG SHOULD NOT BE CALCULATED SINCE THAT
C  WILL RESULT IN A DIVIDE BY 0, OR A NaN IF THE PROGRAM DOES NOT STOP.

C  WHEN THIS HAPPENS (SEE CODE IN PREDLAST3), WHETHER OR NOT CONVERGENCE
C  IS ACHIEVED WILL DEPEND SOLELY ON THE TOL1 CRITERION (I.E., THE TOL2
C  CRITERION CANNOT BE USED, AND IS UNNEEDED).

C-----------------------------------------------------------------------

c  idm1x10.f                                               4/14/12

c  idm1x10 has the following changes to idm1x9.f:

c  It is to be used with npageng17.f, which allows steady state doses
c  to be boluses as well as IVs. As a result, an additional parameter,
c  ISKIPBOL, is used so, in Subroutine FUNC, when convergence occurs in
c  a steady state dose set, the last bolus from that set will not be
c  reapplied below label 83.

c-----------------------------------------------------------------------

c  idm1x9.f                                               3/2/12

c  idm1x9 has the following bug fix to idm1x8.f. In Subroutine FUNC, the
c  code to save ND, SIG, and RS before altering them if there are 
c  time lag parameters (in the call to GETTLAG) is now executed whether
c  or not there are time lag parameters. The reason is that, with steady
c  state doses, the first SIG(.) time in a steady state dose set is
c  reset to be 0 after the steady state dose is identified. And this
c  time must be reset back to be its original negative value at the end
c  of the routine so that the next time the routine is called, the 
c  program will again know when a steady state dose is coming. 

c-----------------------------------------------------------------------

c  idm1x8.f                                                1/15/12

c  Corrects bug in Subroutine FUNC - now time resets are identified
c  by just the observation time = 0 (i.e., the dose time = 0 is
c  no longer required). This is because it is possible for a dose
c  time (especially if there are timelags) to be after the last
c  observation time in a section of the patient file (before a time
c  reset), and if this happens, the program will not be able to
c  identify the observation time of 0 as a time reset.

c-----------------------------------------------------------------------

c  idm1x7.f                                                11/21/11

c  idm1x7 has the following changes from idm1x6:

c  1. It can accommodate steady state dose regimens as created by 
c  new subroutine NEWWORK1.FOR in npageng16.f. And it has new
c  Subroutine PREDLAST3 (both of these 2 new subroutines are based on
c  stand-a-lone versions of the same name) which is called by
c  Subroutine FUNC to predict the final (steady state) compartment
c  amounts. If these predicted values are determined to have
c  converged, the rest of the steady state dose set will be skipped
c  to save time. Note that predictions start after the end of the
c  5th dose set (out of 100 in each steady state regimen), and
c  continue until convergence is reached, or the entire steady state
c  dose set has been integrated through.

C  SO THE MAIN CHANGES TO THE CODE ARE:

C  CHECK TO SEE IF A DOSE TIME IS NEGATIVE. IF NOT, PROCEED AS USUAL. IF 
C  SO, PROCEED AS IF THAT TIME WAS 0, BUT AFTER THE END OF THAT DOSE AND 


C  THE NEXT 4, CALL SUBROUTINE PREDLAST3 TO PREDICT THE STEADY STATE
C  COMPARTMENT AMOUNTS AFTER THE 100 DOSES (NOTE THAT THE COMPARTMENT
C  AMOUNTS WILL HAVE TO BE FOUND AT THE END OF EACH OF THE STEADY STATE
C  DOSES OF COURSE AS THE LOGIC OF PREDLAST3 REQUIRES). IF CONVERGENCE
C  IS ACHIEVED, ASSIGN THE COMPARTMENT AMOUNTS TO BE THE PREDICTED
C  AMOUNTS AND SET KNS TO BE WHAT IT IS WHEN THESE STEADY STATE DOSE 
C  SETS HAVE FINISHED. ALSO, SET T = END OF THE STEADY STATE DOSE SET
C  SINCE THAT'S WHAT IT WOULD HAVE BEEN HAD ALL THE DOSES BEEN 
C  INTEGRATED THROUGH.

c  2. All arrays related to doses (SIG,SIGO,RS,RSO, and BS) in
c  Subroutine FUNC have their 500's changed to 5000's. This is because
c  each set of 100 steady state doses, with each of up to 7 drugs having
c  its own stopping time, could require an extra 100 x 8 dose events, 

c  and there could be multiple steady state sets (they can occur at the
c  start of the dose regimen, or at any time reset point).

c  3. Near the top of Subroutine FUNC, R(1)=0.0D0 is replaced by setting
c  R(2*I-1) = 0.D0, for I = 1,NDRUG. This should have been done when
c  the program became a multi-drug program (see comment in FUNC).

c  4. A time reset no longer requires all initial compartment amounts
c  to be reset to 0. This is because a time reset no longer has to mean
c  an "infinite" amount of time has occurred with no dosing; it can also
c  now mean an "infinite" amount of time has occurred with unknown 
c  dosing. So Subroutine GETIX will be called to establish initial
c  conditions for the new time period (these initial values can of
c  course be 0's as was always assumed in previous programs). This is
c  the situation where a patient, who previously had doses and
c  observations which were recorded while he was in a lab, goes home and
c  gets unknown doses over a long time period, and then returns to the
c  lab to get a new set of doses and observations, starting with 
c  observations which establish his initial conditions for this new
c  time period.


c-----------------------------------------------------------------------

c  idm1x6.f                                                12/20/10

c  idm1x6 has the following change to idm1x5:

c  In Subroutine FUNC, it has code that calls Subroutine ANAL3, rather
c  than USERANAL if N .EQ. -1. Also, the code to reset X(I),I=1,N to 0
c  where there is a time reset now includes extra code to set 
c  X(I),I=1,3 to 0 if N .EQ. -1.

c  Note that ANAL3, and the routines it calls are from the Little NPAG

c  program module, IDPC9A.FOR. 

c  Note that this module is linked first with bigmlt11.f, and the 
c  template model file is TSTMULTH.FOR (in which in Subroutine SYMBOL,
c  the user is told to code N=-1 if he wants to assume the standard
c  3-compartment linear model with analytic solutions, and in this 
c  case also establish the 5 parameters, {KE,KA,KCP,KPC,V} of this
c  model).

c-----------------------------------------------------------------------

c  idm1x5.f							4/03/10

c  idm1x5 has a bug correction to idm1x4. In Subroutine FUNC, in the
c  IF(TIM(KNT) .EQ. 0.D0 .AND. SIG(KNS) .EQ. 0.D0) block, the time,
c  T, is also reset = 0 since the integration will again start from
c  time 0. When this wasn't done (in idm1x4.f), the results were
c  unpredictable (depending on how the DVODE integration routines
c  treated a (T,TOUT) pair which decreased rather than increased.

c-----------------------------------------------------------------------

c  idm1x4.f							11/23/09

c  idm1x4 fixes a bug in the idm1x3 code. Label 75 is moved to in
c  front of the  CALL GETTLAG(TLAG)  statement (see the reason in
c  that part of the code).

c-----------------------------------------------------------------------

c  idm1x3.f							9/18/09

c  idm1x3 has the following changes from idm1x2:

c  1. The TLAG and FA vectors, and the initial values for the X array 
c  will be set by calling new routines (GETTLAG, GETFA, and GETIX, 
c  respectively) that are part of the model file (the new template is 
c  TSTMULT.FOR). This means the user can now code explicit formulas
c  for these values. As a result, all reference to NTLAG, IC, IFA, and
c  IVOL have been removed.

c  2. The shift subroutine will now be from the module, shift5.f, 
c  rather than shift4.f.

c  3. In Subroutine USERANAL, ISTATE is no longer written out. This
c  can slow the program a lot if the numerical integrator (DVODE) is
c  struggling with the integrations. Instead, the total no. of calls to
c  XERRWD (the routine which writes the details of the warnings) is 
c  written to the screen by the main "engine" module, currently 
c  bigmlt4.f.

c  Note that this module, along with idm2x3.f, id3x3.f, and shift5.f
c  are part of the new "engine", whose main module is bigmlt4.f.

c-----------------------------------------------------------------------

c  idm1x2.f							8/14/09


c  idm1x2 has the following changes from idm1x1:

c  1. The code for setting initial compartment amounts from initial
c  compartment concentrations is changed to reflect the fact that
c  now IC(2) refers to the index of the covariates, not the
c  column no. of RS (see comment in code).

c  2. The code to establish the timelag parameters has changed to
c  reflect that NTLAG(I) can now be negative --> in Subroutine
c  SHIFT, the associated timelag parameter will now be the 
c  exponent of the indicated parameter (rather than the parameter 
c  itself).

c  3. The code to establish the FA parameters has changed to
c  reflect that IFA(I) can now be negative --> the associated FA
c  parameter will now be the exponent of the indicated parameter 
c  (rather than the parameter itself).


c  idm1x2.f (along with other new modules idm2x2.f and idm3x2.f) are
c  still called by bigmlt2.f, but are part of the "engine" for the
c  new NPBIG15B.FOR program.

c-----------------------------------------------------------------------

c  idm1x1.f							5/27/09


c  idm1x1.f has the following changes from idfix5g.f:

c  1. It allows the extra option of setting initial compartment 
c  amounts from their initial concentrations - see code in Subroutine 
c  FUNC. 

c  2. It is part of the new Big NPAG "engine", bigmlt2.f, which allows 
c  patient data files to have "reset" values of 0 in the dosage and 
c  sampling blocks. Whenever, in Subroutine FUNC, the program sees a 
c  SIG(.) = 0 and a TIM(.) = 0, it knows that a large enough time has 
c  passed since the last dose that all compartment amounts are to be 
c  reset = 0. Subsequent dose and observed value times are then values 
c  from this point.

c  3. The first argument to Subroutine OUTPUT is changed from 0.0 to 
c  0.D0 in two places.

c  This module, along with idm2x1.f and idm3x1.f are first used in the 
c  bigmlt2.f program.

c-----------------------------------------------------------------------

c  idfix5g.f							5-28-02


c  idfix5g has the following changes from idfix5f.f:

c  It allows multiple drug inputs (rather than just one drug input).
c  The changes required for this are:

c  1. BS has dimension change from (500,3) to (500,7)
c  2. COMMON/CNST2 is changed to include NDRUG (no. of drugs) and
c     NADD (no. of additional covariates), rather than NBI and NRI.
c  3. NTLAG is now a vector instead of a scalar. In particular, 
C     NTLAG(I) = 0 IF DRUG I'S BOLUS COL. HAS NO TIMELAG PARAMETER;
C                K IF DRUG I'S BOLUS COL. HAS A TIMELAG WHOSE VALUE IS
C		   GIVEN BY PARAMETER NO K.
C  4. IFA, PASSED IN COMMON/FRABS FROM SUBROUTINE SYMBOL IS NOW A VECTOR
C     INSTEAD OF A SCALAR.
C     IFA(I) = 0 IF DRUG I WILL HAVE FA = 1.0.
C              K IF DRUG I WILL HAVE AN FA WHOSE VALUE IS TO BE GIVEN
C                BY PARAMETER K.
C  5. THE BOLUS COMPARTMENT NOS., NBCOMP(I), NOW COME VIA 
C     COMMON/BOLUSCOMP FROM SUBROUTINE SYMBOL, AND THE DIMENSION OF
C     NBCOMP HAS BEEN CHANGED TO 7 (MAXIMUM OF 1 PER DRUG) FROM 20.
C  6. ALL OF THE CODE IN SUBROUTINE FUNC RELATED TO NRI AND NBI HAS BEEN
C     CHANGED TO BE IN TERMS OF NI AND NDRUG. 
C  7. THE CODE RELATED TO CALLING SUBROUTINE SHIFT, INCLUDING THE 
C     CALLING ARGUMENTS, HAS BEEN CHANGED TO REFLECT THE ABOVE CHANGES
C     IN NTLAG (I.E., IT IS NOW A VECTOR RATHER THAN A SCALAR). A NEW
C     MODULE, shift3.f (WHICH REPLACES shift2.f) WILL BE LINKED WITH 
C     THIS MODULE.

C-----------------------------------------------------------------------

c  idfix5f.f							4-23-02

c  idfix5f has the following changes to idfix5e:

c  1. To enable FA to be a parameter value (either fixed or random), 
c  rather than always be hardcoded = 1.0, the following changes are
c  implemented ...

c  The hardcoding of FA = 1.0 and the code for NBCOMP are removed
c  from main. In addition, COMMON/BCOMP is removed from the entire 
c  module. Instead, in SUBROUTINE FUNC, a new COMMON/FRABS/IFA provides 
c  the value IFA which is the parameter index of the FA value (passed
c  from SUBROUTINE SYMBOL) unless it = 0, in which case FA is
c  set = 1.0. Also the NBCOMP compartment nos. are now set in 
c  SUBROUTINE FUNC.

c  2. COMMONS /OBSER AND /SUM2 (and the arrays in them) are deleted from 

c  main. They were not needed. Also, COMMON CNST2 is deleted from main
c  since NBI is no longer needed here (since NBCOMP code is removed -
c  see no. 1. above).

c-----------------------------------------------------------------------

c  idfix5e.f							1-22-00

c  idfix5e has the following changes to idfix5d:

c  It allows the initial conditions of the amounts in the compartments
c  to be paramater values, rather than fixed at 0.0. These parameter
c  values may be either fixed or random.


c  To affect this enhancement, the primary change is the code in 
c  subroutine FUNC which sets the initial conditions based on the 
c  values in IC which are provided by COMMON/INITCOND from 
c  SUBROUTINE SYMBOL of the Fortran model file.

c  There are many other changes to simply the code (i.e., a lot of
c  code was leftover code which was unused and/or confusing), namely:

c  - Commons ADAPT1, ADAPT2, LPARAM, PRED, TRANS, and PARAM are 

c    deleted. Variables ISW, IP, and C are deleted.
c  - COMMON/PARAMD/P is now in MAIN, FUNC, and JACOB; MAIN and
c    FUNCx of idcy_53e.f and idcy_63e.f; and DIFFEQ and OUTPUT of
c    the Fortran model file.
c  - P is redimensioned 32. It will hold only the parameters of the
c    model (although some of those parameters may be initial conditions)
c    and there are 20 allowable random paramaters and 12 allowable
c    fixed paramaters now.
c  - All the code to reverse the paramater order (using PD) and to do
c    and undo square root transformations in MAIN and FUNC is removed
c    (it was unneeded, and therefore confusing). In particular, all
c    references to NPT, NUMYES, NUIC, NUP, NPNL, and NBOT are removed.
c  - COMMON ANALYT/IDIFF is removed. IDIFF is unneeded since IDIFF = 0
c    is equivalent to N = 0, and so IDIFF code in FUNC is replaced by
c    the equivalent code for N. NEQN is replaced by N.

c  - In SUBROUTINE SUMSQ, COMMON/PARAM is removed, along with PP and P.
c    Setting PP(I) = P(I), I=1,NPNL made no sense since PP wasn't used

c    and NPNL was always = 0 anyway. P is removed as an argument to
c    SUMSQ (it was unneeded).
c  - In FUNC, the If statment at label 83 is changed to include N .EQ. 0
c    since if N = 0, setting compartment values is unnecessary.


c  idfix5e is part of the big npem program, npbig4.f.

c-----------------------------------------------------------------------

	SUBROUTINE IDPC(X,SUMSQJ,IgIsGoodPoint,ICYCLE,JSUB,IG,
     1   LengthOfPX)
C ,rpar,ipar)

C  INPUT ARE: 

C  INFORMATION FROM A SUBJECT DATA FILE WHICH HAS BEEN READ IN 
C  PREVIOUSLY. THIS INFO IS PASSED TO THE OTHER ROUTINES IN THIS 
C  MODULE BY COMMONS /OBSER/, /CNST/, /CNST2/, AND  /SUM2/.


C  X(I) = ITH COORDINATE OF THE GRID POINT OF INTEREST (INCLUDING FIXED
C	  PARAMETER VALUES).
C  STDEV(I,J) = STD DEV FOR THE ITH OBSERVATION OF THE JTH OUTPUT EQ.
C               (INPUT IN BLANK COMMON TO SUBROUTINE FUNC).

C  OUTPUT IS:

C  SUMSQJ = SUM, FOR THIS SUBJECT, OVER I=1,M x NOS (ACTUALLY THE (I,J)
C  CONTRIBUTION IS IGNORED IF YO(I,J) = -99 --> MISSING VALUE), OF 
C  ((YO(I,J)-H(I,J))/STDEV(I,J))**2, WHERE H(I,J) = PREDICTED VALUE OF THE
C  JTH OUTPUT EQ AT THE ITH OBSERVATION TIME, ASSUMING THE IGTH GRID 
C  POINT, X. NOTE THAT M AND NOS ARE INPUT IN COMMONS SUM2 AND CNST2,
C  RESPECTIVELY.

C-----------------------------------------------------------------------

        IMPLICIT REAL*8(A-H,O-Z)
        DIMENSION X(32),P(32),PX(32)

C wmy2017Jul31
        integer IgIsGoodPoint, ICYCLE, JSUB, IG, LengthOfPX
C        integer, dimension(128) :: ipar
c        double precision, dimension(128) :: rpar


        COMMON/CNST/ N,ND,NI,NUP,NUIC,NP
        COMMON/PARAMD/ P

! NEW PARALLEL CODE BELOW AS OF idm1x17.f.
!$omp   Threadprivate(/PARAMD/,PX)

        save px

C*****INITIALIZE PROGRAM*****

!  AS OF npageng28.f/idm1x17.f, COMMENT OUT CALL TO SYMBOL HERE.
!	CALL SYMBOL

C  THE ABOVE CALL OBTAINS INFO FROM COMMONS.

C  FIND THE SUM OF SQUARES OF DIFFERENCES BETWEEN THE OBSERVED
C  VALUES AND THE PREDICTED VALUES (NORMALIZED BY THE ASSAY
C  VARIANCE OF EACH OBSERVATION) FOR THIS POINT.

C  PUT MODEL PARAMETER VALUES INTO P.

        DO I=1,NP
	  P(I)=X(I)
          PX(I)=X(I)
	END DO

C   SUMLM RETURNS FROM SUBROUTINE SUMSQ AS THE SUM OF SQUARES
C   FOR THIS SET OF (X1,X2,X3,X4,X5) VALUES.

c        write (*,*) "IDPC :: CALL SUMSQ(JSUB,IG)",JSUB,IG
   
	CALL SUMSQ(SUMLM,IgIsGoodPoint,ICYCLE,JSUB,IG,
     1    LengthOfPX,PX)
C ,rpar,ipar)

        SUMSQJ=SUMLM  

        RETURN
	END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
      SUBROUTINE FUNC(M,F,IgIsGoodPoint,ICYCLE,JSUB,IG,
     1   LengthOfPX,PX)
c ,rpar,ipar)

C  FUNCTION TO DETERMINE THE ENTRIES IN F, GIVEN P.

      IMPLICIT REAL*8(A-H,O-Z)

      Integer IgIsGoodPoint,ICYCLE,JSUB,IG,LengthOfPX
      double precision, dimension(32) :: PX

      COMMON/BOLUSCOMP/NBCOMP
      COMMON/OBSER/ TIM,SIG,RS,YO,BS
      COMMON/CNST/ N,ND,NI,NUP,NUIC,NP
      COMMON/INPUT/ R,B
      COMMON/PARAMD/ P
      COMMON/CNST2/ NPL,NOS,NDRUG,NADD
      COMMON/STATE/ X
      COMMON STDEV
      COMMON/ERR/ERRFIL
      PARAMETER(MAXNUMEQ=7)

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
!$omp Threadprivate(/PARAMD/,/INPUT/,/STATE/,RSO,BSO,SIGO,Y)   
c wmy -- the private directive should be in force from DO 800
!$omp Threadprivate(rpar,ipar)   
   
      DIMENSION X(20),P(32),TIM(594),SIG(5000),SIGO(5000),R(37),
     1 RS(5000,34),RSO(5000,34),YT(MAXNUMEQ),YO(594,MAXNUMEQ),F(3564),
     2 BS(5000,7),Y(594,MAXNUMEQ),B(20),NBCOMP(7),STDEV(594,MAXNUMEQ),
     3 FA(7),TLAG(7),XSTORE(100,20),XPRED(20),BSO(5000,7),
     4 XVERIFY(100)
! ADDED BSO(.,.) AS OF idm1x17.f.

C wmy2017Jul27 -- these are for storing the NM values between calls to DVODE
      double precision, dimension(128) :: rpar
      integer, dimension(128) :: ipar

      CHARACTER ERRFIL*20

! NEW PARALLEL CODE BELOW AS OF npageng28.f.
      Save RSO,BSO,SIGO,Y,rpar,ipar
c wmy save rpar,ipar ... IS necessary!!!
c wmy2017Aug01 -- make sure r/ipar is initialized

      write (*,*) "Assuming this is the place where code crashes"

      do III=1,128
         ipar(III)=0
         rpar(III)=0
      end do

      write (*,*) "Or not?!"

C  NOTE THAT AS OF idm1x15.f, THE DIMENSIONS OF 6 IN XSTORE AND XPRED
C  HAVE BEEN CHANGED TO 20, WHICH IS WHAT THEY SHOULD HAVE BEEN ALL
C  ALONG (I.E., THE SAME AS FOR X).

C  NOTE THAT THE 2ND DIMENSION OF STDEV AND YO IS MAXNUMEQ, WHICH
C  IS SET IN THE NEW PARAMETER STATEMENT ABOVE.
C  NOTE THAT THE DIMENSIONS RELATED TO THE NO. OF OUTPUT EQS. IN
C  YO, YT, STDEV, AND Y ARE CHANGED TO MAXNUMEQ (FROM 6). NUMEQT COULD
C  NOT BE USED BECAUSE THESE ARRAYS WERE NOT PASSED TO THIS ROUTINE AS
C  DUMMY ARGUMENTS.


C  NOTE THAT "7" IN THE ABOVE ARRAYS INDICATE THE NO. OF DRUGS ALLOWED.

C  NOTE THAT F HAS DIMENSION 3564 = 594*6 SINCE IT HAS NOS*M ENTRIES,
C  THE MAX VALUE OF NOS = 6, AND THE MAX VALUE FOR M = 99*6 = 594.

C  R(7) CHANGED TO R(20) <-- No. of 'rate inputs'
C  B(3) CHANGED TO B(20) <-- No. of different bolus inputs
C  CHANGED X(3) TO X(20) <-- No. of compartments
C  IC(10) CHANGED TO IC(20) <-- Initial conditions in compartments;
C 		should have been changed to 20 previously (like X,B).
C  NBCOMP(10) CHANGED TO NBCOMP(20) <-- Same remarks as for IC.
C  P(10) CHANGED TO P(32) <-- No. of parameters

C*****ODE CONSTANTS AND INITIALIZATION*****

      KNS=1
      KNT=1

C  NOTE THAT KNT IS THE RUNNING INDEX OF THE NEXT OBSERVATION TIME,
C  AND       KNS IS THE RUNNING INDEX OF THE NEXT DOSAGE TIME.

      T=0.0D0

c wmy 2017Jul27 ipar(25) <- Flag indicating first call to DVODE for (JSUB,IG)
       ipar(25) = 1

C debugging statement
C      write (*,*) "func(JSUB,IG) ipar(25)=", jsub, ig, ipar(25)


C  INITIALIZE ISKIPBOL = 0. SEE CODE BELOW. IT IS ONLY NEEDED FOR A
C  STEADY STATE DOSE SET WHICH HAS BOLUS DOSES.

      ISKIPBOL = 0


      DO I = 1,NDRUG
       R(2*I-1) = 0.D0
      END DO


!  AS OF idm1x17.f, ESTABLISH BSO(.,.), AND THEN USE BSO,RSO,SIGO,
!  AND NDO RATHER THAN BS,RS,SIG, AND ND FOR ALL CODE BELOW.

      DO I=1,ND
       DO J=1,NDRUG
        BSO(I,J)=RS(I,2*J)
       END DO
      END DO

c  AS OF idm1x7.f, instead of R(1) = 0, the code has been changed to 
c  set R(2*I-1) = 0, for I = 1,NDRUG. I.E., All IV rates for all NDRUG
c  drugs are initialized to be 0 ... in case the 1st obs. time is 0,
c  which means that OUTPUT is called before the R(I) are set below.


C  CALL SUBROUTINE GETFA IN npemdriv.f (THE FIRST TEMPLATE FILE TO 
C  INCLUDE GETFA IS TSTMULTG.FOR) TO OBTAIN THE VALUE OF FA FOR EACH
C  OF THE NDRUG DRUGS.

C  AS OF idm1x13.f, BEFORE CALLING GETFA, MUST SET
C  THE R(.) IN CASE ANY OF THE FA(.) ARE FUNCTIONS OF THE 
C  COVARIATES WHICH ARE ESTABLISHED FROM THE R(.) VALUES IN
C  GETFA.
 
      DO I=1,NI
       R(I)=RS(KNS,I)
      END DO

	 CALL GETFA(FA)


C  NOTE THAT NBCOMP(I),I=1,NDRUG WAS SET IN SUBROUTINE SYMBOL AND
C  PASSED TO THIS ROUTINE VIA COMMON/BOLUSCOMP.


C  As of idm1x12.f, the code to save ND0, SIGO, RSO, is moved to before
c  the IF(N .EQ. 0) GO TO 75  statement. The reason is that before this
c  routine returns, ND, SIG, and RS are reset back to these values,
c  even if N = 0, and so they must be established at this time.

C  AS OF idm1x9.f, SAVE ND, SIG, AND RS WHETHER OR NOT NTL = 1, SINCE
C  IF THERE ARE STEADY STATE DOSE SETS, THE FIRST SIG(.) VALUE IN EACH
C  SET WILL BE CHANGED TO BE 0 BELOW.

	 NDO = ND
	 DO I=1,NDO
	  SIGO(I) = SIG(I)
	  DO J=1,NI
	   RSO(I,J) = RS(I,J)
	  END DO
	 END DO



C  IF N = 0, THE OUTPUT EQUATION(S) FOR Y ARE CODED EXPLICITLY INTO
C  SUBROUTINE OUTPUT, AND NO D.E. SOLUTIONS (VIA USERANAL/DIFFEQ) ARE
C  TO BE USED. IN THIS CASE, SKIP THE CODE REGARDING INITIAL CONDITIONS
C  OF THE COMPARTMENTS, SINCE THEY ARE IRRELEVANT (I.E., THE COMPARTMENT
C  AMOUNTS DON'T NEED TO BE INITIALIZED SINCE THEY WON'T BE UPDATED BY
C  INTEGRATING D.E.'S). IN FACT, COULD PROBABLY SKIP TIMELAGS TOO, 
C  SINCE THEY CHANGE THE TIME THAT BOLUS DOSES ARE GIVEN, AND THIS
C  THEORETICALLY ONLY AFFECTS COMPARTMENT AMOUNTS (WHICH ARE NOT USED
C  IF N = 0), BUT JUST SKIP INITIAL CONDITIONS FOR NOW.

        IF(N .EQ. 0) GO TO 75


C  CALL SUBROUTINE GETIX IN npemdriv.f (THE FIRST TEMPLATE FILE TO 
C  INCLUDE GETIX IS TSTMULTG.FOR) TO OBTAIN THE VALUE OF X (THE INITIAL
C  COMPARTMENT AMOUNT) FOR EACH OF THE N COMPARTMENTS.

	 CALL GETIX(N,X)



C  CALL SUBROUTINE GETTLAG IN npemdriv.f (THE FIRST TEMPLATE FILE TO 
C  INCLUDE GETTLAG IS TSTMULTG.FOR) TO OBTAIN THE VALUE OF THE TIMELAG
C  FOR EACH OF THE NDRUG DRUGS.


   75	 CALL GETTLAG(TLAG)

C  IF ANY TLAG(.) VALUES RETURN AS .NE. 0, THEN, CALL SUBROUTINE SHIFT
C  TO ADJUST THE DOSAGE REGIMEN APPROPRIATELY.

      NTL = 0
      DO ID = 1,NDRUG
       IF(TLAG(ID) .NE. 0) NTL = 1
      END DO

	IF(NTL .EQ. 1) THEN

C  STORE INCOMING VALUES IN ND, SIG, AND RS (WHICH CONTAINS BS VALUES)
C  SINCE THEY WILL BE CHANGED IN THE CALL TO SUBROUTINE SHIFT, WHICH 
C  "SHIFTS" THE DOSAGE REGIMEN MATRIX TO ACCOUNT FOR THE TIMELAG 
C  PARAMETER(S), TLAG(I). AT THE END OF THIS ROUTINE, THE VALUES IN ND, 
C  SIG, AND RS WILL BE RESET TO THEIR INCOMING VALUES - TO BE READY FOR 
C  THE NEXT CALL TO THIS ROUTINE WITH POSSIBLY DIFFERENT VALUES FOR 
C  TLAG(I). NO! AS OF idm1x17.f, THE VALUES OF ND,SIG,RS,BS ARE 
C  NOT CHANGED; INSTEAD NDO,SIGO,RSO,BSO ARE USED.


	 CALL SHIFT(TLAG,NDO,SIGO,NDRUG,NADD,RSO)


C  ESTABLISH THE VALUES IN EACH DRUG'S PO COLUMN TO THE CORRESPONDING
C  COLUMN IN ARRAY BSO.


      DO I=1,NDO
       DO J=1,NDRUG
        BSO(I,J)=RSO(I,2*J)
       END DO
      END DO


	ENDIF

C  THE ABOVE ENDIF IS FOR THE  IF(NTL .EQ. 1)  CONDITION.

        IF(TIM(KNT).GE.SIGO(KNS)) GO TO 12
        IF(TIM(KNT).NE.0.0D0) GO TO 45

C  THE ONLY WAY THE FOLLOWING CALL TO OUTPUT CAN OCCUR IS IF TIM(KNT)
C  = 0 --> OBTAIN YT = OUTPUT VALUE(S) AT TIME 0.0.

        CALL OUTPUT(0.D0,YT)
        DO 2000 I=1,NOS
2000    Y(KNT,I)=YT(I)
        KNT=KNT+1
        GO TO 45

12      IF(TIM(KNT).GT.SIGO(KNS)) GO TO 13
        IF(TIM(KNT).NE.0.0D0) GO TO 45

C  THE ONLY WAY THE FOLLOWING CALL TO OUTPUT CAN OCCUR IS IF TIM(KNT)
C  = 0 --> OBTAIN YT = OUTPUT VALUE(S) AT TIME 0.0.

        CALL OUTPUT(0.D0,YT)
        DO 2005 I=1,NOS
2005    Y(KNT,I)=YT(I)
        KNT=KNT+1

13      IF(SIGO(KNS) .GT. 0.0D0) GO TO 45

C  CHECK TO SEE IF SIGO(KNS) < 0. IF SO, IT MEANS THAT 100 STEADY STATE
C  DOSES SHOULD NOW BE APPLIED WITH AN INTERDOSE INTERVAL EQUAL TO
C  -SIGO(KNS).

      ISTEADY = 0


      IF(SIGO(KNS) .LT. 0.D0) THEN


       ISTEADY = 1
       NSET = 1

C  NOTE THAT ISTEADY = 1 TELLS THE PROGRAM BELOW TO PROCEED AS IF THE
C  DOSE TIME IS 0, AND START INTEGRATING THROUGH THE SET OF 100 
C  DOSE SETS, ALL OF WHICH OCCUR BEFORE THE NEXT OBSERVATION TIME ...
C  BUT PAUSE AFTER THE END OF THE 5TH DOSE SET (NSET IS THE RUNNING NO.
C  OF THE CURRENT DOSE SETS THAT HAVE BEEN RUN) AND CALL SUBROUTINE
C  PREDLAST3 TO PREDICT THE STEADY STATE COMPARTMENT AMOUNTS AFTER THE
C  100 DOSE SETS (NOTE THAT THE COMPARTMENT AMOUNTS WILL HAVE TO BE
C  STORED AT THE END OF EACH OF THE STEADY STATE DOSE SETS AS THE LOGIC
C  OF PREDLAST3 REQUIRES). 


C  IF "CONVERGENCE" IS ACHIEVED AT THAT POINT, ASSIGN THE COMPARTMENT 
C  AMOUNTS TO BE THE PREDICTED AMOUNTS, AND ASSIGN KNS TO BE WHAT IT IS
C  WHEN THESE STEADY STATE DOSE SETS HAVE FINISHED. NOTE THAT THE END OF
C  THE 100TH DOSE SET WILL BE AT TIME 100*(-SIGO(KNS)), SO KNS WILL BE 
C  THE INDEX OF THE FIRST DOSE EVENT WHICH OCCURS AFTER THIS TIME.

C  IF "CONVERGENCE" IS NOT ACHIEVED, CONTINUE APPLYING THE LOGIC OF
C  PREDLAST3 UNTIL IT IS ACHIEVED, OR UNTIL THE 100 DOSE SETS ARE ALL
C  INTEGRATED THROUGH, WHICHEVER COMES FIRST.

       DOSEINT = -SIGO(KNS)

C  RESET SIGO(KNS) TO BE 0 SINCE THIS DOSE EVENT REPRESENTS THE START
C  OF 100 DOSE SETS THAT BEGIN AT TIME 0.


       SIGO(KNS) = 0

      ENDIF

C  THE ABOVE ENDIF IS FOR THE  IF(SIGO(KNS) .LT. 0.D0)  CONDITION.


      DO I=1,NI
       R(I)=RSO(KNS,I)
      END DO

      IF(NDRUG .EQ. 0) GO TO 81

C  AS OF idm1x13.f: MUST CALL GETFA BEFORE EVERY TIME THAT
C  FA(.) ARE USED IN CASE THE EQUATION(S) FOR THE FA(.) ARE BASED
C  ON THE COVARIATES, WHICH CAN CHANGE DOSE TO DOSE.

	 CALL GETFA(FA)


      IF(N .EQ. 0) GO TO 120

       DO I=1,NDRUG
       X(NBCOMP(I))=X(NBCOMP(I))+BSO(KNS,I)*FA(I)
      END DO

C  NOTE THAT FA(I) IS THE FRACTION OF DRUG AVAILABLE FROM A BOLUS INPUT
C  FOR DRUG I INTO ITS ABSORPTIVE COMPARTMENT.

      GO TO 81


120   DO I=1,NDRUG
       B(I)=BSO(KNS,I)*FA(I)
      END DO

81    KNS = KNS+1


C*****INTEGRATION OF EQUATIONS*****
  

C  DETERMINE IF, OBSER(ID=0), OR DOSE(ID=1), OR BOTH(ID=2).

! NEW PARALLEL CODE BELOW AS OF npageng28.f

!
!45    IF(KNS .GT. NDO) GO TO 15
! Replaced by below

 45   Continue
 

 46   IF(KNS .GT. NDO) GO TO 15

C CODE CHANGE BELOW FOR idm1x8.f.

      IF(TIM(KNT) .EQ. 0.D0 .AND. KNT .GT. 1) THEN

C  AS OF idm1x7.f, A TIME RESET NO LONGER REQUIRES ALL INITIAL
C  COMPARTMENT AMOUNTS TO BE RESET TO 0. THIS IS BECAUSE A TIME RESET
C  NO LONGER HAS TO MEAN THAT AN "INFINITE" AMOUNT OF TIME HAS OCCURRED
C  WITH NO DOSING; IT CAN ALSO NOW MEAN THAT AN "INFINITE" AMOUNT OF 
C  TIME HAS OCCURRED WITH UNKNOWN DOSING (IN THIS CASE, SUBROUTINE
C  GETIX WILL BE CALLED BELOW TO ESTABLISH INITIAL CONDITIONS FOR THIS
C  TIME PERIOD). 

C  ADVANCE KNS TO THE NEXT VALUE THAT HAS SIGO(KNS) .LE. 0. I.E., ONCE
C  TIMN(KNT) = 0, IT MEANS THAT WE ARE DONE WITH THE OUTPUT OBS.
C  TIMES IN THE PREVIOUS SECTION --> THERE IS NO POINT IN CONTINUING
C  TO INTEGRATE TILL THE END OF THE DOSES IN THE PREVIOUS SECTION
C  (IF THERE ARE ANY).

      DO IKNS = KNS,NDO
       IF(SIGO(IKNS) .LE. 0.D0) GO TO 110
      END DO

C  TO GET HERE MEANS THAT NO VALUE IN SIGO(.) FROM KNS TO NDO HAS A 
C  VALUE .LE. 0, AND THIS IS AN ERROR. IT MEANS THAT THE PATIENT DATA
C  FILE HAS AN OBSERVATION TIME RESET ROW WITHOUT AN ACCOMPANYING
C  DOSE RESET ROW. TELL THE USER AND STOP.

C  REPLACE WRITING OF SIGO() WITH XVERIFY (SEE LOGIC IN SUBROUTINE
C  VERIFYVAL.

       XVERIFY(1) = SIGO(KNS)
       CALL VERIFYVAL(1,XVERIFY)

C      WRITE(*,111) NDO,KNS,SIGO(KNS)
       WRITE(*,111) NDO,KNS,XVERIFY(1)

C      WRITE(25,111) NDO,KNS,SIGO(KNS)
       WRITE(25,111) NDO,KNS,XVERIFY(1)

 111  FORMAT(//' THE CURRENT SUBJECT HAS AN OBSERVATION TIME RESET'/
     1' ROW WITHOUT AN ACCOMPANYING DOSE RESET ROW. THE PROGRAM NOW'/
     2' STOPS. '//
     3' REVIEW YOUR PATIENT FILES AND CORRECT THE ERROR.'//
     4' NOTE THAT THE ',I4,' DOSE TIMES (POSSIBLY ALTERED BY TIMELAGS'/
     5' ARE THE FOLLOWING (AND THERE IS NO TIME .LE. 0 AFTER TIME'/
     6' NO. ',I4,' WHICH HAS CORRESPONDING TIME ',F15.4,'):')

       OPEN(42,FILE=ERRFIL)

C       WRITE(42,111) NDO,KNS,SIGO(KNS) 
        WRITE(42,111) NDO,KNS,XVERIFY(1) 

      DO I = 1,NDO
       WRITE(*,*) SIGO(I)
       WRITE(25,*) SIGO(I)
       WRITE(42,*) SIGO(I)
      END DO

       CLOSE(42)

      CALL PAUSE
      STOP


  110 KNS = IKNS


C  THERE ARE TWO POSSIBILITES AT THIS POINT, EITHER SIGO(KNS) = 0
C  OR SIGO(KNS) < 0. 

C  IF SIGO(KNS) = 0, THIS REPRESENTS A TIME RESET (T WILL BE SET = 0
C  BELOW) WITH A SINGLE DOSE LINE TO START. IN THIS CASE, CALL GETIX
C  AGAIN (JUST AS WAS DONE NEAR THE TOP OF THIS ROUTINE) TO OBTAIN
C  INITIAL COMPARTMENT AMOUNTS. NOTE THAT BY DEFAULT, IN GETIX, ALL
C  COMPARTMENT AMOUNTS ARE SET = 0 (WHICH WOULD BE THE CASE IF IN THE 
C  LONG TIME PERIOD BETWEEN THE LAST SET OF DOSES AND THIS NEW
C  BEGINNING, NO DOSES HAVE BEEN GIVEN). BUT THE USER MAY ALSO HAVE
C  CODED INTO GETIX EQUATIONS THAT SET ONE OR MORE OF THE X(I) TO
C  FUNCTIONS OF COVARIATE AND PARAMETER VALUES (WHICH WOULD BE THE
C  SITUATION IF AN UNKNOWN DOSING REGIMEN HAS TAKEN PLACE BUT IT
C  DOESN'T MATTER WHAT IT WAS BECAUSE THE PATIENT COMES TO A LAB AND
C  SIMPLY HAS HIS COMPARTMENT VALUES ESTABLISHED BEFORE CONTINUING 
C  WITH THE OTHER VALUES IN HIS PATIENT FILE). 

C  IF SIGO(KNS) < 0, THIS REPRESENTS A TIME RESET WITH A STEADY STATE
C  SET OF 100 DOSES ABOUT TO BEGIN. IN THIS CASE, WE ASSUME THAT THE
C  PATIENT IS ABOUT TO GET 100 SETS OF DOSES SO THAT HIS COMPARTMENT
C  AMOUNTS WILL ACHIEVE STEADY STATE VALUES. THESE STEADY STATE VALUES
C  WILL BE ESTIMATED IN THE BLOCK OF CODE BELOW THAT STARTS WITH 
C  IF(ISTEADY .EQ. 1). IN THIS CASE, WE WILL STILL CALL GETIX TO 
C  MAKE SURE THAT ANY RESIDUAL COMPARTMENT AMOUNTS FROM A PREVIOUS
C  SET OF DOSES IS ZEROED OUT (OR SET = VALUES AS DETERMINED BY
C  SUBROUTINE GETIX).

C  AS OF idm1x14.f, BEFORE CALLING GETIX, MUST SET
C  THE R(.) IN CASE ANY OF THE INITIAL CONDITIONS FOR THE X(.)
C  ARE FUNCTIONS OF THE COVARIATES WHICH ARE ESTABLISHED FROM THE 
C  R(.) VALUES IN GETFA.
 
      DO I=1,NI
       R(I)=RSO(KNS,I)
      END DO



        CALL GETIX(N,X)
		
C  MUST ALSO RESET T = 0 SINCE THE INTEGRATION WILL AGAIN START FROM 
C  TIME 0.

       T = 0.D0

C  IF SIGO(KNS) .LT. 0, THIS IS NOT ONLY A TIME RESET, IT IS THE
C  BEGINNING OF A STEADY STATE DOSE SET. IN THIS CASE, APPLY 100 
C  STEADY STATE DOSES WITH AN INTERDOSE INTERVAL EQUAL TO -SIGO(KNS).

      ISTEADY = 0

      IF(SIGO(KNS) .LT. 0.D0) THEN

       ISTEADY = 1
       NSET = 1

C  NOTE THAT ISTEADY = 1 TELLS THE PROGRAM BELOW TO PROCEED AS IF THE
C  DOSE TIME IS 0, AND START INTEGRATING THROUGH THE SET OF 100 
C  DOSE SETS, ALL OF WHICH OCCUR BEFORE THE NEXT OBSERVATION TIME ...
C  BUT PAUSE AFTER THE END OF THE 5TH DOSE SET (NSET IS THE RUNNING NO.
C  OF THE CURRENT DOSE SETS THAT HAVE BEEN RUN) AND CALL SUBROUTINE
C  PREDLAST3 TO PREDICT THE STEADY STATE COMPARTMENT AMOUNTS AFTER THE

C  100 DOSE SETS (NOTE THAT THE COMPARTMENT AMOUNTS WILL HAVE TO BE
C  STORED AT THE END OF EACH OF THE STEADY STATE DOSE SETS AS THE LOGIC
C  OF PREDLAST3 REQUIRES). 


C  IF "CONVERGENCE" IS ACHIEVED AT THAT POINT, ASSIGN THE COMPARTMENT 
C  AMOUNTS TO BE THE PREDICTED AMOUNTS, AND ASSIGN KNS TO BE WHAT IT IS
C  WHEN THESE STEADY STATE DOSE SETS HAVE FINISHED. NOTE THAT THE END OF
C  THE 100TH DOSE SET WILL BE AT TIME 100*(-SIGO(KNS)), SO KNS WILL BE 
C  THE INDEX OF THE FIRST DOSE EVENT WHICH OCCURS AFTER THIS TIME.

C  IF "CONVERGENCE" IS NOT ACHIEVED, CONTINUE APPLYING THE LOGIC OF
C  PREDLAST3 UNTIL IT IS ACHIEVED, OR UNTIL THE 100 DOSE SETS ARE ALL
C  INTEGRATED THROUGH, WHICHEVER COMES FIRST.

       DOSEINT = -SIGO(KNS)

C  RESET SIGO(KNS) TO BE 0 SINCE THIS DOSE EVENT REPRESENTS THE START
C  OF 100 DOSE SETS THAT BEGIN AT TIME 0.

       SIGO(KNS) = 0

      ENDIF

C  THE ABOVE ENDIF IS FOR THE  IF(SIGO(KNS) .LT. 0.D0)  CONDITION.



	ENDIF

C  THE ABOVE ENDIF IS FOR THE 
C   IF(TIM(KNT) .EQ. 0.D0 .AND. KNT .GT. 1)  CONDITION.



      IF(TIM(KNT) .NE. SIGO(KNS)) GO TO 20
      ID=2
      TOUT=TIM(KNT)
      KNT=KNT+1

      KNS=KNS+1

      IF(N .EQ. 0) GO TO 31
      GO TO 30

20    IF(TIM(KNT) .GT. SIGO(KNS) .AND. SIGO(KNS) .GT. 0) GO TO 25


15    ID=0
      TOUT=TIM(KNT)
      KNT=KNT+1
      IF(N .EQ. 0) GO TO 31
      GO TO 30

25    ID=1
      TOUT=SIGO(KNS)
      KNS=KNS+1
      IF(N .EQ. 0) GO TO 31

30      CONTINUE

C wmy 2015Apr22 -- PX was copied near beginning of (JSUB,IG) loop
C   Setting RPAR(I) = P,R,B
C   dvode_f90_m package reserves rpar and ipar 1:22; user
C   params must be on increments above 22 
        DO I = 1,32
          RPAR(I+22)=PX(I)
        END DO
        DO I = 1,37
          RPAR(I+32+22)=R(I)
        END DO
        DO I = 1,20
          RPAR(I+32+37+22)=B(I)
        END DO
C        RPAR(20+32+37+22+1)=NUMEQT
C        RPAR(20+32+37+22+2)=NDRUG
C        RPAR(20+32+37+22+3)=NADD
C        RPAR(20+32+37+22+4)=AGE
C       RPAR(20+32+37+22+5)=HEIGHT
        IPAR(1)=32
        IPAR(2)=37
        IPAR(3)=20
        IPAR(4)=3
        IPAR(5)=ISEX
        IPAR(6)=IETHFLAG
        IPAR(23)=JSUB
        IPAR(24)=IG
C        IPAR(25)=1 // must be set up BEFORE the TIN/TOUT looping begins
        IPAR(26)=IgIsGoodPoint
        IPAR(27)=LengthOfPX
        IPAR(28)=ICYCLE

c wmy2017Aug01 -- debugging statement
c        write (*,*) "0: func(J,IG;T)",JSUB,IG,T,ipar(25),rpar(23),P(1)
C        write (*,*) "0:",JSUB,IG,rpar(24),P(2),rpar(25),P(3)
C        write (*,*) "0:",JSUB,IG, rpar(26),P(4),rpar(27),P(5)
C        write (*,*) "0:",JSUB,IG,rpar(28),rpar(29),rpar(30)
C        write (*,*) "0:",JSUB,ipar(23),IG,ipar(24)

32      IF(N .NE. -1) CALL USERANAL(X,T,TOUT,IgIsGoodPoint,rpar,ipar)
        if (IgIsGoodPoint .ne. 1) then
          write (*,*) "USERANAL ret. IgIsGoodPoint .ne. 1", IgIsGoodPoint
          return
        endif
        IF(N .EQ. -1) CALL ANAL3(X,T,TOUT)
C wmy 2015Aug01 -- Set ipar(25) = 0 after CALL DVODE(...); not here.
C        InitIG = 0
C        ipar(25) = InitIG

C debugging statement
C        write (*,*) "1: func(J,IG;T)",JSUB,IG,T,ipar(25),rpar(23),P(1)
C      write (*,*) "func(JSUB,IG;T) ipar(25)=", jsub, ig, ipar(25),T,
C     1   "IPAR(23)=",ipar(23),"IPAR(24)",ipar(24),ipar(26)
C        write (*,*) "1: func(JSUB,IG,T)",JSUB,IG,T,rpar(23), P(1)
C        write (*,*) "1:",JSUB,IG,rpar(24),rpar(25),rpar(26),rpar(27)
C        write (*,*) "1:",JSUB,IG,rpar(28),rpar(29),rpar(30),rpar(31)

C  IF ISTEADY = 1, THIS IS INSIDE A STEADY STATE DOSE SET. CHECK TO SEE
C  IF TOUT IS A MULTIPLE OF DOSEINT. IF SO, RECORD THE COMPARTMENT
C  AMOUNTS. THEN, AFTER COMPARTMENT AMOUNTS HAVE BEEN STORED FOR AT 
C  LEAST THE 1ST 5 MULTIPLES OF DOSEINT, STOP AND CALL SUBROUTINE
C  PREDLAST3 WHICH PREDICTS THE FINAL (STEADY STATE) COMPARTMENT AMOUNTS
C  AFTER THE LAST (100TH) DOSE SET. 

C  IF PREDLAST3 HAS PREDICTED VALUES WHICH "CONVERGE", ASSIGN THE
C  PREDICTED VALUES TO X, INCREASE KNS TO BE THE INDEX OF THE FIRST DOSE
C  EVENT WHICH OCCURS AFTER THE STEADY STATE DOSE SET ENDS AND CONTINUE.

C  IF PREDLAST3 VALUES DON'T CONVERGE, CONTINUE THE PROCESS WITH 
C  COMPARTMENT AMOUNTS FOR MULTIPLES 2 - 6 OF DOSEINT, TEST FOR
C  "CONVERGENCE", ETC. THIS PROCESS CONTINUES UNTIL "CONVERGENCE" IS
C  ACHIEVED FOR A SET OF 5 COMPARTMENT AMOUNTS (OR SETS OF AMOUNTS IF
C  NDRUG IS > 1), OR UNTIL ALL 100 DOSE SETS IN THE STEADY STATE REGIMEN
C  HAVE FINISHED. 

      IF(ISTEADY .EQ. 1) THEN


C  THE NEXT DOSE SET END TIME IS DOSEINT*NSET. IF TOUT = DOSEINT*NSET,
C  STORE THE COMPARTMENT AMOUNTS. IF NSET .GE. 5, CALL PREDLAST3 AND
C  PROCEED AS INDICATED ABOVE.

       CALL THESAME(TOUT,DOSEINT*NSET,ISAME)

       IF(ISAME .EQ. 1) THEN

        NN = N
        IF(N .EQ. -1) NN = 3

        DO J = 1,NN
         XSTORE(NSET,J) = X(J)
        END DO


        IF(NSET .GE. 5) THEN

         CALL PREDLAST3(NN,NSET,XSTORE,XPRED,ICONV)

  
         IF(ICONV .EQ. 1) THEN

C  SINCE THE PREDICTED VALUES ARE CONSIDERED ACCURATE (I.E., 
C  "CONVERGENCE WAS ACHIEVED IN PREDLAST), RESET ISTEADY TO 0,
C  WHICH MEANS THAT THE STEADY STATE DOSES ARE FINISHED; ASSIGN THE
C  COMPARTMENT AMOUNTS TO BE THE PREDICTED VALUES; AND SET KNS TO THE
C  FIRST DOSE EVENT AFTER THE END OF THE STEADY STATE DOSE SET. ALSO,
C  SET T = THE ENDING TIME OF THE STEADY STATE DOSE SET = 100*DOSEINT,
C  SINCE THAT IS WHAT IT WOULD HAVE BEEN HAD ALL 100 DOSE SETS BEEN
C  RUN.

          ISTEADY = 0

          DO J = 1,NN
           X(J) = XPRED(J)
          END DO

          T = 100.D0*DOSEINT


C  ADVANCE KNS TO BE THE FIRST DOSE PAST THE 100 DOSE SETS IN THIS
C  STEADY STATE SET. NOTE THAT THIS SET ENDS BEFORE 100*DOSEINT, SO
C  FIND THE FIRST SIGO(.) THAT IS .GE. 100*DOSEINT, OR THAT IS = 0
C  (WHICH SIGNIFIES A TIME RESET) OR THAT IS < 0 (WHICH SIGNIFIES 
C  ANOTHER STEADY STATE SET).

          DO I = KNS,NDO
           IF(SIGO(I) .GE. 100.D0*DOSEINT .OR. SIGO(I) .LE. 0.D0) THEN
            KNSNEW = I
            GO TO 100
           ENDIF
          END DO

C  TO GET HERE MEANS THAT THERE ARE NO DOSE TIMES PAST THE END OF THIS
C  STEADY STATE DOSE SET. IN THIS CASE, SET KNS TO NDO+1.

          KNS = NDO+1
          GO TO 200

  100     KNS = KNSNEW
  200     CONTINUE


C  SET ISKIPBOL = 1 WHENEVER CONVERGENCE OCCURS IN
C  THE STEADY STATE DOSES SINCE IN THIS CASE, WE DON'T WANT TO
C  REAPPLY THE LAST BOLUS FROM THE STEADY STATE SET BELOW LABEL 83.

          ISKIPBOL = 1

         ENDIF


C  THE ABOVE ENDIF IS FOR THE  IF(ICONV .EQ. 1)  CONDITION.

C  IF ICONV = 0, ISTEADY IS STILL = 1, 
C  WHICH MEANS THAT THE ATTEMPT TO PREDICT THE FINAL (STEADY STATE)
C  COMPARTMENT AMOUNTS CONTINUES.
          
        ENDIF
      
C  THE ABOVE ENDIF IS FOR THE  IF(NSET .GE. 5)  CONDITION.

C  SINCE ISAME = 1, THE END OF THE SET NO. NSET HAS OCCURRED -->
C  INCREASE NSET BY 1.


        NSET = NSET + 1

       ENDIF

C  THE ABOVE ENDIF IS FOR THE  IF(ISAME .EQ. 1)  CONDITION.

      ENDIF

C  THE ABOVE ENDIF IS FOR THE  IF(ISTEADY .EQ. 1)  CONDITION.



31      CONTINUE

C  RECORD OBSERVATION AND SUPPLY NEW DOSE

        IF(ID .EQ. 1) GO TO 35
        KNTM1=KNT-1

C  NOTE THAT THE TIME AT WHICH THE OUTPUT IS DESIRED IS TIM(KNTM1); THIS
C  IS CLEAR SINCE THE RETURNING VALUE(S) IN YT ARE PUT INTO ROW NO.
C  KNTM1 OF Y.

        CALL OUTPUT(TIM(KNTM1),YT)

        DO 2010 I=1,NOS
2010    Y(KNTM1,I)=YT(I)

55      IF(ID.EQ.0) GO TO 40

  35    CONTINUE

        IF(NI .EQ. 0) GO TO 83 
     
        DO I=1,NI
         R(I)=RSO(KNS-1,I)
        END DO

C  AS OF idm1x13.f: MUST CALL GETFA BEFORE EVERY TIME THAT
C  FA(.) ARE USED IN CASE THE EQUATION(S) FOR THE FA(.) ARE BASED
C  ON THE COVARIATES, WHICH CAN CHANGE DOSE TO DOSE.

	 CALL GETFA(FA)


83      IF(NDRUG .EQ. 0 .OR. N .EQ. 0) GO TO 82

C  ADDING N .EQ. 0 TO ABOVE IF STATEMENT SHOWS CLEARLY THAT IF
C  N = 0 (IN WHICH CASE ANALYTIC SOLUTIONS ARE CODED DIRECTLY INTO
C  SUBROUTINE OUTPUT, WHICH MAKES THE COMPARTMENT AMOUNTS IRRELEVANT)
C  SETTING VALUES FOR THE COMPARTMENTS, X, IS UNNECESSARY.


C  IF ISKIPBOL = 1, DO NOT APPLY BOLUSES FROM DOSE KNS-1, SINCE THESE
C  BOLUSES WERE PART OF THE STEADY STATE DOSE SET WHICH ALREADY HAD
C  BOLUSES (EFFECTIVELY) APPLIED ABOVE WHERE "CONVERGENCE" OF THE
C  STEADY STATE DOSE SET WAS OBTAINED.

        IF(ISKIPBOL .EQ. 0) THEN
         DO I=1,NDRUG
          X(NBCOMP(I))=X(NBCOMP(I))+BSO(KNS-1,I)*FA(I)
         END DO
        ENDIF

C  RESET ISKIPBOL = 0 HERE. IF IT IS NOW = 1, IT MEANS THAT
C  THE ABOVE APPLICATION OF BOLUSES WAS SKIPPED SINCE THERE HAS JUST
C  BEEN A STEADY STATE SET OF DOSES WHICH CONVERGED (AND WE DON'T
C  WANT THE LAST BOLUS DOSE REAPPLIED). BUT, GOING FORWARD, ISKIPBOL
C  SHOULD BE SET AGAIN TO 0 SO THE ABOVE APPLICATION OF BOLUSES WILL
C  OCCUR WHENEVER THERE IS A NEW BOLUS TO BE APPLIED.

      ISKIPBOL = 0


82      CONTINUE

C  CHECK STOPPING TIME.


40      IF(KNT .LE. M) GO TO 46
C  AS OF npageng28.f, GO TO 45 IS REPLACE BY GO TO 46 ABOVE.

C*****DETERMINE F(I)*****

C  NOTE THAT IF YO(I,J) = -99 --> THIS OBSERVED LEVEL IS MISSING.
C  IN THIS CASE, SET THE CORRESPONDING VALUE OF F = 0.

        DO J=1,NOS
         DO I=1,M
	  IF(YO(I,J) .EQ. -99) F((J-1)*M+I) = 0.D0
          IF(YO(I,J) .NE. -99) F((J-1)*M+I) =(Y(I,J)-YO(I,J))/STDEV(I,J)
	 END DO
	END DO


C  AS OF idm1x9.f, RESTORE THE VALUES FOR ND, SIG, AND RS, IN CASE
C  THIS MODEL HAS TIME LAGS OR STEADY STATE DOSES - TO BE READY FOR THE
C  NEXT CALL TO THIS ROUTINE.
C  NO! AS OF idm1x17.f, THESE VALUES WERE NEVER CHANGED BECAUSE
C      NDO, SIGO, RSO, BSO WERE USED ABOVE INSTEAD.

! NEW PARALLEL CODE BELOW AS OF npageng28.f


!	 ND = NDO
!	 DO I=1,ND
!	  SIG(I) = SIGO(I)
!	  DO J=1,NI
!	   RS(I,J) = RSO(I,J)
!	  END DO
!	 END DO

C  ESTABLISH THE VALUES IN EACH DRUG'S PO COLUMN TO THE CORRESPONDING
C  COLUMN IN ARRAY BS.

!         DO I=1,ND
!          DO J=1,NDRUG
!           BS(I,J)=RS(I,2*J)
!	  END DO
!	 END DO


      RETURN
      END
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
        SUBROUTINE SUMSQ(SSQ,IgIsGoodPoint,ICYCLE,JSUB,IG,
     1   LengthOfPX,PX)
C ,rpar,ipar)

C  SUBROUTINE TO EVALUATE THE SUM OF SQUARES OF THE RESIDUAL VECTOR.

        IMPLICIT REAL*8(A-H,O-Z)

c wmy2017Jul31
        integer IgIsGoodPoint,ICYCLE,JSUB,IG,LengthOfPX
        double precision, dimension(32) :: PX
C        double precision, dimension(128) :: rpar
C        integer, dimension(128) :: ipar

        COMMON/SUM2/ M,NPNL
        COMMON/CNST2/ NPL,NOS,NDRUG,NADD
        DIMENSION F(3564)

C  NOTE THAT F HAS DIMENSION 3564 = 594*6 SINCE IT HAS NOS*M ENTRIES,
C  THE MAX VALUE OF NOS = 6, AND THE MAX VALUE FOR M = 99*6 = 594.

        CALL FUNC(M,F,IgIsGoodPoint,ICYCLE,JSUB,IG,
     1    LengthOfPX,PX)
        SSQ=0.0D0
        if (IgIsGoodPoint == 1) then
         NUMRES=M*NOS
         DO 10 I=1,NUMRES
10        SSQ=SSQ+F(I)*F(I)
        endif
        RETURN

        END
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
        SUBROUTINE USERANAL(X,TIN,TOUT,IgIsGoodPoint,rpar,ipar)

C  PURPOSE:
C	GIVEN X(TIN) THE PROGRAM CALCULATES X(TOUT), WHERE X IS THE 
C	STATE VECTOR FOR THE MODEL UNDER CONSIDERATION (AS DEFINED
C	BY THE D.E'S IN SUBROUTINE DIFFEQ). THESE D.E'S ARE SOLVED
C	USING THE LINPACK ROUTINE, VODE.FOR (AND ASSOCIATED ROUTINES).

C  	THIS ROUTINE CALLS SUBROUTINE DVODE (VODE.FOR) ONCE FOR EACH
C	POINT AT WHICH ANSWERS ARE DESIRED. NOTE THAT DVODE WILL CALL
C	SUBROUTINE DIFFEQ (SUPPLIED BY THE USER -- IT GIVES THE 
C	DIFF. EQS. OF THE MODEL, XP(I)) AND, IF THE USER DESIRES,
C	SUBROUTINE JACOB (SUPPLIED BY THE USER -- IT GIVES THE 
C	JACOBIAN OF PARTIAL DERIVATIVES, dXP(I)/dX(J)). SUBROUTINES
C	DIFFEQ AND JACOB ARE IN THIS MODULE.

C  ARGUMENTS ON INPUT:
C           X - AN ARRAY OF DIMENSION 20. IN THE STANDARD 3-COMPARTMENT
C		MODEL,  X(1), X(2), X(3) SHOULD
C               BE SET TO THE AMOUNT OF DRUG IN THE ABSORBTION,
C               CENTRAL, AND PERIPHERAL COMPARTMENTS, RESPECTIVELY,
C               AT TIME T=TIN.
C         TIN - CURRENT VALUE OF TIME.
C        TOUT - TIME AT WHICH SOLUTION IS DESIRED.

C	VALUES FROM COMMON/TOUSER (FROM MXEM2__/MAIN) WHICH WERE INPUT
C 	REAL-TIME BY THE USER (SEE DETAILS BELOW).
C	 NDIM = NO. OF STATES IN MODEL (.LE. 3 FOR NOW).
C	 MF = METHOD FLAG.
C	 RTOL = SCALAR RELATIVE TOLERANCE PARAMETER.
C	 ATOL(I), I=1,NDIM = ABSOLUTE TOLERANCE PARAMETERS.

C  ARGUMENTS ON OUTPUT:
C           X - THE COMPARTMENT AMOUNTS AT T=TOUT.
C         TIN - SET AT TOUT

        IMPLICIT REAL*8(A-H,O-Z)
        DIMENSION X(20),ATOL(20),RWORK(1002),IWORK(50)

C  AS OF idm1x16.f, THE DIMENSION OF RWORK IS CHANGED FROM 300 TO
C  1002 TO ACCOMADATE AN NDIM (NEQ IN SUBROUTINE DVODE) OF UP TO 20. SO
C  CHANGE LRW BELOW TO 1002. SIMILARLY THE DIMENSION OF IWORK AND
C  LIW BELOW ARE CHANGED FROM 40 TO 50.



	EXTERNAL DIFFEQ,JACOB

C wmy2017Jul31 -- rpar and ipar are (JSUB,IG) specific, initialization
C   should happen way up in the DO 800 loop; w/changes to specific
C   values only if necessary during the calculation.
        integer IgIsGoodPoint
        INTEGER, DIMENSION(128) :: ipar
        double precision, dimension(128) :: rpar

	COMMON/TOUSER/NDIM,MF,RTOL,ATOL

C  THE LOGIC OF THIS CODE IS TAKEN FROM PROGRAM DESOLV3.FOR (4/28/96).

C  FOLLOWING VALUES ARE SUPPLIED TO SUBROUTINE DVODE:

C  DIFFEQ  = NAME OF SUBROUTINE COMPLETED BY USER WHICH GIVES THE D.E.'S 
C	     OF THE MODEL. IT MUST BE DECLARED EXTERNAL.
C TIN      = The initial value of the independent variable.

C TOUT   = First point where output is desired (.ne. TIN). 
C ITOL   = 2 SINCE ATOL IS AN ARRAY.
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
C ITASK  = 1 for normal computation of output values of X at t = TOUT.
C ISTATE = Integer flag (input and output).  Set ISTATE = 1.
C IOPT   = 0 to indicate no optional input used.
C RWORK  = Real work array of length at least..
C             20 + 16*NDIM                      for MF = 10,
C             22 +  9*NDIM + 2*NDIM**2           for MF = 21 or 22,
C             22 + 11*NDIM + (3*ML + 2*MU)*NDIM  for MF = 24 or 25.
C	... I'LL USE AN ARRAY OF 300 (PLENTY FOR NDIM .LE. 8).
C LRW    = Declared length of RWORK (in user's DIMENSION statement).
C IWORK  = Integer work array of length at least..
C             30        for MF = 10,
C             30 + NDIM  for MF = 21, 22, 24, or 25.
C          If MF = 24 or 25, input in IWORK(1),IWORK(2) the lower
C          and upper half-bandwidths ML,MU.
C	... I'LL USE AN ARRAY OF 40 (PLENTY FOR NDIM .LE. 8).
C LIW    = Declared length of IWORK (in user's DIMENSION).
C JACOB    = Name of subroutine COMPLETED BY USER for Jacobian matrix 
C	     (MF = 21 or 24). If used, this name must be declared 
C	     external.  If not used, pass a dummy name.
C MF     = Method flag.  Standard values are..
C          10 for nonstiff (Adams) method, no Jacobian used.
C          21 for stiff (BDF) method, user-supplied full Jacobian.
C          22 for stiff method, internally generated full Jacobian.

C          24 for stiff method, user-supplied banded Jacobian.
C          25 for stiff method, internally generated banded Jacobian.
C RPAR,IPAR = user-defined real and integer SCALARS OR arrays passed to 
C	      DIFFEQ AND JACOB.

C Note that the main program must declare arrays X, RWORK, IWORK,
C and possibly ATOL, RPAR, and IPAR.


C  THE FOLLOWING VALUES RETURN FROM CALLS TO SUBROUTINE DVODE.

C      X = Array of computed values of X vector (AT TIME TOUT).
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

	ITOL=2
	ITASK=1
	ISTATE=1
	IOPT=0
	LRW=1002
	LIW=50

C        IPAR(26) = IgIsGoodPoint -- But at this point, IgIsGoodPoint can only = 1
        IPAR(26) = 1

C debugging statement
C        write (*,*) "User(J,IG;T)",ipar(23),ipar(24),TIN,rpar(23)
C        write (*,*) "JSUB, IG, rpar(23...)",ipar(23),ipar(24),
C     1   rpar(23),rpar(24),rpar(25),rpar(26),rpar(27),rpar(28),
C     2   rpar(29),rpar(30),rpar(31)

        CALL DVODE(DIFFEQ,NDIM,X,TIN,TOUT,ITOL,RTOL,ATOL,ITASK,ISTATE,
     1            IOPT,RWORK,LRW,IWORK,LIW,JACOB,MF,RPAR,IPAR)

C wmy 2017Aug01
C DVODE(JSUB,IG) has been called at least once for (JSUB,IG)
C also set to 0 after first call to USERANAL b/c it doesn't seem
C to work here!?
        ipar(25) = 0
C if (ipar(26) == 0) Set Pr(JSUB|IG) = 0 in main;
        IgIsGoodPoint = IPAR(26)

c        IF (ISTATE .LT. 0) THEN
c         WRITE(*,16) ISTATE
c 16      FORMAT(///' On return from DVODE, ISTATE =',I3)
c	ENDIF



	TIN=TOUT

        RETURN
        END
C

CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
	SUBROUTINE JACOB(NDIM, T, X, ML, MU, PD, NRPD, RPAR, IPAR)

	IMPLICIT REAL*8(A-H,O-Z)
        COMMON/PARAMD/ P
        COMMON/INPUT/ R,B
        DIMENSION X(NDIM), PD(NRPD,NDIM), P(32),R(37),B(20)

! NEW PARALLEL CODE BELOW AS OF npageng28.f
!$omp Threadprivate(/PARAMD/,/INPUT/)


C  THIS ROUTINE IS CALLED BY LINPACK ROUTINE DVODE (WHICH IS CALLED
C  BY ROUTINE USERANAL). THE USER CODES THE JACOBIAN MATRIX CALCULATIONS
C  OF THE MODEL (I.E., THE PARTIAL DERIVATIVES OF XP(I) W.R.T. X(I),
C  WHERE XP(I) WERE CODED INTO ROUTINE DIFFEQ).


C  SINCE THIS ROUTINE CAN'T BE MADE BY THE 'BOXES' PROGRAM AT THIS TIME,
C  IT WILL NOT BE USED. IT IS JUST A DUMMY ROUTINE, NEEDED BECAUSE
C  DVODE EXPECTS TO 'SEE' IT.

C  INPUT ARE:

C  NDIM = NO. OF STATES (DIMENSION OF PROBLEM).

C  T = CURRENT TIME.
C  X(I) = VALUE OF STATE I AT T, I=1,NDIM.
C  [ML,MU] = HALF BANDWIDTH PARAMETERS ... UNNEEDED IF MF = 21 OR 22
C            --> FULL JACOBIAN IS PROVIDED BY USER BELOW (SEE 
C	     DESOLV3.FOR CODE FOR DETAILS).
C	     NOTE THAT SINCE MF = 21 OR 22 IN THIS CASE, NRPD = NDIM.
C  R AND B VIA COMMON/INPUT.



C  OUTPUT ARE:


C  PD(I,J) = PARTIAL DERIVATIVE OF XP(I) W.R.T. X(J), WHERE XP(I)
C	     ARE CALCULATED IN ROUTINE DIFFEQ ABOVE.

        RETURN
        END							  
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
      SUBROUTINE PREDLAST3(NN,NSET,XSTORE,XPRED,ICONV)

      IMPLICIT REAL*8(A-H,O-Z)
      DIMENSION XSTORE(100,20),XPRED(20),COMP(5,20)

C  NOTE THAT AS OF idm1x15.f, THE DIMENSIONS OF 6 IN XSTORE, XPRED,
C  AND COMP HAVE BEEN CHANGED TO 20, WHICH IS WHAT THEY SHOULD HAVE BEEN

C  ALL ALONG (SEE SUBROUTINE FUNC).


C  THIS SUBROUTINE IS CALLED BY SUBROUTINE FUNC WITH NSET SETS OF NN
C  COMPARTMENT  VALUES IN XSTORE. USE THE LAST 5 SETS OF VALUES TO
C  PREDICT THE FINAL (STEADY STATE) COMPARTMENT AMOUNTS AFTER THE LAST
C  (100TH) DOSE SET. 

C  IF THESE VALUES "CONVERGE", SET ICONV = 1, AND WRITE THE PREDICTED
C  VALUES INTO XPRED. IF THEY DON'T CONVERGE, SET ICONV = 0.

C  TOL1 AND TOL2 ARE, FOR NOW, HARDCODED TO BE .0005.

        TOL1 = .0005D0
        TOL2 = .0005D0


C  THE LAST 5 SETS OF VALUES ARE IN XSTORE(NSET-4:NSET,.). PUT THESE
C  VALUES INTO COMP(.,.).

      II = 0
    
      DO I = NSET-4,NSET
       II = II+1
       DO J = 1,NN
        COMP(II,J) = XSTORE(I,J)
       END DO
      END DO



C  FOR EACH COMPARTMENT AMOUNT, SEE IF THE FINAL STEADY STATE COMP.
C  AMOUNT CAN BE PREDICTED ACCURATELY.

      DO IN = 1,NN

       A1 = COMP(1,IN)
       A2 = COMP(2,IN)
       A3 = COMP(3,IN)
       DEL1 = A2 - A1
       DEL2 = A3 - A2

C  TEST FOR DEL1 = 0. IF SO, SEE ISAMETOT BELOW.

       CALL THESAME(DEL1,0.D0,ISAME1)

       IF(ISAME1 .EQ. 0) THEN

        F = DEL2/DEL1

C  THE UNDERLYING ASSUMPTION IS THAT THE RATIO F = DEL2/DEL1
C  IS CONTANT BETWEEN CONSECUTIVE OUTPUT DIFFERENCES. IF SO, THEN
C  THE STEADY STATE VALUE WILL BE A1 + DEL1/(1 - F) (SEE SS.EXP
C  IN \ALAN3\STEADYSTATE). CALCULATE THIS VALUE AND CALL IT PRED1.

C  BUT, IF DEL2 = DEL1, THEN F = 1. IN THIS CASE, CAN'T DO THE FOLLOWING 
C  CALCULATION FOR PRED1, AND WE WOULDN'T WANT TO DO IT SINCE 
C  DEL2 = DEL1 --> A2 - A1 = A3 - A2 --> A1, A2, AND A3 ARE IN AN 
C  ARITHMETIC PROGRESSION --> THERE OBVIOUSLY CAN BE NO CONVERGENCE
C  SINCE, AFTER 100 DOSES, THE VALUE WOULD JUST A1 + 99*DEL1 ... 
C  UNLESS DEL1 = 0, IN WHICH CASE THE VALUE WOULD CONVERGE TO A1.
C  IN THIS CASE SET ISAMEF1 = 1, AND SKIP CALC. OF PRED1. AND THEN
C  SEE THE LOGIC RELATED TO ISAMEF1 BELOW.



        CALL THESAME(F,1.0,ISAMEF1)
        IF(ISAMEF1 .EQ. 0) PRED1 = A1 + DEL1/(1.D0 - F)

       ENDIF


C  SIMILARLY, CALCULATE PRED2 (BASED ON (A2,A3,A4)) AND PRED3 (BASED
C  ON (A3,A4,A5).

       A1 = COMP(2,IN)

       A2 = COMP(3,IN)
       A3 = COMP(4,IN)
       DEL1 = A2 - A1
       DEL2 = A3 - A2

C  TEST FOR DEL1 = 0. IF SO, SEE ISAMETOT BELOW.

       CALL THESAME(DEL1,0.D0,ISAME2)

       IF(ISAME2 .EQ. 0) THEN
        F = DEL2/DEL1


        CALL THESAME(F,1.0,ISAMEF2)
        IF(ISAMEF2 .EQ. 0) PRED2 = A1 + DEL1/(1.D0 - F)

       ENDIF

       A1 = COMP(3,IN)
       A2 = COMP(4,IN)
       A3 = COMP(5,IN)
       DEL1 = A2 - A1
       DEL2 = A3 - A2

C  TEST FOR DEL1 = 0. IF SO, SEE ISAMETOT BELOW.

       CALL THESAME(DEL1,0.D0,ISAME3)

       IF(ISAME3 .EQ. 0) THEN
        F = DEL2/DEL1


        CALL THESAME(F,1.0,ISAMEF3)
        IF(ISAMEF3 .EQ. 0) PRED3 = A1 + DEL1/(1.D0 - F)
       ENDIF


C  ASSUMING A NEGATIVE EXPONENTIAL PATTERN FIT (SEE SS.EXP IN 
C  \ALAN3\STEADYSTATE OR HOME NOTES, PG.2 ON 9/11/11 FOR DETAILS) ON
C (PRED1,PRED2,PRED3), CALCULATE PREDNEG.

C  BUT ONLY DO THIS CALCULATION, AND THE SUBSEQUENT 
C  CONVERGENCE DETERMINATION IF ISAME1 = ISAME2 = ISAME3 = 0, AND
C  ISAMEF1 = ISAMEF2 = ISAMEF3 = 0. OTHERWISE, AT LEAST ONE OF THE
C  PREDICTED VALUES ABOVE WAS NOT CALCULATED.

       ISAMETOT = ISAME1 + ISAME2 + ISAME3
       ISAMEFTOT = ISAMEF1 + ISAMEF2 + ISAMEF3


       IF(ISAMETOT .EQ. 0 .AND. ISAMEFTOT .EQ. 0) THEN

C EDITED CODE BELOW FOR idm1x11.f.

C  IF PRED1 + PRED3 - 2*PRED2 = 0, PREDNEG (SEE BELOW) CANNOT BE 
C  CALCULATED. IN THIS CASE, PRED2 - PRED1 = PRED3 - PRED2 --> 
C  THE SEQUENCE (PRED1, PRED2, PRED3) IS LINEAR, WHICH CANNOT BE 
C  MODELED WITH AN EXPONENTIAL FIT (SEE COMMENTS ABOVE). SO, IF THIS
C  HAPPENS, CONVERGENCE WILL BE SATISFIED IF THESE 3 VALUES ARE 
C  VIRTUALLY THE SAME - I.E., ONLY THE REQUIREMENT INVOLVING TOL1
C  WILL BE NEEDED FOR CONVERGENCE (RECALL THE ONLY REASON FOR THE
C  EXTRA NEGATIVE EXPONENTIAL FIT, AND THE CALCULATION OF PREDNEG IS FOR
C  THOSE CASES WHERE PRED1, PRED2, AND PRED3 ARE NOT ALL VIRTUALLY THE
C  SAME VALUE).

        DEN = PRED1+PRED3-2.D0*PRED2
        CALL THESAME(DEN,0.D0,ISAMEDEN)
      
        IF(ISAMEDEN .EQ. 0) PREDNEG = (PRED1*PRED3 - PRED2*PRED2)/DEN

C  NOW CHECK FOR CONVERGENCE, WHICH HAS BEEN OBTAINED IF 
C  |PRED3/PRED2 - 1| < TOL1 AND |PREDNEG/PRED3 - 1| < TOL2. 

        ICONV = 1
        IF(DABS(PRED3/PRED2 - 1.D0) .GE. TOL1) ICONV = 0
        IF(ISAMEDEN .EQ. 0 .AND. DABS(PREDNEG/PRED3 - 1.D0) .GE. TOL2)
     1   ICONV = 0

C  IF ICONV = 1 FOR THIS COMPARTMENT, IN, STORE THE PREDICTED AMOUNT,
C  AND CONTINUE TO THE NEXT COMPARTMENT. NOTE BELOW THAT 
C  NON-CONVERGENCE IN ANY COMPARTMENT ENDS THE PROCESS SINCE TO
C  CONVERGE, ALL COMPARTMENT PREDICTIONS MUST CONVERGE.

        IF(ICONV .EQ. 1 .AND. ISAMEDEN .EQ. 1) XPRED(IN) = PRED3 
        IF(ICONV .EQ. 1 .AND. ISAMEDEN .EQ. 0) XPRED(IN) = PREDNEG

C EDITED CODE ABOVE FOR idm1x11.f.

       ENDIF

C  THE ABOVE ENDIF IS FOR THE  IF(ISAMETOT .EQ. 0 .AND. ISAMEFTOT .EQ.0)
C  CONDITION.


C  IF ISAMETOT .GT. 0, THERE ARE TWO POSSIBILITIES (AND NOTE THAT IT
C  DOSEN'T MATTER WHAT ISAMEFTOT IS IN THIS CASE):

C   ISAMETOT = 3, IN WHICH CASE COMP(1:4,IN) ARE ALL THE SAME.
C   ISAMETOT = 1 OR 2, IN WHICH CASE SOME OF THE COMP(1:4,IN) VALUES
C     ARE THE SAME, AND SOME ARE NOT.

C  IN THE FORMER CASE, VERIFY THAT COMP(5,IN) IS THE SAME VALUE AS
C  THE COMP(1:4,IN). IF SO, SET THE PREDICTED VALUE = THIS VALUE
C  (I.E., THE PREDICTED VALUE FOR A CONSTANT FUNCTION IS THE
C  CONSTANT VALUE), AND SET ICONV = 1. OTHERWISE, SET ICONV = 0
C  SINCE THERE IS NO WAY TO FIT 4 VALUES WHICH ARE THE SAME AND ONE
C  WHICH IS NOT USING A NEGATIVE EXPONENTIAL FUNCTION.

C  IN THE LATTER CASE, SINCE SOME OF THE COMP(1:4,IN) VALUES ARE THE
C  SAME, AND SOME ARE NOT, SET ICONV = 0 FOR THE SAME REASON AS 
C  STATED IN THE PREVIOUS PARAGRAPH.


       IF(ISAMETOT .EQ. 3) THEN

        CALL THESAME(COMP(5,IN),COMP(1,IN),ISAME)

        IF(ISAME .EQ. 1) THEN
         ICONV = 1
         XPRED(IN) = COMP(1,IN)
        ENDIF

        IF(ISAME .EQ. 0) ICONV = 0
  
       ENDIF

       IF(ISAMETOT .EQ. 1 .OR. ISAMETOT .EQ. 2) ICONV = 0


C  IF ICONV = 0, CONVERGENCE WAS NOT ACHIEVED.

       IF(ICONV .EQ. 0) RETURN


      END DO

C  THE ABOVE END DO IS FOR THE  DO IN = 1,NN  LOOP.

C  TO GET TO THIS POINT, ALL COMPARTMENT AMOUNTS HAVE CONVERGED, AND
C  THEIR PREDICTED AMOUNTS HAVE BEEN STORED INTO XPRED(IN),IN=1,NN.


      RETURN
      END

