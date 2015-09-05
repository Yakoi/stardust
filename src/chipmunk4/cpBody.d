/* Converted to D from cpBody.h by htod */
module chipmunk4.cpBody;
//C     #ifndef __cpBody__
//C     #define __cpBody__
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

extern(Windows){
alias void (*cpBodyVelocityFunc)(cpBody *bd, cpVect gravity, cpFloat damping, cpFloat dt);
alias void (*cpBodyPositionFunc)(cpBody *bd, cpFloat dt);
}

 
struct cpBody{
	// *** Integration Functions.

	// Function that is called to integrate the body's velocity. (Defaults to cpBodyUpdateVelocity)
	cpBodyVelocityFunc velocity_func;
	
	// Function that is called to integrate the body's position. (Defaults to cpBodyUpdatePosition)
	cpBodyPositionFunc position_func;
	
	// *** Mass Properties
	
	// Mass and it's inverse.
	// Always use cpBodySetMass() whenever changing the mass as these values must agree.
	cpFloat m, m_inv;
	
	// Moment of inertia and it's inverse.
	// Always use cpBodySetMass() whenever changing the mass as these values must agree.
	cpFloat i, i_inv;
	
	// *** Positional Properties
	
	// Linear components of motion (position, velocity, and force)
	cpVect p, v, f;
	
	// Angular components of motion (angle, angular velocity, and torque)
	// Always use cpBodySetAngle() to set the angle of the body as a and rot must agree.
	cpFloat a, w, t;
	
	// Cached unit length vector representing the angle of the body.
	// Used for fast vector rotation using cpvrotate().
	cpVect rot;
	
	// *** User Definable Fields
	
	// User defined data pointer.
	void *data;
	
	// *** Internally Used Fields
	
	// Velocity bias values used when solving penetrations and correcting joints.
	cpVect v_bias;
	cpFloat w_bias;
	
//	int active;
} ;

extern(Windows):
// Basic allocation/destruction functions
cpBody *cpBodyAlloc();
cpBody *cpBodyInit(cpBody *bd, cpFloat m, cpFloat i);
cpBody *cpBodyNew(cpFloat m, cpFloat i);

void cpBodyDestroy(cpBody *bd);
void cpBodyFree(cpBody *bd);

// Setters for some of the special properties (mandatory!)
void cpBodySetMass(cpBody *bd, cpFloat m);
void cpBodySetMoment(cpBody *bd, cpFloat i);
void cpBodySetAngle(cpBody *bd, cpFloat a);

//  Modify the velocity of the body so that it will move to the specified absolute coordinates in the next timestep.
// Intended for objects that are moved manually with a custom velocity integration function.
void cpBodySlew(cpBody *bd, cpVect pos, cpFloat dt);

// Default Integration functions.
void cpBodyUpdateVelocity(cpBody *bd, cpVect gravity, cpFloat damping, cpFloat dt);
void cpBodyUpdatePosition(cpBody *bd, cpFloat dt);

// Convert body local to world coordinates
cpVect cpBodyLocal2World(cpBody *bd, cpVect v)
{
	return cpvadd(bd.p, cpvrotate(v, bd.rot));
}

// Convert world to body local coordinates
cpVect cpBodyWorld2Local(cpBody *bd, cpVect v)
{
	return cpvunrotate(cpvsub(v, bd.p), bd.rot);
}

// Apply an impulse (in world coordinates) to the body.
void cpBodyApplyImpulse(cpBody *bd, cpVect j, cpVect r)
{
	bd.v = cpvadd(bd.v, cpvmult(j, bd.m_inv));
	bd.w += bd.i_inv*cpvcross(r, j);
}

// Not intended for external use. Used by cpArbiter.c and cpJoint.c.
void cpBodyApplyBiasImpulse(cpBody *bd, cpVect j, cpVect r)
{
	bd.v_bias = cpvadd(bd.v_bias, cpvmult(j, bd.m_inv));
	bd.w_bias += bd.i_inv*cpvcross(r, j);
}

// Zero the forces on a body.
void cpBodyResetForces(cpBody *bd);
// Apply a force (in world coordinates) to a body.
void cpBodyApplyForce(cpBody *bd, cpVect f, cpVect r);

// Apply a damped spring force between two bodies.
void cpDampedSpring(cpBody *a, cpBody *b, cpVect anchr1, cpVect anchr2, cpFloat rlen, cpFloat k, cpFloat dmp, cpFloat dt);

//int cpBodyMarkLowEnergy(cpBody *body, cpFloat dvsq, int max);
