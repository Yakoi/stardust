/* Converted to D from lp_lib.h by htod */
module lp_solve.lp_lib;

import core.sys.windows.windows;
//C     #ifndef HEADER_lp_lib
//C     #define HEADER_lp_lib

/* --------------------------------------------------------------------------

  This is the main library header file for the lp_solve v5.0 release

  Starting at version 3.0, LP_Solve is released under the LGPL license.
  For full information, see the enclosed file LGPL.txt.

  Original developer:   Michel Berkelaar  -  michel@ics.ele.tue.nl
  Most changes 1.5-2.0: Jeroen Dirks      -  jeroend@tor.numetrix.com
  Changes 3.2-4.0:      Kjell Eikland     -  kjell.eikland@broadpark.no
                        (Simplex code, SOS, SC, code optimization)
                        Peter Notebaert   -  lpsolve@peno.be
                        (Sensitivity analysis, documentation)
  Changes 5.0+:         Kjell Eikland     -  kjell.eikland@broadpark.no
                        (BFP, XLI, simplex, B&B, code modularization)
                        Peter Notebaert   -  lpsolve@peno.be
                        (Sensitivity analysis, New lp parser, LINDO (XLI)
                        parser, VB/.NET interface, documentation)

  Release notes:

  Version 4.0 enhances version 3.2 in terms of internal program/simplex
  architecture, call level interfaces, data layout, features and contains
  several bug fixes.  There is now complete support for semi-continuous
  variables and SOS constructions.  In the process, a complete API
  was added. The MPS parser has been amended to support this.
  Sensitivity analysis and variouse bug fixes was provided by Peter
  Notebaert in 4.0 sub-releases.  Peter also wrote a complete
  documentation of the API and contributed a VB interface, both of which
  significantly enhanced the accessibility of lp_solve.

  Version 5.0 is a major rewrite and code cleanup.  The main additions that
  drove forward this cleanup were the modular inversion logic with optimal
  column ordering, addition of primal phase 1 and dual phase 2 logic for
  full flexibility in the selection of primal and dual simplex modes,
  DEVEX and steepest edge pivot selection, along with dynamic cycling
  detection and prevention.  This cleanup made it possible to harmonize the
  internal rounding principles, contributing to increased numerical stability.

  Version 5.1 rearranges the matrix storage model by enabling both legacy
  element record-based storage and split vector storage.  In addition the
  lprec structure is optimized and additional routines are added, mainly for
  sparse vector additions and enhanced XLI functionality.  Support for XML-
  based models was added on the basis of the LPFML schema via xli_LPFML.

  Version 5.2 removes the objective function from the constraint matrix,
  adds a number of presolve options and speed them up.  Degeneracy handling
  is significantly improved. Support for XLI_ZIMPL was added.
  Multiple and partial pricing has been enhanced and activated.

  -------------------------------------------------------------------------- */
/* Define user program feature option switches                               */
/* ------------------------------------------------------------------------- */

//C     # if defined _WIN32 && !defined __GNUC__
//C     #  define isnan _isnan
//C     # endif
//alias _isnan isnan;
//C     #if defined NOISNAN
//C     # define isnan(x) FALSE
//C     #endif

//C     #define SETMASK(variable, mask)     variable |= mask
//C     #define CLEARMASK(variable, mask)   variable &= ~(mask)
//C     #define TOGGLEMASK(variable, mask)  variable ^= mask
//C     #define ISMASKSET(variable, mask)   (MYBOOL) (((variable) & (mask)) != 0)

/* Utility/system settings                                                   */
/* ------------------------------------------------------------------------- */
/*#define INTEGERTIME */
                    /* Set use of lower-resolution timer */


/* New v5.0+ simplex/optimization features and settings                      */
/* ------------------------------------------------------------------------- */
/*#define NoRowScaleOF */
               /* Optionally skip row-scaling of the OF */
//C     #define DoMatrixRounding                  /* Round A matrix elements to precision */
//C     #define DoBorderRounding            /* Round RHS, bounds and ranges to precision */
//C     #define Phase1EliminateRedundant        /* Remove rows of redundant artificials  */
//C     #define FixViolatedOptimal
//C     #define ImproveSolutionPrecision                 /* Round optimal solution values */
/*#define IncreasePivotOnReducedAccuracy */
  /* Increase epspivot on instability */
/*#define FixInaccurateDualMinit */
     /* Reinvert on inaccuracy in dual minits */
/*#define EnforcePositiveTheta */
        /* Ensure that the theta range is valid */
//C     #define ResetMinitOnReinvert
/*#define UsePrimalReducedCostUpdate */
                            /* Not tested */
/*#define UseDualReducedCostUpdate */
      /* Seems Ok, but slower than expected */
/*#ifdef UseLegacyExtrad */
                     /* Use v3.2- style Extrad method */
//C     #define UseMilpExpandedRCF         /* Non-ints in reduced cost bound tightening */
/*#define UseMilpSlacksRCF */
  /* Slacks in reduced cost bound tightening (degen
                                  prone); requires !SlackInitMinusInf */
//C     #define LegacySlackDefinition      /* Slack as the "value of the constraint" */


/* Development features (change at own risk)                                 */
/* ------------------------------------------------------------------------- */
/*#define MIPboundWithOF */
 /* Enable to detect OF constraint for use during B&B */
/*#define SlackInitMinusInf */
        /* Slacks have 0 LB if this is not defined */
//C     #define FULLYBOUNDEDSIMPLEX FALSE     /* WARNING: Activate at your own risk! */

//alias FALSE FULLYBOUNDEDSIMPLEX;

/* Specify use of the basic linear algebra subroutine library                */
/* ------------------------------------------------------------------------- */
//C     #define libBLAS                  2        /* 0: No, 1: Internal, 2: External */
//C     #define libnameBLAS        "myBLAS"
const libBLAS = 2;


/* Active inverse logic (default is optimized original etaPFI)               */
/* ------------------------------------------------------------------------- */
//C     #if !defined LoadInverseLib
//C     # define LoadInverseLib TRUE          /* Enable alternate inverse libraries */
//C     #endif
//alias TRUE LoadInverseLib;
/*#define ExcludeNativeInverse     */
   /* Disable INVERSE_ACTIVE inverse engine */

//C     #define DEF_OBJINBASIS        TRUE  /* Additional rows inserted at the top (1 => OF) */

//alias TRUE DEF_OBJINBASIS;
//C     #define INVERSE_NONE            -1
//C     #define INVERSE_LEGACY           0
const INVERSE_NONE = -1;
//C     #define INVERSE_ETAPFI           1
const INVERSE_LEGACY = 0;
//C     #define INVERSE_LUMOD            2
const INVERSE_ETAPFI = 1;
//C     #define INVERSE_LUSOL            3
const INVERSE_LUMOD = 2;
//C     #define INVERSE_GLPKLU           4
const INVERSE_LUSOL = 3;

const INVERSE_GLPKLU = 4;
//C     #ifndef RoleIsExternalInvEngine            /* Defined in inverse DLL drivers */
//C       #ifdef ExcludeNativeInverse
//C         #define INVERSE_ACTIVE       INVERSE_NONE       /* Disable native engine */
//C       #else
//C         #define INVERSE_ACTIVE       INVERSE_LEGACY      /* User or DLL-selected */
//C       #endif
alias INVERSE_LEGACY INVERSE_ACTIVE;
//C     #endif


/* Active external language interface logic (default is none)                */
/* ------------------------------------------------------------------------- */
//C     #if !defined LoadLanguageLib
//C     # define LoadLanguageLib TRUE         /* Enable alternate language libraries */
//C     #endif
//alias TRUE LoadLanguageLib;
//C     #define ExcludeNativeLanguage                 /* Disable LANGUAGE_ACTIVE XLI */

//C     #define LANGUAGE_NONE           -1
//C     #define LANGUAGE_LEGACYLP        0
const LANGUAGE_NONE = -1;
//C     #define LANGUAGE_CPLEXLP         1
const LANGUAGE_LEGACYLP = 0;
//C     #define LANGUAGE_MPSX            2
const LANGUAGE_CPLEXLP = 1;
//C     #define LANGUAGE_LPFML           3
const LANGUAGE_MPSX = 2;
//C     #define LANGUAGE_MATHPROG        4
const LANGUAGE_LPFML = 3;
//C     #define LANGUAGE_AMPL            5
const LANGUAGE_MATHPROG = 4;
//C     #define LANGUAGE_GAMS            6
const LANGUAGE_AMPL = 5;
//C     #define LANGUAGE_ZIMPL           7
const LANGUAGE_GAMS = 6;
//C     #define LANGUAGE_S               8
const LANGUAGE_ZIMPL = 7;
//C     #define LANGUAGE_R               9
const LANGUAGE_S = 8;
//C     #define LANGUAGE_MATLAB         10
const LANGUAGE_R = 9;
//C     #define LANGUAGE_OMATRIX        11
const LANGUAGE_MATLAB = 10;
//C     #define LANGUAGE_SCILAB         12
const LANGUAGE_OMATRIX = 11;
//C     #define LANGUAGE_OCTAVE         13
const LANGUAGE_SCILAB = 12;
//C     #define LANGUAGE_EMPS           14
const LANGUAGE_OCTAVE = 13;

const LANGUAGE_EMPS = 14;
//C     #ifndef RoleIsExternalLanguageEngine      /* Defined in XLI driver libraries */
//C       #ifdef ExcludeNativeLanguage
//C         #define LANGUAGE_ACTIVE       LANGUAGE_NONE     /* Disable native engine */
//C       #else
alias LANGUAGE_NONE LANGUAGE_ACTIVE;
//C         #define LANGUAGE_ACTIVE       LANGUAGE_CPLEXLP   /* User or DLL-selected */
//C       #endif
//C     #endif


/* Default parameters and tolerances                                         */
/* ------------------------------------------------------------------------- */
//C     #define OriginalPARAM           0
//C     #define ProductionPARAM         1
const OriginalPARAM = 0;
//C     #define ChvatalPARAM            2
const ProductionPARAM = 1;
//C     #define LoosePARAM              3
const ChvatalPARAM = 2;
//C     #if 1
const LoosePARAM = 3;
//C       #define ActivePARAM           ProductionPARAM
//C     #else
alias ProductionPARAM ActivePARAM;
//C       #define ActivePARAM           LoosePARAM
//C     #endif


/* Miscellaneous settings                                                    */
/* ------------------------------------------------------------------------- */
//C     #ifndef Paranoia
//C       #ifdef _DEBUG
//C         #define Paranoia
//C       #endif
//C     #endif


/* Program version data                                                      */
/* ------------------------------------------------------------------------- */
//C     #define MAJORVERSION             5
//C     #define MINORVERSION             5
const MAJORVERSION = 5;
//C     #define RELEASE                  0
const MINORVERSION = 5;
//C     #define BUILD                   15
const RELEASE = 0;
//C     #define BFPVERSION              12       /* Checked against bfp_compatible() */
const BUILD = 15;
//C     #define XLIVERSION              12       /* Checked against xli_compatible() */
const BFPVERSION = 12;
/* Note that both BFPVERSION and XLIVERSION typically have to be incremented
const XLIVERSION = 12;
   in the case that the lprec structure changes.                             */


/* Include/header files                                                      */
/* ------------------------------------------------------------------------- */
//C     #include <sys/types.h>
import core.stdc.ctype;
//C     #include <stdlib.h>
import std.c.stdlib;
//C     #include <string.h>
import std.c.string;
//C     #include <math.h>
import std.c.math;
//C     #include <stdio.h>
import std.c.stdio;

//C     #include "lp_types.h"
import lp_solve.lp_types;
//C     #include "lp_utils.h"
import lp_solve.lp_utils;

//C     #if (LoadInverseLib == TRUE) || (LoadLanguageLib == TRUE)
//C       #ifdef WIN32
//C         #include <windows.h>
//C       #else
//C         #include <dlfcn.h>
//C       #endif
//C     #endif
//C     #define DllExport extern "C" __declspec (dllexport) 
//C     #ifndef BFP_CALLMODEL
//C       #ifdef WIN32
//C         #define BFP_CALLMODEL __stdcall   /* "Standard" call model */
//C       #else
alias void BFP_CALLMODEL;
//C         #define BFP_CALLMODEL
//C       #endif
//C     #endif
//C     #ifndef XLI_CALLMODEL
//C       #define XLI_CALLMODEL BFP_CALLMODEL
//C     #endif
alias BFP_CALLMODEL XLI_CALLMODEL;

//C     #define REGISTER        register      /* Speed up certain operations */

alias void REGISTER;

/* Definition of program constrants                                          */
/* ------------------------------------------------------------------------- */
//C     #define SIMPLEX_UNDEFINED        0
//C     #define SIMPLEX_Phase1_PRIMAL    1
const SIMPLEX_UNDEFINED = 0;
//C     #define SIMPLEX_Phase1_DUAL      2
const SIMPLEX_Phase1_PRIMAL = 1;
//C     #define SIMPLEX_Phase2_PRIMAL    4
const SIMPLEX_Phase1_DUAL = 2;
//C     #define SIMPLEX_Phase2_DUAL      8
const SIMPLEX_Phase2_PRIMAL = 4;
//C     #define SIMPLEX_DYNAMIC         16
const SIMPLEX_Phase2_DUAL = 8;
//C     #define SIMPLEX_AUTODUALIZE     32
const SIMPLEX_DYNAMIC = 16;

const SIMPLEX_AUTODUALIZE = 32;
//C     #define SIMPLEX_PRIMAL_PRIMAL   (SIMPLEX_Phase1_PRIMAL + SIMPLEX_Phase2_PRIMAL)
//C     #define SIMPLEX_DUAL_PRIMAL     (SIMPLEX_Phase1_DUAL   + SIMPLEX_Phase2_PRIMAL)
//C     #define SIMPLEX_PRIMAL_DUAL     (SIMPLEX_Phase1_PRIMAL + SIMPLEX_Phase2_DUAL)
//C     #define SIMPLEX_DUAL_DUAL       (SIMPLEX_Phase1_DUAL   + SIMPLEX_Phase2_DUAL)
//C     #define SIMPLEX_DEFAULT         (SIMPLEX_DUAL_PRIMAL)

/* Variable codes (internal) */
//C     #define ISREAL                   0
//C     #define ISINTEGER                1
const ISREAL = 0;
//C     #define ISSEMI                   2
const ISINTEGER = 1;
//C     #define ISSOS                    4
const ISSEMI = 2;
//C     #define ISSOSTEMPINT             8
const ISSOS = 4;
//C     #define ISGUB                   16
const ISSOSTEMPINT = 8;

const ISGUB = 16;
/* Presolve defines */
//C     #define PRESOLVE_NONE            0
//C     #define PRESOLVE_ROWS            1
const PRESOLVE_NONE = 0;
//C     #define PRESOLVE_COLS            2
const PRESOLVE_ROWS = 1;
//C     #define PRESOLVE_LINDEP          4
const PRESOLVE_COLS = 2;
//C     #define PRESOLVE_AGGREGATE       8  /* Not implemented */
const PRESOLVE_LINDEP = 4;
//C     #define PRESOLVE_SPARSER        16  /* Not implemented */
const PRESOLVE_AGGREGATE = 8;
//C     #define PRESOLVE_SOS            32
const PRESOLVE_SPARSER = 16;
//C     #define PRESOLVE_REDUCEMIP      64
const PRESOLVE_SOS = 32;
//C     #define PRESOLVE_KNAPSACK      128  /* Implementation not tested completely */
const PRESOLVE_REDUCEMIP = 64;
//C     #define PRESOLVE_ELIMEQ2       256
const PRESOLVE_KNAPSACK = 128;
//C     #define PRESOLVE_IMPLIEDFREE   512
const PRESOLVE_ELIMEQ2 = 256;
//C     #define PRESOLVE_REDUCEGCD    1024
const PRESOLVE_IMPLIEDFREE = 512;
//C     #define PRESOLVE_PROBEFIX     2048
const PRESOLVE_REDUCEGCD = 1024;
//C     #define PRESOLVE_PROBEREDUCE  4096
const PRESOLVE_PROBEFIX = 2048;
//C     #define PRESOLVE_ROWDOMINATE  8192
const PRESOLVE_PROBEREDUCE = 4096;
//C     #define PRESOLVE_COLDOMINATE 16384  /* Reduced functionality, should be expanded */
const PRESOLVE_ROWDOMINATE = 8192;
//C     #define PRESOLVE_MERGEROWS   32768
const PRESOLVE_COLDOMINATE = 16384;
//C     #define PRESOLVE_IMPLIEDSLK  65536
const PRESOLVE_MERGEROWS = 32768;
//C     #define PRESOLVE_COLFIXDUAL 131072
const PRESOLVE_IMPLIEDSLK = 65536;
//C     #define PRESOLVE_BOUNDS     262144
const PRESOLVE_COLFIXDUAL = 131072;
//C     #define PRESOLVE_LASTMASKMODE    (PRESOLVE_DUALS - 1)
const PRESOLVE_BOUNDS = 262144;
//C     #define PRESOLVE_DUALS      524288
//C     #define PRESOLVE_SENSDUALS 1048576
const PRESOLVE_DUALS = 524288;

const PRESOLVE_SENSDUALS = 1048576;
/* Basis crash options */
//C     #define CRASH_NONE               0
//C     #define CRASH_NONBASICBOUNDS     1
const CRASH_NONE = 0;
//C     #define CRASH_MOSTFEASIBLE       2
const CRASH_NONBASICBOUNDS = 1;
//C     #define CRASH_LEASTDEGENERATE    3
const CRASH_MOSTFEASIBLE = 2;

const CRASH_LEASTDEGENERATE = 3;
/* Solution recomputation options (internal) */
//C     #define INITSOL_SHIFTZERO        0
//C     #define INITSOL_USEZERO          1
const INITSOL_SHIFTZERO = 0;
//C     #define INITSOL_ORIGINAL         2
const INITSOL_USEZERO = 1;

const INITSOL_ORIGINAL = 2;
/* Strategy codes to avoid or recover from degenerate pivots,
   infeasibility or numeric errors via randomized bound relaxation */
//C     #define ANTIDEGEN_NONE           0
//C     #define ANTIDEGEN_FIXEDVARS      1
const ANTIDEGEN_NONE = 0;
//C     #define ANTIDEGEN_COLUMNCHECK    2
const ANTIDEGEN_FIXEDVARS = 1;
//C     #define ANTIDEGEN_STALLING       4
const ANTIDEGEN_COLUMNCHECK = 2;
//C     #define ANTIDEGEN_NUMFAILURE     8
const ANTIDEGEN_STALLING = 4;
//C     #define ANTIDEGEN_LOSTFEAS      16
const ANTIDEGEN_NUMFAILURE = 8;
//C     #define ANTIDEGEN_INFEASIBLE    32
const ANTIDEGEN_LOSTFEAS = 16;
//C     #define ANTIDEGEN_DYNAMIC       64
const ANTIDEGEN_INFEASIBLE = 32;
//C     #define ANTIDEGEN_DURINGBB     128
const ANTIDEGEN_DYNAMIC = 64;
//C     #define ANTIDEGEN_RHSPERTURB   256
const ANTIDEGEN_DURINGBB = 128;
//C     #define ANTIDEGEN_BOUNDFLIP    512
const ANTIDEGEN_RHSPERTURB = 256;
//C     #define ANTIDEGEN_DEFAULT        (ANTIDEGEN_FIXEDVARS | ANTIDEGEN_STALLING /* | ANTIDEGEN_INFEASIBLE */)
const ANTIDEGEN_BOUNDFLIP = 512;

/* REPORT defines */
//C     #define NEUTRAL                  0
//C     #define CRITICAL                 1
const NEUTRAL = 0;
//C     #define SEVERE                   2
const CRITICAL = 1;
//C     #define IMPORTANT                3
const SEVERE = 2;
//C     #define NORMAL                   4
const IMPORTANT = 3;
//C     #define DETAILED                 5
const NORMAL = 4;
//C     #define FULL                     6
const DETAILED = 5;

const FULL = 6;
/* MESSAGE defines */
//C     #define MSG_NONE                 0
//C     #define MSG_PRESOLVE             1
const MSG_NONE = 0;
//C     #define MSG_ITERATION            2
const MSG_PRESOLVE = 1;
//C     #define MSG_INVERT               4
const MSG_ITERATION = 2;
//C     #define MSG_LPFEASIBLE           8
const MSG_INVERT = 4;
//C     #define MSG_LPOPTIMAL           16
const MSG_LPFEASIBLE = 8;
//C     #define MSG_LPEQUAL             32
const MSG_LPOPTIMAL = 16;
//C     #define MSG_LPBETTER            64
const MSG_LPEQUAL = 32;
//C     #define MSG_MILPFEASIBLE       128
const MSG_LPBETTER = 64;
//C     #define MSG_MILPEQUAL          256
const MSG_MILPFEASIBLE = 128;
//C     #define MSG_MILPBETTER         512
const MSG_MILPEQUAL = 256;
//C     #define MSG_MILPSTRATEGY      1024
const MSG_MILPBETTER = 512;
//C     #define MSG_MILPOPTIMAL       2048
const MSG_MILPSTRATEGY = 1024;
//C     #define MSG_PERFORMANCE       4096
const MSG_MILPOPTIMAL = 2048;
//C     #define MSG_INITPSEUDOCOST    8192
const MSG_PERFORMANCE = 4096;

const MSG_INITPSEUDOCOST = 8192;
/* MPS file types */
//C     #define MPSFIXED                 1
//C     #define MPSFREE                  2
const MPSFIXED = 1;
//C     #define MPSIBM                   4
const MPSFREE = 2;
//C     #define MPSNEGOBJCONST           8
const MPSIBM = 4;

const MPSNEGOBJCONST = 8;
//C     #define MPS_FREE                 (MPSFREE<<2)
//C     #define MPS_IBM                  (MPSIBM<<2)
//C     #define MPS_NEGOBJCONST          (MPSNEGOBJCONST<<2)

/* MPS defines (internal) */
//C     #define MPSUNDEF                -4
//C     #define MPSNAME                 -3
const MPSUNDEF = -4;
//C     #define MPSOBJSENSE             -2
const MPSNAME = -3;
//C     #define MPSOBJNAME              -1
const MPSOBJSENSE = -2;
//C     #define MPSROWS                  0
const MPSOBJNAME = -1;
//C     #define MPSCOLUMNS               1
const MPSROWS = 0;
//C     #define MPSRHS                   2
const MPSCOLUMNS = 1;
//C     #define MPSBOUNDS                3
const MPSRHS = 2;
//C     #define MPSRANGES                4
const MPSBOUNDS = 3;
//C     #define MPSSOS                   5
const MPSRANGES = 4;

const MPSSOS = 5;
//C     #define MPSVARMASK          "%-8s"
//C     #define MPSVALUEMASK        "%12g"

/* Constraint type codes  (internal) */
//C     #define ROWTYPE_EMPTY            0
//C     #define ROWTYPE_LE               1
const ROWTYPE_EMPTY = 0;
//C     #define ROWTYPE_GE               2
const ROWTYPE_LE = 1;
//C     #define ROWTYPE_EQ               3
const ROWTYPE_GE = 2;
//C     #define ROWTYPE_CONSTRAINT       ROWTYPE_EQ  /* This is the mask for modes */
const ROWTYPE_EQ = 3;
//C     #define ROWTYPE_OF               4
alias ROWTYPE_EQ ROWTYPE_CONSTRAINT;
//C     #define ROWTYPE_INACTIVE         8
const ROWTYPE_OF = 4;
//C     #define ROWTYPE_RELAX           16
const ROWTYPE_INACTIVE = 8;
//C     #define ROWTYPE_GUB             32
const ROWTYPE_RELAX = 16;
//C     #define ROWTYPE_OFMAX            (ROWTYPE_OF + ROWTYPE_GE)
const ROWTYPE_GUB = 32;
//C     #define ROWTYPE_OFMIN            (ROWTYPE_OF + ROWTYPE_LE)
//C     #define ROWTYPE_CHSIGN           ROWTYPE_GE

alias ROWTYPE_GE ROWTYPE_CHSIGN;
/* Public constraint codes */
//C     #define FR                       ROWTYPE_EMPTY
//C     #define LE                       ROWTYPE_LE
alias ROWTYPE_EMPTY FR;
//C     #define GE                       ROWTYPE_GE
alias ROWTYPE_LE LE;
//C     #define EQ                       ROWTYPE_EQ
alias ROWTYPE_GE GE;
//C     #define OF                       ROWTYPE_OF
alias ROWTYPE_EQ EQ;

alias ROWTYPE_OF OF;
/* MIP constraint classes */
//C     #define ROWCLASS_Unknown         0   /* Undefined/unknown */
//C     #define ROWCLASS_Objective       1   /* The objective function */
const ROWCLASS_Unknown = 0;
//C     #define ROWCLASS_GeneralREAL     2   /* General real-values constraint */
const ROWCLASS_Objective = 1;
//C     #define ROWCLASS_GeneralMIP      3   /* General mixed integer/binary and real valued constraint */
const ROWCLASS_GeneralREAL = 2;
//C     #define ROWCLASS_GeneralINT      4   /* General integer-only constraint */
const ROWCLASS_GeneralMIP = 3;
//C     #define ROWCLASS_GeneralBIN      5   /* General binary-only constraint */
const ROWCLASS_GeneralINT = 4;
//C     #define ROWCLASS_KnapsackINT     6   /* Sum of positive integer times integer variables <= positive integer */
const ROWCLASS_GeneralBIN = 5;
//C     #define ROWCLASS_KnapsackBIN     7   /* Sum of positive integer times binary variables <= positive integer */
const ROWCLASS_KnapsackINT = 6;
//C     #define ROWCLASS_SetPacking      8   /* Sum of binary variables >= 1 */
const ROWCLASS_KnapsackBIN = 7;
//C     #define ROWCLASS_SetCover        9   /* Sum of binary variables <= 1 */
const ROWCLASS_SetPacking = 8;
//C     #define ROWCLASS_GUB            10   /* Sum of binary variables = 1  */
const ROWCLASS_SetCover = 9;
//C     #define ROWCLASS_MAX             ROWCLASS_GUB
const ROWCLASS_GUB = 10;

alias ROWCLASS_GUB ROWCLASS_MAX;
/* Column subsets (internal) */
//C     #define SCAN_USERVARS            1
//C     #define SCAN_SLACKVARS           2
const SCAN_USERVARS = 1;
//C     #define SCAN_ARTIFICIALVARS      4
const SCAN_SLACKVARS = 2;
//C     #define SCAN_PARTIALBLOCK        8
const SCAN_ARTIFICIALVARS = 4;
//C     #define USE_BASICVARS           16
const SCAN_PARTIALBLOCK = 8;
//C     #define USE_NONBASICVARS        32
const USE_BASICVARS = 16;
//C     #define SCAN_NORMALVARS         (SCAN_USERVARS + SCAN_ARTIFICIALVARS)
const USE_NONBASICVARS = 32;
//C     #define SCAN_ALLVARS            (SCAN_SLACKVARS + SCAN_USERVARS + SCAN_ARTIFICIALVARS)
//C     #define USE_ALLVARS             (USE_BASICVARS + USE_NONBASICVARS)
//C     #define OMIT_FIXED              64
//C     #define OMIT_NONFIXED          128
const OMIT_FIXED = 64;

const OMIT_NONFIXED = 128;
/* Improvement defines */
//C     #define IMPROVE_NONE             0
//C     #define IMPROVE_SOLUTION         1
const IMPROVE_NONE = 0;
//C     #define IMPROVE_DUALFEAS         2
const IMPROVE_SOLUTION = 1;
//C     #define IMPROVE_THETAGAP         4
const IMPROVE_DUALFEAS = 2;
//C     #define IMPROVE_BBSIMPLEX        8
const IMPROVE_THETAGAP = 4;
//C     #define IMPROVE_DEFAULT          (IMPROVE_DUALFEAS + IMPROVE_THETAGAP)
const IMPROVE_BBSIMPLEX = 8;
//C     #define IMPROVE_INVERSE          (IMPROVE_SOLUTION + IMPROVE_THETAGAP)

/* Scaling types */
//C     #define SCALE_NONE               0
//C     #define SCALE_EXTREME            1
const SCALE_NONE = 0;
//C     #define SCALE_RANGE              2
const SCALE_EXTREME = 1;
//C     #define SCALE_MEAN               3
const SCALE_RANGE = 2;
//C     #define SCALE_GEOMETRIC          4
const SCALE_MEAN = 3;
//C     #define SCALE_FUTURE1            5
const SCALE_GEOMETRIC = 4;
//C     #define SCALE_FUTURE2            6
const SCALE_FUTURE1 = 5;
//C     #define SCALE_CURTISREID         7   /* Override to Curtis-Reid "optimal" scaling */
const SCALE_FUTURE2 = 6;

