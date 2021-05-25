package groupware.massage.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.MassageDao;
import groupware.beans.MassageDto;

@WebServlet(urlPatterns = "/massage/massageInsert.kh")
public class MassageInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			MassageDto massageDto = new MassageDto();
			//작성자만 세션에서 받아오자 (보낸사람을 세션에서 가져옴.)
			String writer =(String)req.getSession().getAttribute("id"); // empNo 
			massageDto.setEmpNo(writer);
			
			massageDto.setM_name(req.getParameter("m_name")); //제목
			massageDto.setM_content(req.getParameter("m_content"));//내용
			massageDto.setReceiver_no(req.getParameter("receiver_no")); // 수신자
			
			MassageDao massageDao = new MassageDao();
			massageDao.insert(massageDto);
			
			resp.sendRedirect("massageList.jsp");
			
		}catch(Exception e) {
			
			e.printStackTrace();
			resp.sendError(500);
			
		}
	}


}
