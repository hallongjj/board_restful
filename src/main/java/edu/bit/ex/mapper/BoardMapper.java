package edu.bit.ex.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import edu.bit.ex.vo.BoardVO;


public interface BoardMapper {

    List<BoardVO> getList();

    BoardVO getVO(int bid);
    
    
	
}
