package groupware.holiday.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.HolidayDao;
import groupware.beans.employeesDao;



@WebServlet(urlPatterns="/holiday/holidayDelete.gw")
public class HolidayDeleteServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			// 준비 : 사원번호, 휴가번호
			String empNo = (String)req.getSession().getAttribute("id");
			int holNo = Integer.parseInt(req.getParameter("holNo"));
			
			//처리
			HolidayDao holidayDao = new HolidayDao();
			
			int holCount = holidayDao.count(empNo,holNo);
			holidayDao.delete(holNo);
			
			employeesDao employeesDao = new employeesDao();
			
			if(employeesDao.holidayPlus(empNo, holCount)) { //제대로 업데이트 됐다면
				
				//출력 : 목록으로 리다이렉트
				resp.sendRedirect("holidayList.jsp");
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
