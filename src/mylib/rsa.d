/**
 * rsa.hを端折って移植 by 謎
 * License: Original SSLeay License
 */
/* Copyright (C) 1995-1998 Eric Young (eay@cryptsoft.com)
 * All rights reserved.
 *
 * This package is an SSL implementation written
 * by Eric Young (eay@cryptsoft.com).
 * The implementation was written so as to conform with Netscapes SSL.
 *
 * This library is free for commercial and non-commercial use as long as
 * the following conditions are aheared to.  The following conditions
 * apply to all code found in this distribution, be it the RC4, RSA,
 * lhash, DES, etc., code; not just the SSL code.  The SSL documentation
 * included with this distribution is covered by the same copyright terms
 * except that the holder is Tim Hudson (tjh@cryptsoft.com).
 *
 * Copyright remains Eric Young's, and as such any Copyright notices in
 * the code are not to be removed.
 * If this package is used in a product, Eric Young should be given attribution
 * as the author of the parts of the library used.
 * This can be in the form of a textual message at program startup or
 * in documentation (online or textual) provided with the package.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *    "This product includes cryptographic software written by
 *     Eric Young (eay@cryptsoft.com)"
 *    The word 'cryptographic' can be left out if the rouines from the library
 *    being used are not cryptographic related :-).
 * 4. If you include any Windows specific code (or a derivative thereof) from
 *    the apps directory (application code) you must include an acknowledgement:
 *    "This product includes software written by Tim Hudson (tjh@cryptsoft.com)"
 *
 * THIS SOFTWARE IS PROVIDED BY ERIC YOUNG ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 * The licence and distribution terms for any publically available version or
 * derivative of this code cannot be changed.  i.e. this code cannot simply be
 * copied and put under another distribution licence
 * [including the GNU Public Licence.]
 */

module mylib.rsa;
extern(C):

version=USE_NO_HEADER;
version(USE_NO_HEADER){//端折り部分
  //crypto.h
  struct crypto_ex_data_st{
    STACK* sk;
    int dummy; /* gcc is screwing up this data structure :-( */
  }
  //ossl_typ.h
  alias rsa_st RSA;
  alias rsa_meth_st RSA_METHOD;
  alias void BIGNUM;
  alias void BN_CTX;
  alias void BN_MONT_CTX;
  alias void ENGINE;
  alias void BN_GENCB;
  alias void BN_BLINDING;
  alias void FILE;
  alias void BIO;
  alias void EVP_MD;
  alias void STACK;
  alias crypto_ex_data_st CRYPTO_EX_DATA;
  /* Called when a new object is created */
  typedef int CRYPTO_EX_new(void *parent, void *ptr, CRYPTO_EX_DATA *ad,
  					int idx, long argl, void *argp);
  /* Called when an object is free()ed */
  typedef void CRYPTO_EX_free(void *parent, void *ptr, CRYPTO_EX_DATA *ad,
  					int idx, long argl, void *argp);
  /* Called when we need to dup an object */
  typedef int CRYPTO_EX_dup(CRYPTO_EX_DATA *to, CRYPTO_EX_DATA *from, void *from_d, 
  					int idx, long argl, void *argp);
}else{
  private import openssl.asn1;

  version(OPENSSL_NO_BIO){}else{
    private import openssl.bio;
  }

  private import openssl.crypto;
  private import openssl.ossl_typ;

  version(OPENSSL_NO_DEPRECATED){}else{
    private import openssl.bn;
  }

  version(OPENSSL_NO_RSA){
    static assert(0,"RSA is disabled.");
  }

  /* Declared already in ossl_typ.h */
  /* alias rsa_st RSA; */
  /* alias rsa_meth_st RSA_METHOD; */
}

