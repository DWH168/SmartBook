package com.smart.book.service;

import com.smart.book.pojo.Msg;

import java.util.List;

public interface MsgService {
    public int addMsg(Msg msg);
    public List<Msg> queryMsgs();
}
