package edu.bit.ex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import edu.bit.ex.service.BoardService;
import edu.bit.ex.vo.BoardVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController // 모든 메서드의 리턴타입을 기존과 다르게 처리한다는 것을 명시
@RequestMapping("/restful/*")
public class RestBoardController {
    
    @Autowired
    private BoardService boardService;
    
    // 1. list(처음 진입 화면이므로 화면이 깜박여도 상관없으므로 @Controller방식으로 접근 - veiw(화면)를 리턴
//    //지금까지 작성해왔던 형태    
//    @GetMapping("/board")
//    public String list(Model model) {
//       model.addAttribute("list", boardService.getList());
//       return "restful/rest_list";
//    }
    @GetMapping("/board")
    public ModelAndView list( ModelAndView mav) {
       mav.setViewName("rest/rest_list"); //rest/rest_list.jsp 
       mav.addObject("list", boardService.getList());
       
       return mav;
    }
    
    // 조회
    @GetMapping("/board/{bid}")
    public ModelAndView rest_content_view(BoardVO vo, ModelAndView mav) {
       mav.setViewName("rest/rest_content_view"); //rest/rest_list.jsp 
       mav.addObject("content_view", boardService.getVO(vo.getBid()));
       
       return mav;
    }
    
}
