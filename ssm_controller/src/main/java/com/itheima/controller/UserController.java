package com.itheima.controller;

import com.itheima.domain.ResultInfo;
import com.itheima.domain.Role;
import com.itheima.domain.UserInfo;
import com.itheima.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

@Controller
@RequestMapping(value = "/user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 查询所有的员工
     * @return
     */
    @RequestMapping("/findAllEmployee")
    public ModelAndView  findAllEmployee(){
        ModelAndView mv = new ModelAndView();
        List<UserInfo> employees = userService.findAllEmployee();
        mv.addObject("employees", employees);
        mv.setViewName("cms/employeeManage/employee");
        return  mv;
    }

    /**
     * 根据id查询员工详细信息
     * @param id
     * @return
     */
    @RequestMapping("/findById")
    public ModelAndView findById(@RequestParam(value = "id", required = true) Integer id){
        ModelAndView mv = new ModelAndView();
        UserInfo employee = userService.findById(id);
        mv.addObject("employee", employee);
        mv.setViewName("cms/employeeManage/employeeDetail");
        return mv;
    }

    /**
     * 添加员工
     */
    @RequestMapping("/saveEmployee")
    public String saveEmployee(UserInfo userInfo){
        userService.saveEmployee(userInfo);
        return "redirect:findAllEmployee";
    }

    /**
     * 添加员工角色需要跳转的页面
     */
    @RequestMapping("/findRoleByUserId")
    public ModelAndView findRoleByUserId(@RequestParam(value = "uid", required = true) Integer uid){
        ModelAndView mv = new ModelAndView();

        UserInfo employee = userService.findById(uid);
        List<Role> otherRoles = userService.findOtherRole(uid);
        mv.addObject("employee", employee);
        mv.addObject("otherRoles", otherRoles);
        mv.setViewName("cms/employeeManage/addrole2Empolyee");

        return mv;
    }

    /**
     * 给员工添加权限
     * 调用
     */
    @RequestMapping("/addrole2employee")
    public String addrole2employee(@RequestParam(value = "uid", required = true) Integer uid, @RequestParam(value = "rid", required = true) Integer rid){
        userService.addOtherRole2Employee(uid, rid);
        return "redirect:findAllEmployee";
    }
// -----------------------------------------------------------------用户访问部分
    /**
     * 登录
     * @param userInfo
     * @return
     */
    @RequestMapping("/login")
    public ModelAndView login(UserInfo userInfo,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ModelAndView mv = new ModelAndView();

        ResultInfo resultInfo = userService.findByUsernameAndPassword(userInfo);

        String fromwhere = request.getParameter("fromwhere");
        //"fromwhere=http://localhost:8080/ssm/pages/surf/masterpiece.jsp?id=5&viewNum=55";
        // 第一个等号的位置
        int pos = fromwhere.indexOf("=");
        // 切割获取fromwhere=之后的字符串url
        String url = fromwhere.substring(pos+1);//http://localhost:8080/ssm/pages/surf/masterpiece.jsp?id=5&viewNum=55
        //因为是登录之后再次访问，我不想让他的viewNum+1。
        int posView = url.indexOf("&");
        if(posView != -1){// 说明存在viewNum
            url = url.substring(0, posView+1)+"viewNum=0";
        }



        if(resultInfo.isFlag()){
            HttpSession session = request.getSession();
            session.setAttribute("userInfo", resultInfo.getUserInfo());
            session.setAttribute("isEmp", resultInfo.isEmp());
            response.sendRedirect(url);// 使得登录后直接返回，点击登录按钮的位置
            mv.setViewName("surf/main");
        }else {
            mv.addObject("resultInfo", resultInfo);
            mv.setViewName("surf/login");
        }
        return mv;
    }

    /**
     * 退出登录代码
     * 点击退出登录之后从哪里退出就退回到哪里去
     * 如果是在要登录的界面点击了退出登录，那就直接跳转到首页
     */
    @RequestMapping("/logout")
    public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fromwhere = request.getParameter("fromwhere");
        //如果是从首页
        //"http://localhost:8080/ssm/pages/surf/main.jsp?";
        //从作品也跳转
        //"http://localhost:8080/ssm/pages/surf/masterpiece2.jsp?id=5";
        //没有viewNum=55;这是因为当做了第二个参数了viewNum,但是对于退出登录不重要
        //因为是登录之后再次访问，我不想让他的viewNum+1。
        int posView = fromwhere.indexOf("&");
        if(posView != -1){// 说明存在viewNum
            fromwhere = fromwhere.substring(0, posView+1)+"viewNum=0";
        }

        //清空所有的记录requestScope
        ModelAndView mv = new ModelAndView();
        mv.clear();
        HttpSession session = request.getSession();
        session.invalidate();

        // 从个人中心退出登录的话跳转到首页，按道理来说应该在进入个人中心的所有页面设置一个参数然后按照这个参数来进行判断是否跳转首页
        int pos = fromwhere.indexOf("userCenter");
        int pos2 = fromwhere.indexOf("myFans");
        int pos3 = fromwhere.indexOf("myStars");
        if((pos != -1) || (pos2!= -1) || (pos3 !=-1) ){
            response.sendRedirect("http://localhost:8080/ssm/pages/surf/main.jsp");
            return;
        }

        // 跳转
        response.sendRedirect(fromwhere);

    }

    /**
     * 注册代码实现
     */
    @RequestMapping("/register")
    public ModelAndView register(UserInfo userInfo, HttpServletRequest request){
        ModelAndView mv = new ModelAndView();

        ResultInfo resultInfo = userService.save(userInfo);

        if(resultInfo.isFlag()){
            HttpSession session = request.getSession();
            session.setAttribute("userInfo", userInfo);
            session.setAttribute("isEmp", resultInfo.isEmp());
            mv.setViewName("surf/main");
        }else {
            mv.addObject("resultInfo", resultInfo);
            mv.setViewName("surf/register");
        }
        return mv;
    }

    /**
     * 根据作者id来查看作者粉丝  关注 以及总观看评论等
     */
    @RequestMapping("/findByUid")
    @ResponseBody
    public UserInfo findByUid(@RequestParam(value = "uid") Integer uid){

        return userService.findByUid(uid);
    }

    /**
     * 添加关注操作
     * @param id
     * @param uid
     */
    @RequestMapping("/addFans")
    @ResponseBody
    public void addFans(@RequestParam(value = "id") Integer id, @RequestParam(value = "uid") Integer uid){
        userService.addFans(id, uid);
    }
}