const SCALE_CURTISREID = 7;
/* Alternative scaling weights */
//C     #define SCALE_LINEAR             0
//C     #define SCALE_QUADRATIC          8
const SCALE_LINEAR = 0;
//C     #define SCALE_LOGARITHMIC       16
const SCALE_QUADRATIC = 8;
//C     #define SCALE_USERWEIGHT        31
const SCALE_LOGARITHMIC = 16;
//C     #define SCALE_MAXTYPE            (SCALE_QUADRATIC-1)
const SCALE_USERWEIGHT = 31;

/* Scaling modes */
//C     #define SCALE_POWER2            32   /* As is or rounded to power of 2 */
//C     #define SCALE_EQUILIBRATE       64   /* Make sure that no scaled number is above 1 */
const SCALE_POWER2 = 32;
//C     #define SCALE_INTEGERS         128   /* Apply to integer columns/variables */
const SCALE_EQUILIBRATE = 64;
//C     #define SCALE_DYNUPDATE        256   /* Apply incrementally every solve() */
const SCALE_INTEGERS = 128;
//C     #define SCALE_ROWSONLY         512   /* Override any scaling to only scale the rows */
const SCALE_DYNUPDATE = 256;
//C     #define SCALE_COLSONLY        1024   /* Override any scaling to only scale the rows */
const SCALE_ROWSONLY = 512;

const SCALE_COLSONLY = 1024;
/* Standard defines for typical scaling models (no Lagrangeans) */
//C     #define SCALEMODEL_EQUILIBRATED  (SCALE_LINEAR+SCALE_EXTREME+SCALE_INTEGERS)
//C     #define SCALEMODEL_GEOMETRIC     (SCALE_LINEAR+SCALE_GEOMETRIC+SCALE_INTEGERS)
//C     #define SCALEMODEL_ARITHMETIC    (SCALE_LINEAR+SCALE_MEAN+SCALE_INTEGERS)
//C     #define SCALEMODEL_DYNAMIC       (SCALEMODEL_GEOMETRIC+SCALE_EQUILIBRATE)
//C     #define SCALEMODEL_CURTISREID    (SCALE_CURTISREID+SCALE_INTEGERS+SCALE_POWER2)

/* Iteration status and strategies (internal) */
//C     #define ITERATE_MAJORMAJOR       0
//C     #define ITERATE_MINORMAJOR       1
const ITERATE_MAJORMAJOR = 0;
//C     #define ITERATE_MINORRETRY       2
const ITERATE_MINORMAJOR = 1;

const ITERATE_MINORRETRY = 2;
/* Pricing methods */
//C     #define PRICER_FIRSTINDEX        0
//C     #define PRICER_DANTZIG           1
const PRICER_FIRSTINDEX = 0;
//C     #define PRICER_DEVEX             2
const PRICER_DANTZIG = 1;
//C     #define PRICER_STEEPESTEDGE      3
const PRICER_DEVEX = 2;
//C     #define PRICER_LASTOPTION        PRICER_STEEPESTEDGE
const PRICER_STEEPESTEDGE = 3;

alias PRICER_STEEPESTEDGE PRICER_LASTOPTION;
/* Additional settings for pricers (internal) */
//C     #define PRICER_RANDFACT        0.1
//C     #define DEVEX_RESTARTLIMIT 1.0e+09    /* Reset the norms if any value exceeds this limit */
const PRICER_RANDFACT = 0.1;
//C     #define DEVEX_MINVALUE       0.000    /* Minimum weight [0..1] for entering variable, consider 0.01 */
const DEVEX_RESTARTLIMIT = 1.0e+09;

const DEVEX_MINVALUE = 0.000;
/* Pricing strategies */
//C     #define PRICE_PRIMALFALLBACK     4    /* In case of Steepest Edge, fall back to DEVEX in primal */
//C     #define PRICE_MULTIPLE           8    /* Enable multiple pricing (primal simplex) */
const PRICE_PRIMALFALLBACK = 4;
//C     #define PRICE_PARTIAL           16    /* Enable partial pricing */
const PRICE_MULTIPLE = 8;
//C     #define PRICE_ADAPTIVE          32    /* Temporarily use alternative strategy if cycling is detected */
const PRICE_PARTIAL = 16;
//C     #define PRICE_HYBRID            64    /* NOT IMPLEMENTED */
const PRICE_ADAPTIVE = 32;
//C     #define PRICE_RANDOMIZE        128    /* Adds a small randomization effect to the selected pricer */
const PRICE_HYBRID = 64;
//C     #define PRICE_AUTOPARTIAL      256    /* Detect and use data on the block structure of the model (primal) */
const PRICE_RANDOMIZE = 128;
//C     #define PRICE_AUTOMULTIPLE     512    /* Automatically select multiple pricing (primal simplex) */
const PRICE_AUTOPARTIAL = 256;
//C     #define PRICE_LOOPLEFT        1024    /* Scan entering/leaving columns left rather than right */
const PRICE_AUTOMULTIPLE = 512;
//C     #define PRICE_LOOPALTERNATE   2048    /* Scan entering/leaving columns alternatingly left/right */
const PRICE_LOOPLEFT = 1024;
//C     #define PRICE_HARRISTWOPASS   4096    /* Use Harris' primal pivot logic rather than the default */
const PRICE_LOOPALTERNATE = 2048;
//C     #define PRICE_FORCEFULL       8192    /* Non-user option to force full pricing */
const PRICE_HARRISTWOPASS = 4096;
//C     #define PRICE_TRUENORMINIT   16384    /* Use true norms for Devex and Steepest Edge initializations */
const PRICE_FORCEFULL = 8192;

const PRICE_TRUENORMINIT = 16384;
/*#define _PRICE_NOBOUNDFLIP*/
//C     #if defined _PRICE_NOBOUNDFLIP
//C     #define PRICE_NOBOUNDFLIP    65536    /* Disallow automatic bound-flip during pivot */
//C     #endif

//C     #define PRICE_STRATEGYMASK       (PRICE_PRIMALFALLBACK +                                   PRICE_MULTIPLE + PRICE_PARTIAL +                                   PRICE_ADAPTIVE + PRICE_HYBRID +                                   PRICE_RANDOMIZE + PRICE_AUTOPARTIAL + PRICE_AUTOMULTIPLE +                                   PRICE_LOOPLEFT + PRICE_LOOPALTERNATE +                                   PRICE_HARRISTWOPASS +                                   PRICE_FORCEFULL + PRICE_TRUENORMINIT)

/* B&B active variable codes (internal) */
//C     #define BB_REAL                  0
//C     #define BB_INT                   1
const BB_REAL = 0;
//C     #define BB_SC                    2
const BB_INT = 1;
//C     #define BB_SOS                   3
const BB_SC = 2;
//C     #define BB_GUB                   4
const BB_SOS = 3;

const BB_GUB = 4;
/* B&B strategies */
//C     #define NODE_FIRSTSELECT         0
//C     #define NODE_GAPSELECT           1
const NODE_FIRSTSELECT = 0;
//C     #define NODE_RANGESELECT         2
const NODE_GAPSELECT = 1;
//C     #define NODE_FRACTIONSELECT      3
const NODE_RANGESELECT = 2;
//C     #define NODE_PSEUDOCOSTSELECT    4
const NODE_FRACTIONSELECT = 3;
//C     #define NODE_PSEUDONONINTSELECT  5    /* Kjell Eikland #1 - Minimize B&B depth */
const NODE_PSEUDOCOSTSELECT = 4;
//C     #define NODE_PSEUDOFEASSELECT   (NODE_PSEUDONONINTSELECT+NODE_WEIGHTREVERSEMODE)
const NODE_PSEUDONONINTSELECT = 5;
//C     #define NODE_PSEUDORATIOSELECT   6    /* Kjell Eikland #2 - Minimize a "cost/benefit" ratio */
//C     #define NODE_USERSELECT          7
const NODE_PSEUDORATIOSELECT = 6;
//C     #define NODE_STRATEGYMASK        (NODE_WEIGHTREVERSEMODE-1) /* Mask for B&B strategies */
const NODE_USERSELECT = 7;
//C     #define NODE_WEIGHTREVERSEMODE   8
//C     #define NODE_BRANCHREVERSEMODE  16
const NODE_WEIGHTREVERSEMODE = 8;
//C     #define NODE_GREEDYMODE         32
const NODE_BRANCHREVERSEMODE = 16;
//C     #define NODE_PSEUDOCOSTMODE     64
const NODE_GREEDYMODE = 32;
//C     #define NODE_DEPTHFIRSTMODE    128
const NODE_PSEUDOCOSTMODE = 64;
//C     #define NODE_RANDOMIZEMODE     256
const NODE_DEPTHFIRSTMODE = 128;
//C     #define NODE_GUBMODE           512
const NODE_RANDOMIZEMODE = 256;
//C     #define NODE_DYNAMICMODE      1024
const NODE_GUBMODE = 512;
//C     #define NODE_RESTARTMODE      2048
const NODE_DYNAMICMODE = 1024;
//C     #define NODE_BREADTHFIRSTMODE 4096
const NODE_RESTARTMODE = 2048;
//C     #define NODE_AUTOORDER        8192
const NODE_BREADTHFIRSTMODE = 4096;
//C     #define NODE_RCOSTFIXING     16384
const NODE_AUTOORDER = 8192;
//C     #define NODE_STRONGINIT      32768
const NODE_RCOSTFIXING = 16384;

const NODE_STRONGINIT = 32768;
//C     #define BRANCH_CEILING           0
//C     #define BRANCH_FLOOR             1
const BRANCH_CEILING = 0;
//C     #define BRANCH_AUTOMATIC         2
const BRANCH_FLOOR = 1;
//C     #define BRANCH_DEFAULT           3
const BRANCH_AUTOMATIC = 2;

const BRANCH_DEFAULT = 3;
/* Action constants for simplex and B&B (internal) */
//C     #define ACTION_NONE              0
//C     #define ACTION_ACTIVE            1
const ACTION_NONE = 0;
//C     #define ACTION_REBASE            2
const ACTION_ACTIVE = 1;
//C     #define ACTION_RECOMPUTE         4
const ACTION_REBASE = 2;
//C     #define ACTION_REPRICE           8
const ACTION_RECOMPUTE = 4;
//C     #define ACTION_REINVERT         16
const ACTION_REPRICE = 8;
//C     #define ACTION_TIMEDREINVERT    32
const ACTION_REINVERT = 16;
//C     #define ACTION_ITERATE          64
const ACTION_TIMEDREINVERT = 32;
//C     #define ACTION_RESTART         255
const ACTION_ITERATE = 64;

const ACTION_RESTART = 255;
/* Solver status values */
//C     #define UNKNOWNERROR            -5
//C     #define DATAIGNORED             -4
const UNKNOWNERROR = -5;
//C     #define NOBFP                   -3
const DATAIGNORED = -4;
//C     #define NOMEMORY                -2
const NOBFP = -3;
//C     #define NOTRUN                  -1
const NOMEMORY = -2;
//C     #define OPTIMAL                  0
const NOTRUN = -1;
//C     #define SUBOPTIMAL               1
const OPTIMAL = 0;
//C     #define INFEASIBLE               2
const SUBOPTIMAL = 1;
//C     #define UNBOUNDED                3
const INFEASIBLE = 2;
//C     #define DEGENERATE               4
const UNBOUNDED = 3;
//C     #define NUMFAILURE               5
const DEGENERATE = 4;
//C     #define USERABORT                6
const NUMFAILURE = 5;
//C     #define TIMEOUT                  7
const USERABORT = 6;
//C     #define RUNNING                  8
const TIMEOUT = 7;
//C     #define PRESOLVED                9
const RUNNING = 8;

const PRESOLVED = 9;
/* Branch & Bound and Lagrangean extra status values (internal) */
//C     #define PROCFAIL                10
//C     #define PROCBREAK               11
const PROCFAIL = 10;
//C     #define FEASFOUND               12
const PROCBREAK = 11;
//C     #define NOFEASFOUND             13
const FEASFOUND = 12;
//C     #define FATHOMED                14
const NOFEASFOUND = 13;

const FATHOMED = 14;
/* Status values internal to the solver (internal) */
//C     #define SWITCH_TO_PRIMAL        20
//C     #define SWITCH_TO_DUAL          21
const SWITCH_TO_PRIMAL = 20;
//C     #define SINGULAR_BASIS          22
const SWITCH_TO_DUAL = 21;
//C     #define LOSTFEAS                23
const SINGULAR_BASIS = 22;
//C     #define MATRIXERROR             24
const LOSTFEAS = 23;

const MATRIXERROR = 24;
/* Objective testing options for "bb_better" (internal) */
//C     #define OF_RELAXED               0
//C     #define OF_INCUMBENT             1
const OF_RELAXED = 0;
//C     #define OF_WORKING               2
const OF_INCUMBENT = 1;
//C     #define OF_USERBREAK             3
const OF_WORKING = 2;
//C     #define OF_HEURISTIC             4
const OF_USERBREAK = 3;
//C     #define OF_DUALLIMIT             5
const OF_HEURISTIC = 4;
//C     #define OF_DELTA                 8  /* Mode */
const OF_DUALLIMIT = 5;
//C     #define OF_PROJECTED            16  /* Mode - future, not active */
const OF_DELTA = 8;

const OF_PROJECTED = 16;
//C     #define OF_TEST_BT               1
//C     #define OF_TEST_BE               2
const OF_TEST_BT = 1;
//C     #define OF_TEST_NE               3
const OF_TEST_BE = 2;
//C     #define OF_TEST_WE               4
const OF_TEST_NE = 3;
//C     #define OF_TEST_WT               5
const OF_TEST_WE = 4;
//C     #define OF_TEST_RELGAP           8  /* Mode */
const OF_TEST_WT = 5;

const OF_TEST_RELGAP = 8;

/* Name list and sparse matrix storage parameters (internal) */
//C     #define MAT_START_SIZE       10000
//C     #define DELTACOLALLOC          100
const MAT_START_SIZE = 10000;
//C     #define DELTAROWALLOC          100
const DELTACOLALLOC = 100;
//C     #define RESIZEFACTOR             4  /* Fractional increase in selected memory allocations */
const DELTAROWALLOC = 100;

const RESIZEFACTOR = 4;
/* Default solver parameters and tolerances (internal) */
//C     #define DEF_PARTIALBLOCKS       10  /* The default number of blocks for partial pricing */
//C     #define DEF_MAXRELAX             7  /* Maximum number of non-BB relaxations in MILP */
const DEF_PARTIALBLOCKS = 10;
//C     #define DEF_MAXPIVOTRETRY       10  /* Maximum number of times to retry a div-0 situation */
const DEF_MAXRELAX = 7;
//C     #define DEF_MAXSINGULARITIES    10  /* Maximum number of singularities in refactorization */
const DEF_MAXPIVOTRETRY = 10;
//C     #define MAX_MINITUPDATES        60  
/* Maximum number of bound swaps between refactorizations
const DEF_MAXSINGULARITIES = 10;
                                       without recomputing the whole vector - contain errors */
//C     #define MIN_REFACTFREQUENCY      5  
/* Refactorization frequency indicating an inherent
const MAX_MINITUPDATES = 60;
                                       numerical instability of the basis */
//C     #define LAG_SINGULARLIMIT        5  
/* Number of times the objective does not change
const MIN_REFACTFREQUENCY = 5;
                                       before it is assumed that the Lagrangean constraints
                                       are non-binding, and therefore impossible to converge;
                                       upper iteration limit is divided by this threshold */
//C     #define MIN_TIMEPIVOT      5.0e-02  
/* Minimum time per pivot for reinversion optimization
const LAG_SINGULARLIMIT = 5;
                                       purposes; use active monitoring only if a pivot
                                       takes more than MINTIMEPIVOT seconds.  5.0e-2 is
                                       roughly suitable for a 1GHz system.  */
//C     #define MAX_STALLCOUNT          12  
/* The absolute upper limit to the number of stalling or
const MIN_TIMEPIVOT = 5.0e-02;
                                       cycling iterations before switching rule */
//C     #define MAX_RULESWITCH           5  
/* The maximum number of times to try an alternate pricing rule
const MAX_STALLCOUNT = 12;
                                       to recover from stalling; set negative for no limit. */
//C     #define DEF_TIMEDREFACT  AUTOMATIC  
/* Default for timed refactorization in BFPs;
const MAX_RULESWITCH = 5;
                                       can be FALSE, TRUE or AUTOMATIC (dynamic) */

alias AUTOMATIC DEF_TIMEDREFACT;
//C     #define DEF_SCALINGLIMIT         5  /* The default maximum number of scaling iterations */

const DEF_SCALINGLIMIT = 5;
//C     #define DEF_NEGRANGE      -1.0e+06  
/* Downward limit for expanded variable range before the
                                       variable is split into positive and negative components */
//C     #define DEF_BB_LIMITLEVEL      -50  
/* Relative B&B limit to protect against very deep,
const DEF_NEGRANGE = -1.0e+06;
                                       memory-consuming trees */

const DEF_BB_LIMITLEVEL = -50;
//C     #define MAX_FRACSCALE            6  /* The maximum decimal scan range for simulated integers */
//C     #define RANDSCALE              100  /* Randomization scaling range */
const MAX_FRACSCALE = 6;
//C     #define DOUBLEROUND        0.0e-02  
/* Extra rounding scalar used in btran/ftran calculations; the
const RANDSCALE = 100;
                                       rationale for 0.0 is that prod_xA() uses rounding as well */
//C     #define DEF_EPSMACHINE    2.22e-16  /* Machine relative precision (doubles) */
const DOUBLEROUND = 0.0e-02;
//C     #define MIN_STABLEPIVOT        5.0  /* Minimum pivot magnitude assumed to be numerically stable */
const DEF_EPSMACHINE = 2.22e-16;

const MIN_STABLEPIVOT = 5.0;

/* Precision macros                                                                       */
/* -------------------------------------------------------------------------------------- */
//C     #define PREC_REDUCEDCOST        lp->epsvalue
//C     #define PREC_IMPROVEGAP         lp->epsdual
//C     #define PREC_SUBSTFEASGAP       lp->epsprimal
//C     #if 1
//C       #define PREC_BASICSOLUTION    lp->epsvalue  /* Zero-rounding of RHS/basic solution vector */
//C     #else
//C       #define PREC_BASICSOLUTION    lp->epsmachine  /* Zero-rounding of RHS/basic solution vector */
//C     #endif
//C     #define LIMIT_ABS_REL         10.0  /* Limit for testing using relative metric */

const LIMIT_ABS_REL = 10.0;

/* Parameters constants for short-cut setting of tolerances                           */
/* -------------------------------------------------------------------------------------- */
//C     #define EPS_TIGHT                0
//C     #define EPS_MEDIUM               1
const EPS_TIGHT = 0;
//C     #define EPS_LOOSE                2
const EPS_MEDIUM = 1;
//C     #define EPS_BAGGY                3
const EPS_LOOSE = 2;
//C     #define EPS_DEFAULT              EPS_TIGHT
const EPS_BAGGY = 3;

alias EPS_TIGHT EPS_DEFAULT;

//C     #if ActivePARAM==ProductionPARAM    /* PARAMETER SET FOR PRODUCTION                       */
/* -------------------------------------------------------------------------------------- */
//C     #define DEF_INFINITE       1.0e+30  /* Limit for dynamic range */
//C     #define DEF_EPSVALUE       1.0e-12  /* High accuracy and feasibility preserving tolerance */
const DEF_INFINITE = 1.0e+30;
//C     #define DEF_EPSPRIMAL      1.0e-10  /* For rounding primal/RHS values to 0 */
const DEF_EPSVALUE = 1.0e-12;
//C     #define DEF_EPSDUAL        1.0e-09  /* For rounding reduced costs to 0 */
const DEF_EPSPRIMAL = 1.0e-10;
//C     #define DEF_EPSPIVOT       2.0e-07  /* Pivot reject threshold */
const DEF_EPSDUAL = 1.0e-09;
//C     #define DEF_PERTURB        1.0e-05  
/* Perturbation scalar for degenerate problems;
const DEF_EPSPIVOT = 2.0e-07;
                                       must at least be RANDSCALE greater than EPSPRIMAL */
//C     #define DEF_EPSSOLUTION    1.0e-05  /* Margin of error for solution bounds */
const DEF_PERTURB = 1.0e-05;
//C     #define DEF_EPSINT         1.0e-07  /* Accuracy for considering a float value as integer */
const DEF_EPSSOLUTION = 1.0e-05;

const DEF_EPSINT = 1.0e-07;
//C     #elif ActivePARAM==OriginalPARAM    /* PARAMETER SET FOR LEGACY VERSIONS                  */
/* -------------------------------------------------------------------------------------- */
//C     #define DEF_INFINITE       1.0e+24  /* Limit for dynamic range */
//C     #define DEF_EPSVALUE       1.0e-08  /* High accuracy and feasibility preserving tolerance */
//C     #define DEF_EPSPRIMAL     5.01e-07  /* For rounding primal/RHS values to 0, infeasibility */
//C     #define DEF_EPSDUAL        1.0e-06  /* For rounding reduced costs to 0 */
//C     #define DEF_EPSPIVOT       1.0e-04  /* Pivot reject threshold */
//C     #define DEF_PERTURB        1.0e-05  
/* Perturbation scalar for degenerate problems;
                                       must at least be RANDSCALE greater than EPSPRIMAL */
//C     #define DEF_EPSSOLUTION    1.0e-02  /* Margin of error for solution bounds */
//C     #define DEF_EPSINT         1.0e-03  /* Accuracy for considering a float value as integer */

//C     #elif ActivePARAM==ChvatalPARAM     /* PARAMETER SET EXAMPLES FROM Vacek Chvatal          */
/* -------------------------------------------------------------------------------------- */
//C     #define DEF_INFINITE       1.0e+30  /* Limit for dynamic range */
//C     #define DEF_EPSVALUE       1.0e-10  /* High accuracy and feasibility preserving tolerance */
//C     #define DEF_EPSPRIMAL       10e-07  /* For rounding primal/RHS values to 0 */
//C     #define DEF_EPSDUAL         10e-05  /* For rounding reduced costs to 0 */
//C     #define DEF_EPSPIVOT        10e-05  /* Pivot reject threshold */
//C     #define DEF_PERTURB         10e-03  
/* Perturbation scalar for degenerate problems;
                                       must at least be RANDSCALE greater than EPSPRIMAL */
//C     #define DEF_EPSSOLUTION    1.0e-05  /* Margin of error for solution bounds */
//C     #define DEF_EPSINT         5.0e-03  /* Accuracy for considering a float value as integer */

//C     #elif ActivePARAM==LoosePARAM       /* PARAMETER SET FOR LOOSE TOLERANCES                 */
/* -------------------------------------------------------------------------------------- */
//C     #define DEF_INFINITE       1.0e+30  /* Limit for dynamic range */
//C     #define DEF_EPSVALUE       1.0e-10  /* High accuracy and feasibility preserving tolerance */
//C     #define DEF_EPSPRIMAL     5.01e-08  /* For rounding primal/RHS values to 0 */
//C     #define DEF_EPSDUAL        1.0e-07  /* For rounding reduced costs to 0 */
//C     #define DEF_EPSPIVOT       1.0e-05  /* Pivot reject threshold */
//C     #define DEF_PERTURB        1.0e-05  
/* Perturbation scalar for degenerate problems;
                                       must at least be RANDSCALE greater than EPSPRIMAL */
//C     #define DEF_EPSSOLUTION    1.0e-05  /* Margin of error for solution bounds */
//C     #define DEF_EPSINT         1.0e-04  /* Accuracy for considering a float value as integer */

//C     #endif


//C     #define DEF_MIP_GAP        1.0e-11  /* The default absolute and relative MIP gap */
//C     #define SCALEDINTFIXRANGE      1.6  /* Epsilon range multiplier < 2 for collapsing bounds to fix */
const DEF_MIP_GAP = 1.0e-11;

const SCALEDINTFIXRANGE = 1.6;
//C     #define MIN_SCALAR         1.0e-10  /* Smallest allowed scaling adjustment */
//C     #define MAX_SCALAR         1.0e+10  /* Largest allowed scaling adjustment */
const MIN_SCALAR = 1.0e-10;
//C     #define DEF_SCALINGEPS     1.0e-02  /* Relative scaling convergence criterion for auto_scale */
const MAX_SCALAR = 1.0e+10;

const DEF_SCALINGEPS = 1.0e-02;
//C     #define DEF_LAGACCEPT      1.0e-03  /* Default Lagrangean convergence acceptance criterion */
//C     #define DEF_LAGCONTRACT       0.90  /* The contraction parameter for Lagrangean iterations */
const DEF_LAGACCEPT = 1.0e-03;
//C     #define DEF_LAGMAXITERATIONS   100  /* The maximum number of Lagrangean iterations */
const DEF_LAGCONTRACT = 0.90;

const DEF_LAGMAXITERATIONS = 100;
//C     #define DEF_PSEUDOCOSTUPDATES    7  
/* The default number of times pseudo-costs are recalculated;
                                       experiments indicate that costs tend to stabilize */
//C     #define DEF_PSEUDOCOSTRESTART 0.15  
/* The fraction of price updates required for B&B restart
const DEF_PSEUDOCOSTUPDATES = 7;
                                       when the mode is NODE_RESTARTMODE */
//C     #define DEF_MAXPRESOLVELOOPS     0  
/* Upper limit to the number of loops during presolve,
const DEF_PSEUDOCOSTRESTART = 0.15;
                                       <= 0 for no limit. */

const DEF_MAXPRESOLVELOOPS = 0;

/* Hashing prototypes and function headers                                   */
/* ------------------------------------------------------------------------- */
//C     #include "lp_Hash.h"
import lp_solve.lp_Hash;


/* Sparse matrix prototypes                                                  */
/* ------------------------------------------------------------------------- */
//C     #include "lp_matrix.h"
import lp_solve.lp_matrix;


/* Basis storage (mainly for B&B) */
//C     typedef struct _basisrec
//C     {
//C       int       level;
//C       int       *var_basic;
//C       MYBOOL    *is_basic;
//C       MYBOOL    *is_lower;
//C       int       pivots;
//C       struct   _basisrec *previous;
//C     } basisrec;
struct _basisrec
{
    int level;
    int *var_basic;
    ubyte *is_basic;
    ubyte *is_lower;
    int pivots;
    _basisrec *previous;
}
extern (C):
alias _basisrec basisrec;

/* Presolve undo data storage */
//C     typedef struct _presolveundorec
//C     {
//C       lprec     *lp;
//C       int       orig_rows;
//C       int       orig_columns;
//C       int       orig_sum;
//C       int       *var_to_orig;       
/* sum_alloc+1 : Mapping of variables from solution to
                                   best_solution to account for removed variables and
                                   rows during presolve; a non-positive value indicates
                                   that the constraint or variable was removed */
//C       int       *orig_to_var;       
/* sum_alloc+1 : Mapping from original variable index to
                                   current / working index number */
//C       REAL      *fixed_rhs;         /* rows_alloc+1 : Storage of values of presolved fixed colums */
//C       REAL      *fixed_obj;         /* columns_alloc+1: Storage of values of presolved fixed rows */
//C       DeltaVrec *deletedA;          /* A matrix of eliminated data from matA */
//C       DeltaVrec *primalundo;        /* Affine translation vectors for eliminated primal variables */
//C       DeltaVrec *dualundo;          /* Affine translation vectors for eliminated dual variables */
//C       MYBOOL    OFcolsdeleted;
//C     } presolveundorec;
struct _presolveundorec
{
    lprec *lp;
    int orig_rows;
    int orig_columns;
    int orig_sum;
    int *var_to_orig;
    int *orig_to_var;
    double *fixed_rhs;
    double *fixed_obj;
    DeltaVrec *deletedA;
    DeltaVrec *primalundo;
    DeltaVrec *dualundo;
    ubyte OFcolsdeleted;
}
alias _presolveundorec presolveundorec;

/* Pseudo-cost arrays used during B&B */
//C     typedef struct _BBPSrec
//C     {
//C       lprec     *lp;
//C       int       pseodotype;
//C       int       updatelimit;
//C       int       updatesfinished;
//C       REAL      restartlimit;
//C       MATitem   *UPcost;
//C       MATitem   *LOcost;
//C       struct   _BBPSrec *secondary;
//C     } BBPSrec;
struct _BBPSrec
{
    lprec *lp;
    int pseodotype;
    int updatelimit;
    int updatesfinished;
    double restartlimit;
    MATitem *UPcost;
    MATitem *LOcost;
    _BBPSrec *secondary;
}
alias _BBPSrec BBPSrec;

//C     #include "lp_mipbb.h"
import lp_solve.lp_mipbb;


/* Partial pricing block data */
//C     typedef struct _partialrec {
//C       lprec     *lp;
//C       int       blockcount;         /* ## The number of logical blocks or stages in the model */
//C       int       blocknow;           /* The currently active block */
//C       int       *blockend;          /* Array of column indeces giving the start of each block */
//C       int       *blockpos;          /* Array of column indeces giving the start scan position */
//C       MYBOOL    isrow;
//C     } partialrec;
struct _partialrec
{
    lprec *lp;
    int blockcount;
    int blocknow;
    int *blockend;
    int *blockpos;
    ubyte isrow;
}
alias _partialrec partialrec;


