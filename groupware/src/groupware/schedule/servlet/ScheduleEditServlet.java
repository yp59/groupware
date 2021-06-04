package groupware.schedule.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.DepartmentDao;
import groupware.beans.ScheduleDao;
import groupware.beans.ScheduleDto;

@WebServlet(urlPatterns = "/schedule/scheduleEdit.kh")
public class ScheduleEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8"); 

			String empNo = (String)req.getSession().getAttribute("id");
			
			//준비: sc_no, id(세션), empNo(사원번호)
			// 그 외에 바꿀 것들 : sc_content, sc_name
			ScheduleDto scheduleDto = new ScheduleDto();
			scheduleDto.setSc_no(Integer.parseInt(req.getParameter("sc_no")));
//			scheduleDto.setEmpNo(empNo);
			scheduleDto.setSc_name(req.getParameter("sc_name"));
			scheduleDto.setSc_content(req.getParameter("sc_content"));
			
			//dep_name -> dep_no
			String dep_name =req.getParameter("dep_name");
			DepartmentDao departmentDao = new DepartmentDao();
			int dep_no =departmentDao.getDep_no(dep_name);
			
			scheduleDto.setDep_no(dep_no);
			
			
			ScheduleDao scheduleDao =new ScheduleDao();
			scheduleDao.edit(scheduleDto);
			
			//출력
			resp.sendRedirect("scheduleDetail.jsp?sc_no="+scheduleDto.getSc_no());
			
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	
	}
}
