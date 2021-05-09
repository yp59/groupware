package groupware.login.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import groupware.beans.authorityDao;
import groupware.beans.employeesDao;
import groupware.beans.employeesDto;

@WebServlet(urlPatterns = "/login/confirm.gw")
public class loginMain extends HttpServlet{

	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
	
	
		req.setCharacterEncoding("UTF-8");
		
		employeesDao employeesdao = new employeesDao();
		
		employeesDto employeesdto = new employeesDto(req.getParameter("empNo"),req.getParameter("empPw"));
		
		authorityDao authoritydao = new authorityDao();
		
		//HttpSession session = req.getSession();
		boolean confirm = employeesdao.login(employeesdto);
		
		if(confirm) {
			
			int autholevel = authoritydao.authorityLevel(req.getParameter("empNo"));
			req.getSession().setAttribute("id", req.getParameter("empNo"));
			req.getSession().setAttribute("authorityLevel", autholevel);//권한레벨을 로그인 시에 아이디에 따라 세션으로 부여 
			resp.sendRedirect(req.getContextPath());				//세션으로 해두면 매번 DB접속 안해도 된다.
		}
		else {
			resp.sendRedirect("http://localhost:8080/groupware/login/loginMain.jsp?error");
		}
	}catch(Exception e) {
		
			e.printStackTrace();
			resp.sendError(500);
		}

	}
}
