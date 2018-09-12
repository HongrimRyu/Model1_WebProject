<%@page import="com.ithong.member.MemberDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%//idck()
request.setCharacterEncoding("utf-8");
MemberDAO mdao = new MemberDAO();
ArrayList<String> al = (ArrayList<String>)mdao.idCheck();
Iterator<String> iter = al.iterator();
%>
[
<%while(iter.hasNext()){%>
"<%=iter.next()%>"<%if(iter.hasNext()){%>,<%}%>

<%}%>


]