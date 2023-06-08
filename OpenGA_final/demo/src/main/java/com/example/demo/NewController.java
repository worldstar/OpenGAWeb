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
import opengaRun.TSP;




@Controller
public class NewController {
	@PostMapping("/processForm2")
    public String processForm(@RequestParam("file") MultipartFile file, Model model, @RequestParam("problem") String problem,@RequestParam("selection") String selection,
    			@RequestParam("crossover") String crossover, @RequestParam("mutation") String mutation, @RequestParam("crossrate") String crossrate0, @RequestParam("mutarate") String mutarate0,
    			@RequestParam("generations") String generations0, @RequestParam("yn") String yn0, @RequestParam("elitism") String elitism0) {
			
		String fileNameForPath = "";
		String resultString = "";

        if (!file.isEmpty()) {
            try {
                String uploadDirectory = "C:\\Users\\a0909\\eclipse-workspace\\demo\\instances\\TSP"; // 目標儲存路徑

                // 確認上傳目錄存在
                File uploadDir = new File(uploadDirectory);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                fileNameForPath = file.getOriginalFilename();
                // 檔案儲存路徑
                String filePath = uploadDirectory + File.separator + fileNameForPath;

                // 儲存檔案
                file.transferTo(new File(filePath));
                
                // 將檔案名稱存儲在模型中
                model.addAttribute("fileNameForPath", fileNameForPath);
                //System.out.println(fileNameForPath);
                
                // 設置模型數據，可選
                model.addAttribute("message", "檔案上傳成功！");
            } catch (IOException e) {
                // 處理檔案上傳錯誤
                model.addAttribute("error", "檔案上傳失敗：" + e.getMessage());
            }
        } else {
            // 檔案為空
            model.addAttribute("error", "檔案為空！");
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
        	out.println("你所需要的菁英比率為：" + elitism + "%");
        }
        else
        {
            elitism = 0;
        	out.println("你所需要的菁英比率為：" + elitism + "%");
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
        
        // 轉發請求到 test2.jsp
        return "result";
    }
}