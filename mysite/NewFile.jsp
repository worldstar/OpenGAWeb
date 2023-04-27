<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.json.JSONArray" %>  
<%@ page import="org.json.JSONObject" %>  

<%
  JSONArray jsonArray = new JSONArray();
  
  // 添加第一個 JSONObject 對象
  JSONObject jsonObject1 = new JSONObject();
  jsonObject1.put("day", 1);
  jsonObject1.put("temp", 30.4);
  jsonArray.put(jsonObject1);
  
  // 添加第二個 JSONObject 對象
  JSONObject jsonObject2 = new JSONObject();
  jsonObject2.put("day", 2);
  jsonObject2.put("temp", 31.2);
  jsonArray.put(jsonObject2);
  
  // 添加第三個 JSONObject 對象
  JSONObject jsonObject3 = new JSONObject();
  jsonObject3.put("day", 3);
  jsonObject3.put("temp", 29.8);
  jsonArray.put(jsonObject3);
   
  // 添加第四個 JSONObject 對象 
  JSONObject jsonObject4 = new JSONObject();
  jsonObject4.put("day", 4);
  jsonObject4.put("temp", 30.1);
  jsonArray.put(jsonObject4); 
   
  // 添加第五個 JSONObject 對象 
  JSONObject jsonObject5 = new JSONObject();
  jsonObject4.put("day", 5);
  jsonObject4.put("temp", 30.6);
  jsonArray.put(jsonObject4); 

  response.setCharacterEncoding("UTF-8");

  out.print(jsonArray.toString());
%>
