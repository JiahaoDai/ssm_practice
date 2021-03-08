package com.itheima.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.text.SimpleDateFormat;
import java.util.Date;

/*
    create table comments(
		id int primary key auto_increment,
		content varchar(200),
		mid int,
		pubTime Date,
		favorNum int,
		uid int,
		constraint masterpiece_comment_fk foreign key(mid) references masterpiece(id),
		constraint user_comment_fk foreign key(uid) references user(id)
	)
 */
public class Comments {
    private Integer id;
    private String content;
    private Integer mid;

    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT")
    private Date pubTime;

    private String pubTimeStr;
    private Integer favorNum;
    private Integer uid;

    private MasterPiece masterPiece;

    private UserInfo userInfo;

    public UserInfo getUserInfo() {
        return userInfo;
    }



    public void setUserInfo(UserInfo userInfo) {
        this.userInfo = userInfo;
    }

    public MasterPiece getMasterPiece() {
        return masterPiece;
    }

    public void setMasterPiece(MasterPiece masterPiece) {
        this.masterPiece = masterPiece;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getMid() {
        return mid;
    }

    public void setMid(Integer mid) {
        this.mid = mid;
    }

    public Date getPubTime() {
        return pubTime;
    }

    public void setPubTime(Date pubTime) {
        this.pubTime = pubTime;
    }

    public Integer getFavorNum() {
        return favorNum;
    }

    public void setFavorNum(Integer favorNum) {
        this.favorNum = favorNum;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getPubTimeStr() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        this.pubTimeStr = sdf.format(this.pubTime).toString();
        return pubTimeStr;
    }

    public void setPubTimeStr(String pubTimeStr) {
        this.pubTimeStr = pubTimeStr;
    }

    @Override
    public String toString() {
        return "Comments{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", mid=" + mid +
                ", pubTime=" + pubTime +
                ", favorNum=" + favorNum +
                ", uid=" + uid +
                '}';
    }
}