struct rsa_meth_st
	{
	const char* name;
	int function(int flen,ubyte* from,
			   ubyte* to,
			   RSA* rsa,int padding) rsa_pub_enc;
	int function(int flen,ubyte* from,
			   ubyte* to,
			   RSA* rsa,int padding) rsa_pub_dec;
	int function(int flen,ubyte* from,
			    ubyte* to,
			    RSA* rsa,int padding) rsa_priv_enc;
	int function(int flen,ubyte* from,
			    ubyte* to,
			    RSA* rsa,int padding) rsa_priv_dec;
	int function(BIGNUM *r0,BIGNUM *I,RSA* rsa,BN_CTX *ctx) rsa_mod_exp; /* Can be null */
	int function(BIGNUM *r, BIGNUM *a, BIGNUM *p,
			  BIGNUM *m, BN_CTX *ctx,
			  BN_MONT_CTX *m_ctx) bn_mod_exp; /* Can be null */
	int function(RSA* rsa) init;		/* called at new */
	int function(RSA* rsa) finish;	/* called at free */
	int flags;			/* RSA_METHOD_FLAG_* things */
	ubyte* app_data;			/* may be needed! */
/* New sign and verify functions: some libraries don't allow arbitrary data
 * to be signed/verified: this allows them to be used. Note: for this to work
 * the RSA_public_decrypt() and RSA_private_encrypt() should *NOT* be used
 * RSA_sign(), RSA_verify() should be used instead. Note: for backwards
 * compatibility this functionality is only enabled if the RSA_FLAG_SIGN_VER
 * option is set in 'flags'.
 */
	int function(int type,
		ubyte* m, uint m_length,
		ubyte* sigret, uint* siglen, RSA* rsa) rsa_sign;
	int function(int dtype,
		ubyte* m, uint m_length,
		ubyte* sigbuf, uint siglen, RSA* rsa) rsa_verify;
/* If this callback is NULL, the builtin software RSA key-gen will be used. This
 * is for behavioural compatibility whilst the code gets rewired, but one day
 * it would be nice to assume there are no such things as "builtin software"
 * implementations. */
	int function(RSA* rsa, int bits, BIGNUM *e, BN_GENCB *cb) rsa_keygen;
	};

struct rsa_st
	{
	/* The first parameter is used to pickup errors where
	 * this is passed instead of aEVP_PKEY, it is set to 0 */
	int pad;
	int _version;
	const RSA_METHOD* meth;
	/* functional reference if 'meth' is ENGINE-provided */
	ENGINE* engine;
	BIGNUM* n;
	BIGNUM* e;
	BIGNUM* d;
	BIGNUM* p;
	BIGNUM* q;
	BIGNUM* dmp1;
	BIGNUM* dmq1;
	BIGNUM* iqmp;
	/* be careful using this if the RSA structure is shared */
	CRYPTO_EX_DATA ex_data;
	int references;
	int flags;

	/* Used to cache montgomery values */
	BN_MONT_CTX* _method_mod_n;
	BN_MONT_CTX* _method_mod_p;
	BN_MONT_CTX* _method_mod_q;

	/* all BIGNUM values are actually in the following data, if it is not
	 * NULL */
	ubyte* bignum_data;
	BN_BLINDING* blinding;
	BN_BLINDING* mt_blinding;
	};

const RSA_3=0x3L;
const RSA_F4=0x10001L;

enum{
  RSA_METHOD_FLAG_NO_CHECK=0x0001, /* don't check pub/private match */
  RSA_FLAG_CACHE_PUBLIC=0x0002,
  RSA_FLAG_CACHE_PRIVATE=0x0004,
  RSA_FLAG_BLINDING=0x0008,
  RSA_FLAG_THREAD_SAFE=0x0010,
/* This flag means the private key operations will be handled by rsa_mod_exp
 * and that they do not depend on the private key components being present:
 * for example a key stored in external hardware. Without this flag bn_mod_exp
 * gets called when private key components are absent.
 */
  RSA_FLAG_EXT_PKEY=0x0020,

/* This flag in the RSA_METHOD enables the new rsa_sign, rsa_verify functions.
 */
  RSA_FLAG_SIGN_VER=0x0040,

  RSA_FLAG_NO_BLINDING=0x0080,		       /* new with 0.9.6j and 0.9.7b; the built-in
                                                * RSA implementation now uses blinding by
                                                * default (ignoring RSA_FLAG_BLINDING),
                                                * but other engines might not need it
                                                */
  RSA_FLAG_NO_EXP_CONSTTIME=0x0100,	       /* new with 0.9.7h; the built-in RSA
                                                * implementation now uses constant time
                                                * modular exponentiation for secret exponents
                                                * by default. This flag causes the
                                                * faster variable sliding window method to
                                                * be used for all exponents.
                                                */
}

enum{
  RSA_PKCS1_PADDING=1,
  RSA_SSLV23_PADDING=2,
  RSA_NO_PADDING=3,
  RSA_PKCS1_OAEP_PADDING=4,
  RSA_X931_PADDING=5,
}
const RSA_PKCS1_PADDING_SIZE=11;

