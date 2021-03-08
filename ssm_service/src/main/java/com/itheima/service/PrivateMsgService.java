package com.itheima.service;

import com.itheima.domain.PrivateMsg;
import com.itheima.domain.UserInfo;

import java.util.List;

public interface PrivateMsgService {

    public void sendMsg(PrivateMsg privateMsg);

    public List<UserInfo> findRelateUser(Integer uid);

    public List<PrivateMsg> findAllRelateMsg(PrivateMsg privateMsg);
}
