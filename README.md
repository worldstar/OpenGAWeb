專案介紹:    
    本專案目標為設計一個網頁，讓使用者能夠使用專案內包含的基因遺傳演算法解決以下六種最佳化問題:TSP、Single Machine Problem、Parallel Machine Problem、Knapsack Problem、
    Flowshop Problem、QAP

運行環境需求:    
    Thymeleaf、Tomcat

安裝及運行步驟:     
    
    1.在Eclipse中，選擇 Help -> Eclipse Marketplace，搜尋STS(建議4.17以後版本)並安裝   

    ![image text](https://github.com/worldstar/OpenGAWeb/blob/22ded745d36536660ab79752e9418282bb86bbe9/readmepicture/classpath1.png)
    
    2.下載並解壓縮本專案後，點選 File -> open project from File System，找到本專案根目錄opengaWeb並fininsh
    
    3.在Eclipse中，於新專案根目錄上方點擊右鍵並選取properties，Java Build Path -> classpath -> Add JARs，找到src/main/webapp/WEB-INF/lib/openga.jar並套用    
    
    4.下載並安裝Tomcat，並在Eclipse中點開Server並創建new server，選擇Apache -> Tomcat v9.0 server，然後點擊browse並找到Tomcat根目錄，點擊完成後環境建立完成
