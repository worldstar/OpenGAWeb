<%@ page language = "java" contentType = "text/html; charset = UTF-8"
    pageEncoding = "UTF-8"%>

<%@ page import = "opengaRun.TSP_Run"%>

<%@ page import = "opengaRun.singleMachine_Run"%>
<%@ page import = "openga.applications.data.knapsackORLibProblems"%>

<%@ page import = "opengaRun.flowshop_Run"%>
<%@ page import = "java.util.concurrent.ExecutorService"%>
<%@ page import = "java.util.concurrent.Executors"%>
<%@ page import = "java.util.concurrent.Executor"%>

<%@ page import = "opengaRun.ParallelMachine_Run"%>

<%@ page import = "opengaRun.knapsackSGA_Run"%>

<%@ page import = "opengaRun.QAP_NVR_Run"%>
<%@ page import = "openga.applications.data.readQAPData"%>

<!DOCTYPE html>

<html>
<head>
<meta charset = "UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

String problem      = request.getParameter("problem");
String selection    = request.getParameter("selection");
String crossover    = request.getParameter("crossover");
String mutation     = request.getParameter("mutation");

String crossrate0   = request.getParameter("crossrate");
String mutarate0    = request.getParameter("mutarate");
String generations0 = request.getParameter("generations");
String yn0          = request.getParameter("yn");
String elitism0     = request.getParameter("elitism");

int crossrate   = Integer.parseInt(crossrate0);
int mutarate    = Integer.parseInt(mutarate0);
int generations = Integer.parseInt(generations0);
int yn          = Integer.parseInt(yn0);
int elitism     = Integer.parseInt(elitism0);

%>

你要解決的問題是：<%= problem %><br>
你所選擇的Selection operator是：<%= selection %><br>
你所選擇的Crossover operator是：<%= crossover %><br>
你所選擇的Mutation operator是：<%= mutation %><br>

你所需要的Crossover rate為：<%= crossrate %>%<br>
你所需要的Mutation rate為：<%= mutarate %>%<br>
你所需要的Generations為：<%= generations %>代<br>

<%

if(yn == 1)
{
	out.println("你所需要的菁英比率為：" + elitism + "%");
}
else
{
    elitism = 0;
	out.println("你所需要的菁英比率為：" + elitism + "%");
}

