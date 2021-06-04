package groupware.attendance.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.AttendanceDao;
import groupware.beans.AttendanceDto;

@WebServlet(urlPatterns="/attendance/attend.gw")
public class AttendServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			AttendanceDto attendanceDto = new AttendanceDto();
			
			String empNo = (String)req.getSession().getAttribute("id");
			attendanceDto.setEmpNo(empNo);
			
			AttendanceDao attendanceDao = new AttendanceDao();
			attendanceDao.attend(attendanceDto);
			
			resp.sendRedirect("attendanceMain.jsp");
//			resp.setCharacterEncoding("UTF-8");
//			resp.setContentType("text/html");
//			resp.getWriter().print("<script>");
//			resp.getWriter().print("window.alert('출근이 완료되었습니다');");
//			resp.getWriter().print("location.href='attendanceMain.jsp';");
//			resp.getWriter().print("</script>");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
