package groupware.massage.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.MassageDao;
import groupware.beans.MassageDto;
import groupware.beans.MassageListDao;
import groupware.beans.MassageListDto;

@WebServlet(urlPatterns = "/massage/massageInsert.kh")
public class MassageInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			//수신자 이름으로 파라미터를 받아왔다. 따라서 이를 수신자 번호로 바꿔서 보내야 한다.
			
			
			
			MassageDto massageDto = new MassageDto();
			//작성자만 세션에서 받아오자 (보낸사람을 세션에서 가져옴.)
			String writer =(String)req.getSession().getAttribute("id"); // empNo 발신자번호 저장
			massageDto.setEmpNo(writer);
			
			massageDto.setM_name(req.getParameter("m_name")); //제목 저장
			massageDto.setM_content(req.getParameter("m_content"));//내용 저장
			
			//수신자 번호 구하기(수신자 이름 -> 번호 change!)
			//MassageListDao 에서 가져온다.
			
			MassageListDao massageListDao = new MassageListDao();
			String e2_name = req.getParameter("e2_name");
			MassageListDto massageListDto = massageListDao.getReceiver_no(e2_name); //파라미터로 받아온 e2_name을 ListDao 매개변수로 넣어서 e2_no 받아오기.
			String receiver_no = massageListDto.getE2_no();
			massageDto.setReceiver_no(receiver_no); //수신자번호 저장
			
			
			
			
			//저장된 값 보내기
			MassageDao massageDao = new MassageDao();
			massageDao.insert(massageDto);
			
			resp.sendRedirect("massageSenderList.jsp");
			
		}catch(Exception e) {
			
			e.printStackTrace();
			resp.sendError(500);
			
		}
	}


}
