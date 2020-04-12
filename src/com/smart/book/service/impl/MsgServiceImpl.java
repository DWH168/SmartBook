package com.smart.book.service.impl;

import com.smart.book.dao.MsgDao;
import com.smart.book.dao.impl.MsgDaoImpl;
import com.smart.book.pojo.Msg;
import com.smart.book.service.MsgService;

import java.util.List;

public class MsgServiceImpl implements MsgService {

    MsgDao msgDao =new MsgDaoImpl();
    @Override
    public int addMsg(Msg msg) {
        return msgDao.addMsg(msg);
    }

    @Override
    public List<Msg> queryMsgs() {
        List<Msg> msgList= msgDao.querymsgs();
        return msgList;
    }
}