/* Specially Ordered Sets (SOS) prototypes and settings                      */
/* ------------------------------------------------------------------------- */
/* SOS storage structure (LINEARSEARCH is typically in the 0-10 range)       */
//C     #ifndef LINEARSEARCH
//C     #define LINEARSEARCH 0
//C     #endif
const LINEARSEARCH = 0;

//C     #include "lp_SOS.h"
import lp_solve.lp_SOS;


/* Prototypes for user call-back functions                                   */
/* ------------------------------------------------------------------------- */
//C     typedef int    (__WINAPI lphandle_intfunc)(lprec *lp, void *userhandle);
alias int function(lprec *lp, void *userhandle) lphandle_intfunc;
//C     typedef void   (__WINAPI lphandlestr_func)(lprec *lp, void *userhandle, char *buf);
alias void function(lprec *lp, void *userhandle, char *buf)lphandlestr_func;
//C     typedef void   (__WINAPI lphandleint_func)(lprec *lp, void *userhandle, int message);
alias void function(lprec *lp, void *userhandle, int message)lphandleint_func;
//C     typedef int    (__WINAPI lphandleint_intfunc)(lprec *lp, void *userhandle, int message);
alias int function(lprec *lp, void *userhandle, int message)lphandleint_intfunc;


/* API typedef definitions                                                   */
/* ------------------------------------------------------------------------- */
//C     typedef MYBOOL (__WINAPI add_column_func)(lprec *lp, REAL *column);
alias ubyte function(lprec *lp, double *column)add_column_func;
//C     typedef MYBOOL (__WINAPI add_columnex_func)(lprec *lp, int count, REAL *column, int *rowno);
alias ubyte function(lprec *lp, int count, double *column, int *rowno)add_columnex_func;
//C     typedef MYBOOL (__WINAPI add_constraint_func)(lprec *lp, REAL *row, int constr_type, REAL rh);
alias ubyte function(lprec *lp, double *row, int constr_type, double rh)add_constraint_func;
//C     typedef MYBOOL (__WINAPI add_constraintex_func)(lprec *lp, int count, REAL *row, int *colno, int constr_type, REAL rh);
alias ubyte function(lprec *lp, int count, double *row, int *colno, int constr_type, double rh)add_constraintex_func;
//C     typedef MYBOOL (__WINAPI add_lag_con_func)(lprec *lp, REAL *row, int con_type, REAL rhs);
alias ubyte function(lprec *lp, double *row, int con_type, double rhs)add_lag_con_func;
//C     typedef int (__WINAPI add_SOS_func)(lprec *lp, char *name, int sostype, int priority, int count, int *sosvars, REAL *weights);
alias int function(lprec *lp, char *name, int sostype, int priority, int count, int *sosvars, double *weights)add_SOS_func;
//C     typedef int (__WINAPI column_in_lp_func)(lprec *lp, REAL *column);
alias int function(lprec *lp, double *column)column_in_lp_func;
//C     typedef lprec * (__WINAPI copy_lp_func)(lprec *lp);
alias lprec *function(lprec *lp)copy_lp_func;
//C     typedef void (__WINAPI default_basis_func)(lprec *lp);
alias void function(lprec *lp)default_basis_func;
//C     typedef MYBOOL (__WINAPI del_column_func)(lprec *lp, int colnr);
alias ubyte function(lprec *lp, int colnr)del_column_func;
//C     typedef MYBOOL (__WINAPI del_constraint_func)(lprec *lp, int rownr);
alias ubyte function(lprec *lp, int rownr)del_constraint_func;
//C     typedef void (__WINAPI delete_lp_func)(lprec *lp);
alias void function(lprec *lp)delete_lp_func;
//C     typedef MYBOOL (__WINAPI dualize_lp_func)(lprec *lp);
alias ubyte function(lprec *lp)dualize_lp_func;
//C     typedef void (__WINAPI free_lp_func)(lprec **plp);
alias void function(lprec **plp)free_lp_func;
//C     typedef int (__WINAPI get_anti_degen_func)(lprec *lp);
alias int function(lprec *lp)get_anti_degen_func;
//C     typedef MYBOOL (__WINAPI get_basis_func)(lprec *lp, int *bascolumn, MYBOOL nonbasic);
alias ubyte function(lprec *lp, int *bascolumn, ubyte nonbasic)get_basis_func;
//C     typedef int (__WINAPI get_basiscrash_func)(lprec *lp);
alias int function(lprec *lp)get_basiscrash_func;
//C     typedef int (__WINAPI get_bb_depthlimit_func)(lprec *lp);
alias int function(lprec *lp)get_bb_depthlimit_func;
//C     typedef int (__WINAPI get_bb_floorfirst_func)(lprec *lp);
alias int function(lprec *lp)get_bb_floorfirst_func;
//C     typedef int (__WINAPI get_bb_rule_func)(lprec *lp);
alias int function(lprec *lp)get_bb_rule_func;
//C     typedef MYBOOL (__WINAPI get_bounds_tighter_func)(lprec *lp);
alias ubyte function(lprec *lp)get_bounds_tighter_func;
//C     typedef REAL (__WINAPI get_break_at_value_func)(lprec *lp);
alias double function(lprec *lp)get_break_at_value_func;
//C     typedef char * (__WINAPI get_col_name_func)(lprec *lp, int colnr);
alias char *function(lprec *lp, int colnr)get_col_name_func;
//C     typedef MYBOOL (__WINAPI get_column_func)(lprec *lp, int colnr, REAL *column);
alias ubyte function(lprec *lp, int colnr, double *column)get_column_func;
//C     typedef int (__WINAPI get_columnex_func)(lprec *lp, int colnr, REAL *column, int *nzrow);
alias int function(lprec *lp, int colnr, double *column, int *nzrow)get_columnex_func;
//C     typedef int (__WINAPI get_constr_type_func)(lprec *lp, int rownr);
alias int function(lprec *lp, int rownr)get_constr_type_func;
//C     typedef REAL (__WINAPI get_constr_value_func)(lprec *lp, int rownr, int count, REAL *primsolution, int *nzindex);
alias double function(lprec *lp, int rownr, int count, double *primsolution, int *nzindex)get_constr_value_func;
//C     typedef MYBOOL (__WINAPI get_constraints_func)(lprec *lp, REAL *constr);
alias ubyte function(lprec *lp, double *constr)get_constraints_func;
//C     typedef MYBOOL (__WINAPI get_dual_solution_func)(lprec *lp, REAL *rc);
alias ubyte function(lprec *lp, double *rc)get_dual_solution_func;
//C     typedef REAL (__WINAPI get_epsb_func)(lprec *lp);
alias double function(lprec *lp)get_epsb_func;
//C     typedef REAL (__WINAPI get_epsd_func)(lprec *lp);
alias double function(lprec *lp)get_epsd_func;
//C     typedef REAL (__WINAPI get_epsel_func)(lprec *lp);
alias double function(lprec *lp)get_epsel_func;
//C     typedef REAL (__WINAPI get_epsint_func)(lprec *lp);
alias double function(lprec *lp)get_epsint_func;
//C     typedef REAL (__WINAPI get_epsperturb_func)(lprec *lp);
alias double function(lprec *lp)get_epsperturb_func;
//C     typedef REAL (__WINAPI get_epspivot_func)(lprec *lp);
alias double function(lprec *lp)get_epspivot_func;
//C     typedef int (__WINAPI get_improve_func)(lprec *lp);
alias int function(lprec *lp)get_improve_func;
//C     typedef REAL (__WINAPI get_infinite_func)(lprec *lp);
alias double function(lprec *lp)get_infinite_func;
//C     typedef MYBOOL (__WINAPI get_lambda_func)(lprec *lp, REAL *lambda);
alias ubyte function(lprec *lp, double *lambda)get_lambda_func;
//C     typedef REAL (__WINAPI get_lowbo_func)(lprec *lp, int colnr);
alias double function(lprec *lp, int colnr)get_lowbo_func;
//C     typedef int (__WINAPI get_lp_index_func)(lprec *lp, int orig_index);
alias int function(lprec *lp, int orig_index)get_lp_index_func;
//C     typedef char * (__WINAPI get_lp_name_func)(lprec *lp);
alias char *function(lprec *lp)get_lp_name_func;
//C     typedef int (__WINAPI get_Lrows_func)(lprec *lp);
alias int function(lprec *lp)get_Lrows_func;
//C     typedef REAL (__WINAPI get_mat_func)(lprec *lp, int rownr, int colnr);
alias double function(lprec *lp, int rownr, int colnr)get_mat_func;
//C     typedef REAL (__WINAPI get_mat_byindex_func)(lprec *lp, int matindex, MYBOOL isrow, MYBOOL adjustsign);
alias double function(lprec *lp, int matindex, ubyte isrow, ubyte adjustsign)get_mat_byindex_func;
//C     typedef int (__WINAPI get_max_level_func)(lprec *lp);
alias int function(lprec *lp)get_max_level_func;
//C     typedef int (__WINAPI get_maxpivot_func)(lprec *lp);
alias int function(lprec *lp)get_maxpivot_func;
//C     typedef REAL (__WINAPI get_mip_gap_func)(lprec *lp, MYBOOL absolute);
alias double function(lprec *lp, ubyte absolute)get_mip_gap_func;
//C     typedef int (__WINAPI get_multiprice_func)(lprec *lp, MYBOOL getabssize);
alias int function(lprec *lp, ubyte getabssize)get_multiprice_func;
//C     typedef MYBOOL (__WINAPI is_use_names_func)(lprec *lp, MYBOOL isrow);
alias ubyte function(lprec *lp, ubyte isrow)is_use_names_func;
//C     typedef void (__WINAPI set_use_names_func)(lprec *lp, MYBOOL isrow, MYBOOL use_names);
alias void function(lprec *lp, ubyte isrow, ubyte use_names)set_use_names_func;
//C     typedef int (__WINAPI get_nameindex_func)(lprec *lp, char *varname, MYBOOL isrow);
alias int function(lprec *lp, char *varname, ubyte isrow)get_nameindex_func;
//C     typedef int (__WINAPI get_Ncolumns_func)(lprec *lp);
alias int function(lprec *lp)get_Ncolumns_func;
//C     typedef REAL (__WINAPI get_negrange_func)(lprec *lp);
alias double function(lprec *lp)get_negrange_func;
//C     typedef int (__WINAPI get_nz_func)(lprec *lp);
alias int function(lprec *lp)get_nz_func;
//C     typedef int (__WINAPI get_Norig_columns_func)(lprec *lp);
alias int function(lprec *lp)get_Norig_columns_func;
//C     typedef int (__WINAPI get_Norig_rows_func)(lprec *lp);
alias int function(lprec *lp)get_Norig_rows_func;
//C     typedef int (__WINAPI get_Nrows_func)(lprec *lp);
alias int function(lprec *lp)get_Nrows_func;
//C     typedef REAL (__WINAPI get_obj_bound_func)(lprec *lp);
alias double function(lprec *lp)get_obj_bound_func;
//C     typedef REAL (__WINAPI get_objective_func)(lprec *lp);
alias double function(lprec *lp)get_objective_func;
//C     typedef int (__WINAPI get_orig_index_func)(lprec *lp, int lp_index);
alias int function(lprec *lp, int lp_index)get_orig_index_func;
//C     typedef char * (__WINAPI get_origcol_name_func)(lprec *lp, int colnr);
alias char *function(lprec *lp, int colnr)get_origcol_name_func;
//C     typedef char * (__WINAPI get_origrow_name_func)(lprec *lp, int rownr);
alias char *function(lprec *lp, int rownr)get_origrow_name_func;
//C     typedef void (__WINAPI get_partialprice_func)(lprec *lp, int *blockcount, int *blockstart, MYBOOL isrow);
alias void function(lprec *lp, int *blockcount, int *blockstart, ubyte isrow)get_partialprice_func;
//C     typedef int (__WINAPI get_pivoting_func)(lprec *lp);
alias int function(lprec *lp)get_pivoting_func;
//C     typedef int (__WINAPI get_presolve_func)(lprec *lp);
alias int function(lprec *lp)get_presolve_func;
//C     typedef int (__WINAPI get_presolveloops_func)(lprec *lp);
alias int function(lprec *lp)get_presolveloops_func;
//C     typedef MYBOOL (__WINAPI get_primal_solution_func)(lprec *lp, REAL *pv);
alias ubyte function(lprec *lp, double *pv)get_primal_solution_func;
//C     typedef int (__WINAPI get_print_sol_func)(lprec *lp);
alias int function(lprec *lp)get_print_sol_func;
//C     typedef MYBOOL (__WINAPI get_pseudocosts_func)(lprec *lp, REAL *clower, REAL *cupper, int *updatelimit);
alias ubyte function(lprec *lp, double *clower, double *cupper, int *updatelimit)get_pseudocosts_func;
//C     typedef MYBOOL (__WINAPI get_ptr_constraints_func)(lprec *lp, REAL **constr);
alias ubyte function(lprec *lp, double **constr)get_ptr_constraints_func;
//C     typedef MYBOOL (__WINAPI get_ptr_dual_solution_func)(lprec *lp, REAL **rc);
alias ubyte function(lprec *lp, double **rc)get_ptr_dual_solution_func;
//C     typedef MYBOOL (__WINAPI get_ptr_lambda_func)(lprec *lp, REAL **lambda);
alias ubyte function(lprec *lp, double **lambda)get_ptr_lambda_func;
//C     typedef MYBOOL (__WINAPI get_ptr_primal_solution_func)(lprec *lp, REAL **pv);
alias ubyte function(lprec *lp, double **pv)get_ptr_primal_solution_func;
//C     typedef MYBOOL (__WINAPI get_ptr_sensitivity_obj_func)(lprec *lp, REAL **objfrom, REAL **objtill);
alias ubyte function(lprec *lp, double **objfrom, double **objtill)get_ptr_sensitivity_obj_func;
//C     typedef MYBOOL (__WINAPI get_ptr_sensitivity_objex_func)(lprec *lp, REAL **objfrom, REAL **objtill, REAL **objfromvalue, REAL **objtillvalue);
alias ubyte function(lprec *lp, double **objfrom, double **objtill, double **objfromvalue, double **objtillvalue)get_ptr_sensitivity_objex_func;
//C     typedef MYBOOL (__WINAPI get_ptr_sensitivity_rhs_func)(lprec *lp, REAL **duals, REAL **dualsfrom, REAL **dualstill);
alias ubyte function(lprec *lp, double **duals, double **dualsfrom, double **dualstill)get_ptr_sensitivity_rhs_func;
//C     typedef MYBOOL (__WINAPI get_ptr_variables_func)(lprec *lp, REAL **var);
alias ubyte function(lprec *lp, double **var)get_ptr_variables_func;
//C     typedef REAL (__WINAPI get_rh_func)(lprec *lp, int rownr);
alias double function(lprec *lp, int rownr)get_rh_func;
//C     typedef REAL (__WINAPI get_rh_range_func)(lprec *lp, int rownr);
alias double function(lprec *lp, int rownr)get_rh_range_func;
//C     typedef int (__WINAPI get_rowex_func)(lprec *lp, int rownr, REAL *row, int *colno);
alias int function(lprec *lp, int rownr, double *row, int *colno)get_rowex_func;
//C     typedef MYBOOL (__WINAPI get_row_func)(lprec *lp, int rownr, REAL *row);
alias ubyte function(lprec *lp, int rownr, double *row)get_row_func;
//C     typedef char * (__WINAPI get_row_name_func)(lprec *lp, int rownr);
alias char *function(lprec *lp, int rownr)get_row_name_func;
//C     typedef REAL (__WINAPI get_scalelimit_func)(lprec *lp);
alias double function(lprec *lp)get_scalelimit_func;
//C     typedef int (__WINAPI get_scaling_func)(lprec *lp);
alias int function(lprec *lp)get_scaling_func;
//C     typedef MYBOOL (__WINAPI get_sensitivity_obj_func)(lprec *lp, REAL *objfrom, REAL *objtill);
alias ubyte function(lprec *lp, double *objfrom, double *objtill)get_sensitivity_obj_func;
//C     typedef MYBOOL (__WINAPI get_sensitivity_objex_func)(lprec *lp, REAL *objfrom, REAL *objtill, REAL *objfromvalue, REAL *objtillvalue);
alias ubyte function(lprec *lp, double *objfrom, double *objtill, double *objfromvalue, double *objtillvalue)get_sensitivity_objex_func;
//C     typedef MYBOOL (__WINAPI get_sensitivity_rhs_func)(lprec *lp, REAL *duals, REAL *dualsfrom, REAL *dualstill);
alias ubyte function(lprec *lp, double *duals, double *dualsfrom, double *dualstill)get_sensitivity_rhs_func;
//C     typedef int (__WINAPI get_simplextype_func)(lprec *lp);
alias int function(lprec *lp)get_simplextype_func;
//C     typedef int (__WINAPI get_solutioncount_func)(lprec *lp);
alias int function(lprec *lp)get_solutioncount_func;
//C     typedef int (__WINAPI get_solutionlimit_func)(lprec *lp);
alias int function(lprec *lp)get_solutionlimit_func;
//C     typedef int (__WINAPI get_status_func)(lprec *lp);
alias int function(lprec *lp)get_status_func;
//C     typedef char * (__WINAPI get_statustext_func)(lprec *lp, int statuscode);
alias char *function(lprec *lp, int statuscode)get_statustext_func;
//C     typedef long (__WINAPI get_timeout_func)(lprec *lp);
alias int function(lprec *lp)get_timeout_func;
//C     typedef COUNTER (__WINAPI get_total_iter_func)(lprec *lp);
alias long function(lprec *lp)get_total_iter_func;
//C     typedef COUNTER (__WINAPI get_total_nodes_func)(lprec *lp);
alias long function(lprec *lp)get_total_nodes_func;
//C     typedef REAL (__WINAPI get_upbo_func)(lprec *lp, int colnr);
alias double function(lprec *lp, int colnr)get_upbo_func;
//C     typedef int (__WINAPI get_var_branch_func)(lprec *lp, int colnr);
alias int function(lprec *lp, int colnr)get_var_branch_func;
//C     typedef REAL (__WINAPI get_var_dualresult_func)(lprec *lp, int index);
alias double function(lprec *lp, int index)get_var_dualresult_func;
//C     typedef REAL (__WINAPI get_var_primalresult_func)(lprec *lp, int index);
alias double function(lprec *lp, int index)get_var_primalresult_func;
//C     typedef int (__WINAPI get_var_priority_func)(lprec *lp, int colnr);
alias int function(lprec *lp, int colnr)get_var_priority_func;
//C     typedef MYBOOL (__WINAPI get_variables_func)(lprec *lp, REAL *var);
alias ubyte function(lprec *lp, double *var)get_variables_func;
//C     typedef int (__WINAPI get_verbose_func)(lprec *lp);
alias int function(lprec *lp)get_verbose_func;
//C     typedef MYBOOL (__WINAPI guess_basis_func)(lprec *lp, REAL *guessvector, int *basisvector);
alias ubyte function(lprec *lp, double *guessvector, int *basisvector)guess_basis_func;
//C     typedef REAL (__WINAPI get_working_objective_func)(lprec *lp);
alias double function(lprec *lp)get_working_objective_func;
//C     typedef MYBOOL (__WINAPI has_BFP_func)(lprec *lp);
alias ubyte function(lprec *lp)has_BFP_func;
//C     typedef MYBOOL (__WINAPI has_XLI_func)(lprec *lp);
alias ubyte function(lprec *lp)has_XLI_func;
//C     typedef MYBOOL (__WINAPI is_add_rowmode_func)(lprec *lp);
alias ubyte function(lprec *lp)is_add_rowmode_func;
//C     typedef MYBOOL (__WINAPI is_anti_degen_func)(lprec *lp, int testmask);
alias ubyte function(lprec *lp, int testmask)is_anti_degen_func;
//C     typedef MYBOOL (__WINAPI is_binary_func)(lprec *lp, int colnr);
alias ubyte function(lprec *lp, int colnr)is_binary_func;
//C     typedef MYBOOL (__WINAPI is_break_at_first_func)(lprec *lp);
alias ubyte function(lprec *lp)is_break_at_first_func;
//C     typedef MYBOOL (__WINAPI is_constr_type_func)(lprec *lp, int rownr, int mask);
alias ubyte function(lprec *lp, int rownr, int mask)is_constr_type_func;
//C     typedef MYBOOL (__WINAPI is_debug_func)(lprec *lp);
alias ubyte function(lprec *lp)is_debug_func;
//C     typedef MYBOOL (__WINAPI is_feasible_func)(lprec *lp, REAL *values, REAL threshold);
alias ubyte function(lprec *lp, double *values, double threshold)is_feasible_func;
//C     typedef MYBOOL (__WINAPI is_unbounded_func)(lprec *lp, int colnr);
alias ubyte function(lprec *lp, int colnr)is_unbounded_func;
//C     typedef MYBOOL (__WINAPI is_infinite_func)(lprec *lp, REAL value);
alias ubyte function(lprec *lp, double value)is_infinite_func;
//C     typedef MYBOOL (__WINAPI is_int_func)(lprec *lp, int column);
alias ubyte function(lprec *lp, int column)is_int_func;
//C     typedef MYBOOL (__WINAPI is_integerscaling_func)(lprec *lp);
alias ubyte function(lprec *lp)is_integerscaling_func;
//C     typedef MYBOOL (__WINAPI is_lag_trace_func)(lprec *lp);
alias ubyte function(lprec *lp)is_lag_trace_func;
//C     typedef MYBOOL (__WINAPI is_maxim_func)(lprec *lp);
alias ubyte function(lprec *lp)is_maxim_func;
//C     typedef MYBOOL (__WINAPI is_nativeBFP_func)(lprec *lp);
alias ubyte function(lprec *lp)is_nativeBFP_func;
//C     typedef MYBOOL (__WINAPI is_nativeXLI_func)(lprec *lp);
alias ubyte function(lprec *lp)is_nativeXLI_func;
//C     typedef MYBOOL (__WINAPI is_negative_func)(lprec *lp, int colnr);
alias ubyte function(lprec *lp, int colnr)is_negative_func;
//C     typedef MYBOOL (__WINAPI is_obj_in_basis_func)(lprec *lp);
alias ubyte function(lprec *lp)is_obj_in_basis_func;
//C     typedef MYBOOL (__WINAPI is_piv_mode_func)(lprec *lp, int testmask);
alias ubyte function(lprec *lp, int testmask)is_piv_mode_func;
//C     typedef MYBOOL (__WINAPI is_piv_rule_func)(lprec *lp, int rule);
alias ubyte function(lprec *lp, int rule)is_piv_rule_func;
//C     typedef MYBOOL (__WINAPI is_presolve_func)(lprec *lp, int testmask);
alias ubyte function(lprec *lp, int testmask)is_presolve_func;
//C     typedef MYBOOL (__WINAPI is_scalemode_func)(lprec *lp, int testmask);
alias ubyte function(lprec *lp, int testmask)is_scalemode_func;
//C     typedef MYBOOL (__WINAPI is_scaletype_func)(lprec *lp, int scaletype);
alias ubyte function(lprec *lp, int scaletype)is_scaletype_func;
//C     typedef MYBOOL (__WINAPI is_semicont_func)(lprec *lp, int colnr);
alias ubyte function(lprec *lp, int colnr)is_semicont_func;
//C     typedef MYBOOL (__WINAPI is_SOS_var_func)(lprec *lp, int colnr);
alias ubyte function(lprec *lp, int colnr)is_SOS_var_func;
//C     typedef MYBOOL (__WINAPI is_trace_func)(lprec *lp);
alias ubyte function(lprec *lp)is_trace_func;
//C     typedef void (__WINAPI lp_solve_version_func)(int *majorversion, int *minorversion, int *release, int *build);
alias void function(int *majorversion, int *minorversion, int *release, int *build)lp_solve_version_func;
//C     typedef lprec * (__WINAPI make_lp_func)(int rows, int columns);
alias lprec *function(int rows, int columns)make_lp_func;
//C     typedef void (__WINAPI print_constraints_func)(lprec *lp, int columns);
alias void function(lprec *lp, int columns)print_constraints_func;
//C     typedef MYBOOL (__WINAPI print_debugdump_func)(lprec *lp, char *filename);
alias ubyte function(lprec *lp, char *filename)print_debugdump_func;
//C     typedef void (__WINAPI print_duals_func)(lprec *lp);
alias void function(lprec *lp)print_duals_func;
//C     typedef void (__WINAPI print_lp_func)(lprec *lp);
alias void function(lprec *lp)print_lp_func;
//C     typedef void (__WINAPI print_objective_func)(lprec *lp);
alias void function(lprec *lp)print_objective_func;
//C     typedef void (__WINAPI print_scales_func)(lprec *lp);
alias void function(lprec *lp)print_scales_func;
//C     typedef void (__WINAPI print_solution_func)(lprec *lp, int columns);
alias void function(lprec *lp, int columns)print_solution_func;
//C     typedef void (__WINAPI print_str_func)(lprec *lp, char *str);
alias void function(lprec *lp, char *str)print_str_func;
//C     typedef void (__WINAPI print_tableau_func)(lprec *lp);
alias void function(lprec *lp)print_tableau_func;
//C     typedef void (__WINAPI put_abortfunc_func)(lprec *lp, lphandle_intfunc newctrlc, void *ctrlchandle);
alias void function(lprec *lp, int  function(lprec *lp, void *userhandle)newctrlc, void *ctrlchandle)put_abortfunc_func;
//C     typedef void (__WINAPI put_bb_nodefunc_func)(lprec *lp, lphandleint_intfunc newnode, void *bbnodehandle);
alias void function(lprec *lp, int  function(lprec *lp, void *userhandle, int message)newnode, void *bbnodehandle)put_bb_nodefunc_func;
//C     typedef void (__WINAPI put_bb_branchfunc_func)(lprec *lp, lphandleint_intfunc newbranch, void *bbbranchhandle);
alias void function(lprec *lp, int  function(lprec *lp, void *userhandle, int message)newbranch, void *bbbranchhandle)put_bb_branchfunc_func;
//C     typedef void (__WINAPI put_logfunc_func)(lprec *lp, lphandlestr_func newlog, void *loghandle);
alias void function(lprec *lp, void  function(lprec *lp, void *userhandle, char *buf)newlog, void *loghandle)put_logfunc_func;
//C     typedef void (__WINAPI put_msgfunc_func)(lprec *lp, lphandleint_func newmsg, void *msghandle, int mask);
alias void function(lprec *lp, void  function(lprec *lp, void *userhandle, int message)newmsg, void *msghandle, int mask)put_msgfunc_func;
//C     typedef lprec * (__WINAPI read_LP_func)(char *filename, int verbose, char *lp_name);
alias lprec *function(char *filename, int verbose, char *lp_name)read_LP_func;
//C     typedef lprec * (__WINAPI read_MPS_func)(char *filename, int options);
alias lprec *function(char *filename, int options)read_MPS_func;
//C     typedef lprec * (__WINAPI read_XLI_func)(char *xliname, char *modelname, char *dataname, char *options, int verbose);
alias lprec *function(char *xliname, char *modelname, char *dataname, char *options, int verbose)read_XLI_func;
//C     typedef MYBOOL (__WINAPI read_basis_func)(lprec *lp, char *filename, char *info);
alias ubyte function(lprec *lp, char *filename, char *info)read_basis_func;
//C     typedef void (__WINAPI reset_basis_func)(lprec *lp);
alias void function(lprec *lp)reset_basis_func;
//C     typedef MYBOOL (__WINAPI read_params_func)(lprec *lp, char *filename, char *options);
alias ubyte function(lprec *lp, char *filename, char *options)read_params_func;
//C     typedef void (__WINAPI reset_params_func)(lprec *lp);
alias void function(lprec *lp)reset_params_func;
//C     typedef MYBOOL (__WINAPI resize_lp_func)(lprec *lp, int rows, int columns);
alias ubyte function(lprec *lp, int rows, int columns)resize_lp_func;
//C     typedef MYBOOL (__WINAPI set_add_rowmode_func)(lprec *lp, MYBOOL turnon);
alias ubyte function(lprec *lp, ubyte turnon)set_add_rowmode_func;
//C     typedef void (__WINAPI set_anti_degen_func)(lprec *lp, int anti_degen);
alias void function(lprec *lp, int anti_degen)set_anti_degen_func;
//C     typedef int  (__WINAPI set_basisvar_func)(lprec *lp, int basisPos, int enteringCol);
alias int function(lprec *lp, int basisPos, int enteringCol)set_basisvar_func;
//C     typedef MYBOOL (__WINAPI set_basis_func)(lprec *lp, int *bascolumn, MYBOOL nonbasic);
alias ubyte function(lprec *lp, int *bascolumn, ubyte nonbasic)set_basis_func;
//C     typedef void (__WINAPI set_basiscrash_func)(lprec *lp, int mode);
alias void function(lprec *lp, int mode)set_basiscrash_func;
//C     typedef void (__WINAPI set_bb_depthlimit_func)(lprec *lp, int bb_maxlevel);
alias void function(lprec *lp, int bb_maxlevel)set_bb_depthlimit_func;
//C     typedef void (__WINAPI set_bb_floorfirst_func)(lprec *lp, int bb_floorfirst);
alias void function(lprec *lp, int bb_floorfirst)set_bb_floorfirst_func;
//C     typedef void (__WINAPI set_bb_rule_func)(lprec *lp, int bb_rule);
alias void function(lprec *lp, int bb_rule)set_bb_rule_func;
//C     typedef MYBOOL (__WINAPI set_BFP_func)(lprec *lp, char *filename);
alias ubyte function(lprec *lp, char *filename)set_BFP_func;
//C     typedef MYBOOL (__WINAPI set_binary_func)(lprec *lp, int colnr, MYBOOL must_be_bin);
alias ubyte function(lprec *lp, int colnr, ubyte must_be_bin)set_binary_func;
//C     typedef MYBOOL (__WINAPI set_bounds_func)(lprec *lp, int colnr, REAL lower, REAL upper);
alias ubyte function(lprec *lp, int colnr, double lower, double upper)set_bounds_func;
//C     typedef void (__WINAPI set_bounds_tighter_func)(lprec *lp, MYBOOL tighten);
alias void function(lprec *lp, ubyte tighten)set_bounds_tighter_func;
//C     typedef void (__WINAPI set_break_at_first_func)(lprec *lp, MYBOOL break_at_first);
alias void function(lprec *lp, ubyte break_at_first)set_break_at_first_func;
//C     typedef void (__WINAPI set_break_at_value_func)(lprec *lp, REAL break_at_value);
alias void function(lprec *lp, double break_at_value)set_break_at_value_func;
//C     typedef MYBOOL (__WINAPI set_column_func)(lprec *lp, int colnr, REAL *column);
alias ubyte function(lprec *lp, int colnr, double *column)set_column_func;
//C     typedef MYBOOL (__WINAPI set_columnex_func)(lprec *lp, int colnr, int count, REAL *column, int *rowno);
alias ubyte function(lprec *lp, int colnr, int count, double *column, int *rowno)set_columnex_func;
//C     typedef MYBOOL (__WINAPI set_col_name_func)(lprec *lp, int colnr, char *new_name);
alias ubyte function(lprec *lp, int colnr, char *new_name)set_col_name_func;
//C     typedef MYBOOL (__WINAPI set_constr_type_func)(lprec *lp, int rownr, int con_type);
alias ubyte function(lprec *lp, int rownr, int con_type)set_constr_type_func;
//C     typedef void (__WINAPI set_debug_func)(lprec *lp, MYBOOL debug);
alias void function(lprec *lp, ubyte debug_)set_debug_func;
//C     typedef void (__WINAPI set_epsb_func)(lprec *lp, REAL epsb);
alias void function(lprec *lp, double epsb)set_epsb_func;
//C     typedef void (__WINAPI set_epsd_func)(lprec *lp, REAL epsd);
alias void function(lprec *lp, double epsd)set_epsd_func;
//C     typedef void (__WINAPI set_epsel_func)(lprec *lp, REAL epsel);
alias void function(lprec *lp, double epsel)set_epsel_func;
//C     typedef void (__WINAPI set_epsint_func)(lprec *lp, REAL epsint);
alias void function(lprec *lp, double epsint)set_epsint_func;
//C     typedef MYBOOL (__WINAPI set_epslevel_func)(lprec *lp, int epslevel);
alias ubyte function(lprec *lp, int epslevel)set_epslevel_func;
//C     typedef void (__WINAPI set_epsperturb_func)(lprec *lp, REAL epsperturb);
alias void function(lprec *lp, double epsperturb)set_epsperturb_func;
//C     typedef void (__WINAPI set_epspivot_func)(lprec *lp, REAL epspivot);
alias void function(lprec *lp, double epspivot)set_epspivot_func;
//C     typedef MYBOOL (__WINAPI set_unbounded_func)(lprec *lp, int colnr);
alias ubyte function(lprec *lp, int colnr)set_unbounded_func;
//C     typedef void (__WINAPI set_improve_func)(lprec *lp, int improve);
alias void function(lprec *lp, int improve)set_improve_func;
//C     typedef void (__WINAPI set_infinite_func)(lprec *lp, REAL infinite);
alias void function(lprec *lp, double infinite)set_infinite_func;
//C     typedef MYBOOL (__WINAPI set_int_func)(lprec *lp, int colnr, MYBOOL must_be_int);
alias ubyte function(lprec *lp, int colnr, ubyte must_be_int)set_int_func;
//C     typedef void (__WINAPI set_lag_trace_func)(lprec *lp, MYBOOL lag_trace);
alias void function(lprec *lp, ubyte lag_trace)set_lag_trace_func;
//C     typedef MYBOOL (__WINAPI set_lowbo_func)(lprec *lp, int colnr, REAL value);
alias ubyte function(lprec *lp, int colnr, double value)set_lowbo_func;
//C     typedef MYBOOL (__WINAPI set_lp_name_func)(lprec *lp, char *lpname);
alias ubyte function(lprec *lp, char *lpname)set_lp_name_func;
//C     typedef MYBOOL (__WINAPI set_mat_func)(lprec *lp, int row, int column, REAL value);
alias ubyte function(lprec *lp, int row, int column, double value)set_mat_func;
//C     typedef void (__WINAPI set_maxim_func)(lprec *lp);
alias void function(lprec *lp)set_maxim_func;
//C     typedef void (__WINAPI set_maxpivot_func)(lprec *lp, int max_num_inv);
alias void function(lprec *lp, int max_num_inv)set_maxpivot_func;
//C     typedef void (__WINAPI set_minim_func)(lprec *lp);
alias void function(lprec *lp)set_minim_func;
//C     typedef void (__WINAPI set_mip_gap_func)(lprec *lp, MYBOOL absolute, REAL mip_gap);
alias void function(lprec *lp, ubyte absolute, double mip_gap)set_mip_gap_func;
//C     typedef MYBOOL (__WINAPI set_multiprice_func)(lprec *lp, int multiblockdiv);
alias ubyte function(lprec *lp, int multiblockdiv)set_multiprice_func;
//C     typedef void (__WINAPI set_negrange_func)(lprec *lp, REAL negrange);
alias void function(lprec *lp, double negrange)set_negrange_func;
//C     typedef MYBOOL (__WINAPI set_obj_func)(lprec *lp, int colnr, REAL value);
alias ubyte function(lprec *lp, int colnr, double value)set_obj_func;
//C     typedef void (__WINAPI set_obj_bound_func)(lprec *lp, REAL obj_bound);
alias void function(lprec *lp, double obj_bound)set_obj_bound_func;
//C     typedef MYBOOL (__WINAPI set_obj_fn_func)(lprec *lp, REAL *row);
alias ubyte function(lprec *lp, double *row)set_obj_fn_func;
//C     typedef MYBOOL (__WINAPI set_obj_fnex_func)(lprec *lp, int count, REAL *row, int *colno);
alias ubyte function(lprec *lp, int count, double *row, int *colno)set_obj_fnex_func;
//C     typedef void (__WINAPI set_obj_in_basis_func)(lprec *lp, MYBOOL obj_in_basis);
alias void function(lprec *lp, ubyte obj_in_basis)set_obj_in_basis_func;
//C     typedef MYBOOL (__WINAPI set_outputfile_func)(lprec *lp, char *filename);
alias ubyte function(lprec *lp, char *filename)set_outputfile_func;
//C     typedef void (__WINAPI set_outputstream_func)(lprec *lp, FILE *stream);
alias void function(lprec *lp, FILE *stream)set_outputstream_func;
//C     typedef MYBOOL (__WINAPI set_partialprice_func)(lprec *lp, int blockcount, int *blockstart, MYBOOL isrow);
alias ubyte function(lprec *lp, int blockcount, int *blockstart, ubyte isrow)set_partialprice_func;
//C     typedef void (__WINAPI set_pivoting_func)(lprec *lp, int piv_rule);
alias void function(lprec *lp, int piv_rule)set_pivoting_func;
//C     typedef void (__WINAPI set_preferdual_func)(lprec *lp, MYBOOL dodual);
alias void function(lprec *lp, ubyte dodual)set_preferdual_func;
//C     typedef void (__WINAPI set_presolve_func)(lprec *lp, int presolvemode, int maxloops);
alias void function(lprec *lp, int presolvemode, int maxloops)set_presolve_func;
//C     typedef void (__WINAPI set_print_sol_func)(lprec *lp, int print_sol);
alias void function(lprec *lp, int print_sol)set_print_sol_func;
//C     typedef MYBOOL (__WINAPI set_pseudocosts_func)(lprec *lp, REAL *clower, REAL *cupper, int *updatelimit);
alias ubyte function(lprec *lp, double *clower, double *cupper, int *updatelimit)set_pseudocosts_func;
//C     typedef MYBOOL (__WINAPI set_rh_func)(lprec *lp, int rownr, REAL value);
alias ubyte function(lprec *lp, int rownr, double value)set_rh_func;
//C     typedef MYBOOL (__WINAPI set_rh_range_func)(lprec *lp, int rownr, REAL deltavalue);
alias ubyte function(lprec *lp, int rownr, double deltavalue)set_rh_range_func;
//C     typedef void (__WINAPI set_rh_vec_func)(lprec *lp, REAL *rh);
alias void function(lprec *lp, double *rh)set_rh_vec_func;
//C     typedef MYBOOL (__WINAPI set_row_func)(lprec *lp, int rownr, REAL *row);
alias ubyte function(lprec *lp, int rownr, double *row)set_row_func;
//C     typedef MYBOOL (__WINAPI set_rowex_func)(lprec *lp, int rownr, int count, REAL *row, int *colno);
alias ubyte function(lprec *lp, int rownr, int count, double *row, int *colno)set_rowex_func;
//C     typedef MYBOOL (__WINAPI set_row_name_func)(lprec *lp, int rownr, char *new_name);
alias ubyte function(lprec *lp, int rownr, char *new_name)set_row_name_func;
//C     typedef void (__WINAPI set_scalelimit_func)(lprec *lp, REAL scalelimit);
alias void function(lprec *lp, double scalelimit)set_scalelimit_func;
//C     typedef void (__WINAPI set_scaling_func)(lprec *lp, int scalemode);
alias void function(lprec *lp, int scalemode)set_scaling_func;
//C     typedef MYBOOL (__WINAPI set_semicont_func)(lprec *lp, int colnr, MYBOOL must_be_sc);
alias ubyte function(lprec *lp, int colnr, ubyte must_be_sc)set_semicont_func;
//C     typedef void (__WINAPI set_sense_func)(lprec *lp, MYBOOL maximize);
alias void function(lprec *lp, ubyte maximize)set_sense_func;
//C     typedef void (__WINAPI set_simplextype_func)(lprec *lp, int simplextype);
alias void function(lprec *lp, int simplextype)set_simplextype_func;
//C     typedef void (__WINAPI set_solutionlimit_func)(lprec *lp, int limit);
alias void function(lprec *lp, int limit)set_solutionlimit_func;
//C     typedef void (__WINAPI set_timeout_func)(lprec *lp, long sectimeout);
alias void function(lprec *lp, int sectimeout)set_timeout_func;
//C     typedef void (__WINAPI set_trace_func)(lprec *lp, MYBOOL trace);
alias void function(lprec *lp, ubyte trace)set_trace_func;
//C     typedef MYBOOL (__WINAPI set_upbo_func)(lprec *lp, int colnr, REAL value);
alias ubyte function(lprec *lp, int colnr, double value)set_upbo_func;
//C     typedef MYBOOL (__WINAPI set_var_branch_func)(lprec *lp, int colnr, int branch_mode);
alias ubyte function(lprec *lp, int colnr, int branch_mode)set_var_branch_func;
//C     typedef MYBOOL (__WINAPI set_var_weights_func)(lprec *lp, REAL *weights);
alias ubyte function(lprec *lp, double *weights)set_var_weights_func;
//C     typedef void (__WINAPI set_verbose_func)(lprec *lp, int verbose);
alias void function(lprec *lp, int verbose)set_verbose_func;
//C     typedef MYBOOL (__WINAPI set_XLI_func)(lprec *lp, char *filename);
alias ubyte function(lprec *lp, char *filename)set_XLI_func;
//C     typedef int (__WINAPI solve_func)(lprec *lp);
alias int function(lprec *lp)solve_func;
//C     typedef MYBOOL (__WINAPI str_add_column_func)(lprec *lp, char *col_string);
alias ubyte function(lprec *lp, char *col_string)str_add_column_func;
//C     typedef MYBOOL (__WINAPI str_add_constraint_func)(lprec *lp, char *row_string ,int constr_type, REAL rh);
alias ubyte function(lprec *lp, char *row_string, int constr_type, double rh)str_add_constraint_func;
//C     typedef MYBOOL (__WINAPI str_add_lag_con_func)(lprec *lp, char *row_string, int con_type, REAL rhs);
alias ubyte function(lprec *lp, char *row_string, int con_type, double rhs)str_add_lag_con_func;
//C     typedef MYBOOL (__WINAPI str_set_obj_fn_func)(lprec *lp, char *row_string);
alias ubyte function(lprec *lp, char *row_string)str_set_obj_fn_func;
//C     typedef MYBOOL (__WINAPI str_set_rh_vec_func)(lprec *lp, char *rh_string);
alias ubyte function(lprec *lp, char *rh_string)str_set_rh_vec_func;
//C     typedef REAL (__WINAPI time_elapsed_func)(lprec *lp);
alias double function(lprec *lp)time_elapsed_func;
//C     typedef void (__WINAPI unscale_func)(lprec *lp);
alias void function(lprec *lp)unscale_func;
//C     typedef MYBOOL (__WINAPI write_lp_func)(lprec *lp, char *filename);
alias ubyte function(lprec *lp, char *filename)write_lp_func;
//C     typedef MYBOOL (__WINAPI write_LP_func)(lprec *lp, FILE *output);
alias ubyte function(lprec *lp, FILE *output)write_LP_func;
//C     typedef MYBOOL (__WINAPI write_mps_func)(lprec *lp, char *filename);
alias ubyte function(lprec *lp, char *filename)write_mps_func;
//C     typedef MYBOOL (__WINAPI write_MPS_func)(lprec *lp, FILE *output);
alias ubyte function(lprec *lp, FILE *output)write_MPS_func;
//C     typedef MYBOOL (__WINAPI write_freemps_func)(lprec *lp, char *filename);
alias ubyte function(lprec *lp, char *filename)write_freemps_func;
//C     typedef MYBOOL (__WINAPI write_freeMPS_func)(lprec *lp, FILE *output);
alias ubyte function(lprec *lp, FILE *output)write_freeMPS_func;
//C     typedef MYBOOL (__WINAPI write_XLI_func)(lprec *lp, char *filename, char *options, MYBOOL results);
alias ubyte function(lprec *lp, char *filename, char *options, ubyte results)write_XLI_func;
//C     typedef MYBOOL (__WINAPI write_basis_func)(lprec *lp, char *filename);
alias ubyte function(lprec *lp, char *filename)write_basis_func;
//C     typedef MYBOOL (__WINAPI write_params_func)(lprec *lp, char *filename, char *options);
alias ubyte function(lprec *lp, char *filename, char *options)write_params_func;


