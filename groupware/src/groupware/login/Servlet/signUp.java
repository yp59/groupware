package groupware.login.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.PositionHolidayDao;
import groupware.beans.employeesDao;
import groupware.beans.employeesDto;

/*-잘못 입력하면 바로아래에 제약조건 문구 뜨면서 다시 입력하도록 안내 문구 추가해야 한다.
데이터 베이스내에 unique 조건이 걸린 값은 catch문에서 처리해서 화면으로 나타낼 수 있게 처리
(미구현)*/
@WebServlet(urlPatterns = "/login/signUpInsert")
public class signUp extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		try {
		req.setCharacterEncoding("UTF-8");
		
		String email = req.getParameter("emailLocal")+"@"+req.getParameter("emailDomain");
		
		String phone = "010-"+req.getParameter("empPhonemid")+"-"+req.getParameter("empPhonelast");
		
		String address = "["+req.getParameter("postNumber")+"] "
						+req.getParameter("addressNum")+" "+req.getParameter("addressDetail");
		
		employeesDao employeesdao = new employeesDao();
		
		//회원가입시 직급에 따른 휴가 일수 설정
		PositionHolidayDao positionHolidayDao = new PositionHolidayDao();
		int holiday = positionHolidayDao.get(Integer.parseInt(req.getParameter("poNo")));
		
		employeesDto employeesdto = new employeesDto(
				
				req.getParameter("empNo"),
				req.getParameter("empPw"),
				Integer.parseInt(req.getParameter("poNo")),
				req.getParameter("empName"),
				req.getParameter("joinDate"),
				phone,
				email,
				address,
				req.getParameter("department"),//부서 받아서 db 저장가능하게 구현
				holiday //직급별 휴가일수 설정
				);
		
		employeesdao.regist(employeesdto);
		
		resp.sendRedirect(req.getContextPath()+"/login/registSuccess.jsp");
		
		}catch(Exception e) {
			
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
