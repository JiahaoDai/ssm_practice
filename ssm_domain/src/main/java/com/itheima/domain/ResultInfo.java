package com.itheima.domain;

public class ResultInfo {
    private boolean flag;//是否成功
    private String msg;//传回去的信息
    private boolean isEmp;//是否是员工
    private UserInfo userInfo;//返回查询到的userInfo对象

    public UserInfo getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(UserInfo userInfo) {
        this.userInfo = userInfo;
    }

    public boolean isEmp() {
        return isEmp;
    }

    public void setEmp(boolean emp) {
        isEmp = emp;
    }

    public boolean isFlag() {
        return flag;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    @Override
    public String toString() {
        return "ResultInfo{" +
                "flag=" + flag +
                ", msg='" + msg + '\'' +
                '}';
    }
}
