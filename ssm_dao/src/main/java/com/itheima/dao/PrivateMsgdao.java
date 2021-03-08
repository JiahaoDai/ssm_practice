package com.itheima.dao;


import com.itheima.domain.PrivateMsg;
import com.itheima.domain.UserInfo;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PrivateMsgdao {


    @Insert("insert into privateMsg values(#{uid}, #{masterpieceUid}, #{content}, #{sendTime})")
    public void sendMsg(PrivateMsg privateMsg);


    @Select("select id,username from user where id in (select uid from privatemsg where masterpieceUid = #{uid}) or id in (select masterpieceUid from privatemsg where uid = #{uid})")
    public List<UserInfo> findRelateUser(Integer uid);

    @Select("select * from privatemsg where (uid = #{uid} and  masterpieceUid = #{masterpieceUid}) or (uid = #{masterpieceUid} and  masterpieceUid = #{uid}) order by sendTime")
    public List<PrivateMsg> findAllRelateMsg(PrivateMsg privateMsg);
}
