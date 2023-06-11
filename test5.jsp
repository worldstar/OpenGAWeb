<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>取得下拉式選單的值</title>
    <script>
        let fruits = ["蘋果", "香蕉", "橘子"];
        let vegetables = ["胡蘿蔔", "馬鈴薯", "西蘭花"];

        function updateSecondMenu() {
            let firstMenuValue = document.getElementById("firstMenu").value;
            let secondMenu = document.getElementById("secondMenu");
            secondMenu.innerHTML = "";

            if (firstMenuValue === "1") {
                for (let i = 0; i < fruits.length; i++) {
                    let option = document.createElement("option");
                    option.text = fruits[i];
                    secondMenu.add(option);
                }
            } else if (firstMenuValue === "2") {
                for (let i = 0; i < vegetables.length; i++) {
                    let option = document.createElement("option");
                    option.text = vegetables[i];
                    secondMenu.add(option);
                }
            }
        }
    </script>
</head>
<body>
    <form action="test5.jsp" method="post">
        <label for="firstMenu">第一層選單：</label>
        <select id="firstMenu" name="firstMenu" onchange="updateSecondMenu()">
            <option value="0">請選擇</option>
            <option value="1">水果</option>
            <option value="2">蔬菜</option>
        </select>

        <br>

        <label for="secondMenu">第二層選單：</label>
        <select id="secondMenu" name="secondMenu">
        </select>

        <br>

        <input type="submit" value="提交">
    </form>

    <%
        String selectedValue = request.getParameter("secondMenu");
        if (selectedValue != null) {
            out.println("您所選擇的值為：" + selectedValue);
        }
    %>
</body>
</html>