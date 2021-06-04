package groupware.filter.loginFilter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebFilter(urlPatterns = {
"/login/loginInfo.jsp","/login/logOut.gw","/index.jsp",

"/board/boardDetail.jsp","/board/boardEdit.jsp","/board/boardInsert.jsp",
"/board/boardmain.jsp","/board/boardmainNotice.jsp","/board/boardmainQuestion.jsp",
"/board/boardmainFree.jsp","/board/boardDelete.gw","/board/boardEdit.gw",

"/board/boardInsert.gw", //로그인이랑 게시판 필터 적용
"/board/boardInsert.gw","/board/comEdit.gw","/board/comDelete.gw", //로그인이랑 게시판 필터 적용

"/holiday/*", //휴가 메뉴 필터 적용
"/attendance/*", //근태메뉴 필터 적용
"/salary/*", //급여 메뉴 필터 적용

"/schedule/scheduleList.jsp","/schedule/scheduleDetail.jsp","/schedule/scheduleInsert.jsp","/schedule/scheduleEdit.jsp",
"/schedule/scheduleSuccess.jsp","/schedule/scheduleSuccessCancel.jsp","/scheduleDeleteSuccess.jsp",
"/schedule/scheduleInsert.kh","/schedule/scheduleEdit.kh","/schedule/scheduleComplete.kh",

"/address/*",

"/massage/massageReceiverList.jsp","/massage/massageDetail.jsp","/massage/massageInsert.jsp","/massage/massageSenderList.jsp",
"/massage/massageInsert.kh",


"/mail/mailSend.gw", "/mail/mailList.jsp", "/mail/mailSend.jsp", // 메일 필터 적용

"/approval/approvalDetail.jsp","/approval/approvalDetailIndir.jsp","/approval/approvalInsert.jsp",
"/approval/approvalInsertMain.jsp","/approval/approvalList.jsp","/approval/InsertDepartmentPopUp.jsp",
"/approval/approvalInsert.gw","/approval/directAppInsert.gw"//결재 필터 적용

})



public class filter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
		
		throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;

		HttpSession session = req.getSession();
		
		if(session.getAttribute("id")!=null) {
			chain.doFilter(request, response);//통과코드
		}
		else
		{	
		resp.sendRedirect(req.getContextPath()+"/login/loginMain.jsp");//로그인 안되있으니 로그인부터하고와라 코드
		}
	}
	//db자주 들르는거 안좋음 session이 접근성이 좋기때문에 최대한 활용하자.
}
