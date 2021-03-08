package com.itheima.dao;


import com.itheima.domain.Picture;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface Picturedao {

    @Select("select * from picture where mid = #{mid}")
    public List<Picture> findByMid(Integer mid);


    @Delete("delete from picture where mid = #{mid}")
    public void deleteByMid(Integer mid);
}
