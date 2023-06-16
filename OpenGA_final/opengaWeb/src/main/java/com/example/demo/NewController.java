package com.example.demo;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import jakarta.servlet.http.Part;
import openga.applications.data.TSPInstances;





@Controller
public class NewController {
	@PostMapping("/processForm2")
    public String processForm(@RequestParam("file") MultipartFile file, Model model, @RequestParam("problem") String problem,@RequestParam("selection") String selection,
    			@RequestParam("crossover") String crossover, @RequestParam("mutation") String mutation, @RequestParam("crossrate") String crossrate0, @RequestParam("mutarate") String mutarate0,
    			@RequestParam("generations") String generations0, @RequestParam("yn") String yn0, @RequestParam("elitism") String elitism0) {
			
		String fileNameForPath = "";
		String resultString = "";
		String uploadDirectory = "";
		if(problem.equals("TSP")) {
        if (!file.isEmpty()) {
            try {
                uploadDirectory = "C:\\Users\\a0909\\eclipse-workspace\\demo\\instances\\TSP"; // �ؼ��x�s���|

                // �T�{�W�ǥؿ��s�b
                File uploadDir = new File(uploadDirectory);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                fileNameForPath = file.getOriginalFilename();
                // �ɮ��x�s���|
                String filePath = uploadDirectory + File.separator + fileNameForPath;

                // �x�s�ɮ�
                file.transferTo(new File(filePath));
                
                // �N�ɮצW�٦s�x�b�ҫ���
                model.addAttribute("fileNameForPath", fileNameForPath);
                //System.out.println(fileNameForPath);
                
                // �]�m�ҫ��ƾڡA�i��
                model.addAttribute("message", "upload success");
            } catch (IOException e) {
                // �B�z�ɮפW�ǿ��~
                model.addAttribute("error", "upload failed" + e.getMessage());
            }
        } else {
            // �ɮ׬���
            model.addAttribute("error", "�ɮ׬��šI");
        }
        
        //StartGA


        String uploadfilePath = "instances/TSP/" + fileNameForPath;
        double crossrate   = Double.parseDouble(crossrate0)/100;
        double mutarate    = Double.parseDouble(mutarate0)/100;
        int generations = Integer.parseInt(generations0);
        int yn          = Integer.parseInt(yn0);
        double elitism     = Double.parseDouble(elitism0)/100;
        
        
/*        if(yn == 1)
        {
        	out.println("�A�һݭn���׭^��v���G" + elitism + "%");
        }
        else
        {
            elitism = 0;
        	out.println("�A�һݭn���׭^��v���G" + elitism + "%");
        }  */

        if(problem.equals("TSP")){
            System.out.println("TSP");
            
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
            System.out.println(uploadfilePath);
            File file1 = new File(uploadfilePath);
            System.out.println(file1.exists());
            opengaRun.TSP_Run TSP1 = new opengaRun.TSP_Run();
            double crossoverRate[], mutationRate[];
            crossoverRate = new double[]{crossrate};//1, 0.5
            mutationRate  = new double[]{mutarate};
            int counter = 0;
            double elitismArray[] = new double[]{elitism};
            int generationsArray[] = new int[]{generations};
            int numInstances = 1;

            opengaRun.TSPInstances TSPInstances1 = new opengaRun.TSPInstances();
       		
    		TSPInstances1.instituteLastString(uploadfilePath);
            TSPInstances1.setData(TSPInstances1.getFileName(TSPInstances1.getInstancesLength()-1));
            TSPInstances1.getDataFromFile();
            String instanceName = TSPInstances1.getFileName(TSPInstances1.getInstancesLength()-1);
            System.out.println(instanceName);
            TSPInstances1.calcEuclideanDistanceMatrix();
            int length = TSPInstances1.getSize();
            

                        TSP1.setParameter(0, crossoverRate[0], mutationRate[0], counter, elitismArray[0], generationsArray[0],
    						TSPInstances1.getOriginalPoint(), TSPInstances1.getCoordinates(),
                        	TSPInstances1.getDistanceMatrix(), TSPInstances1.getSize(), instanceName);
                      		TSP1.initiateVars(CrossoverType,MutationType);
                      		resultString = TSP1.start();
                      		model.addAttribute("resultString", resultString);
             //   System.exit(0);
        }
		}
		
		else if(problem.equals("SingleMachine")){

	        if (!file.isEmpty()) {
	            try {
	                uploadDirectory = "C:\\Users\\User\\eclipse-workspace\\opengaWeb\\sks"; // �ؼ��x�s���|

	                // �T�{�W�ǥؿ��s�b
	                File uploadDir = new File(uploadDirectory);
	                if (!uploadDir.exists()) {
	                    uploadDir.mkdirs();
	                }
	                
	                fileNameForPath = file.getOriginalFilename();
	                // �ɮ��x�s���|
	                String filePath = uploadDirectory + File.separator + fileNameForPath;

	                // �x�s�ɮ�
	                file.transferTo(new File(filePath));
	                
	                // �N�ɮצW�٦s�x�b�ҫ���
	                model.addAttribute("fileNameForPath", fileNameForPath);
	                //System.out.println(fileNameForPath);
	                
	                // �]�m�ҫ��ƾڡA�i��
	                model.addAttribute("message", "upload success");
	            } catch (IOException e) {
	                // �B�z�ɮפW�ǿ��~
	                model.addAttribute("error", "upload failed" + e.getMessage());
	            }
	        } else {
	            // �ɮ׬���
	            model.addAttribute("error", "�ɮ׬��šI");
	        }
	        
	        //StartGA
	        
	        System.out.println("SingleMachine");
	        
	        opengaRun.singleMachine_Run singleMachine1 = new opengaRun.singleMachine_Run();
	        System.out.println("singleMachineGA_SKS_20070506");
	        //openga.applications.data.singleMachine singleMachineData = new openga.applications.data.singleMachine();
	        int jobSets[] = new int[]{20, 30, 40, 50, 60, 90};//20, 30, 40, 50, 60, 90, 100, 200//20, 40, 60, 80
	        int counter = 0;
	        int repeatExperiments = 30;

	        int popSize[] = new int[]{100};//50, 100, 155, 210 [100]
	        double crossoverRate[] = new double[]{0.9},//0.6, 0.9 {0.9}
	               mutationRate [] = new double[]{0.5};//0.1, 0.5 {0.5}
	               // elitism = 0.2;

	        //Sourd Instance
//	        for(int i = 0 ; i < repeatExperiments ; i ++ ){
//	          for(int m = 0 ; m < jobSets.length ; m ++ ){//jobSets.length
//	            for(int k = 0 ; k < 49 ; k ++ ){
//	              if(jobSets[m] <= 50 ||  (jobSets[m] > 50 && k < 9)){
	                System.out.println("Combinations: "+counter);
	                opengaRun.singleMachine readSingleMachineData1 = new opengaRun.singleMachine();
	                readSingleMachineData1.instituteLastString(fileNameForPath);
	                
	               
	                String fileName = readSingleMachineData1.getFileName(20, readSingleMachineData1.getM20Length()-1);
	                //fileName = "bky"+numberOfJobs+"_1";
	                System.out.print(fileName+"\t");
	                readSingleMachineData1.setData("sks/"+fileName);
	                readSingleMachineData1.getDataFromFile();
//	                int numberOfJobs = readSingleMachineData1.objectNumber;
//	                System.out.println(numberOfJobs);
	                int numberOfJobs = 20;
	                int dueDate[] = readSingleMachineData1.getDueDate();
	                int processingTime[] = readSingleMachineData1.getPtime();

	                singleMachine1.setData(20, dueDate, processingTime, fileName);
	                singleMachine1.initiateVars();
	                resultString = singleMachine1.startMain();
	                model.addAttribute("resultString", resultString);
//	                counter ++;
//	              }
//	            }
//	          }
//	        }//end for
//	        System.exit(0);
		}
		
        // ��o�ШD�� test2.jsp
        return "result";
    }

}