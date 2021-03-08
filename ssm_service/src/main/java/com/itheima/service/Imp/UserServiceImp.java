package com.itheima.service.Imp;


import com.itheima.dao.Roledao;
import com.itheima.dao.Userdao;
import com.itheima.domain.ResultInfo;
import com.itheima.domain.Role;
import com.itheima.domain.UserInfo;
import com.itheima.service.UserService;
import com.itheima.utils.PasswordEncoderUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service(value = "userService")
public class UserServiceImp implements UserService {

    @Autowired
    private Roledao roledao;

    @Autowired
    private Userdao userdao;

    @Override
    public List<UserInfo> findAll() {
        return userdao.findAll();
    }

    @Override
    public UserInfo findByUsername(String username) {
        return userdao.findByUsername(username);
    }

    /**
     * 用户访问界面的注册，直接将角色设置为了ROLE_USER
     * @param userInfo
     * @return
     */
    @Override
    public ResultInfo save(UserInfo userInfo) {
        userInfo.setStatus(0);//表示用户未激活，之后可能使用邮箱激活的方式
        ResultInfo resultInfo = new ResultInfo();
        resultInfo.setFlag(true);
        resultInfo.setEmp(false);//普通用户,因为我设置的用户访问页面的注册就只是普通用户
        //判断用户名是否有重复，如果不重复就可以申请
        List<UserInfo> users = userdao.findAll();
        for (UserInfo user : users) {
            if(user.getUsername().equals(userInfo.getUsername())){
                resultInfo.setFlag(false);
                resultInfo.setMsg("用户名已存在，请换一个");
                return resultInfo;
            }
        }
        userInfo.setPassword(PasswordEncoderUtils.encoding(userInfo.getPassword()));
        userdao.save(userInfo);
        // 为了获取id不得不在查询一次
        UserInfo user = userdao.findByUsernameAndPassword(userInfo);
        add_role2user(user.getId());// 普通用户直接添加角色就是普通角色
        return resultInfo;
    }

    /**
     * 给用户添加角色都是ROLE_USER
     * @param id
     */
    @Override
    public void add_role2user(Integer id) {
        userdao.add_role2user(id);
    }

    /**
     * 登录
     * @param userInfo
     * @return
     */
    @Override
    public ResultInfo findByUsernameAndPassword(UserInfo userInfo) {
        // 将密码加密然后和数据库的对比
//        userInfo.setPassword(PasswordEncoderUtils.encoding(userInfo.getPassword()));
        ResultInfo resultInfo = new ResultInfo();
        resultInfo.setFlag(true);
        resultInfo.setEmp(false);
        UserInfo user = userdao.findByUsernameAndPassword(userInfo);
        if(user == null){
            resultInfo.setFlag(false);
            resultInfo.setMsg("用户或密码错误");
        }else {
            resultInfo.setUserInfo(user);
            List<Role>roles = user.getRoles();
            for (Role role : roles) {
                if(!("ROLE_USER".equals(role.getRoleName()))){
                    resultInfo.setEmp(true);
                    break;
                }
            }
        }
        return resultInfo;
    }

    @Override
    public List<UserInfo> findAllEmployee() {
        return userdao.findAllEmployee();
    }

    @Override
    public UserInfo findById(Integer id) {
        return userdao.findById(id);
    }

    /**
     * 添加员工
     * @param userInfo
     */
    @Override
    public void saveEmployee(UserInfo userInfo) {
        userInfo.setStatus(1);
        userInfo.setPassword(PasswordEncoderUtils.encoding(userInfo.getPassword()));// 密码的加密
        userdao.save(userInfo);
        UserInfo user = userdao.findByUsernameAndPassword(userInfo);
        userdao.add_role2employee(user.getId());
    }

    @Override
    public void add_role2employee(Integer id) {
        userdao.add_role2employee(id);
    }

    @Override
    public void addOtherRole2Employee(Integer uid, Integer rid) {
        userdao.addOtherRole2Employee(uid, rid);
    }

    @Override
    public List<Role> findOtherRole(Integer uid) {
        return roledao.findOtherRole(uid);
    }

    @Override
    public UserInfo findByUid(Integer uid) {
        return userdao.findByUid(uid);
    }

    @Override
    public void addFans(Integer id, Integer uid) {
        userdao.addFans(id, uid);
    }


// ------------------------------------------------------------------------------------------------
    /**
     * 实现spring-security登录的方法
     * @param username
     * @return
     * @throws UsernameNotFoundException
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserInfo userInfo = userdao.findByUsername(username);
        return new User(userInfo.getUsername(), "{noop}"+userInfo.getPassword(), true, true,true,true, getAuthority(userInfo.getRoles()));
    }

    private List<SimpleGrantedAuthority> getAuthority(List<Role> roles){

        List<SimpleGrantedAuthority> roleList = new ArrayList<SimpleGrantedAuthority>();
        for (Role role : roles) {
            roleList.add(new SimpleGrantedAuthority(role.getRoleName()));

        }
        return roleList;
    }
}
