/* Converted to D from chipmunk.h by htod */
module chipmunk4.chipmunk;
/* Copyright (c) 2007 Scott Lembcke
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

//C     #ifndef CHIPMUNK_HEADER
//C     #define CHIPMUNK_HEADER

//C     #ifdef __cplusplus
//C     extern "C" {
//C     #endif
	
//C     typedef double cpFloat;
alias double cpFloat;
	
     static cpFloat
     cpfmax(cpFloat a, cpFloat b)
     {
     	return (a > b) ? a : b;
     }

     static cpFloat
     cpfmin(cpFloat a, cpFloat b)
     {
     	return (a < b) ? a : b;
     }

//C     static inline cpFloat
//C     cpfclamp(cpFloat f, cpFloat min, cpFloat max){
//C     	return cpfmin(cpfmax(f, min), max);
//C     }

//C     #ifndef INFINITY
//C     	#ifdef _MSC_VER
//C     		union MSVC_EVIL_FLOAT_HACK
//C     		{
//C     			unsigned __int8 Bytes[4];
//C     			float Value;
//C     		};
//C     		static union MSVC_EVIL_FLOAT_HACK INFINITY_HACK = {{0x00, 0x00, 0x80, 0x7F}};
//C     		#define INFINITY (INFINITY_HACK.Value)
//C     	#else
//C     		#define INFINITY (1e1000)
//C     	#endif
//C     #endif

//C     #include "cpVect.h"
import chipmunk4.cpVect;
//C     #include "cpBB.h"
import chipmunk4.cpBB;
//C     #include "cpBody.h"
import chipmunk4.cpBody;
//C     #include "cpArray.h"
import chipmunk4.cpArray;
//C     #include "cpHashSet.h"
import chipmunk4.cpHashSet;
//C     #include "cpSpaceHash.h"
import chipmunk4.cpSpaceHash;

//C     #include "cpShape.h"
import chipmunk4.cpShape;
//C     #include "cpPolyShape.h"
import chipmunk4.cpPolyShape;

//C     #include "cpArbiter.h"
import chipmunk4.cpArbiter;
//C     #include "cpCollision.h"
import chipmunk4.cpCollision;
	
//C     #include "cpJoint.h"
import chipmunk4.cpJoint;

//C     #include "cpSpace.h"
import chipmunk4.cpSpace;

//C     #define CP_HASH_COEF (3344921057ul)
//C     #define CP_HASH_PAIR(A, B) ((unsigned int)(A)*CP_HASH_COEF ^ (unsigned int)(B)*CP_HASH_COEF)

//C     #define DLLEXPORT __declspec(dllexport)
//C     #define STDCALL __stdcall
//C     DLLEXPORT void cpInitChipmunk(void);
extern (Windows):
void  cpInitChipmunk();

//C     DLLEXPORT cpFloat cpMomentForCircle(cpFloat m, cpFloat r1, cpFloat r2, cpVect offset);
cpFloat  cpMomentForCircle(cpFloat m, cpFloat r1, cpFloat r2, cpVect offset);
//C     DLLEXPORT cpFloat cpMomentForPoly(cpFloat m, int numVerts, cpVect *verts, cpVect offset);
cpFloat  cpMomentForPoly(cpFloat m, int numVerts, cpVect *verts, cpVect offset);

//C     #ifdef __cplusplus
//C     }
//C     #endif

//C     #endif