//#define RSA_set_app_data(s,arg)         RSA_set_ex_data(s,0,arg)
//#define RSA_get_app_data(s)             RSA_get_ex_data(s,0)

RSA*	RSA_new();
RSA*	RSA_new_method(ENGINE* engine);
int	RSA_size(RSA*);

/* Deprecated version */
version(OPENSSL_NO_DEPRECATED){}else{
  RSA*	RSA_generate_key(int bits, uint e,void function(int,int,void*) callback,void* cb_arg);
} /* !defined(OPENSSL_NO_DEPRECATED) */

/* New version */
int	RSA_generate_key_ex(RSA* rsa, int bits, BIGNUM* e, BN_GENCB* cb);

int	RSA_check_key(RSA*);
	/* next 4 return -1 on error */
int	RSA_public_encrypt(int flen, ubyte* from,
		ubyte* to, RSA* rsa,int padding);
int	RSA_private_encrypt(int flen, ubyte* from,
		ubyte* to, RSA* rsa,int padding);
int	RSA_public_decrypt(int flen, ubyte* from, 
		ubyte* to, RSA* rsa,int padding);
int	RSA_private_decrypt(int flen, ubyte* from, 
		ubyte* to, RSA* rsa,int padding);
void	RSA_free (RSA* r);
/* "up" the RSA object's reference count */
int	RSA_up_ref(RSA* r);

int	RSA_flags(RSA* r);

void RSA_set_default_method(RSA_METHOD *meth);
RSA_METHOD *RSA_get_default_method();
RSA_METHOD *RSA_get_method(RSA* rsa);
int RSA_set_method(RSA* rsa, RSA_METHOD *meth);

/* This function needs the memory locking malloc callbacks to be installed */
int RSA_memory_lock(RSA* r);

/* these are the actual SSLeay RSA functions */
RSA_METHOD* RSA_PKCS1_SSLeay();

RSA_METHOD* RSA_null_method();

//DECLARE_ASN1_ENCODE_FUNCTIONS_const(RSA, RSAPublicKey)
//DECLARE_ASN1_ENCODE_FUNCTIONS_const(RSA, RSAPrivateKey)
//asn1.hを使って展開 ここから
RSA *d2i_RSAPublicKey(RSA** a, ubyte** _in, int len);
int i2d_RSAPublicKey(RSA* a, ubyte** _out);
RSA *d2i_RSAPrivateKey(RSA** a, ubyte** _in, int len);
int i2d_RSAPrivateKey(RSA* a, ubyte** _out);
//ここまで

version(OPENSSL_NO_FP_API){}else{
  int	RSA_print_fp(FILE *fp, RSA* r,int offset);
}

version(OPENSSL_NO_BIO){}else{
  int	RSA_print(BIO *bp, RSA* r,int offset);
}

int i2d_RSA_NET(RSA* a, ubyte** pp,
		int function(ubyte* buf, int len, ubyte* prompt, int verify) cb,
		int sgckey);
RSA* d2i_RSA_NET(RSA* *a, ubyte** pp, int length,
		 int function(ubyte* buf, int len, ubyte* prompt, int verify) cb,
		 int sgckey);

int i2d_Netscape_RSA(RSA* a, ubyte** pp,
		     int function(ubyte* buf, int len, ubyte* prompt,
			       int verify) cb);
RSA* d2i_Netscape_RSA(RSA* *a, ubyte** pp, int length,
		      int function(ubyte* buf, int len, ubyte* prompt,
				int verify) cb);

/* The following 2 functions sign and verify a X509_SIG ASN1 object
 * inside PKCS#1 padded RSA encryption */
int RSA_sign(int type, ubyte* m, uint m_length,
	ubyte* sigret, uint *siglen, RSA* rsa);
int RSA_verify(int type, ubyte* m, uint m_length,
	ubyte* sigbuf, uint siglen, RSA* rsa);

/* The following 2 function sign and verify a ASN1_OCTET_STRING
 * object inside PKCS#1 padded RSA encryption */
int RSA_sign_ASN1_OCTET_STRING(int type,
	ubyte* m, uint m_length,
	ubyte* sigret, uint *siglen, RSA* rsa);
