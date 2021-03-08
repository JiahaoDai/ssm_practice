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
    <title>个人中心</title>
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
    <link rel="stylesheet" href="../../css/userCenterMasterpieceManage.css">
    <script>
        var uid = ${sessionScope.userInfo.id};
        $.ajax({
            url: "${pageContext.request.contextPath}/masterPiece/findByUid",
            contentType:"application/json;charset=utf-8",
            type:"get",
            data:{"uid":uid},
            dataType:"json",
            success:function (masterPieces) {
                var content = "";
                for(var i = 0; i < masterPieces.length; i++){
                    content += '<li class="card-info">\n' +
                        '\n' +
                        '                                    <div class="card-url">\n' +
                        '                                        <a href="${pageContext.request.contextPath}/pages/surf/masterpiece2.jsp?id='+masterPieces[i].id+'&viewNum='+masterPieces[i].viewNum+'">\n' +
                        '                                            <img class="card-img-url" src="${pageContext.request.contextPath}/'+masterPieces[i].coverUrl+'" alt="">\n' +
                        '                                        </a>\n' +
                        '                                    </div>\n' +
                        '                                    <div class="card-content">\n' +
                        '                                        <div class="card-desc">'+masterPieces[i].masterpieceDesc+'</div>\n' +
                        '\n' +
                        '                                        <div class="card-item-info">\n' +
                        '                                            <div class="card-pubTime">'+masterPieces[i].pubTimeStr+'</div>\n' +
                        '                                            <div class="card-category">'+masterPieces[i].category.categoryDesc+'</div>\n' +
                        '                                        </div>\n' +
                        '\n' +
                        '                                        <div class="card-item">\n' +
                        '                                            <div class="card-favor">点赞数:'+masterPieces[i].favorNum+'</div>\n' +
                        '                                            <div class="card-view">观看数:'+masterPieces[i].viewNum+'</div>\n' +
                        '                                            <div class="card-comment">评论数:'+masterPieces[i].comments.length+'</div>\n' +
                        '                                        </div>\n' +
                        '\n' +
                        '                                    </div>\n' +
                        '\n' +
                        '                                    <div class="card-btn">\n' +
                        '                                        <button class="btn btn-sm btn-danger delete-btn">删除</button>\n' +
                        '                                    </div>\n' +
                        '                                        <input type="hidden" value="'+masterPieces[i].id+'" name="mid"+i>\n' +
                        '                                </li>'
                }
                $("#card-list").html(content);
            }
        })



        $(function () {
            $(".delete-btn").click(function () {
                var mid = $(this).parent().siblings("input[name='mid']").val();
                alert(mid)
                // 发送ajax删除掉作品，以及相关的评论以及图片
                $.ajax({
                    url: "${pageContext.request.contextPath}/masterPiece/deleteById",
                    contentType:"text/html;charset=utf-8",
                    type:"get",
                    data:{"mid":mid},
                    dateType:"text",
                    success:function(){
                        location.href = "${pageContext.request.contextPath}/pages/surf/userCenterMasterpieceManage.jsp"
                    },
                    error:function () {
                        alert("错误")
                    }
                })
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
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark">作品管理</h1>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content-header -->

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <!-- left column -->
                    <div class="col-md-12">
                        <div class="card-body">
                            <ul class="card-list" id="card-list">

                            </ul>
                        </div>

                    </div>
                    <!--/.col (left) -->
                    <!-- right column -->
                    <div class="col-md-6">

                    </div>
                    <!--/.col (right) -->
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

