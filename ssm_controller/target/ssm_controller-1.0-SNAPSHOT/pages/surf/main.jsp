<%--
  Created by IntelliJ IDEA.
  User: Jiahao Dai
  Date: 2020/11/30
  Time: 16:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>首页</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>

    <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home_page.css">

    <script>
        $(function () {
            $.ajax({
                url:"${pageContext.request.contextPath}/masterPiece/findAll",
                contentType:"application/json;charset=utf-8",
                // data:'{"name":"djh", "age":18}',
                type:"post",
                dataType:"json",
                success:function (masterPieces){
                    console.log(masterPieces);
                    var card_box_list = $("#card-box-list");
                    var content = ""
                    for(var i = 0; i < masterPieces.length; i++){
                        content += '<div class="card-box">\n' +
                            '                    <div class="card-img">\n' +
                            //'                        <a href="${pageContext.request.contextPath}/masterPiece/findById?id='+masterPieces[i].id+'&viewNum='+masterPieces[i].viewNum+'">\n' +
                            '                        <a href="${pageContext.request.contextPath}/pages/surf/masterpiece2.jsp?id='+masterPieces[i].id+'&viewNum='+masterPieces[i].viewNum+'">\n' +
                            '                            <img class="list-img" src="${pageContext.request.contextPath}/'+masterPieces[i].coverUrl+'" alt="">\n' +
                            '                        </a>\n' +
                            '                    </div>\n' +
                            '                    <div class="card-info">\n' +
                            '                        <p class="card-info-title">'+masterPieces[i].masterpieceDesc+'</p>\n' +
                            '                        <p class="card-info-type">'+masterPieces[i].category.categoryDesc+'</p>\n' +
                            '                        <p class="card-info-item">\n' +
                            '                            <span class="statistics-view">点击:'+masterPieces[i].viewNum+'</span>\n' +
                            '                            <span class="statistics-comment">评论:'+masterPieces[i].comments.length+'</span>\n' +
                            '                            <span class="statistics-favor">投币:'+masterPieces[i].favorNum+'</span>\n' +
                            '                        </p>\n' +
                            '                    </div>\n' +
                            '                    <div class="card-item">'+
                            '                       <span class="user" style="float:left">'+masterPieces[i].userInfo.username+'</span>'+
                            '                       <span class="pubTime" style="float:right">'+masterPieces[i].pubTimeStr+'</span>'+
                            '                     </div>'+
                            '                </div>'
                    }
                    card_box_list.html(content)
                }
            })
        })

    </script>


</head>
<body>
<div class="wrapper">
<%--    头部--%>
    <jsp:include page="../../header.jsp"/>

    <div class="main-wrapper">
        <!--            轮播图-->
        <div class="Carousel-box">
            <div class="Carousel">
                <div class="banner">
                    <!--                    bootstrap-->
                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="2000">
                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                        </ol>

                        <!-- Wrapper for slides -->
                        <div class="carousel-inner" role="listbox">
                            <div class="item active">
                                <img class="banner-img" src="https://img.zcool.cn/community/0100385fc4ba8111013ee04dbfd81b.jpg@1380w" alt="...">
                            </div>
                            <div class="item">
                                <img class="banner-img" src="https://img.zcool.cn/community/01246a5fc4aa1511013fdcc74ce40c.png@1380w" alt="...">
                            </div>

                            <div class="item">
                                <img class="banner-img" src="https://img.zcool.cn/community/0126505fc4aade11013fdcc7a203fe.png@1380w" alt="...">
                            </div>
                        </div>

                        <!-- Controls -->
                        <a class="left carousel-control" href="#carousel-example-generic" role="button"
                           data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="right carousel-control" href="#carousel-example-generic" role="button"
                           data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>

                    </div>
                </div>
            </div>

            <!--                广告位-->
            <div class="advertise"></div>
        </div>

        <!--        中间部分-->

        <div class="text-desc">
            <p class="desc">图片展示</p>
        </div>

        <div class="all-list">
            <div class="work-list-box" id="card-box-list">

            </div>
        </div>
    </div>


</div>
</body>
</html>
