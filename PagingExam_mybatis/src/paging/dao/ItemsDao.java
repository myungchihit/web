package paging.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import paging.vo.Item;

public interface ItemsDao {

	/**
	 * 
	 * @param session
	 * @param beginItemNo : 보려는 페이지의 시작 item 번호
	 * @param endItemNo : 보려는 페이지의 마지막 item 번호
	 * @return
	 */
	List<Item> selectItemList(SqlSession session, int beginItemNo, int endItemNo);

	/**
	 * item_tb의 총 레코드 수를 조회
	 * @param session
	 * @return
	 */
	int selectItemCount(SqlSession session);

}