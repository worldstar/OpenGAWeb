專案介紹:    
    本專案目標為設計一個網頁，讓使用者能夠使用專案內包含的基因遺傳演算法解決以下六種最佳化問題:TSP、Single Machine Problem、Parallel Machine Problem、Knapsack Problem、
    Flowshop Problem、QAP


運行環境需求:    
    Thymeleaf、Tomcat

安裝及運行步驟:    

    1.下載並安裝 Eclipse 和 Java   
    
    2.在Eclipse中，選擇 Help -> Eclipse Marketplace，搜尋STS(建議4.17以後版本)並安裝    
    
    3.點選new-project -> Springstarter project開啟新的Spring Boot專案    
    
    4.下載並解壓縮本專案後，將opengaWeb/src/main/資料夾中的內容複製並取代新開啟專案的main資料夾中的內容    
    
    5.將本專案根目錄下pom.xml中的dependencies添加到新專案中的pom.xml    
    
    6.在Eclipse中，於新專案根目錄上方點擊右鍵並選取properties，Java Build Path -> classpath -> Add JARs，找到src/main/webapp/WEB-INF/lib/openga.jar並套用    
    
    7.下載並安裝Tomcat，並在Eclipse中點開Server並創建new server，選擇Apache -> Tomcat v9.0 server，然後點擊browse並找到Tomcat根目錄，點擊完成後環境建立完成
