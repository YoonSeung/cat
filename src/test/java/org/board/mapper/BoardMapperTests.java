package org.board.mapper;


import java.util.List;

import org.board.domain.BoardVO;
import org.board.domain.Criteria;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
//	@Test
//	public void testGetList() {
//		mapper.getList().forEach(board -> log.info(board));
//	}
	
//	@Test
//	public void testInsert() {
//		BoardVO board = new BoardVO();
//		board.setTitle("나 혼자 실습 새로 작성하는 글");
//		board.setContent("나 혼자 새로 작성하는 내용");
//		board.setWriter("윤승환");
//		mapper.insert(board);
//		log.info(board);
//	}
	
//	@Test
//	public void testInsertSelectKey() {
//		BoardVO board = new BoardVO();
//		board.setTitle("나 혼자 실습 새로 작성하는 글 select key");
//		board.setContent("나 혼자 새로 작성하는 내용 select key");
//		board.setWriter("윤승환");
//		mapper.insertSelectKey(board);
//		log.info(board);
//	}
	
//	@Test
//	public void testRead() {
//		BoardVO board = mapper.read(1471L);
//		log.info(board);
//	}
	
//	@Test
//	public void testDelete() {
//		log.info("Delete count: " + mapper.delete(1470L));
//	}
	
//	@Test
//	public void testUpdate() {
//		BoardVO board = new BoardVO();
//		board.setBno(1471L);
//		board.setTitle("나혼자 수정되는 제목");
//		board.setContent("나혼자 수정되는 내용");
//		board.setWriter("윤승환 수정");
//		
//		int count = mapper.update(board);
//		log.info("update count:" + count);
//	}
	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(3);
		cri.setAmount(10);
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board->log.info(board.getBno()));
	}
}


