package com.share.common.util;



import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

public class DES {
	private static String keyFilePath = "d:/Secret.ser";
    public static byte[] Encryption(byte[] paramater) throws Exception {
		SecretKeySpec newKey = null;
		Key ChiperKey = LoadKey(keyFilePath);
		
		try {
			Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
			cipher.init(Cipher.ENCRYPT_MODE, ChiperKey);

			byte[] encrypt = cipher.doFinal(paramater);

			return encrypt;
			
		} catch (Exception e) {
			System.out.println("encrypt error : " + e.getMessage());
			return null;
		}
	}
    
    //String��ȣȭ
    public static String EncryptionString(String paramater, String keyPath) throws Exception {
		SecretKeySpec newKey = null;
		
		Key ChiperKey = LoadKey(keyPath);
		
		try {
			Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
			cipher.init(Cipher.ENCRYPT_MODE, ChiperKey);

			byte[] encrypt = cipher.doFinal(paramater.getBytes());

			return new String(Base64.encodeBase64(encrypt));
			
		} catch (Exception e) {
			System.out.println("encrypt error : " + e.getMessage());
			return null;
		}
	}
    
    public static byte[] Decryption(byte[] paramater) throws Exception{
		SecretKeySpec newKey = null;
		
		Key ChiperKey = LoadKey(keyFilePath);
		try {
			Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, ChiperKey);

			return cipher.doFinal(paramater);
			
		} catch (Exception e) {
			System.out.println("decrypt error : " + e.getMessage());
			return null;
		}
    }
    
    public static String DecryptionString(String paramater, String keyPath) throws Exception{
		SecretKeySpec newKey = null;
		Key ChiperKey = LoadKey(keyPath);

		try {
			Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, ChiperKey);
			
			byte[] decrypt = cipher.doFinal(Base64.decodeBase64(paramater.getBytes()));
			
			return new String(decrypt);
			
		} catch (Exception e) {
			System.out.println("decrypt error : " + e.getMessage());
			return null;
		}
    }
    
	public static Key LoadKey(String filePath) throws Exception{
		FileInputStream fis = null;
		ObjectInputStream ois = null;

		try {
			fis = new FileInputStream(filePath);
			ois = new ObjectInputStream(fis);
			return (Key)ois.readObject();
								
		} catch (Exception e) {
			e.printStackTrace();
			//e.System.out.println(e);
			return null;
		} finally {
			if (ois!=null) {
				try {
					ois.close();
				} catch (Exception e) {}
			}
		}
		
	}
	
	public static File makeSecureFile(String securityFileName) throws Exception{
		File file = new File(securityFileName);
		
		try {
			KeyGenerator generator = KeyGenerator.getInstance("DES");
			generator.init(new SecureRandom());
			
			Key key = generator.generateKey();
			ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream(file));
			out.writeObject(key);
			out.close();
		}catch (IOException ioe) {
			System.out.println("IOException : " + ioe.getMessage());
		}catch (NoSuchAlgorithmException nsae) {
			System.out.println("NoSuchAlgorithmException : " + nsae.getMessage());
		}
		return file;
	}
}
