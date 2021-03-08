package com.itheima.service.Imp;


import com.itheima.dao.Roledao;
import com.itheima.domain.Role;
import com.itheima.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImp implements RoleService {

    @Autowired
    private Roledao roledao;

    @Override
    public List<Role> findAll() {
        return roledao.findAll();
    }

    @Override
    public void save(Role role) {
        roledao.save(role);
    }

    @Override
    public void deleteRoleById(Integer id) {
        roledao.deleteRoleById(id);
    }
}
