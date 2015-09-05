/* Converted to D from cpPolyShape.h by htod */
module chipmunk4.cpPolyShape;
import chipmunk4.cpShape;
import chipmunk4.chipmunk;
import chipmunk4.cpVect;
import chipmunk4.cpBody;
//C     #ifndef __cpPolyShape__
//C     #define __cpPolyShape__
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

// Axis structure used by cpPolyShape.
//C     typedef struct cpPolyShapeAxis{
	// normal
//C     	cpVect n;
	// distance from origin
//C     	cpFloat d;
//C     } cpPolyShapeAxis;
struct cpPolyShapeAxis
{
    cpVect n;
    cpFloat d;
}

// Convex polygon shape structure.
//C     typedef struct cpPolyShape{
//C     	cpShape shape;
	
	// Vertex and axis lists.
//C     	int numVerts;
//C     	cpVect *verts;
//C     	cpPolyShapeAxis *axes;

	// Transformed vertex and axis lists.
//C     	cpVect *tVerts;
struct cpPolyShape{
	cpShape shape;
	
	// Vertex and axis lists.
	int numVerts;
	cpVect *verts;
	cpPolyShapeAxis *axes;

	// Transformed vertex and axis lists.
	cpVect *tVerts;
	cpPolyShapeAxis *tAxes;
} 

extern(Windows){
    // Basic allocation functions.
    cpPolyShape *cpPolyShapeAlloc();
    cpPolyShape *cpPolyShapeInit(cpPolyShape *poly, cpBody *bd, int numVerts, cpVect *verts, cpVect offset);
    cpShape *cpPolyShapeNew(cpBody *bd, int numVerts, cpVect *verts, cpVect offset);
}

// Returns the minimum distance of the polygon to the axis.
cpFloat cpPolyShapeValueOnAxis(cpPolyShape *poly, const cpVect n, const cpFloat d)
{
	cpVect *verts = poly.tVerts;
	cpFloat min = cpvdot(n, verts[0]);
	
	int i;
	for(i=1; i<poly.numVerts; i++)
		min = cpfmin(min, cpvdot(n, verts[i]));
	
	return min - d;
}

// Returns true if the polygon contains the vertex.
int cpPolyShapeContainsVert(cpPolyShape *poly, cpVect v)
{
	cpPolyShapeAxis *axes = poly.tAxes;
	
	int i;
	for(i=0; i<poly.numVerts; i++){
		cpFloat dist = cpvdot(axes[i].n, v) - axes[i].d;
		if(dist > 0.0) return 0;
	}
	
	return 1;
}

// Same as cpPolyShapeContainsVert() but ignores faces pointing away from the normal.
int cpPolyShapeContainsVertPartial(cpPolyShape *poly, cpVect v, cpVect n)
{
	cpPolyShapeAxis *axes = poly.tAxes;
	
	int i;
	for(i=0; i<poly.numVerts; i++){
		if(cpvdot(axes[i].n, n) < 0.0f) continue;
		cpFloat dist = cpvdot(axes[i].n, v) - axes[i].d;
		if(dist > 0.0) return 0;
	}
	
	return 1;
}
