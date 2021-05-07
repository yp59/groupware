package groupware.board.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.boardDao;


@WebServlet(urlPatterns = "/board/boardDelete.gw")
public class boardDelete extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		try {
			
			req.setCharacterEncoding("UTF-8");
			int boardNo=Integer.parseInt(req.getParameter("boardNo"));
			
			boardDao boarddao = new boardDao();
			 
			boarddao.Delete(boardNo);
			
			resp.sendRedirect("http://localhost:8080/groupware/board/boardmain.jsp");
		
		}catch(Exception e) {
		
			e.printStackTrace();
			resp.sendError(500);
			
		}
	}
}
