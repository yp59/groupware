package groupware.mail.servlet;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import groupware.beans.MailLogin;

@WebServlet(urlPatterns = "/mail/mailSend.gw")
public class MailSendServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			// 폼에서 전송 받은 데이터 저장 (경로는 자신에 맞게 수정)
			String path = "D:/upload";
			String encoding = "UTF-8";
			int maximumSize = 10 * 1024 * 1024;
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			MultipartRequest mr = new MultipartRequest(req, path, maximumSize, encoding);
			
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
			
			// 제목, 수진자 지정
			msg.setSentDate(new Date());
        	msg.setFrom(new InternetAddress("5groupware@gmail.com", "그룹웨어 관리자"));
            InternetAddress to = new InternetAddress(mr.getParameter("mailRecipient"));         
            msg.setRecipient(Message.RecipientType.TO, to);            
            msg.setSubject(mr.getParameter("mailTitle"), "UTF-8");            
            
            //본문
            File file = mr.getFile("mailFile");
            
            // 첨부 파일이 없으면
            if(null == mr.getFile("mailFile")) {
            MimeMultipart mmp = new MimeMultipart();
            MimeBodyPart mbp = new MimeBodyPart();
            mbp.setContent(mr.getParameter("mailContent") +
            		"\n [본 메일은 그룹웨어 관리자가 발송한 메일이며 발신전용 메일입니다.]", "text/html; charset=UTF-8");
            mmp.addBodyPart(mbp);
            
			msg.setContent(mmp);
            }
            
            // 첨부 파일이 있으면
            else {
            MimeMultipart mmp = new MimeMultipart();
            MimeBodyPart mbp = new MimeBodyPart();
            mbp.setContent(mr.getParameter("mailContent") +
                		"\n [본 메일은 그룹웨어 관리자가 발송한 메일이며 발신전용 메일입니다.]", "text/html; charset=UTF-8");
            mmp.addBodyPart(mbp);
                
            //파일 첨부
            mbp = new MimeBodyPart();
            FileDataSource fds = new FileDataSource(file.getAbsolutePath());
            mbp.setDataHandler(new DataHandler(fds));
            mbp.setFileName(MimeUtility.encodeText(mr.getOriginalFileName("mailFile"), "UTF-8", "B"));
            mmp.addBodyPart(mbp);
    			
            msg.setContent(mmp);	
            }
			
            //메일 전송
            Transport.send(msg);
			
            // 메일 리스트로 리다이렉트
			resp.sendRedirect("http://localhost:8080/groupware/mail/mailList.jsp");
			}catch(Exception e) {
			
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