/* Prototypes for callbacks from basis inverse/factorization libraries       */
/* ------------------------------------------------------------------------- */
//C     typedef MYBOOL (__WINAPI userabortfunc)(lprec *lp, int level);
alias ubyte function(lprec *lp, int level)userabortfunc;
//C     typedef void   (__VACALL reportfunc)(lprec *lp, int level, char *format, ...);
alias void function(lprec *lp, int level, char *format,...)reportfunc;
//C     typedef char * (__VACALL explainfunc)(lprec *lp, char *format, ...);
alias char *function(lprec *lp, char *format,...)explainfunc;
//C     typedef int    (__WINAPI getvectorfunc)(lprec *lp, int varin, REAL *pcol, int *nzlist, int *maxabs);
alias int function(lprec *lp, int varin, double *pcol, int *nzlist, int *maxabs)getvectorfunc;
//C     typedef int    (__WINAPI getpackedfunc)(lprec *lp, int j, int rn[], double bj[]);
alias int function(lprec *lp, int j, int *rn, double *bj)getpackedfunc;
//C     typedef REAL    (__WINAPI get_OF_activefunc)(lprec *lp, int varnr, REAL mult);
alias double function(lprec *lp, int varnr, double mult)get_OF_activefunc;
//C     typedef int    (__WINAPI getMDOfunc)(lprec *lp, MYBOOL *usedpos, int *colorder, int *size, MYBOOL symmetric);
alias int function(lprec *lp, ubyte *usedpos, int *colorder, int *size, ubyte symmetric)getMDOfunc;
//C     typedef MYBOOL (__WINAPI invertfunc)(lprec *lp, MYBOOL shiftbounds, MYBOOL final);
alias ubyte function(lprec *lp, ubyte shiftbounds, ubyte final_)invertfunc;
//C     typedef void   (__WINAPI set_actionfunc)(int *actionvar, int actionmask);
alias void function(int *actionvar, int actionmask)set_actionfunc;
//C     typedef MYBOOL (__WINAPI is_actionfunc)(int actionvar, int testmask);
alias ubyte function(int actionvar, int testmask)is_actionfunc;
//C     typedef void   (__WINAPI clear_actionfunc)(int *actionvar, int actionmask);
alias void function(int *actionvar, int actionmask)clear_actionfunc;


/* Prototypes for basis inverse/factorization libraries                      */
/* ------------------------------------------------------------------------- */
//C     typedef char   *(BFP_CALLMODEL BFPchar)(void);
alias char *function()BFPchar;
//C     typedef void   (BFP_CALLMODEL BFP_lp)(lprec *lp);
alias void function(lprec *lp)BFP_lp;
//C     typedef void   (BFP_CALLMODEL BFP_lpint)(lprec *lp, int newsize);
alias void function(lprec *lp, int newsize)BFP_lpint;
//C     typedef int    (BFP_CALLMODEL BFPint_lp)(lprec *lp);
alias int function(lprec *lp)BFPint_lp;
//C     typedef int    (BFP_CALLMODEL BFPint_lpint)(lprec *lp, int kind);
alias int function(lprec *lp, int kind)BFPint_lpint;
//C     typedef REAL   (BFP_CALLMODEL BFPreal_lp)(lprec *lp);
alias double function(lprec *lp)BFPreal_lp;
//C     typedef REAL   *(BFP_CALLMODEL BFPrealp_lp)(lprec *lp);
alias double *function(lprec *lp)BFPrealp_lp;
//C     typedef void   (BFP_CALLMODEL BFP_lpbool)(lprec *lp, MYBOOL maximum);
alias void function(lprec *lp, ubyte maximum)BFP_lpbool;
//C     typedef int    (BFP_CALLMODEL BFPint_lpbool)(lprec *lp, MYBOOL maximum);
alias int function(lprec *lp, ubyte maximum)BFPint_lpbool;
//C     typedef int    (BFP_CALLMODEL BFPint_lpintintboolbool)(lprec *lp, int uservars, int Bsize, MYBOOL *usedpos, MYBOOL final);
alias int function(lprec *lp, int uservars, int Bsize, ubyte *usedpos, ubyte final_)BFPint_lpintintboolbool;
//C     typedef void   (BFP_CALLMODEL BFP_lprealint)(lprec *lp, REAL *pcol, int *nzidx);
alias void function(lprec *lp, double *pcol, int *nzidx)BFP_lprealint;
//C     typedef void   (BFP_CALLMODEL BFP_lprealintrealint)(lprec *lp, REAL *prow, int *pnzidx, REAL *drow, int *dnzidx);
alias void function(lprec *lp, double *prow, int *pnzidx, double *drow, int *dnzidx)BFP_lprealintrealint;
//C     typedef MYBOOL (BFP_CALLMODEL BFPbool_lp)(lprec *lp);
alias ubyte function(lprec *lp)BFPbool_lp;
//C     typedef MYBOOL (BFP_CALLMODEL BFPbool_lpbool)(lprec *lp, MYBOOL changesign);
alias ubyte function(lprec *lp, ubyte changesign)BFPbool_lpbool;
//C     typedef MYBOOL (BFP_CALLMODEL BFPbool_lpint)(lprec *lp, int size);
alias ubyte function(lprec *lp, int size)BFPbool_lpint;
//C     typedef MYBOOL (BFP_CALLMODEL BFPbool_lpintintchar)(lprec *lp, int size, int deltasize, char *options);
alias ubyte function(lprec *lp, int size, int deltasize, char *options)BFPbool_lpintintchar;
//C     typedef MYBOOL (BFP_CALLMODEL BFPbool_lpintintint)(lprec *lp, int size, int deltasize, int sizeofvar);
alias ubyte function(lprec *lp, int size, int deltasize, int sizeofvar)BFPbool_lpintintint;
//C     typedef LREAL  (BFP_CALLMODEL BFPlreal_lpintintreal)(lprec *lp, int row_nr, int col_nr, REAL *pcol);
alias double function(lprec *lp, int row_nr, int col_nr, double *pcol)BFPlreal_lpintintreal;
//C     typedef REAL   (BFP_CALLMODEL BFPreal_lplrealreal)(lprec *lp, LREAL theta, REAL *pcol);
alias double function(lprec *lp, double theta, double *pcol)BFPreal_lplrealreal;

//C     typedef int    (BFP_CALLMODEL getcolumnex_func)(lprec *lp, int colnr, REAL *nzvalues, int *nzrows, int *mapin);
alias int function(lprec *lp, int colnr, double *nzvalues, int *nzrows, int *mapin)getcolumnex_func;
//C     typedef int    (BFP_CALLMODEL BFPint_lpintrealcbintint)(lprec *lp, int items, getcolumnex_func cb, int *maprow, int*mapcol);
alias int function(lprec *lp, int items, int  function(lprec *lp, int colnr, double *nzvalues, int *nzrows, int *mapin)cb, int *maprow, int *mapcol)BFPint_lpintrealcbintint;

/* Prototypes for external language libraries                                */
/* ------------------------------------------------------------------------- */
//C     typedef char   *(XLI_CALLMODEL XLIchar)(void);
alias char *function()XLIchar;
//C     typedef MYBOOL (XLI_CALLMODEL XLIbool_lpintintint)(lprec* lp, int size, int deltasize, int sizevar);
alias ubyte function(lprec *lp, int size, int deltasize, int sizevar)XLIbool_lpintintint;
//C     typedef MYBOOL (XLI_CALLMODEL XLIbool_lpcharcharcharint)(lprec *lp, char *modelname, char *dataname, char *options, int verbose);
alias ubyte function(lprec *lp, char *modelname, char *dataname, char *options, int verbose)XLIbool_lpcharcharcharint;
//C     typedef MYBOOL (XLI_CALLMODEL XLIbool_lpcharcharbool)(lprec *lp, char *filename, char *options, MYBOOL results);
alias ubyte function(lprec *lp, char *filename, char *options, ubyte results)XLIbool_lpcharcharbool;


/* Main lp_solve prototypes and function definitions                         */
/* ------------------------------------------------------------------------- */
//C     struct _lprec
//C     {
  /* Full list of exported functions made available in a quasi object-oriented fashion */
