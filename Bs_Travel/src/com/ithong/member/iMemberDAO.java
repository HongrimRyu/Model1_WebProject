package com.ithong.member;

import java.util.ArrayList;
import java.util.List;

public interface iMemberDAO {

	public List<String> idCheck();
	public List<String> nickCheck();
	public boolean insertMembers(MemberDTO mb);
	public int[] loginCheck(String id,String pass, String ip);
	public MemberDTO searchMember(String id);
	public int updateMember(MemberDTO mb,boolean pass);
	public ArrayList<MemberDTO> getMemberList(int num);
	public ArrayList<MemberDTO> getMemberList(int num, String search);
	public boolean delMembers(String id);
	public int warningPw(String id);
		
	
	
	
}
