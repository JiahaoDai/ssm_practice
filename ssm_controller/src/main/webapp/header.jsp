<%--
  Created by IntelliJ IDEA.
  User: Jiahao Dai
  Date: 2020/12/1
  Time: 10:31
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>头部</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
            $.ajax({
                url: "${pageContext.request.contextPath}/category/findAll",
                contentType: "application/json;charset=utf-8",
                // data:'{"name":"djh", "age":18}',
                type: "post",
                dataType: "json",
                success: function (categories) {
                    console.log(categories);
                    var categoryUl = $("#category");
                    var content = "";
                    for (var i = 1; i <= categories.length; i++) {
                        if (i % 3 === 0) {

                            content += '<li role="separator" class="divider"></li>';
                            content += '<li><a href="#">' + categories[i - 1].categoryDesc + '</a></li>';
                        } else {
                            content += '<li><a href="#">' + categories[i - 1].categoryDesc + '</a></li>';
                        }
                    }
                    console.log(content)
                    categoryUl.html(content)
                }
            })

        })

        // 分类下拉
        function dropdownOpen(){
            var dropdown = $("#dropdown");
            var className = dropdown.attr("class");

            dropdown.addClass("open")
            $(".dropdown-toggle").prop('aria-expanded',"true")
        }

    </script>
</head>
<body>
<nav class="navbar navbar-default navbar-inverse">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#" style="color:red">
                <!--                        <img src="" alt="logo">-->
                logo
            </a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">首页 <span class="sr-only">(current)</span></a></li>
                <li class="dropdown" id="dropdown" onclick="dropdownOpen()">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                       aria-expanded="false">分类 <span class="caret"></span></a>
                    <ul class="dropdown-menu" id="category">
                        <li>Nihao</li>
                    </ul>
                </li>
            </ul>
            <form class="navbar-form navbar-left">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="请输入搜索的内容">
                </div>
                <button type="submit" class="btn btn-default">提交</button>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <c:if test="${(sessionScope.userInfo != null) and (sessionScope.isEmp)}">
                    <li><a href="javascript:void(0)">${sessionScope.userInfo.username}</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/logout?fromwhere=${pageContext.request.requestURL}?${pageContext.request.queryString}">退出登录</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/surf/userCenter.jsp">个人中心</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/cms/home.jsp">后台管理系统</a></li>
                </c:if>
                <c:if test="${(sessionScope.userInfo != null) and (!sessionScope.isEmp)}">
                    <li><a href="javascript:void(0)">${sessionScope.userInfo.username}</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/logout?fromwhere=${pageContext.request.requestURL}?${pageContext.request.queryString}">退出登录</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/surf/userCenter.jsp">个人中心</a></li>
                </c:if>
                <c:if test="${sessionScope.userInfo == null}">
                    <li><a href="${pageContext.request.contextPath}/pages/surf/login.jsp?fromwhere=${pageContext.request.requestURL}?${pageContext.request.queryString}" id="login-btn">登录</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/surf/register.jsp">注册</a></li>
                </c:if>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
</body>
</html>
