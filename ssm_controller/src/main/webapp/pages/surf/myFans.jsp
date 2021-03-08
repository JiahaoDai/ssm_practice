<%--
  Created by IntelliJ IDEA.
  User: Jiahao Dai
  Date: 2020/12/10
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>我的关注</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Tempusdominus Bbootstrap 4 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- JQVMap -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/jqvmap/jqvmap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminlte.min.css">
    <!-- overlayScrollbars -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/daterangepicker/daterangepicker.css">
    <!-- summernote -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/summernote/summernote-bs4.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

    <script src="../../js/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="../../css/userList.css">

    <script>
        $(function () {
            var uid = ${sessionScope.userInfo.id};
            $.ajax({
                url: "${pageContext.request.contextPath}/user/findByUid",
                contentType:"application/json;charset=utf-8",
                type:"get",
                data:{"uid":uid},
                dataType:"json",
                async: false,//ajax默认是异步的，如果里面还有一个ajax可能里面的还没有执行完，这个里面的操作也在执行
                success:function (userInfo) {
                    var fans = userInfo.fans;
                    var content = "";
                    for(var i = 0; i < fans.length; i++) {
                        content += '<li class="user-single">\n' +
                            '                                    <div class="user-url">\n' +
                            '                                        <a href="#">\n' +
                            '                                            <img  class="user-logo" src="../../img/user2-160x160.jpg" alt="">\n' +
                            '                                        </a>\n' +
                            '                                    </div>\n' +
                            '                                    <div class="user-info">\n' +
                            '                                        <div class="user-username">\n' +
                            '                                            ' + fans[i].username + '\n' +
                            '                                        </div>\n'

                        var fansId = fans[i].id;
                        $.ajax({
                            url: "${pageContext.request.contextPath}/user/findByUid",
                            contentType:"application/json;charset=utf-8",
                            type:"get",
                            data:{"uid":fansId},
                            dataType:"json",
                            async: false,
                            success:function (fansSecond) {//这个查询出来的是我关注的人,因为无法使用递归，或者是我不会这个递归
                                content += '<div class="user-status">\n' +
                                    '                                            <div class="user-fansNum">\n' +
                                    '                                                粉丝数:'+fansSecond.fans.length+'\n' +
                                    '                                            </div>\n' +
                                    '                                            <div class="user-starsNum">\n' +
                                    '                                                关注的人:'+fansSecond.stars.length+'\n' +
                                    '                                            </div>\n' +
                                    '                                        </div>\n' +
                                    '                                    </div>\n' +
                                    '\n' +
                                    '                                </li>'

                            }
                        })
                    }

                    $("#userList").html(content);
                }
            })
        })
    </script>

</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <!-- Navbar -->
    <jsp:include page="userheader.jsp"/>
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <jsp:include page="userSidebar.jsp"/>
    <!-- Content Wrapper. Contains page content -->
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">我的粉丝</h1>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content-header -->

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="userBox">
                            <ul class="userList" id="userList">
                                <li class="user-single">
                                    <div class="user-url">
                                        <a href="#">
                                            <img  class="user-logo" src="../../img/user2-160x160.jpg" alt="">
                                        </a>
                                    </div>
                                    <div class="user-info">
                                        <div class="user-username">
                                            戴家豪
                                        </div>
                                        <div class="user-status">
                                            <div class="user-fansNum">
                                                粉丝数:100
                                            </div>
                                            <div class="user-starsNum">
                                                关注的人:2
                                            </div>
                                        </div>
                                    </div>

                                </li>

                            </ul>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div>
        </section>
        <!-- /.content -->
    </div>

</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="${pageContext.request.contextPath}/plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
    $.widget.bridge('uibutton', $.ui.button)
</script>
<!-- Bootstrap 4 -->
<script src="${pageContext.request.contextPath}/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="${pageContext.request.contextPath}/plugins/chart.js/Chart.min.js"></script>
<!-- Sparkline -->
<script src="${pageContext.request.contextPath}/plugins/sparklines/sparkline.js"></script>
<!-- JQVMap -->
<script src="${pageContext.request.contextPath}/plugins/jqvmap/jquery.vmap.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
<!-- jQuery Knob Chart -->
<script src="${pageContext.request.contextPath}/plugins/jquery-knob/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script src="${pageContext.request.contextPath}/plugins/moment/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="${pageContext.request.contextPath}/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="${pageContext.request.contextPath}/plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="${pageContext.request.contextPath}/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/js/adminlte.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="${pageContext.request.contextPath}/js/pages/dashboard.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${pageContext.request.contextPath}/js/demo.js"></script>
</body>
</html>

