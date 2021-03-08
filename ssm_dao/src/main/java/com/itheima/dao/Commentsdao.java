package com.itheima.dao;


import com.itheima.domain.Comments;
import com.itheima.domain.UserInfo;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface Commentsdao {
    /*

    private Integer id;
    private String content;
    private Integer mid;
    private Date pubTime;
    private Integer favorNum;
    private Integer uid;

    private MasterPiece masterPiece;

    private UserInfo userInfo;
     */


    @Select("select * from comments where mid = #{mid}")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "content", column = "content"),
            @Result(property = "pubTime", column = "pubTime"),
            @Result(property = "favorNum", column = "favorNum"),
            @Result(property = "userInfo", column = "uid", javaType = UserInfo.class, one = @One(select = "com.itheima.dao.Userdao.findById"))
    })
    public List<Comments> findByMid(Integer mid);

    @Insert("insert into comments(content, pubTime, favorNum, mid, uid) values(#{content},#{pubTime},#{favorNum},#{mid},#{uid})")
    public void save(Comments comments);

    @Delete("delete from comments where mid = #{mid}")
    public void deleteByMid(Integer mid);
}
