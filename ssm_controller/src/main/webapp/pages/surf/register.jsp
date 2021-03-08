<%--
  Created by IntelliJ IDEA.
  User: Jiahao Dai
  Date: 2020/11/30
  Time: 18:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" isErrorPage="false" %>
<html>
<head>
    <title>注册页面</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
    <script src="../../js/jquery-3.3.1.min.js"></script>
    <style type="text/css">

        .container{
            margin-top: 100px;
            margin-left: 425px;
        }
        .text{
            /*margin: 0 auto;*/
            width: 400px;
            margin-left: 70px;
            font-size: 30px;
            color: white;
            background-color: black;
            text-align: center;
            margin-bottom: 20px;
        }
    </style>

    <script>
        function isDumplicate() {
            var password = $("#password").val();
            var password2 = $("#password2").val();
            var psdMsg = $("#psdMsg");//两次密码输入不正确的时候的信息标签
            if(password === password2){
                psdMsg.html("两次密码输入相同");
                psdMsg.css("color","green");
                $("#btn").attr("disabled", false);
            }else {
                //两次密码对比不成功
                psdMsg.html("两次密码输入不同");
                psdMsg.css("color","red");
                $("#btn").attr("disabled", true);
            }
        }
    </script>
</head>
<body>
<div class="container">
    <div class="register">
        <div class="text">
            注册用户
        </div>
        <form class="form-horizontal" method="post" action="${pageContext.request.contextPath}/user/register">
            <div class="form-group">
                <label class="col-sm-2 control-label">用户名</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" name="username" placeholder="请输入用户名">
                </div>
                <span style="color: red">${resultInfo.msg}</span>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">密码</label>
                <div class="col-sm-3">
                    <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码">
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">重复密码</label>
                <div class="col-sm-3">
                    <input type="password" class="form-control" id="password2" name="password2" placeholder="请再次输入密码" onmouseleave="isDumplicate()">
                </div>
                <span id="psdMsg"></span>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">邮箱</label>
                <div class="col-sm-3">
                    <input type="email" class="form-control" name="email" placeholder="请输入您的邮箱">
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">手机号</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" name="phoneNum" maxlength="11" placeholder="请输入您的手机号">
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-primary" id="btn">注册</button>
                </div>
            </div>
        </form>
    </div>
</div>

</body>
</html>
