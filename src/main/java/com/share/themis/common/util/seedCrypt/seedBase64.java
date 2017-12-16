package com.share.themis.common.util.seedCrypt;

import java.io.IOException;

public class seedBase64
{

    //Round keys for encryption or decryption
    private static int pdwRoundKey[] = new int[32];
    

    /**
     * SEED 암호화
     * @param txt 복호화 문자열
     * @param key 암호화 key
     * @return
     */
    public static String encrypted( String txt, String key ){
        String  encryptSeedTxt = "";
        try{
            if(txt == null || "".equals(txt)){
                return encryptSeedTxt;
            }
            byte UserKey[]   =key.getBytes();
            encryptSeedTxt = encryptSeedBase64(txt, UserKey);
        }catch(Exception e){
            e.printStackTrace();
        }
        return encryptSeedTxt;
    } 
       
    
    /**
     * SEED 복호화
     * @param txt 암호화 문자열
     * @param key 복호화 key
     * @return
     */
    public static String decrypted( String txt, String key ){
        String  decryptSeedTxt = "";
        try{
            if(txt == null || "".equals(txt)){
                return decryptSeedTxt;
            }
            byte UserKey[]   =key.getBytes();
            decryptSeedTxt = decryptSeedBase64(txt, UserKey);
        }catch(Exception e){
            e.printStackTrace();
        }
        return decryptSeedTxt;
    } 
       
    
    public static String encryptSeedBase64(String txt, byte pbUserKey[]) throws Exception{
        String resultEnc = null;
        try{
            String strenc = txt;
            
            //byte 수 채우기
            int max = 0;
            if(strenc.getBytes().length % 16 != 0){
                max = 16-(strenc.getBytes().length % 16);   
            }
            
            for(int i=0; i<max ; i++){
                strenc += " ";
            }   
            
            int size = strenc.getBytes().length;
            
            //input plaintext to be encrypted
            byte pbData[]     = strenc.getBytes("UTF-8");

            byte pbCipher[]   = new byte[ 16 ];
            byte reData[][]   = new byte[ size/16 ][16];
            byte reCipher[]   = new byte[ size ];       

            //Derive roundkeys from user secret key
            seedx.SeedRoundKey(pdwRoundKey, pbUserKey);     

            //Encryption
            int b1=0, b2=0; 
            for(int i=0; i < size; i++){
                b1 = (i / 16);
                b2 = (i % 16);                  
                reData[ b1 ][ b2 ] = pbData[i];             
            }
            int rf = 0;
            
            for(int i=0; i<reData.length; i++){
                seedx.SeedEncrypt(reData[i], pdwRoundKey, pbCipher);                
                for(int j=0; j<pbCipher.length; j++){
                    reCipher[rf++] = pbCipher[j];
                }
            }
            
            byte[] bEnc = reCipher;
            resultEnc = Base64.encodeBytes(bEnc);       
            
            
        }catch(Exception e){
            throw e;
        }
        return resultEnc;
    }
    
    public static String decryptSeedBase64(String Cipher, byte pbUserKey[]) throws Exception{
        String strdec=null;
        byte[] reCipher =Base64.decode(Cipher);
        try{
            int size = reCipher.length;
            
            byte pbPlain[]    = new byte[ 16 ];
            byte reData[][]   = new byte[ size/16 ][16];            
            byte rePlain[]    = new byte[ size ];

            //Derive roundkeys from user secret key
            seedx.SeedRoundKey(pdwRoundKey, pbUserKey);     

            //Decryption        
            int b1=0, b2=0; 
            for(int i=0; i<size; i++){
                b1 = (i / 16);
                b2 = (i % 16);                          
                reData[ b1 ][ b2 ] = reCipher[i];               
            }       
            int rf = 0; 
            for(int i=0; i<reData.length; i++){
                seedx.SeedDecrypt(reData[i], pdwRoundKey, pbPlain); 
                for(int j=0; j<pbPlain.length; j++){
                    rePlain[rf++] = pbPlain[j];
                }
            }
            String strdecNotrim = new String(rePlain ,"UTF-8");
            if(strdecNotrim != null){
                strdec = strdecNotrim.trim();
            }
        }catch(IOException e){
            throw e;
        }catch(Exception e){
            throw e;
        }
        
            return strdec;
    }
}