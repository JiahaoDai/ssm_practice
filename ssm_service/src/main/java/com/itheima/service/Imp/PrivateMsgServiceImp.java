package com.itheima.service.Imp;

import com.itheima.dao.PrivateMsgdao;
import com.itheima.domain.PrivateMsg;
import com.itheima.domain.UserInfo;
import com.itheima.service.PrivateMsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class PrivateMsgServiceImp implements PrivateMsgService {

    @Autowired
    private PrivateMsgdao privateMsgdao;
    @Override
    public void sendMsg(PrivateMsg privateMsg) {
        privateMsgdao.sendMsg(privateMsg);
    }

    @Override
    public List<UserInfo> findRelateUser(Integer uid) {
        return privateMsgdao.findRelateUser(uid);
    }

    @Override
    public List<PrivateMsg> findAllRelateMsg(PrivateMsg privateMsg) {
        return privateMsgdao.findAllRelateMsg(privateMsg);
    }
}
