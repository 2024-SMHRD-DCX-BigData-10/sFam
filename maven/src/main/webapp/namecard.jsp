<%@page import="com.smhrd.model.FarmhouseDTO"%>
<%@page import="com.smhrd.model.CertificationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>농가 및 농산품 정보</title>
<style>
    .container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
    }
    .card {
        width: 300px; /* 명함의 너비 */
        height: auto; /* 명함의 높이를 콘텐츠에 맞게 자동 조정 */
        margin: 10px;
        border: 1px solid darkgray;
        padding: 10px;
        box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
        border-radius: 5px;
        background-color: white;
        box-sizing: border-box;
        transition: background-color 0.3s;
    }
    .card:hover {
        background-color: #f0f0f0;
    }
    .card h5 {
        font-size: 18px;
        margin-bottom: 5px;
    }
    .card p {
        margin: 2px 0;
    }
    .qr-code {
        width: 50px; /* QR 코드의 크기를 줄입니다. */
        height: 50px;
        float: right;
        margin-left: 10px;
        object-fit: contain; /* 이미지가 주어진 영역에 맞춰지도록 합니다. */
    }
    .card ul {
        list-style-type: none;
        padding-left: 0;
        margin: 5px 0;
    }
    .card ul li {
        display: inline;
        margin-right: 5px;
    }
    .certification {
        margin-top: 10px;
    }
    .certification img {
        width: 50px; /* 인증 이미지 크기 */
        height: 50px;
        margin-right: 5px;
    }
</style>
<script>
<<<<<<< master
    function moveToPoster(fhName) {
        window.location.href = "poster.jsp?fh_name=" + encodeURIComponent(fhName);
<<<<<<< HEAD
=======
    function showProductDetails(agriName) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "ProductDetailsCon?agri_name=" + encodeURIComponent(agriName), true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                document.getElementById("productDetails").innerHTML = xhr.responseText;
            }
        };
        xhr.send();
>>>>>>> 3aa34a1 0610마무리
=======
>>>>>>> branch 'master' of https://github.com/2024-SMHRD-DCX-BigData-10/SFarm.git
    }
</script>
</head>
<body>
    <div class="container">
        <%
            List<FarmhouseDTO> farm_name = (List<FarmhouseDTO>) request.getAttribute("farm_name");
            List<String> qrPaths = (List<String>) request.getAttribute("qrPaths");
            List<CertificationDTO> certificationList = (List<CertificationDTO>) request.getAttribute("certificationList");

            if (farm_name != null && qrPaths != null) {
                for (int i = 0; i < farm_name.size(); i++) {
                    FarmhouseDTO x = farm_name.get(i);
                    String qrCodePath = qrPaths.get(i);
        %>
                    <div class="card">
                        <h5 class="card-title"><%= x.getFh_name() %></h5>
                        <p>농장주: <%= x.getFh_owner() %></p>
                        <ul>
                        <%
                            for (FarmhouseDTO dto : farm_name) {
                                if (dto.getFh_name().equals(x.getFh_name())) {
                                    String agri_name = dto.getAgri_name();
                        %>
                                    <li><a href="javascript:void(0)" onclick="showProductDetails('<%= agri_name %>')"><%= agri_name %></a></li>
                        <%
                                }
                            }
                        %>
                        </ul>
                        <div>
                        <%
                            if (qrCodePath != null) {
                        %>
                                <img src="<%= request.getContextPath() + qrCodePath %>" alt="QR Code" class="qr-code">
                        <%
                            } else {
                        %>
                                <h3>QR 없음</h3>
                        <%
                            }
                        %>
                        </div>
                        <p class="card-text"><%= x.getFh_intro() %></p>
                        <div class="certification">
                            <h5>인증 정보</h5>
                            <%
                                if (certificationList != null && !certificationList.isEmpty()) {
                                    for (CertificationDTO cert : certificationList) {
                                        if (cert.getFh_name().equals(x.getFh_name())) {
                            %>
                                            <p>인증 종류: <%= cert.getCert_type() %></p>
                                            <img src="<%= cert.getCert_img() %>" alt="인증 이미지">
                            <%
                                        }
                                    }
                                } else {
                            %>
                                    <p>인증 정보를 찾을 수 없습니다.</p>
                            <%
                                }
                            %>
                        </div>
                    </div>
        <%
                }
            } else {
        %>
                <h3>농가 정보가 없습니다.</h3>
        <%
            }
        %>
    </div>
    <div id="productDetails">
        <!-- 여기에 농산품 정보가 표시됩니다. -->
    </div>
</body>
</html>
