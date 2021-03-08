<%--
  Created by IntelliJ IDEA.
  User: Jiahao Dai
  Date: 2020/11/30
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>登录页面</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>

    <script src="../../js/jquery-3.3.1.min.js"></script>
    <script>
        $(function (){
            var url = "${pageContext.request.queryString}";
            console.log(url);

            $("#fromwhere").val(url);
        })
    </script>

</head>
<body>
    <div class="login">
        <h1 style="color: red">${resultInfo.msg}</h1>
        <form class="form-horizontal" method="post" action="${pageContext.request.contextPath}/user/login">
            <div class="form-group">
                <label class="col-sm-2 control-label"></label>
                <div class="col-sm-3">
                    <input type="hidden" name="fromwhere" id="fromwhere">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">用户名</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" name="username" placeholder="请输入用户名">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">密码</label>
                <div class="col-sm-3">
                    <input type="password" class="form-control" name="password" placeholder="请输入密码">
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-primary">登录</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
