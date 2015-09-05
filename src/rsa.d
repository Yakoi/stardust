private import mylib.rsa,std.stdio,std.string;
static class RsaKey{
  ///新規キーを作成して返します。
  static RSA* createKey(){
    return RSA_generate_key(192,65537,null,null);
  };
  ///空のキーを返します。
  static RSA* getKey(){
    return RSA_new();
  }
}

class Rsa{
  private{
    RSA* key;
  }
  public{
    ubyte[] getPublicKey(){
      char[] re;
      ubyte* _pub;
      int len=i2d_RSAPublicKey(this.key,&_pub);
      if(!_pub||len<0)throw new Exception("i2d_RSAPublicKey faild");
      ubyte[] pub;
      pub=_pub[0..len];
      return pub;
    }
    ubyte[] getPrivateKey(){
      char[] re;
      ubyte* _priv;
      int len=i2d_RSAPrivateKey(this.key,&_priv);
      if(!_priv||len<0)throw new Exception("i2d_RSAPrivateKey faild");
      ubyte[] priv;
      priv=_priv[0..len];
      return priv;
    }
    void setPublicKey(ubyte[] pubkey){
      ubyte* p=cast(ubyte*)pubkey;
      this.key=d2i_RSAPublicKey(&this.key,&p,pubkey.length);
    }
    void setPrivateKey(ubyte[] prkey){
      ubyte* p=cast(ubyte*)prkey;
      this.key=d2i_RSAPrivateKey(&this.key,&p,prkey.length);
    }
    ubyte[] crypt(ubyte[] plain){
      int rv;
      ubyte[] crypted=new ubyte[RSA_size(key)];
      rv=RSA_public_encrypt(plain.length,plain.ptr,crypted.ptr,this.key,RSA_PKCS1_PADDING);
      if(rv<0)throw new Exception("RSA_public_encrypt faild");
      return crypted;
    }
    ubyte[] decrypt(ubyte[] crypted){
      int rv;
      ubyte[] decrypted=new ubyte[RSA_size(key)];
      rv=RSA_private_decrypt(crypted.length,crypted.ptr,decrypted.ptr,this.key,RSA_PKCS1_PADDING);
      if(rv<0)throw new Exception("RSA_private_decrypt faild");
      return decrypted;
    }
    private void free(){
      RSA_free(this.key);
    }
    this(RSA* key){
      this.key=key;
    }
    this(){
      this.key=RSA_new();
    }
    ~this(){
      free();
    }
  }
}

char[] ubyteToString(ubyte[] data){
  char[] re;
  foreach(ubyte b;data){
    re~=format("%02x",b);
  }
  return re;
}

ubyte[] stringToUbyte(char[] data){
  ubyte[] re;
  re.length=data.length/2;
  for(int i;data.length > i*2;i++){
    re[i]=cast(ubyte)(((data[i*2]<'a'?data[i*2]-'0':data[i*2]-'a'+10)<<4)+(data[i*2+1]<'a'?data[i*2+1]-'0':data[i*2+1]-'a'+10));
  }
  return re;
}

int main(){
  Rsa myrsa=new Rsa(RsaKey.createKey());
  ubyte[] pubkey=myrsa.getPublicKey();
  ubyte[] prkey=myrsa.getPrivateKey();
  writef("publicKey:0x%s\n",ubyteToString(pubkey));
  writef("privateKey:0x%s\n",ubyteToString(prkey));
  myrsa.setPublicKey(pubkey);
  myrsa.setPrivateKey(prkey);
  ubyte[] test=myrsa.crypt(cast(ubyte[])"test");
  writef("%s\n",test);
  writef("%s\n",cast(char[])myrsa.decrypt(test));
  myrsa=new Rsa(RsaKey.getKey());
  myrsa.setPublicKey(pubkey);
  myrsa.setPrivateKey(prkey);
  writef("%s\n",cast(char[])myrsa.decrypt(test));
  delete myrsa;
  return 0;
}
