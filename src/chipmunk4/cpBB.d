/* Converted to D from cpBB.h by htod */
module chipmunk4.cpBB;
//C     #ifndef __cpBB__
//C     #define __cpBB__
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
//C     #include "chipmunk.h"
import chipmunk4.chipmunk;
import chipmunk4.cpVect;
struct cpBB{
	cpFloat l, b, r ,t;
} 


cpBB cpBBNew(const cpFloat l, const cpFloat b, const cpFloat r, const cpFloat t)
{
	cpBB bb = {l, b, r, t};
	return bb;
}
/*

static inline int
cpBBintersects(const cpBB a, const cpBB b)
{
	return (a.l<=b.r && b.l<=a.r && a.b<=b.t && b.b<=a.t);
}

static inline int
cpBBcontainsBB(const cpBB bb, const cpBB other)
{
	return (bb.l < other.l && bb.r > other.r && bb.b < other.b && bb.t > other.t);
}

static inline int
cpBBcontainsVect(const cpBB bb, const cpVect v)
{
	return (bb.l < v.x && bb.r > v.x && bb.b < v.y && bb.t > v.y);
}
#define DLLEXPORT __declspec(dllexport)

DLLEXPORT cpVect cpBBClampVect(const cpBB bb, const cpVect v); // clamps the vector to lie within the bbox
DLLEXPORT cpVect cpBBWrapVect(const cpBB bb, const cpVect v); // wrap a vector to a bbox
#endif// __cpBB__
*/
int cpBBintersects(const cpBB a, const cpBB b)
{
	return (a.l<=b.r && b.l<=a.r && a.b<=b.t && b.b<=a.t);
}

int cpBBcontainsBB(const cpBB bb, const cpBB other)
{
	return (bb.l < other.l && bb.r > other.r && bb.b < other.b && bb.t > other.t);
}

int cpBBcontainsVect(const cpBB bb, const cpVect v)
{
	return (bb.l < v.x && bb.r > v.x && bb.b < v.y && bb.t > v.y);
}
extern(Windows):
cpVect cpBBClampVect(const cpBB bb, const cpVect v); // clamps the vector to lie within the bbox
cpVect cpBBWrapVect(const cpBB bb, const cpVect v); // wrap a vector to a bbox
