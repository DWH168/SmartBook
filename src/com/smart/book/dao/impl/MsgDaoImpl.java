package com.smart.book.dao.impl;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.smart.book.dao.MsgDao;
import com.smart.book.pojo.Msg;


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

    @Override
    public int replay(Msg msg) {
        String sql = "update bk_msg set `reply`=? where id = ?";

        String st = updateReply(msg);
        return update(sql,st,msg.getId());
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
        String sql = "select `id`,`name`,`msg`,`reply`,`time` from bk_msg order by `id` desc";
        return queryForList(Msg.class, sql);
    }

    /**
     * 根据id查询留言
     * @param id
     * @return
     */
    @Override
    public Msg queryMsgById(Integer id) {

        String sql = "select * from bk_msg where id = ?";

        return queryForOne(Msg.class, sql,id);
    }

    private String updateReply(Msg msg)
    {
        Integer id=msg.getId();
        Msg newmsg=queryMsgById(id);
        JsonArray jsonElements;
//        System.out.println(newmsg.getReply());
        String json=newmsg.getReply()+"";
        if("null".equals(json))
        {
            jsonElements = new JsonArray();
        }
        else {
            JsonParser jsonParser = new JsonParser();
            jsonElements = jsonParser.parse(newmsg.getReply()).getAsJsonArray();
        }
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("name",msg.getName());
        jsonObject.addProperty("time",msg.getTime());
        jsonObject.addProperty("msg",msg.getMsg());

        jsonElements.add(jsonObject);
        return jsonElements.toString();
    }


}
