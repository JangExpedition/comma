package mail;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
 
public class Gmail extends Authenticator{
    
	final String SMTP_HOST_ADDR = "smtp.gmail.com";	// "smtp.gmail.com"
	final int SMTP_HOST_PORT = 587;
	final String TO_MAIN_EMAIL_ID = "jangcccci@gmail.com";	// 계정
	final String MAIN_EMAIL_PW = "qquywvvhqpjxsehz";	// 앱비밀번호
	
	public void send(String[] fromInfo) {
		Properties prop = new Properties();
        prop.put("mail.smtp.host", SMTP_HOST_ADDR); 
        prop.put("mail.smtp.port", SMTP_HOST_PORT); 
        prop.put("mail.smtp.auth", "true"); 
        prop.put("mail.smtp.ssl.enable", "true"); 
        prop.put("mail.smtp.ssl.trust", SMTP_HOST_ADDR);
	        
        Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(TO_MAIN_EMAIL_ID, MAIN_EMAIL_PW);
            }
        });
        
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(TO_MAIN_EMAIL_ID));

            //수신자메일주소
            InternetAddress[] toAddr = new InternetAddress[1];
            toAddr[0] = new InternetAddress (TO_MAIN_EMAIL_ID); 
            message.setRecipients(Message.RecipientType.TO, toAddr);

            // Subject
            message.setSubject(fromInfo[2]);

            // Text
            message.setText(fromInfo[4]);

            // send the message
            Transport.send(message);
            System.out.println("message sent successfully!!");
        } catch (AddressException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (MessagingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

	}
}