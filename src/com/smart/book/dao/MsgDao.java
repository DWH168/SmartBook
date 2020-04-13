package com.smart.book.dao;

import com.smart.book.pojo.Msg;

import java.util.List;

public interface MsgDao {


    public int addMsg(Msg msg);

    public int replay(Msg msg);

    public int deleteMsg(Integer id);

    public List<Msg> querymsgs();

    public Msg queryMsgById(Integer id);

}
