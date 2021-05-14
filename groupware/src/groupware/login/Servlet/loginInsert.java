package groupware.login.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.employeesDao;
import groupware.beans.employeesDto;

@WebServlet(urlPatterns = "/login/loginInfoEdit.gw")
public class loginInsert extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {//login sign up 과 마찬가지로 update sql문을 활용하여 db의 데이터 수정 
		// 수정할 수 없는 정보(empNo,직급)등은 수정하지 못하게 함.
			req.setCharacterEncoding("UTF-8");
		
			employeesDao employeesdao = new employeesDao();
			employeesDto employeesdto = new employeesDto();
			
			String phone = "010-"+req.getParameter("empPhonemid")+"-"+req.getParameter("empPhonelast");
			
			String email = req.getParameter("emailLocal")+"@"+req.getParameter("emailDomain");
			
			String address = "["+req.getParameter("postNumber")+"] "
					+req.getParameter("addressNum")+" "+req.getParameter("addressDetail");
			
			employeesdto.setEmpPw(req.getParameter("empPw"));
			employeesdto.setEmpName(req.getParameter("empName"));
			employeesdto.setEmpPhone(req.getParameter(phone));
			employeesdto.setEmail(email);
			employeesdto.setAddress(address);
			employeesdto.setEmpNo(req.getParameter("empNo"));
			
			employeesdao.loginInfoEdit(employeesdto);
			
			resp.sendRedirect(req.getContextPath()+"/login/loginInfo.jsp");
			
	}catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
	
	}
}