//C       add_column_func               *add_column;
//C       add_columnex_func             *add_columnex;
//C       add_constraint_func           *add_constraint;
//C       add_constraintex_func         *add_constraintex;
//C       add_lag_con_func              *add_lag_con;
//C       add_SOS_func                  *add_SOS;
//C       column_in_lp_func             *column_in_lp;
//C       copy_lp_func                  *copy_lp;
//C       default_basis_func            *default_basis;
//C       del_column_func               *del_column;
//C       del_constraint_func           *del_constraint;
//C       delete_lp_func                *delete_lp;
//C       dualize_lp_func               *dualize_lp;
//C       free_lp_func                  *free_lp;
//C       get_anti_degen_func           *get_anti_degen;
//C       get_basis_func                *get_basis;
//C       get_basiscrash_func           *get_basiscrash;
//C       get_bb_depthlimit_func        *get_bb_depthlimit;
//C       get_bb_floorfirst_func        *get_bb_floorfirst;
//C       get_bb_rule_func              *get_bb_rule;
//C       get_bounds_tighter_func       *get_bounds_tighter;
//C       get_break_at_value_func       *get_break_at_value;
//C       get_col_name_func             *get_col_name;
//C       get_columnex_func             *get_columnex;
//C       get_constr_type_func          *get_constr_type;
//C       get_constr_value_func         *get_constr_value;
//C       get_constraints_func          *get_constraints;
//C       get_dual_solution_func        *get_dual_solution;
//C       get_epsb_func                 *get_epsb;
//C       get_epsd_func                 *get_epsd;
//C       get_epsel_func                *get_epsel;
//C       get_epsint_func               *get_epsint;
//C       get_epsperturb_func           *get_epsperturb;
//C       get_epspivot_func             *get_epspivot;
//C       get_improve_func              *get_improve;
//C       get_infinite_func             *get_infinite;
//C       get_lambda_func               *get_lambda;
//C       get_lowbo_func                *get_lowbo;
//C       get_lp_index_func             *get_lp_index;
//C       get_lp_name_func              *get_lp_name;
//C       get_Lrows_func                *get_Lrows;
//C       get_mat_func                  *get_mat;
//C       get_mat_byindex_func          *get_mat_byindex;
//C       get_max_level_func            *get_max_level;
//C       get_maxpivot_func             *get_maxpivot;
//C       get_mip_gap_func              *get_mip_gap;
//C       get_multiprice_func           *get_multiprice;
//C       get_nameindex_func            *get_nameindex;
//C       get_Ncolumns_func             *get_Ncolumns;
//C       get_negrange_func             *get_negrange;
//C       get_nz_func                   *get_nonzeros;
//C       get_Norig_columns_func        *get_Norig_columns;
//C       get_Norig_rows_func           *get_Norig_rows;
//C       get_Nrows_func                *get_Nrows;
//C       get_obj_bound_func            *get_obj_bound;
//C       get_objective_func            *get_objective;
//C       get_orig_index_func           *get_orig_index;
//C       get_origcol_name_func         *get_origcol_name;
//C       get_origrow_name_func         *get_origrow_name;
//C       get_partialprice_func         *get_partialprice;
//C       get_pivoting_func             *get_pivoting;
//C       get_presolve_func             *get_presolve;
//C       get_presolveloops_func        *get_presolveloops;
//C       get_primal_solution_func      *get_primal_solution;
//C       get_print_sol_func            *get_print_sol;
//C       get_pseudocosts_func          *get_pseudocosts;
//C       get_ptr_constraints_func      *get_ptr_constraints;
//C       get_ptr_dual_solution_func    *get_ptr_dual_solution;
//C       get_ptr_lambda_func           *get_ptr_lambda;
//C       get_ptr_primal_solution_func  *get_ptr_primal_solution;
//C       get_ptr_sensitivity_obj_func  *get_ptr_sensitivity_obj;
//C       get_ptr_sensitivity_objex_func *get_ptr_sensitivity_objex;
//C       get_ptr_sensitivity_rhs_func  *get_ptr_sensitivity_rhs;
//C       get_ptr_variables_func        *get_ptr_variables;
//C       get_rh_func                   *get_rh;
//C       get_rh_range_func             *get_rh_range;
//C       get_row_func                  *get_row;
//C       get_rowex_func                *get_rowex;
//C       get_row_name_func             *get_row_name;
//C       get_scalelimit_func           *get_scalelimit;
//C       get_scaling_func              *get_scaling;
//C       get_sensitivity_obj_func      *get_sensitivity_obj;
//C       get_sensitivity_objex_func    *get_sensitivity_objex;
//C       get_sensitivity_rhs_func      *get_sensitivity_rhs;
//C       get_simplextype_func          *get_simplextype;
//C       get_solutioncount_func        *get_solutioncount;
//C       get_solutionlimit_func        *get_solutionlimit;
//C       get_status_func               *get_status;
//C       get_statustext_func           *get_statustext;
//C       get_timeout_func              *get_timeout;
//C       get_total_iter_func           *get_total_iter;
//C       get_total_nodes_func          *get_total_nodes;
//C       get_upbo_func                 *get_upbo;
//C       get_var_branch_func           *get_var_branch;
//C       get_var_dualresult_func       *get_var_dualresult;
//C       get_var_primalresult_func     *get_var_primalresult;
//C       get_var_priority_func         *get_var_priority;
//C       get_variables_func            *get_variables;
//C       get_verbose_func              *get_verbose;
//C       get_working_objective_func    *get_working_objective;
//C       has_BFP_func                  *has_BFP;
//C       has_XLI_func                  *has_XLI;
//C       is_add_rowmode_func           *is_add_rowmode;
//C       is_anti_degen_func            *is_anti_degen;
//C       is_binary_func                *is_binary;
//C       is_break_at_first_func        *is_break_at_first;
//C       is_constr_type_func           *is_constr_type;
//C       is_debug_func                 *is_debug;
//C       is_feasible_func              *is_feasible;
//C       is_infinite_func              *is_infinite;
//C       is_int_func                   *is_int;
//C       is_integerscaling_func        *is_integerscaling;
//C       is_lag_trace_func             *is_lag_trace;
//C       is_maxim_func                 *is_maxim;
//C       is_nativeBFP_func             *is_nativeBFP;
//C       is_nativeXLI_func             *is_nativeXLI;
//C       is_negative_func              *is_negative;
//C       is_obj_in_basis_func          *is_obj_in_basis;
//C       is_piv_mode_func              *is_piv_mode;
//C       is_piv_rule_func              *is_piv_rule;
//C       is_presolve_func              *is_presolve;
//C       is_scalemode_func             *is_scalemode;
//C       is_scaletype_func             *is_scaletype;
//C       is_semicont_func              *is_semicont;
//C       is_SOS_var_func               *is_SOS_var;
//C       is_trace_func                 *is_trace;
//C       is_unbounded_func             *is_unbounded;
//C       is_use_names_func             *is_use_names;
//C       lp_solve_version_func         *lp_solve_version;
//C       make_lp_func                  *make_lp;
//C       print_constraints_func        *print_constraints;
//C       print_debugdump_func          *print_debugdump;
//C       print_duals_func              *print_duals;
//C       print_lp_func                 *print_lp;
//C       print_objective_func          *print_objective;
//C       print_scales_func             *print_scales;
//C       print_solution_func           *print_solution;
//C       print_str_func                *print_str;
//C       print_tableau_func            *print_tableau;
//C       put_abortfunc_func            *put_abortfunc;
//C       put_bb_nodefunc_func          *put_bb_nodefunc;
//C       put_bb_branchfunc_func        *put_bb_branchfunc;
//C       put_logfunc_func              *put_logfunc;
//C       put_msgfunc_func              *put_msgfunc;
//C       read_LP_func                  *read_LP;
//C       read_MPS_func                 *read_MPS;
//C       read_XLI_func                 *read_XLI;
//C       read_params_func              *read_params;
//C       read_basis_func               *read_basis;
//C       reset_basis_func              *reset_basis;
//C       reset_params_func             *reset_params;
//C       resize_lp_func                *resize_lp;
//C       set_add_rowmode_func          *set_add_rowmode;
//C       set_anti_degen_func           *set_anti_degen;
//C       set_basisvar_func             *set_basisvar;
//C       set_basis_func                *set_basis;
//C       set_basiscrash_func           *set_basiscrash;
//C       set_bb_depthlimit_func        *set_bb_depthlimit;
//C       set_bb_floorfirst_func        *set_bb_floorfirst;
//C       set_bb_rule_func              *set_bb_rule;
//C       set_BFP_func                  *set_BFP;
//C       set_binary_func               *set_binary;
//C       set_bounds_func               *set_bounds;
//C       set_bounds_tighter_func       *set_bounds_tighter;
//C       set_break_at_first_func       *set_break_at_first;
//C       set_break_at_value_func       *set_break_at_value;
//C       set_column_func               *set_column;
//C       set_columnex_func             *set_columnex;
//C       set_col_name_func             *set_col_name;
//C       set_constr_type_func          *set_constr_type;
//C       set_debug_func                *set_debug;
//C       set_epsb_func                 *set_epsb;
//C       set_epsd_func                 *set_epsd;
//C       set_epsel_func                *set_epsel;
//C       set_epsint_func               *set_epsint;
//C       set_epslevel_func             *set_epslevel;
//C       set_epsperturb_func           *set_epsperturb;
//C       set_epspivot_func             *set_epspivot;
//C       set_unbounded_func            *set_unbounded;
//C       set_improve_func              *set_improve;
//C       set_infinite_func             *set_infinite;
//C       set_int_func                  *set_int;
//C       set_lag_trace_func            *set_lag_trace;
//C       set_lowbo_func                *set_lowbo;
//C       set_lp_name_func              *set_lp_name;
//C       set_mat_func                  *set_mat;
//C       set_maxim_func                *set_maxim;
//C       set_maxpivot_func             *set_maxpivot;
//C       set_minim_func                *set_minim;
//C       set_mip_gap_func              *set_mip_gap;
//C       set_multiprice_func           *set_multiprice;
//C       set_negrange_func             *set_negrange;
//C       set_obj_bound_func            *set_obj_bound;
//C       set_obj_fn_func               *set_obj_fn;
//C       set_obj_fnex_func             *set_obj_fnex;
//C       set_obj_func                  *set_obj;
//C       set_obj_in_basis_func         *set_obj_in_basis;
//C       set_outputfile_func           *set_outputfile;
//C       set_outputstream_func         *set_outputstream;
//C       set_partialprice_func         *set_partialprice;
//C       set_pivoting_func             *set_pivoting;
//C       set_preferdual_func           *set_preferdual;
//C       set_presolve_func             *set_presolve;
//C       set_print_sol_func            *set_print_sol;
//C       set_pseudocosts_func          *set_pseudocosts;
//C       set_rh_func                   *set_rh;
//C       set_rh_range_func             *set_rh_range;
//C       set_rh_vec_func               *set_rh_vec;
//C       set_row_func                  *set_row;
//C       set_rowex_func                *set_rowex;
//C       set_row_name_func             *set_row_name;
//C       set_scalelimit_func           *set_scalelimit;
//C       set_scaling_func              *set_scaling;
//C       set_semicont_func             *set_semicont;
//C       set_sense_func                *set_sense;
//C       set_simplextype_func          *set_simplextype;
//C       set_solutionlimit_func        *set_solutionlimit;
//C       set_timeout_func              *set_timeout;
//C       set_trace_func                *set_trace;
//C       set_upbo_func                 *set_upbo;
//C       set_use_names_func            *set_use_names;
//C       set_var_branch_func           *set_var_branch;
//C       set_var_weights_func          *set_var_weights;
//C       set_verbose_func              *set_verbose;
//C       set_XLI_func                  *set_XLI;
//C       solve_func                    *solve;
//C       str_add_column_func           *str_add_column;
//C       str_add_constraint_func       *str_add_constraint;
//C       str_add_lag_con_func          *str_add_lag_con;
//C       str_set_obj_fn_func           *str_set_obj_fn;
//C       str_set_rh_vec_func           *str_set_rh_vec;
//C       time_elapsed_func             *time_elapsed;
//C       unscale_func                  *unscale;
//C       write_lp_func                 *write_lp;
//C       write_LP_func                 *write_LP;
//C       write_mps_func                *write_mps;
//C       write_MPS_func                *write_MPS;
//C       write_freemps_func            *write_freemps;
//C       write_freeMPS_func            *write_freeMPS;
//C       write_XLI_func                *write_XLI;
//C       write_basis_func              *write_basis;
//C       write_params_func             *write_params;

  /* Spacer */
//C       int       *alignmentspacer;

  /* Problem description */
//C       char      *lp_name;           /* The name of the model */

  /* Problem sizes */
//C       int       sum;                /* The total number of variables, including slacks */
//C       int       rows;
//C       int       columns;
//C       int       equalities;         /* No of non-Lagrangean equality constraints in the problem */
//C       int       boundedvars;        /* Count of bounded variables */
//C       int       INTfuture1;

  /* Memory allocation sizes */
//C       int       sum_alloc;          /* The allocated memory for row+column-sized data */
//C       int       rows_alloc;         /* The allocated memory for row-sized data */
//C       int       columns_alloc;      /* The allocated memory for column-sized data */

  /* Model status and solver result variables */
//C       MYBOOL    source_is_file;     /* The base model was read from a file */
//C       MYBOOL    model_is_pure;      /* The model has been built entirely from row and column additions */
//C       MYBOOL    model_is_valid;     /* Has this lp pased the 'test' */
//C       MYBOOL    tighten_on_set;     /* Specify if bounds will be tightened or overriden at bound setting */
//C       MYBOOL    names_used;         /* Flag to indicate if names for rows and columns are used */
//C       MYBOOL    use_row_names;      /* Flag to indicate if names for rows are used */
//C       MYBOOL    use_col_names;      /* Flag to indicate if names for columns are used */

//C       MYBOOL    lag_trace;          /* Print information on Lagrange progression */
//C       MYBOOL    spx_trace;          /* Print information on simplex progression */
//C       MYBOOL    bb_trace;           /* TRUE to print extra debug information */
//C       MYBOOL    streamowned;        /* TRUE if the handle should be closed at delete_lp() */
//C       MYBOOL    obj_in_basis;       /* TRUE if the objective function is in the basis matrix */

//C       int       spx_status;         /* Simplex solver feasibility/mode code */
//C       int       lag_status;         /* Extra status variable for lag_solve */
//C       int       solutioncount;      /* number of equal-valued solutions found (up to solutionlimit) */
//C       int       solutionlimit;      /* upper number of equal-valued solutions kept track of */

//C       REAL      real_solution;      /* Optimal non-MIP solution base */
//C       REAL      *solution;          
/* sum_alloc+1 : Solution array of the next to optimal LP,
                                   Index   0           : Objective function value,
                                   Indeces 1..rows     : Slack variable values,
                                   Indeced rows+1..sum : Variable values */
//C       REAL      *best_solution;     
/* sum_alloc+1 : Solution array of optimal 'Integer' LP,
                                   structured as the solution array above */
//C       REAL      *full_solution;     /* sum_alloc+1 : Final solution array expanded for deleted variables */
//C       REAL      *edgeVector;        /* Array of reduced cost scaling norms (DEVEX and Steepest Edge) */

//C       REAL      *drow;              /* sum+1: Reduced costs of the last simplex */
//C       int       *nzdrow;            /* sum+1: Indeces of non-zero reduced costs of the last simplex */
//C       REAL      *duals;             /* rows_alloc+1 : The dual variables of the last LP */
//C       REAL      *full_duals;        /* sum_alloc+1: Final duals array expanded for deleted variables */
//C       REAL      *dualsfrom;         
/* sum_alloc+1 :The sensitivity on dual variables/reduced costs
                                   of the last LP */
//C       REAL      *dualstill;         
/* sum_alloc+1 :The sensitivity on dual variables/reduced costs
                                   of the last LP */
//C       REAL      *objfrom;           
/* columns_alloc+1 :The sensitivity on objective function
                                   of the last LP */
//C       REAL      *objtill;           
/* columns_alloc+1 :The sensitivity on objective function
                                   of the last LP */
//C       REAL      *objfromvalue;      
/* columns_alloc+1 :The value of the variables when objective value
                                   is at its from value of the last LP */
//C       REAL      *orig_obj;          /* Unused pointer - Placeholder for OF not part of B */
//C       REAL      *obj;               /* Special vector used to temporarily change the OF vector */

//C       COUNTER   current_iter;       /* Number of iterations in the current/last simplex */
//C       COUNTER   total_iter;         /* Number of iterations over all B&B steps */
//C       COUNTER   current_bswap;      /* Number of bound swaps in the current/last simplex */
//C       COUNTER   total_bswap;        /* Number of bount swaps over all B&B steps */
//C       int       solvecount;         /* The number of solve() performed in this model */
//C       int       max_pivots;         /* Number of pivots between refactorizations of the basis */

  /* Various execution parameters */
//C       int       simplex_strategy;   /* Set desired combination of primal and dual simplex algorithms */
//C       int       simplex_mode;       /* Specifies the current simplex mode during solve; see simplex_strategy */
//C       int       verbose;            /* Set amount of run-time messages and results */
//C       int       print_sol;          /* TRUE to print optimal solution; AUTOMATIC skips zeros */
//C       FILE      *outstream;         /* Output stream, initialized to STDOUT */

  /* Main Branch and Bound settings */
//C       MYBOOL    *bb_varbranch;      
/* Determines branching strategy at the individual variable level;
                                   the setting here overrides the bb_floorfirst setting */
//C       int       piv_strategy;       /* Strategy for selecting row and column entering/leaving */
//C       int       _piv_rule_;         /* Internal working rule-part of piv_strategy above */
//C       int       bb_rule;            /* Rule for selecting B&B variables */
//C       MYBOOL    bb_floorfirst;      
/* Set BRANCH_FLOOR for B&B to set variables to floor bound first;
                                   conversely with BRANCH_CEILING, the ceiling value is set first */
//C       MYBOOL    bb_breakfirst;      /* TRUE to stop at first feasible solution */
//C       MYBOOL    _piv_left_;         /* Internal variable indicating active pricing loop order */
//C       MYBOOL    BOOLfuture1;

//C       REAL      scalelimit;         /* Relative convergence criterion for iterated scaling */
//C       int       scalemode;          /* OR-ed codes for data scaling */
//C       int       improve;            /* Set to non-zero for iterative improvement */
//C       int       anti_degen;         /* Anti-degen strategy (or none) TRUE to avoid cycling */
//C       int       do_presolve;        /* PRESOLVE_ parameters for LP presolving */
//C       int       presolveloops;      /* Maximum number of presolve loops */

//C       int       perturb_count;      /* The number of bound relaxation retries performed */

  /* Row and column names storage variables */
//C       hashelem  **row_name;         /* rows_alloc+1 */
//C       hashelem  **col_name;         /* columns_alloc+1 */
//C       hashtable *rowname_hashtab;   /* hash table to store row names */
//C       hashtable *colname_hashtab;   /* hash table to store column names */

  /* Optionally specify continuous rows/column blocks for partial pricing */
//C       partialrec *rowblocks;
//C       partialrec *colblocks;

  /* Row and column type codes */
//C       MYBOOL    *var_type;          /* sum_alloc+1 : TRUE if variable must be integer */

  /* Data for multiple pricing */
//C       multirec  *multivars;
//C       int       multiblockdiv;      /* The divisor used to set or augment pricing block */

  /* Variable (column) parameters */
//C       int       fixedvars;          /* The current number of basic fixed variables in the model */
//C       int       int_vars;           /* Number of variables required to be integer */

//C       int       sc_vars;            /* Number of semi-continuous variables */
//C       REAL      *sc_lobound;        
/* sum_columns+1 : TRUE if variable is semi-continuous;
                                   value replaced by conventional lower bound during solve */
//C       int       *var_is_free;       /* columns+1: Index of twin variable if variable is free */
//C       int       *var_priority;      /* columns: Priority-mapping of variables */

//C       SOSgroup  *GUB;               /* Pointer to record containing GUBs */

//C       int       sos_vars;           /* Number of variables in the sos_priority list */
//C       int       sos_ints;           /* Number of integers in SOS'es above */
//C       SOSgroup  *SOS;               /* Pointer to record containing all SOS'es */
//C       int       *sos_priority;      /* Priority-sorted list of variables (no duplicates) */

  /* Optionally specify list of active rows/columns used in multiple pricing */
//C       REAL      *bsolveVal;         /* rows+1: bsolved solution vector for reduced costs */
//C       int       *bsolveIdx;         /* rows+1: Non-zero indeces of bsolveVal */

  /* RHS storage */
//C       REAL      *orig_rhs;          
/* rows_alloc+1 : The RHS after scaling and sign
                                   changing, but before 'Bound transformation' */
//C       LREAL     *rhs;               /* rows_alloc+1 : The RHS of the current simplex tableau */

  /* Row (constraint) parameters */
//C       int       *row_type;          /* rows_alloc+1 : Row/constraint type coding */

  /* Optionally specify data for dual long-step */
//C       multirec  *longsteps;

  /* Original and working row and variable bounds */
//C       REAL      *orig_upbo;         /* sum_alloc+1 : Bound before transformations */
//C       REAL      *upbo;              /*  " " : Upper bound after transformation and B&B work */
//C       REAL      *orig_lowbo;        /*  "       "                                 */
//C       REAL      *lowbo;             /*  " " : Lower bound after transformation and B&B work */

  /* User data and basis factorization matrices (ETA or LU, product form) */
//C       MATrec    *matA;
//C       INVrec    *invB;

  /* Basis and bounds */
//C       BBrec     *bb_bounds;         /* The linked list of B&B bounds */
//C       BBrec     *rootbounds;        /* The bounds at the lowest B&B level */
//C       basisrec  *bb_basis;          /* The linked list of B&B bases */
//C       basisrec  *rootbasis;
//C       OBJmonrec *monitor;           /* Objective monitoring record for stalling/degeneracy handling */

  /* Scaling parameters */
//C       REAL      *scalars;           
/* sum_alloc+1:0..Rows the scaling of the rows,
                                   Rows+1..Sum the scaling of the columns */
//C       MYBOOL    scaling_used;       /* TRUE if scaling is used */
//C       MYBOOL    columns_scaled;     /* TRUE if the columns are scaled too */
//C       MYBOOL    varmap_locked;      /* Determines whether the var_to_orig and orig_to_var are fixed */

  /* Variable state information */
//C       MYBOOL    basis_valid;        /* TRUE is the basis is still valid */
//C       int       crashmode;          /* Basis crashing mode (or none) */
//C       int       *var_basic;         /* rows_alloc+1: The list of columns in the basis */
//C       REAL      *val_nonbasic;      /* Array to store current values of non-basic variables */
//C       MYBOOL    *is_basic;          /* sum_alloc+1: TRUE if the column is in the basis */
//C       MYBOOL    *is_lower;          
/*  "       " : TRUE if the variable is at its
                                   lower bound (or in the basis), FALSE otherwise */

  /* Simplex basis indicators */
//C       int       *rejectpivot;       /* List of unacceptable pivot choices due to division-by-zero */
//C       BBPSrec   *bb_PseudoCost;     /* Data structure for costing of node branchings */
//C       int       bb_PseudoUpdates;   /* Maximum number of updates for pseudo-costs */
//C       int       bb_strongbranches;  /* The number of strong B&B branches performed */
//C       int       is_strongbranch;    /* Are we currently in a strong branch mode? */
//C       int       bb_improvements;    /* The number of discrete B&B objective improvement steps */

  /* Solver working variables */
//C       REAL      rhsmax;             /* The maximum |value| of the rhs vector at any iteration */
//C       REAL      suminfeas;          /* The working sum of primal and dual infeasibilities */
//C       REAL      bigM;               /* Original objective weighting in primal phase 1 */
//C       REAL      P1extraVal;         /* Phase 1 OF/RHS offset for feasibility */
//C       int       P1extraDim;         /* Phase 1 additional columns/rows for feasibility */
//C       int       spx_action;         /* ACTION_ variables for the simplex routine */
//C       MYBOOL    spx_perturbed;      /* The variable bounds were relaxed/perturbed into this simplex */
//C       MYBOOL    bb_break;           /* Solver working variable; signals break of the B&B */
//C       MYBOOL    wasPreprocessed;    /* The solve preprocessing was performed */
//C       MYBOOL    wasPresolved;       /* The solve presolver was invoked */
//C       int      INTfuture2;

  /* Lagragean solver storage and parameters */
//C       MATrec    *matL;
//C       REAL      *lag_rhs;           /* Array of Lagrangean rhs vector */
//C       int       *lag_con_type;      /* Array of GT, LT or EQ */
//C       REAL      *lambda;            /* Lambda values (Lagrangean multipliers) */
//C       REAL      lag_bound;          /* The Lagrangian lower OF bound */
//C       REAL      lag_accept;         /* The Lagrangian convergence criterion */

  /* Solver thresholds */
//C       REAL      infinite;           /* Limit for dynamic range */
//C       REAL      negrange;           /* Limit for negative variable range */
//C       REAL      epsmachine;         /* Default machine accuracy */
//C       REAL      epsvalue;           /* Input data precision / rounding of data values to 0 */
//C       REAL      epsprimal;          /* For rounding RHS values to 0/infeasibility */
//C       REAL      epsdual;            /* For rounding reduced costs to zero */
//C       REAL      epspivot;           /* Pivot reject tolerance */
//C       REAL      epsperturb;         /* Perturbation scalar */
//C       REAL      epssolution;        /* The solution tolerance for final validation */

  /* Branch & Bound working parameters */
//C       int       bb_status;          /* Indicator that the last solvelp() gave an improved B&B solution */
//C       int       bb_level;           /* Solver B&B working variable (recursion depth) */
//C       int       bb_maxlevel;        /* The deepest B&B level of the last solution */
//C       int       bb_limitlevel;      /* The maximum B&B level allowed */
//C       COUNTER   bb_totalnodes;      /* Total number of nodes processed in B&B */
//C       int       bb_solutionlevel;   /* The B&B level of the last / best solution */
//C       int       bb_cutpoolsize;     /* Size of the B&B cut pool */
//C       int       bb_cutpoolused;     /* Currently used cut pool */
//C       int       bb_constraintOF;    /* General purpose B&B parameter (typically for testing) */
//C       int       *bb_cuttype;        /* The type of the currently used cuts */
//C       int       *bb_varactive;      /* The B&B state of the variable; 0 means inactive */
//C       DeltaVrec *bb_upperchange;    /* Changes to upper bounds during the B&B phase */
//C       DeltaVrec *bb_lowerchange;    /* Changes to lower bounds during the B&B phase */

//C       REAL      bb_deltaOF;         /* Minimum OF step value; computed at beginning of solve() */

//C       REAL      bb_breakOF;         
/* User-settable value for the objective function deemed
                               to be sufficiently good in an integer problem */
//C       REAL      bb_limitOF;         /* "Dual" bound / limit to final optimal MIP solution */
//C       REAL      bb_heuristicOF;     
/* Set initial "at least better than" guess for objective function
                               (can significantly speed up B&B iterations) */
//C       REAL      bb_parentOF;        /* The OF value of the previous BB simplex */
//C       REAL      bb_workOF;          /* The unadjusted OF value for the current best solution */

  /* Internal work arrays allocated as required */
//C       presolveundorec *presolve_undo;
//C       workarraysrec   *workarrays;

  /* MIP parameters */
//C       REAL      epsint;             /* Margin of error in determining if a float value is integer */
//C       REAL      mip_absgap;         /* Absolute MIP gap */
//C       REAL      mip_relgap;         /* Relative MIP gap */

  /* Time/timer variables and extended status text */
//C       double    timecreate;
//C       double    timestart;
//C       double    timeheuristic;
//C       double    timepresolved;
//C       double    timeend;
//C       long      sectimeout;

  /* Extended status message text set via explain() */
//C       char      *ex_status;

  /* Refactorization engine interface routines (for dynamic DLL/SO BFPs) */
//C     #if LoadInverseLib == TRUE
//C       #ifdef WIN32
//C         HINSTANCE                   hBFP;
//C       #else
//C         void                        *hBFP;
//C       #endif
//C     #endif
//C       BFPchar                       *bfp_name;
//C       BFPbool_lpintintint           *bfp_compatible;
//C       BFPbool_lpintintchar          *bfp_init;
//C       BFP_lp                        *bfp_free;
//C       BFPbool_lpint                 *bfp_resize;
//C       BFPint_lp                     *bfp_memallocated;
//C       BFPbool_lp                    *bfp_restart;
//C       BFPbool_lp                    *bfp_mustrefactorize;
//C       BFPint_lp                     *bfp_preparefactorization;
//C       BFPint_lpintintboolbool       *bfp_factorize;
//C       BFP_lp                        *bfp_finishfactorization;
//C       BFP_lp                        *bfp_updaterefactstats;
//C       BFPlreal_lpintintreal         *bfp_prepareupdate;
//C       BFPreal_lplrealreal           *bfp_pivotRHS;
//C       BFPbool_lpbool                *bfp_finishupdate;
//C       BFP_lprealint                 *bfp_ftran_prepare;
//C       BFP_lprealint                 *bfp_ftran_normal;
//C       BFP_lprealint                 *bfp_btran_normal;
//C       BFP_lprealintrealint          *bfp_btran_double;
//C       BFPint_lp                     *bfp_status;
//C       BFPint_lpbool                 *bfp_nonzeros;
//C       BFPbool_lp                    *bfp_implicitslack;
//C       BFPint_lp                     *bfp_indexbase;
//C       BFPint_lp                     *bfp_rowoffset;
//C       BFPint_lp                     *bfp_pivotmax;
//C       BFPbool_lpint                 *bfp_pivotalloc;
//C       BFPint_lp                     *bfp_colcount;
//C       BFPbool_lp                    *bfp_canresetbasis;
//C       BFPreal_lp                    *bfp_efficiency;
//C       BFPrealp_lp                   *bfp_pivotvector;
//C       BFPint_lp                     *bfp_pivotcount;
//C       BFPint_lpint                  *bfp_refactcount;
//C       BFPbool_lp                    *bfp_isSetI;
//C       BFPint_lpintrealcbintint      *bfp_findredundant;

  /* External language interface routines (for dynamic DLL/SO XLIs) */
//C     #if LoadLanguageLib == TRUE
//C       #ifdef WIN32
//C         HINSTANCE                   hXLI;
//C       #else
//C         void                        *hXLI;
//C       #endif
//C     #endif
//C       XLIchar                       *xli_name;
//C       XLIbool_lpintintint           *xli_compatible;
//C       XLIbool_lpcharcharcharint     *xli_readmodel;
//C       XLIbool_lpcharcharbool        *xli_writemodel;

  /* Miscellaneous internal functions made available externally */
//C       userabortfunc                 *userabort;
//C       reportfunc                    *report;
//C       explainfunc                   *explain;
//C       getvectorfunc                 *get_lpcolumn;
//C       getpackedfunc                 *get_basiscolumn;
//C       get_OF_activefunc             *get_OF_active;
//C       getMDOfunc                    *getMDO;
//C       invertfunc                    *invert;
//C       set_actionfunc                *set_action;
//C       is_actionfunc                 *is_action;
//C       clear_actionfunc              *clear_action;

  /* User program interface callbacks */
//C       lphandle_intfunc              *ctrlc;
//C         void                          *ctrlchandle;     /* User-specified "owner process ID" */
//C       lphandlestr_func              *writelog;
//C         void                          *loghandle;       /* User-specified "owner process ID" */
//C       lphandlestr_func              *debuginfo;
//C       lphandleint_func              *usermessage;
//C         int                           msgmask;
//C         void                          *msghandle;       /* User-specified "owner process ID" */
//C       lphandleint_intfunc           *bb_usenode;
//C         void                          *bb_nodehandle;   /* User-specified "owner process ID" */
//C       lphandleint_intfunc           *bb_usebranch;
//C         void                          *bb_branchhandle; /* User-specified "owner process ID" */

  /* replacement of static variables */
