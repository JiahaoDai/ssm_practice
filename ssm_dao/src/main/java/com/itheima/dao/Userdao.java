package com.itheima.dao;


import com.itheima.domain.Role;
import com.itheima.domain.UserInfo;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface Userdao {

    @Select("select * from user")
    public List<UserInfo> findAll();


    @Select("select * from user where username = #{username}")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "username", column = "username"),
            @Result(property = "password", column = "password"),
            @Result(property = "email", column = "email"),
            @Result(property = "phoneNum", column = "phoneNum"),
            @Result(property = "status", column = "status"),
            @Result(property = "roles", column = "id", javaType = List.class, many = @Many(select = "com.itheima.dao.Roledao.findById"))
    })
    public UserInfo findByUsername(String username);


    @Insert("insert into user(username, password, email, phoneNum, status) values(#{username}, #{password}, #{email}, #{phoneNum}, #{status})")
    public void save(UserInfo userInfo);


    @Insert("insert into user_role(uid, rid) values(#{uid}, 1)")
    public void add_role2user(Integer uid);


    @Select("select * from user where username = #{username} and password = #{password}")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "username", column = "username"),
            @Result(property = "password", column = "password"),
            @Result(property = "email", column = "email"),
            @Result(property = "phoneNum", column = "phoneNum"),
            @Result(property = "status", column = "status"),
            @Result(property = "roles", column = "id", javaType = List.class, many = @Many(select = "com.itheima.dao.Roledao.findById")),
            @Result(property = "masterPieces", column = "id", javaType = List.class, many = @Many(select = "com.itheima.dao.MasterPiecedao.findByUid")),
    })
    public UserInfo findByUsernameAndPassword(UserInfo userInfo);

    /**
     * 直接这样写sql语句可以将角色是员工的用户查询出来，但是并没有封装到UserInfo里面的roles里面
     * @return
     */
    @Select("select distinct user.id, user.username, user.password, user.email from  user left join user_role on user.id = user_role.uid left join role on  user_role.rid = role.id where role.roleName != \"ROLE_USER\";")
    public List<UserInfo> findAllEmployee();


    @Select("select * from user where id = #{id}")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "username", column = "username"),
            @Result(property = "password", column = "password"),
            @Result(property = "email", column = "email"),
            @Result(property = "phoneNum", column = "phoneNum"),
            @Result(property = "status", column = "status"),
            @Result(property = "roles", column = "id", javaType = List.class, many = @Many(select = "com.itheima.dao.Roledao.findById"))
    })
    public UserInfo findById(Integer id);


    @Insert("insert into user_role values(#{uid}, 4)")
    public void add_role2employee(Integer uid);

    @Insert("insert into user_role values(#{uid}, #{rid})")
    public void addOtherRole2Employee(@Param(value = "uid") Integer uid, @Param(value = "rid") Integer rid);


    @Select("select * from user where id in (select uid from usertouser where conuid = #{uid})")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "username", column = "username"),
    })
    public List<UserInfo> findFansByUid(Integer uid);

    @Select("select * from user where id in (select conuid from usertouser where uid = #{uid})")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "username", column = "username"),
    })
    public List<UserInfo> findStarsByUid(Integer uid);


    @Select("select *  from user where id = #{uid}")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "username", column = "username"),
            @Result(property = "fans", column = "id", javaType = List.class, many = @Many(select = "com.itheima.dao.Userdao.findFansByUid")),
            @Result(property = "stars", column = "id", javaType = List.class, many = @Many(select = "com.itheima.dao.Userdao.findStarsByUid")),
            @Result(property = "masterPieces", column = "id", javaType = List.class, many = @Many(select = "com.itheima.dao.MasterPiecedao.findByUid"))
    })
    public UserInfo findByUid(Integer uid);


    @Insert("insert into usertouser values(#{uid}, #{id})")
    public void addFans(@Param(value = "id") Integer id, @Param(value = "uid") Integer uid);
}
