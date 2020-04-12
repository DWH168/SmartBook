package com.smart.book.test;

import com.smart.book.dao.MsgDao;
import com.smart.book.dao.impl.MsgDaoImpl;
import com.smart.book.pojo.Msg;
import com.smart.book.utils.JdbcUtils;
import org.junit.Test;

import java.util.List;

public class MsgDaoTest {

    @Test
    public void TestMsg()
    {

        System.out.println("666");
        MsgDao msgDao = new MsgDaoImpl();
        Msg msg = new Msg();
        msg.setMsg("11234哈哈哈哈哈4");
        msg.setTime("2020");
        msg.setName("88888");
        msgDao.addMsg(msg);
//
//       List<Msg> msgList= msgDao.querymsgs();
//
//        for (int i = 0; i < msgList.size(); i++) {
//
//            System.out.println(msgList.get(i).getMsg());
//        }
    }
}
