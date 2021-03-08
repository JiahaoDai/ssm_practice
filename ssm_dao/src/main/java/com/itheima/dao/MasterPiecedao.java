package com.itheima.dao;


import com.itheima.domain.*;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MasterPiecedao {

    @Select("select * from masterpiece")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "commentNum", column = "commentNum"),
            @Result(property = "viewNum", column = "viewNum"),
            @Result(property = "favorNum", column = "favorNum"),
            @Result(property = "pubTime", column = "pubTime"),
            @Result(property = "masterpieceDesc", column = "masterpieceDesc"),
            @Result(property = "masterpieceContent", column = "masterpieceContent"),
            @Result(property = "userInfo", column = "uid", javaType = UserInfo.class,one = @One(select = "com.itheima.dao.Userdao.findById")),
            @Result(property = "category", column = "cid", javaType = Category.class,one = @One(select = "com.itheima.dao.Categorydao.findById")),
            @Result(property = "comments", column = "id", javaType = List.class, many = @Many(select = "com.itheima.dao.Commentsdao.findByMid"))
    })
    public List<MasterPiece> findAll();


    @Select("select * from masterpiece where id = #{id}")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "commentNum", column = "commentNum"),
            @Result(property = "viewNum", column = "viewNum"),
            @Result(property = "favorNum", column = "favorNum"),
            @Result(property = "pubTime", column = "pubTime"),
            @Result(property = "masterpieceDesc", column = "masterpieceDesc"),
            @Result(property = "masterpieceContent", column = "masterpieceContent"),
            @Result(property = "userInfo", column = "uid", javaType = UserInfo.class,one = @One(select = "com.itheima.dao.Userdao.findByUid")),
            @Result(property = "category", column = "cid", javaType = Category.class,one = @One(select = "com.itheima.dao.Categorydao.findById")),
            @Result(property = "pictures", column = "id", javaType = List.class, many = @Many(select = "com.itheima.dao.Picturedao.findByMid")),
            @Result(property = "comments", column = "id", javaType = List.class, many = @Many(select = "com.itheima.dao.Commentsdao.findByMid"))
    })
    public MasterPiece findById(Integer id);


    @Update("update masterpiece set viewNum = #{i} where id = #{id}")
    public void updateViewNum(@Param(value = "i") Integer i, @Param(value = "id") Integer id);


    @Update("update masterpiece set favorNum = #{favorNum} where id = #{id}")
    public void updateFavorNum(MasterPiece masterPiece);

    /**
     * 根据用户id来查找
     * @param uid
     * @return
     */
    @Select("select * from masterpiece where uid = #{uid}")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "commentNum", column = "commentNum"),
            @Result(property = "viewNum", column = "viewNum"),
            @Result(property = "favorNum", column = "favorNum"),
            @Result(property = "pubTime", column = "pubTime"),
            @Result(property = "masterpieceDesc", column = "masterpieceDesc"),
            @Result(property = "category", column = "cid", javaType = Category.class,one = @One(select = "com.itheima.dao.Categorydao.findById")),
            @Result(property = "comments", column = "id", javaType = List.class, many = @Many(select = "com.itheima.dao.Commentsdao.findByMid")),

    })
    public List<MasterPiece> findByUid(Integer uid);

    @Delete("delete from masterpiece where id = #{mid}")
    public void deleteById(Integer mid);
}
