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
    <link rel="stylesheet" href="../../css/userMsg.css">
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

        funMsg = function(me){
            var loginId = ${sessionScope.userInfo.id}
            var fromId = $(me).attr("fromId");
            $(me).siblings().removeClass("msg-active");
            $(me).addClass("msg-active");
            $.ajax({
                url:"${pageContext.request.contextPath}/privateMsg/findAllRelateMsg",
                contentType:"application/json;charset=utf-8",
                data:'{"uid":'+fromId+',"masterpieceUid":'+loginId+'}',
                type:"post",
                dataType:"json",
                success:function (privateMsgs) {
                    var content = "";
                    for(var i = 0; i < privateMsgs.length; i++){
                        if(privateMsgs[i].uid === parseInt(fromId)){

                            content += '<li class="msg-li" style="border: 1px solid green; color: black">\n' +
                                '                                '+privateMsgs[i].content+'\n' +
                                '                            </li>'
                        }else{
                            content += '<li class="msg-li" style="border: 1px solid red; color: red">\n' +
                                '                                '+privateMsgs[i].content+'\n' +
                                '                            </li>'
                        }

                    }

                    $("#msg-list").html(content);
                }

            })
        }



        $(function () {
            var uid = ${sessionScope.userInfo.id};
            $.ajax({
                url:"${pageContext.request.contextPath}/privateMsg/findRelateUser",
                contentType:"application/json;charset=utf-8",
                data:{"uid":uid},
                type:"get",
                async:"false",
                dataType:"json",
                success:function (userInfos) {
                    console.log(userInfos);
                    var content = "";
                    for(var i = 0; i < userInfos.length; i++){
                        if(i === 0){
                            content += '<li class="msg-from-list-li  msg-active" fromId = "'+userInfos[i].id+'" onclick="funMsg(this)">\n' +
                                '                            <div class="msg-send-url">\n' +
                                '                                <img class="msg-url" src="../../img/user2-160x160.jpg" alt="">\n' +
                                '                            </div>\n' +
                                '                            <div class="msg-sender">'+userInfos[i].username+'</div>\n' +
                                '\n' +
                                '                        </li>'
                        }else {
                            content += '<li class="msg-from-list-li" fromId = "'+userInfos[i].id+'" onclick="funMsg(this)">\n' +
                                '                            <div class="msg-send-url">\n' +
                                '                                <img class="msg-url" src="../../img/user2-160x160.jpg" alt="">\n' +
                                '                            </div>\n' +
                                '                            <div class="msg-sender">'+userInfos[i].username+'</div>\n' +
                                '\n' +
                                '                        </li>'
                        }

                    }
                    $("#msg-from-list").html(content)
                }
            })

        })


        funcSendMsg = function () {
            //获取收取人的uid
            var masterpieceUid = $(".msg-from-list-li.msg-active").attr("fromId");
            //自己的uid
            var loginId = ${sessionScope.userInfo.id};
            //发送的内容
            var content = $("#msg").val();
            $.ajax({
                url:"${pageContext.request.contextPath}/privateMsg/sendMsg",
                contentType:"application/json;charset=utf-8",
                data:'{"uid":'+loginId+',"masterpieceUid":'+masterpieceUid+',"content":"'+content+'","sendTime":"'+dateToString()+'"}',
                type:"post",
                success:function () {
                    // location.href = "${pageContext.request.contextPath}/pages/surf/myMsg.jsp"
                    var newMsg = '<li class="msg-li" style="border: 1px solid red; color: red">\n' +
                        '                                '+content+'\n' +
                        '                            </li>'
                    $("#msg-list").append(newMsg)
                    $("#msg").val("");
                }
            })
        }






        
        
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
                        <h1 class="m-0 text-dark">我的私信</h1>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content-header -->


        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="msg-from-who">
                    <ul class="msg-from-list" id="msg-from-list">
                        <li class="msg-from-list-li  msg-active">
                            <div class="msg-send-url">
                                <img class="msg-url" src="../../img/user2-160x160.jpg" alt="">
                            </div>
                            <div class="msg-sender">戴家豪</div>
                        </li>
                        <li class="msg-from-list-li  msg-active">
                            <div class="msg-send-url">
                                <img class="msg-url" src="../../img/user2-160x160.jpg" alt="">
                            </div>
                            <div class="msg-sender">hello</div>
                        </li>
                    </ul>
                </div>

                <div class="msg-box">
                    <div class="msg-info">
                        <ul class="msg-list" id="msg-list">

                        </ul>
                    </div>
                    <div class="msg-you-send">
                        <textarea name="" id="msg"></textarea>
                    </div>
                    <div class="send-btn">
                        <button class="btn btn-sm btn-primary" onclick="funcSendMsg()">发送</button>
                    </div>
                </div>
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

