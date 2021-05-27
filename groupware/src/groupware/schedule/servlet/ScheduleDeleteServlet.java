package groupware.schedule.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.ScheduleDao;
import groupware.beans.ScheduleDto;

@WebServlet(urlPatterns = "/schedule/scheduleDelete.kh")
public class ScheduleDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			String empNo =(String)req.getSession().getAttribute("id");
			//준비: sc_no(파라미터), id(세션)
			ScheduleDto scheduleDto = new ScheduleDto();
			scheduleDto.setSc_no(Integer.parseInt(req.getParameter("sc_no")));
			scheduleDto.setEmpNo(empNo);
		
			
			ScheduleDao scheduleDao = new ScheduleDao();
			scheduleDao.delete(scheduleDto);
			
			
			//출력:성공화면 출력
			resp.sendRedirect("scheduleDeleteSuccess.jsp");
			
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
			
		}
	}
	
	
}
