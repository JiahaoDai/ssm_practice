package com.itheima.dao;

import com.itheima.domain.Category;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface Categorydao {

    @Select("select * from category")
    public List<Category> findAll();

    @Select("select * from category where id = #{id}")
    public Category findById(Integer id);
}
