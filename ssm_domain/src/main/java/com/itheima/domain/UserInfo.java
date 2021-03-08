package com.itheima.domain;

import org.springframework.security.core.userdetails.User;

import java.util.List;

/**
 * 用户domain
 */
public class UserInfo {
    private Integer id;
    private String username;
    private String password;
    private String email;
    private String phoneNum;
    private Integer status;//激活状态
    private String statusStr;

    //    粉丝数
    private List<UserInfo> fans;//粉丝用户

    //   自己关注的人
    private List<UserInfo> stars;


    private List<Role> roles;

    private List<MasterPiece> masterPieces;

    private List<Comments> comments;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getStatusStr() {
        if(status != null){
            statusStr = "已激活";
        }else {
            statusStr = "未激活";
        }
        return statusStr;
    }

    public void setStatusStr(String statusStr) {
        this.statusStr = statusStr;
    }

    public List<UserInfo> getFans() {
        return fans;
    }

    public void setFans(List<UserInfo> fans) {
        this.fans = fans;
    }

    public List<UserInfo> getStars() {
        return stars;
    }

    public void setStars(List<UserInfo> stars) {
        this.stars = stars;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    public List<MasterPiece> getMasterPieces() {
        return masterPieces;
    }

    public void setMasterPieces(List<MasterPiece> masterPieces) {
        this.masterPieces = masterPieces;
    }

    public List<Comments> getComments() {
        return comments;
    }

    public void setComments(List<Comments> comments) {
        this.comments = comments;
    }
}
