package com.itheima.service;


import com.itheima.domain.Role;

import java.util.List;

public interface RoleService {

    public List<Role> findAll();

    public void save(Role role);

    public void deleteRoleById(Integer id);
}
