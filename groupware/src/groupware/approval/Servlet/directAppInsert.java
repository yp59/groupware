package groupware.approval.Servlet;

import java.io.IOException;
import java.util.List;

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
		int appNo = Integer.parseInt(req.getParameter("appNo"));
		
		directAppDao directappdao = new directAppDao();
		directAppDto directappdto = new directAppDto();
		
		directappdto.setApproval(req.getParameter("approval"));
		directappdto.setAppNo(appNo);
		directappdto.setConsesus(req.getParameter("consesus"));
		directappdto.setType(req.getParameter("type"));
		
		directappdao.directUpdate(directappdto);//결재 결과값을 저장하고

		//////상태 판별 구문 (상신,진행중,종결,중지)////////////////////
		List<directAppDto> list = directappdao.appState(appNo);
		//테이블의 type과 app_date값들을 list로 저장
		
		String state = "상신";
		int endCount=0;
		int appSize = list.size();
		
		for(directAppDto x : list) {
			
			if(x.getType().equals("거부")||x.getType().equals("반려")) {//결재자중 누군가가 거부혹은 반려를 했다면
				state = "중지";
				break;//전부다 결재를 했든 안했든 무조건 중지시키고 반복문을 벗어난다.
			}
			if(!x.getType().equals("미결")) {//Type에 미결이 아닐경우 state는 일단 진행중으로 표시
				
				endCount +=1;//결재자 수를 새는 변수
				
				if(appSize==endCount) {//모두다 결재했으면 종결
					state = "종결";
					break;
				}
				if(endCount>0) {//한명이라도 결재를 한 경우라면 상태는 진행중
					state = "진행중";
				}
				
			}
		}
		
		////update로 approval table의 state 컬럼에 값 넣기/////////////
		
		directappdao.stateUpdate(state, appNo);//approval table 의 상태 업데이트
		
		////////////////////////////////////////////////////////
		
		resp.sendRedirect(req.getContextPath()+"/approval/approvalList.jsp");
	}catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
	
	}

}
