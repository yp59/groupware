package groupware.mail.servlet;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.MailLogin;

@WebServlet(urlPatterns = "/mail/mailSend.gw")
public class MailSendServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			req.setCharacterEncoding("UTF-8");
			
			// 메일 설정
			Properties prop = System.getProperties();
			prop.put("mail.smtp.starttls.enable", "true");
			prop.put("mail.smtp.host", "smtp.gmail.com");
			prop.put("mail.smtp.auth", "true");
			prop.put("mail.smtp.port", "587");
			
			Authenticator login = new MailLogin();
			Session session = Session.getDefaultInstance(prop, login);
			MimeMessage msg = new MimeMessage(session);
			
			// 메일 내용
			msg.setSentDate(new Date());
        	msg.setFrom(new InternetAddress("5groupware@gmail.com", "그룹웨어 관리자"));
            InternetAddress to = new InternetAddress(req.getParameter("mailRecipient"));         
            msg.setRecipient(Message.RecipientType.TO, to);            
            msg.setSubject(req.getParameter("mailTitle"), "UTF-8");            
            msg.setText(req.getParameter("mailContent"), "UTF-8");            
            
            Transport.send(msg);
			
            // 메일 리스트로 리다이렉트
			resp.sendRedirect("http://localhost:8080/groupware/mail/mailList.jsp");
		}catch(Exception e) {
			
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
