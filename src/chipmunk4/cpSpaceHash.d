/* Converted to D from cpSpaceHash.h by htod */
module chipmunk4.cpSpaceHash;
import chipmunk4.cpBB;
import chipmunk4.chipmunk;
import chipmunk4.cpVect;
import chipmunk4.cpHashSet;
//C     #ifndef __cpSpaceHash__
//C     #define __cpSpaceHash__
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

// The spatial hash is Chipmunk's default (and currently only) spatial index type.
// Based on a chained hash table.

// Used internally to track objects added to the hash
//C     typedef struct cpHandle{
	// Pointer to the object
//C     	void *obj;
	// Retain count
//C     	int retain;
	// Query stamp. Used to make sure two objects
	// aren't identified twice in the same query.
//C     	int stamp;
//C     } cpHandle;
struct cpHandle
{
    void *obj;
    int retain;
    int stamp;
}

// Linked list element for in the chains.
//C     typedef struct cpSpaceHashBin{
//C     	cpHandle *handle;
//C     	struct cpSpaceHashBin *next;
//C     } cpSpaceHashBin;
struct cpSpaceHashBin
{
    cpHandle *handle;
    cpSpaceHashBin *next;
}

// BBox callback. Called whenever the hash needs a bounding box from an object.
//C     typedef cpBB (*cpSpaceHashBBFunc)(void *obj);
extern (Windows)alias cpBB (*cpSpaceHashBBFunc)(void *obj);
//alias int cpBB (*cpSpaceHashBBFunc)(void* obj);

//C     typedef struct cpSpaceHash{
	// Number of cells in the table.
//C     	int numcells;
	// Dimentions of the cells.
//C     	cpFloat celldim;
	
	// BBox callback.
//C     	cpSpaceHashBBFunc bbfunc;

	// Hashset of all the handles.
//C     	cpHashSet *handleSet;
	
//C     	cpSpaceHashBin **table;
	// List of recycled bins.
//C     	cpSpaceHashBin *bins;

	// Incremented on each query. See cpHandle.stamp.
//C     	int stamp;
//C     } cpSpaceHash;
struct cpSpaceHash
{
	// Number of cells in the table.
	int numcells;
	// Dimentions of the cells.
	cpFloat celldim;
	
	// BBox callback.
	cpSpaceHashBBFunc bbfunc;

	// Hashset of all the handles.
	cpHashSet *handleSet;
	
	cpSpaceHashBin **table;
	// List of recycled bins.
	cpSpaceHashBin *bins;

	// Incremented on each query. See cpHandle.stamp.
	int stamp;
}

extern(Windows){
    //Basic allocation/destruction functions.
    cpSpaceHash *cpSpaceHashAlloc();
    cpSpaceHash *cpSpaceHashInit(cpSpaceHash *hash, cpFloat celldim, int cells, cpSpaceHashBBFunc bbfunc);
    cpSpaceHash *cpSpaceHashNew(cpFloat celldim, int cells, cpSpaceHashBBFunc bbfunc);

    void cpSpaceHashDestroy(cpSpaceHash *hash);
    void cpSpaceHashFree(cpSpaceHash *hash);

    // Resize the hashtable. (Does not rehash! You must call cpSpaceHashRehash() if needed.)
    void cpSpaceHashResize(cpSpaceHash *hash, cpFloat celldim, int numcells);

    // Add an object to the hash.
    void cpSpaceHashInsert(cpSpaceHash *hash, void *obj, uint id, cpBB bb);
    // Remove an object from the hash.
    void cpSpaceHashRemove(cpSpaceHash *hash, void *obj, uint id);

    // Iterator function
    alias void (*cpSpaceHashIterator)(void *obj, void *data);
    // Iterate over the objects in the hash.
    void cpSpaceHashEach(cpSpaceHash *hash, cpSpaceHashIterator func, void *data);

    // Rehash the contents of the hash.
    void cpSpaceHashRehash(cpSpaceHash *hash);
    // Rehash only a specific object.
    void cpSpaceHashRehashObject(cpSpaceHash *hash, void *obj, uint id);

// Query callback.

    alias int (*cpSpaceHashQueryFunc)(void *obj1, void *obj2, void *data);
    // Point query the hash. A reference to the query point is passed as obj1 to the query callback.
    void cpSpaceHashPointQuery(cpSpaceHash *hash, cpVect point, cpSpaceHashQueryFunc func, void *data);
    // Query the hash for a given BBox.
    void cpSpaceHashQuery(cpSpaceHash *hash, void *obj, cpBB bb, cpSpaceHashQueryFunc func, void *data);
    // Run a query for the object, then insert it. (Optimized case)
    void cpSpaceHashQueryInsert(cpSpaceHash *hash, void *obj, cpBB bb, cpSpaceHashQueryFunc func, void *data);
    // Rehashes while querying for each object. (Optimized case) 
    void cpSpaceHashQueryRehash(cpSpaceHash *hash, cpSpaceHashQueryFunc func, void *data);
}
