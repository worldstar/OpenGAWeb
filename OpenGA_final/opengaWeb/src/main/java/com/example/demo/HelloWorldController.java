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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.Part;


@Controller
public class HelloWorldController {
    
   public List<String> templateNames = Arrays.asList("algorithmForm", "upload_form");
    
   @ModelAttribute
    public  void addAttributes(Model model) {
   	model.addAttribute("templateNames", templateNames);
   }


   @GetMapping("/homepage")
   public String homepage() {          
       return "homepage";
   }
     

    @GetMapping("/algorithmForm")
    public String algorithmForm() {          
        return "algorithmForm";
    }
    

    @GetMapping("/upload_form")
    public String upload_form() {          
        return "upload_form";
    }
        
    @PostMapping("/processForm")
    public String processForm(@RequestParam("file") MultipartFile file, Model model, RedirectAttributes redirectAttributes) {
    	

        if (!file.isEmpty()) {
            try {
                String uploadDirectory = "C:\\Users\\a0909\\eclipse-workspace\\demo\\instances\\TSP"; // 目標儲存路徑

                // 確認上傳目錄存在
                File uploadDir = new File(uploadDirectory);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                String fileNameForPath = file.getOriginalFilename();
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

        // 轉發請求到 test2.jsp
        return "redirect:/test3.jsp";
    }

    

}
