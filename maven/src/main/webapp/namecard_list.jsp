<%@page import="com.smhrd.model.FarmhouseDTO"%>
<%@page import="com.smhrd.model.FarmhouseDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>농가 목록</title>
    <style>
        body {
            margin: 0px;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: mintcream;
        }
        .navbar-brand {
            font-size: 40px;
            font-family: Georgia, 'Times New Roman', Times, serif;
            color: cadetblue;
            text-decoration: none;
        }
        .search-bar {
            display: flex;
        }
        .search-bar input[type="search"] {
            padding: 5px;
            font-size: 16px;
        }
        .search-bar button {
            padding: 5px 10px;
            font-size: 16px;
            border: none;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }
        .search-bar button:hover {
            background-color: #45a049;
        }
        .wrap {
            width: 100%;
            background-color: whitesmoke;
            padding: 20px 0;
        }
        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .col {
            flex: 1 1 30%;
            max-width: 30%;
            box-sizing: border-box;
            padding: 15px;
        }
        .card {
            width: 100%;
            padding: 10px;
            border: 1px solid darkgray;
            border-radius: 5px;
            background-color: white;
        }
        .card img {
            border-radius: 5px 5px 0 0;
            width: 100%;
            height: auto;
        }
        .card-body {
            padding: 10px;
        }
        .card-body h5 {
            font-size: 18px;
            font-weight: bold;
            margin: 10px 0;
        }
        .card-body p {
            margin: 5px 0;
        }
        .qr-img {
            width: 30px; /* QR 코드 크기를 줄입니다 */
            height: 30px; /* QR 코드 크기를 줄입니다 */
            float: left;
            margin-right: 10px;
            object-fit: contain; /* 이미지가 주어진 영역에 맞춰지도록 합니다 */
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #4CAF50;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 10px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .footer {
            width: 100%;
            height: 130px;
            background-color: darkcyan;
            text-align: center;
            padding: 20px 0;
        }
        .footer img {
            width: 200px;
            border-radius: 30px;
        }
        @media (max-width: 1200px) {
            .col {
                flex: 1 1 45%;
                max-width: 45%;
            }
        }
        @media (max-width: 768px) {
            .col {
                flex: 1 1 100%;
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
  <!-- 네비바 -->
  <nav class="navbar">
    <a href="SFarm_main.jsp" class="navbar-brand">SFarm</a>
    <form class="search-bar" method="get" action="namecard_list.jsp">
        <select name="filterType">
            <option value="fh_name">농장명</option>
            <option value="agri_name">품목명</option>
        </select>
        <input type="search" name="searchKeyword" placeholder="검색어를 입력해주세요." aria-label="Search">
        <button type="submit">Search</button>
    </form>
  </nav>

  <div class="wrap">
    <div class="container">
        <%
            String filterType = request.getParameter("filterType");
            String searchKeyword = request.getParameter("searchKeyword");
            FarmhouseDAO dao = new FarmhouseDAO();
            ArrayList<FarmhouseDTO> fh_dto_list = dao.getAllFarmhouses();
            ArrayList<FarmhouseDTO> filteredList = new ArrayList<>();

            if (fh_dto_list != null && filterType != null && searchKeyword != null) {
                searchKeyword = searchKeyword.toLowerCase(); // 검색어를 소문자로 변환
                for (FarmhouseDTO dto : fh_dto_list) {
                    if (filterType.equals("fh_name") && dto.getFh_name().toLowerCase().contains(searchKeyword)) {
                        filteredList.add(dto);
                    } else if (filterType.equals("agri_name") && dto.getAgri_name().toLowerCase().contains(searchKeyword)) {
                        filteredList.add(dto);
                    }
                }
            } else {
                filteredList = fh_dto_list;
            }

            if (filteredList != null && !filteredList.isEmpty()) {
                String currentFhName = "";
                ArrayList<String> agriNamesList = new ArrayList<>();
                FarmhouseDTO currentFarmhouse = null;

                for (FarmhouseDTO dto : filteredList) {
                    if (!dto.getFh_name().equals(currentFhName)) {
                        if (currentFarmhouse != null) {
        %>
        <div class="col">
            <div class="card">
                <img src="./img/수박포도.jpg" class="card-img-top" alt="농장이미지">
                <div class="card-body">
                    <h5 class="card-title"><%= currentFarmhouse.getFh_name() %></h5>
                    <div>
                        <img class="qr-img" src="./img/qr.png">
                    </div>
                    <div style="clear: both;"></div>
                    <p class="card-text"><%= currentFarmhouse.getFh_intro() %></p>
                    <p>Tell. <%= currentFarmhouse.getFh_owner() %></p>
                    <p>농산물: <%= String.join(", ", agriNamesList) %></p> <!-- 농산물 이름들 표시 -->
                    <a href="S_NameCardCon?mb_id=<%= currentFarmhouse.getMb_id() %>&fh_name=<%= currentFarmhouse.getFh_name() %>" class="btn">들어가기</a>
                </div>
            </div>
        </div>
        <%
                        }
                        currentFhName = dto.getFh_name();
                        currentFarmhouse = dto;
                        agriNamesList.clear();
                    }
                    agriNamesList.add(dto.getAgri_name());
                }
                if (currentFarmhouse != null) {
        %>
        <div class="col">
            <div class="card">
                <img src="./img/수박포도.jpg" class="card-img-top" alt="농장이미지">
                <div class="card-body">
                    <h5 class="card-title"><%= currentFarmhouse.getFh_name() %></h5>
                    <div>
                        <img class="qr-img" src="./img/qr.png">
                    </div>
                    <div style="clear: both;"></div>
                    <p class="card-text"><%= currentFarmhouse.getFh_intro() %></p>
                    <p>Tell. <%= currentFarmhouse.getFh_owner() %></p>
                    <p>농산물: <%= String.join(", ", agriNamesList) %></p> <!-- 농산물 이름들 표시 -->
                    <a href="S_NameCardCon?mb_id=<%= currentFarmhouse.getMb_id() %>&fh_name=<%= currentFarmhouse.getFh_name() %>" class="btn">들어가기</a>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <p>농가 정보가 없습니다.</p>
        <%
            }
        %>
    </div>
  </div>

  <!-- footer -->
  <footer class="footer">
    <div class="footer-container">
      <img class="acs-img" src="./img/농림축산식품부_국_좌우.jpg" alt="농림축산이미지">
    </div>
  </footer>

</body>
</html>
