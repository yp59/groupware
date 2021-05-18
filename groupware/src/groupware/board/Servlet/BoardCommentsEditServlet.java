package groupware.board.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.BoardCommentsDao;
import groupware.beans.BoardCommentsDto;

@WebServlet(urlPatterns = "/board/comEdit.gw")
public class BoardCommentsEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			BoardCommentsDto boardCommentsDto = new BoardCommentsDto();
			boardCommentsDto.setComNo(Integer.parseInt(req.getParameter("comNo")));
			boardCommentsDto.setComContent(req.getParameter("ComContent"));
			boardCommentsDto.setEmpNo(req.getParameter("empNo"));
			
			String empNo = (String)req.getSession().getAttribute("empNo");
			boardCommentsDto.setEmpNo(empNo);
			
			//처리
			BoardCommentsDao boardCommentsDao = new BoardCommentsDao();
			boardCommentsDao.edit(boardCommentsDto);
			
			//출력 : 원래의 게시글로 복귀(redirect)
			resp.sendRedirect("boardDetail.jsp?boardNo=" + boardCommentsDto.getEmpNo());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