int RSA_verify_ASN1_OCTET_STRING(int type,
	ubyte* m, uint m_length,
	ubyte* sigbuf, uint siglen, RSA* rsa);

int RSA_blinding_on(RSA* rsa, BN_CTX *ctx);
void RSA_blinding_off(RSA* rsa);
BN_BLINDING *RSA_setup_blinding(RSA* rsa, BN_CTX *ctx);

int RSA_padding_add_PKCS1_type_1(ubyte* to,int tlen,
	ubyte* f,int fl);
int RSA_padding_check_PKCS1_type_1(ubyte* to,int tlen,
	ubyte* f,int fl,int rsa_len);
int RSA_padding_add_PKCS1_type_2(ubyte* to,int tlen,
	ubyte* f,int fl);
int RSA_padding_check_PKCS1_type_2(ubyte* to,int tlen,
	ubyte* f,int fl,int rsa_len);
int PKCS1_MGF1(ubyte* mask, int len,
	ubyte* seed, int seedlen, EVP_MD *dgst);
int RSA_padding_add_PKCS1_OAEP(ubyte* to,int tlen,
	ubyte* f,int fl,
	ubyte* p,int pl);
int RSA_padding_check_PKCS1_OAEP(ubyte* to,int tlen,
	ubyte* f,int fl,int rsa_len,
	ubyte* p,int pl);
int RSA_padding_add_SSLv23(ubyte* to,int tlen,
	ubyte* f,int fl);
int RSA_padding_check_SSLv23(ubyte* to,int tlen,
	ubyte* f,int fl,int rsa_len);
int RSA_padding_add_none(ubyte* to,int tlen,
	ubyte* f,int fl);
int RSA_padding_check_none(ubyte* to,int tlen,
	ubyte* f,int fl,int rsa_len);
int RSA_padding_add_X931(ubyte* to,int tlen,
	ubyte* f,int fl);
int RSA_padding_check_X931(ubyte* to,int tlen,
	ubyte* f,int fl,int rsa_len);
int RSA_X931_hash_id(int nid);

int RSA_verify_PKCS1_PSS(RSA* rsa, ubyte* mHash,
			EVP_MD *Hash, ubyte* EM, int sLen);
int RSA_padding_add_PKCS1_PSS(RSA* rsa, ubyte* EM,
			ubyte* mHash,
			EVP_MD *Hash, int sLen);

int RSA_get_ex_new_index(int argl, void *argp, CRYPTO_EX_new *new_func,
	CRYPTO_EX_dup *dup_func, CRYPTO_EX_free *free_func);
int RSA_set_ex_data(RSA* r,int idx,void *arg);
void *RSA_get_ex_data(RSA* r, int idx);

RSA* RSAPublicKey_dup(RSA* rsa);
RSA* RSAPrivateKey_dup(RSA* rsa);

/* BEGIN ERROR CODES */
/* The following lines are auto generated by the script mkerr.pl. Any changes
 * made after this point may be overwritten when the script is next run.
 */
void ERR_load_RSA_strings();

/* Error codes for the RSA functions. */

