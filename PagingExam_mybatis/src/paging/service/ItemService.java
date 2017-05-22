package paging.service;

import java.util.Map;

public interface ItemService {

	/**
	 * page 기준으로 item들을 조회하는 메소드.
	 * @param page 보려는 페이지
	 * @return Map 내에 그 페이지에서 보여줄 Item들을 담은 List와 PaingBean 객체를 리턴
	 */
	Map<String, Object> getItemList(int page);

}