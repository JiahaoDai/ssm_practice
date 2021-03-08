package com.itheima.controller;


import com.itheima.domain.Role;
import com.itheima.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    /**
     * 查询所有角色
     * @return
     */
    @RequestMapping("/findAll")
    public ModelAndView findAll(){
        ModelAndView mv = new ModelAndView();
        List<Role> roles = roleService.findAll();
        mv.addObject("roles", roles);
        mv.setViewName("cms/roleManage/rolelist");
        return mv;
    }

    /**
     * 新建角色
     */
    @RequestMapping("/save")
    public String save(Role role){
        roleService.save(role);
        return "redirect:findAll";//重定向到所有角色
    }

    /**
     * 删除角色
     */
    @RequestMapping("/deleteRoleById")
    public String deleteRoleById(@RequestParam(value = "id", required = true) Integer id){
        roleService.deleteRoleById(id);
        return "redirect:findAll";
    }
}
