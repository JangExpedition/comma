package mail;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Mail {
	
	public String sendMail(String clientEmail) {
		String host = "http://localhost:8080/comma/";
		String from = "jangcccci@gmail.com";
		String to = clientEmail;
		String subject = "쉼표, 가입인증 메일입니다.";
		int _code = (int)(Math.random()*899999+100000);
		String code = Integer.toString(_code);
		String content = "인증번호는 " + code + "입니다.";
		
		Properties p = new Properties();
		p.put("mail.smtp.user", from);
		p.put("mail.smtp.host", "smtpgooglemail.com");
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		
		try {
			Authenticator auth = new Gmail();
			Session session = Session.getInstance(p, auth);
			session.setDebug(true);
			MimeMessage msg =  new MimeMessage(session);
			msg.setSubject(subject);
			Address fromAddr = new InternetAddress(from);
			msg.setFrom(fromAddr);
			Address toAddr = new InternetAddress(to);
			msg.addRecipient(Message.RecipientType.TO, toAddr);
			msg.setContent(content, "text/html;charset=UTF8");
			Transport.send(msg);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return code;
	}
}