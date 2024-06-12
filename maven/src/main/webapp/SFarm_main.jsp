<%@page import="com.smhrd.model.FarmhouseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SFarm 메인 페이지</title>
    <link rel="stylesheet" type="text/css" href="CSS/navbar.css">
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        body {
            margin: 0;
        }
        .main-background {
            position: relative;
            padding: 1px;
            width: 100%;
            height: 1000px;
            background-image: url(./img/main-banner.png);
            background-repeat: no-repeat;
            background-size: cover;
            filter: brightness(85%);
        }
        .main-title {
            color: white;
            font-weight: lighter;
            padding: 10px;
            font-size: 20px;
            margin-top: 300px;
            margin-left: 30px;
            padding-top: 30px;
            text-align: left;
        }
        .main-content {
        	border : 0px;
            color: white;
            font-size: 50px;
            font-weight: bold;
            font-style: italic;
            
            text-align: left;
            margin-left: 30px;
        }
        .main-button {
            padding: 1px;
            font-size: 20px;
            background: white;
            border-radius: 30px;
           
            padding: 7px;
            margin-top:30px;
            margin-left:30px;
            width: 130px;
            height: 70px;
            background-color: #154726;
            color: white;
            border-color: aliceblue;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }
        .main-button:hover {
            background-color: #123d2e;
            transform: scale(1.1);
        }
        .footer {
            width: 100%;
            height: 150px;
            background-color: #154726;
        }
        .acs-img {
            width: 200px;
            position: relative;
            top: 60px;
            left: 50px;
            border-radius: 30px;
        }
        .nav-join {
            font-size: 23px;
            color: rgb(90, 90, 90);
            font-family: fantasy;
            margin-left: 130px;
        }
        .nav-but {
            margin-left: 50px;
            margin-right: 50px;
        }
        .content-area {
        	border:0px;
            position: absolute;
            top: 100px;
            right: 30px;
            width: 30%; 
            padding: 20px;
            background-color: rgba(255, 255, 255, 0); /* 초기 상태에서 배경 투명 */
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0);
        }
        .loaded-content {
            background: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
            height: 1000px;
        }
        @media screen and (max-width: 1200px) {
            .nav-title a {
                font-size: 30px;
            }
            .nav-item a {
                font-size: 16px;
            }
            .main-content {
                font-size: 40px;
            }
            .main-button {
                width: 110px;
                height: 60px;
            }
        }
        @media screen and (max-width: 768px) {
            .nav-title a {
                font-size: 25px;
            }
            .nav-item a {
                font-size: 14px;
            }
            .main-content {
                font-size: 30px;
            }
            .main-button {
                width: 100px;
                height: 50px;
            }
        }
        @media screen and (max-width: 576px) {
            .nav-title a {
                font-size: 10px;
            }
            .nav-item a {
                font-size: 5px;
            }
            .main-title {
                font-size: 16px;
                margin-top: 200px;
            }
            .main-content {
                font-size: 24px;
            }
            .nav-but{
            	 
            	
            }
            .main-button {
                width: 90px;
                height: 60px;
                font-size: 16px;
            }
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // 네비게이션 링크 클릭 이벤트 처리


            // 회원가입 및 로그인 버튼 클릭 이벤트 처리
            $('.nav-but a').click(function(event) {
                event.preventDefault(); // 링크 기본 동작 방지
                var href = $(this).attr('href'); // 링크의 href 속성 가져오기

                // AJAX 요청 보내기
                $.ajax({
                    url: href,
                    method: 'GET',
                    success: function(data) {
                        $('#main-content').html(data).addClass('loaded-content'); // 응답 데이터를 메인 컨텐츠 영역에 삽입하고 스타일 적용
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX 요청 실패: ' + error);
                    }
                });
            });
            $('.new_farm').click(function(event) {
                event.preventDefault(); // 링크 기본 동작 방지
                var href = $(this).attr('href'); // 링크의 href 속성 가져오기

                // AJAX 요청 보내기
                $.ajax({
                    url: href,
                    method: 'GET',
                    success: function(data) {
                        $('#main-content').html(data).addClass('loaded-content'); // 응답 데이터를 메인 컨텐츠 영역에 삽입하고 스타일 적용
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX 요청 실패: ' + error);
                    }
                });
            });

            // 로그아웃 버튼 클릭 이벤트 처리
            $('.logout-btn').click(function(event) {
                event.preventDefault(); // 링크 기본 동작 방지
                var href = $(this).attr('href'); // 링크의 href 속성 가져오기
                window.location.href = href; // 로그아웃 링크를 실제로 이동
            });
        });
        
      
           	
        	 $(document).ready(function() {
        	        // h4.main-title 회전 애니메이션 (속도를 3초로 설정)
        	        $('.main-title').css({ 
        	            'opacity': '0',
        	            'transform': 'rotate(-180deg)'
        	        }).animate({ 
        	            'opacity': '1',
        	            'transform': 'rotate(0deg)'
        	        }, {
        	            duration: 3000, // 3초로 애니메이션 지속 시간을 설정
        	            step: function(now, fx) {
        	                if (fx.prop === 'opacity') {
        	                    var rotateValue = -180 + (180 * now);
        	                    $(this).css('transform', 'rotate(' + rotateValue + 'deg)');
        	                }
        	            }
        	        });
        	    });
        	
         $(document).ready(function() {
            // p.main-content 애니메이션
            $('.main-content').css({ 
                'opacity': '0'
            }).animate({ 
                'opacity': '1'
            }, {
                duration: 3000,
                step: function(now, fx) {
                    if (fx.prop === 'opacity') {
                        $(this).css('transform', 'translateY(' + (50 - 50 * now) + 'px)');
                    }
                }
            });
        });
        
        
    </script>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="main-background">
    <div class="main-expainbox">
        <h4 class="main-title">storytelling</h4>
        <p class="main-content">건강한 로컬푸드의<br>농가 이야기를 소개합니다.</p>
        <div><a href="namecard_list.jsp"><button class="main-button">농가<br>알아보기</button></a></div>
    </div>
    <%
         user_info = (MemberDTO) session.getAttribute("user_info");
        if (user_info != null) {
            FarmhouseDAO f_dao = new FarmhouseDAO();
            String mb_id = user_info.getMb_id();
            System.out.println("메인페이지" + mb_id);
    %>
        
        <div><a href="SFarm_registerPage.jsp" class="new_farm"><button class="main-button" >농장<br> 등록하기</button></a></div>
    <%
        }
    %>
</div>

<!-- 오른쪽 부분에 배경 이미지 위로 내용 삽입 -->
<div class="content-area" id="main-content">
    <!-- 여기에 AJAX 요청으로 로드된 내용이 삽입됩니다. -->
</div>

<!-- footer -->
<footer class="footer">
    <div class="footer-container">
        <img class="acs-img" src="./img/농림축산식품부_국_좌우.jpg" alt="농림축산이미지">
    </div>
</footer>
</body>
</html>
