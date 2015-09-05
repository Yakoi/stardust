/* Converted to D from cpJoint.h by htod */
module chipmunk4.cpJoint;
import chipmunk4.cpVect;
import chipmunk4.chipmunk;
import chipmunk4.cpBody;
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

// TODO: Comment me!
	
//C     extern cpFloat cp_joint_bias_coef;
enum cpJointType {
	CP_PIN_JOINT,
	CP_PIVOT_JOINT,
	CP_SLIDE_JOINT,
	CP_GROOVE_JOINT,
	CP_CUSTOM_JOINT, // For user definable joint types.
} 


struct cpJointClass {
	cpJointType type;
	
	void (*preStep)(cpJoint *joint, cpFloat dt_inv);
	void (*applyImpulse)(cpJoint *joint);
} 

struct cpJoint {
	const cpJointClass *klass;
	
	cpBody* a, b;
}

extern(Windows){
    void cpJointDestroy(cpJoint *joint);
    void cpJointFree(cpJoint *joint);
}


struct cpPinJoint {
	cpJoint joint;
	cpVect anchr1, anchr2;
	cpFloat dist;
	
	cpVect r1, r2;
	cpVect n;
	cpFloat nMass;
	
	cpFloat jnAcc, jBias;
	cpFloat bias;
} 

extern(Windows){
    cpPinJoint *cpPinJointAlloc();
    cpPinJoint *cpPinJointInit(cpPinJoint *joint, cpBody *a, cpBody *b, cpVect anchr1, cpVect anchr2);
    cpJoint *cpPinJointNew(cpBody *a, cpBody *b, cpVect anchr1, cpVect anchr2);
}


struct cpSlideJoint {
	cpJoint joint;
	cpVect anchr1, anchr2;
	cpFloat min, max;
	
	cpVect r1, r2;
	cpVect n;
	cpFloat nMass;
	
	cpFloat jnAcc, jBias;
	cpFloat bias;
} 

extern(Windows){
    cpSlideJoint *cpSlideJointAlloc();
    cpSlideJoint *cpSlideJointInit(cpSlideJoint *joint, cpBody *a, cpBody *b, cpVect anchr1, cpVect anchr2, cpFloat min, cpFloat max);
    cpJoint *cpSlideJointNew(cpBody *a, cpBody *b, cpVect anchr1, cpVect anchr2, cpFloat min, cpFloat max);
}


struct cpPivotJoint {
	cpJoint joint;
	cpVect anchr1, anchr2;
	
	cpVect r1, r2;
	cpVect k1, k2;
	
	cpVect jAcc, jBias;
	cpVect bias;
} ;

extern(Windows){
    cpPivotJoint *cpPivotJointAlloc();
    cpPivotJoint *cpPivotJointInit(cpPivotJoint *joint, cpBody *a, cpBody *b, cpVect pivot);
    cpJoint *cpPivotJointNew(cpBody *a, cpBody *b, cpVect pivot);
}


struct cpGrooveJoint {
	cpJoint joint;
	cpVect grv_n, grv_a, grv_b;
	cpVect  anchr2;
	
	cpVect grv_tn;
	cpFloat clamp;
	cpVect r1, r2;
	cpVect k1, k2;
	
	cpVect jAcc, jBias;
	cpVect bias;
} 

extern(Windows){
    cpGrooveJoint *cpGrooveJointAlloc();
    cpGrooveJoint *cpGrooveJointInit(cpGrooveJoint *joint, cpBody *a, cpBody *b, cpVect groove_a, cpVect groove_b, cpVect anchr2);
    cpJoint *cpGrooveJointNew(cpBody *a, cpBody *b, cpVect groove_a, cpVect groove_b, cpVect anchr2);
}
