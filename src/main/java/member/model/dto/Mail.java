package member.model.dto;
import javax.mail.Authenticator;

import javax.mail.PasswordAuthentication;

 

public class Mail extends Authenticator{

    PasswordAuthentication pa;

    public Mail() {
        String mail_id = "jangcccci@gmail.con";
        String mail_pw = "qocndlvkfl12!";

        pa = new PasswordAuthentication(mail_id, mail_pw);

    }

    

    public PasswordAuthentication getPasswordAuthentication() {
        return pa;
    }

}