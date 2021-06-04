package groupware.approval.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.directAppDao;
import groupware.beans.directAppDto;

@WebServlet(urlPatterns = "/approval/directAppInsert.gw")
public class directAppInsert extends HttpServlet{

@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
	try {
		directAppDao directappdao = new directAppDao();
		directAppDto directappdto = new directAppDto();
		
		directappdto.setApproval(req.getParameter("approval"));
		directappdto.setAppNo(Integer.parseInt(req.getParameter("appNo")));
		directappdto.setConsesus(req.getParameter("consesus"));
		directappdto.setType(req.getParameter("type"));
		
		directappdao.directUpdate(directappdto);
		
		resp.sendRedirect(req.getContextPath()+"/approval/approvalList.jsp");
	}catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
	
	}

}
