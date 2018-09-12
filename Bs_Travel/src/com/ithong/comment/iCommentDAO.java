package com.ithong.comment;

import java.util.List;



public interface iCommentDAO {

	public int idxCheck(int board,int num);
	public boolean attachComment(int board,CommentDTO cdto);
	public List<CommentDTO> getCommandList(int board, int num);
	public CommentDTO getComment(int board,int idx,int c_idx);
	public boolean updateComment(int board, CommentDTO cdto);
	public boolean replyComment(int board, CommentDTO cdto);
}
