<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "openga.operator.crossover.twoPointCrossover2"%>
<%@ page import = "openga.operator.crossover.CrossoverI"%>
<%@ page import = "openga.chromosomes.population"%>
<%@ page import = "openga.chromosomes.populationI"%>
<%@ page import = "openga.util.timeClock"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action = "" method = "get"></form>

<%
timeClock time = new timeClock();
time.start();

CrossoverI twoPointCrossover21 = new twoPointCrossover2();
openga.util.printClass printClass1 = new openga.util.printClass();
populationI population1 = new population();
populationI newPop = new population();
int size = 3, length = 6;

population1.setGenotypeSizeAndLength(true, size, length, 2);
population1.createNewPop();
for(int i = 0 ; i < size ; i ++ ){
   printClass1.printMatrix(""+i,population1.getSingleChromosome(i).genes);
}

twoPointCrossover21.setData(0.9, population1);
twoPointCrossover21.startCrossover();
newPop = twoPointCrossover21.getCrossoverResult();

for(int i = 0 ; i < size ; i ++ ){
   printClass1.printMatrix(""+i,newPop.getSingleChromosome(i).genes);
}

time.end();

double time0 = time.getExecutionTime();
%>

<br>計時：經過了<%= time0 %>秒

</body>
</html>