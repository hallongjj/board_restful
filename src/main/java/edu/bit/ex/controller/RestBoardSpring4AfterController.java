package edu.bit.ex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import edu.bit.ex.service.BoardService;
import edu.bit.ex.vo.BoardVO;
import lombok.extern.log4j.Log4j;

// spring 4.0에서부터 
// @RestController라는 어노테이션을 추가해서 
// 해당 Controller의 모든 매서드의 리턴타입을 기존과 다르게 처리한다는 것을 명시

@Log4j
//Controller의 모든 매서드의 리턴타입을 기존과 다르게 처리한다는 것을 명시
@RestController
public class RestBoardSpring4AfterController {

    @Autowired
    private BoardService boardService;

    // 자바객체 1ist를 json형태로 바꾸어줌
    @GetMapping("/rest/after")
    public List<BoardVO> restAfter(Model model) {
        log.info("restAfter()..");
        List<BoardVO> list = boardService.getList();
        model.addAttribute("list", list);
        return list;
    }
    
    @RequestMapping("/rest/{bid}")
    public BoardVO getVO(@PathVariable("bid") int bid, Model model) {
        log.info("getVO..");
        BoardVO vo = boardService.getVO(bid);
        model.addAttribute("vo", vo);
        return vo;
    }

}
