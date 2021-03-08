package com.itheima.service;

import com.itheima.domain.ResultInfo;
import com.itheima.domain.Role;
import com.itheima.domain.UserInfo;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface UserService extends UserDetailsService {

    public List<UserInfo> findAll();

    public UserInfo findByUsername(String username);

    public ResultInfo save(UserInfo userInfo);

    public void add_role2user(Integer id);

    public ResultInfo findByUsernameAndPassword(UserInfo userInfo);

    public List<UserInfo> findAllEmployee();

    public UserInfo findById(Integer id);

    public void saveEmployee(UserInfo userInfo);

    public void add_role2employee(Integer id);

    public void addOtherRole2Employee(Integer uid, Integer rid);

    public List<Role> findOtherRole(Integer uid);

    public UserInfo findByUid(Integer uid);

    public void addFans(Integer id, Integer uid);
}
