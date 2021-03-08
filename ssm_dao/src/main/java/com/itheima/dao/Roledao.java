package com.itheima.dao;


import com.itheima.domain.Role;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface Roledao {


    @Select("select * from role")
    public List<Role> findAll();

    @Select("select * from role where id in (select rid from user_role where uid = #{id})")
    public List<Role> findById(Integer id);


    @Insert("insert into role(roleName, roleDesc) values(#{roleName}, #{roleDesc})")
    public void save(Role role);


    @Delete("delete from role where id = #{id}")
    public void deleteRoleById(Integer id);


    @Select("select * from role where id not in (select rid from user_role where uid = #{uid})")
    public List<Role> findOtherRole(Integer uid);
}
