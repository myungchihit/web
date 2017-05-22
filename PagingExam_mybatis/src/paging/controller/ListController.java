package paging.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import paging.service.ItemService;
import paging.service.impl.ItemServiceImpl;

public class ListController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try{
		// 1. 요청파라미터 조회 + 검증
		int page = 1;	// 기본페이지가 1  ==> 0이면 안된다.
		
		try{
			page = Integer.parseInt(request.getParameter("page"));	// 보려는 페이지 번호 조회	(만약 1이 아닌 이상한값이 넘어 온다면 1페이지를 보여주는것)
		}catch(Exception e){}
		
		// 2. 비지니스 로직 - Model 호출
		ItemService service = ItemServiceImpl.getInstance();
		Map<String, Object> map = service.getItemList(page); // getItemList 리턴값이 map이기 때문에 map으로 받아준다
		
		// 3. 결과 응답 - View 호출	page만들떄 총2개 객체가 필요하니까 2개 객체 뿌린다
		request.setAttribute("list", map.get("list"));				
		request.setAttribute("pageBean", map.get("pageBean"));
		
		request.getRequestDispatcher("/item_list.jsp").forward(request, response);
		
		
		}catch(Exception ex){
			// 에러 페이지 이동
			ex.printStackTrace();
		}
	}
}







