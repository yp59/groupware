package groupware.beans;

import javax.mail.PasswordAuthentication;
import javax.mail.Authenticator;


// 구글 SMTP 서버 인증(수정금지)
public class MailLogin extends Authenticator{
	PasswordAuthentication pa;
	
	public MailLogin() {
		String mail_id = "5groupware@gmail.com"; // 구글 ID
		String mail_pw = "dbfl4589"; // 구글 PW
		
		pa = new PasswordAuthentication(mail_id, mail_pw);
	}
	
	// 인증 반환
	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}

}
