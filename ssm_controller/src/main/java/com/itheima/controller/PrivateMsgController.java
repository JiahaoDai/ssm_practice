package com.itheima.controller;


import com.itheima.domain.PrivateMsg;
import com.itheima.domain.UserInfo;
import com.itheima.service.PrivateMsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/privateMsg")
public class PrivateMsgController {

    @Autowired
    private PrivateMsgService privateMsgService;

    @RequestMapping("/findAllRelateMsg")
    @ResponseBody
    public List<PrivateMsg> findAll(@RequestBody PrivateMsg privateMsg){
        return privateMsgService.findAllRelateMsg(privateMsg);
    }

    /**
     * 发送私信
     */
    @RequestMapping("/sendMsg")
    @ResponseBody
    public void sendMsg(@RequestBody PrivateMsg privateMsg){
        privateMsgService.sendMsg(privateMsg);
    }

    @RequestMapping("/findRelateUser")
    @ResponseBody
    public List<UserInfo> findAllMsg(@RequestParam(value = "uid") Integer uid){
        List<UserInfo>userInfos = privateMsgService.findRelateUser(uid);
        System.out.println(userInfos);
        return userInfos;
    }
}
