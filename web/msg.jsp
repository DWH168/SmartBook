<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
    关注公众号：智慧小巷
    获取更多资料源码！
--%>
<html>
<head>
    <meta charset="UTF-8">
    <title>留言板-智慧小巷</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="./static/css/bootstrap.min.css" />
    <link rel="stylesheet" href="./static/css/jquery-confirm.css">
    <script src="./static/js/jquery.min.js" type="text/javascript"></script>
    <script src="./static/js/jquery-confirm.js" type="text/javascript"></script>
    <script src="./static/js/bootstrap.min.js" type="text/javascript"></script>
    <style>.w1000{
        max-width:1000px;
        width: 100%;
        margin: 0 auto;
        padding-left: 10px;
        padding-right: 10px;
    }
    </style>
</head>
<body>
<div class="w1000">
    <h3>留言板-智慧小巷</h3>
    <div id="list" class="tab-pane active">
        <div class="form-group">
            <textarea class="form-control" rows="5" id="content" placeholder="留言内容*"></textarea>
        </div>
        <div class="form-group">
            <input type="text" id="author" class="form-control" value="匿名" placeholder="昵称（选填）" maxlength="20" />
        </div>
        <div class="form-group"><button type="button" id="add" class="btn btn-primary btn-block">提交留言</button></div>
    </div>
</div>
<div class="w1000" >
    <C:forEach items="${msg}" var="key">
        <div class="panel panel-default">
            <div class="panel-heading">${key.name}<small style="margin-left: 20px;" >${key.time}</small></div>
            <div class="panel-body">
                ${key.msg}
            </div>
        </div>
    </C:forEach>
</div>
<script type="text/javascript">
    //提交留言
    $(document).ready(function() {
        $("button").on("click",
            function() {
                let name = $("#author").val();
                let msg = $("#content").val();
                console.log(name+"23456");
                if(msg==''||name=='')
                {
                    $.alert({
                        title: '提示',
                        content: '请填写完整',
                    });
                    return ;
                }
                $.ajax({
                    url:'./msg?action=addMsg',
                    type:'post',
                    data:{
                        content:msg,
                        name:name,
                    },
                    dataType:'json',
                    success:function (data) {
                        if(data.state=="success"){

                            $.confirm({
                                title: '提示',
                                content: '提交成功',
                                buttons: {
                                    somethingElse: {
                                        text: '确定',
                                        btnClass: 'btn-blue',
                                        keys: ['enter', 'shift'],
                                        action: function(){
                                            window.location.reload();
                                        }
                                    }
                                }
                            });
                        }else if(data.state=="error"){
                            alert("失败");
                        }else{
                            alert("未知错误")
                        }
                    },error:function(){
                        alert("error");
                    }
                });
            });
    });
</script>
</body>
</html>