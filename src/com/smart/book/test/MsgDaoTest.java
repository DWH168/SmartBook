package com.smart.book.test;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.smart.book.dao.MsgDao;
import com.smart.book.dao.impl.BaseDao;
import com.smart.book.dao.impl.MsgDaoImpl;
import com.smart.book.pojo.Msg;
import com.smart.book.utils.JdbcUtils;
import org.junit.Test;

import java.util.List;

public class MsgDaoTest extends BaseDao {

    @Test
    public void Test()
    {

        Msg msg1= new Msg();
        msg1.setName("45566");
        msg1.setMsg("3345");
        msg1.setId(25);
        msg1.setTime("2020-01-01");
        System.out.println(updateReply(msg1));
    }

    private String updateReply(Msg msg)
    {
        MsgDao msgDao = new MsgDaoImpl();
        Integer id=msg.getId();

        Msg newmsg=msgDao.queryMsgById(id);

        System.out.println(newmsg.toString());
        JsonParser jsonParser = new JsonParser();
        JsonArray jsonElements;
        if("null".equals(newmsg.getReply()))
        {
            jsonElements = jsonParser.parse(newmsg.getReply()).getAsJsonArray();
        }
        else {
            jsonElements = new JsonArray();
        }
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("name",msg.getName());
        jsonObject.addProperty("time",msg.getTime());
        jsonObject.addProperty("msg",msg.getMsg());

        jsonElements.add(jsonObject);
        return jsonElements.toString();
    }
//    public void TestMsg()
//    {
//
//
//        JsonArray jsonArray = new JsonArray();
//        for (int i = 0; i < 10; i++) {
//            JsonObject jsonObject = new JsonObject();
//            jsonObject.addProperty("name","666");
//            jsonObject.addProperty("time","666");
//            jsonObject.addProperty("msg","666");
////            System.out.println(jsonObject.toString());
//            jsonArray.add(jsonObject);
//        }
//
//
//        JsonParser jsonParser = new JsonParser();
//        JsonArray jsonElements = jsonParser.parse(jsonArray.toString()).getAsJsonArray();
//
//
//        JsonObject jsonObject = new JsonObject();
//        jsonObject.addProperty("name","666");
//        jsonObject.addProperty("time","666");
//        jsonObject.addProperty("msg","99");
//
//        jsonElements.add(jsonObject);
//
//        System.out.println(jsonElements.toString());
//
//    }
}
