package paging.service.impl;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import paging.dao.ItemsDao;
import paging.dao.impl.ItemsDaoImpl;
import paging.service.ItemService;
import paging.util.PagingBean;
import paging.util.SqlSessionFactoryManager;
import paging.vo.Item;

public class ItemServiceImpl implements ItemService {
	private SqlSessionFactory factory;
	private ItemsDao dao;
	private static ItemService instance;

	private ItemServiceImpl() throws IOException {
		factory = SqlSessionFactoryManager.getInstance().getSqlSessionFactory();  // SqlSessionFactoryManager 클래스에 있는 SessionFactory 호출해서 factory에 저장
		dao = ItemsDaoImpl.getInstance();
	}
	public static ItemService getInstance() throws IOException {
		if (instance == null) {
			instance = new ItemServiceImpl();
		}
		return instance;
	}
	
	@Override
	public Map<String, Object> getItemList(int page){
		HashMap<String, Object> map = new HashMap<>(); // 결과값을 담을 Map
		SqlSession session = factory.openSession();
		try{
			//1. PagingBean 객체 생성 -> Paging 계산 처리하는 객체. -> 보려는 페이지(파리미터로 받아오는 page), 총 item 수 ( 밑에서 생성한 totalCount)
			int totalCount = dao.selectItemCount(session);
			PagingBean pageBean = new PagingBean(totalCount,page);
			map.put("pageBean", pageBean);
			
		List<Item> list = dao.selectItemList(session, pageBean.getBeginItemInPage(), pageBean.getEndItemInPage() ); // 시작점과 끝점을 넣어준다
		
		map.put("list",list);
		return map;
		}finally{
			session.close();
		}
	}
	
	
}








