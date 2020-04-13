package com.smart.book.web;

import com.smart.book.dao.MsgDao;
import com.smart.book.dao.impl.MsgDaoImpl;
import com.smart.book.pojo.Msg;
import com.smart.book.service.MsgService;
import com.smart.book.service.impl.MsgServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MsgServlet extends BaseServlet {

    MsgService msgService=new MsgServiceImpl();
    protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        req.setAttribute("msg", msgService.queryMsgs());
        req.getRequestDispatcher("/msg.jsp").forward(req,resp);
    }
    protected void addMsg(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Msg msg = new Msg();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        msg.getName();
        String gmsg = req.getParameter("content");
        String name= req.getParameter("name");
        String time=df.format(new Date());
        msg.setMsg(gmsg);
        msg.setName(name);
        msg.setTime(time);
        msgService.addMsg(msg);

        resp.setContentType("charset=utf-8");
        String result = "{\"state\":\"success\"}";
        resp.getWriter().print(result);
    }
    protected void addReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Msg msg = new Msg();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        msg.getName();
        String gmsg = req.getParameter("content");
        String name= req.getParameter("name");
        String time=df.format(new Date());
        msg.setMsg(gmsg);
        msg.setName(name);
        msg.setTime(time);
        msg.setId(Integer.valueOf(req.getParameter("id")));
//        msg.setId(29);
        MsgDaoImpl msgDao =new MsgDaoImpl();
        System.out.println(msg.toString());
        msgDao.replay(msg);
        resp.setContentType("charset=utf-8");
        String result = "{\"state\":\"success\"}";
        resp.getWriter().print(result);
    }
}


