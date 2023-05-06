package com.example.demo;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.HttpClientBuilder;

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
        
    
    @PostMapping("/upload")
    public String handleUpload(@RequestParam("avatar") MultipartFile avatar, Model model) throws IOException {
        
    	

        
        String fileName = avatar.getOriginalFilename();
        String fileType = avatar.getContentType();
        long fileSize = avatar.getSize();
     
        

        String savePath = "D:\\" + fileName;
        File destFile = new File(savePath);

        try {

          avatar.transferTo(destFile);

        } catch (IOException e) {

        }
        

        return "result";
    }
}
