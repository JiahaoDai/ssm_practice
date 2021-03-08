package com.itheima.domain;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class MasterPiece {

    private Integer id;
    private Integer uid;// 作者id
    private Integer cid;// 分类id
    private Integer commentNum;
    private Integer viewNum;
    private Integer favorNum;
    private Date pubTime;
    private String pubTimeStr;//将Date类型的数据转换为字符串
    private String masterpieceDesc;
    private String masterpieceContent;

    //封面图
    private String coverUrl;

    // 对于作品的评论
    private List<Comments> comments;

    // 一对多的关系  作品-------------图片
    private List<Picture> pictures;

    private UserInfo userInfo;

    private Category category;

    // 为了在作品详情页判断是否能够关注作品的作者 我需要判断是否登录过
    private UserInfo userLogin;// 正在浏览的人

    public UserInfo getUserLogin() {
        return userLogin;
    }

    public void setUserLogin(UserInfo userLogin) {
        this.userLogin = userLogin;
    }

    public void setPubTimeStr(String pubTimeStr) {
        this.pubTimeStr = pubTimeStr;
    }

    public List<Comments> getComments() {
        return comments;
    }


    public String getCoverUrl() {
        return coverUrl;
    }

    public void setCoverUrl(String coverUrl) {
        this.coverUrl = coverUrl;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public UserInfo getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(UserInfo userInfo) {
        this.userInfo = userInfo;
    }

    public void setComments(List<Comments> comments) {
        this.comments = comments;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Integer getCommentNum() {
        return commentNum;
    }

    public void setCommentNum(Integer commentNum) {
        this.commentNum = commentNum;
    }

    public Integer getViewNum() {
        return viewNum;
    }

    public void setViewNum(Integer viewNum) {
        this.viewNum = viewNum;
    }

    public Integer getFavorNum() {
        return favorNum;
    }

    public void setFavorNum(Integer favorNum) {
        this.favorNum = favorNum;
    }

    public Date getPubTime() {
        return pubTime;
    }

    public void setPubTime(Date pubTime) {
        this.pubTime = pubTime;
    }

    public String getMasterpieceDesc() {
        return masterpieceDesc;
    }

    public void setMasterpieceDesc(String masterpieceDesc) {
        this.masterpieceDesc = masterpieceDesc;
    }

    public String getMasterpieceContent() {
        return masterpieceContent;
    }

    public void setMasterpieceContent(String masterpieceContent) {
        this.masterpieceContent = masterpieceContent;
    }

    public List<Picture> getPictures() {
        return pictures;
    }

    public void setPictures(List<Picture> pictures) {
        this.pictures = pictures;
    }

    public String getPubTimeStr() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        this.pubTimeStr = sdf.format(this.pubTime).toString();
        return pubTimeStr;
    }

}
