package com.ithong.board;

import java.util.List;

public interface iBoardDAO {


	public int maxIdx(int board);
	public int maxIdx(int board,String search);
	public List<BoardDTO> getBoardList(int board, int startPage, int pageSize);
	public List<BoardDTO> getBoardList(int board, int startPage, int pageSize, String search);
	public List<BoardDTO> getBoardList(int board, int startPage, int pageSize, int main);
	public BoardDTO getBoard(int board,int num);
	public String getNick(String id);
	public void updateCount(int board,int num);
	public boolean writeBoard(int board,BoardDTO bdto);
	public boolean updateBoard(int board,BoardDTO bdto); 
	public boolean deleteBoard(int board, BoardDTO bdto); 
	public boolean reInsertBoard(int board, BoardDTO bdto);
}