//C       char      *rowcol_name;       /* The name of a row/column */
//C     };
//alias void INVrec;
import lp_solve.lp_lusol;
alias _INVrec INVrec;
struct _lprec
{
    ubyte  function(lprec *lp, double *column)add_column;
    ubyte  function(lprec *lp, int count, double *column, int *rowno)add_columnex;
    ubyte  function(lprec *lp, double *row, int constr_type, double rh)add_constraint;
    ubyte  function(lprec *lp, int count, double *row, int *colno, int constr_type, double rh)add_constraintex;
    ubyte  function(lprec *lp, double *row, int con_type, double rhs)add_lag_con;
    int  function(lprec *lp, char *name, int sostype, int priority, int count, int *sosvars, double *weights)add_SOS;
    int  function(lprec *lp, double *column)column_in_lp;
    lprec * function(lprec *lp)copy_lp;
    void  function(lprec *lp)default_basis;
    ubyte  function(lprec *lp, int colnr)del_column;
    ubyte  function(lprec *lp, int rownr)del_constraint;
    void  function(lprec *lp)delete_lp;
    ubyte  function(lprec *lp)dualize_lp;
    void  function(lprec **plp)free_lp;
    int  function(lprec *lp)get_anti_degen;
    ubyte  function(lprec *lp, int *bascolumn, ubyte nonbasic)get_basis;
    int  function(lprec *lp)get_basiscrash;
    int  function(lprec *lp)get_bb_depthlimit;
    int  function(lprec *lp)get_bb_floorfirst;
    int  function(lprec *lp)get_bb_rule;
    ubyte  function(lprec *lp)get_bounds_tighter;
    double  function(lprec *lp)get_break_at_value;
    char * function(lprec *lp, int colnr)get_col_name;
    int  function(lprec *lp, int colnr, double *column, int *nzrow)get_columnex;
    int  function(lprec *lp, int rownr)get_constr_type;
    double  function(lprec *lp, int rownr, int count, double *primsolution, int *nzindex)get_constr_value;
    ubyte  function(lprec *lp, double *constr)get_constraints;
    ubyte  function(lprec *lp, double *rc)get_dual_solution;
    double  function(lprec *lp)get_epsb;
    double  function(lprec *lp)get_epsd;
    double  function(lprec *lp)get_epsel;
    double  function(lprec *lp)get_epsint;
    double  function(lprec *lp)get_epsperturb;
    double  function(lprec *lp)get_epspivot;
    int  function(lprec *lp)get_improve;
    double  function(lprec *lp)get_infinite;
    ubyte  function(lprec *lp, double *lambda)get_lambda;
    double  function(lprec *lp, int colnr)get_lowbo;
    int  function(lprec *lp, int orig_index)get_lp_index;
    char * function(lprec *lp)get_lp_name;
    int  function(lprec *lp)get_Lrows;
    double  function(lprec *lp, int rownr, int colnr)get_mat;
    double  function(lprec *lp, int matindex, ubyte isrow, ubyte adjustsign)get_mat_byindex;
    int  function(lprec *lp)get_max_level;
    int  function(lprec *lp)get_maxpivot;
    double  function(lprec *lp, ubyte absolute)get_mip_gap;
    int  function(lprec *lp, ubyte getabssize)get_multiprice;
    int  function(lprec *lp, char *varname, ubyte isrow)get_nameindex;
    int  function(lprec *lp)get_Ncolumns;
    double  function(lprec *lp)get_negrange;
    int  function(lprec *lp)get_nonzeros;
    int  function(lprec *lp)get_Norig_columns;
    int  function(lprec *lp)get_Norig_rows;
    int  function(lprec *lp)get_Nrows;
    double  function(lprec *lp)get_obj_bound;
    double  function(lprec *lp)get_objective;
    int  function(lprec *lp, int lp_index)get_orig_index;
    char * function(lprec *lp, int colnr)get_origcol_name;
    char * function(lprec *lp, int rownr)get_origrow_name;
    void  function(lprec *lp, int *blockcount, int *blockstart, ubyte isrow)get_partialprice;
    int  function(lprec *lp)get_pivoting;
    int  function(lprec *lp)get_presolve;
    int  function(lprec *lp)get_presolveloops;
    ubyte  function(lprec *lp, double *pv)get_primal_solution;
    int  function(lprec *lp)get_print_sol;
    ubyte  function(lprec *lp, double *clower, double *cupper, int *updatelimit)get_pseudocosts;
    ubyte  function(lprec *lp, double **constr)get_ptr_constraints;
    ubyte  function(lprec *lp, double **rc)get_ptr_dual_solution;
    ubyte  function(lprec *lp, double **lambda)get_ptr_lambda;
    ubyte  function(lprec *lp, double **pv)get_ptr_primal_solution;
    ubyte  function(lprec *lp, double **objfrom, double **objtill)get_ptr_sensitivity_obj;
    ubyte  function(lprec *lp, double **objfrom, double **objtill, double **objfromvalue, double **objtillvalue)get_ptr_sensitivity_objex;
    ubyte  function(lprec *lp, double **duals, double **dualsfrom, double **dualstill)get_ptr_sensitivity_rhs;
    ubyte  function(lprec *lp, double **var)get_ptr_variables;
    double  function(lprec *lp, int rownr)get_rh;
    double  function(lprec *lp, int rownr)get_rh_range;
    ubyte  function(lprec *lp, int rownr, double *row)get_row;
    int  function(lprec *lp, int rownr, double *row, int *colno)get_rowex;
    char * function(lprec *lp, int rownr)get_row_name;
    double  function(lprec *lp)get_scalelimit;
    int  function(lprec *lp)get_scaling;
    ubyte  function(lprec *lp, double *objfrom, double *objtill)get_sensitivity_obj;
    ubyte  function(lprec *lp, double *objfrom, double *objtill, double *objfromvalue, double *objtillvalue)get_sensitivity_objex;
    ubyte  function(lprec *lp, double *duals, double *dualsfrom, double *dualstill)get_sensitivity_rhs;
    int  function(lprec *lp)get_simplextype;
    int  function(lprec *lp)get_solutioncount;
    int  function(lprec *lp)get_solutionlimit;
    int  function(lprec *lp)get_status;
    char * function(lprec *lp, int statuscode)get_statustext;
    int  function(lprec *lp)get_timeout;
    long  function(lprec *lp)get_total_iter;
    long  function(lprec *lp)get_total_nodes;
    double  function(lprec *lp, int colnr)get_upbo;
    int  function(lprec *lp, int colnr)get_var_branch;
    double  function(lprec *lp, int index)get_var_dualresult;
    double  function(lprec *lp, int index)get_var_primalresult;
    int  function(lprec *lp, int colnr)get_var_priority;
    ubyte  function(lprec *lp, double *var)get_variables;
    int  function(lprec *lp)get_verbose;
    double  function(lprec *lp)get_working_objective;
    ubyte  function(lprec *lp)has_BFP;
    ubyte  function(lprec *lp)has_XLI;
    ubyte  function(lprec *lp)is_add_rowmode;
    ubyte  function(lprec *lp, int testmask)is_anti_degen;
    ubyte  function(lprec *lp, int colnr)is_binary;
    ubyte  function(lprec *lp)is_break_at_first;
    ubyte  function(lprec *lp, int rownr, int mask)is_constr_type;
    ubyte  function(lprec *lp)is_debug;
    ubyte  function(lprec *lp, double *values, double threshold)is_feasible;
    ubyte  function(lprec *lp, double value)is_infinite;
    ubyte  function(lprec *lp, int column)is_int;
    ubyte  function(lprec *lp)is_integerscaling;
    ubyte  function(lprec *lp)is_lag_trace;
    ubyte  function(lprec *lp)is_maxim;
    ubyte  function(lprec *lp)is_nativeBFP;
    ubyte  function(lprec *lp)is_nativeXLI;
    ubyte  function(lprec *lp, int colnr)is_negative;
    ubyte  function(lprec *lp)is_obj_in_basis;
    ubyte  function(lprec *lp, int testmask)is_piv_mode;
    ubyte  function(lprec *lp, int rule)is_piv_rule;
    ubyte  function(lprec *lp, int testmask)is_presolve;
    ubyte  function(lprec *lp, int testmask)is_scalemode;
    ubyte  function(lprec *lp, int scaletype)is_scaletype;
    ubyte  function(lprec *lp, int colnr)is_semicont;
    ubyte  function(lprec *lp, int colnr)is_SOS_var;
    ubyte  function(lprec *lp)is_trace;
    ubyte  function(lprec *lp, int colnr)is_unbounded;
    ubyte  function(lprec *lp, ubyte isrow)is_use_names;
    void  function(int *majorversion, int *minorversion, int *release, int *build)lp_solve_version;
    lprec * function(int rows, int columns)make_lp;
    void  function(lprec *lp, int columns)print_constraints;
    ubyte  function(lprec *lp, char *filename)print_debugdump;
    void  function(lprec *lp)print_duals;
    void  function(lprec *lp)print_lp;
    void  function(lprec *lp)print_objective;
    void  function(lprec *lp)print_scales;
    void  function(lprec *lp, int columns)print_solution;
    void  function(lprec *lp, char *str)print_str;
    void  function(lprec *lp)print_tableau;
    void  function(lprec *lp, int  function(lprec *lp, void *userhandle)newctrlc, void *ctrlchandle)put_abortfunc;
    void  function(lprec *lp, int  function(lprec *lp, void *userhandle, int message)newnode, void *bbnodehandle)put_bb_nodefunc;
    void  function(lprec *lp, int  function(lprec *lp, void *userhandle, int message)newbranch, void *bbbranchhandle)put_bb_branchfunc;
    void  function(lprec *lp, void  function(lprec *lp, void *userhandle, char *buf)newlog, void *loghandle)put_logfunc;
    void  function(lprec *lp, void  function(lprec *lp, void *userhandle, int message)newmsg, void *msghandle, int mask)put_msgfunc;
    lprec * function(char *filename, int verbose, char *lp_name)read_LP;
    lprec * function(char *filename, int options)read_MPS;
    lprec * function(char *xliname, char *modelname, char *dataname, char *options, int verbose)read_XLI;
    ubyte  function(lprec *lp, char *filename, char *options)read_params;
    ubyte  function(lprec *lp, char *filename, char *info)read_basis;
    void  function(lprec *lp)reset_basis;
    void  function(lprec *lp)reset_params;
    ubyte  function(lprec *lp, int rows, int columns)resize_lp;
    ubyte  function(lprec *lp, ubyte turnon)set_add_rowmode;
    void  function(lprec *lp, int anti_degen)set_anti_degen;
    int  function(lprec *lp, int basisPos, int enteringCol)set_basisvar;
    ubyte  function(lprec *lp, int *bascolumn, ubyte nonbasic)set_basis;
    void  function(lprec *lp, int mode)set_basiscrash;
    void  function(lprec *lp, int bb_maxlevel)set_bb_depthlimit;
    void  function(lprec *lp, int bb_floorfirst)set_bb_floorfirst;
    void  function(lprec *lp, int bb_rule)set_bb_rule;
    ubyte  function(lprec *lp, char *filename)set_BFP;
    ubyte  function(lprec *lp, int colnr, ubyte must_be_bin)set_binary;
    ubyte  function(lprec *lp, int colnr, double lower, double upper)set_bounds;
    void  function(lprec *lp, ubyte tighten)set_bounds_tighter;
    void  function(lprec *lp, ubyte break_at_first)set_break_at_first;
    void  function(lprec *lp, double break_at_value)set_break_at_value;
    ubyte  function(lprec *lp, int colnr, double *column)set_column;
    ubyte  function(lprec *lp, int colnr, int count, double *column, int *rowno)set_columnex;
    ubyte  function(lprec *lp, int colnr, char *new_name)set_col_name;
    ubyte  function(lprec *lp, int rownr, int con_type)set_constr_type;
    void  function(lprec *lp, ubyte debug_)set_debug;
    void  function(lprec *lp, double epsb)set_epsb;
    void  function(lprec *lp, double epsd)set_epsd;
    void  function(lprec *lp, double epsel)set_epsel;
    void  function(lprec *lp, double epsint)set_epsint;
    ubyte  function(lprec *lp, int epslevel)set_epslevel;
    void  function(lprec *lp, double epsperturb)set_epsperturb;
    void  function(lprec *lp, double epspivot)set_epspivot;
    ubyte  function(lprec *lp, int colnr)set_unbounded;
    void  function(lprec *lp, int improve)set_improve;
    void  function(lprec *lp, double infinite)set_infinite;
    ubyte  function(lprec *lp, int colnr, ubyte must_be_int)set_int;
    void  function(lprec *lp, ubyte lag_trace)set_lag_trace;
    ubyte  function(lprec *lp, int colnr, double value)set_lowbo;
    ubyte  function(lprec *lp, char *lpname)set_lp_name;
    ubyte  function(lprec *lp, int row, int column, double value)set_mat;
    void  function(lprec *lp)set_maxim;
    void  function(lprec *lp, int max_num_inv)set_maxpivot;
    void  function(lprec *lp)set_minim;
    void  function(lprec *lp, ubyte absolute, double mip_gap)set_mip_gap;
    ubyte  function(lprec *lp, int multiblockdiv)set_multiprice;
    void  function(lprec *lp, double negrange)set_negrange;
    void  function(lprec *lp, double obj_bound)set_obj_bound;
    ubyte  function(lprec *lp, double *row)set_obj_fn;
    ubyte  function(lprec *lp, int count, double *row, int *colno)set_obj_fnex;
    ubyte  function(lprec *lp, int colnr, double value)set_obj;
    void  function(lprec *lp, ubyte obj_in_basis)set_obj_in_basis;
    ubyte  function(lprec *lp, char *filename)set_outputfile;
    void  function(lprec *lp, FILE *stream)set_outputstream;
    ubyte  function(lprec *lp, int blockcount, int *blockstart, ubyte isrow)set_partialprice;
    void  function(lprec *lp, int piv_rule)set_pivoting;
    void  function(lprec *lp, ubyte dodual)set_preferdual;
    void  function(lprec *lp, int presolvemode, int maxloops)set_presolve;
    void  function(lprec *lp, int print_sol)set_print_sol;
    ubyte  function(lprec *lp, double *clower, double *cupper, int *updatelimit)set_pseudocosts;
    ubyte  function(lprec *lp, int rownr, double value)set_rh;
    ubyte  function(lprec *lp, int rownr, double deltavalue)set_rh_range;
    void  function(lprec *lp, double *rh)set_rh_vec;
    ubyte  function(lprec *lp, int rownr, double *row)set_row;
    ubyte  function(lprec *lp, int rownr, int count, double *row, int *colno)set_rowex;
    ubyte  function(lprec *lp, int rownr, char *new_name)set_row_name;
    void  function(lprec *lp, double scalelimit)set_scalelimit;
    void  function(lprec *lp, int scalemode)set_scaling;
    ubyte  function(lprec *lp, int colnr, ubyte must_be_sc)set_semicont;
    void  function(lprec *lp, ubyte maximize)set_sense;
    void  function(lprec *lp, int simplextype)set_simplextype;
    void  function(lprec *lp, int limit)set_solutionlimit;
    void  function(lprec *lp, int sectimeout)set_timeout;
    void  function(lprec *lp, ubyte trace)set_trace;
    ubyte  function(lprec *lp, int colnr, double value)set_upbo;
    void  function(lprec *lp, ubyte isrow, ubyte use_names)set_use_names;
    ubyte  function(lprec *lp, int colnr, int branch_mode)set_var_branch;
    ubyte  function(lprec *lp, double *weights)set_var_weights;
    void  function(lprec *lp, int verbose)set_verbose;
    ubyte  function(lprec *lp, char *filename)set_XLI;
    int  function(lprec *lp)solve;
    ubyte  function(lprec *lp, char *col_string)str_add_column;
    ubyte  function(lprec *lp, char *row_string, int constr_type, double rh)str_add_constraint;
    ubyte  function(lprec *lp, char *row_string, int con_type, double rhs)str_add_lag_con;
    ubyte  function(lprec *lp, char *row_string)str_set_obj_fn;
    ubyte  function(lprec *lp, char *rh_string)str_set_rh_vec;
    double  function(lprec *lp)time_elapsed;
    void  function(lprec *lp)unscale;
    ubyte  function(lprec *lp, char *filename)write_lp;
    ubyte  function(lprec *lp, FILE *output)write_LP;
    ubyte  function(lprec *lp, char *filename)write_mps;
    ubyte  function(lprec *lp, FILE *output)write_MPS;
    ubyte  function(lprec *lp, char *filename)write_freemps;
    ubyte  function(lprec *lp, FILE *output)write_freeMPS;
    ubyte  function(lprec *lp, char *filename, char *options, ubyte results)write_XLI;
    ubyte  function(lprec *lp, char *filename)write_basis;
    ubyte  function(lprec *lp, char *filename, char *options)write_params;
    int *alignmentspacer;
    char *lp_name;
    int sum;
    int rows;
    int columns;
    int equalities;
    int boundedvars;
    int INTfuture1;
    int sum_alloc;
    int rows_alloc;
    int columns_alloc;
    ubyte source_is_file;
    ubyte model_is_pure;
    ubyte model_is_valid;
    ubyte tighten_on_set;
    ubyte names_used;
    ubyte use_row_names;
    ubyte use_col_names;
    ubyte lag_trace;
    ubyte spx_trace;
    ubyte bb_trace;
    ubyte streamowned;
    ubyte obj_in_basis;
    int spx_status;
    int lag_status;
    int solutioncount;
    int solutionlimit;
    double real_solution;
    double *solution;
    double *best_solution;
    double *full_solution;
    double *edgeVector;
    double *drow;
    int *nzdrow;
    double *duals;
    double *full_duals;
    double *dualsfrom;
    double *dualstill;
    double *objfrom;
    double *objtill;
    double *objfromvalue;
    double *orig_obj;
    double *obj;
    long current_iter;
    long total_iter;
    long current_bswap;
    long total_bswap;
    int solvecount;
    int max_pivots;
    int simplex_strategy;
    int simplex_mode;
    int verbose;
    int print_sol;
    FILE *outstream;
    ubyte *bb_varbranch;
    int piv_strategy;
    int _piv_rule_;
    int bb_rule;
    ubyte bb_floorfirst;
    ubyte bb_breakfirst;
    ubyte _piv_left_;
    ubyte BOOLfuture1;
    double scalelimit;
    int scalemode;
    int improve;
    int anti_degen;
    int do_presolve;
    int presolveloops;
    int perturb_count;
    hashelem **row_name;
    hashelem **col_name;
    hashtable *rowname_hashtab;
    hashtable *colname_hashtab;
    partialrec *rowblocks;
    partialrec *colblocks;
    ubyte *var_type;
    multirec *multivars;
    int multiblockdiv;
    int fixedvars;
    int int_vars;
    int sc_vars;
    double *sc_lobound;
    int *var_is_free;
    int *var_priority;
    SOSgroup *GUB;
    int sos_vars;
    int sos_ints;
    SOSgroup *SOS;
    int *sos_priority;
    double *bsolveVal;
    int *bsolveIdx;
    double *orig_rhs;
    double *rhs;
    int *row_type;
    multirec *longsteps;
    double *orig_upbo;
    double *upbo;
    double *orig_lowbo;
    double *lowbo;
    MATrec *matA;
    INVrec *invB;
    BBrec *bb_bounds;
    BBrec *rootbounds;
    basisrec *bb_basis;
    basisrec *rootbasis;
    OBJmonrec *monitor;
    double *scalars;
    ubyte scaling_used;
    ubyte columns_scaled;
    ubyte varmap_locked;
    ubyte basis_valid;
    int crashmode;
    int *var_basic;
    double *val_nonbasic;
    ubyte *is_basic;
    ubyte *is_lower;
    int *rejectpivot;
    BBPSrec *bb_PseudoCost;
    int bb_PseudoUpdates;
    int bb_strongbranches;
    int is_strongbranch;
    int bb_improvements;
    double rhsmax;
    double suminfeas;
    double bigM;
    double P1extraVal;
    int P1extraDim;
    int spx_action;
    ubyte spx_perturbed;
    ubyte bb_break;
    ubyte wasPreprocessed;
    ubyte wasPresolved;
    int INTfuture2;
    MATrec *matL;
    double *lag_rhs;
    int *lag_con_type;
    double *lambda;
    double lag_bound;
    double lag_accept;
    double infinite;
    double negrange;
    double epsmachine;
    double epsvalue;
    double epsprimal;
    double epsdual;
    double epspivot;
    double epsperturb;
    double epssolution;
    int bb_status;
    int bb_level;
    int bb_maxlevel;
    int bb_limitlevel;
    long bb_totalnodes;
    int bb_solutionlevel;
    int bb_cutpoolsize;
    int bb_cutpoolused;
    int bb_constraintOF;
    int *bb_cuttype;
    int *bb_varactive;
    DeltaVrec *bb_upperchange;
    DeltaVrec *bb_lowerchange;
    double bb_deltaOF;
    double bb_breakOF;
    double bb_limitOF;
    double bb_heuristicOF;
    double bb_parentOF;
    double bb_workOF;
    presolveundorec *presolve_undo;
    workarraysrec *workarrays;
    double epsint;
    double mip_absgap;
    double mip_relgap;
    double timecreate;
    double timestart;
    double timeheuristic;
    double timepresolved;
    double timeend;
    int sectimeout;
    char *ex_status;
    HINSTANCE hBFP;
    char * function()bfp_name;
    ubyte  function(lprec *lp, int size, int deltasize, int sizeofvar)bfp_compatible;
    ubyte  function(lprec *lp, int size, int deltasize, char *options)bfp_init;
    void  function(lprec *lp)bfp_free;
    ubyte  function(lprec *lp, int size)bfp_resize;
    int  function(lprec *lp)bfp_memallocated;
    ubyte  function(lprec *lp)bfp_restart;
    ubyte  function(lprec *lp)bfp_mustrefactorize;
    int  function(lprec *lp)bfp_preparefactorization;
    int  function(lprec *lp, int uservars, int Bsize, ubyte *usedpos, ubyte final_)bfp_factorize;
    void  function(lprec *lp)bfp_finishfactorization;
    void  function(lprec *lp)bfp_updaterefactstats;
    double  function(lprec *lp, int row_nr, int col_nr, double *pcol)bfp_prepareupdate;
    double  function(lprec *lp, double theta, double *pcol)bfp_pivotRHS;
    ubyte  function(lprec *lp, ubyte changesign)bfp_finishupdate;
    void  function(lprec *lp, double *pcol, int *nzidx)bfp_ftran_prepare;
    void  function(lprec *lp, double *pcol, int *nzidx)bfp_ftran_normal;
    void  function(lprec *lp, double *pcol, int *nzidx)bfp_btran_normal;
    void  function(lprec *lp, double *prow, int *pnzidx, double *drow, int *dnzidx)bfp_btran_double;
    int  function(lprec *lp)bfp_status;
    int  function(lprec *lp, ubyte maximum)bfp_nonzeros;
    ubyte  function(lprec *lp)bfp_implicitslack;
    int  function(lprec *lp)bfp_indexbase;
    int  function(lprec *lp)bfp_rowoffset;
    int  function(lprec *lp)bfp_pivotmax;
    ubyte  function(lprec *lp, int size)bfp_pivotalloc;
    int  function(lprec *lp)bfp_colcount;
    ubyte  function(lprec *lp)bfp_canresetbasis;
    double  function(lprec *lp)bfp_efficiency;
    double * function(lprec *lp)bfp_pivotvector;
    int  function(lprec *lp)bfp_pivotcount;
    int  function(lprec *lp, int kind)bfp_refactcount;
    ubyte  function(lprec *lp)bfp_isSetI;
    int  function(lprec *lp, int items, int  function(lprec *lp, int colnr, double *nzvalues, int *nzrows, int *mapin)cb, int *maprow, int *mapcol)bfp_findredundant;
    HINSTANCE hXLI;
    char * function()xli_name;
    ubyte  function(lprec *lp, int size, int deltasize, int sizevar)xli_compatible;
    ubyte  function(lprec *lp, char *modelname, char *dataname, char *options, int verbose)xli_readmodel;
    ubyte  function(lprec *lp, char *filename, char *options, ubyte results)xli_writemodel;
    ubyte  function(lprec *lp, int level)userabort;
    void  function(lprec *lp, int level, char *format,...)report;
    char * function(lprec *lp, char *format,...)explain;
    int  function(lprec *lp, int varin, double *pcol, int *nzlist, int *maxabs)get_lpcolumn;
    int  function(lprec *lp, int j, int *rn, double *bj)get_basiscolumn;
    double  function(lprec *lp, int varnr, double mult)get_OF_active;
    int  function(lprec *lp, ubyte *usedpos, int *colorder, int *size, ubyte symmetric)getMDO;
    ubyte  function(lprec *lp, ubyte shiftbounds, ubyte final_)invert;
    void  function(int *actionvar, int actionmask)set_action;
    ubyte  function(int actionvar, int testmask)is_action;
    void  function(int *actionvar, int actionmask)clear_action;
    int  function(lprec *lp, void *userhandle)ctrlc;
    void *ctrlchandle;
    void  function(lprec *lp, void *userhandle, char *buf)writelog;
    void *loghandle;
    void  function(lprec *lp, void *userhandle, char *buf)debuginfo;
    void  function(lprec *lp, void *userhandle, int message)usermessage;
    int msgmask;
    void *msghandle;
    int  function(lprec *lp, void *userhandle, int message)bb_usenode;
    void *bb_nodehandle;
    int  function(lprec *lp, void *userhandle, int message)bb_usebranch;
    void *bb_branchhandle;
    char *rowcol_name;
}


//C     #ifdef __cplusplus
//C     __EXTERN_C {
//C     #endif


/* User and system function interfaces                                       */
/* ------------------------------------------------------------------------- */

//C     void __EXPORT_TYPE __WINAPI lp_solve_version(int *majorversion, int *minorversion, int *release, int *build);
extern (C):
void  lp_solve_version(int *majorversion, int *minorversion, int *release, int *build);

//C     lprec __EXPORT_TYPE * __WINAPI make_lp(int rows, int columns);
lprec * make_lp(int rows, int columns);
//C     MYBOOL __EXPORT_TYPE __WINAPI resize_lp(lprec *lp, int rows, int columns);
ubyte  resize_lp(lprec *lp, int rows, int columns);
//C     int __EXPORT_TYPE __WINAPI get_status(lprec *lp);
int  get_status(lprec *lp);
//C     char __EXPORT_TYPE * __WINAPI get_statustext(lprec *lp, int statuscode);
char * get_statustext(lprec *lp, int statuscode);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_obj_in_basis(lprec *lp);
ubyte  is_obj_in_basis(lprec *lp);
//C     void __EXPORT_TYPE __WINAPI set_obj_in_basis(lprec *lp, MYBOOL obj_in_basis);
void  set_obj_in_basis(lprec *lp, ubyte obj_in_basis);
/* Create and initialise a lprec structure defaults */

//C     lprec __EXPORT_TYPE * __WINAPI copy_lp(lprec *lp);
lprec * copy_lp(lprec *lp);
//C     MYBOOL __EXPORT_TYPE __WINAPI dualize_lp(lprec *lp);
ubyte  dualize_lp(lprec *lp);
//C     STATIC MYBOOL memopt_lp(lprec *lp, int rowextra, int colextra, int nzextra);
extern (C):
ubyte  memopt_lp(lprec *lp, int rowextra, int colextra, int nzextra);
/* Copy or dualize the lp */

//C     void __EXPORT_TYPE __WINAPI delete_lp(lprec *lp);
extern (C):
void  delete_lp(lprec *lp);
//C     void __EXPORT_TYPE __WINAPI free_lp(lprec **plp);
void  free_lp(lprec **plp);
/* Remove problem from memory */

//C     MYBOOL __EXPORT_TYPE __WINAPI set_lp_name(lprec *lp, char *lpname);
ubyte  set_lp_name(lprec *lp, char *lpname);
//C     __EXPORT_TYPE char * __WINAPI get_lp_name(lprec *lp);
char * get_lp_name(lprec *lp);
/* Set and get the problem name */

//C     MYBOOL __EXPORT_TYPE __WINAPI has_BFP(lprec *lp);
ubyte  has_BFP(lprec *lp);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_nativeBFP(lprec *lp);
ubyte  is_nativeBFP(lprec *lp);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_BFP(lprec *lp, char *filename);
ubyte  set_BFP(lprec *lp, char *filename);
/* Set basis factorization engine */

//C     lprec __EXPORT_TYPE * __WINAPI read_XLI(char *xliname, char *modelname, char *dataname, char *options, int verbose);
lprec * read_XLI(char *xliname, char *modelname, char *dataname, char *options, int verbose);
//C     MYBOOL __EXPORT_TYPE __WINAPI write_XLI(lprec *lp, char *filename, char *options, MYBOOL results);
ubyte  write_XLI(lprec *lp, char *filename, char *options, ubyte results);
//C     MYBOOL __EXPORT_TYPE __WINAPI has_XLI(lprec *lp);
ubyte  has_XLI(lprec *lp);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_nativeXLI(lprec *lp);
ubyte  is_nativeXLI(lprec *lp);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_XLI(lprec *lp, char *filename);
ubyte  set_XLI(lprec *lp, char *filename);
/* Set external language interface */

//C     MYBOOL __EXPORT_TYPE __WINAPI set_obj(lprec *lp, int colnr, REAL value);
ubyte  set_obj(lprec *lp, int colnr, double value);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_obj_fn(lprec *lp, REAL *row);
ubyte  set_obj_fn(lprec *lp, double *row);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_obj_fnex(lprec *lp, int count, REAL *row, int *colno);
ubyte  set_obj_fnex(lprec *lp, int count, double *row, int *colno);
/* set the objective function (Row 0) of the matrix */
//C     MYBOOL __EXPORT_TYPE __WINAPI str_set_obj_fn(lprec *lp, char *row_string);
ubyte  str_set_obj_fn(lprec *lp, char *row_string);
/* The same, but with string input */
//C     void __EXPORT_TYPE __WINAPI set_sense(lprec *lp, MYBOOL maximize);
void  set_sense(lprec *lp, ubyte maximize);
//C     void __EXPORT_TYPE __WINAPI set_maxim(lprec *lp);
void  set_maxim(lprec *lp);
//C     void __EXPORT_TYPE __WINAPI set_minim(lprec *lp);
void  set_minim(lprec *lp);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_maxim(lprec *lp);
ubyte  is_maxim(lprec *lp);
/* Set optimization direction for the objective function */

//C     MYBOOL __EXPORT_TYPE __WINAPI add_constraint(lprec *lp, REAL *row, int constr_type, REAL rh);
ubyte  add_constraint(lprec *lp, double *row, int constr_type, double rh);
//C     MYBOOL __EXPORT_TYPE __WINAPI add_constraintex(lprec *lp, int count, REAL *row, int *colno, int constr_type, REAL rh);
ubyte  add_constraintex(lprec *lp, int count, double *row, int *colno, int constr_type, double rh);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_add_rowmode(lprec *lp, MYBOOL turnon);
ubyte  set_add_rowmode(lprec *lp, ubyte turnon);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_add_rowmode(lprec *lp);
ubyte  is_add_rowmode(lprec *lp);
/* Add a constraint to the problem, row is the constraint row, rh is the right hand side,
   constr_type is the type of constraint (LE (<=), GE(>=), EQ(=)) */
//C     MYBOOL __EXPORT_TYPE __WINAPI str_add_constraint(lprec *lp, char *row_string, int constr_type, REAL rh);
ubyte  str_add_constraint(lprec *lp, char *row_string, int constr_type, double rh);
/* The same, but with string input */

