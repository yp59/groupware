package groupware.board.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.BoardCommentsDao;
import groupware.beans.BoardCommentsDto;


@WebServlet(urlPatterns = "/board/comInsert.gw")
public class BoardCommentsInsertServlet extends HttpServlet{
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			BoardCommentsDto boardCommentsDto = new BoardCommentsDto();
			boardCommentsDto.setComContent(req.getParameter("comContent"));
			boardCommentsDto.setBoardNo(Integer.parseInt(req.getParameter("boardNo")));
			boardCommentsDto.setEmpNo(req.getParameter("empNo"));
			
			//처리
			BoardCommentsDao boardCommentsDao = new BoardCommentsDao();
			boardCommentsDao.insert(boardCommentsDto);
			
			//출력 : 상세페이지로 복귀(redirect)
			resp.sendRedirect("boardDetail.jsp?boardNo="+boardCommentsDto.getBoardNo());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
