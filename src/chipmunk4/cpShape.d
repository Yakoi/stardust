/* Converted to D from cpShape.h by htod */
module chipmunk4.cpShape;
import chipmunk4.cpBB;
import chipmunk4.cpVect;
import chipmunk4.cpBody;
import chipmunk4.chipmunk;
//C     #ifndef __cpSharp__
//C     #define __cpSharp__
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

// For determinism, you can reset the shape id counter.
//C     #define DLLEXPORT __declspec(dllexport)
//C     DLLEXPORT void cpResetShapeIdCounter(void);
extern(Windows){
    void  cpResetShapeIdCounter();
}

// Enumeration of shape types.
//C     typedef enum cpShapeType{
//C     	CP_CIRCLE_SHAPE,
//C     	CP_SEGMENT_SHAPE,
//C     	CP_POLY_SHAPE,
//C     	CP_NUM_SHAPES
//C     } cpShapeType;
enum cpShapeType
{
    CP_CIRCLE_SHAPE,
    CP_SEGMENT_SHAPE,
    CP_POLY_SHAPE,
    CP_NUM_SHAPES,
}

// Forward declarations required for defining the cpShape and cpShapeClass structs.
//C     struct cpShape;
//C     struct cpShapeClass;

// Shape class. Holds function pointers and type data.
//C     typedef struct cpShapeClass {
//C     	cpShapeType type;
	
	// Called by cpShapeCacheBB().
//C     	cpBB (*cacheData)(struct cpShape *shape, cpVect p, cpVect rot);
	// Called to by cpShapeDestroy().
//C     	void (*destroy)(struct cpShape *shape);
	
	// called by cpShapeQueryPointQuery().
//C     	int (*pointQuery)(struct cpShape *shape, cpVect p);
//C     } cpShapeClass;

struct cpShapeClass
{
    cpShapeType type;

	// Called by cpShapeCacheBB().
	cpBB (*cacheData)(cpShape *shape, cpVect p, cpVect rot);
	// Called to by cpShapeDestroy().
	void (*destroy)(cpShape *shape);
	
	// called by cpShapeQueryPointQuery().
	int (*pointQuery)(cpShape *shape, cpVect p);
}

// Basic shape struct that the others inherit from.
//C     typedef struct cpShape{
	// The "class" of a shape as defined above 
//C     	const cpShapeClass *klass;
	
	// cpBody that the shape is attached to.
//C     	cpBody *body;

	// Cached BBox for the shape.
//C     	cpBB bb;
	
	// *** Surface properties.
	
	// Coefficient of restitution. (elasticity)
//C     	cpFloat e;
struct cpShape{
	// The "class" of a shape as defined above 
	const cpShapeClass *klass;
	
	// cpBody that the shape is attached to.
	cpBody *bd;

	// Cached BBox for the shape.
	cpBB bb;
	
	// *** Surface properties.
	
	// Coefficient of restitution. (elasticity)
	cpFloat e;
	// Coefficient of friction.
	cpFloat u;
	// Surface velocity used when solving for friction.
	cpVect surface_v;

	// *** User Definable Fields

	// User defined data pointer for the shape.
	void *data;
	
	// User defined collision type for the shape.
	uint collision_type;
	// User defined collision group for the shape.
	uint group;
	// User defined layer bitmask for the shape.
	uint layers;
	
	// *** Internally Used Fields
	
	// Unique id used as the hash value.
	uint id;
}

extern(Windows){
    // Low level shape initialization func.
    cpShape* cpShapeInit(cpShape *shape, const cpShapeClass *klass, cpBody *bd);

    // Basic destructor functions. (allocation functions are not shared)
    void cpShapeDestroy(cpShape *shape);
    void cpShapeFree(cpShape *shape);

    // Cache the BBox of the shape.
    cpBB cpShapeCacheBB(cpShape *shape);

    // Test if a point lies within a shape.
    int cpShapePointQuery(cpShape *shape, cpVect p);

    // Test if a segment collides with a shape.
    // Returns [0-1] if the segment collides and -1 otherwise.
    // 0 would be a collision at point a, 1 would be a collision at point b.
    //cpFloat cpShapeSegmentQuery(cpShape *shape, cpVect a, cpVect b);
}


// Circle shape structure.
struct cpCircleShape{
	cpShape shape;
	
	// Center. (body space coordinates)
	cpVect c;
	// Radius.
	cpFloat r;
	
	// Transformed center. (world space coordinates)
	cpVect tc;
}

extern(Windows){
    // Basic allocation functions for cpCircleShape.
    cpCircleShape *cpCircleShapeAlloc();
    cpCircleShape *cpCircleShapeInit(cpCircleShape *circle, cpBody *bd, cpFloat radius, cpVect offset);
    cpShape *cpCircleShapeNew(cpBody *bd, cpFloat radius, cpVect offset);
}
// Segment shape structure.
struct cpSegmentShape{
	cpShape shape;
	
	// Endpoints and normal of the segment. (body space coordinates)
	cpVect a, b, n;
	// Radius of the segment. (Thickness)
	cpFloat r;

	// Transformed endpoints and normal. (world space coordinates)
	cpVect ta, tb, tn;
}

extern(Windows){
    // Basic allocation functions for cpSegmentShape.
    cpSegmentShape* cpSegmentShapeAlloc();
    cpSegmentShape* cpSegmentShapeInit(cpSegmentShape *seg, cpBody *bd, cpVect a, cpVect b, cpFloat radius);
    cpShape* cpSegmentShapeNew(cpBody *bd, cpVect a, cpVect b, cpFloat radius);
}
