<%@page import="com.smhrd.model.FarmhouseDTO"%>
<%@page import="com.smhrd.model.FarmhouseDAO"%>
<%@page import="com.smhrd.model.CertificationDTO"%>
<%@page import="com.smhrd.model.CertificationDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>농가 및 농산품 정보</title>
<style>
    .container {
        display: flex;
    }
    .left {
        flex: 70%;
    }
    .right {
        flex: 30%;
        padding-left: 20px;
    }
    .qr-code {
        width: 100px;  /* QR 코드의 크기를 줄입니다. */
        height: 100px;
    }
</style>
<script>
    function showProductDetails(agriName) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "ProductDetailsCon?agri_name=" + encodeURIComponent(agriName), true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                document.getElementById("productDetails").innerHTML = xhr.responseText;
            }
        };
        xhr.send();
    }
</script>
</head>
<body>
    <%
        String mb_id = request.getParameter("mb_id");
        String fh_name = request.getParameter("fh_name");
        String qrCodePath = request.getParameter("qrCodePath");

        System.out.println("Received mb_id: " + mb_id);  // 디버깅용 출력
        System.out.println("Received fh_name: " + fh_name);  // 디버깅용 출력
        System.out.println("QR Code Path: " + qrCodePath);  // 디버깅용 출력

        FarmhouseDAO farmhouseDao = new FarmhouseDAO();
        CertificationDAO certificationDao = new CertificationDAO();
        ArrayList<FarmhouseDTO> fh_dto = null;
        ArrayList<CertificationDTO> certificationList = null;

        if (mb_id != null) {
            fh_dto = farmhouseDao.getFarmhouseDTO(mb_id);
            certificationList = certificationDao.getCertifications(fh_name);
            System.out.println("Farmhouse DTO List: " + fh_dto);  // 디버깅용 출력
            System.out.println("Certification List: " + certificationList);  // 디버깅용 출력
        } else {
            System.out.println("mb_id is null");
        }

        if (fh_dto != null && fh_dto.size() > 0) {
            FarmhouseDTO x = fh_dto.get(0);
    %>
        <div class="wrap" >

      <!-- 농가명함 시작 -->
        <div class="col">
            <div class="card" style=" border-color:black; width: 18rem; float:left; padding: 5px; margin-top: 90px; margin-left: 10px; margin-right: 10px;">
                
              <img src="./img/수박포도.jpg" class="card-img-top" alt="...">
              <div class="card-body">
                <h5 class="card-title"><%= x.getFh_name() %></h5>
                <p>농장주: <%= x.getFh_owner() %></p>
                 <ul>
                <%
                    for (FarmhouseDTO dto : fh_dto) {
                        String agri_name = dto.getAgri_name();
                %>
                    <li><a href="javascript:void(0)" onclick="showProductDetails('<%= agri_name %>')"><%= agri_name %></a></li>
                <%
                    }
                %>
                </ul>
                <div>
                   <%
                if (qrCodePath != null) {
            %>
             
               
                <h3>QR 코드:</h3>
                <img src="<%= request.getContextPath() + qrCodePath %>" alt="QR Code" class="qr-code">
            <%
                } else {
            %>
                <h3>QR 없음</h3>
            <%
                }
            %>
                </div>
                <div style="clear: both;"></div>
                <p class="card-text"><%= x.getFh_intro() %> 
                </p>
                <p>Tell.010-0000-0000</p>
              </div>
            </div>
          </div>
    <!-- 농가명함 끝 -->
    
        <div class="right">
            <h3>인증 정보</h3>
            <%
                if (certificationList != null && !certificationList.isEmpty()) {
                    for (CertificationDTO cert : certificationList) {
            %>
                <p>인증 종류: <%= cert.getCert_type() %></p>
                <p>인증 이미지: <img src="<%= cert.getCert_img() %>" alt="인증 이미지" class="qr-code"></p>
                <hr>
            <%
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
        } else {
    %>
        <h3>농가 정보가 없습니다.</h3>
    <%
        }
    %>

    <div id="productDetails">
        <!-- 여기에 농산품 정보가 표시됩니다. -->
    </div>
</body>
</html>
