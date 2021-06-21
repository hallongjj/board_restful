package edu.bit.ex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.bit.ex.service.BoardService;
import edu.bit.ex.vo.BoardVO;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/ajax/**")
public class AjaxBoardController {
	
    @Autowired
    private BoardService boardService;
    
    @GetMapping("/list")
    public String list(Model model) {
        log.info("list()..");
        log.info(boardService.getList());
        model.addAttribute("list", boardService.getList());
        return "ajax/ajaxList";
    }
    
    @ResponseBody
    @GetMapping("/delete")
    public String delete(BoardVO vo) {
        log.info("delete()..");
        boardService.remove(vo.getBid());
        return "SUCCESS";
    }
}
