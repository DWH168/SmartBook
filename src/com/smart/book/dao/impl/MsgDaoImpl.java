package com.smart.book.dao.impl;

import com.smart.book.dao.MsgDao;
import com.smart.book.pojo.Msg;
import netscape.javascript.JSObject;

import java.util.List;

public class MsgDaoImpl extends BaseDao implements MsgDao {

    /**
     * 添加留言
     * @param msg
     * @return  添加成功后返回影响行数
     * */
    @Override
    public int addMsg(Msg msg) {
        String sql="insert into bk_msg(`msg`,`name`,`time`) values(?,?,?)";
        return update(sql,msg.getMsg(),msg.getName(),msg.getTime());
    }

    /**
     * 删除留言
     * @param id
     * @return
     */
    @Override
    public int deleteMsg(Integer id) {
        String sql="delete from bk_msg where id = ?";

        return update(sql,id);
    }

    /**
     * 查询留言
     * @return
     */
    @Override
    public List<Msg> querymsgs() {
        String sql = "select `id`,`name`,`msg`,`time` from bk_msg order by `id` desc";
        return queryForList(Msg.class, sql);
    }
}