/* Function codes. */
enum{
  RSA_F_MEMORY_LOCK=100,
  RSA_F_RSA_BUILTIN_KEYGEN=129,
  RSA_F_RSA_CHECK_KEY=123,
  RSA_F_RSA_EAY_PRIVATE_DECRYPT=101,
  RSA_F_RSA_EAY_PRIVATE_ENCRYPT=102,
  RSA_F_RSA_EAY_PUBLIC_DECRYPT=103,
  RSA_F_RSA_EAY_PUBLIC_ENCRYPT=104,
  RSA_F_RSA_GENERATE_KEY=105,
  RSA_F_RSA_MEMORY_LOCK=130,
  RSA_F_RSA_NEW_METHOD=106,
  RSA_F_RSA_NULL=124,
  RSA_F_RSA_NULL_MOD_EXP=131,
  RSA_F_RSA_NULL_PRIVATE_DECRYPT=132,
  RSA_F_RSA_NULL_PRIVATE_ENCRYPT=133,
  RSA_F_RSA_NULL_PUBLIC_DECRYPT=134,
  RSA_F_RSA_NULL_PUBLIC_ENCRYPT=135,
  RSA_F_RSA_PADDING_ADD_NONE=107,
  RSA_F_RSA_PADDING_ADD_PKCS1_OAEP=121,
  RSA_F_RSA_PADDING_ADD_PKCS1_PSS=125,
  RSA_F_RSA_PADDING_ADD_PKCS1_TYPE_1=108,
  RSA_F_RSA_PADDING_ADD_PKCS1_TYPE_2=109,
  RSA_F_RSA_PADDING_ADD_SSLV23=110,
  RSA_F_RSA_PADDING_ADD_X931=127,
  RSA_F_RSA_PADDING_CHECK_NONE=111,
  RSA_F_RSA_PADDING_CHECK_PKCS1_OAEP=122,
  RSA_F_RSA_PADDING_CHECK_PKCS1_TYPE_1=112,
  RSA_F_RSA_PADDING_CHECK_PKCS1_TYPE_2=113,
  RSA_F_RSA_PADDING_CHECK_SSLV23=114,
  RSA_F_RSA_PADDING_CHECK_X931=128,
  RSA_F_RSA_PRINT=115,
  RSA_F_RSA_PRINT_FP=116,
  RSA_F_RSA_SETUP_BLINDING=136,
  RSA_F_RSA_SIGN=117,
  RSA_F_RSA_SIGN_ASN1_OCTET_STRING=118,
  RSA_F_RSA_VERIFY=119,
  RSA_F_RSA_VERIFY_ASN1_OCTET_STRING=120,
  RSA_F_RSA_VERIFY_PKCS1_PSS=126,
}

/* Reason codes. */
enum{
  RSA_R_ALGORITHM_MISMATCH=100,
  RSA_R_BAD_E_VALUE=101,
  RSA_R_BAD_FIXED_HEADER_DECRYPT=102,
  RSA_R_BAD_PAD_BYTE_COUNT=103,
  RSA_R_BAD_SIGNATURE=104,
  RSA_R_BLOCK_TYPE_IS_NOT_01=106,
  RSA_R_BLOCK_TYPE_IS_NOT_02=107,
  RSA_R_DATA_GREATER_THAN_MOD_LEN=108,
  RSA_R_DATA_TOO_LARGE=109,
  RSA_R_DATA_TOO_LARGE_FOR_KEY_SIZE=110,
  RSA_R_DATA_TOO_LARGE_FOR_MODULUS=132,
  RSA_R_DATA_TOO_SMALL=111,
  RSA_R_DATA_TOO_SMALL_FOR_KEY_SIZE=122,
  RSA_R_DIGEST_TOO_BIG_FOR_RSA_KEY=112,
  RSA_R_DMP1_NOT_CONGRUENT_TO_D=124,
  RSA_R_DMQ1_NOT_CONGRUENT_TO_D=125,
  RSA_R_D_E_NOT_CONGRUENT_TO_1=123,
  RSA_R_FIRST_OCTET_INVALID=133,
  RSA_R_INVALID_HEADER=137,
  RSA_R_INVALID_MESSAGE_LENGTH=131,
  RSA_R_INVALID_PADDING=138,
  RSA_R_INVALID_TRAILER=139,
  RSA_R_IQMP_NOT_INVERSE_OF_Q=126,
  RSA_R_KEY_SIZE_TOO_SMALL=120,
  RSA_R_LAST_OCTET_INVALID=134,
  RSA_R_NO_PUBLIC_EXPONENT=140,
  RSA_R_NULL_BEFORE_BLOCK_MISSING=113,
  RSA_R_N_DOES_NOT_EQUAL_P_Q=127,
  RSA_R_OAEP_DECODING_ERROR=121,
  RSA_R_PADDING_CHECK_FAILED=114,
  RSA_R_P_NOT_PRIME=128,
  RSA_R_Q_NOT_PRIME=129,
  RSA_R_RSA_OPERATIONS_NOT_SUPPORTED=130,
  RSA_R_SLEN_CHECK_FAILED=136,
  RSA_R_SLEN_RECOVERY_FAILED=135,
  RSA_R_SSLV3_ROLLBACK_ATTACK=115,
  RSA_R_THE_ASN1_OBJECT_IDENTIFIER_IS_NOT_KNOWN_FOR_THIS_MD=116,
  RSA_R_UNKNOWN_ALGORITHM_TYPE=117,
  RSA_R_UNKNOWN_PADDING_TYPE=118,
  RSA_R_WRONG_SIGNATURE_LENGTH=119,
}


