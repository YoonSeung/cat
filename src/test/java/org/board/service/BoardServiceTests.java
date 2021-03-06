package org.board.service;

import static org.junit.Assert.assertNotNull;

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
public class BoardServiceTests {
	@Setter(onMethod_ = {@Autowired})
	private BoardService service;
	
//	@Test
//	public void testExist() {
//		log.info(service);
//		assertNotNull(service);
//	}
	
//	@Test
//	public void testRegister() {
//		BoardVO board = new BoardVO();
//		board.setTitle("비즈니스 나혼자 새로 작성하는 글");
//		board.setContent("비즈니스 나 혼자 새로 작성하는 내용");
//		board.setWriter("윤승환");
//		
//		service.register(board);
//		log.info("생성된 게시물 번호>>" + board.getBno());
//	}
	
	@Test
	public void testGetList() {
//		service.getList().forEach(board->log.info(board));
		service.getList(new Criteria(2,10)).forEach(board->log.info(board));
	}
	
//	@Test
//	public void testGet() {
//		log.info(service.get(1472L));
//	}
	
//	@Test
//	public void testDelete() {
//		log.info("remove result:" + service.remove(1111L));
//	}
	
//	@Test
//	public void testUpdate() {
//		BoardVO board = service.get(1472L);
//		
//		if(board == null) {
//			return;
//		}
//		
//		board.setTitle("비즈니스 제목 수정 실습");
//		log.info("modify result:"+service.modify(board));
//	}
}
