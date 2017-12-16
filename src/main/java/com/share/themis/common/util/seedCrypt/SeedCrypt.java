package com.share.themis.common.util.seedCrypt;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import com.share.themis.common.util.ConfigUtils;
import com.share.themis.common.util.seedCrypt.seedBase64;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SeedCrypt {

    private static final Logger logger = LoggerFactory.getLogger(SeedCrypt.class);
    private static String cryptKey = ConfigUtils.getString("webService.cryptKey");

    /**
     * encrypt
     * @param text
     * @param key
     * @return
     */
    public static String encrypt(String text, String key) {
        String encryptText = "";
        try {
            Random ran = new Random();  //보안에 필요한 랜덤값(영문대문자4개)
            String psk = "";
            for(int i=0 ; i<4 ; i++){
                char chr = (char)(ran.nextInt(26) + 65);
                psk += chr;
            }
            //logger.info("Random psk is " + psk);
            text = psk+text;
            encryptText = seedBase64.encrypted(text, key);
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
        return encryptText;
    }

    /**
     * decrypt
     * @param encryptText
     * @param key
     * @return
     */
    public static String decrypt(String encryptText, String key) {
        String decryptText = "";
        try {
            decryptText = seedBase64.decrypted(encryptText, key);
            //logger.debug("decryptText! "+decryptText);
            if(decryptText.length() < 4){
                return "";
            }else{
                decryptText =  decryptText.substring(4, decryptText.length());
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
        return decryptText;
    }

    /**
     * encrypt
     * @param text
     * @return
     */
    public static String encrypt(String text) {
        String encryptText = "";
        try {
            Random ran = new Random();  //보안에 필요한 랜덤값(영문대문자4개)
            String psk = "";
            for(int i=0 ; i<4 ; i++){
                char chr = (char)(ran.nextInt(26) + 65);
                psk += chr;
            }
            //logger.info("Random psk is " + psk);
            text = psk+text;
            encryptText = seedBase64.encrypted(text, cryptKey);
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
        return encryptText;
    }

    /**
     * decrypt
     * @param encryptText
     * @return
     */
    public static String decrypt(String encryptText) {
        String decryptText = "";
        try {
            decryptText = seedBase64.decrypted(encryptText, cryptKey);
            //logger.debug("decryptText! "+decryptText);
            if(decryptText.length() < 4){
                return "";
            }else{
                decryptText =  decryptText.substring(4, decryptText.length());
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
        return decryptText;
    }
    
      public static String encryptSHA256(String value) throws NoSuchAlgorithmException{
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(value.getBytes());
     
            byte byteData[] = md.digest();
     
            //convert the byte to hex format method 1
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
             sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
            }
     
            //convert the byte to hex format method 2
            StringBuffer hexString = new StringBuffer();
            for (int i=0;i<byteData.length;i++) {
                String hex=Integer.toHexString(0xff & byteData[i]);
                if(hex.length()==1) hexString.append('0');
                hexString.append(hex);
            }
          return hexString.toString();
      }

      
      public static String getNewPassword(){
            String password = "";
            // 48~57 0~9
            // 58~64 특수 문자
            // 65~90 A~Z
            // 91~96 사이 특수 문자
            // 97~122 a~z
            int x = 0;
            int temp = 0;
            while (x < 8) {
                // 특수문자 필요 없다면 아래 if 문 추가
                //
                temp = (char)((Math.random()*75)+48);
                if( (temp >= 58 && temp <= 64) || (temp >= 91 && temp <= 96) ){
                    continue;
                }
                
                password += (char)temp;
                
                //password += (char)((Math.random()*75)+48);
                
                System.out.println("x= " + x + "password = " +password);
                x++;
            }
            
            return password;
        }

    /**
     * @param args
     */
    public static void main(String[] args) {
        try {
        	String asd= AES.aesDecode("vsNSN22j9scoCIiZisDX9sROydTfAmj969Uq+DOJGfvTDHg3UU1nzcA/nM+IW8cN0tFt9iXQPEytOcMAp6RNdA==", "abcdefghijklmnopqrstuvwxyz123456");
        	System.out.println(asd);
            System.out.println(encrypt("남정우", "5EBAC6E0054E166819AFF1CC6D346CDB"));
            System.out.println(decrypt(encrypt("남정우", "5EBAC6E0054E166819AFF1CC6D346CDB"),"5EBAC6E0054E166819AFF1CC6D346CDB"));
            System.out.println(encryptSHA256("ppqq11"));
            System.out.println(encryptSHA256("ppqq11"));
            System.out.println(encryptSHA256("123456"));
            System.out.println("구분");
            System.out.println(encryptSHA256("eris"));
            System.out.println("11a05b637b7f8eb058c6e9a8600e769f1b3944d0f727501c6016577289142ab1");
            System.out.println(getNewPassword());
            System.out.println(getNewPassword());
//          System.out.println(encrypt("Seed"));
//          System.out.println(decrypt(encrypt("Seed")));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
