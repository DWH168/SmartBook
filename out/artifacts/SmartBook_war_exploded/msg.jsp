<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonParser" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="java.util.List" %>
<%@ page import="com.smart.book.pojo.Msg" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="java.util.Collections" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        .reply a{
            display: inline-block;
            float: right;
            margin-right: 0.5rem;
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
                <div class="hidden">${key.id}</div>
                <div>
                        ${key.msg}
                </div>
                <div>
                    <C:set scope="request" var="rey" value="${key.reply}" />
                        <%
                            String s= request.getAttribute("rey")+"";
                            List<Msg> msgs =new ArrayList<>();
                            if(!s.equals("null"))
                            {
                                JsonParser jsonParser = new JsonParser();
                                JsonArray jsonArray = jsonParser.parse(s).getAsJsonArray();
                                for (int i = 0; i < jsonArray.size(); i++) {
                                    Msg msg =new Msg();
                                    JsonObject jsonObject = jsonArray.get(i).getAsJsonObject();
                                    msg.setName(jsonObject.get("name").getAsString());
                                    msg.setTime(jsonObject.get("time").getAsString());
                                    msg.setMsg(jsonObject.get("msg").getAsString());
                                    msgs.add(msg);
                                }
                                Collections.reverse(msgs);
                                request.setAttribute("arr_reply",msgs);
                            }
                        %>
                    <C:if test="${!empty requestScope.arr_reply}" >
                        <C:forEach items="${requestScope.arr_reply}" var="k">
                            <div style="padding-left: 1rem;">
                                <hr/>
                                <div><strong>${k.name} </strong>(${k.time}) : ${k.msg}</div>
                            </div>
                        </C:forEach>
                    </C:if>

                </div>
                <div class="reply">
                    <a class="reply-but" href="javascript:;">回复</a>
                </div>
            </div>
        </div>
    </C:forEach>
</div>
<script type="text/javascript">
    //提交留言
    $(document).ready(function() {
        $("#add").on("click",
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
            $(".reply-but").on("click",
                function() {
                    let inp='<div class="reply-div" class="tab-pane active">\n' +
                        '        <div class="form-group">\n' +
                        '            <textarea class="form-control" rows="5" id="reply-content" placeholder="回复内容*"></textarea>\n' +
                        '        </div>\n' +
                        '        <div class="form-group">\n' +
                        '            <input type="text" id="reply-author" class="form-control" value="匿名" placeholder="昵称（选填）" maxlength="20" />\n' +
                        '        </div>\n' +
                        '        <div class="form-group"><button type="button" id="reply-tj"  class="btn btn-primary btn-block">提交留言</button></div>\n' +
                        '    </div>'

                    if($(this).html()=='回复')
                    {
                        $(".reply-div").remove();
                        $(".reply-but").text("回复");
                        // console.log("点击了回复");
                        let h=$(this).parent().parent();
                        $(this).text('取消');
                        $('#list').hide();
                        h.prepend(inp);
                        $(this).scrollIntoView(true);

                    }
                    else if($(this).html()=='取消')
                    {
                        console.log("点击了取消");
                        // let h=$(this).parent().parent().children(".reply-div").remove();
                        $(".reply-div").remove();
                        $(this).text('回复');
                        $('#list').show();
                    }
                });
            $(document).on("click","#reply-tj",function () {

                    let ID=$(this).parent().parent().next().html();
                    let name = $("#reply-author").val();
                    let msg = $("#reply-content").val();
                    console.log("点击了"+ID);
                    if(msg==''||name=='')
                    {
                        $.alert({
                            title: '提示',
                            content: '请填写完整',
                        });
                        return ;
                    }
                    $.ajax({
                        url:'./msg?action=addReply',
                        type:'post',
                        data:{
                            content:msg,
                            name:name,
                            id:ID
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