package paging.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import paging.dao.ItemsDao;
import paging.vo.Item;

public class ItemsDaoImpl implements ItemsDao {
	private static ItemsDao instance;

	private ItemsDaoImpl() {
	}

	public static ItemsDao getInstance() {
		if (instance == null) {
			instance = new ItemsDaoImpl();
		}
		return instance;
	}
	private String makeSql(String sqlId){
		return "paging.config.mapper.pagingMapper."+sqlId;
	}

	@Override
	public List<Item> selectItemList(SqlSession session, int beginItemNo, int endItemNo) {
		HashMap<String, Integer> param = new HashMap<>();
		param.put("beginItemNum", beginItemNo);
		param.put("endItemNum", endItemNo);
		return session.selectList(makeSql("selectItemList"), param);
	}

	@Override
	public int selectItemCount(SqlSession session){
		return session.selectOne(makeSql("selectItemCount"));
	}
}








