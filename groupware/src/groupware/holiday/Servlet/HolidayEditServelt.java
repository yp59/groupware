package groupware.holiday.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.HolidayDao;
import groupware.beans.HolidayDto;
import groupware.beans.employeesDao;

@WebServlet(urlPatterns = "/holiday/holidayEdit.gw")
public class HolidayEditServelt extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			HolidayDto holidayDto = new HolidayDto();
			holidayDto.setHolNo(Integer.parseInt(req.getParameter("holidayNo")));
			holidayDto.setHolType(req.getParameter("holidayType"));
			holidayDto.setHolStart(req.getParameter("holidayStart"));
			holidayDto.setHolContent(req.getParameter("holidayContent"));
			holidayDto.setHolEnd(req.getParameter("holidayEnd"));
			
			String empNo = (String)req.getSession().getAttribute("id");
			holidayDto.setEmpNo(empNo);

			HolidayDao holidayDao = new HolidayDao();
			holidayDao.edit(holidayDto);
			
			int holCount = holidayDao.count(empNo,Integer.parseInt(req.getParameter("holidayNo"))); //한번 신청한 휴가 일수 가져오기

			employeesDao employeesDao = new employeesDao();
			
			if(employeesDao.holidayMinus(empNo, holCount)) { //제대로 업데이트 됐다면
				resp.sendRedirect("holidayDetail.jsp?holNo="+holidayDto.getHolNo());
			}

		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
