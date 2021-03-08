<%--
  Created by IntelliJ IDEA.
  User: Jiahao Dai
  Date: 2020/12/10
  Time: 17:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
    <script src="../../js/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
            var uid = ${sessionScope.userInfo.id};
            $.ajax({
                url: "${pageContext.request.contextPath}/user/findByUid",
                contentType:"application/json;charset=utf-8",
                type:"get",
                data:{"uid":uid},
                dateType:"json",
                success:function(userInfo){
                    var total_view_num = 0
                    var total_favor_num = 0
                    for(var i = 0; i < userInfo.masterPieces.length; i++){
                        total_view_num += userInfo.masterPieces[i].viewNum;
                        total_favor_num += userInfo.masterPieces[i].favorNum;
                    }
                    var content = '<li class="nav-item dropdown">\n' +
                        '            <a href="#">\n' +
                        '                <span class="badge">关注的人:'+userInfo.stars.length+'</span>\n' +
                        '            </a>\n' +
                        '        </li>\n' +
                        '        <!-- Notifications Dropdown Menu -->\n' +
                        '        <li class="nav-item">\n' +
                        '            <a href="#">\n' +
                        '                <span class="badge">粉丝数:'+userInfo.fans.length+'</span>\n' +
                        '            </a>\n' +
                        '        </li>\n' +
                        '        <li class="nav-item">\n' +
                        '            <span class="badge">观看:'+total_view_num+'</span>\n' +
                        '        </li>\n' +
                        '        <li class="nav-item">\n' +
                        '            <span class="badge">点赞数:'+total_favor_num+'</span>\n' +
                        '        </li>';

                    $("#item-list").html(content);
                },
                error:function () {
                    alert("错误")
                }
            })
        })
    </script>
</head>
<body>
<!-- Navbar -->
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
        </li>

    </ul>

    <!-- SEARCH FORM -->
    <form class="form-inline ml-3">
        <div class="input-group input-group-sm">
            <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
            <div class="input-group-append">
                <button class="btn btn-navbar" type="submit">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </form>

    <ul class="navbar-nav ml-auto">
        <li>
            <a href="${pageContext.request.contextPath}/user/logout?fromwhere=${pageContext.request.requestURL}?${pageContext.request.queryString}">退出登录</a>
        </li>
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto" id="item-list">
        <!-- Messages Dropdown Menu -->
        <li class="nav-item dropdown">
            <a href="#">
                <span class="badge">关注的人:100</span>
            </a>
        </li>
        <!-- Notifications Dropdown Menu -->
        <li class="nav-item">
            <a href="#">
                <span class="badge">粉丝数:200</span>
            </a>
        </li>
        <li class="nav-item">
            <span class="badge">观看:100</span>
        </li>
        <li class="nav-item">
            <span class="badge">点赞:100</span>
        </li>
    </ul>
</nav>
<!-- /.navbar -->
</body>
</html>