if(problem.equals("TSP")){
    out.println("TSP");
    
    int CrossoverType = 1;
    int MutationType  = 1;
    
	if(crossover.equals("CyclingCrossoverP")){
	    CrossoverType = 1;
    }
    else if(crossover.equals("PMX")){
        CrossoverType = 2;
    }
    
	if(mutation.equals("swapMutation")){
	    MutationType  = 1;
    }
    else if(mutation.equals("shiftMutation")){
        MutationType  = 2;
    }
    
    System.out.print("TSP SGA 1010 DOE");
    TSP_Run TSP1 = new TSP_Run();
    double crossoverRate[], mutationRate[];
    crossoverRate = new double[]{crossrate};//1, 0.5
    mutationRate  = new double[]{mutarate};
    int counter = 0;
    double elitismArray[] = new double[]{elitism};
    int generationsArray[] = new int[]{generations};
    int numInstances = 1;
    int repeat = 30;

    //to test different kinds of combinations.
      for(int i = 1 ; i < 2 ; i ++ ){//numInstances
        //initiate scheduling data, we get the data from a program.
        openga.applications.data.TSPInstances TSPInstances1 = new openga.applications.data.TSPInstances();
        TSPInstances1.setData(TSPInstances1.getFileName(i));
        TSPInstances1.getDataFromFile();
        String instanceName = TSPInstances1.getFileName(i);
        TSPInstances1.calcEuclideanDistanceMatrix();
        int length = TSPInstances1.getSize();
        
        for(int j = 0 ; j < crossoverRate.length ; j ++ ){
          for(int k = 0 ; k < mutationRate.length ; k ++ ){
            for(int n = 0 ; n < elitismArray.length ; n ++ ){
                for(int m = 0 ; m < repeat ; m ++ ){
                  System.out.println(counter);
                  TSP1.setParameter(i, crossoverRate[j], mutationRate[k], counter, elitismArray[n], generationsArray[0],
                          TSPInstances1.getOriginalPoint(), TSPInstances1.getCoordinates(),
                          TSPInstances1.getDistanceMatrix(), TSPInstances1.getSize(), instanceName);
                  TSP1.initiateVars(CrossoverType, MutationType);
                  TSP1.start();
                  counter ++;
                }             
            }
          }
        }
      }//end for   
    System.exit(0);
}
else if(problem.equals("SingleMachine")){
    out.println("SingleMachine");
    
    int CrossoverType = 1;
    int MutationType  = 1;
    
    if(crossover.equals("twoPointCrossover2")){
        CrossoverType = 1;
    }
    else if(crossover.equals("PMX")){
        CrossoverType = 2;
    }
    
	if(mutation.equals("shiftMutation")){
	    MutationType  = 1;
    }
    else if(mutation.equals("inverseMutation")){
        MutationType  = 2;
    }
    
    singleMachine_Run singleMachine1 = new singleMachine_Run();
    System.out.println("singleMachineGA_SKS_20070506");
    //openga.applications.data.singleMachine singleMachineData = new openga.applications.data.singleMachine();
    int jobSets[] = new int[]{20, 30, 40, 50, 60, 90};//20, 30, 40, 50, 60, 90, 100, 200//20, 40, 60, 80
    int counter = 0;
    int repeatExperiments = 30;

    int popSize[] = new int[]{100};//50, 100, 155, 210 [100]
    double crossoverRate[] = new double[]{crossrate},//0.6, 0.9 {0.9}
           mutationRate [] = new double[]{mutarate};//0.1, 0.5 {0.5}
           // elitism = 0.2;

    //Sourd Instance
    for(int i = 0 ; i < repeatExperiments ; i ++ ){
      for(int m = 0 ; m < jobSets.length ; m ++ ){//jobSets.length
        for(int k = 0 ; k < 49 ; k ++ ){
          if(jobSets[m] <= 50 ||  (jobSets[m] > 50 && k < 9)){
            System.out.println("Combinations: "+counter);
            openga.applications.data.singleMachine readSingleMachineData1 = new openga.applications.data.singleMachine();
            int numberOfJobs = jobSets[m];
            String fileName = readSingleMachineData1.getFileName(numberOfJobs, k);
            //fileName = "bky"+numberOfJobs+"_1";
            System.out.print(fileName+"\t");
            readSingleMachineData1.setData("sks/"+fileName+".txt");
            readSingleMachineData1.getDataFromFile();
            int dueDate[] = readSingleMachineData1.getDueDate();
            int processingTime[] = readSingleMachineData1.getPtime();

            singleMachine1.setData(numberOfJobs, dueDate, processingTime, fileName);
            singleMachine1.initiateVars(CrossoverType, MutationType);
            singleMachine1.startMain();
            counter ++;
          }
        }
      }
    }//end for
    System.exit(0);

    /*
    //BKY Instance
    int incrementSteps = 5;
    for(int i = 0 ; i < repeatExperiments ; i ++ ){
      for(int j = 0 ; j < jobSets.length ; j ++ ){//jobSets.length
        for(int k = 0 ; k < popSize.length ; k ++ ){
          for (int m = 0; m < crossoverRate.length; m++) {
            for (int n = 0; n < mutationRate.length; n++) {
              for(int p = 296 ; p < 297 ; ){
                openga.applications.data.readSingleMachine readSingleMachineData1 = new openga.applications.data.readSingleMachine();
                int numberOfJobs = jobSets[j];
                String fileName = readSingleMachineData1.getFileName(numberOfJobs, p);
                readSingleMachineData1.setData("instances/SingleMachineBKS/"+fileName+".txt");
                if(readSingleMachineData1.testReadData()){//to test whether the file exist
                  System.out.print("Combinations: "+counter+"\t");
                  System.out.print(fileName+"\t");
                  readSingleMachineData1.getDataFromFile();
                  int dueDate[] = readSingleMachineData1.getDueDate();
                  int processingTime[] = readSingleMachineData1.getPtime();

                  singleMachine1.setData(numberOfJobs, dueDate, processingTime, fileName);
                  singleMachine1.setParameters(popSize[k], crossoverRate[m], mutationRate[n], 100000);
                  singleMachine1.initiateVars();
                  singleMachine1.startMain();
                  counter ++;
                }
                p += incrementSteps;
              }
            }
          }
        }
      }
    }//end for
    */
}
else if(problem.equals("flowshop")){
    out.println("flowshop");
    
    int CrossoverType = 1;
    int MutationType  = 1;
    
    if(crossover.equals("twoPointCrossover2")){
        CrossoverType = 1;
    }
    else if(crossover.equals("PMX")){
        CrossoverType = 2;
    }
    
	if(mutation.equals("shiftMutation")){
	    MutationType  = 1;
    }
    else if(mutation.equals("inverseMutation")){
        MutationType  = 2;
    }
    
    System.out.println("in flow shop SGA");
    flowshop_Run flowshop1 = new flowshop_Run();
    int repeatExperiments = 30;
    int numberOfJob[] = new int []{20, 40, 60, 80};//
    int numberOfMachines = 20;
    int counter = 0;
    double kValues[] = new double[]{0.8};
    double targetValue[] = new double[]{0.5};

    int cores = 2;
    
        

    for(int j = 0 ; j < numberOfJob.length ; j ++ ){
      for(int k = 0 ; k < kValues.length ; k ++ ){
        for(int m = 0 ; m < targetValue.length ; m ++ ){
          for(int i = 0 ; i < repeatExperiments/cores ; i ++ ){
            ExecutorService application0 = Executors.newCachedThreadPool();
            //ArrayList<Callable> retrieverTasks = new ArrayList<Callable>();
            //ArrayList<Callable<T>> retrieverTasks = new ArrayList<Callable<T>>();
            flowshop_Run flowshopArray[] = new flowshop_Run[cores];
            for(int x = 0 ; x < cores ; x ++){
              System.out.println(counter++);
              flowshopArray[x] = new flowshop_Run();
              flowshopArray[x].setFlowShopData(numberOfJob[j], numberOfMachines);
              flowshopArray[x].setParameters(kValues[k], targetValue[m]);
              flowshopArray[x].initiateVars(CrossoverType, MutationType);
              //retrieverTasks.add((Callable<T>)flowshopArray[x]);
            }
            // flowshopArray[0].sendToPool(flowshopArray);
            //application.shutdown();
          }//end for
        }
      }
    }
    System.exit(0);

    
    for(int i = 0 ; i < repeatExperiments ; i ++ ){
      for(int j = 0 ; j < numberOfJob.length ; j ++ ){
        for(int k = 0 ; k < kValues.length ; k ++ ){
          for(int m = 0 ; m < targetValue.length ; m ++ ){
            System.out.println(counter++);
            flowshop1.setFlowShopData(numberOfJob[j], numberOfMachines);
            flowshop1.setParameters(kValues[k], targetValue[m]);
            flowshop1.initiateVars(CrossoverType, MutationType);
            flowshop1.start();
          }
        }
      }
    }//end for
}
else if(problem.equals("ParallelMachine")){
    out.println("ParallelMachine");
    
    // twoPointCrossover2
    
	// inverseMutation
	
    ParallelMachine_Run flowshopParallelMachine1 = new ParallelMachine_Run();
    flowshopParallelMachine1.tran(crossrate, mutarate, generations, yn, elitism);
    flowshopParallelMachine1.initiateVars();
    flowshopParallelMachine1.start();
}
else if(problem.equals("knapsack Problem")){
    out.println("knapsack Problem");
    
    int CrossoverType = 1;
    
	if(crossover.equals("uniformCrossover")){
	    CrossoverType = 1;
    }
    else if(crossover.equals("onePointBinaryCrossover")){
        CrossoverType = 2;
    }
    
    System.out.println("knapsackSGA_DOE20101107");
    int popSize[] = new int[]{100};//100, 200
    int numberOfItem[] = new int []{500};//100, 250, 500
    int numberOfKnapsack[] = new int[]{5, 10, 30};//5, 10, 30

    double crossoverRate[] = new double[]{crossrate, 0.5},//0.9, 0.5
           mutationRate[] = new double[]{mutarate, 0.1},//0.5, 0.1
           elitismArray[] = new double[]{elitism, 0.1};//0.2, 0.1
    int repeatExperiments = 30;
    int counter = 0;

    for(int i = 0 ; i < numberOfItem.length ; i ++ ){
      for(int j = 0 ; j < numberOfKnapsack.length ; j ++ ){
        knapsackORLibProblems knapsackORLibProblems1 = new knapsackORLibProblems();
        knapsackORLibProblems1.readInstanceData(numberOfItem[i], numberOfKnapsack[j]);

        int numberOfInstanceReplications = knapsackORLibProblems1.getInstanceReplications();
        double profit[][] = knapsackORLibProblems1.getProfit();
        double weights[][][] = knapsackORLibProblems1.getWeights();
        double rightHandSide[][] = knapsackORLibProblems1.getRightHandSide();        

        for(int k = 0 ; k < numberOfInstanceReplications ; ){
          for(int m = 0 ; m < crossoverRate.length ; m ++){
            for(int n = 0 ; n < mutationRate.length ; n ++){
              for(int p = 0 ; p < elitismArray.length ; p ++){
                for(int x = 0 ; x < repeatExperiments ; x ++ ){
                  String instanceName = "knapsack"+numberOfItem[i]+"-"+numberOfKnapsack[j]+"-"+k;
                  knapsackSGA_Run knapsackSGA1 = new knapsackSGA_Run();
                  knapsackSGA1.setData(numberOfItem[i], numberOfKnapsack[j], popSize[0], crossoverRate[m], mutationRate[n], elitismArray[p]);
                  knapsackSGA1.setKnapsackData(instanceName, profit[k], weights[k], rightHandSide[k]);
                  knapsackSGA1.initiateVars(CrossoverType);
                  knapsackSGA1.start();
                }
              }
            }
          }
          //k += 10; //Choosing the first instance when we do the DOE.
        }

      }
    }
    
	// bitFlipMutation
	
}
else if(problem.equals("QAP")){
    out.println("QAP");
    
    int CrossoverType = 1;
    int MutationType  = 1;
    
    if(crossover.equals("twoPointCrossover2")){
        CrossoverType = 1;
    }
    else if(crossover.equals("PMX")){
        CrossoverType = 2;
    }
    
	if(mutation.equals("swapMutation")){
	    MutationType  = 1;
    }
    else if(mutation.equals("shiftMutation")){
        MutationType  = 2;
    }
    
    int repeatExperiments = 30;
    int seed[] = new int[repeatExperiments];
    int popSize[] = new int[]{100, 200};//100, 200{100}
    double crossoverRate[] = new double[]{crossrate, 0.9};//0.6, 0.9 (0.6)
    double mutationRate[]  = new double[]{mutarate, 0.5};//0.1, 0.5 (0.1)
    double elitismArray[] = new double[]{elitism};
    int totalSolnsToExamine = 100000;//100000 is the default one for Zvi Drezner.
    int counter = 0;
    /*
     "nug30.dat", "ste36a.dat", "sko49.dat", "tai60a.dat",
       "sko72.dat", "sko81.dat", "sko90.dat", "wil100.dat"
    */
   String filenames[] = new String[]{"nug30.dat", "ste36a.dat", "sko49.dat", "tai60a.dat",
       "sko72.dat", "sko81.dat", "sko90.dat", "wil100.dat"};

    for(int i = 0 ; i < seed.length ; i ++ ){
      seed[i] = i+500;
    }

    //to test different kinds of combinations.
    for(int i = 0 ; i < filenames.length ; i ++ ){
      String fileName = "instances\\QAP\\";
      fileName += filenames[i];
      readQAPData readQAPData1 = new readQAPData();
      readQAPData1.setData(fileName);
      readQAPData1.getDataFromFile();
      int size = readQAPData1.getSize();

      for(int j = 0 ; j < popSize.length ; j ++ ){
        for(int k = 0 ; k < crossoverRate.length ; k ++ ){
          for(int m = 0 ; m < mutationRate.length ; m ++ ){
            for(int n = 0 ; n < seed.length ; n ++ ){//replications
              QAP_NVR_Run QAP_NVR1 = new QAP_NVR_Run();
              System.out.println(counter);
              //totalSolnsToExamine = Math.max(100000, 100*20*size);
              totalSolnsToExamine = 1000*size;
              QAP_NVR1.setParameter(i, popSize[j], crossoverRate[k], mutationRate[m], counter, elitismArray[0], totalSolnsToExamine);
              QAP_NVR1.setQAPData(size, readQAPData1.getFlow(), readQAPData1.getDistance());
              QAP_NVR1.setData(fileName);
              QAP_NVR1.initiateVars(CrossoverType, MutationType);
              QAP_NVR1.start();
              counter ++;
            }//end for
          }
        }
      }
    }

    System.exit(0);
}

%>

</body>
</html>