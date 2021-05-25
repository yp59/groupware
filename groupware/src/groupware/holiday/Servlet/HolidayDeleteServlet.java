package groupware.holiday.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.HolidayDao;



@WebServlet(urlPatterns="/holiday/holidayDelete.gw")
public class HolidayDeleteServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			// 준비 : 휴가 번호
			int holNo = Integer.parseInt(req.getParameter("holNo"));
			
			//처리
			HolidayDao holidayDao = new HolidayDao();
			holidayDao.delete(holNo);
			
			//출력 : 목록으로 리다이렉트
			resp.sendRedirect("holidayList.jsp");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
