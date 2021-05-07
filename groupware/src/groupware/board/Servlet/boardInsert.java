package groupware.board.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.boardDao;
import groupware.beans.boardDto;

@WebServlet(urlPatterns = "/board/boardInsert.gw")
public class boardInsert extends HttpServlet{

@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		
		req.setCharacterEncoding("UTF-8");
		
		boardDto boarddto = new boardDto();
		boarddto.setBoTitle(req.getParameter("boTitle"));
		boarddto.setBoType(req.getParameter("boType"));
		boarddto.setBoContent(req.getParameter("boContent"));
		
		boardDao boarddao = new boardDao();
		
		boarddao.registration(boarddto);
	
		
		resp.sendRedirect("http://localhost:8080/groupware/board/boardmain.jsp");
	}catch(Exception e) {
		
		e.printStackTrace();
		resp.sendError(500);
	}

}
}
