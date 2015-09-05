/* Converted to D from cpHashSet.h by htod */
module chipmunk4.cpHashSet;
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
 
// cpHashSet uses a chained hashtable implementation.
// Other than the transformation functions, there is nothing fancy going on.

// cpHashSetBin's form the linked lists in the chained hash table.
//C     typedef struct cpHashSetBin {
	// Pointer to the element.
//C     	void *elt;
	// Hash value of the element.
//C     	unsigned int hash;
	// Next element in the chain.
//C     	struct cpHashSetBin *next;
//C     } cpHashSetBin;
struct cpHashSetBin
{
    void *elt;
    uint hash;
    cpHashSetBin *next;
}

extern(Windows){
// Equality function. Returns true if ptr is equal to elt.
//C     typedef int (*cpHashSetEqlFunc)(void *ptr, void *elt);
//alias int  function(void *ptr, void *elt)cpHashSetEqlFunc;
alias int (*cpHashSetEqlFunc)(void *ptr, void *elt);
// Used by cpHashSetInsert(). Called to transform the ptr into an element.
//C     typedef void *(*cpHashSetTransFunc)(void *ptr, void *data);
//alias void * function(void *ptr, void *data)cpHashSetTransFunc;
alias void *(*cpHashSetTransFunc)(void *ptr, void *data);
// Iterator function for a hashset.
//C     typedef void (*cpHashSetIterFunc)(void *elt, void *data);
//alias void  function(void *elt, void *data)cpHashSetIterFunc;
alias void (*cpHashSetIterFunc)(void *elt, void *data);
// Reject function. Returns true if elt should be dropped.
//C     typedef int (*cpHashSetRejectFunc)(void *elt, void *data);
//alias int  function(void *elt, void *data)cpHashSetRejectFunc;
alias int (*cpHashSetRejectFunc)(void *elt, void *data);
}

//C     typedef struct cpHashSet {
	// Number of elements stored in the table.
//C     	int entries;
	// Number of cells in the table.
//C     	int size;
	
//C     	cpHashSetEqlFunc eql;
//C     	cpHashSetTransFunc trans;
	
	// Default value returned by cpHashSetFind() when no element is found.
	// Defaults to NULL.
//C     	void *default_value;
	
//C     	cpHashSetBin **table;
//C     } cpHashSet;
struct cpHashSet
{
    int entries;
    int size;
    cpHashSetEqlFunc eql;
    cpHashSetTransFunc trans;
    void *default_value;
    cpHashSetBin **table;
}

extern(Windows):
// Basic allocation/destruction functions.
//C     #define DLLEXPORT __declspec(dllexport)
//C     DLLEXPORT void cpHashSetDestroy(cpHashSet *set);
void  cpHashSetDestroy(cpHashSet *set);
//C     DLLEXPORT void cpHashSetFree(cpHashSet *set);
void  cpHashSetFree(cpHashSet *set);

//C     DLLEXPORT cpHashSet *cpHashSetAlloc(void);
cpHashSet * cpHashSetAlloc();
//C     DLLEXPORT cpHashSet *cpHashSetInit(cpHashSet *set, int size, cpHashSetEqlFunc eqlFunc, cpHashSetTransFunc trans);
cpHashSet * cpHashSetInit(cpHashSet *set, int size, cpHashSetEqlFunc eqlFunc, cpHashSetTransFunc trans);
//C     DLLEXPORT cpHashSet *cpHashSetNew(int size, cpHashSetEqlFunc eqlFunc, cpHashSetTransFunc trans);
cpHashSet * cpHashSetNew(int size, cpHashSetEqlFunc eqlFunc, cpHashSetTransFunc trans);

// Insert an element into the set, returns the element.
// If it doesn't already exist, the transformation function is applied.
//C     DLLEXPORT void *cpHashSetInsert(cpHashSet *set, unsigned int hash, void *ptr, void *data);
void * cpHashSetInsert(cpHashSet *set, uint hash, void *ptr, void *data);
// Remove and return an element from the set.
//C     DLLEXPORT void *cpHashSetRemove(cpHashSet *set, unsigned int hash, void *ptr);
void * cpHashSetRemove(cpHashSet *set, uint hash, void *ptr);
// Find an element in the set. Returns the default value if the element isn't found.
//C     DLLEXPORT void *cpHashSetFind(cpHashSet *set, unsigned int hash, void *ptr);
void * cpHashSetFind(cpHashSet *set, uint hash, void *ptr);

// Iterate over a hashset.
//C     DLLEXPORT void cpHashSetEach(cpHashSet *set, cpHashSetIterFunc func, void *data);
void  cpHashSetEach(cpHashSet *set, cpHashSetIterFunc func, void *data);
// Iterate over a hashset while rejecting certain elements.
//C     DLLEXPORT void cpHashSetReject(cpHashSet *set, cpHashSetRejectFunc func, void *data);
void  cpHashSetReject(cpHashSet *set, cpHashSetRejectFunc func, void *data);