//C     MYBOOL __EXPORT_TYPE __WINAPI set_row(lprec *lp, int rownr, REAL *row);
ubyte  set_row(lprec *lp, int rownr, double *row);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_rowex(lprec *lp, int rownr, int count, REAL *row, int *colno);
ubyte  set_rowex(lprec *lp, int rownr, int count, double *row, int *colno);
//C     MYBOOL __EXPORT_TYPE __WINAPI get_row(lprec *lp, int rownr, REAL *row);
ubyte  get_row(lprec *lp, int rownr, double *row);
//C     int __EXPORT_TYPE __WINAPI get_rowex(lprec *lp, int rownr, REAL *row, int *colno);
int  get_rowex(lprec *lp, int rownr, double *row, int *colno);
/* Fill row with the row row_nr from the problem */

//C     MYBOOL __EXPORT_TYPE __WINAPI del_constraint(lprec *lp, int rownr);
ubyte  del_constraint(lprec *lp, int rownr);
//C     STATIC MYBOOL del_constraintex(lprec *lp, LLrec *rowmap);
extern (C):
ubyte  del_constraintex(lprec *lp, LLrec *rowmap);
/* Remove constrain nr del_row from the problem */

//C     MYBOOL __EXPORT_TYPE __WINAPI add_lag_con(lprec *lp, REAL *row, int con_type, REAL rhs);
extern (C):
ubyte  add_lag_con(lprec *lp, double *row, int con_type, double rhs);
/* add a Lagrangian constraint of form Row' x contype Rhs */
//C     MYBOOL __EXPORT_TYPE __WINAPI str_add_lag_con(lprec *lp, char *row_string, int con_type, REAL rhs);
ubyte  str_add_lag_con(lprec *lp, char *row_string, int con_type, double rhs);
/* The same, but with string input */
//C     void __EXPORT_TYPE __WINAPI set_lag_trace(lprec *lp, MYBOOL lag_trace);
void  set_lag_trace(lprec *lp, ubyte lag_trace);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_lag_trace(lprec *lp);
ubyte  is_lag_trace(lprec *lp);
/* Set debugging/tracing mode of the Lagrangean solver */

//C     MYBOOL __EXPORT_TYPE __WINAPI set_constr_type(lprec *lp, int rownr, int con_type);
ubyte  set_constr_type(lprec *lp, int rownr, int con_type);
//C     int __EXPORT_TYPE __WINAPI get_constr_type(lprec *lp, int rownr);
int  get_constr_type(lprec *lp, int rownr);
//C     REAL __EXPORT_TYPE __WINAPI get_constr_value(lprec *lp, int rownr, int count, REAL *primsolution, int *nzindex);
double  get_constr_value(lprec *lp, int rownr, int count, double *primsolution, int *nzindex);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_constr_type(lprec *lp, int rownr, int mask);
ubyte  is_constr_type(lprec *lp, int rownr, int mask);
//C     STATIC char *get_str_constr_type(lprec *lp, int con_type);
extern (C):
char * get_str_constr_type(lprec *lp, int con_type);
//C     STATIC int get_constr_class(lprec *lp, int rownr);
int  get_constr_class(lprec *lp, int rownr);
//C     STATIC char *get_str_constr_class(lprec *lp, int con_class);
char * get_str_constr_class(lprec *lp, int con_class);
/* Set the type of constraint in row Row (LE, GE, EQ) */

//C     MYBOOL __EXPORT_TYPE __WINAPI set_rh(lprec *lp, int rownr, REAL value);
extern (C):
ubyte  set_rh(lprec *lp, int rownr, double value);
//C     REAL __EXPORT_TYPE __WINAPI get_rh(lprec *lp, int rownr);
double  get_rh(lprec *lp, int rownr);
/* Set and get the right hand side of a constraint row */
//C     MYBOOL __EXPORT_TYPE __WINAPI set_rh_range(lprec *lp, int rownr, REAL deltavalue);
ubyte  set_rh_range(lprec *lp, int rownr, double deltavalue);
//C     REAL __EXPORT_TYPE __WINAPI get_rh_range(lprec *lp, int rownr);
double  get_rh_range(lprec *lp, int rownr);
/* Set the RHS range; i.e. the lower and upper bounds of a constraint row */
//C     void __EXPORT_TYPE __WINAPI set_rh_vec(lprec *lp, REAL *rh);
void  set_rh_vec(lprec *lp, double *rh);
/* Set the right hand side vector */
//C     MYBOOL __EXPORT_TYPE __WINAPI str_set_rh_vec(lprec *lp, char *rh_string);
ubyte  str_set_rh_vec(lprec *lp, char *rh_string);
/* The same, but with string input */

//C     MYBOOL __EXPORT_TYPE __WINAPI add_column(lprec *lp, REAL *column);
ubyte  add_column(lprec *lp, double *column);
//C     MYBOOL __EXPORT_TYPE __WINAPI add_columnex(lprec *lp, int count, REAL *column, int *rowno);
ubyte  add_columnex(lprec *lp, int count, double *column, int *rowno);
//C     MYBOOL __EXPORT_TYPE __WINAPI str_add_column(lprec *lp, char *col_string);
ubyte  str_add_column(lprec *lp, char *col_string);
/* Add a column to the problem */

//C     MYBOOL __EXPORT_TYPE __WINAPI set_column(lprec *lp, int colnr, REAL *column);
ubyte  set_column(lprec *lp, int colnr, double *column);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_columnex(lprec *lp, int colnr, int count, REAL *column, int *rowno);
ubyte  set_columnex(lprec *lp, int colnr, int count, double *column, int *rowno);
/* Overwrite existing column data */

//C     int __EXPORT_TYPE __WINAPI column_in_lp(lprec *lp, REAL *column);
int  column_in_lp(lprec *lp, double *column);
/* Returns the column index if column is already present in lp, otherwise 0.
   (Does not look at bounds and types, only looks at matrix values */

//C     int __EXPORT_TYPE __WINAPI get_columnex(lprec *lp, int colnr, REAL *column, int *nzrow);
int  get_columnex(lprec *lp, int colnr, double *column, int *nzrow);
//C     MYBOOL __EXPORT_TYPE __WINAPI get_column(lprec *lp, int colnr, REAL *column);
ubyte  get_column(lprec *lp, int colnr, double *column);
/* Fill column with the column col_nr from the problem */

//C     MYBOOL __EXPORT_TYPE __WINAPI del_column(lprec *lp, int colnr);
ubyte  del_column(lprec *lp, int colnr);
//C     STATIC MYBOOL del_columnex(lprec *lp, LLrec *colmap);
extern (C):
ubyte  del_columnex(lprec *lp, LLrec *colmap);
/* Delete a column */

//C     MYBOOL __EXPORT_TYPE __WINAPI set_mat(lprec *lp, int rownr, int colnr, REAL value);
extern (C):
ubyte  set_mat(lprec *lp, int rownr, int colnr, double value);
/* Fill in element (Row,Column) of the matrix
   Row in [0..Rows] and Column in [1..Columns] */
//C     REAL __EXPORT_TYPE __WINAPI get_mat(lprec *lp, int rownr, int colnr);
double  get_mat(lprec *lp, int rownr, int colnr);
//C     REAL __EXPORT_TYPE __WINAPI get_mat_byindex(lprec *lp, int matindex, MYBOOL isrow, MYBOOL adjustsign);
double  get_mat_byindex(lprec *lp, int matindex, ubyte isrow, ubyte adjustsign);
//C     int __EXPORT_TYPE __WINAPI get_nonzeros(lprec *lp);
int  get_nonzeros(lprec *lp);
/* get a single element from the matrix */
  /* Name changed from "mat_elm" by KE */

//C     void __EXPORT_TYPE __WINAPI set_bounds_tighter(lprec *lp, MYBOOL tighten);
void  set_bounds_tighter(lprec *lp, ubyte tighten);
//C     MYBOOL get_bounds(lprec *lp, int column, REAL *lower, REAL *upper);
extern (C):
ubyte  get_bounds(lprec *lp, int column, double *lower, double *upper);
//C     MYBOOL __EXPORT_TYPE __WINAPI get_bounds_tighter(lprec *lp);
extern (C):
ubyte  get_bounds_tighter(lprec *lp);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_upbo(lprec *lp, int colnr, REAL value);
/// colnr番目の変数の上限をvalueにする
ubyte  set_upbo(lprec *lp, int colnr, double value);
//C     REAL __EXPORT_TYPE __WINAPI get_upbo(lprec *lp, int colnr);
/// colnr番目の変数の上限を取得
double  get_upbo(lprec *lp, int colnr);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_lowbo(lprec *lp, int colnr, REAL value);
/// colnr番目の変数の下限をvalueにする
ubyte  set_lowbo(lprec *lp, int colnr, double value);
//C     REAL __EXPORT_TYPE __WINAPI get_lowbo(lprec *lp, int colnr);
/// colnr番目の変数の下限を取得
double  get_lowbo(lprec *lp, int colnr);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_bounds(lprec *lp, int colnr, REAL lower, REAL upper);
/// colnr番目の変数の上限と下限を設定
ubyte  set_bounds(lprec *lp, int colnr, double lower, double upper);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_unbounded(lprec *lp, int colnr);
/// colnr番目の変数の制限をなくす
ubyte  set_unbounded(lprec *lp, int colnr);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_unbounded(lprec *lp, int colnr);
/// colnr番目の変数が制限されているかどうか取得する
ubyte  is_unbounded(lprec *lp, int colnr);
/* Set the upper and lower bounds of a variable */

//C     MYBOOL __EXPORT_TYPE __WINAPI set_int(lprec *lp, int colnr, MYBOOL must_be_int);
ubyte  set_int(lprec *lp, int colnr, ubyte must_be_int);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_int(lprec *lp, int colnr);
ubyte  is_int(lprec *lp, int colnr);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_binary(lprec *lp, int colnr, MYBOOL must_be_bin);
ubyte  set_binary(lprec *lp, int colnr, ubyte must_be_bin);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_binary(lprec *lp, int colnr);
ubyte  is_binary(lprec *lp, int colnr);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_semicont(lprec *lp, int colnr, MYBOOL must_be_sc);
ubyte  set_semicont(lprec *lp, int colnr, ubyte must_be_sc);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_semicont(lprec *lp, int colnr);
ubyte  is_semicont(lprec *lp, int colnr);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_negative(lprec *lp, int colnr);
ubyte  is_negative(lprec *lp, int colnr);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_var_weights(lprec *lp, REAL *weights);
ubyte  set_var_weights(lprec *lp, double *weights);
//C     int __EXPORT_TYPE __WINAPI get_var_priority(lprec *lp, int colnr);
int  get_var_priority(lprec *lp, int colnr);
/* Set the type of variable */

//C     MYBOOL __EXPORT_TYPE __WINAPI set_pseudocosts(lprec *lp, REAL *clower, REAL *cupper, int *updatelimit);
ubyte  set_pseudocosts(lprec *lp, double *clower, double *cupper, int *updatelimit);
//C     MYBOOL __EXPORT_TYPE __WINAPI get_pseudocosts(lprec *lp, REAL *clower, REAL *cupper, int *updatelimit);
ubyte  get_pseudocosts(lprec *lp, double *clower, double *cupper, int *updatelimit);
/* Set initial values for, or get computed pseudocost vectors;
   note that setting of pseudocosts can only happen in response to a
   call-back function optionally requesting this */

//C     int  __EXPORT_TYPE __WINAPI add_SOS(lprec *lp, char *name, int sostype, int priority, int count, int *sosvars, REAL *weights);
int  add_SOS(lprec *lp, char *name, int sostype, int priority, int count, int *sosvars, double *weights);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_SOS_var(lprec *lp, int colnr);
ubyte  is_SOS_var(lprec *lp, int colnr);
/* Add SOS constraints */

//C     MYBOOL __EXPORT_TYPE __WINAPI set_row_name(lprec *lp, int rownr, char *new_name);
ubyte  set_row_name(lprec *lp, int rownr, char *new_name);
//C     char __EXPORT_TYPE * __WINAPI get_row_name(lprec *lp, int rownr);
char * get_row_name(lprec *lp, int rownr);
//C     char __EXPORT_TYPE * __WINAPI get_origrow_name(lprec *lp, int rownr);
char * get_origrow_name(lprec *lp, int rownr);
/* Set/Get the name of a constraint row */
   /* Get added by KE */

//C     MYBOOL __EXPORT_TYPE __WINAPI set_col_name(lprec *lp, int colnr, char *new_name);
ubyte  set_col_name(lprec *lp, int colnr, char *new_name);
//C     char __EXPORT_TYPE * __WINAPI get_col_name(lprec *lp, int colnr);
char * get_col_name(lprec *lp, int colnr);
//C     char __EXPORT_TYPE * __WINAPI get_origcol_name(lprec *lp, int colnr);
char * get_origcol_name(lprec *lp, int colnr);
/* Set/Get the name of a variable column */
  /* Get added by KE */

//C     __EXPORT_TYPE void __WINAPI unscale(lprec *lp);
void  unscale(lprec *lp);
/* Undo previous scaling of the problem */

//C     __EXPORT_TYPE void __WINAPI set_preferdual(lprec *lp, MYBOOL dodual);
void  set_preferdual(lprec *lp, ubyte dodual);
//C     __EXPORT_TYPE void __WINAPI set_simplextype(lprec *lp, int simplextype);
void  set_simplextype(lprec *lp, int simplextype);
//C     __EXPORT_TYPE int __WINAPI get_simplextype(lprec *lp);
int  get_simplextype(lprec *lp);
/* Set/Get if lp_solve should prefer the dual simplex over the primal -- added by KE */

//C     __EXPORT_TYPE void __WINAPI default_basis(lprec *lp);
void  default_basis(lprec *lp);
//C     __EXPORT_TYPE void __WINAPI set_basiscrash(lprec *lp, int mode);
void  set_basiscrash(lprec *lp, int mode);
//C     __EXPORT_TYPE int __WINAPI get_basiscrash(lprec *lp);
int  get_basiscrash(lprec *lp);
//C     __EXPORT_TYPE int __WINAPI set_basisvar(lprec *lp, int basisPos, int enteringCol);
int  set_basisvar(lprec *lp, int basisPos, int enteringCol);
//C     __EXPORT_TYPE MYBOOL __WINAPI set_basis(lprec *lp, int *bascolumn, MYBOOL nonbasic);
ubyte  set_basis(lprec *lp, int *bascolumn, ubyte nonbasic);
//C     __EXPORT_TYPE MYBOOL __WINAPI get_basis(lprec *lp, int *bascolumn, MYBOOL nonbasic);
ubyte  get_basis(lprec *lp, int *bascolumn, ubyte nonbasic);
//C     __EXPORT_TYPE void __WINAPI reset_basis(lprec *lp);
void  reset_basis(lprec *lp);
/* Set/Get basis for a re-solved system */
  /* Added by KE */
//C     __EXPORT_TYPE MYBOOL __WINAPI guess_basis(lprec *lp, REAL *guessvector, int *basisvector);
ubyte  guess_basis(lprec *lp, double *guessvector, int *basisvector);

//C     __EXPORT_TYPE MYBOOL __WINAPI is_feasible(lprec *lp, REAL *values, REAL threshold);
ubyte  is_feasible(lprec *lp, double *values, double threshold);
/* returns TRUE if the vector in values is a feasible solution to the lp */

//C     __EXPORT_TYPE int __WINAPI solve(lprec *lp);
int  solve(lprec *lp);
/* Solve the problem */

//C     __EXPORT_TYPE REAL __WINAPI time_elapsed(lprec *lp);
double  time_elapsed(lprec *lp);
/* Return the number of seconds since start of solution process */

//C     __EXPORT_TYPE void __WINAPI put_bb_nodefunc(lprec *lp, lphandleint_intfunc newnode, void *bbnodehandle);
void  put_bb_nodefunc(lprec *lp, int  function(lprec *lp, void *userhandle, int message)newnode, void *bbnodehandle);
//C     __EXPORT_TYPE void __WINAPI put_bb_branchfunc(lprec *lp, lphandleint_intfunc newbranch, void *bbbranchhandle);
void  put_bb_branchfunc(lprec *lp, int  function(lprec *lp, void *userhandle, int message)newbranch, void *bbbranchhandle);
/* Allow the user to override B&B node and branching decisions */

//C     __EXPORT_TYPE void __WINAPI put_abortfunc(lprec *lp, lphandle_intfunc newctrlc, void *ctrlchandle);
void  put_abortfunc(lprec *lp, int  function(lprec *lp, void *userhandle)newctrlc, void *ctrlchandle);
/* Allow the user to define an interruption callback function */

//C     __EXPORT_TYPE void __WINAPI put_logfunc(lprec *lp, lphandlestr_func newlog, void *loghandle);
void  put_logfunc(lprec *lp, void  function(lprec *lp, void *userhandle, char *buf)newlog, void *loghandle);
/* Allow the user to define a logging function */

//C     void __EXPORT_TYPE __WINAPI put_msgfunc(lprec *lp, lphandleint_func newmsg, void *msghandle, int mask);
void  put_msgfunc(lprec *lp, void  function(lprec *lp, void *userhandle, int message)newmsg, void *msghandle, int mask);
/* Allow the user to define an event-driven message/reporting */

//C     __EXPORT_TYPE MYBOOL __WINAPI get_primal_solution(lprec *lp, REAL *pv);
ubyte  get_primal_solution(lprec *lp, double *pv);
//C     __EXPORT_TYPE MYBOOL __WINAPI get_ptr_primal_solution(lprec *lp, REAL **pv);
ubyte  get_ptr_primal_solution(lprec *lp, double **pv);
//C     __EXPORT_TYPE MYBOOL __WINAPI get_dual_solution(lprec *lp, REAL *rc);
ubyte  get_dual_solution(lprec *lp, double *rc);
//C     __EXPORT_TYPE MYBOOL __WINAPI get_ptr_dual_solution(lprec *lp, REAL **rc);
ubyte  get_ptr_dual_solution(lprec *lp, double **rc);
//C     __EXPORT_TYPE MYBOOL __WINAPI get_lambda(lprec *lp, REAL *lambda);
ubyte  get_lambda(lprec *lp, double *lambda);
//C     __EXPORT_TYPE MYBOOL __WINAPI get_ptr_lambda(lprec *lp, REAL **lambda);
ubyte  get_ptr_lambda(lprec *lp, double **lambda);
/* Get the primal, dual/reduced costs and Lambda vectors */

/* Read an MPS file */
//C     lprec __EXPORT_TYPE * __WINAPI read_MPS(char *filename, int options);
lprec * read_MPS(char *filename, int options);
//C     lprec __EXPORT_TYPE * __WINAPI read_mps(FILE *filename, int options);
lprec * read_mps(FILE *filename, int options);
//C     lprec __EXPORT_TYPE * __WINAPI read_freeMPS(char *filename, int options);
lprec * read_freeMPS(char *filename, int options);
//C     lprec __EXPORT_TYPE * __WINAPI read_freemps(FILE *filename, int options);
lprec * read_freemps(FILE *filename, int options);

/* Write a MPS file to output */
//C     MYBOOL __EXPORT_TYPE __WINAPI write_mps(lprec *lp, char *filename);
ubyte  write_mps(lprec *lp, char *filename);
//C     MYBOOL __EXPORT_TYPE __WINAPI write_MPS(lprec *lp, FILE *output);
ubyte  write_MPS(lprec *lp, FILE *output);
//C     MYBOOL __EXPORT_TYPE __WINAPI write_freemps(lprec *lp, char *filename);
ubyte  write_freemps(lprec *lp, char *filename);
//C     MYBOOL __EXPORT_TYPE __WINAPI write_freeMPS(lprec *lp, FILE *output);
ubyte  write_freeMPS(lprec *lp, FILE *output);

//C     MYBOOL __EXPORT_TYPE __WINAPI write_lp(lprec *lp, char *filename);
ubyte  write_lp(lprec *lp, char *filename);
//C     MYBOOL __EXPORT_TYPE __WINAPI write_LP(lprec *lp, FILE *output);
ubyte  write_LP(lprec *lp, FILE *output);
 /* Write a LP file to output */

//C     MYBOOL __WINAPI LP_readhandle(lprec **lp, FILE *filename, int verbose, char *lp_name);
ubyte  LP_readhandle(lprec **lp, FILE *filename, int verbose, char *lp_name);
//C     lprec __EXPORT_TYPE * __WINAPI read_lp(FILE *filename, int verbose, char *lp_name);
lprec * read_lp(FILE *filename, int verbose, char *lp_name);
//C     lprec __EXPORT_TYPE * __WINAPI read_LP(char *filename, int verbose, char *lp_name);
lprec * read_LP(char *filename, int verbose, char *lp_name);
/* Old-style lp format file parser */

//C     MYBOOL __EXPORT_TYPE __WINAPI write_basis(lprec *lp, char *filename);
ubyte  write_basis(lprec *lp, char *filename);
//C     MYBOOL __EXPORT_TYPE __WINAPI read_basis(lprec *lp, char *filename, char *info);
ubyte  read_basis(lprec *lp, char *filename, char *info);
/* Read and write basis from/to file in CPLEX BAS format */

//C     MYBOOL __EXPORT_TYPE __WINAPI write_params(lprec *lp, char *filename, char *options);
ubyte  write_params(lprec *lp, char *filename, char *options);
//C     MYBOOL __EXPORT_TYPE __WINAPI read_params(lprec *lp, char *filename, char *options);
ubyte  read_params(lprec *lp, char *filename, char *options);
//C     void __EXPORT_TYPE __WINAPI reset_params(lprec *lp);
void  reset_params(lprec *lp);
/* Read and write parameter file */

//C     void __EXPORT_TYPE __WINAPI print_lp(lprec *lp);
void  print_lp(lprec *lp);
//C     void __EXPORT_TYPE __WINAPI print_tableau(lprec *lp);
void  print_tableau(lprec *lp);
/* Print the current problem, only useful in very small (test) problems */

//C     void __EXPORT_TYPE __WINAPI print_objective(lprec *lp);
void  print_objective(lprec *lp);
//C     void __EXPORT_TYPE __WINAPI print_solution(lprec *lp, int columns);
void  print_solution(lprec *lp, int columns);
//C     void __EXPORT_TYPE __WINAPI print_constraints(lprec *lp, int columns);
void  print_constraints(lprec *lp, int columns);
/* Print the solution to stdout */

//C     void __EXPORT_TYPE __WINAPI print_duals(lprec *lp);
void  print_duals(lprec *lp);
/* Print the dual variables of the solution */

//C     void __EXPORT_TYPE __WINAPI print_scales(lprec *lp);
void  print_scales(lprec *lp);
/* If scaling is used, print the scaling factors */

//C     void __EXPORT_TYPE __WINAPI print_str(lprec *lp, char *str);
void  print_str(lprec *lp, char *str);

//C     void __EXPORT_TYPE __WINAPI set_outputstream(lprec *lp, FILE *stream);
void  set_outputstream(lprec *lp, FILE *stream);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_outputfile(lprec *lp, char *filename);
ubyte  set_outputfile(lprec *lp, char *filename);

