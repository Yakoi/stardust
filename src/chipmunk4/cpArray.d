/* Converted to D from cpArray.h by htod */
module chipmunk4.cpArray;
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
 
// NOTE: cpArray is rarely used and will probably go away.
//C     #define DLLEXPORT __declspec(dllexport)

//C     typedef struct cpArray{
//C     	int num, max;
//C     	void **arr;
//C     } cpArray;
struct cpArray
{
    int num, max;
    void **arr;
}
extern(Windows):

//C     typedef void (*cpArrayIter)(void *ptr, void *data);
//alias void  function(void *ptr, void *data)cpArrayIter;
alias void (*cpArrayIter)(void *ptr, void *data);

//C     DLLEXPORT cpArray *cpArrayAlloc(void);
cpArray * cpArrayAlloc();
//C     DLLEXPORT cpArray *cpArrayInit(cpArray *arr, int size);
cpArray * cpArrayInit(cpArray *arr, int size);
//C     DLLEXPORT cpArray *cpArrayNew(int size);
cpArray * cpArrayNew(int size);

//C     DLLEXPORT void cpArrayDestroy(cpArray *arr);
void  cpArrayDestroy(cpArray *arr);
//C     DLLEXPORT void cpArrayFree(cpArray *arr);
void  cpArrayFree(cpArray *arr);

//C     void cpArrayClear(cpArray *arr);
void  cpArrayClear(cpArray *arr);

//C     DLLEXPORT void cpArrayPush(cpArray *arr, void *object);
void  cpArrayPush(cpArray *arr, void *object);
//C     DLLEXPORT void cpArrayDeleteIndex(cpArray *arr, int index);
void  cpArrayDeleteIndex(cpArray *arr, int index);
//C     DLLEXPORT void cpArrayDeleteObj(cpArray *arr, void *obj);
void  cpArrayDeleteObj(cpArray *arr, void *obj);

//C     DLLEXPORT void cpArrayEach(cpArray *arr, cpArrayIter iterFunc, void *data);
void  cpArrayEach(cpArray *arr, cpArrayIter iterFunc, void *data);
//C     DLLEXPORT int cpArrayContains(cpArray *arr, void *ptr);
int  cpArrayContains(cpArray *arr, void *ptr);
