package groupware.massage.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import groupware.beans.MassageDao;
import groupware.beans.MassageDto;
import groupware.beans.MassageFileDao;
import groupware.beans.MassageFileDto;
import groupware.beans.employeesDao;
import groupware.beans.employeesDto;

@WebServlet(urlPatterns = "/massage/massageInsert.kh")
public class MassageInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			String path="D:/upload";
			int maximumSize = 10*1024*1024;
			String encoding ="UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			
			MultipartRequest mRequest = new MultipartRequest(req, path, maximumSize, encoding, policy);
			
			
			
			
			
			
			MassageDto massageDto = new MassageDto();
			//작성자만 세션에서 받아오자 (보낸사람을 세션에서 가져옴.)
			String writer =(String)req.getSession().getAttribute("id"); // empNo 발신자번호 저장
			massageDto.setEmpNo(writer);
			
			
			massageDto.setM_name(mRequest.getParameter("m_name")); //메세지 제목 저장
			massageDto.setM_content(mRequest.getParameter("m_content"));//내용 저장
			
			
			
			
//			수신자 번호 구하기(수신자 이름 -> 번호 change!)			
//			수신자 이름을 -> 수신자 번호로 바꾸는 getReceiver_no 메소드 : employeesDao 에 만듦.
			String e2_name = mRequest.getParameter("e2_name");
			employeesDao empDao = new employeesDao();
			employeesDto empDto = empDao.getReceiver_no(e2_name); //파라미터로 받아온 e2_name을 매개변수로 넣어서 e2_no 받아오기.
			String receiver_no = empDto.getEmpNo();
			
			massageDto.setReceiver_no(receiver_no); //수신자번호 저장
			
			

			MassageDao massageDao = new MassageDao();
			int sequence = massageDao.getSequence();
			
			massageDto.setM_no(sequence);
			//massage table 부분 저장된 값 보내기
			massageDao.insert(massageDto);
			
			
			//파일등록
			File file=mRequest.getFile("massage_file");
			if(file!=null) {
				MassageFileDto massageFileDto = new MassageFileDto();
				massageFileDto.setFile_save_name(mRequest.getFilesystemName("massage_file"));
				massageFileDto.setFile_upload_name(mRequest.getOriginalFileName("massage_file"));
				massageFileDto.setFile_content_type(mRequest.getContentType("massage_file"));
				massageFileDto.setFile_size(file.length());
				massageFileDto.setFile_origin(sequence);
				
				MassageFileDao massageFileDao = new MassageFileDao();
				massageFileDao.insert(massageFileDto);
				
			}
			
			
			
			
			resp.sendRedirect("massageSenderList.jsp");
			
		}catch(Exception e) {
			
			e.printStackTrace();
			resp.sendError(500);
			
		}
	}


}
