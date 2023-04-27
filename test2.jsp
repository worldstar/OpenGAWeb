<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>

<%
String problem=request.getParameter("problem");
String selection=request.getParameter("selection");
String crossover=request.getParameter("crossover");
String mutation=request.getParameter("mutation");
String crossrate=request.getParameter("crossrate");
String mutarate=request.getParameter("mutarate");
String generations=request.getParameter("generations");
String yn=request.getParameter("yn");
String elitism=request.getParameter("elitism");
int a=Integer.parseInt(crossrate);
int b=Integer.parseInt(mutarate);
int c=Integer.parseInt(generations);
int d=Integer.parseInt(yn);
int e=Integer.parseInt(elitism);
%>
你要解決的問題是：<%=problem%><br>
你所選擇的Selection operator是：<%=selection%><br>
你所選擇的Crossover operator是：<%=crossover%><br>
你所選擇的Mutation operator是：<%=mutation%><br>

你所需要的Crossover rate為：<%=a%>%<br>
你所需要的Mutation rate為：<%=b%>%<br>
你所需要的Generations為：<%=c%>代<br>

<%
if(d==1)
{
	out.println("你所需要的菁英比率為："+e+"%");
}
else
{
	e=0;
	out.println("你所需要的菁英比率為："+e+"%");
}

%>
</body>
</html>