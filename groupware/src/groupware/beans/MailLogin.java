package groupware.beans;

import javax.mail.PasswordAuthentication;
import javax.mail.Authenticator;

public class MailLogin extends Authenticator{
	PasswordAuthentication pa;
	
	public MailLogin() {
		String mail_id = "5groupware@gmail.com";
		String mail_pw = "dbfl4589";
		
		pa = new PasswordAuthentication(mail_id, mail_pw);
	}
	
	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}

}
