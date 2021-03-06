package groupware.attendance.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.AttendanceDao;

@WebServlet(urlPatterns = "/attendance/attendanceEdit.gw")
public class AttendanceEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			req.setCharacterEncoding("UTF-8");
			String empNo = req.getParameter("empNo");
			String attDate = req.getParameter("attDate");
			String attend = req.getParameter("attend");
			String leave = req.getParameter("leave");
			
			AttendanceDao attendanceDao = new AttendanceDao();
			
			if(attendanceDao.edit(empNo,attDate,attend,leave)) {
				attendanceDao.totaltime(empNo, attDate);
				attendanceDao.overtime(empNo, attDate);
				resp.sendRedirect("attendanceAuthorityDetail.jsp?attDate="+attDate+"&empNo="+empNo);
				
			}
			else {
				throw new Exception();
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
