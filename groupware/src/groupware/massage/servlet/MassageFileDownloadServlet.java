package groupware.massage.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import groupware.beans.MassageFileDao;
import groupware.beans.MassageFileDto;

@WebServlet(urlPatterns = "/massage/massageFile.kh")
public class MassageFileDownloadServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int file_no =Integer.parseInt(req.getParameter("file_no"));
			
			MassageFileDao massageFileDao = new MassageFileDao();
			MassageFileDto massageFileDto = massageFileDao.getByFileNo(file_no);
			
			String file_name = URLEncoder.encode(massageFileDto.getFile_upload_name(),"UTF-8");
			
			resp.setHeader("Content-Type", massageFileDto.getFile_content_type());
			resp.setHeader("Content-Encoding", "UTF-8");
			resp.setHeader("Content-length", String.valueOf(massageFileDto.getFile_size()));
			resp.setHeader("Content-Disposition", "attachment; filename=\""+file_name+"\"");
			
			File dir = new File("D:/upload");
			File target = new File(dir, massageFileDto.getFile_save_name());
			
			byte[]buffer = new byte[1024];
			FileInputStream in = new FileInputStream(target);
			
			while(true) {
				int size = in.read(buffer);
				if(size==-1) break;
				resp.getOutputStream().write(buffer,0,size);
			}
			
			in.close();
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
	
	
}
