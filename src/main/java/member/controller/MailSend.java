package member.controller;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import member.model.dto.Mail;

public class MailSend {

    public String mailSend(String clientMail) {
        Properties prop = System.getProperties();
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.port", "587");

        Authenticator auth = new Mail();
        Session session = Session.getDefaultInstance(prop, auth);
        MimeMessage msg = new MimeMessage(session);
        int code = (int)(Math.random()*899999+100000);

        try {
            msg.setSentDate(new Date());
            msg.setFrom(new InternetAddress("jangcccci@gmail.com", "COMMA"));
            InternetAddress to = new InternetAddress(clientMail);         
            msg.setRecipient(Message.RecipientType.TO, to);            
            msg.setSubject("제목", "UTF-8");            
            msg.setText("안녕하세요 테스트 메일입니다." + code, "UTF-8");            

            Transport.send(msg);

        } catch(AddressException ae) {            
            System.out.println("AddressException : " + ae.getMessage());           
        } catch(MessagingException me) {            
            System.out.println("MessagingException : " + me.getMessage());
        } catch(UnsupportedEncodingException e) {
            System.out.println("UnsupportedEncodingException : " + e.getMessage());
        }
        
        return Integer.toString(code);
        
    }

}
