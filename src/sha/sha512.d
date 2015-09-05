/**
  FreeBLのsha512.cの劣化移植
  License: MPL 1.1/GPL 2.0/LGPL 2.1
*/
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 * 
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 * 
 * The Original Code is the Netscape security libraries.
 * 
 * The Initial Developer of the Original Code is
 * Netscape Communications Corporation.
 * Portions created by the Initial Developer are Copyright (C) 2002
 * the Initial Developer. All Rights Reserved.
 * 
 * Contributor(s):
 *   Nazo<lovesyao@gmail.com>
 * 
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 * 
 * ***** END LICENSE BLOCK ***** *
 */
module sha.sha512;
import std.string;
import std.stdio;

const uint SHA256_BLOCK_LENGTH=64;   /* bytes */
const uint SHA384_BLOCK_LENGTH=128;  /* bytes */
const uint SHA512_BLOCK_LENGTH=128;  /* bytes */
const uint SHA256_LENGTH=32;
const uint SHA384_LENGTH=48;
const uint SHA512_LENGTH=64;

uint SHR(uint x,uint n){
  return (x >> n);
}
uint SHL(uint x,uint n){
  return (x << n);
}
uint Ch(uint x,uint y,uint z){
  return ((x & y) ^ (~x & z));
}
uint Maj(uint x,uint y,uint z){
  return ((x & y) ^ (x & z) ^ (y & z));
}

static const ubyte[240] pad = [
  0x80,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  /* compiler will fill the rest in with zeros */
];

static const uint[64] K256 = [
  0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 
  0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
  0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 
  0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
  0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 
  0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
  0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 
  0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
  0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 
  0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
  0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 
  0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
  0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 
  0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
  0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 
  0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
];

static const uint[8] H256 = [
  0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 
  0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
];

struct SHA256ContextStr {
  union U{
    uint[64] w;     /* message schedule, input buffer, plus 48 words */
    ubyte[256]  b;
  }
  U u;
  uint[8] h;              /* 8 state variables */
  uint sizeHi,sizeLo;     /* 64-bit count of hashed bytes. */
}

uint ROTR32(uint x,uint n){
  return ((x >> n) | (x << ((8 * x.sizeof) - n)));
}

uint S0(uint x){
  return (ROTR32(x, 2) ^ ROTR32(x,13) ^ ROTR32(x,22));
}
uint S1(uint x){
  return (ROTR32(x, 6) ^ ROTR32(x,11) ^ ROTR32(x,25));
}
uint s0(ref uint t1,uint x){
  return (t1 = x, ROTR32(t1, 7) ^ ROTR32(t1,18) ^ SHR(t1, 3));
}
uint s1(ref uint t2,uint x){
  return (t2 = x, ROTR32(t2,17) ^ ROTR32(t2,19) ^ SHR(t2,10));
}

alias SHA256ContextStr SHA256Context;

/**
 * SHA256計算のコンテキストを保持
 *
 * ダイジェストを計算するデータがバッファリングされているときに使用します。
 */
struct SHA256_CTX{
  union U{
    uint[64] w;     /* message schedule, input buffer, plus 48 words */
    ubyte[256]  b;
  }
  U u;
  uint[8] h;              /* 8 state variables */
  uint sizeHi,sizeLo;     /* 64-bit count of hashed bytes. */
  ///SHA1メッセージダイジェスト処理を開始します。 
  void start(){
    h[0..8]=H256[0..8];
  }
  private void compress(){
    uint t1,t2;
    void INITW(uint t){
      u.w[t] = (s1(t2,u.w[t-2]) + u.w[t-7] + s0(t1,u.w[t-15]) + u.w[t-16]);
    }
    for (int t=16;t<64;++t){
      INITW(t);
    }
    uint a,b,c,d,e,f,g,h;
    a = this.h[0];
    b = this.h[1];
    c = this.h[2];
    d = this.h[3];
    e = this.h[4];
    f = this.h[5];
    g = this.h[6];
    h = this.h[7];
    void ROUND(uint n,uint a,uint b,uint c,ref uint d,uint e,uint f,uint g,ref uint h){
      h += S1(e) + Ch(e,f,g) + K256[n] + u.w[n];
      d += h;
      h += S0(a) + Maj(a,b,c);
    }
    for(int t=0;t<64;t+=8){
      ROUND(t+0,a,b,c,d,e,f,g,h);
      ROUND(t+1,h,a,b,c,d,e,f,g);
      ROUND(t+2,g,h,a,b,c,d,e,f);
      ROUND(t+3,f,g,h,a,b,c,d,e);
      ROUND(t+4,e,f,g,h,a,b,c,d);
      ROUND(t+5,d,e,f,g,h,a,b,c);
      ROUND(t+6,c,d,e,f,g,h,a,b);
      ROUND(t+7,b,c,d,e,f,g,h,a);
    }
    this.h[0] += a;
    this.h[1] += b;
    this.h[2] += c;
    this.h[3] += d;
    this.h[4] += e;
    this.h[5] += f;
    this.h[6] += g;
    this.h[7] += h;
  }
  ///新しいブロック input を処理してコンテキストを更新し、 SHA1メッセージダイジェスト処理を続行します。
  void update(void[] input){
    uint inBuf = sizeLo & 0x3f;

    /* Add inputLen into the count of bytes processed, before processing */
    if((sizeLo += input.length) < input.length)
      sizeHi++;

    /* if data already in buffer, attemp to fill rest of buffer */
    if(inBuf){
      uint todo = SHA256_BLOCK_LENGTH - inBuf;
      if(input.length < todo){
        todo=input.length;
      }
      u.b[$-todo..$]=(cast(ubyte[])input)[0..todo];
      input=input[todo..$];
      if(inBuf + todo == SHA256_BLOCK_LENGTH)
        compress();
    }

    /* if enough data to fill one or more whole buffers, process them. */
    while(input.length >= SHA256_BLOCK_LENGTH) {
      u.b[0..SHA256_BLOCK_LENGTH]=(cast(ubyte[])input)[0..SHA256_BLOCK_LENGTH];
      input=input[SHA256_BLOCK_LENGTH+1..$];
      compress();
    }
    /* if data left over, fill it into buffer */
    u.b[0..input.length]=(cast(ubyte[])input)[0..$];
  }
  ///SHA1メッセージダイジェスト処理を終了し、結果を digest へ出力します。 
  void finish(ubyte[32] digest){
    uint inBuf = sizeLo & 0x3f;
    uint padLen = (inBuf < 56) ? (56 - inBuf) : (56 + 64 - inBuf);
    uint hi, lo;

    hi = (sizeHi << 3) | (sizeLo >> 29);
    lo = (sizeLo << 3);
    update(cast(void[])pad[0..padLen]);
    u.w[14] = hi;
    u.w[15] = lo;
    compress();
    digest[0..$]=(cast(ubyte[])h)[0..32];
  }
}

///配列 data のSHA256ダイジェストを計算
void sum(ubyte[32] digest,void[] data){
  SHA256_CTX context;
  context.start();
  context.update(data);
  context.finish(digest);
}

///SHA256ダイジェストを文字列に変換 
char[] digestToString(ubyte[32] digest){
  char[] result = new char[64];
  int i;

  foreach (ubyte u;digest){
    result[i] = std.string.hexdigits[u >> 4];
    result[i + 1] = std.string.hexdigits[u & 15];
    i += 2;
  }
  return result;
}

///ダイジェストを16進表記で標準出力に表示
void printDigest(ubyte[32] digest){
  foreach (ubyte u; digest)
    printf("%02x", u);
}
