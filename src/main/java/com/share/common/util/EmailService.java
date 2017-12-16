package com.share.common.util;

import java.util.Properties;
import java.util.Stack;



import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;



import com.share.themis.common.map.DataMap;
import com.share.themis.common.util.ConfigUtils;

public class EmailService{
	//email setting	
	private static  String sender           = "";
	private static  String ksccSender       = "";
	private static  String web_host         = "";
	private static  String SMTP_SERVER_IP   = "";
	private static  String SMTP_SERVER_PORT = "";
	private static  String SMTP_SERVER_AUTH = "";
	
	//PasswordAuthentication setting
	private static String AUTH_ID          = "";
	private static String AUTH_PW          = "";
	
	private Stack stack              = null;
	
	public EmailService(){
		sender           = ConfigUtils.getString("email.sender"); 
		ksccSender       = ConfigUtils.getString("email.ksccSender"); 
		web_host         = ConfigUtils.getString("email.web_host"); 
		SMTP_SERVER_IP   = ConfigUtils.getString("email.SMTP_SERVER_IP"); 
		SMTP_SERVER_PORT = ConfigUtils.getString("email.SMTP_SERVER_PORT"); 
		SMTP_SERVER_AUTH = ConfigUtils.getString("email.SMTP_SERVER_AUTH");
		AUTH_ID          = ConfigUtils.getString("email.AUTH_ID");
		AUTH_PW          = ConfigUtils.getString("email.AUTH_PW");
	}
	
	/**
	 * 
	 * @param name : 
	 * @param mobileNo : 
	 * @param title : 
	 * @param data : 
	 * @param mailAddress : 
	 * @throws TosaException
	 */
	public static void sendMail(DataMap dataMap, String pwd, String mailAddress) throws Exception{
			String from = null;
			String to = null;
			String subject = null;
			String content = null;
			
			content = setHtmlAccountAccess(dataMap, pwd);
			
			subject = "임시비밀번호 발송~";
			
			from = sender;
			
			//from = sender;
			to  = mailAddress;
			
			Authenticator auth = new PopupAuthenticator();
			
			// SMTP 
			Properties p = System.getProperties();
			
			p.put("mail.smtp.host", SMTP_SERVER_IP);
			p.put("mail.smtp.port", SMTP_SERVER_PORT);
			p.put("mail.smtp.auth", SMTP_SERVER_AUTH);
	
			// Session MimeMessage 
			Session session = Session.getInstance(p, auth);
			MimeMessage msg = new MimeMessage(session);
	
			msg.setFrom(new InternetAddress(from));
	
			InternetAddress[] address = { new InternetAddress(to) };
	
			msg.setRecipients(Message.RecipientType.TO, address);
			msg.setSubject(subject);
			msg.setSentDate(new java.util.Date());
	
			msg.setContent(content, "text/html; charset=euc-kr");
	 
			MimeBodyPart bodypart = new MimeBodyPart();
			bodypart.setContent(content, "text/html;charset=euc-kr");
	
			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(bodypart);
			msg.setContent(multipart);
	
			Transport.send(msg);
	}
	
	/**
	 * 
	 * @param dataMap
	 * @param pwd
	 * @param mailAddress
	 * @throws Exception
	 */
	public static void sendMailAccountAccess(DataMap dataMap, String pwd, String mailAddress) throws Exception{

		String from = null;
		String to = null;
		String subject = null;
		String content = null;
		
		content = setHtmlAccountAccess(dataMap, pwd);
		subject = "가입승인~";
		from = sender;
		//from = sender;
		to  = mailAddress;

		Authenticator auth = new PopupAuthenticator();

		// SMTP 
		Properties p = System.getProperties();
		
		p.put("mail.smtp.host", SMTP_SERVER_IP);
		p.put("mail.smtp.port", SMTP_SERVER_PORT);
		p.put("mail.smtp.auth", SMTP_SERVER_AUTH);

		// Session MimeMessage 
		Session session = Session.getInstance(p, auth);
		MimeMessage msg = new MimeMessage(session);

		msg.setFrom(new InternetAddress(from));

		InternetAddress[] address = { new InternetAddress(to) };

		msg.setRecipients(Message.RecipientType.TO, address);
		msg.setSubject(subject);
		msg.setSentDate(new java.util.Date());

		msg.setContent(content, "text/html; charset=euc-kr");

		MimeBodyPart bodypart = new MimeBodyPart();
		bodypart.setContent(content, "text/html;charset=euc-kr");

		Multipart multipart = new MimeMultipart();
		multipart.addBodyPart(bodypart);
		msg.setContent(multipart); 

		Transport.send(msg);
	}
	
	static class PopupAuthenticator extends Authenticator {
		public PasswordAuthentication getPasswordAuthentication() {
			//return new PasswordAuthentication("abcd", "abcd#test@12");
			//return new PasswordAuthentication("abcd", "abcd@12");			// real Server(119.205.200.114)
			return new PasswordAuthentication(AUTH_ID, AUTH_PW);			// Testl Server(119.205.200.77)
		}
	}
	
	  /**
	 * 
	 * @param dataMap
	 * @param pwd
	 * @return
	 */
	private static String setHtmlAccountAccess(DataMap dataMap, String pwd) {
		StringBuffer strHTML = new StringBuffer();
		
		strHTML.append("<html> \n");
		strHTML.append("<body> \n");
		strHTML.append("<table width=\"650\" border=\"0\"> \n");
		strHTML.append("<tr><td width=\"2%\">&nbsp;</td><td> \n");
		strHTML.append("<br><font style=\"line-height:25px\"> \n");
		strHTML.append("</body> \n");
		strHTML.append("</html> \n");
		
		return strHTML.toString();
	}	
	
	
	/**
	 * testing logic 
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception{
		
		String[] email = new String[]{"test@gmail.com"};
		
		for(int i=0; i<email.length; i++){
			//System.out.println("i : " + i);
			//sendMail("test", "", "ID_임시", "PASS_임시", email[i]);
			//Thread.sleep(500);
		}
	}
}