//C     void __EXPORT_TYPE __WINAPI set_verbose(lprec *lp, int verbose);
void  set_verbose(lprec *lp, int verbose);
//C     int __EXPORT_TYPE __WINAPI get_verbose(lprec *lp);
int  get_verbose(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_timeout(lprec *lp, long sectimeout);
void  set_timeout(lprec *lp, int sectimeout);
//C     long __EXPORT_TYPE __WINAPI get_timeout(lprec *lp);
int  get_timeout(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_print_sol(lprec *lp, int print_sol);
void  set_print_sol(lprec *lp, int print_sol);
//C     int __EXPORT_TYPE __WINAPI get_print_sol(lprec *lp);
int  get_print_sol(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_debug(lprec *lp, MYBOOL debug);
void  set_debug(lprec *lp, ubyte debug_);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_debug(lprec *lp);
ubyte  is_debug(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_trace(lprec *lp, MYBOOL trace);
void  set_trace(lprec *lp, ubyte trace);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_trace(lprec *lp);
ubyte  is_trace(lprec *lp);

//C     MYBOOL __EXPORT_TYPE __WINAPI print_debugdump(lprec *lp, char *filename);
ubyte  print_debugdump(lprec *lp, char *filename);

//C     void __EXPORT_TYPE __WINAPI set_anti_degen(lprec *lp, int anti_degen);
void  set_anti_degen(lprec *lp, int anti_degen);
//C     int __EXPORT_TYPE __WINAPI get_anti_degen(lprec *lp);
int  get_anti_degen(lprec *lp);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_anti_degen(lprec *lp, int testmask);
ubyte  is_anti_degen(lprec *lp, int testmask);

//C     void __EXPORT_TYPE __WINAPI set_presolve(lprec *lp, int presolvemode, int maxloops);
void  set_presolve(lprec *lp, int presolvemode, int maxloops);
//C     int __EXPORT_TYPE __WINAPI get_presolve(lprec *lp);
int  get_presolve(lprec *lp);
//C     int __EXPORT_TYPE __WINAPI get_presolveloops(lprec *lp);
int  get_presolveloops(lprec *lp);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_presolve(lprec *lp, int testmask);
ubyte  is_presolve(lprec *lp, int testmask);

//C     int __EXPORT_TYPE __WINAPI get_orig_index(lprec *lp, int lp_index);
int  get_orig_index(lprec *lp, int lp_index);
//C     int __EXPORT_TYPE __WINAPI get_lp_index(lprec *lp, int orig_index);
int  get_lp_index(lprec *lp, int orig_index);

//C     void __EXPORT_TYPE __WINAPI set_maxpivot(lprec *lp, int max_num_inv);
void  set_maxpivot(lprec *lp, int max_num_inv);
//C     int __EXPORT_TYPE __WINAPI get_maxpivot(lprec *lp);
int  get_maxpivot(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_obj_bound(lprec *lp, REAL obj_bound);
void  set_obj_bound(lprec *lp, double obj_bound);
//C     REAL __EXPORT_TYPE __WINAPI get_obj_bound(lprec *lp);
double  get_obj_bound(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_mip_gap(lprec *lp, MYBOOL absolute, REAL mip_gap);
void  set_mip_gap(lprec *lp, ubyte absolute, double mip_gap);
//C     REAL __EXPORT_TYPE __WINAPI get_mip_gap(lprec *lp, MYBOOL absolute);
double  get_mip_gap(lprec *lp, ubyte absolute);

//C     void __EXPORT_TYPE __WINAPI set_bb_rule(lprec *lp, int bb_rule);
void  set_bb_rule(lprec *lp, int bb_rule);
//C     int __EXPORT_TYPE __WINAPI get_bb_rule(lprec *lp);
int  get_bb_rule(lprec *lp);

//C     MYBOOL __EXPORT_TYPE __WINAPI set_var_branch(lprec *lp, int colnr, int branch_mode);
ubyte  set_var_branch(lprec *lp, int colnr, int branch_mode);
//C     int __EXPORT_TYPE __WINAPI get_var_branch(lprec *lp, int colnr);
int  get_var_branch(lprec *lp, int colnr);

//C     MYBOOL __EXPORT_TYPE __WINAPI is_infinite(lprec *lp, REAL value);
ubyte  is_infinite(lprec *lp, double value);
//C     void __EXPORT_TYPE __WINAPI set_infinite(lprec *lp, REAL infinite);
void  set_infinite(lprec *lp, double infinite);
//C     REAL __EXPORT_TYPE __WINAPI get_infinite(lprec *lp);
double  get_infinite(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_epsint(lprec *lp, REAL epsint);
void  set_epsint(lprec *lp, double epsint);
//C     REAL __EXPORT_TYPE __WINAPI get_epsint(lprec *lp);
double  get_epsint(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_epsb(lprec *lp, REAL epsb);
void  set_epsb(lprec *lp, double epsb);
//C     REAL __EXPORT_TYPE __WINAPI get_epsb(lprec *lp);
double  get_epsb(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_epsd(lprec *lp, REAL epsd);
void  set_epsd(lprec *lp, double epsd);
//C     REAL __EXPORT_TYPE __WINAPI get_epsd(lprec *lp);
double  get_epsd(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_epsel(lprec *lp, REAL epsel);
void  set_epsel(lprec *lp, double epsel);
//C     REAL __EXPORT_TYPE __WINAPI get_epsel(lprec *lp);
double  get_epsel(lprec *lp);

//C     MYBOOL __EXPORT_TYPE __WINAPI set_epslevel(lprec *lp, int epslevel);
ubyte  set_epslevel(lprec *lp, int epslevel);

//C     void __EXPORT_TYPE __WINAPI set_scaling(lprec *lp, int scalemode);
void  set_scaling(lprec *lp, int scalemode);
//C     int __EXPORT_TYPE __WINAPI get_scaling(lprec *lp);
int  get_scaling(lprec *lp);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_scalemode(lprec *lp, int testmask);
ubyte  is_scalemode(lprec *lp, int testmask);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_scaletype(lprec *lp, int scaletype);
ubyte  is_scaletype(lprec *lp, int scaletype);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_integerscaling(lprec *lp);
ubyte  is_integerscaling(lprec *lp);
//C     void __EXPORT_TYPE __WINAPI set_scalelimit(lprec *lp, REAL scalelimit);
void  set_scalelimit(lprec *lp, double scalelimit);
//C     REAL __EXPORT_TYPE __WINAPI get_scalelimit(lprec *lp);
double  get_scalelimit(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_improve(lprec *lp, int improve);
void  set_improve(lprec *lp, int improve);
//C     int __EXPORT_TYPE __WINAPI get_improve(lprec *lp);
int  get_improve(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_pivoting(lprec *lp, int piv_rule);
void  set_pivoting(lprec *lp, int piv_rule);
//C     int __EXPORT_TYPE __WINAPI get_pivoting(lprec *lp);
int  get_pivoting(lprec *lp);
//C     MYBOOL __EXPORT_TYPE __WINAPI set_partialprice(lprec *lp, int blockcount, int *blockstart, MYBOOL isrow);
ubyte  set_partialprice(lprec *lp, int blockcount, int *blockstart, ubyte isrow);
//C     void __EXPORT_TYPE __WINAPI get_partialprice(lprec *lp, int *blockcount, int *blockstart, MYBOOL isrow);
void  get_partialprice(lprec *lp, int *blockcount, int *blockstart, ubyte isrow);

//C     MYBOOL __EXPORT_TYPE __WINAPI set_multiprice(lprec *lp, int multiblockdiv);
ubyte  set_multiprice(lprec *lp, int multiblockdiv);
//C     int __EXPORT_TYPE __WINAPI get_multiprice(lprec *lp, MYBOOL getabssize);
int  get_multiprice(lprec *lp, ubyte getabssize);

//C     MYBOOL __EXPORT_TYPE __WINAPI is_use_names(lprec *lp, MYBOOL isrow);
ubyte  is_use_names(lprec *lp, ubyte isrow);
//C     void __EXPORT_TYPE __WINAPI set_use_names(lprec *lp, MYBOOL isrow, MYBOOL use_names);
void  set_use_names(lprec *lp, ubyte isrow, ubyte use_names);

//C     int __EXPORT_TYPE __WINAPI get_nameindex(lprec *lp, char *varname, MYBOOL isrow);
int  get_nameindex(lprec *lp, char *varname, ubyte isrow);

//C     MYBOOL __EXPORT_TYPE __WINAPI is_piv_mode(lprec *lp, int testmask);
ubyte  is_piv_mode(lprec *lp, int testmask);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_piv_rule(lprec *lp, int rule);
ubyte  is_piv_rule(lprec *lp, int rule);

//C     void __EXPORT_TYPE __WINAPI set_break_at_first(lprec *lp, MYBOOL break_at_first);
void  set_break_at_first(lprec *lp, ubyte break_at_first);
//C     MYBOOL __EXPORT_TYPE __WINAPI is_break_at_first(lprec *lp);
ubyte  is_break_at_first(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_bb_floorfirst(lprec *lp, int bb_floorfirst);
void  set_bb_floorfirst(lprec *lp, int bb_floorfirst);
//C     int __EXPORT_TYPE __WINAPI get_bb_floorfirst(lprec *lp);
int  get_bb_floorfirst(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_bb_depthlimit(lprec *lp, int bb_maxlevel);
void  set_bb_depthlimit(lprec *lp, int bb_maxlevel);
//C     int __EXPORT_TYPE __WINAPI get_bb_depthlimit(lprec *lp);
int  get_bb_depthlimit(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_break_at_value(lprec *lp, REAL break_at_value);
void  set_break_at_value(lprec *lp, double break_at_value);
//C     REAL __EXPORT_TYPE __WINAPI get_break_at_value(lprec *lp);
double  get_break_at_value(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_negrange(lprec *lp, REAL negrange);
void  set_negrange(lprec *lp, double negrange);
//C     REAL __EXPORT_TYPE __WINAPI get_negrange(lprec *lp);
double  get_negrange(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_epsperturb(lprec *lp, REAL epsperturb);
void  set_epsperturb(lprec *lp, double epsperturb);
//C     REAL __EXPORT_TYPE __WINAPI get_epsperturb(lprec *lp);
double  get_epsperturb(lprec *lp);

//C     void __EXPORT_TYPE __WINAPI set_epspivot(lprec *lp, REAL epspivot);
void  set_epspivot(lprec *lp, double epspivot);
//C     REAL __EXPORT_TYPE __WINAPI get_epspivot(lprec *lp);
double  get_epspivot(lprec *lp);

//C     int __EXPORT_TYPE __WINAPI get_max_level(lprec *lp);
int  get_max_level(lprec *lp);
//C     COUNTER __EXPORT_TYPE __WINAPI get_total_nodes(lprec *lp);
long  get_total_nodes(lprec *lp);
//C     COUNTER __EXPORT_TYPE __WINAPI get_total_iter(lprec *lp);
long  get_total_iter(lprec *lp);

//C     REAL __EXPORT_TYPE __WINAPI get_objective(lprec *lp);
double  get_objective(lprec *lp);
//C     REAL __EXPORT_TYPE __WINAPI get_working_objective(lprec *lp);
double  get_working_objective(lprec *lp);

//C     REAL __EXPORT_TYPE __WINAPI get_var_primalresult(lprec *lp, int index);
double  get_var_primalresult(lprec *lp, int index);
//C     REAL __EXPORT_TYPE __WINAPI get_var_dualresult(lprec *lp, int index);
double  get_var_dualresult(lprec *lp, int index);

//C     MYBOOL __EXPORT_TYPE __WINAPI get_variables(lprec *lp, REAL *var);
ubyte  get_variables(lprec *lp, double *var);
//C     MYBOOL __EXPORT_TYPE __WINAPI get_ptr_variables(lprec *lp, REAL **var);
ubyte  get_ptr_variables(lprec *lp, double **var);

//C     MYBOOL __EXPORT_TYPE __WINAPI get_constraints(lprec *lp, REAL *constr);
ubyte  get_constraints(lprec *lp, double *constr);
//C     MYBOOL __EXPORT_TYPE __WINAPI get_ptr_constraints(lprec *lp, REAL **constr);
ubyte  get_ptr_constraints(lprec *lp, double **constr);

//C     MYBOOL __EXPORT_TYPE __WINAPI get_sensitivity_rhs(lprec *lp, REAL *duals, REAL *dualsfrom, REAL *dualstill);
ubyte  get_sensitivity_rhs(lprec *lp, double *duals, double *dualsfrom, double *dualstill);
//C     MYBOOL __EXPORT_TYPE __WINAPI get_ptr_sensitivity_rhs(lprec *lp, REAL **duals, REAL **dualsfrom, REAL **dualstill);
ubyte  get_ptr_sensitivity_rhs(lprec *lp, double **duals, double **dualsfrom, double **dualstill);

//C     MYBOOL __EXPORT_TYPE __WINAPI get_sensitivity_obj(lprec *lp, REAL *objfrom, REAL *objtill);
ubyte  get_sensitivity_obj(lprec *lp, double *objfrom, double *objtill);
//C     MYBOOL __EXPORT_TYPE __WINAPI get_sensitivity_objex(lprec *lp, REAL *objfrom, REAL *objtill, REAL *objfromvalue, REAL *objtillvalue);
ubyte  get_sensitivity_objex(lprec *lp, double *objfrom, double *objtill, double *objfromvalue, double *objtillvalue);
//C     MYBOOL __EXPORT_TYPE __WINAPI get_ptr_sensitivity_obj(lprec *lp, REAL **objfrom, REAL **objtill);
ubyte  get_ptr_sensitivity_obj(lprec *lp, double **objfrom, double **objtill);
//C     MYBOOL __EXPORT_TYPE __WINAPI get_ptr_sensitivity_objex(lprec *lp, REAL **objfrom, REAL **objtill, REAL **objfromvalue, REAL **objtillvalue);
ubyte  get_ptr_sensitivity_objex(lprec *lp, double **objfrom, double **objtill, double **objfromvalue, double **objtillvalue);

//C     void __EXPORT_TYPE __WINAPI set_solutionlimit(lprec *lp, int limit);
void  set_solutionlimit(lprec *lp, int limit);
//C     int __EXPORT_TYPE __WINAPI get_solutionlimit(lprec *lp);
int  get_solutionlimit(lprec *lp);
//C     int __EXPORT_TYPE __WINAPI get_solutioncount(lprec *lp);
int  get_solutioncount(lprec *lp);

//C     int __EXPORT_TYPE __WINAPI get_Norig_rows(lprec *lp);
int  get_Norig_rows(lprec *lp);
//C     int __EXPORT_TYPE __WINAPI get_Nrows(lprec *lp);
int  get_Nrows(lprec *lp);
//C     int __EXPORT_TYPE __WINAPI get_Lrows(lprec *lp);
int  get_Lrows(lprec *lp);

//C     int __EXPORT_TYPE __WINAPI get_Norig_columns(lprec *lp);
int  get_Norig_columns(lprec *lp);
//C     int __EXPORT_TYPE __WINAPI get_Ncolumns(lprec *lp);
int  get_Ncolumns(lprec *lp);

//C     typedef int (__WINAPI read_modeldata_func)(void *userhandle, char *buf, int max_size);
extern (C):
alias int function(void *userhandle, char *buf, int max_size)read_modeldata_func;
//C     typedef int (__WINAPI write_modeldata_func)(void *userhandle, char *buf);
alias int function(void *userhandle, char *buf)write_modeldata_func;
//C     MYBOOL __WINAPI MPS_readex(lprec **newlp, void *userhandle, read_modeldata_func read_modeldata, int typeMPS, int options);
extern (C):
ubyte  MPS_readex(lprec **newlp, void *userhandle, int  function(void *userhandle, char *buf, int max_size)read_modeldata, int typeMPS, int options);

/* #if defined develop */
//C     lprec __EXPORT_TYPE * __WINAPI read_lpex(void *userhandle, read_modeldata_func read_modeldata, int verbose, char *lp_name);
lprec * read_lpex(void *userhandle, int  function(void *userhandle, char *buf, int max_size)read_modeldata, int verbose, char *lp_name);
//C     MYBOOL __EXPORT_TYPE __WINAPI write_lpex(lprec *lp, void *userhandle, write_modeldata_func write_modeldata);
ubyte  write_lpex(lprec *lp, void *userhandle, int  function(void *userhandle, char *buf)write_modeldata);

//C     lprec __EXPORT_TYPE * __WINAPI read_mpsex(void *userhandle, read_modeldata_func read_modeldata, int options);
lprec * read_mpsex(void *userhandle, int  function(void *userhandle, char *buf, int max_size)read_modeldata, int options);
//C     lprec __EXPORT_TYPE * __WINAPI read_freempsex(void *userhandle, read_modeldata_func read_modeldata, int options);
lprec * read_freempsex(void *userhandle, int  function(void *userhandle, char *buf, int max_size)read_modeldata, int options);

//C     MYBOOL __EXPORT_TYPE __WINAPI MPS_writefileex(lprec *lp, int typeMPS, void *userhandle, write_modeldata_func write_modeldata);
ubyte  MPS_writefileex(lprec *lp, int typeMPS, void *userhandle, int  function(void *userhandle, char *buf)write_modeldata);
/* #endif */

//C     #ifdef __cplusplus
//C     }
//C     #endif


/* Forward definitions of functions used internaly by the lp toolkit */
//C     MYBOOL set_callbacks(lprec *lp);
extern (C):
ubyte  set_callbacks(lprec *lp);
//C     STATIC int yieldformessages(lprec *lp);
int  yieldformessages(lprec *lp);
//C     MYBOOL __WINAPI userabort(lprec *lp, int message);
extern (C):
ubyte  userabort(lprec *lp, int message);
/*char * __VACALL explain(lprec *lp, char *format, ...);
void __VACALL report(lprec *lp, int level, char *format, ...);*/

/* Memory management routines */
//C     STATIC MYBOOL append_rows(lprec *lp, int deltarows);
extern (C):
ubyte  append_rows(lprec *lp, int deltarows);
//C     STATIC MYBOOL append_columns(lprec *lp, int deltacolumns);
ubyte  append_columns(lprec *lp, int deltacolumns);
//C     STATIC void inc_rows(lprec *lp, int delta);
void  inc_rows(lprec *lp, int delta);
//C     STATIC void inc_columns(lprec *lp, int delta);
void  inc_columns(lprec *lp, int delta);
//C     STATIC MYBOOL init_rowcol_names(lprec *lp);
ubyte  init_rowcol_names(lprec *lp);
//C     STATIC MYBOOL inc_row_space(lprec *lp, int deltarows);
ubyte  inc_row_space(lprec *lp, int deltarows);
//C     STATIC MYBOOL inc_col_space(lprec *lp, int deltacols);
ubyte  inc_col_space(lprec *lp, int deltacols);
//C     STATIC MYBOOL shift_rowcoldata(lprec *lp, int base, int delta, LLrec *usedmap, MYBOOL isrow);
ubyte  shift_rowcoldata(lprec *lp, int base, int delta, LLrec *usedmap, ubyte isrow);
//C     STATIC MYBOOL shift_basis(lprec *lp, int base, int delta, LLrec *usedmap, MYBOOL isrow);
ubyte  shift_basis(lprec *lp, int base, int delta, LLrec *usedmap, ubyte isrow);
//C     STATIC MYBOOL shift_rowdata(lprec *lp, int base, int delta, LLrec *usedmap);
ubyte  shift_rowdata(lprec *lp, int base, int delta, LLrec *usedmap);
//C     STATIC MYBOOL shift_coldata(lprec *lp, int base, int delta, LLrec *usedmap);
ubyte  shift_coldata(lprec *lp, int base, int delta, LLrec *usedmap);

/* INLINE */
//C      MYBOOL is_chsign(lprec *lp, int rownr);
ubyte  is_chsign(lprec *lp, int rownr);

//C     STATIC MYBOOL inc_lag_space(lprec *lp, int deltarows, MYBOOL ignoreMAT);
ubyte  inc_lag_space(lprec *lp, int deltarows, ubyte ignoreMAT);
//C     lprec *make_lag(lprec *server);
lprec * make_lag(lprec *server);

//C     REAL get_rh_upper(lprec *lp, int rownr);
double  get_rh_upper(lprec *lp, int rownr);
//C     REAL get_rh_lower(lprec *lp, int rownr);
double  get_rh_lower(lprec *lp, int rownr);
//C     MYBOOL set_rh_upper(lprec *lp, int rownr, REAL value);
ubyte  set_rh_upper(lprec *lp, int rownr, double value);
//C     MYBOOL set_rh_lower(lprec *lp, int rownr, REAL value);
ubyte  set_rh_lower(lprec *lp, int rownr, double value);
//C     STATIC int bin_count(lprec *lp, MYBOOL working);
int  bin_count(lprec *lp, ubyte working);
//C     STATIC int MIP_count(lprec *lp);
int  MIP_count(lprec *lp);
//C     STATIC int SOS_count(lprec *lp);
int  SOS_count(lprec *lp);
//C     STATIC int GUB_count(lprec *lp);
int  GUB_count(lprec *lp);
//C     STATIC int identify_GUB(lprec *lp, MYBOOL mark);
int  identify_GUB(lprec *lp, ubyte mark);
//C     STATIC int prepare_GUB(lprec *lp);
int  prepare_GUB(lprec *lp);

//C     STATIC MYBOOL refactRecent(lprec *lp);
ubyte  refactRecent(lprec *lp);
//C     STATIC MYBOOL check_if_less(lprec *lp, REAL x, REAL y, int variable);
ubyte  check_if_less(lprec *lp, double x, double y, int variable);
//C     STATIC MYBOOL feasiblePhase1(lprec *lp, REAL epsvalue);
ubyte  feasiblePhase1(lprec *lp, double epsvalue);
//C     STATIC void free_duals(lprec *lp);
void  free_duals(lprec *lp);
//C     STATIC void initialize_solution(lprec *lp, MYBOOL shiftbounds);
void  initialize_solution(lprec *lp, ubyte shiftbounds);
//C     STATIC void recompute_solution(lprec *lp, MYBOOL shiftbounds);
void  recompute_solution(lprec *lp, ubyte shiftbounds);
//C     STATIC int verify_solution(lprec *lp, MYBOOL reinvert, char *info);
int  verify_solution(lprec *lp, ubyte reinvert, char *info);
//C     STATIC int check_solution(lprec *lp, int  lastcolumn, REAL *solution,
//C                               REAL *upbo, REAL *lowbo, REAL tolerance);
int  check_solution(lprec *lp, int lastcolumn, double *solution, double *upbo, double *lowbo, double tolerance);
/* INLINE */
//C      MYBOOL is_fixedvar(lprec *lp, int variable);
ubyte  is_fixedvar(lprec *lp, int variable);
/* INLINE */
//C      MYBOOL is_splitvar(lprec *lp, int colnr);
ubyte  is_splitvar(lprec *lp, int colnr);

//C     void   __WINAPI set_action(int *actionvar, int actionmask);
extern (C):
void  set_action(int *actionvar, int actionmask);
//C     void   __WINAPI clear_action(int *actionvar, int actionmask);
void  clear_action(int *actionvar, int actionmask);
//C     MYBOOL __WINAPI is_action(int actionvar, int testmask);
ubyte  is_action(int actionvar, int testmask);

/* INLINE */
//C      MYBOOL is_bb_rule(lprec *lp, int bb_rule);
extern (C):
ubyte  is_bb_rule(lprec *lp, int bb_rule);
/* INLINE */
//C      MYBOOL is_bb_mode(lprec *lp, int bb_mask);
ubyte  is_bb_mode(lprec *lp, int bb_mask);
/* INLINE */
//C      int get_piv_rule(lprec *lp);
int  get_piv_rule(lprec *lp);
//C     STATIC char *get_str_piv_rule(int rule);
char * get_str_piv_rule(int rule);
//C     STATIC MYBOOL __WINAPI set_var_priority(lprec *lp);
extern (C):
ubyte  set_var_priority(lprec *lp);
//C     STATIC int find_sc_bbvar(lprec *lp, int *count);
extern (C):
int  find_sc_bbvar(lprec *lp, int *count);
//C     STATIC int find_sos_bbvar(lprec *lp, int *count, MYBOOL intsos);
int  find_sos_bbvar(lprec *lp, int *count, ubyte intsos);
//C     STATIC int find_int_bbvar(lprec *lp, int *count, BBrec *BB, MYBOOL *isfeasible);
int  find_int_bbvar(lprec *lp, int *count, BBrec *BB, ubyte *isfeasible);

/* Solution-related functions */
//C     STATIC REAL compute_dualslacks(lprec *lp, int target, REAL **dvalues, int **nzdvalues, MYBOOL dosum);
double  compute_dualslacks(lprec *lp, int target, double **dvalues, int **nzdvalues, ubyte dosum);
//C     STATIC MYBOOL solution_is_int(lprec *lp, int index, MYBOOL checkfixed);
ubyte  solution_is_int(lprec *lp, int index, ubyte checkfixed);
//C     STATIC MYBOOL bb_better(lprec *lp, int target, int mode);
ubyte  bb_better(lprec *lp, int target, int mode);
//C     STATIC void construct_solution(lprec *lp, REAL *target);
void  construct_solution(lprec *lp, double *target);
//C     STATIC void transfer_solution_var(lprec *lp, int uservar);
void  transfer_solution_var(lprec *lp, int uservar);
//C     STATIC MYBOOL construct_duals(lprec *lp);
ubyte  construct_duals(lprec *lp);
//C     STATIC MYBOOL construct_sensitivity_duals(lprec *lp);
ubyte  construct_sensitivity_duals(lprec *lp);
//C     STATIC MYBOOL construct_sensitivity_obj(lprec *lp);
ubyte  construct_sensitivity_obj(lprec *lp);

//C     STATIC int add_GUB(lprec *lp, char *name, int priority, int count, int *sosvars);
int  add_GUB(lprec *lp, char *name, int priority, int count, int *sosvars);
//C     STATIC basisrec *push_basis(lprec *lp, int *basisvar, MYBOOL *isbasic, MYBOOL *islower);
basisrec * push_basis(lprec *lp, int *basisvar, ubyte *isbasic, ubyte *islower);
//C     STATIC MYBOOL compare_basis(lprec *lp);
ubyte  compare_basis(lprec *lp);
//C     STATIC MYBOOL restore_basis(lprec *lp);
ubyte  restore_basis(lprec *lp);
//C     STATIC MYBOOL pop_basis(lprec *lp, MYBOOL restore);
ubyte  pop_basis(lprec *lp, ubyte restore);
//C     STATIC MYBOOL is_BasisReady(lprec *lp);
ubyte  is_BasisReady(lprec *lp);
//C     STATIC MYBOOL is_slackbasis(lprec *lp);
ubyte  is_slackbasis(lprec *lp);
//C     STATIC MYBOOL verify_basis(lprec *lp);
ubyte  verify_basis(lprec *lp);
//C     STATIC int unload_basis(lprec *lp, MYBOOL restorelast);
int  unload_basis(lprec *lp, ubyte restorelast);

//C     STATIC int perturb_bounds(lprec *lp, BBrec *perturbed, MYBOOL doRows, MYBOOL doCols, MYBOOL includeFIXED);
int  perturb_bounds(lprec *lp, BBrec *perturbed, ubyte doRows, ubyte doCols, ubyte includeFIXED);
//C     STATIC MYBOOL validate_bounds(lprec *lp, REAL *upbo, REAL *lowbo);
ubyte  validate_bounds(lprec *lp, double *upbo, double *lowbo);
//C     STATIC MYBOOL impose_bounds(lprec *lp, REAL * upbo, REAL *lowbo);
ubyte  impose_bounds(lprec *lp, double *upbo, double *lowbo);
//C     STATIC int unload_BB(lprec *lp);
int  unload_BB(lprec *lp);

//C     STATIC REAL feasibilityOffset(lprec *lp, MYBOOL isdual);
double  feasibilityOffset(lprec *lp, ubyte isdual);
//C     STATIC MYBOOL isP1extra(lprec *lp);
ubyte  isP1extra(lprec *lp);
//C     STATIC REAL get_refactfrequency(lprec *lp, MYBOOL final);
double  get_refactfrequency(lprec *lp, ubyte final_);
//C     STATIC int findBasicFixedvar(lprec *lp, int afternr, MYBOOL slacksonly);
int  findBasicFixedvar(lprec *lp, int afternr, ubyte slacksonly);
//C     STATIC MYBOOL isBasisVarFeasible(lprec *lp, REAL tol, int basis_row);
ubyte  isBasisVarFeasible(lprec *lp, double tol, int basis_row);
//C     STATIC MYBOOL isPrimalFeasible(lprec *lp, REAL tol, int infeasibles[], REAL *feasibilitygap);
ubyte  isPrimalFeasible(lprec *lp, double tol, int *infeasibles, double *feasibilitygap);
//C     STATIC MYBOOL isDualFeasible(lprec *lp, REAL tol, int *boundflips, int infeasibles[], REAL *feasibilitygap);
ubyte  isDualFeasible(lprec *lp, double tol, int *boundflips, int *infeasibles, double *feasibilitygap);

/* Main simplex driver routines */
//C     STATIC int preprocess(lprec *lp);
int  preprocess(lprec *lp);
//C     STATIC void postprocess(lprec *lp);
void  postprocess(lprec *lp);
//C     STATIC MYBOOL performiteration(lprec *lp, int rownr, int varin, LREAL theta, MYBOOL primal, MYBOOL allowminit, REAL *prow, int *nzprow, REAL *pcol, int *nzpcol, int *boundswaps);
ubyte  performiteration(lprec *lp, int rownr, int varin, double theta, ubyte primal, ubyte allowminit, double *prow, int *nzprow, double *pcol, int *nzpcol, int *boundswaps);
//C     STATIC void transfer_solution_var(lprec *lp, int uservar);
void  transfer_solution_var(lprec *lp, int uservar);
//C     STATIC void transfer_solution(lprec *lp, MYBOOL dofinal);
void  transfer_solution(lprec *lp, ubyte dofinal);

/* Scaling utilities */
//C     STATIC REAL scaled_floor(lprec *lp, int colnr, REAL value, REAL epsscale);
double  scaled_floor(lprec *lp, int colnr, double value, double epsscale);
//C     STATIC REAL scaled_ceil(lprec *lp, int colnr, REAL value, REAL epsscale);
double  scaled_ceil(lprec *lp, int colnr, double value, double epsscale);

/* Variable mapping utility routines */
//C     STATIC void varmap_lock(lprec *lp);
void  varmap_lock(lprec *lp);
//C     STATIC void varmap_clear(lprec *lp);
void  varmap_clear(lprec *lp);
//C     STATIC MYBOOL varmap_canunlock(lprec *lp);
ubyte  varmap_canunlock(lprec *lp);
//C     STATIC void varmap_addconstraint(lprec *lp);
void  varmap_addconstraint(lprec *lp);
//C     STATIC void varmap_addcolumn(lprec *lp);
void  varmap_addcolumn(lprec *lp);
//C     STATIC void varmap_delete(lprec *lp, int base, int delta, LLrec *varmap);
void  varmap_delete(lprec *lp, int base, int delta, LLrec *varmap);
//C     STATIC void varmap_compact(lprec *lp, int prev_rows, int prev_cols);
void  varmap_compact(lprec *lp, int prev_rows, int prev_cols);
//C     STATIC MYBOOL varmap_validate(lprec *lp, int varno);
ubyte  varmap_validate(lprec *lp, int varno);
/* STATIC MYBOOL del_varnameex(lprec *lp, hashelem **namelist, hashtable *ht, int varnr, LLrec *varmap); */
//C      STATIC MYBOOL del_varnameex(lprec *lp, hashelem **namelist, int items, hashtable *ht, int varnr, LLrec *varmap);
ubyte  del_varnameex(lprec *lp, hashelem **namelist, int items, hashtable *ht, int varnr, LLrec *varmap);

/* Pseudo-cost routines (internal) */
//C     STATIC BBPSrec *init_pseudocost(lprec *lp, int pseudotype);
BBPSrec * init_pseudocost(lprec *lp, int pseudotype);
//C     STATIC void free_pseudocost(lprec *lp);
void  free_pseudocost(lprec *lp);
//C     STATIC REAL get_pseudorange(BBPSrec *pc, int mipvar, int varcode);
double  get_pseudorange(BBPSrec *pc, int mipvar, int varcode);
//C     STATIC void update_pseudocost(BBPSrec *pc, int mipvar, int varcode, MYBOOL capupper, REAL varsol);
void  update_pseudocost(BBPSrec *pc, int mipvar, int varcode, ubyte capupper, double varsol);
//C     STATIC REAL get_pseudobranchcost(BBPSrec *pc, int mipvar, MYBOOL dofloor);
double  get_pseudobranchcost(BBPSrec *pc, int mipvar, ubyte dofloor);
//C     STATIC REAL get_pseudonodecost(BBPSrec *pc, int mipvar, int vartype, REAL varsol);
double  get_pseudonodecost(BBPSrec *pc, int mipvar, int vartype, double varsol);

/* Matrix access and equation solving routines */
//C     STATIC void set_OF_override(lprec *lp, REAL *ofVector);
void  set_OF_override(lprec *lp, double *ofVector);
//C     STATIC void set_OF_p1extra(lprec *lp, REAL p1extra);
void  set_OF_p1extra(lprec *lp, double p1extra);
//C     STATIC void unset_OF_p1extra(lprec *lp);
void  unset_OF_p1extra(lprec *lp);
//C     MYBOOL modifyOF1(lprec *lp, int index, REAL *ofValue, REAL mult);
ubyte  modifyOF1(lprec *lp, int index, double *ofValue, double mult);
//C     REAL __WINAPI get_OF_active(lprec *lp, int varnr, REAL mult);
extern (C):
double  get_OF_active(lprec *lp, int varnr, double mult);
//C     STATIC MYBOOL is_OF_nz(lprec *lp, int colnr);
extern (C):
ubyte  is_OF_nz(lprec *lp, int colnr);

//C     STATIC int get_basisOF(lprec *lp, int coltarget[], REAL crow[], int colno[]);
int  get_basisOF(lprec *lp, int *coltarget, double *crow, int *colno);
//C     int    __WINAPI get_basiscolumn(lprec *lp, int j, int rn[], double bj[]);
extern (C):
int  get_basiscolumn(lprec *lp, int j, int *rn, double *bj);
//C     int    __WINAPI obtain_column(lprec *lp, int varin, REAL *pcol, int *nzlist, int *maxabs);
int  obtain_column(lprec *lp, int varin, double *pcol, int *nzlist, int *maxabs);
//C     STATIC int compute_theta(lprec *lp, int rownr, LREAL *theta, int isupbound, REAL HarrisScalar, MYBOOL primal);
extern (C):
int  compute_theta(lprec *lp, int rownr, double *theta, int isupbound, double HarrisScalar, ubyte primal);

/* Pivot utility routines */
//C     STATIC int findBasisPos(lprec *lp, int notint, int *var_basic);
int  findBasisPos(lprec *lp, int notint, int *var_basic);
//C     STATIC MYBOOL check_degeneracy(lprec *lp, REAL *pcol, int *degencount);
ubyte  check_degeneracy(lprec *lp, double *pcol, int *degencount);

//C     #endif /* HEADER_lp_lib */
