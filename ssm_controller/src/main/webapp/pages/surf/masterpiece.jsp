<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>作品详情页面</title>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/masterpiece.css">

    <script>


        function dateToString() {
            var datetime = new Date();
            var year = datetime.getFullYear();
            var month = datetime.getMonth() + 1;
            var date = datetime.getDate();
            var hour = datetime.getHours();
            /*对月 日 时 分 秒 小于10的时候的处理  --小于 10 时前面加 0*/
            if (month <= 9) {
                month = "0" + month;
            }
            if (date <= 9) {
                date = "0" + date
            }
            if (hour <= 9) {
                hour = "0" + hour;
            }
            var minute = datetime.getMinutes();
            if (minute <= 9) {
                minute = "0" + minute;
            }
            var second = datetime.getSeconds();
            if (second <= 9) {
                second = "0" + second;
            }
            return year + "-" + month + "-" + date + " " + hour + ":" + minute
                + ":" + second;
        }


        $(function () {
            $("#comment-btn-div").click(function () {
                var content = $("#input-text").val();

                uid = ${sessionScope.userInfo.id};//这个在没有登录的情况下是错误的，所以可以使得点赞也点不了，但是登录之后就可以了
                // ${sessionScope.userInfo.id}在没登录的情况下什么都没有

                var mid = ${masterPiece.id};
                $.ajax({
                    url:"${pageContext.request.contextPath}/masterPiece/saveComments",
                    contentType:"application/json;charset=utf-8",
                    data:'{"pubTime":"'+dateToString()+'","favorNum":0,"content":"'+content+'", "mid":'+mid+', "uid":'+uid+'}',
                    type:"post",
                    success:function (){
                        location.href="${pageContext.request.contextPath}/masterPiece/findById?id="+mid;
                    }
                })
            })

            $("#favor-box").click(function () {
                var favorNum = $("#masterfavorNum").html();
                var id = ${masterPiece.id};
                console.log(favorNum);
                $.ajax({
                    url:"${pageContext.request.contextPath}/masterPiece/updateFavorNum",
                    contentType:"application/json;charset=utf-8",
                    data:'{"favorNum":'+favorNum+', "id":'+id+'}',// 发送请求成功了，但是它这个就是会标红 但是不会错
                    type:"post",
                    // dataType:"json",
                    success: function () {
                        favorNum++;
                        $("#masterfavorNum").html(favorNum)
                    }
                })
            })
        })


    </script>

</head>
<body>
<div class="wrapper">
    <%--    头部--%>
    <jsp:include page="../../header.jsp"/>

    <div class="main-wrapper">
        <!-- 作品简介及作者简介-->
        <div class="work-info">
            <div class="work-info-inner">
                <div class="left-part">
                    <div class="title-desc">${masterPiece.masterpieceDesc}</div>
                    <p class="pubTime">
                        ${masterPiece.pubTimeStr}
                    </p>
                    <div class="work-head">
                        <div class="left-head">
                            <span class="head-index">${masterPiece.category.categoryDesc}</span>
                        </div>
                        <div class="right-head">
                            <span>观看:${masterPiece.viewNum}</span>
                            <span>|</span>
                            <span>评论:${masterPiece.comments.size()}</span>
                            <span>|</span>
                            <span>点赞:${masterPiece.favorNum}</span>
                        </div>
                    </div>
                </div>

                <div class="right-part">
                    <div class="author-img">
                        <a href="#">
                            <img class="author-head"
                                 src="https://img.zcool.cn/community/01e0745d327ad2a80120695cb268f6.jpg@80w_80h_1c_1e_1o_100sh.jpg"
                                 alt="">
                        </a>
                    </div>

                    <div class="author-info">
                        <p class="author-name">${masterPiece.userInfo.username}</p>
                        <div class="btn-area">
                            <button class="btn btn-sm btn-default btn-1">关注</button>
                            <button class="btn btn-sm btn-primary btn-2">私信</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="work-content">
            <div class="work-content-inner">
                <p>
                    ${masterPiece.masterpieceContent}
                </p>
            </div>
        </div>
        <!-- 图片展示-->
        <!--            轮播图-->
        <div class="Carousel-box">
            <div class="Carousel">
                <div class="banner">
                    <!--                    bootstrap-->
                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="2000">
                        <!-- Wrapper for slides -->
                        <div class="carousel-inner" role="listbox">
                            <c:forEach items="${masterPiece.pictures}" var="picture" varStatus="s">
                                <c:if test="${s.count == 1}">
                                    <div class="item active">
                                        <img class="banner-img"
                                             src="${pageContext.request.contextPath}/${masterPiece.coverUrl}"
                                             alt="...">
                                    </div>
                                    <div class="item">
                                        <img class="banner-img"
                                             src="${pageContext.request.contextPath}/${picture.url}"
                                             alt="...">
                                    </div>
                                </c:if>
                                <c:if test="${s.count != 1}">
                                    <div class="item">
                                        <img class="banner-img"
                                             src="${pageContext.request.contextPath}/${picture.url}"
                                             alt="...">
                                    </div>
                                </c:if>
                            </c:forEach>
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

        <!--        点赞的图标-->
        <div class="work-favor">
            <div class="work-favor-inner">
                <div class="favor-box" id="favor-box">
                    <div>
                        <img src="${pageContext.request.contextPath}/img/favor.png" alt="">
                    </div>
                    <i class="incon" id="masterfavorNum">${masterPiece.favorNum}</i>
                </div>
            </div>
        </div>
        <!-- 评论部分-->
        <div class="comment-module">
            <div class="comment-module-inner">
                <c:if test="${sessionScope.userInfo != null}">
                    <div class="text-input">
                        <textarea type="text" id="input-text"></textarea>
                        <div class="btn-div" id="comment-btn-div">
                            <button class="btn btn-primary btn-sm">发表评论</button>
                        </div>
                    </div>
                </c:if>

                <c:if test="${sessionScope.userInfo == null}">
                    <div class="text-input">
                        <div id="btn-login">
                            <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/pages/surf/login.jsp'">登录</button>
                        </div>
                    </div>
                </c:if>


                <div class="detail-all-comment">
                    <div class="comment-title">全部评论 ${masterPiece.comments.size()}</div>
                    <div class="comment-list-div">
                        <ul class="comment-list-ul">
                            <c:forEach items="${masterPiece.comments}" var="comment">
                                <li class="comment-list">
                                    <div class="comment-content">
                                        <div class="comment-user">
                                            <a href="#">
                                                <img class="user-img"
                                                     src="https://img.zcool.cn/community/0113dc5f0d691aa801206621f7e6d0.jpg@80w_80h_1c_1e_1o_100sh.jpg"
                                                     alt="">
                                            </a>
                                        </div>

                                        <div class="comment-info">
                                            <div class="comment-user-name">
                                                ${comment.userInfo.username}
                                            </div>
                                            <div class="comment-content-words">
                                                ${comment.content}
                                            </div>
                                            <div class="comment-bottom">
                                                <span class="comment-pubTime">${comment.pubTimeStr}</span>
                                                <div class="comment-favor">
                                                    <img class="favor-img" src="${pageContext.request.contextPath}/img/favor.png" alt="">
                                                    <span id="comments-favorNum">${comment.favorNum}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>

                        </ul>
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>


</div>
</body>
</html>
