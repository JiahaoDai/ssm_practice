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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/masterpiece.css">

    <script>
        var parameter = window.location.search;//window.location.href获取网页url , window.location.search获取的是??参数=1&参数=2
        var para = parameter.split("?")[1].split("&");//id=5&viewNum=88 or id=5
        var id = para[0].split("=")[1];// 作品的id
        var viewNum = 0;
        if(para.length > 1){
            viewNum = para[1].split("=")[1];
        }

        // 私信弹框
        function funcMsg(){
            $("#hidden-content").css("opacity","60")
            $("#hidden-content").css("display","block")
            // 获取私信框中的内容
            // 首先要得到作者的id以及 登录的人的id
        }

        // 发送私信
        function funcSendMsg(){
            $.ajax({
                url:"${pageContext.request.contextPath}/masterPiece/findById",
                contentType:"application/json;charset=utf-8",
                data:'{"id":'+id+', "viewNum":'+viewNum+'}',
                type:"post",
                async: false,
                dataType:"json",
                success:function (masterpiece) {
                    alert(masterpiece.userLogin);
                    var uid = "";
                    var masterpieceUid = masterpiece.userInfo.id;
                    var sendTime = dateToString();//注意这个时间需要在domain里面设置
                    var msg = $("#private-msg").val();
                    if(masterpiece.userLogin != null){
                        uid = masterpiece.userLogin.id;

                        $.ajax({
                            url:"${pageContext.request.contextPath}/privateMsg/sendMsg",
                            contentType:"application/json;charset=utf-8",
                            data:'{"uid":'+uid+', "masterpieceUid":'+masterpieceUid+', "sendTime":"'+sendTime+'", "content":"'+msg+'"}',
                            type:"post",
                            async: false,
                            success:function () {
                                $("#hidden-content").css("display","none")
                                alert("发送成功")
                            }
                        })
                    }else {
                        $("#hidden-content").css("display","none");
                        alert("您尚未登录，请先登录");
                    }
                }
            })
        }

        function exitBtn(){
            $("#hidden-content").css("display","none")
        }


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

        // 添加关注js
        function folkStars(uid, authord_id){
            if(uid === undefined){
                alert("请先登录");
                return true;
            }else {
                // 发送ajax
                $.ajax({
                    url:"${pageContext.request.contextPath}/user/addFans",
                    contentType:"text/html;charset=utf-8",
                    data:{"id":authord_id, "uid":uid},
                    type:"get",
                    success:function () {
                        location.href='${pageContext.request.contextPath}/pages/surf/masterpiece2.jsp?id='+id+'&viewNum='+viewNum;
                    }
                })
            }

        }

        //加载页面
        $(function () {

            $.ajax({
                url: "${pageContext.request.contextPath}/masterPiece/findById",
                contentType:"application/json;charset=utf-8",
                type:"post",
                data:'{"id":'+id+', "viewNum":'+viewNum+'}',
                dataType:"json",
                success:function (masterPiece) {
                    console.log(masterPiece);
                    $("#title-desc").html(masterPiece.masterpieceDesc);
                    $("#pubTime").html(masterPiece.pubTimeStr);
                    $("#head-index").html(masterPiece.category.categoryDesc);
                    $("#right-head").html(
                        '<span>观看:'+masterPiece.viewNum+'</span>\n' +
                        '                            <span>|</span>\n' +
                        '                            <span>评论:'+masterPiece.comments.length+'</span>\n' +
                        '                            <span>|</span>\n' +
                        '                            <span>点赞:'+masterPiece.favorNum+'</span>'
                    );
                    // 作者头像url

                    // 作者名
                    $("#author-name").html(masterPiece.userInfo.username)

                    //作品内容描述
                    $("#work-content-inner").html(
                        "<p>\n" +
                        "                    "+masterPiece.masterpieceContent+"\n" +
                        "                </p>"
                    );
                    // 轮播图
                    var content = "";
                    for(var i = 0; i < masterPiece.pictures.length; i++){
                        if( i === 0 ){
                            content += '<div class="item active">\n' +
                                '                                <img class="banner-img"\n' +
                                '                                     src="${pageContext.request.contextPath}/'+masterPiece.coverUrl+'"\n' +
                                '                                     alt="...">\n' +
                                '                            </div>\n' +
                                '                            <div class="item">\n' +
                                '                                <img class="banner-img"\n' +
                                '                                     src="${pageContext.request.contextPath}/'+masterPiece.pictures[i].url+'"\n' +
                                '                                     alt="...">\n' +
                                '                            </div>'
                        }else {
                            content += '<div class="item">\n' +
                                '                                <img class="banner-img"\n' +
                                '                                     src="${pageContext.request.contextPath}/'+masterPiece.pictures[i].url+'"\n' +
                                '                                     alt="...">\n' +
                                '                            </div>'
                        }
                    }
                    $("#carousel-inner").html(content);

                    //点赞数量
                    $("#masterfavorNum").html(masterPiece.favorNum);

                    //评论部分
                    $("#comment-title").html(
                        '全部评论: '+masterPiece.comments.length
                    );

                    var li_content = "";
                    for(var i = 0; i < masterPiece.comments.length; i++){
                        li_content += '<li class="comment-list">\n' +
                            '                                <div class="comment-content">\n' +
                            '                                    <div class="comment-user">\n' +
                            '                                        <a href="#">\n' +
                            '                                            <img class="user-img"\n' +
                            '                                                 src="https://img.zcool.cn/community/0113dc5f0d691aa801206621f7e6d0.jpg@80w_80h_1c_1e_1o_100sh.jpg"\n' +
                            '                                                 alt="">\n' +
                            '                                        </a>\n' +
                            '                                    </div>\n' +
                            '\n' +
                            '                                    <div class="comment-info">\n' +
                            '                                        <div class="comment-user-name">\n' +
                            '                                                '+masterPiece.comments[i].userInfo.username+'\n' +
                            '                                        </div>\n' +
                            '                                        <div class="comment-content-words">\n' +
                            '                                                '+masterPiece.comments[i].content+'\n' +
                            '                                        </div>\n' +
                            '                                        <div class="comment-bottom">\n' +
                            '                                            <span class="comment-pubTime">'+masterPiece.comments[i].pubTimeStr+'</span>\n' +
                            '                                            <div class="comment-favor">\n' +
                            '                                                <img class="favor-img" src="${pageContext.request.contextPath}/img/favor.png" alt="">\n' +
                            '                                                <span id="comments-favorNum">'+masterPiece.comments[i].favorNum+'</span>\n' +
                            '                                            </div>\n' +
                            '                                        </div>\n' +
                            '                                    </div>\n' +
                            '                                </div>\n' +
                            '                            </li>'
                    }
                    $("#comment-list-ul").html(li_content);

                    // 对于关注的按钮进行js
                    // 如果已经关注，那么就显示已关注；如果没有关注就显示关注
                    var btn_content = "";
                    var fans_list = masterPiece.userInfo.fans;
                    var uid = "";
                    if(masterPiece.userLogin){
                        // 表示用户已经登录
                        uid = masterPiece.userLogin.id;
                        for(var j = 0; j < fans_list.length; j++){
                            var fansId = fans_list[j].id;//粉丝的id
                            if(fansId === uid || uid === masterPiece.userInfo.id){
                                btn_content = '<button class="btn btn-sm btn-default btn-1" disabled>已关注</button>\n' +
                                    '                            <button class="btn btn-sm btn-primary btn-2" onclick="funcMsg()">私信</button>'
                                console.log("已关注")
                                break;
                            }else{
                                btn_content = '<button class="btn btn-sm btn-default btn-1" onclick="folkStars('+uid+','+masterPiece.userInfo.id+')">关注</button>\n' +
                                    '                            <button class="btn btn-sm btn-primary btn-2" onclick="funcMsg()">私信</button>'
                            }
                        }
                    }else{
                        btn_content = '<button class="btn btn-sm btn-default btn-1" onclick="folkStars()">关注</button>\n' +
                            '                            <button class="btn btn-sm btn-primary btn-2" onclick="funcMsg()">私信</button>'
                    }

                    $("#btn-area").html(btn_content);
                }
            })
        })

        // 点赞和评论js
        $(function () {

            $("#comment-btn-div").click(function () {
                var content = $("#input-text").val();

                // uid = ${sessionScope.userInfo.id};//这个在没有登录的情况下是错误的，所以可以使得点赞也点不了，但是登录之后就可以了
                // ${sessionScope.userInfo.id}在没登录的情况下什么都没有

                var mid = id;
                $.ajax({
                    url:"${pageContext.request.contextPath}/masterPiece/saveComments",
                    contentType:"application/json;charset=utf-8",
                    data:'{"pubTime":"'+dateToString()+'","favorNum":0,"content":"'+content+'", "mid":'+mid+'}',
                    type:"post",
                    success:function (){
                        location.href="${pageContext.request.contextPath}/pages/surf/masterpiece2.jsp?id="+mid+"&viewNum="+viewNum;
                    }
                })
            })


            $("#favor-box").click(function () {
                var favorNum = $("#masterfavorNum").html();
                $.ajax({
                    url:"${pageContext.request.contextPath}/masterPiece/updateFavorNum",
                    contentType:"application/json;charset=utf-8",
                    data:'{"favorNum":'+favorNum+', "id":'+id+'}',// 发送请求成功了，但是它这个就是会标红 但是不会错
                    type:"post",
                    // dataType:"json",
                    success: function (flag) {
                        if(flag){
                            favorNum++;
                            $("#masterfavorNum").html(favorNum)
                        }else {
                            // 说明没有登录，最好能够提示请先登录
                            alert("您尚未登录，请先登录")
                        }

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
                    <div class="title-desc" id="title-desc">作品描述</div>
                    <p class="pubTime" id="pubTime">
                        发布时间
                    </p>
                    <div class="work-head">
                        <div class="left-head">
                            <span class="head-index" id="head-index">分类</span>
                        </div>
                        <div class="right-head" id="right-head">

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
                        <p class="author-name" id="author-name">作者名</p>
                        <div class="btn-area" id="btn-area">
                            <button class="btn btn-sm btn-default btn-1" onclick="folkStars(${sessionScope.userInfo.id})">关注</button>
                            <button class="btn btn-sm btn-primary btn-2" onclick="funcMsg()">私信</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="work-content">
            <div class="work-content-inner" id="work-content-inner">
                <p>
                    作品内容描述
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
                        <div class="carousel-inner" role="listbox" id="carousel-inner">

                            <div class="item active">
                                <img class="banner-img"
                                     src="#"
                                     alt="...">
                            </div>
                            <div class="item">
                                <img class="banner-img"
                                     src="#"
                                     alt="...">
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

        <!--        点赞的图标-->
        <div class="work-favor">
            <div class="work-favor-inner">
                <div class="favor-box" id="favor-box">
                    <div>
                        <img src="${pageContext.request.contextPath}/img/favor.png" alt="">
                    </div>
                    <i class="incon" id="masterfavorNum">100</i>
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
                            <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/pages/surf/login.jsp?fromwhere=${pageContext.request.requestURL}?${pageContext.request.queryString}'">登录</button>
                        </div>
                    </div>
                </c:if>


                <div class="detail-all-comment">
                    <div class="comment-title" id="comment-title">全部评论  100</div>
                    <div class="comment-list-div">
                        <ul class="comment-list-ul" id="comment-list-ul">
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
                                                评论用户名
                                        </div>
                                        <div class="comment-content-words">
                                                评论内容
                                        </div>
                                        <div class="comment-bottom">
                                            <span class="comment-pubTime">评论时间</span>
                                            <div class="comment-favor">
                                                <img class="favor-img" src="${pageContext.request.contextPath}/img/favor.png" alt="">
                                                <span id="comments-favorNum">100</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>

                        </ul>
                    </div>
                </div>
            </div>
        </div>


        <div class="hidden-content" id="hidden-content">
            <div class="input-content">
                <textarea name="private-msg" id="private-msg"></textarea>
                <button class="btn btn-primary" id="sub-btn" onclick="funcSendMsg()">发送</button>
                <button class="btn btn-danger" onclick="exitBtn()">退出</button>
            </div>

        </div>

    </div>

</div>


</div>
</body>
</html>
