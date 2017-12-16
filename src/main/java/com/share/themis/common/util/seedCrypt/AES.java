package com.share.themis.common.util.seedCrypt;

import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;


public class AES {
	private static String masterKey = "abcdefghijklmnopqrstuvwxyz123456";
	private static byte[] ivBytes = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
	public static void main(String[] args) throws Exception {
		
		/*
		String str = "Q9pBJaqGDYPbuATFmqAAazgbdZlQe6JxuVuoG+qenIU=";
		byte[] textBytes = Base64.decodeBase64(str);
		AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivBytes);
		SecretKeySpec newKey = new SecretKeySpec(masterKey.getBytes("UTF-8"), "AES");
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.DECRYPT_MODE, newKey, ivSpec);
		new String(cipher.doFinal(textBytes), "UTF-8");
		System.out.println(new String(cipher.doFinal(textBytes), "UTF-8"));
		*/
		
		// 한글 테스트
		System.out.println("<<<< 한글 테스트 >>>> message = 가나다라마바");
		String message = "가나다라마바";
		String aesEncodeTemp = aesEncode(message, masterKey);
		System.out.println("aesEncodeTemp : " + aesEncodeTemp);
		
		String aesDecodeTemp = aesDecode(aesEncodeTemp, masterKey);
		System.out.println("aesDecodeTemp : " + aesDecodeTemp);
		
		
		// 영문, 숫자 테스트
		System.out.println("<<<< 영문, 숫자 테스트 >>>> message = abcdefg1234567890");
		message = "abcdefg1234567890";
		aesEncodeTemp = aesEncode(message, masterKey);
		System.out.println("aesEncodeTemp : " + aesEncodeTemp);
		
		aesDecodeTemp = aesDecode(aesEncodeTemp, masterKey);
		System.out.println("aesDecodeTemp : " + aesDecodeTemp);
		
		// 특수문자
		System.out.println("<<<< 특수문자 테스트 >>>> message = !@#$%^&*()-=");
		message = "!@#$%^&*()-=";
		aesEncodeTemp = aesEncode(message, masterKey);
		System.out.println("aesEncodeTemp : " + aesEncodeTemp);
		
		aesDecodeTemp = aesDecode(aesEncodeTemp, masterKey);
		System.out.println("aesDecodeTemp : " + aesDecodeTemp);
		
		// 혼합문자
		System.out.println("<<<< 혼합문자 테스트 >>>> message = 가나다1234abcd-----1A@dF4Ttg한글");
		message = "가나다1234abcd-----1A@dF4Ttg한글";
		aesEncodeTemp = aesEncode(message, masterKey);
		System.out.println("aesEncodeTemp : " + aesEncodeTemp);
		
		aesDecodeTemp = aesDecode(aesEncodeTemp, masterKey);
		System.out.println("aesDecodeTemp : " + aesDecodeTemp);
	}


	public static String aesEncode(String str, String key) throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException,	IllegalBlockSizeException, BadPaddingException {

		byte[] textBytes = str.getBytes("UTF-8");
		AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivBytes);
		SecretKeySpec newKey = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
		Cipher cipher = null;
		cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, newKey, ivSpec);
		return Base64.encodeBase64String(cipher.doFinal(textBytes));
	}

	public static String aesDecode(String str, String key) throws java.io.UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {

		byte[] textBytes = Base64.decodeBase64(str);
		//byte[] textBytes = str.getBytes("UTF-8");
		AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivBytes);
		SecretKeySpec newKey = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.DECRYPT_MODE, newKey, ivSpec);
		return new String(cipher.doFinal(textBytes), "UTF-8");
	}



}